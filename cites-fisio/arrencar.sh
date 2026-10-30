#!/bin/bash

echo "Iniciant Gestor de CITES - Fisioteràpia..."

# Arrencar Eureka Server
echo "Arrencant Eureka Server (port 8761)..."
cd backend/eureka-server && ../mvnw spring-boot:run &
EUREKA_PID=$!

# Arrencar Cataleg Service
echo "Arrencant Cataleg Service (port 8082)..."
cd backend/cataleg-service && ../mvnw spring-boot:run &
CATALEG_PID=$!

# Arrencar Fisioterapeutes Service
echo "Arrencant Fisioterapeutes Service (port 8083)..."
cd backend/fisioterapeutes-svc && ../mvnw spring-boot:run &
FISIO_PID=$!

# Arrencar Especialitats Service
echo "Arrencant Especialitats Service (port 8084)..."
cd backend/especialitats-svc && ../mvnw spring-boot:run &
ESPECIALITATS_PID=$!

# Arrencar Cites Service
echo "Arrencant Cites Service (port 8085)..."
cd backend/cites-service && ../mvnw spring-boot:run &
CITES_PID=$!

# Arrencar Gateway
echo "Arrencant API Gateway (port 8080)..."
cd backend/gateway && ../mvnw spring-boot:run &
GATEWAY_PID=$!

# Esperar que tots els serveis s'hagin iniciat
sleep 5

echo ""
echo "=========================================="
echo "Serveis arrencats amb èxit!"
echo "=========================================="
echo "Eureka Server:     http://localhost:8761"
echo "API Gateway:       http://localhost:8080"
echo ""
echo "PID Eureka:  $EUREKA_PID"
echo "PID Cataleg: $CATALEG_PID"
echo "PID Fisio:   $FISIO_PID"
echo "PID Especialitats: $ESPECIALITATS_PID"
echo "PID Cites:   $CITES_PID"
echo "PID Gateway: $GATEWAY_PID"
echo "=========================================="

# Guardar PIDs en un fitxer per a l'atura
cat > /tmp/cites-fisio-pids.txt << PIDS
EUREKA_PID=$EUREKA_PID
CATALEG_PID=$CATALEG_PID
FISIO_PID=$FISIO_PID
ESPECIALITATS_PID=$ESPECIALITATS_PID
CITES_PID=$CITES_PID
GATEWAY_PID=$GATEWAY_PID
PIDS

echo ""
echo "Serveis executant-se en fons. Utilitzar 'aturar.sh' per aturar-los."
