#!/bin/bash

# Prova de fum per al Gestor de CITES - Fisioteràpia
# Verifica que tots els serveis s'hagin iniciat correctament i que les API responden

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

PASS=0
FAIL=0

echo ""
echo "=========================================="
echo "PROVA DE FUM - Gestor de CITES"
echo "=========================================="
echo ""

# Funció per verificar serveis
check_service() {
    local name=$1
    local port=$2
    local path=$3
    
    echo -n "Verificant $name (port $port)... "
    
    if curl -s --max-time 5 "http://localhost:$port$path" > /dev/null 2>&1; then
        echo -e "${GREEN}OK${NC}"
        ((PASS++))
        return 0
    else
        echo -e "${RED}NOCT${NC}"
        ((FAIL++))
        return 1
    fi
}

# Funció per verificar serveis amb Eureka
check_eureka_service() {
    local name=$1
    local service_id=$2
    
    echo -n "Verificant $name a Eureka... "
    
    if curl -s "http://localhost:8761/eureka/apps" | grep -q "$service_id"; then
        echo -e "${GREEN}OK${NC}"
        ((PASS++))
        return 0
    else
        echo -e "${RED}NOCT${NC}"
        ((FAIL++))
        return 1
    fi
}

echo "Etapa 1: Verificació de serveis individualment"
echo "----------------------------------------------"

check_service "Cataleg Service" 8082 "/"
check_service "Fisioterapeutes Service" 8083 "/"
check_service "Especialitats Service" 8084 "/"
check_service "Cites Service" 8085 "/"
check_service "Gateway" 8080 "/"

echo ""
echo "Etapa 2: Verificació a Eureka Server"
echo "------------------------------------"

check_eureka_service "cataleg-service" "cataleg-service"
check_eureka_service "fisioterapeutes-svc" "fisioterapeutes-svc"
check_eureka_service "especialitats-svc" "especialitats-svc"
check_eureka_service "cites-service" "cites-service"

echo ""
echo "Etapa 3: Verificació de routes del Gateway"
echo "------------------------------------------"

check_service "Gateway - Cites" 8080 "/api/cites/"
check_service "Gateway - Especialitats" 8080 "/api/especialitats/"
check_service "Gateway - Fisioterapeutes" 8080 "/api/fisioterapeutes/"
check_service "Gateway - Cataleg" 8080 "/api/cataleg/"

echo ""
echo "=========================================="
echo "RESULTATS DE LA PROVA DE FUM"
echo "=========================================="
echo -e "Serveis funcionals: ${GREEN}$PASS${NC}"
echo -e "Errors: ${RED}$FAIL${NC}"
echo ""

if [ $FAIL -eq 0 ]; then
    echo -e "${GREEN}TOTES LES PROVES S'HAN PASSAT!${NC}"
    exit 0
else
    echo -e "${YELLOW}ALGUNA PROVA HA FALLAT. Revisar els logs.${NC}"
    exit 1
fi
