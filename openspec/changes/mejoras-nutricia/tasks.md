# Tasks: Mejoras NutricIA - Quality and Testing

## Phase 1: Testing Infrastructure (Foundation)

- [ ] 1.1 Create `backend/tests/` directory structure
- [ ] 1.2 Create `backend/tests/__init__.py` package marker
- [ ] 1.3 Create `backend/pytest.ini` with async configuration
- [ ] 1.4 Create `backend/tests/conftest.py` with fixtures (db_session, test_user, auth_token)
- [ ] 1.5 Add test dependencies to `backend/requirements-dev.txt` (if exists) or document needed packages

## Phase 2: Backend Unit Tests - Auth

- [ ] 2.1 Create `backend/tests/unit/auth/__init__.py`
- [ ] 2.2 Create `backend/tests/unit/auth/test_register.py` - test successful registration
- [ ] 2.3 Create `backend/tests/unit/auth/test_register.py` - test duplicate email fails
- [ ] 2.4 Create `backend/tests/unit/auth/test_login.py` - test successful login
- [ ] 2.5 Create `backend/tests/unit/auth/test_login.py` - test wrong password fails
- [ ] 2.6 Create `backend/tests/unit/auth/test_login.py` - test non-existent user fails
- [ ] 2.7 Create `backend/tests/unit/auth/test_token.py` - test valid token decode
- [ ] 2.8 Create `backend/tests/unit/auth/test_token.py` - test expired token fails

## Phase 3: Backend Unit Tests - Meals

- [x] 3.1 Create `backend/tests/unit/meals/__init__.py`
- [x] 3.2 Create `backend/tests/unit/meals/test_crud.py` - test save_meal creates meal
- [x] 3.3 Create `backend/tests/unit/meals/test_crud.py` - test list_meals filters by user
- [x] 3.4 Create `backend/tests/unit/meals/test_crud.py` - test get_meal returns correct meal
- [x] 3.5 Create `backend/tests/unit/meals/test_crud.py` - test remove_meal deletes meal
- [x] 3.6 Create `backend/tests/unit/meals/test_scan.py` - test scan food returns meal data

## Phase 4: Backend Unit Tests - Habits

- [x] 4.1 Create `backend/tests/unit/habits/__init__.py`
- [x] 4.2 Create `backend/tests/unit/habits/test_use_cases.py` - test create_habit
- [x] 4.3 Create `backend/tests/unit/habits/test_use_cases.py` - test check_in habit
- [x] 4.4 Create `backend/tests/unit/habits/test_use_cases.py` - test water intake tracking

## Phase 5: Backend Integration Tests

- [x] 5.1 Create `backend/tests/integration/__init__.py`
- [x] 5.2 Create `backend/tests/integration/test_auth_api.py` - POST /auth/register endpoint
- [x] 5.3 Create `backend/tests/integration/test_auth_api.py` - POST /auth/login endpoint
- [x] 5.4 Create `backend/tests/integration/test_auth_api.py` - GET /auth/me endpoint
- [x] 5.5 Create `backend/tests/integration/test_meals_api.py` - GET /meals/ endpoint
- [x] 5.6 Create `backend/tests/integration/test_meals_api.py` - POST /meals/ endpoint
- [x] 5.7 Create `backend/tests/integration/test_habits_api.py` - GET /habits/ endpoint
- [x] 5.8 Create `backend/tests/integration/test_habits_api.py` - POST /habits/ endpoint

## Phase 6: Quality Configuration Files

- [x] 6.1 Create `backend/mypy.ini` with proper path configuration
- [x] 6.2 Create `backend/ruff.toml` with linting rules
- [x] 6.3 Verify mypy runs without --ignore-missing-imports locally

## Phase 7: Fix CI Pipeline

- [x] 7.1 Read current `.github/workflows/ci.yml`
- [x] 7.2 Remove pytest exit code 5 fallback from CI
- [x] 7.3 Add coverage threshold check (fail if < 70%)
- [x] 7.4 Verify CI runs tests and fails appropriately in PR

## Phase 8: Frontend Component Cleanup

- [x] 8.1 Verify `shared/components/meal-card.tsx` is the canonical version
- [x] 8.2 Update all imports pointing to `components/shared/meal-card.tsx`
- [x] 8.3 Delete `frontend/components/shared/meal-card.tsx`
- [x] 8.4 Verify `shared/components/date-selector.tsx` is the canonical version
- [x] 8.5 Update all imports pointing to `components/shared/date-selector.tsx`
- [x] 8.6 Delete `frontend/components/shared/date-selector.tsx`

## Phase 9: Verification

- [x] 9.1 Run backend tests locally - all should pass
- [x] 9.2 Run mypy locally - no errors
- [x] 9.3 Run ruff locally - no errors
- [x] 9.4 Check frontend typecheck/lint successfully (no build)
- [x] 9.5 Verify test coverage >= 70%
- [ ] 9.6 Commit all changes (pending explicit user confirmation; not requested in this step)
