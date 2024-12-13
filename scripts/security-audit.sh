# security-audit.sh
#!/bin/bash
# Script para auditoría de seguridad

echo "Iniciando auditoría de seguridad..."

# Verificar configuración de firewall
ufw status > /var/log/security/firewall_status.log

# Verificar usuarios y permisos
cat /etc/passwd > /var/log/security/users.log
cat /etc/group > /var/log/security/groups.log

# Verificar servicios en ejecución
ps aux > /var/log/security/running_services.log

echo "Auditoría completada. Revise los logs."