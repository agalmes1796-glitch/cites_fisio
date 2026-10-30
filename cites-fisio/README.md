# Gestor de CITES - Fisioteràpia 🏋️‍♂️💆

[![Java](https://img.shields.io/badge/Java-25-orange.svg)](https://www.oracle.com/java/)
[![Spring Boot](https://img.shields.io/badge/Spring_Boot-4.0.3-green.svg)](https://spring.io/projects/spring-boot)
[![Vue](https://img.shields.io/badge/Vue-3-blue.svg)](https://vuejs.org/)
[![License](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)

## 🏗️ Arquitectura de Microserveis

Aquest projecte implementa una arquitectura de microserveis per a la gestió de cites de fisioteràpia, desenvolupat amb:

### Backend (Java/Spring Boot 4)
- **Eureka Server** (`eureka-server`): Servei de descobriment de serveis (port 8761)
- **API Gateway** (`gateway`): Punt d'entrada únic que enruta sol·licituds als microserveis (port 8080)
- **Microserveis**:
  - `cataleg-service`: Catàleg bàsic (port 8082) - sense Eureka
  - `fisioterapeutes-svc`: Gestió de fisioterapeutes (port 8083)
  - `especialitats-svc`: Gestió d'especialitats (port 8084)
  - `cites-service`: Gestió de cites amb H2 i JPA (port 8085)

### Frontend (Vue 3 + Vite)
- Aplicació SPA amb Vue 3, Router i Vitest per a proves
- Consumi les API mitjançant l'API Gateway

## 🚀 Instal·lació

### Requisits
- Java 25
- Maven 3.9+
- Node.js 18+
- npm o pnpm

### Pas 1: Configurar Backend

```bash
cd backend
mvnw clean install
mvnw verify
```

### Pas 2: Configurar Frontend

```bash
cd frontend
npm install
npm test
```

## 🎯 Arrencar l'aplicació

### Opció A: Arrencar tots els serveis automàticament

```bash
./arrencar.sh
```

Això iniciarà tots els serveis en fons:
- Eureka Server (8761)
- Cataleg Service (8082)
- Fisioterapeutes Service (8083)
- Especialitats Service (8084)
- Cites Service (8085)
- API Gateway (8080)

### Opció B: Arrencar serveis individualment

```bash
# Backend
cd backend/eureka-server && mvnw spring-boot:run
cd backend/cataleg-service && mvnw spring-boot:run
cd backend/fisioterapeutes-svc && mvnw spring-boot:run
cd backend/especialitats-svc && mvnw spring-boot:run
cd backend/cites-service && mvnw spring-boot:run
cd backend/gateway && mvnw spring-boot:run

# Frontend (en una altra terminal)
cd frontend
npm run dev
```

### Aturar l'aplicació

```bash
./aturar.sh
```

## 🧪 Proves

### Backend

```bash
cd backend
mvnw verify              # Executa totes les proves amb cobertura
mvnw verify -DskipTests  # Salta les proves
```

### Frontend

```bash
cd frontend
npm test                 # Executa totes les proves
npm run test:watch      # Mode de vigilança (reexecuta en canviar fitxers)
```

## 🧪 Prova de Fum

```bash
./prova-de-fum.sh
```

Verifica que tots els serveis s'han iniciat correctament i que les API respondes.

## 🔗 Punts d'entrada

| Componente | URL | Port |
|------------|-----|------|
| API Gateway (principal) | http://localhost:8080 | 8080 |
| Eureka Server | http://localhost:8761/eureka | 8761 |
| Documentation (Swagger) | http://localhost:8080/swagger-ui.html | 8080 |

## 📁 Estructura del projecte

```
cites-fisio/
├── README.md                    # Aquest fitxer
├── arrencar.sh                  # Script per arrencar tots els serveis
├── aturar.sh                    # Script per aturar tots els serveis
├── prova-de-fum.sh             # Prova de fum automàtica
├── backend/                     # Microserveis Java/Spring Boot
│   ├── pom.xml                 # POM agregador
│   ├── mvnw                    # Maven wrapper
│   ├── eureka-server/          # Servei de descobriment (Eureka Server)
│   ├── cataleg-service/        # Catàleg bàsic (sense Eureka)
│   ├── fisioterapeutes-svc/    # Microservei: Fisioterapeutes
│   ├── especialitats-svc/      # Microservei: Especialitats
│   ├── cites-service/          # Microservei principal: Cites (H2 + JPA)
│   └── gateway/                # API Gateway (Spring Cloud Gateway)
└── frontend/                   # Aplicació Vue 3
    ├── package.json
    ├── vite.config.ts
    ├── index.html
    └── src/
        ├── main.js             # Router i routes
        ├── App.vue
        ├── views/              # Vistes principals
        └── __tests__/         # Proves Vitest
```

## 🛠️ Desenvolupament

### Configuració de l'entorn de desenvolupament

1. **Backend**: Arrencar tots els serveis amb `./arrencar.sh`
2. **Frontend**: Arrencar el dev server amb `npm run dev` al directori frontend

### Hot Reload

- Backend: Spring Boot ja inclou hot reload per a canvis en codi Java
- Frontend: Vite inclou hot reload automàtic per a canvis en JavaScript/Vue

## 📝 Convencions del projecte

- **Identificadors**: En català sense «l·l» (`cancelar`, no `cancel·lar`)
- **Moneda**: En cèntims (no flotants)
- **Dates**: ISO locals (sense Z timezone indicator)
- **Errors**: Com a `ErrorDeCita` amb un codi del catàleg d'errors
- **Proves**: Sense `vi.mock`, `vi.fn`, `vi.spyOn` o `vi.useFakeTimers`

## 📄 Llicència

MIT License

🤖 Generat amb [Claude Code](https://claude.com/claude-code)
