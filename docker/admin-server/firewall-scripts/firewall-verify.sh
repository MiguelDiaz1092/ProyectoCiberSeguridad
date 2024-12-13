#!/bin/bash
# Script para verificar la configuración del firewall

echo "=== Verificación de Reglas de Firewall ==="

# Verificar estado del firewall
echo -e "\n1. Estado del Firewall:"
ufw status numbered

# Verificar conexiones activas
echo -e "\n2. Conexiones Activas:"
netstat -tunlp

# Verificar reglas de iptables
echo -e "\n3. Reglas de iptables detalladas:"
iptables -L -v -n

# Verificar puertos abiertos
echo -e "\n4. Puertos escuchando:"
ss -tuln

# Verificar logs de firewall
echo -e "\n5. Últimas entradas del log del firewall:"
tail -n 20 /var/log/ufw.log

# Verificar conectividad entre VLANs
echo -e "\n6. Pruebas de conectividad:"
echo "Probando conexión a servidor de aplicaciones..."
nc -zv 172.21.0.2 80
echo "Probando conexión a base de datos..."
nc -zv 172.21.0.3 3306

echo -e "\n=== Verificación Completada ===

