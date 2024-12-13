#!/bin/bash
# Script para configurar cifrado de datos

# Instalar herramientas necesarias
apt-get update
apt-get install -y openssl apache2-utils

# Configurar SSL/TLS para la comunicación web
mkdir -p /etc/ssl/private
openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -keyout /etc/ssl/private/server.key \
    -out /etc/ssl/certs/server.crt \
    -subj "/C=CO/ST=State/L=City/O=Organization/CN=server"

# Configurar MySQL para usar SSL
cat > /etc/mysql/conf.d/ssl.cnf << EOF
[mysqld]
ssl-cert=/etc/ssl/certs/server.crt
ssl-key=/etc/ssl/private/server.key
require_secure_transport=ON
EOF

# Cifrar backups automáticamente
cat > /usr/local/bin/backup-encrypt.sh << EOF
#!/bin/bash
BACKUP_DIR="/var/backups/db"
mkdir -p \$BACKUP_DIR
DATE=\$(date +%Y%m%d)
mysqldump tienda_db | gpg -c > \$BACKUP_DIR/backup-\$DATE.sql.gpg
find \$BACKUP_DIR -type f -mtime +7 -delete
EOF

chmod +x /usr/local/bin/backup-encrypt.sh

# Agregar al crontab
echo "0 2 * * * /usr/local/bin/backup-encrypt.sh" >> /var/spool/cron/crontabs/root

echo "Configuración de cifrado completada"
