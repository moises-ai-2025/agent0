// Script que mantém o processo vivo mesmo após o encerramento do servidor Express
const { spawn } = require('child_process');
const fs = require('fs');

console.log('Iniciando servidor com keep-alive wrapper...');

// Iniciar o processo do servidor
const serverProcess = spawn('node', ['server.js'], {
  stdio: 'inherit' // Compartilhar stdout/stderr com o processo principal
});

// Capturar sinais para encerrar corretamente
['SIGINT', 'SIGTERM'].forEach(signal => {
  process.on(signal, () => {
    console.log(`Recebido sinal ${signal}, tentando encerrar servidor graciosamente...`);
    serverProcess.kill(signal);
    
    // Aguardar um pouco antes de forçar o encerramento
    setTimeout(() => {
      console.log('Mantendo o container ativo mesmo após o sinal...');
      // Não encerramos o processo principal, mantendo-o ativo
    }, 1000);
  });
});

// Lidar com o encerramento do processo filho
serverProcess.on('close', (code) => {
  console.log(`Processo do servidor encerrado com código: ${code}`);
  console.log('Mantendo o processo principal ativo para evitar reinicialização do container...');
  // Não encerramos o processo principal, mantendo-o ativo indefinidamente
});

// Escrever um arquivo de status a cada 10 segundos para demonstrar que estamos vivos
setInterval(() => {
  const timestamp = new Date().toISOString();
  fs.writeFileSync('/app/status.txt', `Processo keep-alive ativo em: ${timestamp}\n`);
}, 10000);
