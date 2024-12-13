#!/bin/bash
# Script de configuración avanzada de firewall
echo "Configurando reglas avanzadas de firewall..."
# Resetear reglas existentes
ufw --force reset
ufw default deny incoming
ufw default deny outgoing
# Protección contra ataques comunes
echo "Configurando protección contra ataques..."
# Protección contra SYN flood
iptables -A INPUT -p tcp --syn -m limit --limit 1/s --limit-burst 3 -j ACCEPT
# Protección contra escaneo de puertos
iptables -A INPUT -p tcp --tcp-flags ALL NONE -j DROP  # NULL scan
iptables -A INPUT -p tcp --tcp-flags ALL ALL -j DROP   # XMAS scan
# Reglas básicas anteriores
echo "Configurando reglas de acceso VLANs..."
# VLAN 10 - Administración
ufw allow from 172.20.0.0/24 to any port 22 proto tcp
ufw allow from 172.20.0.0/24 to 172.21.0.0/24
ufw allow from 172.20.0.0/24 to 172.22.0.0/24
# VLAN 20 - IT/Aplicaciones
ufw allow from 172.21.0.0/24 to any port 80 proto tcp
ufw allow from 172.21.0.0/24 to any port 443 proto tcp
ufw allow from 172.21.0.0/24 to any port 3306 proto tcp
ufw allow from 172.21.0.2 to 172.21.0.3 port 3306 proto tcp
# VLAN 30 - Operaciones
ufw allow from 172.22.0.0/24 to 172.21.0.2 port 80 proto tcp
ufw allow from 172.22.0.0/24 to 172.21.0.2 port 443 proto tcp
# Reglas adicionales de seguridad
echo "Configurando reglas adicionales de seguridad..."
# Limitar intentos de conexión SSH
ufw limit ssh
# Protección contra ataques de fuerza bruta
iptables -A INPUT -p tcp --dport 22 -m state --state NEW -m recent --set
iptables -A INPUT -p tcp --dport 22 -m state --state NEW -m recent --update --seconds 60 --hitcount 4 -j DROP
# Permitir conexiones establecidas
ufw allow established
# Permitir ping solo desde redes internas
ufw allow from 172.20.0.0/24 proto icmp
ufw allow from 172.21.0.0/24 proto icmp
ufw allow from 172.22.0.0/24 proto icmp
# Bloquear acceso a puertos privilegiados no utilizados
ufw deny 1:21/tcp
ufw deny 23:79/tcp
ufw deny 81:442/tcp
ufw deny 444:3305/tcp
ufw deny 3307:65535/tcp
# Configuración de logging avanzado
echo "Configurando logging avanzado..."
ufw logging high
iptables -A INPUT -j LOG --log-prefix "[UFW BLOCK] "
iptables -A FORWARD -j LOG --log-prefix "[UFW FORWARD] "
# Habilitar y verificar
echo "Habilitando firewall..."
ufw --force enable
echo "Verificando estado..."
ufw status verbose
# Guardar reglas de iptables
echo "Guardando reglas de iptables..."
iptables-save > /etc/iptables/rules.v4