FROM node:18-slim

# Criar diretório de trabalho
WORKDIR /app

# Configurar variáveis de ambiente
ENV PORT=3000
ENV URL="your-domain.com"
ENV GITHUB_CLIENT_ID=""
ENV GITHUB_CLIENT_SECRET=""

# Copiar arquivos de configuração
COPY package.json /app/
COPY server.js /app/

# Instalar dependências
RUN npm install

# Expor porta
EXPOSE 3000

# Criar um script de inicialização mais robusto
RUN echo '#!/bin/bash\n\
echo "Iniciando servidor Daytona simulado..."\n\
node server.js\n\
echo "Processo do servidor encerrado, mantendo container ativo para debug"\n\
tail -f /dev/null' > /app/start.sh && chmod +x /app/start.sh

# Iniciar usando o script
CMD ["/app/start.sh"]
