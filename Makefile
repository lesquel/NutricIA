# ──────────────────────────────────────────────
# NutricIA — Makefile
# ──────────────────────────────────────────────
.PHONY: help setup dev dev-backend dev-frontend stop migrate test lint clean logs

COMPOSE := docker compose

# Default target
help: ## Show this help
	@echo ""
	@echo "  🌱 NutricIA — Development Commands"
	@echo "  ──────────────────────────────────────"
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | \
		awk 'BEGIN {FS = ":.*?## "}; {printf "  \033[36m%-18s\033[0m %s\n", $$1, $$2}'
	@echo ""

# ── Setup ────────────────────────────────────

setup: ## Initial project setup (submodules, env, deps)
	@echo "🌱 Setting up NutricIA..."
	git submodule update --init --recursive
	@[ -f .env ] || cp .env.example .env && echo "  ✓ Root .env created"
	@[ -f backend/.env ] || cp backend/.env.example backend/.env && echo "  ✓ Backend .env created"
	@[ -f frontend/.env ] || cp frontend/.env.example frontend/.env && echo "  ✓ Frontend .env created"
	@echo "✅ Setup complete! Run 'make dev' to start."

# ── Development ──────────────────────────────

dev: ## Start full stack (DB + Backend + Frontend + pgAdmin)
	$(COMPOSE) up --build

dev-detached: ## Start full stack in background
	$(COMPOSE) up --build -d

dev-backend: ## Start only backend + database
	$(COMPOSE) up --build db backend

dev-frontend: ## Start only frontend
	$(COMPOSE) up --build frontend

stop: ## Stop all containers
	$(COMPOSE) down

restart: ## Restart all containers
	$(COMPOSE) restart

# ── Database ─────────────────────────────────

migrate: ## Run Alembic migrations
	$(COMPOSE) exec backend alembic upgrade head

migrate-generate: ## Generate a new migration (usage: make migrate-generate msg="description")
	$(COMPOSE) exec backend alembic revision --autogenerate -m "$(msg)"

migrate-downgrade: ## Rollback last migration
	$(COMPOSE) exec backend alembic downgrade -1

db-shell: ## Open PostgreSQL shell
	$(COMPOSE) exec db psql -U postgres -d nutricia

# ── Testing ──────────────────────────────────

test: ## Run all tests
	@echo "🧪 Running backend tests..."
	$(COMPOSE) exec backend python -m pytest -v
	@echo ""
	@echo "🧪 Running frontend type check..."
	$(COMPOSE) exec frontend npx tsc --noEmit

test-backend: ## Run backend tests only
	$(COMPOSE) exec backend python -m pytest -v

# ── Code Quality ─────────────────────────────

lint: ## Run all linters
	@echo "🔍 Linting backend..."
	$(COMPOSE) exec backend ruff check .
	$(COMPOSE) exec backend ruff format --check .
	@echo ""
	@echo "🔍 Linting frontend..."
	$(COMPOSE) exec frontend npx eslint .

format: ## Auto-format all code
	$(COMPOSE) exec backend ruff format .
	$(COMPOSE) exec backend ruff check --fix .

typecheck: ## Run type checking
	$(COMPOSE) exec backend mypy app/
	$(COMPOSE) exec frontend npx tsc --noEmit

# ── Logs & Debug ─────────────────────────────

logs: ## Follow all container logs
	$(COMPOSE) logs -f

logs-backend: ## Follow backend logs
	$(COMPOSE) logs -f backend

logs-frontend: ## Follow frontend logs
	$(COMPOSE) logs -f frontend

shell-backend: ## Open a shell in the backend container
	$(COMPOSE) exec backend bash

shell-frontend: ## Open a shell in the frontend container
	$(COMPOSE) exec frontend bash

# ── Cleanup ──────────────────────────────────

clean: ## Stop containers and remove volumes
	$(COMPOSE) down -v --remove-orphans
	@echo "🧹 Cleaned up containers and volumes."

clean-all: ## Full cleanup including images and cache
	$(COMPOSE) down -v --rmi local --remove-orphans
	docker system prune -f
	@echo "🧹 Full cleanup complete."
