#!/bin/bash

# Script para verificar atualizações no branch prod e reiniciar o bot
# Deve ser rodado via cron (ex: a cada 5 minutos)

BOT_DIR="/home/pi/bot"
LOG_FILE="/home/pi/bot_update.log"

cd "$BOT_DIR" || exit

# Verifica por mudanças no branch prod
git fetch origin prod
LOCAL=$(git rev-parse HEAD)
REMOTE=$(git rev-parse origin/prod)

if [ "$LOCAL" != "$REMOTE" ]; then
    echo "$(date): Mudanças detectadas no branch prod. Atualizando..." >> "$LOG_FILE"
    
    # Faz o pull das alterações
    git pull origin prod >> "$LOG_FILE" 2>&1
    
    # Reinstala dependências e faz o build
    echo "$(date): Reinstalando dependências..." >> "$LOG_FILE"
    npm install >> "$LOG_FILE" 2>&1
    
    echo "$(date): Executando build..." >> "$LOG_FILE"
    npm run build >> "$LOG_FILE" 2>&1
    
    # Reinicia o serviço do bot
    echo "$(date): Reiniciando serviço discord-bot..." >> "$LOG_FILE"
    sudo systemctl restart discord-bot.service
    
    echo "$(date): Bot atualizado com sucesso!" >> "$LOG_FILE"
else
    # echo "$(date): Nenhuma mudança detectada." >> "$LOG_FILE"
    exit 0
fi
