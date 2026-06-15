# typescript-template

> 🎯 Generated from [martgra/typescript_template](https://github.com/martgra/typescript_template)
>
> ```bash
> # Generate your own project with Copier
> uvx copier copy gh:martgra/typescript_template my-project
> ```

A TypeScript project

[![Copier](https://img.shields.io/endpoint?url=https://raw.githubusercontent.com/copier-org/copier/master/img/badge/badge-grayscale-inverted-border-orange.json)](https://github.com/copier-org/copier)
[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](./LICENSE)
[![TypeScript](https://img.shields.io/badge/TypeScript-5.2%2B-blue)](https://www.typescriptlang.org/)
[![Bun](https://img.shields.io/badge/bun-latest-black)](https://bun.sh)

## ✨ Features

- 🚀 **TypeScript** - Type-safe development with strict mode
- 📦 **Bun** - Fast package management and runtime
- 🎨 **Biome** - Lint, format, and import sorting for code (JS/TS/JSON)
- 📝 **Prettier** - Formatting for Markdown & YAML
- 🔍 **Knip** - Detect unused code and dependencies
- 🪝 **Husky** - Git hooks for quality enforcement
- 🔐 **Secret Detection** - Prevent committing secrets
- ⚙️ **GitHub Actions** - Automated CI/CD
- 🐳 **Dev Container** - Consistent development environment

## Quick Start

```bash
# Install dependencies
bun install

# Set up git hooks
bun run prepare

# Start development with watch mode
bun run dev

# Build for production
bun run build

# Run production build
bun start
```

## 🛠️ Development Tools

### Linting & Formatting

```bash
# Run Biome (lint + format + organize imports for code)
bun run check
bun run lint
bun run lint:fix

# Check/fix formatting (Biome for code, Prettier for docs)
bun run format
bun run format:check

# Find unused code/dependencies
bun run knip
```

### Git Hooks

Pre-commit hooks automatically:

- Run Biome (lint, format, organize imports)
- Format Markdown & YAML with Prettier
- Scan for secrets with secretlint

**Note:** Changes are **not auto-staged**. Review, stage, and commit again if hooks make changes.

## 📁 Project Structure

```
.
├── .devcontainer/       # Dev container configuration
├── .github/
│   └── workflows/       # GitHub Actions CI/CD
├── .husky/              # Git hooks
├── .vscode/             # VSCode settings
├── src/
│   └── index.ts         # Entry point
├── dist/                # Build output
├── CONTRIBUTING.md      # Contribution guidelines
├── CHANGELOG.md         # Version history
├── LICENSE              # MIT License file
└── package.json
```

## ⚙️ Configuration Files

- **`biome.json`** - Lint, format, and import sort rules (JS/TS/JSON)
- **`.prettierrc`** - Formatting rules for Markdown & YAML
- **`.editorconfig`** - Editor configuration for consistency
- **`knip.json`** - Unused code and dependency detection
- **`.secretlintrc.json`** - Secret detection rules
- **`tsconfig.json`** - TypeScript compiler options (strict mode)

## 🤝 Contributing

See [CONTRIBUTING.md](./CONTRIBUTING.md) for guidelines.

## 📝 License

MIT - See [LICENSE](./LICENSE) file for details.
