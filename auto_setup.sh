#!/bin/bash

# Script final de configuração automática
# Executa apenas uma vez para configurar tudo

LOG_FILE="/home/pi/auto_setup.log"
SETUP_DONE="/home/pi/.setup_done"

# Verifica se já foi executado
if [ -f "$SETUP_DONE" ]; then
    echo "Setup já foi executado. Saindo..."
    exit 0
fi

echo "$(date): Iniciando configuração automática..." >> "$LOG_FILE"

# Aguarda rede estar disponível
echo "$(date): Aguardando conexão de rede..." >> "$LOG_FILE"
while ! ping -c 1 8.8.8.8 > /dev/null 2>&1; do
    sleep 5
done

echo "$(date): Rede conectada!" >> "$LOG_FILE"

# Atualiza o sistema
echo "$(date): Atualizando sistema..." >> "$LOG_FILE"
apt update >> "$LOG_FILE" 2>&1

# Instala dependências
echo "$(date): Instalando dependências..." >> "$LOG_FILE"
apt install -y python3 python3-pip >> "$LOG_FILE" 2>&1

# Cria diretório do servidor
mkdir -p /home/pi/servidor
chown pi:pi /home/pi/servidor

# Copia e configura o script do servidor
cp /boot/start_server.sh /home/pi/start_server.sh
chmod +x /home/pi/start_server.sh
chown pi:pi /home/pi/start_server.sh

# Copia e configura o serviço systemd
cp /boot/servidor-auto.service /etc/systemd/system/
systemctl daemon-reload
systemctl enable servidor-auto.service

# Habilita SSH
systemctl enable ssh

# Configura timezone para Brasil
timedatectl set-timezone America/Sao_Paulo

# Marca como concluído
touch "$SETUP_DONE"
echo "$(date): Configuração concluída!" >> "$LOG_FILE"

echo "$(date): Reiniciando sistema..." >> "$LOG_FILE"
reboot
