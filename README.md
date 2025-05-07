# Implantação do Servidor Daytona no Railway

Este repositório contém todos os arquivos necessários para implantar seu próprio servidor Daytona no Railway.com, permitindo escalar além do limite de 10 sandboxes da versão cloud.

## Arquivos Incluídos

- `Dockerfile`: Configura o ambiente de execução do servidor Daytona
- `docker-compose.yml`: Define os serviços e volumes necessários
- `railway.json`: Configura opções específicas do Railway
- `.env`: Armazena variáveis de ambiente para configuração

## Pré-requisitos

1. Uma conta no [Railway.com](https://railway.com) (plano Pro recomendado)
2. Um domínio personalizado que você controle
3. Uma conta em um provedor de identidade (GitHub, GitLab, etc.)
4. Cliente OAuth configurado no seu provedor de identidade

## Guia de Implantação Passo a Passo

### 1. Configurar OAuth no Provedor de Identidade

#### Para GitHub:
1. Acesse [GitHub Developer Settings](https://github.com/settings/developers)
2. Clique em "New OAuth App"
3. Preencha:
   - Nome da Aplicação: "Daytona Self-Hosted"
   - Homepage URL: `https://seu-dominio.com`
   - Callback URL: `https://seu-dominio.com/api/auth/callback/github`
4. Anote o Client ID e Client Secret gerados

### 2. Preparar Repositório

1. Edite o arquivo `.env` e preencha as variáveis:
   ```
   URL=seu-dominio.com
   IDP=github  # ou outro provedor que estiver usando
   IDP_ID=seu_client_id_github
   IDP_SECRET=seu_client_secret_github
   ```

2. Faça o mesmo no `Dockerfile`, atualizando as variáveis ENV

### 3. Implantar no Railway

1. Crie uma conta no [Railway.com](https://railway.com)
2. Instale a CLI do Railway: `npm i -g @railway/cli`
3. Faça login: `railway login`
4. Na pasta do projeto, execute:
   ```bash
   railway init
   ```
5. Crie um novo projeto:
   ```bash
   railway project create
   ```
6. Implante o projeto:
   ```bash
   railway up
   ```

### 4. Configurar Domínio Personalizado

1. No dashboard do Railway, vá para "Settings" > "Domains"
2. Adicione seu domínio personalizado
3. Siga as instruções para configurar os registros DNS no seu provedor de domínio
4. Aguarde a propagação do DNS (pode levar até 48 horas)

### 5. Verificar Instalação

1. Acesse seu domínio personalizado
2. Faça login com sua conta no provedor de identidade
3. Você deve ver o dashboard do Daytona

## Configurar Servidores Worker para Sandboxes

Para executar sandboxes, você precisará de servidores worker com Docker instalado:

### Opção 1: Servidores VPS Externos

1. Configure servidores Ubuntu em provedores como DigitalOcean, AWS, etc.
2. Instale Docker:
   ```bash
   curl -fsSL https://get.docker.com -o get-docker.sh
   sh get-docker.sh
   ```
3. Configure permissões:
   ```bash
   sudo usermod -aG docker $USER
   sudo chmod 666 /var/run/docker.sock
   ```

### Opção 2: Workers no Railway

1. Crie projetos separados no Railway para cada worker
2. Use um Dockerfile simples com Docker instalado
3. Configure portas e volumes conforme necessário

## Adicionar Workers ao Servidor Daytona

1. Instale o CLI do Daytona em sua máquina local:
   ```bash
   curl -fsSL https://get.daytona.io | sh
   ```

2. Configure o Daytona CLI para usar seu servidor:
   ```bash
   daytona server use https://seu-dominio.com
   ```

3. Adicione cada worker como target:
   ```bash
   daytona server target set
   ```
   
4. Escolha "docker-provider" e forneça os detalhes de cada servidor worker:
   - Nome do target (ex: "worker1")
   - Hostname (IP do servidor)
   - Usuário para SSH
   - Caminho para sua chave SSH
   - Caminho do socket Docker (/var/run/docker.sock)
   - Diretório de dados (ex: /home/seu-usuario/daytona-data)

## Atualizar seu Projeto

Para apontar para sua nova instância do Daytona, atualize as variáveis de ambiente no seu arquivo `.env`:

```bash
# Atualize essas linhas em backend/.env
DAYTONA_SERVER_URL="https://seu-dominio.com/api"
DAYTONA_API_KEY="<seu-novo-api-key>"  # Obtenha do dashboard da sua instância Daytona
DAYTONA_TARGET="default"  # Ou deixe em branco para usar qualquer target disponível
```

## Solução de Problemas

- **Erro de conexão**: Verifique se seu domínio está configurado corretamente e se o servidor está rodando.
- **Erro de autenticação**: Confirme se as configurações OAuth estão corretas.
- **Erro ao criar sandbox**: Verifique se os workers estão configurados corretamente e acessíveis.

## Recursos Adicionais

- [Documentação oficial do Daytona](https://www.daytona.io/docs/)
- [Documentação do Railway](https://docs.railway.app/)
- [Repositório do Daytona no GitHub](https://github.com/daytonaio/daytona)
