# Repository Guidelines

## Project Structure & Module Organization
- `src/` — application code grouped by feature/module. Keep files small and cohesive.
- `tests/` — unit/integration tests mirroring `src/` layout.
- `scripts/` — one-off or automation scripts (CI, data, maintenance).
- `assets/` or `public/` — static files (images, styles, fixtures).
- `docs/` — developer docs and diagrams.

If a subproject exists (e.g., `frontend/`, `backend/`), each follows the same structure inside its folder.

## Build, Test, and Development Commands
- Prefer `make` targets if present: `make help`, `make dev`, `make build`, `make test`, `make lint`.
- JavaScript/TypeScript: `npm run dev`, `npm run build`, `npm test`, `npm run lint`.
- Python: `pytest -q`, `ruff check .`, `black .` (or run via `make`).

Run commands from the project root unless a subproject `README` states otherwise.

## Coding Style & Naming Conventions
- Indentation: 2 spaces (JS/TS), 4 spaces (Python). No tabs.
- Formatters/Linters: use configured tools (e.g., Prettier, Black, Ruff, ESLint). Examples:
  - `npm run lint && npm run format`
  - `ruff check . && black .`
- Naming: `camelCase` for variables/functions (JS/TS), `snake_case` (Python), `PascalCase` for classes, `kebab-case` for CLI files and script names.
- Keep functions <100 lines; extract helpers for readability.

## Testing Guidelines
- Mirror `src/` structure under `tests/`.
- Naming: Python `tests/test_*.py`; JS/TS `**/*.test.(js|ts|tsx)`.
- Aim for ≥80% coverage on changed code. Add regression tests for fixed bugs.
- Run fast unit tests locally before pushing: `make test` or `npm test` / `pytest`.

## Commit & Pull Request Guidelines
- Use Conventional Commits when possible: `feat: add user search`, `fix: handle null IDs`.
- Scope small and atomic; one logical change per PR.
- PR checklist:
  - Clear description and rationale; link issues (e.g., `#123`).
  - Screenshots or CLI output for UI/UX/CLI changes.
  - Steps to verify locally; note migrations or breaking changes.

## Security & Configuration
- Do not commit secrets. Use env files: `cp .env.example .env.local` and keep `.env*` in `.gitignore`.
- Validate inputs and handle errors explicitly; fail closed.

## Agent-Specific Notes
- Follow this file’s guidance within its scope. Favor minimal, surgical changes that match existing patterns. Avoid broad refactors unless requested.
