# Guia de Conexão Power BI com Supabase

## 📊 Método 1: Conexão PostgreSQL (Recomendado)

Este é o método mais robusto e permite atualização automática dos dados.

### Passo 1: Obter Credenciais do Supabase

1. Acesse seu projeto no Supabase: https://supabase.com/dashboard
2. Vá em **Settings** > **Database**
3. Na seção **Connection Info**, anote:
   - **Host**: `db.xxxxxxxxxxxxx.supabase.co`
   - **Database name**: `postgres`
   - **Port**: `5432`
   - **User**: `postgres`
   - **Password**: Clique em "Reset database password" se não souber

### Passo 2: Conectar no Power BI Desktop

1. Abra o **Power BI Desktop**
2. Clique em **Obter Dados** (ou **Get Data**)
3. Procure por **"PostgreSQL database"** ou **"Banco de dados PostgreSQL"**
4. Clique em **Conectar**

### Passo 3: Configurar Conexão

Preencha os campos:

```
Servidor: db.xxxxxxxxxxxxx.supabase.co
Banco de dados: postgres
```

**Modo de Conectividade de Dados:**
- Selecione **Import** (para carregar dados no Power BI)
- Ou **DirectQuery** (para consultar em tempo real - mais lento)

Clique em **OK**

### Passo 4: Autenticação

1. Selecione **Banco de dados** (Database)
2. Preencha:
   - **Nome de usuário**: `postgres`
   - **Senha**: A senha que você anotou/resetou
3. Clique em **Conectar**

### Passo 5: Selecionar Tabela

1. No navegador, expanda **public** > **Tables**
2. Marque a caixa ao lado de **fii_fundamentus**
3. Clique em **Carregar** (Load)

✅ **Pronto!** Os dados agora estão no Power BI.

---

## 📊 Método 2: Conexão via API REST

Alternativa se você tiver problemas com PostgreSQL.

### Passo 1: Obter URL e API Key

1. Acesse **Settings** > **API** no Supabase
2. Anote:
   - **URL**: `https://xxxxxxxxxxxxx.supabase.co`
   - **anon/public key**: `eyJhbGc...` (chave longa)

### Passo 2: Conectar no Power BI

1. No Power BI Desktop, clique em **Obter Dados**
2. Selecione **Web**
3. Cole a URL:

```
https://xxxxxxxxxxxxx.supabase.co/rest/v1/fii_fundamentus?select=*
```

(Substitua `xxxxxxxxxxxxx` pelo seu ID do projeto)

4. Clique em **OK**

### Passo 3: Configurar Headers

1. Clique em **Avançado** (Advanced)
2. Em **Cabeçalhos HTTP** (HTTP Headers), adicione:

```
apikey: sua-anon-key-aqui
Authorization: Bearer sua-anon-key-aqui
```

3. Clique em **OK**

### Passo 4: Transformar Dados

1. O Power BI vai abrir o Power Query Editor
2. Clique em **Para Tabela** (To Table)
3. Clique em **Expandir** (ícone de duas setas) na coluna
4. Marque todas as colunas e clique em **OK**
5. Clique em **Fechar e Aplicar**

---

## 🔄 Configurar Atualização Automática

### No Power BI Desktop

1. Vá em **Transformar dados** > **Configurações de fonte de dados**
2. Certifique-se que as credenciais estão salvas

### No Power BI Service (Online)

Para atualização automática na nuvem:

1. Publique o relatório no Power BI Service
2. Vá em **Configurações** do dataset
3. Em **Credenciais da fonte de dados**, configure:
   - **Método de autenticação**: Básico
   - **Nome de usuário**: `postgres`
   - **Senha**: Sua senha do Supabase
4. Em **Atualização agendada**, configure:
   - Ative **Manter seus dados atualizados**
   - Defina frequência (ex: diariamente às 10h)

**Importante**: Para Power BI Service, você pode precisar de um **Gateway de dados local** se estiver usando conexão PostgreSQL. A conexão via API REST não precisa de gateway.

---

## 📈 Criar Visualizações

Agora que os dados estão carregados, você pode criar:

### Exemplos de Visualizações

1. **Tabela de FIIs**
   - Arraste `papel`, `segmento`, `dividend_yield`, `cotacao` para uma tabela

2. **Gráfico de Dividend Yield**
   - Gráfico de barras: `papel` no eixo, `dividend_yield` nos valores

3. **Segmentação por Segmento**
   - Adicione um filtro de `segmento`

4. **Mapa de Calor de P/VP**
   - Use matriz com cores condicionais

### Dica: Converter Colunas

As colunas vêm como texto. Para fazer cálculos:

1. Vá em **Transformar dados**
2. Selecione colunas numéricas (`cotacao`, `dividend_yield`, etc.)
3. Clique em **Tipo de Dados** > **Número Decimal**
4. Remova símbolos (%, R$) se necessário
5. Clique em **Fechar e Aplicar**

---

## 🔍 Solução de Problemas

### Erro: "Não foi possível conectar"
- Verifique se o IP do seu computador está permitido no Supabase
- Vá em **Settings** > **Database** > **Connection pooling**
- Tente usar a porta `6543` (connection pooler) em vez de `5432`

### Erro: "Autenticação falhou"
- Resete a senha do banco no Supabase
- Use exatamente `postgres` como usuário

### Dados não aparecem
- Verifique se o workflow do GitHub rodou com sucesso
- Confirme que há dados na tabela no Supabase Dashboard

### Atualização não funciona no Power BI Service
- Verifique se as credenciais estão configuradas
- Para PostgreSQL, pode precisar de Gateway de dados local
- Considere usar API REST que não precisa de gateway

---

## 📝 Exemplo de Fórmula DAX

Para criar medidas calculadas:

```dax
// Converter Dividend Yield de texto para número
Dividend Yield Num = 
VALUE(
    SUBSTITUTE(
        SUBSTITUTE([dividend_yield], "%", ""),
        ",", "."
    )
)

// Média de Dividend Yield
Média DY = AVERAGE([Dividend Yield Num])

// Ranking de FIIs
Ranking DY = 
RANKX(
    ALL(fii_fundamentus),
    [Dividend Yield Num],
    ,
    DESC,
    DENSE
)
```

---

## ✅ Checklist Final

- [ ] Conexão estabelecida com Supabase
- [ ] Tabela `fii_fundamentus` carregada no Power BI
- [ ] Colunas numéricas convertidas corretamente
- [ ] Visualizações criadas
- [ ] Atualização automática configurada (se usando Power BI Service)
- [ ] Relatório publicado (opcional)

---

## 🆘 Precisa de Ajuda?

Se encontrar algum erro, me envie:
1. Print do erro
2. Qual método de conexão está usando (PostgreSQL ou API)
3. Logs do GitHub Actions (se o problema for nos dados)
