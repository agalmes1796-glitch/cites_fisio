# Testing Service

Esquelet de microservei dins l'arquitectura de microserveis del gestor de cites.

No implementa ninguna regla de negoci: serveix com a plantilla mínima
registrable a Eureka para verificar l'arquitectura i les eines del projecte.

## Què conté

- `TestingApplication` — arrencada Spring Boot amb client d'Eureka
- `TestingHealthController` — GET `/api/health` que respon amb el nom del servei i el seu estat
- Una prova de fum (`TestingApplicationTest`) que arrossega tot el context i verifica el punt de salut
- Sense bases de dades ni regles de negoci

## Execució

```bash
# Arrencar Eureka primer (port 8761), després:
cd backend
./mvnw spring-boot:run -pl testing
```

El servei escolta al port **8086**. Comprovar que està actiu:

```bash
curl http://localhost:8086/api/health
# {"servei":"testing","estat":"UP"}
```

## Proves

```bash
cd backend
./mvnw -pl testing verify
```

Les proves no necessiten un servidor Eureka en marxa (el client de
descoberta està desactivat dins la configuració de testes).
