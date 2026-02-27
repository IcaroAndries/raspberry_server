#!/bin/bash

# Script para iniciar servidor automaticamente na Raspberry Pi
# Este script será executado na inicialização

# Aguarda a conexão de rede
echo "Aguardando conexão de rede..."
while ! ping -c 1 google.com &> /dev/null; do
    echo "Sem conexão de rede, aguardando..."
    sleep 5
done

echo "Conexão de rede estabelecida!"

# Cria o diretório do servidor se não existir
mkdir -p /home/pi/servidor

# Navega para o diretório do servidor
cd /home/pi/servidor

# Cria um arquivo HTML simples se não existir
if [ ! -f index.html ]; then
    cat > index.html << 'EOF'
<!DOCTYPE html>
<html>
<head>
    <title>Servidor Raspberry Pi 3</title>
    <meta charset="UTF-8">
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 20px;
            text-align: center;
        }
        .container {
            max-width: 800px;
            margin: 0 auto;
            background-color: white;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }
        h1 {
            color: #333;
        }
        .info {
            background-color: #e7f3ff;
            padding: 15px;
            border-radius: 5px;
            margin: 20px 0;
        }
        .status {
            color: #008000;
            font-weight: bold;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>🍓 Servidor Raspberry Pi Ativo</h1>
        <div class="info">
            <p><strong>Status:</strong> <span class="status">Online</span></p>
            <p><strong>Data/Hora:</strong> <span id="datetime"></span></p>
            <p><strong>Servidor:</strong> Python HTTP Server</p>
        </div>
        <p>Seu servidor Raspberry Pi 3 está funcionando corretamente!</p>
        <p>Para acessar arquivos, navegue para diferentes diretórios na URL.</p>
    </div>
    
    <script>
        function updateDateTime() {
            const now = new Date();
            document.getElementById('datetime').textContent = now.toLocaleString();
        }
        updateDateTime();
        setInterval(updateDateTime, 1000);
    </script>
</body>
</html>
EOF
fi

# Obtém o IP da Raspberry Pi
IP=$(hostname -I | cut -d' ' -f1)

# Registra o início do servidor
echo "$(date): Iniciando servidor HTTP na porta 8000" >> /home/pi/servidor/server.log
echo "$(date): IP da Raspberry Pi: $IP" >> /home/pi/servidor/server.log

# Exibe informações no console
echo "==================================="
echo "Servidor iniciado com sucesso!"
echo "IP da Raspberry Pi: $IP"
echo "Acesse: http://$IP:8000"
echo "==================================="

# Inicia o servidor Python HTTP na porta 8000
python3 -m http.server 8000 >> /home/pi/servidor/server.log 2>&1
