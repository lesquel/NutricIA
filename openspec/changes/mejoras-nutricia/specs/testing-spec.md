# Delta for Testing Infrastructure

## Purpose

This spec defines the testing requirements for the NutricIA backend and frontend, establishing a baseline of quality assurance that the project currently lacks.

## ADDED Requirements

### Requirement: Backend Unit Tests MUST Exist

The backend MUST have unit tests covering at minimum:
- Auth module: register, login, token validation
- Meals module: CRUD operations, list filtering
- Habits module: create habit, check-in, water tracking
- Analytics module: daily/weekly summaries

#### Scenario: Auth register creates user

- GIVEN a valid registration request with email, name, and password
- WHEN the register endpoint is called
- THEN a new user is created in the database
- AND a JWT access token is returned
- AND the password is hashed (not stored in plain text)

#### Scenario: Auth login returns token

- GIVEN an existing user with email "test@example.com" and password "password123"
- WHEN the login endpoint is called with correct credentials
- THEN a JWT access token is returned
- AND the token can be used to access protected endpoints

#### Scenario: Auth login with wrong password fails

- GIVEN an existing user with password "password123"
- WHEN login is attempted with password "wrongpassword"
- THEN a 401 Unauthorized response is returned
- AND no token is returned

#### Scenario: Protected endpoint without token fails

- GIVEN no authentication token
- WHEN accessing a protected endpoint like /meals/
- THEN a 401 Unauthorized response is returned

#### Scenario: Protected endpoint with invalid token fails

- GIVEN an invalid or expired JWT token
- WHEN accessing a protected endpoint
- THEN a 401 Unauthorized response is returned

### Requirement: Backend Integration Tests MUST Exist

The backend MUST have integration tests for API endpoints.

#### Scenario: Meals list returns user meals only

- GIVEN an authenticated user with 3 meals in the database
- WHEN GET /meals/ is called with valid auth
- THEN exactly 3 meals are returned
- AND each meal belongs to the authenticated user

#### Scenario: Create meal adds to database

- GIVEN an authenticated user
- WHEN POST /meals/ is called with meal data
- THEN the meal is created in the database
- AND the returned meal matches the input data

### Requirement: Frontend Component Tests MUST Exist

The frontend MUST have tests for critical components.

#### Scenario: MealCard renders correctly

- GIVEN a meal object with name, calories, protein, carbs, fat
- WHEN the MealCard component renders
- THEN all nutritional values are displayed correctly

#### Scenario: DateSelector navigation works

- GIVEN the DateSelector component
- WHEN the user clicks next/previous day
- THEN the displayed date changes accordingly

### Requirement: CI Pipeline MUST Enforce Tests

The CI pipeline MUST NOT pass if tests are missing or failing.

#### Scenario: CI fails with no tests

- GIVEN the project has no test files
- WHEN CI runs pytest
- THEN the CI pipeline MUST fail
- AND not use a fallback to pass

#### Scenario: CI fails with failing tests

- GIVEN tests exist but some fail
- WHEN CI runs the test suite
- THEN the CI pipeline MUST fail

### Requirement: Test Coverage Threshold

The backend MUST maintain at least 70% code coverage.

#### Scenario: Coverage below threshold fails CI

- GIVEN coverage report shows 60% coverage
- WHEN CI checks coverage
- THEN the CI pipeline MUST fail

## MODIFIED Requirements

### Requirement: Mypy Configuration

(Previously: mypy uses --ignore-missing-imports flag)

The project SHOULD have a mypy.ini file that:
- Properly configures paths for the app
- Uses strict settings where possible
- Is run in CI without ignore flags

### Requirement: Ruff Configuration

(Previously: Ruff uses default configuration)

The project SHOULD have a ruff.toml file that:
- Enables specific linting rules
- Configures formatting preferences
- Is run in CI

## REMOVED Requirements

### Requirement: Pytest Fallback

(Reason: The CI currently has a fallback that passes even when no tests exist. This defeats the purpose of having tests.)

The CI pipeline MUST NOT have any fallback mechanism that allows passing without tests.
