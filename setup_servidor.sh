#!/bin/bash

# Script de configuração inicial da Raspberry Pi
# Este script configura tudo automaticamente na primeira inicialização

echo "=== Configuração do Servidor Raspberry Pi ==="

# Cria o diretório home do usuário pi se não existir
mkdir -p /home/pi

# Copia o script do servidor para o diretório home
cp /boot/start_server.sh /home/pi/start_server.sh
chmod +x /home/pi/start_server.sh

# Copia o arquivo de serviço para o systemd
cp /boot/servidor-auto.service /etc/systemd/system/servidor-auto.service

# Atualiza o sistema
echo "Atualizando sistema..."
apt update

# Instala dependências se necessário
echo "Instalando dependências..."
apt install -y python3 python3-pip

# Recarrega o systemd
systemctl daemon-reload

# Habilita o serviço para iniciar automaticamente
systemctl enable servidor-auto.service

# Configura o WiFi country code para Brasil
echo "Configurando WiFi..."
sed -i 's/country=GB/country=BR/' /etc/wpa_supplicant/wpa_supplicant.conf

# Cria um arquivo de status para indicar que a configuração foi concluída
echo "$(date): Configuração inicial concluída" > /home/pi/setup_complete.log

echo "=== Configuração concluída! ==="
echo "Reiniciando em 10 segundos..."
sleep 10
reboot
