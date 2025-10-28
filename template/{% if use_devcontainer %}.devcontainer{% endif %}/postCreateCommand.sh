#!/bin/bash

set -e

# Ensure node_modules ownership is correct (should already be owned by vscode from Dockerfile)
# No sudo needed as we're running as vscode user
chown -R vscode:vscode /workspace/node_modules 2>/dev/null || true

