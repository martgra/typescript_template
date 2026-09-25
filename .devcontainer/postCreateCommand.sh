#!/bin/bash

set -e

chown -R vscode:vscode /workspace/node_modules 2>/dev/null || true

mise install
bun install

