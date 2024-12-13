#!/bin/bash

# Iniciar servicios
service ssh start
service fail2ban start

# Configurar firewall
/usr/local/bin/firewall-rules.sh

# Log de inicio
echo "[$(date)] Container started" >> /var/log/admin-server.log
echo "[$(date)] Running firewall verification..." >> /var/log/admin-server.log
/usr/local/bin/firewall-verify.sh >> /var/log/admin-server.log

# Mantener el contenedor corriendo
tail -f /var/log/admin-server.log