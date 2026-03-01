# Contributing to NutricIA

First off, thank you for considering contributing to NutricIA! 🌱

## Table of Contents

- [Code of Conduct](#code-of-conduct)
- [Getting Started](#getting-started)
- [Development Workflow](#development-workflow)
- [Coding Standards](#coding-standards)
- [Commit Messages](#commit-messages)
- [Pull Request Process](#pull-request-process)
- [Reporting Bugs](#reporting-bugs)
- [Suggesting Features](#suggesting-features)

## Code of Conduct

This project adheres to the [Contributor Covenant Code of Conduct](CODE_OF_CONDUCT.md). By participating, you are expected to uphold this code.

## Getting Started

1. **Fork** the repository
2. **Clone** your fork with submodules:

   ```bash
   git clone --recurse-submodules https://github.com/YOUR_USERNAME/NutricIA.git
   cd NutricIA
   ```

3. **Set up** the development environment:

   ```bash
   bash scripts/setup.sh
   ```

4. **Start** the stack:

   ```bash
   make dev
   ```

### CI Submodule Access

If `backend/` and `frontend/` repositories are private, configure a repository secret named `SUBMODULES_TOKEN` in GitHub Actions with read access to both submodule repositories.

## Development Workflow

### Branch Naming

| Prefix | Use |
|--------|-----|
| `feature/` | New features (`feature/add-meal-editing`) |
| `fix/` | Bug fixes (`fix/calorie-calculation`) |
| `docs/` | Documentation changes (`docs/api-endpoints`) |
| `refactor/` | Code refactoring (`refactor/auth-service`) |
| `test/` | Adding tests (`test/habits-service`) |
| `chore/` | Maintenance (`chore/update-deps`) |

### Steps

1. Create a branch from `main`:

   ```bash
   git checkout -b feature/your-feature
   ```

2. Make your changes
3. Run linting and tests:

   ```bash
   make lint
   make test
   ```

4. Install and enable pre-commit hooks:

   ```bash
   pip install pre-commit
   pre-commit install
   pre-commit run --all-files
   ```

   Alternative (no global install):

   ```bash
   uvx pre-commit run --all-files
   ```

   Hooks run checks for both `backend/` (Ruff format/lint) and `frontend/` (Expo lint + TypeScript).
   Note: `backend/` and `frontend/` are git submodules; hooks execute commands inside each submodule.

   Ensure frontend dependencies are installed before running hooks:

   ```bash
   cd frontend && npm install
   ```

5. Commit following [Conventional Commits](#commit-messages)
6. Push and open a Pull Request

### Submodule Commit Flow

Because `backend/` and `frontend/` are git submodules, commit in this order:

1. Commit inside `backend/` and/or `frontend/`
2. Return to repository root
3. Commit updated submodule pointers in root repo

Example:

```bash
cd backend && git add -A && git commit -m "fix(backend): ..."
cd ../frontend && git add -A && git commit -m "fix(frontend): ..."
cd .. && git add backend frontend && git commit -m "chore: update submodule refs"
```

## Coding Standards

### Backend (Python)

- **Python 3.12+** with modern type annotations
- **Ruff** for linting and formatting
- **mypy** for type checking
- Follow Clean Architecture: `domain → application → infrastructure → presentation`
- Use `async/await` throughout
- All functions should have type hints

```bash
# Check
make lint
make typecheck

# Auto-fix
make format
```

### Frontend (TypeScript)

- **TypeScript strict mode** enabled
- **ESLint** for linting
- Components use functional style with hooks
- Feature-based architecture: `features/{name}/components|hooks|services|stores`
- Use theme tokens from `constants/theme.ts` — no hardcoded colors

```bash
make lint
npm run typecheck
```

## Commit Messages

We follow [Conventional Commits](https://www.conventionalcommits.org/):

```
<type>(<scope>): <description>

[optional body]

[optional footer(s)]
```

### Types

| Type | Description |
|------|-------------|
| `feat` | New feature |
| `fix` | Bug fix |
| `docs` | Documentation |
| `style` | Formatting (not CSS) |
| `refactor` | Code restructuring |
| `test` | Adding tests |
| `chore` | Maintenance |
| `perf` | Performance improvement |
| `ci` | CI/CD changes |

### Examples

```
feat(meals): add manual meal entry form
fix(auth): handle expired Google OAuth tokens
docs(readme): add deployment guide
refactor(habits): extract check-in use case
```

## Pull Request Process

1. Ensure your PR description clearly describes the problem and solution
2. Link any related issues using `Closes #123`
3. Make sure all checks pass (lint, test, type-check)
4. Request a review from a maintainer
5. Address feedback promptly
6. Squash commits before merging

### PR Checklist

- [ ] Code follows the project's coding standards
- [ ] Tests added/updated for changes
- [ ] Documentation updated if needed
- [ ] No new linting errors
- [ ] Type checking passes
- [ ] Commit messages follow Conventional Commits

## Reporting Bugs

Use the [Bug Report template](.github/ISSUE_TEMPLATE/bug_report.md) and include:

- Clear description of the bug
- Steps to reproduce
- Expected vs actual behavior
- Screenshots if applicable
- Environment details (OS, browser, device)

## Suggesting Features

Use the [Feature Request template](.github/ISSUE_TEMPLATE/feature_request.md) and include:

- Problem description (what pain point does this solve?)
- Proposed solution
- Alternatives considered
- Additional context

---

Thank you for helping make NutricIA better! 🌿
