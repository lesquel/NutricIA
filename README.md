<p align="center">
  <img src="design/logo-placeholder.png" alt="NutricIA" width="120" />
</p>

<h1 align="center">NutricIA</h1>

<p align="center">
  <strong>Open-source AI-powered calorie tracker with a mindful living twist</strong>
</p>

<p align="center">
  <a href="LICENSE"><img src="https://img.shields.io/badge/License-MIT-green.svg" alt="MIT License" /></a>
  <a href="https://github.com/lesquel/NutricIA/actions"><img src="https://img.shields.io/github/actions/workflow/status/lesquel/NutricIA/ci.yml?label=CI" alt="CI" /></a>
  <img src="https://img.shields.io/badge/Python-3.12+-blue.svg" alt="Python" />
  <img src="https://img.shields.io/badge/Expo-SDK%2054-000020.svg" alt="Expo" />
</p>

---

## What is NutricIA?

NutricIA is a mobile-first calorie tracker that uses **AI vision** to scan your meals, a **habit garden** to gamify healthy routines, and a **journal** to log your daily nourishment — all wrapped in a warm, sage-green aesthetic.

### Key Features

- **AI Food Scanner** — Take a photo, get instant calorie & macro estimates (Gemini / GPT-4o)
- **Dashboard** — Daily calorie ring, macro pills, and recent meals at a glance
- **Journal** — Grouped meal log by time-of-day (Breakfast → Dinner)
- **Habit Garden** — Plant seeds for each habit; watch them grow, wilt, or bloom
- **Hydration Tracker** — Tap cups to track daily water intake
- **Settings & Goals** — Customize calorie/water targets and dietary preferences

---

## Tech Stack

| Layer | Technology |
|-------|-----------|
| **Mobile App** | React Native 0.81 · Expo SDK 54 · Expo Router v6 · TypeScript |
| **State** | Zustand 5 · TanStack React Query 5 |
| **Backend API** | FastAPI · Python 3.12+ · Pydantic v2 |
| **Database** | PostgreSQL 16 · SQLAlchemy 2.0 (async) · Alembic |
| **AI** | Gemini 2.0 Flash · OpenAI GPT-4o (strategy pattern) |
| **Auth** | OAuth 2.0 (Google / Apple) → JWT |
| **Infra** | Docker Compose · GitHub Actions CI |

---

## Quick Start

### Prerequisites

- **Docker** & **Docker Compose** v2+
- **Node.js** 22+ (for frontend dev without Docker)
- **Python 3.12+** & [**uv**](https://docs.astral.sh/uv/) (for backend dev without Docker)

### 1. Clone with submodules

```bash
git clone --recurse-submodules https://github.com/lesquel/NutricIA.git
cd NutricIA
```

### 2. Configure environment

```bash
cp .env.example .env
cp backend/.env.example backend/.env
cp frontend/.env.example frontend/.env
# Edit .env files with your API keys (Gemini / OpenAI, Google OAuth, etc.)
```

### 3. Start everything

```bash
make dev
# or without Make:
docker compose up --build
```

| Service | URL |
|---------|-----|
| Backend API | http://localhost:8000 |
| API Docs (Swagger) | http://localhost:8000/docs |
| pgAdmin | http://localhost:5050 |
| Frontend (Expo) | http://localhost:8081 |

### 4. Run migrations

```bash
make migrate
```

---

## Project Structure

```
NutricIA/
├── backend/                    # FastAPI backend (git submodule)
│   ├── app/
│   │   ├── shared/             # Shared domain, infra, security
│   │   ├── auth/               # OAuth + JWT authentication
│   │   │   ├── domain/         # Enums, exceptions
│   │   │   ├── application/    # Use cases
│   │   │   ├── infrastructure/ # Models, repositories, providers
│   │   │   └── presentation/   # Schemas, router
│   │   ├── meals/              # AI food scanning + CRUD
│   │   ├── habits/             # Gamified habit tracking
│   │   ├── analytics/          # Daily/weekly/monthly stats
│   │   └── users/              # Profile & settings
│   ├── alembic/                # DB migrations
│   └── Dockerfile
├── frontend/                   # Expo/React Native app (git submodule)
│   ├── app/                    # Expo Router screens
│   ├── features/               # Feature modules
│   │   ├── auth/               # Auth service, store, hooks
│   │   ├── dashboard/          # Dashboard hooks, components
│   │   ├── scanner/            # Camera scan hooks, components
│   │   ├── journal/            # Journal hooks, components
│   │   ├── garden/             # Habits hooks, components
│   │   └── settings/           # Settings hooks, service
│   ├── shared/                 # Shared API client, types, stores
│   └── Dockerfile
├── docker-compose.yml
├── Makefile
└── scripts/
```

### Architecture

**Backend** follows **Clean Architecture** per feature module:

```
domain/         → Business rules, enums, exceptions (zero dependencies)
application/    → Use cases orchestrating domain + infrastructure
infrastructure/ → SQLAlchemy models, repositories, external APIs
presentation/   → FastAPI routers, Pydantic schemas
```

**Frontend** follows a **Feature-based** architecture:

```
features/{name}/
  api/          → API service calls (via shared client)
  hooks/        → React Query hooks + Zustand selectors
  components/   → Feature-specific UI components
  store/        → Zustand store (if feature-local state needed)
```

---

## Available Commands

```bash
make dev              # Start all containers
make dev-detached     # Start in background
make stop             # Stop all containers
make migrate          # Run Alembic migrations
make migrate-generate # Auto-generate a new migration
make test             # Run backend tests
make lint             # Lint backend + frontend
make format           # Format backend code
make logs             # Tail all container logs
make shell-backend    # Open bash in backend container
make shell-frontend   # Open bash in frontend container
make clean            # Remove containers & volumes
```

---

## Contributing

We love contributions! Please read our [Contributing Guide](CONTRIBUTING.md) before submitting a PR.

1. Fork the repo
2. Create a feature branch: `git checkout -b feat/my-feature`
3. Commit with [Conventional Commits](https://www.conventionalcommits.org/): `git commit -m "feat: add meal editing"`
4. Push and open a Pull Request

---

## Security

Found a vulnerability? Please report it responsibly — see [SECURITY.md](SECURITY.md).

---

## License

[MIT](LICENSE) — NutricIA Contributors
