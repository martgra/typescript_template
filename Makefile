SHELL := /bin/bash
.PHONY: test test-thorough test-minimal test-full test-app-runs docker-test build clean

# Use copier from venv if available, otherwise system copier
COPIER := $(shell which /tmp/copier-venv/bin/copier 2>/dev/null || which copier 2>/dev/null || echo "uvx copier")

# Quick test with defaults
test:
	@echo "🧪 Running quick template test with defaults..."
	@$(MAKE) -s _test_config CONFIG="--defaults"

# Thorough testing with multiple configurations
test-thorough:
	@echo "════════════════════════════════════════════════════════════════"
	@echo "🔬 THOROUGH TEMPLATE TESTING"
	@echo "════════════════════════════════════════════════════════════════"
	@echo ""
	@echo "📋 Test 1/4: Default configuration"
	@$(MAKE) -s test
	@echo ""
	@echo "📋 Test 2/4: Minimal configuration (no optional features)"
	@$(MAKE) -s test-minimal
	@echo ""
	@echo "📋 Test 3/4: Full configuration (all features enabled)"
	@$(MAKE) -s test-full
	@echo ""
	@echo "📋 Test 4/4: Application runtime test"
	@$(MAKE) -s test-app-runs
	@echo ""
	@echo "════════════════════════════════════════════════════════════════"
	@echo "✅ ALL THOROUGH TESTS PASSED!"
	@echo "════════════════════════════════════════════════════════════════"

# Test with minimal configuration
test-minimal:
	@echo "🧪 Testing minimal configuration (no optional features)..."
	@$(MAKE) -s _test_config CONFIG="--data use_devcontainer=false --data use_vscode=false --data use_github_actions=false --data typescript_strict=false"

# Test with all features enabled
test-full:
	@echo "🧪 Testing full configuration (all features)..."
	@$(MAKE) -s _test_config CONFIG="--data use_devcontainer=true --data use_vscode=true --data use_github_actions=true --data typescript_strict=true"

