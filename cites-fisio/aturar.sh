#!/bin/bash

echo "Aturant Gestor de CITES - Fisioteràpia..."

# Carregar PIDs guardats
if [ -f /tmp/cites-fisio-pids.txt ]; then
    source /tmp/cites-fisio-pids.txt
else
    echo "Fitxer de PIDs no trobat. Intentant aturar processos per port..."
    
    # Alternativa: aturar per PID si el fitxer no existeix
    EUREKA_PID=$(lsof -ti:8761 2>/dev/null | head -1)
    CATALEG_PID=$(lsof -ti:8082 2>/dev/null | head -1)
    FISIO_PID=$(lsof -ti:8083 2>/dev/null | head -1)
    ESPECIALITATS_PID=$(lsof -ti:8084 2>/dev/null | head -1)
    CITES_PID=$(lsof -ti:8085 2>/dev/null | head -1)
    GATEWAY_PID=$(lsof -ti:8080 2>/dev/null | head -1)
fi

# Aturar cada servei
echo "Aturant Eureka Server (port 8761)..."
if [ -n "$EUREKA_PID" ] && kill -0 "$EUREKA_PID" 2>/dev/null; then
    kill "$EUREKA_PID" 2>/dev/null
    sleep 1
fi

echo "Aturant Cataleg Service (port 8082)..."
if [ -n "$CATALEG_PID" ] && kill -0 "$CATALEG_PID" 2>/dev/null; then
    kill "$CATALEG_PID" 2>/dev/null
    sleep 1
fi

echo "Aturant Fisioterapeutes Service (port 8083)..."
if [ -n "$FISIO_PID" ] && kill -0 "$FISIO_PID" 2>/dev/null; then
    kill "$FISIO_PID" 2>/dev/null
    sleep 1
fi

echo "Aturant Especialitats Service (port 8084)..."
if [ -n "$ESPECIALITATS_PID" ] && kill -0 "$ESPECIALITATS_PID" 2>/dev/null; then
    kill "$ESPECIALITATS_PID" 2>/dev/null
    sleep 1
fi

echo "Aturant Cites Service (port 8085)..."
if [ -n "$CITES_PID" ] && kill -0 "$CITES_PID" 2>/dev/null; then
    kill "$CITES_PID" 2>/dev/null
    sleep 1
fi

echo "Aturant API Gateway (port 8080)..."
if [ -n "$GATEWAY_PID" ] && kill -0 "$GATEWAY_PID" 2>/dev/null; then
    kill "$GATEWAY_PID" 2>/dev/null
    sleep 1
fi

# Eliminar fitxer de PIDs
rm -f /tmp/cites-fisio-pids.txt

echo ""
echo "Tots els serveis han estat aturats."
echo ""

# Verificar quins processos queden
echo "Verificant ports encara en ús..."
lsof -i :8761 -i :8082 -i :8083 -i :8084 -i :8085 -i :8080 2>/dev/null || echo "Tots els ports estan lliures."
