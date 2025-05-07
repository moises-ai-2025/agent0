const express = require("express");
const app = express();
const port = process.env.PORT || 3000;
const url = process.env.URL || "localhost";

app.use(express.json());
app.use(express.urlencoded({ extended: true }));

app.get("/", (req, res) => {
  res.send(`
    <html>
      <head>
        <title>Daytona Server</title>
        <style>
          body { font-family: Arial, sans-serif; max-width: 800px; margin: 0 auto; padding: 20px; }
          h1 { color: #333; }
          .container { border: 1px solid #ddd; padding: 20px; border-radius: 5px; }
          .info { background-color: #f8f9fa; padding: 15px; margin-top: 20px; border-radius: 5px; }
        </style>
      </head>
      <body>
        <h1>Daytona Server</h1>
        <div class="container">
          <p><strong>Status:</strong> Online</p>
          <p><strong>Configurado para:</strong> ${url}</p>
          <p>Este é um servidor simulado do Daytona hospedado no Railway</p>
        </div>
        <div class="info">
          <h3>Endpoints disponíveis:</h3>
          <ul>
            <li><code>/api/auth/callback/github</code> - Callback de autenticação do GitHub</li>
            <li><code>/api/sandboxes</code> - GET: Listar sandboxes | POST: Criar sandbox</li>
          </ul>
        </div>
      </body>
    </html>
  `);
});

app.get("/api/auth/callback/github", (req, res) => {
  res.send("Autenticação GitHub recebida");
});

// Endpoint para criação de sandbox (simulado)
app.post("/api/sandboxes", (req, res) => {
  res.json({
    success: true,
    sandbox_id: "sandbox-" + Math.random().toString(36).substring(2, 8),
    message: "Sandbox criado com sucesso"
  });
});

// Endpoint para listagem de sandboxes (simulado)
app.get("/api/sandboxes", (req, res) => {
  res.json({
    sandboxes: [
      { id: "sandbox-123456", status: "running", created_at: new Date().toISOString() },
      { id: "sandbox-789012", status: "running", created_at: new Date().toISOString() }
    ]
  });
});

app.listen(port, () => {
  console.log(`Servidor rodando na porta ${port}`);
});
