# Instruccions per a assistents d'IA en aquest repositori

## Font de la veritat

El document `docs/requisits.md` és la font de la veritat. No inventeu regles: les preguntes van al Product Owner.

## TDD estricte

- Cap codi de producció sense una prova fallida abans
- Una prova a la vegada
- Comproveu que falla per la raó esperada
- Còdi mínim per fer-la passar
- Refactoritze només verd (green)
- Mai modifiqueu una prova per fer-la passar
- Commiteu només en verd

## Convencions

- Identificadors en català sense el punt mitjà de «l·l» (`cancelar`, no `cancel·lar`)
- Diners en cèntims
- Dates ISO locals (sense Z timezone indicator)
- Errors llançats com a `ErrorDeCita` amb un `codi` del catàleg d'errors dels requisits

## Proves

Proves sense `vi.mock`, `vi.fn`, `vi.spyOn` o `vi.useFakeTimers`.

## Estructura

Backend (Java/Spring Boot 4 - Maven multi-mòdul):
- `backend/pom.xml` (aggregator)
- `backend/eureka-server/` - Servei de descobriment
- `backend/cataleg-service/` - Catàleg bàsic (sense Eureka)
- `backend/fisioterapeutes-svc/` - Microservei: Fisioterapeutes
- `backend/especialitats-svc/` - Microservei: Especialitats  
- `backend/cites-service/` - Microservei principal: Cites (H2 + JPA)
- `backend/gateway/` - API Gateway

Frontend (Vue 3 + Vite):
- `frontend/src/fisio.js` (producció)
- `frontend/tests/escenari.js` (ajudants de prova)
- `frontend/tests/*.test.js` (proves)
- `frontend/docs/requisits.md` (requisits frontend)

## Comandes

Backend:
- `cd backend && mvnw verify` - Executa totes les proves amb cobertura
- `cd backend && mvnw verify -DskipTests` - Salta les proves

Frontend:
- `cd frontend && npm test` - Executa totes les proves
- `cd frontend && npm run test:watch` - Mode de vigilança

## Arquitectura

El projecte segueix una arquitectura de microserveis amb:
- Eureka Server per a descobriment de serveis
- Spring Cloud Gateway com a punt d'entrada únic
- Cada microservei registrat a Eureka (excepte cataleg-service)
- Frontend Vue 3 que consumeix les API a través del Gateway

## Ports dels serveis

| Servei | Port | URL |
|--------|------|-----|
| Eureka Server | 8761 | http://localhost:8761/eureka |
| Cataleg Service | 8082 | http://localhost:8082 |
| Fisioterapeutes Service | 8083 | http://localhost:8083 |
| Especialitats Service | 8084 | http://localhost:8084 |
| Cites Service | 8085 | http://localhost:8085 |
| API Gateway | 8080 | http://localhost:8080 |

🤖 Generat amb [Claude Code](https://claude.com/claude-code)
