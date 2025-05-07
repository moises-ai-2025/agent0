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

# Expor apenas a porta 3000 (padrão do Railway)
EXPOSE 3000

# Iniciar diretamente o servidor Express
CMD ["npm", "start"]
