# Copier Template for TypeScript/Bun Projects

This repository contains a [Copier](https://copier.readthedocs.io/) template for scaffolding TypeScript projects with Bun, complete linting/formatting setup, and optional devcontainer support.

## Using This Template

### Prerequisites

```bash
# Install Copier (Python CLI tool)
pip install copier
# or
pipx install copier
```

### Generate a New Project

```bash
# Using the template branch
copier copy --vcs-ref=template gh:your-username/your-repo path/to/new-project

# Or if you've cloned this repo locally
copier copy path/to/this/repo/template path/to/new-project
```

Copier will ask you several questions to customize your project:

- **Project name**: Name for your project (used in package.json)
- **Description**: Short description of your project
- **Author name**: Your name
- **Author email**: Your email address
- **Use Git**: Initialize git repository in new project
- **Use devcontainer**: Include VSCode devcontainer setup
- **Setup Husky**: Include git hooks for pre-commit linting
- **TypeScript strict mode**: Enable all strict TypeScript checks
- **Package manager**: Choose between bun, npm, yarn, or pnpm

### What's Included

The generated project includes:

- **Bun Runtime**: Fast JavaScript/TypeScript runtime and package manager
- **TypeScript**: Full TypeScript support with configurable strict mode
- **ESLint**: Code linting with TypeScript support
- **Prettier**: Code formatting with consistent style
- **Import Sorting**: Automatic import organization via eslint-plugin-simple-import-sort
- **Knip**: Unused code and dependency detection
- **Husky** (optional): Git hooks for pre-commit checks
- **lint-staged** (optional): Run linters only on staged files
- **Devcontainer** (optional): Complete Docker-based development environment

### Project Scripts

After generation, the following scripts are available:

```bash
# Development
bun run dev          # Run in development mode with watch
bun run build        # Build for production
bun start           # Run the built project

# Code Quality
bun run lint        # Check for linting issues
bun run lint:fix    # Auto-fix linting issues
bun run format      # Format code with Prettier
bun run format:check # Check if code is formatted
bun run knip        # Find unused code and dependencies
```

### Development Environment Options

#### Without Devcontainer
Just install Bun locally:
```bash
curl -fsSL https://bun.sh/install | bash
bun install
```

#### With Devcontainer
Open the project in VSCode and use the "Reopen in Container" command. Everything is pre-configured.

## Branch Structure

- **main**: Working example project (this README documents the template)
- **template**: Copier template with Jinja2-templated files

## Template Development

To modify the template:

1. Switch to template branch: `git checkout template`
2. Edit files in `template/` directory
3. Modify `copier.yml` to add/change questions
4. Test locally: `copier copy template /tmp/test-project`

## License

MIT
