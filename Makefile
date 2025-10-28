SHELL := /bin/bash
.PHONY: test build clean

# Use uvx copier with cache directory to avoid warnings
COPIER := uvx --cache-dir /tmp/uvx-cache copier

# Test template generation with git hooks validation
test:
	@set -euo pipefail; \
	tmpdir=$$(mktemp -d); \
	echo "�� Generating template into: $$tmpdir"; \
	$(COPIER) copy --vcs-ref=HEAD . "$$tmpdir" --defaults --force --trust 2>&1 | grep -v "FutureWarning\|DirtyLocalWarning" || true; \
	cd "$$tmpdir"; \
	echo "🌀 Initializing git repo..."; \
	git add -A >/dev/null; \
	bun install --no-cache >/dev/null; \
	echo "🚀 Running pre-commit hooks..."; \
	git commit -m "test: validate hooks" 2>&1 | tee /tmp/hook_output.log | grep -E "🔍 Scanning for secrets" >/dev/null && echo "  ✓ Hooks validated" || (echo "  ✗ Hooks failed" && cat /tmp/hook_output.log && exit 1); \
	cd - >/dev/null; \
	rm -rf "$$tmpdir"; \
	echo "✅ All checks passed and temp folder cleaned up."

# Build for inspection (no git initialization)
build:
	@echo "🔧 Generating template into: build_output/"
	@rm -rf build_output
	@$(COPIER) copy --vcs-ref=HEAD . build_output --defaults --force --trust --data skip_git_init=true 2>&1 | grep -v "FutureWarning\|DirtyLocalWarning" || true
	@echo "📦 Installing dependencies..."
	@cd build_output && bun install --no-cache >/dev/null
	@echo "🚀 Running linter and formatter checks..."
	@cd build_output && bun run lint && bun run format:check
	@echo "✅ Template generated and validated successfully!"
	@echo "📁 Check the output in: build_output/"

clean:
	@echo "🧹 Cleaning build output..."
	@rm -rf build_output
	@echo "✅ Cleaned!"
