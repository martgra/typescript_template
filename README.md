# TypeScript Template

[![Copier](https://img.shields.io/endpoint?url=https://raw.githubusercontent.com/copier-org/copier/master/img/badge/badge-grayscale-inverted-border-orange.json)](https://github.com/copier-org/copier)

A production-ready [Copier](https://copier.readthedocs.io/) template for modern TypeScript projects with comprehensive tooling, testing, and quality checks.

## ✨ Features

- 🚀 **Modern tooling**: Bun/npm/yarn/pnpm support, TypeScript with strict mode option
- 🧪 **Testing infrastructure**: Vitest with coverage reporting and 80% thresholds
- 🔒 **Quality & Security**: ESLint, Prettier, Knip, secret detection, import sorting
- 🪝 **Git hooks**: Husky with lint-staged and secretlint pre-commit checks
- 🐳 **Optional devcontainer**: Reproducible development environment with Docker
- ⚙️ **VSCode integration**: Pre-configured settings, extensions, and debugging
- 🤖 **GitHub Actions**: Complete CI/CD with testing, linting, dependency updates
- 📝 **Documentation**: Auto-generated CONTRIBUTING.md, CHANGELOG.md, and comprehensive README
- ⚖️ **License support**: MIT, Apache-2.0, GPL-3.0, Proprietary, or None
- 🔐 **Environment setup**: .env.example with common configuration patterns

## 🚀 Usage

Generate a new project using Copier:

```bash
# Using uvx (recommended if you have uv installed)
uvx copier copy gh:martgra/typescript_template <destination>

# Or with pipx
pipx run copier copy gh:martgra/typescript_template <destination>
```

### Template Questions

The template will ask you:

- **Project info**: name, description
- **Author**: name and email
- **Development environment**: VSCode settings, devcontainer (Docker)
- **CI/CD**: GitHub Actions workflows
- **Code quality**: Git hooks (Husky), testing framework (Vitest)
- **TypeScript**: Strict mode option
- **License**: MIT, Apache-2.0, GPL-3.0, Proprietary, or None
- **Package manager**: bun, npm, yarn, or pnpm

## 🛠️ Development

This repository contains the Copier template itself. To test the template:

```bash
# Run full validation (generates project, runs all checks)
make test

# Generate template to build_output/ for inspection
make build

# Clean build artifacts
make clean
```

### Testing Workflow

The `make test` command:

1. Generates a project from the template in a temp directory
2. Initializes git and installs dependencies
3. Sets up git hooks
4. Runs all quality checks (lint, format, tests, knip)
5. Cleans up the temp directory

## 📁 Template Structure

```
template/                           # Template files (what gets copied)
├── .github/
│   ├── workflows/
│   │   └── ci.yaml.jinja          # CI workflow for PRs and main
│   └── dependabot.yml             # Dependency updates (npm + devcontainers)
├── .vscode/                        # VSCode settings and extensions
├── .devcontainer/                  # Docker devcontainer setup
├── .husky/                         # Git hooks
│   └── pre-commit                 # Lint, format, and secret scanning
├── src/
│   ├── __tests__/
│   │   └── example.test.ts.jinja  # Example Vitest tests
│   └── index.ts.jinja             # Entry point
├── CONTRIBUTING.md.jinja           # Contribution guidelines
├── CHANGELOG.md.jinja              # Version history template
├── LICENSE.jinja                   # License file (MIT/Apache/GPL/Proprietary)
├── README.md.jinja                 # Generated project README with badges
├── package.json.jinja              # Dependencies and scripts
├── tsconfig.json.jinja             # TypeScript configuration
├── vitest.config.ts.jinja          # Test configuration with coverage
├── .env.example.jinja              # Environment variables template
├── .secretlintrc.json.jinja        # Secret detection rules
├── .eslintrc.json.jinja            # ESLint configuration
├── .prettierrc.jinja               # Prettier configuration
├── knip.json.jinja                 # Unused code detection
├── .editorconfig.jinja             # Editor settings
└── .gitignore.jinja                # Git ignore patterns

copier.yaml                         # Template configuration and questions
includes/slugify.jinja              # Helper macro for package naming
Makefile                            # Template testing infrastructure
```

## 🔄 Updates

To update an existing project with new template changes:

```bash
# From within your generated project
copier update
```

This will prompt you for any new questions and merge in template updates.

## 🎯 What's Included in Generated Projects

### Testing
- ✅ Vitest testing framework
- ✅ Example test suite
- ✅ Coverage reporting with 80% thresholds
- ✅ Watch mode support

### Code Quality
- ✅ ESLint with TypeScript support
- ✅ Prettier for consistent formatting
- ✅ Import sorting (simple-import-sort)
- ✅ Knip for unused code detection
- ✅ Secretlint for credential scanning

### Git Hooks (Husky)
- ✅ Pre-commit: lint-staged, secret scanning
- ✅ Auto-fix on commit (review required before re-committing)

### CI/CD
- ✅ Pull request validation workflow
- ✅ Automated dependency updates (Dependabot)
- ✅ Test execution with coverage upload
- ✅ Build verification

### Documentation
- ✅ Comprehensive README with badges
- ✅ Contributing guidelines
- ✅ Changelog template
- ✅ Environment variable examples

## 📋 Requirements

- Python 3.8+ (for Copier)
- Bun 1.3.1+ or Node.js 20+ (for generated projects)
- Git 2.0+
- Docker (optional, for devcontainer)

## 🤝 Contributing

Contributions to improve this template are welcome! Please:

1. Test your changes with `make test`
2. Ensure the build passes with `make build`
3. Update documentation as needed

## 📄 License

This template is available under the MIT License. Generated projects can use any license you choose during setup.

├── .vscode/                 # VSCode settings
├── .devcontainer/           # Dev container config (optional)
├── .husky/                  # Git hooks (optional)
├── .github/                 # GitHub Actions (optional)
└── includes/                # Jinja macros and utilities

copier.yaml                  # Template configuration
Makefile                     # Template testing
```

## Requirements

- [Copier](https://copier.readthedocs.io/) 9.0.0+
- [Bun](https://bun.sh/) or npm/yarn/pnpm

## License

MIT
