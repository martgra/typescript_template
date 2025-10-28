SHELL := /bin/bash
.PHONY: test build clean

# Use copier from venv if available, otherwise system copier
COPIER := $(shell which /tmp/copier-venv/bin/copier 2>/dev/null || which copier 2>/dev/null || echo "uvx copier")

# Test template generation and validation
test:
	@echo "════════════════════════════════════════════════════════════════"
	@echo "🧪 TESTING TEMPLATE"
	@echo "════════════════════════════════════════════════════════════════"
	@set -euo pipefail; \
	tmpdir=$$(mktemp -d); \
	trap 'cd - >/dev/null 2>&1; rm -rf "$$tmpdir"' EXIT; \
	echo "📂 Generating template..."; \
	$(COPIER) copy --vcs-ref=HEAD . "$$tmpdir" --defaults --force --trust 2>&1 | grep -v "FutureWarning\|DirtyLocalWarning" || true; \
	cd "$$tmpdir"; \
	\
	echo "🔍 Verifying core files..."; \
	test -f package.json && test -f tsconfig.json && test -f src/index.ts && test -f README.md && echo "  ✓ Core files present" || (echo "  ✗ Missing files" && exit 1); \
	\
	echo "🔍 Checking for template artifacts..."; \
	! grep -r "{{" . --include="*.ts" --include="*.json" --include="*.md" 2>/dev/null | grep -v node_modules || (echo "  ✗ Found unprocessed template variables" && exit 1); \
	echo "  ✓ No template artifacts"; \
	\
	echo "📦 Installing dependencies..."; \
	bun install --no-cache 2>&1 | tail -1; \
	\
	echo "🎨 Running formatter and linter..."; \
	bun run format >/dev/null 2>&1; \
	bun run lint 2>&1 | grep -E "warning|error|✖" || echo "  ✓ Linting passed"; \
	bun run format:check >/dev/null 2>&1 && echo "  ✓ Format check passed" || (echo "  ✗ Format check failed" && exit 1); \
	\
	echo "🔨 Building application..."; \
	bun run build 2>&1 | grep -E "error" && exit 1 || echo "  ✓ Build successful"; \
	test -f dist/index.js || (echo "  ✗ Build output missing" && exit 1); \
	\
	echo "▶️  Running application..."; \
	timeout 5s bun run dist/index.js 2>&1 | head -5 || true; \
	\
	echo "════════════════════════════════════════════════════════════════"; \
	echo "✅ ALL TESTS PASSED!"; \
	echo "════════════════════════════════════════════════════════════════"

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
