# Daytona Simulado no Railway

Este repositório contém os arquivos necessários para implantar um servidor simulado que emula as funcionalidades básicas do Daytona no Railway.

## Sobre esta abordagem

Em vez de tentar implantar um servidor Daytona completo (que pode ser complexo para auto-hospedar), criamos uma solução simplificada que emula as principais funcionalidades do Daytona através de uma aplicação Node.js/Express. Esta abordagem permite:

- Rápida implantação no Railway
- Maior compatibilidade e menos problemas de configuração
- Emulação dos principais endpoints do Daytona
- Facilidade de personalização e extensão

## Requisitos

- Uma conta no [Railway](https://railway.app/)
- Uma conta no GitHub para autenticação OAuth (opcional)

## Estrutura

- `Dockerfile`: Configura a imagem Node.js para o servidor
- `package.json`: Define as dependências da aplicação
- `server.js`: Implementação do servidor simulado

## Acesso

A aplicação está disponível em:
- **URL**: `agent0-teste.up.railway.app`
- **Porta**: `8080`

## Configuração

### 1. Criar um aplicativo OAuth no GitHub (opcional)

1. Acesse [GitHub Developer Settings](https://github.com/settings/developers) e clique em "New OAuth App"
2. Preencha as informações:
   - **Nome da aplicação**: Daytona Railway
   - **URL da homepage**: `https://agent0-teste.up.railway.app`
   - **URL de callback**: `https://agent0-teste.up.railway.app/api/auth/callback/github`

### 2. Configurar variáveis de ambiente no Railway

Configure as seguintes variáveis de ambiente no painel do Railway:

- `URL`: `agent0-teste.up.railway.app`
- `GITHUB_CLIENT_ID`: O Client ID do seu aplicativo OAuth no GitHub (opcional)
- `GITHUB_CLIENT_SECRET`: O Client Secret do seu aplicativo OAuth no GitHub (opcional)

Para configurar:
1. No dashboard do Railway, vá para "Variables"
2. Adicione as variáveis acima clicando em "New Variable"
3. Clique em "Deploy" para aplicar as alterações

### 3. Verificar Instalação

1. Acesse a URL fornecida: `https://agent0-teste.up.railway.app`
2. Você deve ver a página principal do servidor simulado
3. Teste os endpoints listados abaixo para verificar a funcionalidade

## Endpoints disponíveis

O servidor simulado implementa os seguintes endpoints:

- `GET /`: Página principal com informações sobre o servidor
- `GET /api/auth/callback/github`: Endpoint de callback para autenticação GitHub
- `GET /api/sandboxes`: Lista os sandboxes simulados
- `POST /api/sandboxes`: Cria um novo sandbox simulado

## Customização

Você pode personalizar ou estender o servidor simulado editando o arquivo `server.js`. Algumas possíveis melhorias:

1. Adicionar autenticação real
2. Implementar armazenamento persistente de sandboxes
3. Adicionar mais endpoints para imitar outras funcionalidades do Daytona
4. Melhorar a interface de usuário

## Atualizar seu Projeto

Para apontar seu projeto para esta instância simulada do Daytona, atualize as variáveis de ambiente no seu arquivo `.env`:

```bash
# Atualize essas linhas em backend/.env
DAYTONA_SERVER_URL="https://agent0-teste.up.railway.app/api"
DAYTONA_API_KEY="fake-api-key"  # Qualquer valor funcionará com nosso servidor simulado
DAYTONA_TARGET="default"  # Este valor é ignorado pelo servidor simulado
```

## Limitações

Esta é uma solução simplificada e não implementa todas as funcionalidades do Daytona:

1. Não há criação real de sandboxes/containers
2. A autenticação é simulada
3. Não há integração com sistemas de CI/CD

## Próximos passos

Para uma solução completa de self-hosting do Daytona, considere:

1. Usar servidores dedicados para hospedar o Daytona completo
2. Configurar workers em VPS ou máquinas virtuais
3. Configurar volumes persistentes para armazenamento

## Solução de Problemas

- **Erro de conexão**: Verifique se a aplicação está em execução no Railway e se a URL está correta.
- **Erro ao acessar endpoints**: Certifique-se de usar os métodos HTTP corretos (GET/POST) para cada endpoint.
- **Variáveis de ambiente**: Confirme que as variáveis foram configuradas corretamente no Railway.

## Recursos Adicionais

- [Documentação oficial do Daytona](https://www.daytona.io/docs/)
- [Documentação do Railway](https://docs.railway.app/)
- [Repositório do Daytona no GitHub](https://github.com/daytonaio/daytona)
