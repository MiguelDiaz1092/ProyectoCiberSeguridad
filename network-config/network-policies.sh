# Políticas de Seguridad - admin-server

# 1. Reglas de Firewall (UFW)
ufw default deny incoming
ufw default allow outgoing
ufw allow from 172.21.0.0/24 to any port 3306 proto tcp  # MySQL
ufw allow from 172.20.0.0/24 to any port 22 proto tcp    # SSH
ufw allow 80/tcp  # HTTP
ufw enable

# 2. Configuración de logs
mkdir -p /var/log/security
chmod 740 /var/log/security

# 3. Monitoreo de sistema
apt-get update && apt-get install -y \
    auditd \
    logwatch \
    rkhunter

# 4. Configuración de auditoría
auditctl -w /etc/passwd -p wa -k identity
auditctl -w /etc/group -p wa -k identity
auditctl -w /var/log/auth.log -p wa -k auth_log
