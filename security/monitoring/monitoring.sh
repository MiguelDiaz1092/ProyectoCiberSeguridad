#!/bin/bash
# Script para configurar monitoreo y logs

echo "Iniciando configuración de monitoreo..."

# Crear directorios necesarios
mkdir -p /var/spool/cron/crontabs
mkdir -p /var/log/apache2
mkdir -p /var/log/mysql
touch /var/log/auth.log

# Instalar herramientas de monitoreo
apt-get update
apt-get install -y fail2ban logwatch auditd sysstat

# Crear directorio para fail2ban si no existe
mkdir -p /etc/fail2ban
mkdir -p /var/run/fail2ban

# Configurar Fail2ban
cat > /etc/fail2ban/jail.local << EOF
[DEFAULT]
bantime = 3600
findtime = 600
maxretry = 3

[docker-action]
enabled = true
filter = docker-action
logpath = /var/log/auth.log
maxretry = 3
EOF

# Crear filtro personalizado para fail2ban
mkdir -p /etc/fail2ban/filter.d
cat > /etc/fail2ban/filter.d/docker-action.conf << EOF
[Definition]
failregex = Failed .* from <HOST>
ignoreregex =
EOF

# Configurar logrotate
mkdir -p /etc/logrotate.d
cat > /etc/logrotate.d/custom-logs << EOF
/var/log/auth.log
/var/log/mysql/error.log
/var/log/docker.log {
    weekly
    rotate 4
    compress
    delaycompress
    missingok
    notifempty
    create 640 root root
}
EOF

# Configurar script de alertas
cat > /usr/local/bin/check-alerts.sh << EOF
#!/bin/bash
# Revisar uso de disco
DISK_USAGE=\$(df / | tail -1 | awk '{print \$5}' | sed 's/%//')
if [ \$DISK_USAGE -gt 85 ]; then
    echo "Uso de disco alto: \$DISK_USAGE%" >> /var/log/alerts.log
fi

# Revisar memoria
MEM_USAGE=\$(free | grep Mem | awk '{print \$3/\$2 * 100.0}')
if [ \$(echo "\$MEM_USAGE > 90" | bc) -eq 1 ]; then
    echo "Uso de memoria alto: \$MEM_USAGE%" >> /var/log/alerts.log
fi
EOF

chmod +x /usr/local/bin/check-alerts.sh

# Crear crontab si no existe
touch /var/spool/cron/crontabs/root
chmod 600 /var/spool/cron/crontabs/root
echo "*/5 * * * * /usr/local/bin/check-alerts.sh" >> /var/spool/cron/crontabs/root

# Iniciar servicios si están disponibles
if command -v fail2ban-server >/dev/null 2>&1; then
    service fail2ban start || echo "Fail2ban no pudo iniciarse"
fi

if command -v auditd >/dev/null 2>&1; then
    service auditd start || echo "Auditd no pudo iniciarse"
fi

echo "Configuración de monitoreo completada"