#!/bin/bash

# Função para corrigir dependências específicas
definir_dependencias_frontend() {
  echo "Corrigindo dependências do frontend..."
  sed -i 's/\"ip-subnet-calculator\": \"[^\"]*\"/\"ip-subnet-calculator\": \"^1.1.8\"/' frontend/package.json
  sed -i 's/\"node-fetch\": \"[^\"]*\"/\"node-fetch\": \"^2.6.9\"/' frontend/package.json
}

definir_dependencias_backend() {
  echo "Corrigindo dependências do backend..."
  sed -i 's/\"sucrase\": \"[^\"]*\"/\"sucrase\": \"^3.32.0\"/' backend/package.json
}

# Início do script
echo "CLONANDO REPOSITÓRIO"
git clone https://github.com/steinhorstbr/cgnat-manager.git || { echo "Erro ao clonar o repositório."; exit 1; }

# Entra no repositório
echo "ENTRANDO NA PASTA"
cd cgnat-manager || { echo "Erro ao entrar na pasta cgnat-manager."; exit 1; }

# Corrige dependências do frontend
echo "CORRIGINDO O PACKAGE.JSON DO FRONTEND"
definir_dependencias_frontend

# Instala dependências do frontend
echo "INSTALANDO DEPENDÊNCIAS DO FRONTEND"
cd frontend || { echo "Erro ao entrar na pasta frontend."; exit 1; }
npm install --legacy-peer-deps || { echo "Erro ao instalar dependências do frontend."; exit 1; }
cd ..

# Corrige dependências do backend
echo "CORRIGINDO O PACKAGE.JSON DO BACKEND"
definir_dependencias_backend

# Instala dependências do backend
echo "INSTALANDO DEPENDÊNCIAS DO BACKEND"
cd backend || { echo "Erro ao entrar na pasta backend."; exit 1; }
npm install --legacy-peer-deps || { echo "Erro ao instalar dependências do backend."; exit 1; }
cd ..

# Criar script starter
cat << 'EOF' > starter-cgnat-manager.sh
#!/bin/bash

# Inicia o frontend
cd frontend
nohup npm run start > /dev/null 2>&1 &
cd ..

# Inicia o backend
cd backend
nohup npm run dev > /dev/null 2>&1 &
cd ..
EOF

chmod +x starter-cgnat-manager.sh

echo "ATIVANDO O ROTEAMENTO NO LINUX"
echo 1 > /proc/sys/net/ipv4/ip_forward

# Finaliza
cd ..
echo "INSTALAÇÃO CONCLUÍDA. USE ./starter-cgnat-manager.sh PARA INICIAR O SISTEMA."
