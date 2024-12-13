#!/bin/bash
# Script para implementar políticas de contraseñas y seguridad

# Configurar política de contraseñas en admin-server
echo "Configurando políticas de contraseñas..."

# Ajustar parámetros de contraseñas en PAM
cat > /etc/pam.d/common-password << EOF
password        requisite       pam_cracklib.so retry=3 minlen=12 difok=3 ucredit=-1 lcredit=-1 dcredit=-1 ocredit=-1
password        [success=1 default=ignore]      pam_unix.so obscure use_authtok try_first_pass sha512
EOF

# Configurar caducidad de contraseñas
chage --maxdays 90 --mindays 1 --warndays 7 root

# Configurar límites de intentos fallidos
cat > /etc/pam.d/common-auth << EOF
auth    required            pam_tally2.so deny=5 unlock_time=1800
auth    [success=1 default=ignore]    pam_unix.so nullok_secure
EOF

# Configurar auditoría de autenticación
cat > /etc/audit/rules.d/audit.rules << EOF
-w /etc/passwd -p wa -k identity
-w /etc/group -p wa -k identity
-w /etc/shadow -p wa -k identity
-w /var/log/auth.log -p wa -k auth_log
EOF

# Reiniciar servicio de auditoría
service auditd restart

echo "Políticas de contraseñas y seguridad configuradas."
