# Proposal: Mejoras NutricIA - Calidad y Testing

## Intent

El proyecto NutricIA tiene una arquitectura sólida pero carece de tests y tiene issues de calidad críticos que impiden considerarlo production-ready. Este cambio aborda la deuda técnica más urgente: ausencia total de tests, CI con configuración débil, y componentes duplicados.

## Scope

### In Scope
1. **Agregar tests al backend**
   - Tests unitarios para casos de uso (auth, meals, habits, analytics, users)
   - Tests de integración para endpoints API críticos
   - Configuración de pytest completa (pytest.ini, conftest.py)

2. **Corregir CI fallback de tests**
   - Eliminar el fallback que hace pasar el CI sin tests
   - Fallar si no hay tests o si coverage es bajo

3. **Eliminar componentes duplicados**
   - Unificar meal-card.tsx en una sola ubicación
   - Unificar date-selector.tsx en una sola ubicación

4. **Configurar herramientas de calidad**
   - mypy.ini con configuración estricta
   - ruff.toml con reglas personalizadas

5. **Tests de frontend**
   - Tests básicos de componentes críticos

### Out of Scope
- Migración de submodules a mono-repo (futuro)
- Implementación de rate limiting (futuro)
- Cobertura completa de código (se establece mínimo 70%)

## Approach

1. **Backend Tests**: Usar pytest con fixtures para DB, auth tokens y factories para modelos
2. **Frontend Tests**: Vitest + React Testing Library para componentes
3. **CI Fix**: Cambiar el fallback de pytest para que requiera tests
4. **Deduplicación**: Eliminar archivos duplicados y actualizar imports
5. **Config**: Crear archivos de configuración faltantes

## Affected Areas

| Area | Impact | Description |
|------|--------|-------------|
| `backend/app/` | Modified | Casos de uso necesitan tests |
| `backend/tests/` | New | Carpeta de tests a crear |
| `frontend/components/shared/` | Modified | Componentes duplicados a eliminar |
| `frontend/shared/components/` | Modified | Destino de componentes unificados |
| `.github/workflows/ci.yml` | Modified | Corregir fallback de tests |
| `pytest.ini` | New | Configuración de pytest |
| `mypy.ini` | New | Configuración de tipos |
| `ruff.toml` | New | Configuración de linter |
| `package.json` | Modified | Añadir scripts de test |

## Risks

| Risk | Likelihood | Mitigation |
|------|------------|------------|
| Tests rotos inicialmente | High | Escribir tests mínimos que pasen primero |
| Duplicación de imports tras merge | Medium | Verificar después de eliminar duplicados |
| CI falla al quitar fallback | Low | Asegurar que hay tests antes de cambiar CI |

## Rollback Plan

1. Revertir cambios en ci.yml para restaurar fallback
2. Eliminar carpeta tests/ si hay problemas
3. Restaurar componentes duplicados desde git
4. Eliminar archivos de configuración nuevos

## Dependencies

- Ninguna dependencia externa

## Success Criteria

- [ ] Backend tiene al menos 20 tests cubriendo casos de uso principales
- [ ] CI falla si no hay tests (sin fallback)
- [ ] No hay archivos duplicados en frontend/components y frontend/shared/components
- [ ] mypy.ini existe y se ejecuta en CI
- [ ] ruff.toml existe y se ejecuta en CI
- [ ] Coverage de backend >= 70%
