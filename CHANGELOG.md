# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added

- Clean Architecture backend with domain/application/infrastructure/presentation layers
- Feature-based frontend architecture with services/hooks/stores per module
- Docker Compose development stack (PostgreSQL, pgAdmin, Backend, Frontend)
- Makefile with development, testing, and deployment commands
- Open source setup: LICENSE (MIT), CONTRIBUTING, CODE_OF_CONDUCT, SECURITY
- GitHub issue templates and PR template
- CI/CD pipeline with GitHub Actions
- Environment variable management (.env files for root, backend, frontend)
- Git submodules for backend and frontend repositories

### Changed

- Reorganized backend modules from flat router/service/schemas to Clean Architecture layers
- Reorganized frontend from monolithic screens to feature-based modules
- Improved analytics queries (single SQL query instead of N+1)

### Fixed

- Apple OAuth verification (now uses full JWKS verification)
- MealType validation (added enum constraint)
- Dark mode issues in MealCard and Journal components

## [0.1.0] - 2026-02-27

### Added

- Initial project structure
- FastAPI backend with auth, meals, habits, analytics, users modules
- React Native (Expo) frontend with dashboard, scanner, journal, garden screens
- AI-powered food analysis with Gemini and OpenAI providers
- OAuth authentication (Google, Apple)
- Gamified habit tracking with streak system
- Water intake tracking
- Nutritional analytics (daily, weekly, monthly)
