# Como Fazer Push do Código para o GitHub

## ✅ Opção 1: GitHub Desktop (Recomendado - Mais Fácil)

### Passo 1: Baixar GitHub Desktop
1. Acesse: https://desktop.github.com/
2. Baixe e instale o GitHub Desktop
3. Faça login com sua conta GitHub

### Passo 2: Adicionar o Repositório
1. No GitHub Desktop, clique em **File** > **Add local repository**
2. Clique em **Choose...** e selecione a pasta: `C:\Users\adrie\.gemini\Projetos\1`
3. Se aparecer "This directory does not appear to be a Git repository", clique em **create a repository**
4. Preencha:
   - **Name**: fii
   - **Local path**: `C:\Users\adrie\.gemini\Projetos\1`
   - Marque **Initialize this repository with a README** (pode desmarcar, já temos README)
5. Clique em **Create repository**

### Passo 3: Conectar ao GitHub
1. Clique em **Publish repository** (topo da janela)
2. Preencha:
   - **Name**: fii
   - **Description**: Scraper de FIIs para Supabase
   - Desmarque **Keep this code private** (se quiser público)
3. Clique em **Publish repository**

### Passo 4: Fazer Commit e Push
1. Você verá todos os arquivos na aba **Changes**
2. No campo de mensagem, escreva: `Adicionar script e configuração do GitHub Actions`
3. Clique em **Commit to main**
4. Clique em **Push origin** (topo da janela)

✅ **Pronto!** O código está no GitHub.

---

## 🔧 Opção 2: Instalar Git e Usar Linha de Comando

### Passo 1: Instalar Git
1. Acesse: https://git-scm.com/download/win
2. Baixe e instale (pode deixar todas as opções padrão)
3. Reinicie o PowerShell/VS Code

### Passo 2: Configurar Git (primeira vez)
```powershell
git config --global user.name "Seu Nome"
git config --global user.email "seu-email@example.com"
```

### Passo 3: Inicializar Repositório
```powershell
cd C:\Users\adrie\.gemini\Projetos\1
git init
git branch -M main
```

### Passo 4: Adicionar Arquivos
```powershell
git add .
git commit -m "Adicionar script e configuração do GitHub Actions"
```

### Passo 5: Conectar ao GitHub
```powershell
git remote add origin https://github.com/AdrielDeAlmeida/fii.git
git push -u origin main
```

Se pedir autenticação, use um **Personal Access Token** do GitHub (não a senha).

---

## 🔐 IMPORTANTE: Verificar o .env

Antes de fazer push, certifique-se que o arquivo `.env` **NÃO** será enviado:

1. Abra o arquivo `.gitignore`
2. Verifique se tem a linha: `.env`
3. Se não tiver, adicione

O arquivo `.env` contém suas credenciais secretas e **NUNCA** deve ir para o GitHub!

---

## ✅ Verificar se Funcionou

Depois do push:
1. Acesse: https://github.com/AdrielDeAlmeida/fii
2. Você deve ver todos os arquivos:
   - `script.py`
   - `.github/workflows/update_fii_data.yml`
   - `requirements.txt`
   - `README.md`
   - etc.
3. **NÃO** deve aparecer o arquivo `.env` (se aparecer, delete imediatamente!)

---

## 🤖 Depois do Push

Assim que o código estiver no GitHub:
1. Vá em **Actions**: https://github.com/AdrielDeAlmeida/fii/actions
2. Clique em **"Atualizar Dados FII no Supabase"**
3. Clique em **"Run workflow"** para testar
4. O workflow vai rodar automaticamente todos os dias às 9h UTC (6h Brasília)

---

## 🆘 Problemas Comuns

### "Authentication failed"
- Use um **Personal Access Token** em vez da senha
- Crie em: https://github.com/settings/tokens
- Selecione scope: `repo`

### "Permission denied"
- Verifique se você é o dono do repositório
- Ou use GitHub Desktop que gerencia autenticação automaticamente

### Arquivo .env apareceu no GitHub
1. Delete o arquivo do GitHub (via interface web)
2. Execute localmente:
```powershell
git rm --cached .env
git commit -m "Remove .env do repositório"
git push
```
3. Mude suas credenciais do Supabase (por segurança)
