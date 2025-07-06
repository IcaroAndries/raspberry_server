# Configuração Automática do Servidor Raspberry Pi

## O que foi configurado

Sua Raspberry Pi foi configurada para:

exemplo de rede
1. **Conectar automaticamente ao WiFi**: Rede "Sweet Nova" com senha "12345678"
2. **Habilitar SSH**: Para acesso remoto
3. **Iniciar um servidor HTTP**: Na porta 8000 automaticamente

## Como funciona

### Conexão WiFi
- A Raspberry Pi se conectará automaticamente à rede "Sweet Nova"
- O país está configurado para Brasil (BR)

### Servidor HTTP
- Um servidor Python HTTP será iniciado automaticamente na porta 8000
- O servidor ficará disponível em: `http://[IP_DA_RASPBERRY]:8000`
- Uma página inicial será criada mostrando o status do servidor

### Logs
- Logs do servidor: `/home/pi/servidor/server.log`
- Log da configuração: `/home/pi/setup_complete.log`

## Como usar

### 1. Primeira inicialização
- Insira o cartão SD na Raspberry Pi
- Ligue a Raspberry Pi
- Aguarde 2-3 minutos para a configuração inicial

### 2. Descobrir o IP da Raspberry Pi
Você pode descobrir o IP da sua Raspberry Pi de várias formas:

**Opção 1: Pelo roteador**
- Acesse a interface do seu roteador
- Procure por dispositivos conectados
- Encontre a Raspberry Pi na lista

**Opção 2: Usando nmap (no seu computador)**
```bash
nmap -sn 192.168.1.0/24
```
(Substitua 192.168.1.0/24 pela sua rede)

**Opção 3: Usando o comando ping**
```bash
ping raspberrypi.local
```

### 3. Acessar o servidor
- Abra um navegador web
- Digite: `http://[IP_DA_RASPBERRY]:8000`
- Você verá a página inicial do servidor

### 4. Acessar via SSH (opcional)
```bash
ssh pi@[IP_DA_RASPBERRY]
```
Senha padrão: `raspberry`

## Personalização

### Alterar a porta do servidor
Edite o arquivo `/home/pi/start_server.sh` e altere a linha:
```bash
python3 -m http.server 8000
```
Para a porta desejada, exemplo:
```bash
python3 -m http.server 8080
```

### Adicionar arquivos ao servidor
- Coloque seus arquivos em `/home/pi/servidor/`
- Eles ficarão disponíveis via navegador

### Alterar a página inicial
- Edite o arquivo `/home/pi/servidor/index.html`
- Ou substitua por seu próprio arquivo HTML

## Comandos úteis

### Verificar status do servidor
```bash
systemctl status servidor-auto.service
```

### Parar o servidor
```bash
sudo systemctl stop servidor-auto.service
```

### Iniciar o servidor
```bash
sudo systemctl start servidor-auto.service
```

### Ver logs em tempo real
```bash
sudo journalctl -u servidor-auto.service -f
```

## Solução de problemas

### Servidor não inicia
1. Verifique se o serviço está habilitado:
   ```bash
   sudo systemctl is-enabled servidor-auto.service
   ```

2. Verifique os logs:
   ```bash
   sudo journalctl -u servidor-auto.service
   ```

### Não consegue acessar o servidor
1. Verifique se a Raspberry Pi está conectada à rede
2. Confirme o IP da Raspberry Pi
3. Verifique se a porta 8000 não está bloqueada pelo firewall

### Alterar configurações WiFi
Edite o arquivo `/etc/wpa_supplicant/wpa_supplicant.conf` ou use o arquivo `octopi-wpa-supplicant.txt` no cartão SD.

## Segurança

⚠️ **IMPORTANTE**: 
- Altere a senha padrão do usuário pi
- Configure um firewall se necessário
- Use conexões SSH com chave pública para maior segurança

## Contato

Para mais informações ou suporte, consulte a documentação oficial da Raspberry Pi.
