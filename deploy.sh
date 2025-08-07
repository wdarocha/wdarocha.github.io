#!/bin/bash

# Script de publicação do site no servidor do IMECC (Unicamp)
# Requer: apelido "imecc" configurado em ~/.ssh/config

echo "🚧 Gerando o site com Jekyll..."
bundle exec jekyll build

if [ $? -ne 0 ]; then
    echo "❌ Erro na geração do site. Abortando."
    exit 1
fi

echo "🚀 Enviando arquivos para o servidor IMECC..."
rsync -avz --delete _site/ imecc:~/public_html/

if [ $? -eq 0 ]; then
    echo "✅ Site publicado com sucesso em: https://www.ime.unicamp.br/~wdarocha"
else
    echo "❌ Falha ao transferir os arquivos."
    exit 1
fi

