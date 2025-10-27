# Multiplayer Game

A TypeScript-based multiplayer game project with a complete development setup.

## Quick Start

```bash
# Install dependencies
bun install

# Start development server
bun run dev

# Build for production
bun run build

# Run production build
bun run start
```

## Development Tools

### Linting & Formatting

```bash
# Run ESLint
bun run lint
bun run lint:fix

# Run Prettier
bun run format
bun run format:check

# Find unused code/dependencies
bun run knip
```

### Git Hooks

Pre-commit hooks automatically run ESLint and Prettier on staged files:

- Files are fixed but **not auto-staged**
- Review changes, then stage and commit again

## Project Structure

```
.
├── src/              # Source code
├── .devcontainer/    # Dev container configuration (optional)
├── .husky/           # Git hooks
├── .vscode/          # VSCode settings
└── dist/             # Build output
```

## Configuration Files

- **`.prettierrc`** - Code formatting rules
- **`.eslintrc.json`** - Linting rules
- **`.editorconfig`** - Editor configuration
- **`knip.json`** - Unused code detection
- **`tsconfig.json`** - TypeScript configuration

## Converting to Monorepo

If you want to organize your code as a monorepo with separate packages (e.g., server/client):

### 1. Update `package.json`

```json
{
  "name": "multiplayer-game-monorepo",
  "workspaces": ["packages/*"],
  "scripts": {
    "build": "bun run --filter '*' build",
    "dev": "bun run --filter '*' dev",
    "lint": "bun run --filter '*' lint"
  }
}
```

### 2. Create Package Structure

```bash
mkdir -p packages/server packages/client

# Move existing code or create new packages
mv src packages/server/src
```

### 3. Create Package package.json Files

**packages/server/package.json:**

```json
{
  "name": "@your-game/server",
  "version": "1.0.0",
  "main": "dist/index.js",
  "scripts": {
    "build": "tsc",
    "dev": "bun run --watch src/index.ts"
  }
}
```

**packages/client/package.json:**

```json
{
  "name": "@your-game/client",
  "version": "1.0.0",
  "main": "dist/index.js",
  "scripts": {
    "build": "tsc",
    "dev": "bun run --watch src/index.ts"
  }
}
```

### 4. Update `knip.json`

```json
{
  "$schema": "https://unpkg.com/knip@latest/schema.json",
  "workspaces": {
    ".": {
      "entry": ["index.ts"],
      "project": ["**/*.ts"]
    },
    "packages/*": {
      "entry": ["src/index.ts"],
      "project": ["src/**/*.ts"]
    }
  }
}
```

### 5. Update `tsconfig.json`

Create a root `tsconfig.json`:

```json
{
  "files": [],
  "references": [{ "path": "./packages/server" }, { "path": "./packages/client" }]
}
```

Each package gets its own `tsconfig.json`:

```json
{
  "extends": "../../tsconfig.base.json",
  "compilerOptions": {
    "outDir": "dist",
    "rootDir": "src"
  },
  "include": ["src"]
}
```

## Dev Container (Optional)

This project includes a dev container configuration for consistent development environments:

```bash
# Open in VS Code with Dev Containers extension
code .
# Then: Reopen in Container
```

Features:

- Bun pre-installed
- ZSH with Oh My Zsh
- All extensions auto-installed
- Persistent command history

## License

MIT
