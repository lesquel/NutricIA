# Design: Mejoras NutricIA - Quality and Testing

## Technical Approach

This change implements a comprehensive testing infrastructure for NutricIA backend and frontend, fixes CI configuration to enforce testing, and addresses code quality issues. The approach follows a bottom-up strategy: first establish testing infrastructure, then write tests, then fix CI.

## Architecture Decisions

### Decision: Testing Framework Selection

**Choice**: pytest for backend, Vitest + React Native Testing Library for frontend
**Alternatives considered**: unittest (Python), Jest (Frontend)
**Rationale**: 
- pytest is the industry standard for Python with excellent async support
- Vitest is fast, compatible with Jest APIs, and works well with Expo

### Decision: Test Database Strategy

**Choice**: Use in-memory SQLite for unit tests, test database for integration tests
**Alternatives considered**: Mock database entirely, Use production database
**Rationale**: In-memory SQLite is fast and requires no setup. Integration tests should use a real database to catch issues that mocks miss.

### Decision: Component Consolidation

**Choice**: Keep `shared/components/` as the single source of truth, remove legacy versions from `components/shared/`
**Alternatives considered**: Keep both, merge into new location
**Rationale**: The `shared/components/` versions are more feature-complete and use proper state management. Simpler to have one source of truth.

### Decision: CI Fallback Removal

**Choice**: Remove the pytest exit code 5 fallback entirely
**Alternatives considered**: Add a minimum test count check
**Rationale**: Exit code 5 means "no tests collected" - this should ALWAYS fail in CI. A minimum count could have false positives.

## Data Flow

### Test Execution Flow

```
CI Trigger
    │
    ▼
Install Dependencies (pip/ npm)
    │
    ▼
Lint (Ruff / ESLint)
    │
    ▼
Type Check (Mypy / TypeScript)
    │
    ▼
Run Tests (pytest / vitest)
    │
    ├── If exit code = 5 (no tests) → FAIL
    │
    ▼
Coverage Check (coverage.py)
    │
    ├── If coverage < 70% → FAIL
    │
    ▼
All Pass → CI Passes
```

### Test Organization

```
backend/tests/
├── conftest.py              # Shared fixtures
├── unit/
│   ├── auth/
│   │   ├── test_register.py
│   │   ├── test_login.py
│   │   └── test_token.py
│   ├── meals/
│   │   ├── test_crud.py
│   │   └── test_scan.py
│   └── habits/
│       └── test_use_cases.py
└── integration/
    ├── test_auth_api.py
    ├── test_meals_api.py
    └── test_habits_api.py
```

## File Changes

| File | Action | Description |
|------|--------|-------------|
| `backend/tests/conftest.py` | Create | Shared pytest fixtures |
| `backend/tests/__init__.py` | Create | Package marker |
| `backend/tests/unit/auth/test_register.py` | Create | Register use case tests |
| `backend/tests/unit/auth/test_login.py` | Create | Login use case tests |
| `backend/tests/unit/auth/test_token.py` | Create | JWT token tests |
| `backend/tests/unit/meals/test_crud.py` | Create | Meal CRUD tests |
| `backend/tests/unit/meals/test_scan.py` | Create | AI scan tests |
| `backend/tests/unit/habits/test_use_cases.py` | Create | Habit use case tests |
| `backend/tests/integration/test_auth_api.py` | Create | Auth endpoint integration tests |
| `backend/tests/integration/test_meals_api.py` | Create | Meals endpoint integration tests |
| `backend/tests/integration/test_habits_api.py` | Create | Habits endpoint integration tests |
| `backend/pytest.ini` | Create | Pytest configuration |
| `backend/mypy.ini` | Create | Mypy configuration |
| `backend/ruff.toml` | Create | Ruff linter configuration |
| `frontend/components/shared/meal-card.tsx` | Delete | Duplicate component |
| `frontend/components/shared/date-selector.tsx` | Delete | Duplicate component |
| `.github/workflows/ci.yml` | Modify | Remove pytest fallback |

## Interfaces / Contracts

### Pytest Fixtures Contract

```python
# backend/tests/conftest.py
import pytest
from typing import AsyncGenerator
from sqlalchemy.ext.asyncio import AsyncSession

@pytest.fixture
async def db_session() -> AsyncGenerator[AsyncSession, None]:
    """Provides a clean database session for tests."""
    ...

@pytest.fixture
async def test_user(db_session: AsyncSession) -> User:
    """Creates and returns a test user."""
    ...

@pytest.fixture
async def auth_token(test_user: User) -> str:
    """Generates a valid JWT token for test_user."""
    ...
```

### Test User Contract

```python
# All test users must have:
class TestUser:
    email: str           # e.g., "test@example.com"
    password: str        # Plain text, will be hashed
    name: str           # e.g., "Test User"
```

## Testing Strategy

| Layer | What to Test | Approach |
|-------|-------------|----------|
| Unit - Auth | register(), login(), verify_password() | Direct function calls with mocked DB |
| Unit - Meals | save_meal(), list_meals() | Direct function calls with mocked DB |
| Unit - Habits | create_habit(), check_in() | Direct function calls with mocked DB |
| Integration | All API endpoints | FastAPI TestClient with real DB |
| Frontend Components | MealCard, DateSelector | React Native Testing Library |

### Coverage Targets

- **Auth module**: 80% (critical path)
- **Meals module**: 70%
- **Habits module**: 70%
- **Overall**: 70%

## Migration / Rollback

No migration required - this is a pure quality improvement.

### Rollback Steps
1. Delete `backend/tests/` folder
2. Delete `backend/pytest.ini`
3. Delete `backend/mypy.ini`
4. Delete `backend/ruff.toml`
5. Restore deleted frontend components from git
6. Restore CI fallback in `.github/workflows/ci.yml`

## Open Questions

- [ ] Should we add frontend E2E tests with Detox or similar? (Deferred to future)
- [ ] Should we use test containers for integration tests? (No - keep it simple with SQLite)
