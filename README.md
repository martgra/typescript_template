# TypeScript Template

[![Copier](https://img.shields.io/endpoint?url=https://raw.githubusercontent.com/copier-org/copier/master/img/badge/badge-grayscale-inverted-border-orange.json)](https://github.com/copier-org/copier)

A minimal [Copier](https://copier.readthedocs.io/) template for TypeScript projects with essential quality tooling.

## ✨ Features

- 🚀 **TypeScript**: Simple Hello World starter with optional strict mode
- 📦 **Bun**: Fast package manager and runtime
- 🔒 **Quality & Security**: Biome (lint, format, import sorting), Prettier for docs, Knip
- 🪝 **Git hooks**: Husky with lint-staged and secretlint (always enabled)
- 🔐 **Secret detection**: Secretlint in pre-commit hooks and CI
- 🐳 **Optional devcontainer**: Reproducible development environment
- ⚙️ **Optional VSCode**: Pre-configured settings and extensions
- 🤖 **Optional GitHub Actions**: CI/CD with linting and build checks
- ⚖️ **MIT License**: Always included

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
- **Development environment**: VSCode settings (yes/no), devcontainer (yes/no)
- **CI/CD**: GitHub Actions workflows (yes/no)
- **TypeScript**: Strict mode option (yes/no)

## 🛠️ Development

This repository contains the Copier template itself. To test the template:

```bash
# Run validation (generates project, runs all checks)
make test

# Generate template to build_output/ for inspection
make build

# Clean build artifacts
make clean
```

The `make test` command generates a project, installs dependencies, and runs all quality checks (lint, format, build, and runtime test).

## 📁 Template Structure

```
template/                           # Template files (what gets copied)
├── .github/
│   ├── workflows/
│   │   └── ci.yaml.jinja          # CI workflow (optional)
│   └── dependabot.yaml            # Dependency updates
├── .vscode/                        # VSCode settings (optional)
├── .devcontainer/                  # Docker devcontainer (optional)
├── .husky/                         # Git hooks
│   └── pre-commit                 # Lint, format, and secret scanning
├── src/
│   └── index.ts                   # Simple Hello World entry point
├── CONTRIBUTING.md.jinja           # Contribution guidelines
├── CHANGELOG.md.jinja              # Version history template
├── LICENSE.jinja                   # MIT License
├── README.md.jinja                 # Generated project README with badges
├── package.json.jinja              # Dependencies and scripts
├── tsconfig.json.jinja             # TypeScript configuration
├── .secretlintrc.json.jinja        # Secret detection rules
├── biome.json                      # Lint, format & import sort rules
├── .prettierrc.jinja               # Prettier config (Markdown & YAML)
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

### Core Files

- ✅ Simple TypeScript Hello World (`src/index.ts`)
- ✅ Build configuration for Bun
- ✅ MIT License

### Code Quality

- ✅ Biome for linting, formatting, and import sorting (JS/TS/JSON)
- ✅ Prettier for Markdown & YAML formatting
- ✅ Knip for unused code detection
- ✅ Secretlint for credential scanning

### Git Hooks (Husky)

- ✅ Pre-commit: lint-staged, secret scanning, formatting
- ✅ Auto-fix on commit (changes not auto-staged for review)

### Optional Features

- ✅ GitHub Actions CI/CD workflow
- ✅ VSCode settings and recommended extensions
- ✅ Devcontainer for Docker-based development

### Documentation

- ✅ Comprehensive README with badges
- ✅ Contributing guidelines
- ✅ Changelog template

## 📋 Requirements

- Python 3.8+ (for Copier)
- Bun 1.3.1+ (for generated projects)
- Git 2.0+
- Docker (optional, for devcontainer)

## 🤝 Contributing

Contributions to improve this template are welcome! Please:

1. Test your changes with `make test`
2. Ensure the build passes with `make build`
3. Update documentation as needed

## 📄 License

MIT - This template itself is MIT licensed. Generated projects also use MIT license.
