#!/bin/bash

# Script para configuração na primeira inicialização
# Este arquivo será executado apenas uma vez

SETUP_COMPLETE="/home/pi/setup_complete.log"

# Verifica se a configuração já foi executada
if [ ! -f "$SETUP_COMPLETE" ]; then
    echo "Executando configuração inicial..."
    
    # Executa o script de configuração
    /boot/setup_servidor.sh
    
    # Marca como concluído
    echo "$(date): Primeira configuração executada" > "$SETUP_COMPLETE"
else
    echo "Configuração já foi executada anteriormente."
fi
