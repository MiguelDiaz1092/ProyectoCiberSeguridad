FROM debian:bullseye-slim

# Configurar instalación no interactiva
ENV DEBIAN_FRONTEND=noninteractive

# Pre-configurar wireshark-common para instalación no interactiva
RUN echo "wireshark-common wireshark-common/install-setuid boolean true" | debconf-set-selections

# Actualizar e instalar herramientas básicas y de seguridad
RUN apt-get update && apt-get install -y \
    net-tools \
    iputils-ping \
    iproute2 \
    iptables \
    openssh-server \
    nano \
    vim \
    curl \
    sudo \
    nmap \
    tcpdump \
    wireshark \
    fail2ban \
    ufw \
    telnet \
    netcat \
    && rm -rf /var/lib/apt/lists/*

# Configurar SSH
RUN mkdir /var/run/sshd
RUN echo 'root:Admin123Secure!' | chpasswd
RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config

# Preparar UFW
COPY ufw.conf /etc/ufw/
RUN mkdir -p /etc/ufw/applications.d

# Configurar Fail2ban
COPY fail2ban.conf /etc/fail2ban/jail.local

# Copiar scripts de firewall
COPY firewall-scripts/firewall-rules.sh /usr/local/bin/
COPY firewall-scripts/firewall-verify.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/firewall-rules.sh /usr/local/bin/firewall-verify.sh

# Script de inicio
COPY start.sh /start.sh
RUN chmod +x /start.sh

EXPOSE 22

CMD ["/start.sh"]