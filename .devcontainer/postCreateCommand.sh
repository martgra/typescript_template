#!/bin/bash

set -euo pipefail

# Ensure node_modules ownership is correct (should already be owned by vscode from Dockerfile)
# No sudo needed as we're running as vscode user
chown -R vscode:vscode /workspace/node_modules 2>/dev/null || true

echo "Running mise install..."
mise install

# Sync dependencies only if node_modules missing or manifests changed
if [ ! -d node_modules ] || [ package.json -nt node_modules ] || [ bun.lock -nt node_modules ]; then
    echo "Running bun install (post-create)..."
    bun install
else
    echo "bun install skipped (node_modules up-to-date)."
fi

echo "PostCreate complete"
