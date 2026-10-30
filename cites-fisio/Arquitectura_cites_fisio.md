# Arquitectura del sistema - Gestor de cites per clínica de fisioteràpia

## Visió global

Arquitectura de microserveis amb:
- **Backend**: Maven multi mòdul amb 5 modules, Eureka Server i Gateway
- **Frontend**: Vue 3 con Vite, Router i Vitest
- **Comunicació**: REST HTTP entre components

## Components

```
┌─────────────────────────────────────────────────────────────┐
│                     EUREKA SERVER                            │
│              (backend/eureka-server)                         │
└─────────────────────────────────────────────────────────────┘
                              │
                              ▼
┌─────────────────────────────────────────────────────────────┐
│                    EUREKA CLIENTS                            │
│  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐      │
│  │cataleg-      │  │fisioterapeutes│  │cites-        │      │
│  │service       │  │service        │  │service       │      │
│  └──────────────┘  └──────────────┘  └──────────────┘      │
│  ┌──────────────┐  ┌──────────────┐                        │
│  │especialitats-│  │              │                        │
│  │service       │  │              │                        │
│  └──────────────┘  │              │                        │
│                    │              │                        │
│                    ▼              ▼                        │
│         (serveis interns sense Eureka client)               │
└─────────────────────────────────────────────────────────────┘
                              │
                              ▼
┌─────────────────────────────────────────────────────────────┐
│                   SPRING CLOUD GATEWAY                       │
│              (backend/gateway)                              │
│  Routes:                                                    │
│  - /api/especialitats → especialitats-service               │
│  - /api/fisioterapeutes → fisioterapeutes-service           │
│  - /api/cites → cites-service                               │
└─────────────────────────────────────────────────────────────┘
                              │
                              ▼
┌─────────────────────────────────────────────────────────────┐
│                    FRONTEND (Vue 3)                          │
│              Port: :5173                                     │
│  Proxy: /api → Gateway (:8080)                              │
└─────────────────────────────────────────────────────────────┘
```

## Ports

| Component            | Port  |
|----------------------|-------|
| eureka-server        | 8761  |
| cataleg-service      | 8082  |
| fisioterapeutes-svc  | 8083  |
| especialitats-svc    | 8084  |
| cites-service        | 8085  |
| gateway              | 8080  |
| frontend             | 5173  |

## Estructura del projecte

```
backend/
├── pom.xml                          # Aggregator POM
├── mvnw                            # Maven Wrapper
├── mvnw.cmd
├── eureka-server/                  # Module: Eureka Server
│   ├── pom.xml
│   └── src/main/java/...
├── cataleg-service/                # Module: Cataleg (internal)
│   ├── pom.xml
│   └── src/main/java/...
├── fisioterapeutes-svc/            # Module: Fisioterapeutes
│   ├── pom.xml
│   └── src/main/java/...
├── especialitats-svc/              # Module: Especialitats
│   ├── pom.xml
│   └── src/main/java/...
└── cites-service/                  # Module: Cites
    ├── pom.xml
    └── src/main/java/...

frontend/
├── package.json
├── vite.config.js
├── vitest.config.js
├── index.html
└── src/
    ├── App.vue
    ├── main.js
    └── router/
        └── index.js
```

## Dependències per mòdul

| Mòdul                  | Dependencies                                  |
|------------------------|-----------------------------------------------|
| eureka-server          | spring-cloud-starter-netflix-eureka-server    |
| cataleg-service        | spring-boot-starter-web                       |
| fisioterapeutes-svc    | spring-boot-starter-web                       |
| especialitats-svc      | spring-boot-starter-web                       |
| cites-service          | spring-boot-starter-web                       |
| gateway                | spring-cloud-starter-gateway, eureka-client   |

## Configuració clau

### Eureka Server (`eureka-server/application.yaml`)
```yaml
eureka:
  instance:
    prefer-ip-address: true
  client:
    register-with-eureka: false
    fetch-registry: false
server:
  port:
    application: 8761
```

### Gateway (`gateway/application.yaml`)
```yaml
spring:
  cloud:
    gateway:
      routes:
        - id: especialitats-service
          uri: lb://especialitats-svc
          predicates:
            - Path=/api/especialitats/**
        - id: fisioterapeutes-service
          uri: lb://fisioterapeutes-svc
          predicates:
            - Path=/api/fisioterapeutes/**
        - id: cites-service
          uri: lb://cites-service
          predicates:
            - Path=/api/cites/**

eureka:
  instance:
    prefer-ip-address: true
  client:
    serviceUrl:
      defaultZone: http://localhost:8761/eureka/
```

### Mòduls interns (`*-service/application.yaml`)
```yaml
server:
  port: 8082  # o el corresponent

eureka:
  instance:
    prefer-ip-address: true
  client:
    serviceUrl:
      defaultZone: http://localhost:8761/eureka/
```

## Regles d'arquitectura

### ARQ-01: Eureka Server és un sol component
Només `eureka-server` té `@EnableEurekaServer`. Els altres modules són clients o interns.

### ARQ-02: Gateway com a única entrada externa
Tots els accessos HTTP externs passen per `/api/**` → Gateway → Serveis.

### ARQ-03: Nomenament català sense «l·l»
Identificadors en català simplificat: `catalog`, `fisioterapeutes`, `especialitats`, `cites`.

### ARQ-04: Diners en cèntims
Tota la moneda interna utilitza unitats de 1 cèntim.

### ARQ-05: Dates ISO locals
Totes les dates utilitzen format ISO-8601 amb zona horària (e.g., `2026-10-02T10:30:00+02:00`).

## Test levels

| Nivell      | Objectiu                                      |
|-------------|-----------------------------------------------|
| Unit        | Classes individuals sense dependències externes |
| Integration | Components interactuant (Eureka, Gateway)     |
| End-to-end  | Fluxos complets d'usuari                      |

## Test doubles permès

- Mocks estàndard de Java
- Stubs manuels
- Fakes en memòria per a proves unitàries

## Comandes

```bash
# Backend
cd backend && ./mvnw verify              # Compilació i proves
cd backend && ./mvnw spring-boot:run -pl eureka-server  # Eureka Server

# Frontend
cd frontend && npm run dev               # Desenvolupament
cd frontend && npm run test:unit         # Proves unitàries

# Scripts de gestió
./scripts/arrencar.sh                    # Arrenca tot el sistema
./scripts/aturar.sh                      # Atura tot el sistema
./scripts/prova-de-fum.sh                # Smoke test
```

## Pitfalls

- Spring Boot 4: utilitza `spring-boot-starter-webflux` per a gateway, no `spring-boot-starter-web`
- Eureka clients requereixen temps de connexió adequats (5s default)
- El frontend proxy `/api` ha d'anar al Gateway port, no als serveis directament
