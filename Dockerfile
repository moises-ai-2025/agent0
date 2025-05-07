FROM ubuntu:22.04

# Instalar dependências
RUN apt-get update && apt-get install -y \
    curl \
    wget \
    unzip \
    ca-certificates \
    gnupg \
    lsb-release \
    sudo \
    jq

# Instalar Docker
RUN curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg \
    && echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
    $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null \
    && apt-get update \
    && apt-get install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin

# Criar diretório de trabalho
WORKDIR /app

# Baixar o instalador do Daytona usando wget em vez de curl (mais confiável)
RUN wget -O installer.zip https://github.com/daytonaio/installer/archive/refs/heads/main.zip \
    && unzip -q installer.zip \
    && ls -la \
    && cp -r installer-main*/* /app/ || cp -r daytona-installer-main*/* /app/ \
    && ls -la \
    && rm -rf installer.zip installer-main*

# Configurar variáveis de ambiente
ENV URL="your-domain.com"
ENV IDP="github"
ENV IDP_ID=""
ENV IDP_SECRET=""

# Criar script de inicialização personalizado
RUN echo '#!/bin/bash \n\
echo "Iniciando servidor Daytona com as seguintes configurações:" \n\
echo "URL: $URL" \n\
echo "IDP: $IDP" \n\
echo "IDP_ID: $IDP_ID" \n\
echo "Configurando..." \n\
URL="$URL" IDP="$IDP" IDP_ID="$IDP_ID" IDP_SECRET="$IDP_SECRET" ./setup.sh -y \n\
echo "Configuração concluída, mantendo o container em execução..." \n\
# Manter o container rodando \n\
tail -f /dev/null' > /app/start.sh

# Tornar o script executável
RUN chmod +x /app/start.sh

# Expor porta
EXPOSE 3000

# Iniciar
CMD ["/app/start.sh"]