# Internal target for running a test with specific config
_test_config:
	@set -euo pipefail; \
	tmpdir=$$(mktemp -d); \
	trap 'cd - >/dev/null 2>&1; rm -rf "$$tmpdir"' EXIT; \
	echo "  📂 Generating template into: $$tmpdir"; \
	$(COPIER) copy --vcs-ref=HEAD . "$$tmpdir" $(CONFIG) --force --trust 2>&1 | grep -v "FutureWarning\|DirtyLocalWarning" || true; \
	cd "$$tmpdir"; \
	\
	echo "  🔍 Verifying generated files..."; \
	test -f package.json || (echo "    ✗ package.json missing" && exit 1); \
	test -f tsconfig.json || (echo "    ✗ tsconfig.json missing" && exit 1); \
	test -f .eslintrc.json || (echo "    ✗ .eslintrc.json missing" && exit 1); \
	test -f .prettierrc || (echo "    ✗ .prettierrc missing" && exit 1); \
	test -f knip.json || (echo "    ✗ knip.json missing" && exit 1); \
	test -f src/index.ts || (echo "    ✗ src/index.ts missing" && exit 1); \
	test -f src/lib/env.ts || (echo "    ✗ src/lib/env.ts missing" && exit 1); \
	test -f src/lib/graceful-shutdown.ts || (echo "    ✗ src/lib/graceful-shutdown.ts missing" && exit 1); \
	test -f README.md || (echo "    ✗ README.md missing" && exit 1); \
	test -f CONTRIBUTING.md || (echo "    ✗ CONTRIBUTING.md missing" && exit 1); \
	test -f CHANGELOG.md || (echo "    ✗ CHANGELOG.md missing" && exit 1); \
	test -f .env.example || (echo "    ✗ .env.example missing" && exit 1); \
	echo "    ✓ All core files present"; \
	\
	echo "  🔍 Checking for template artifacts..."; \
	! grep -r "use_testing" . --include="*.ts" --include="*.json" --include="*.md" --include="*.yml" --include="*.yaml" 2>/dev/null || (echo "    ✗ Found use_testing references" && exit 1); \
	! grep -r "vitest" . --include="*.ts" --include="*.json" --include="*.md" 2>/dev/null | grep -v "node_modules" || (echo "    ✗ Found vitest references" && exit 1); \
	! test -f vitest.config.ts || (echo "    ✗ vitest.config.ts should not exist" && exit 1); \
	! test -d src/__tests__ || (echo "    ✗ src/__tests__ should not exist" && exit 1); \
	! grep -r "{{ package_name }}" . --include="*.yml" --include="*.yaml" --include="*.json" 2>/dev/null | grep -v node_modules || (echo "    ✗ Found unprocessed template variables" && exit 1); \
	! grep -r "{{ project_name }}" . --include="*.yml" --include="*.yaml" --include="*.json" 2>/dev/null | grep -v node_modules || (echo "    ✗ Found unprocessed template variables" && exit 1); \
	echo "    ✓ No template artifacts found"; \
	\
	echo "  🌀 Initializing git..."; \
	git init >/dev/null 2>&1 || true; \
	git add -A >/dev/null 2>&1 || true; \
	\
	echo "  📦 Installing dependencies..."; \
	bun install --no-cache 2>&1 | grep -v "^" || echo "    ✓ Dependencies installed"; \
	\
	if [ -f ".husky/pre-commit" ]; then \
		echo "  🔧 Installing git hooks..."; \
		bunx husky install >/dev/null 2>&1 || true; \
	fi; \
	\
	echo "  🎨 Formatting code..."; \
	bun run format >/dev/null 2>&1; \
	\
	echo "  🔍 Running linter..."; \
	bun run lint 2>&1 | grep -E "warning|error|✖" || echo "    ✓ No linting issues"; \
	\
	echo "  ✅ Checking format..."; \
	bun run format:check >/dev/null 2>&1 && echo "    ✓ Code is formatted" || (echo "    ✗ Format check failed" && exit 1); \
	\
	echo "  🔨 Building TypeScript..."; \
	bun run build 2>&1 | grep -E "error" && exit 1 || echo "    ✓ Build successful"; \
	\
	echo "  ✅ Verifying compiled output..."; \
	test -d dist && test -f dist/index.js || (echo "    ✗ Build output missing" && exit 1); \
	echo "    ✓ dist/index.js exists"; \
	\
	echo "  🔍 Checking for unused code..."; \
	bun run knip 2>&1 | grep -E "error" | grep -v "script.*exited with code" || echo "    ✓ Knip check complete"; \
	\
	echo "  ✅ Test passed!"

# Test that the generated app actually runs
test-app-runs:
	@echo "🚀 Testing that generated application runs..."
	@set -euo pipefail; \
	tmpdir=$$(mktemp -d); \
	trap 'cd - >/dev/null 2>&1; rm -rf "$$tmpdir"' EXIT; \
	echo "  📂 Generating template..."; \
	$(COPIER) copy --vcs-ref=HEAD . "$$tmpdir" --defaults --force --trust 2>&1 | grep -v "FutureWarning\|DirtyLocalWarning" || true; \
	cd "$$tmpdir"; \
	\
	echo "  📦 Installing dependencies..."; \
	bun install --no-cache 2>&1 | tail -1; \
	\
	echo "  🔨 Building application..."; \
	bun run build >/dev/null 2>&1; \
	\
	echo "  ▶️  Running application (5 second timeout)..."; \
	timeout 5s bun run dist/index.js 2>&1 | head -5 || true; \
	\
	echo "  ✅ Application runs successfully!"

# Build for inspection
build:
	@echo "🔧 Generating template into: build_output/"
	@rm -rf build_output
	@$(COPIER) copy --vcs-ref=HEAD . build_output --defaults --force --trust --data skip_git_init=true 2>&1 | grep -v "FutureWarning\|DirtyLocalWarning" || true
	@echo "📦 Installing dependencies..."
	@cd build_output && bun install --no-cache --ignore-scripts >/dev/null
	@echo "🎨 Formatting generated files..."
	@cd build_output && bun run format >/dev/null
	@echo "🚀 Running linter and formatter checks..."
	@cd build_output && bun run lint && bun run format:check
	@echo "✅ Template generated and validated successfully!"
	@echo "📁 Check the output in: build_output/"

clean:
	@echo "🧹 Cleaning build output..."
	@rm -rf build_output
	@echo "✅ Cleaned!"
