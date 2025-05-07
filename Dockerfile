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

# Iniciar
CMD ["npm", "start"]
