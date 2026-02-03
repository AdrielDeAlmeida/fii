# Scraper de FIIs - Fundamentus para Supabase

Este projeto extrai dados de Fundos de Investimento Imobiliário (FIIs) do site Fundamentus e atualiza automaticamente uma base de dados SQL no Supabase, permitindo integração com Power BI.

## 🚀 Funcionalidades

- ✅ Web scraping automático do site Fundamentus
- ✅ Atualização diária automática via GitHub Actions
- ✅ Armazenamento em banco de dados SQL (Supabase)
- ✅ Pronto para integração com Power BI
- ✅ Logs detalhados de execução

## 📋 Pré-requisitos

### 1. Conta no Supabase

1. Acesse [supabase.com](https://supabase.com) e crie uma conta gratuita
2. Crie um novo projeto
3. Anote a **URL do projeto** e a **Service Role Key** (em Settings > API)

### 2. Criar Tabela no Supabase

Execute o seguinte SQL no SQL Editor do Supabase:

```sql
CREATE TABLE fii_fundamentus (
    id BIGSERIAL PRIMARY KEY,
    papel VARCHAR(10) NOT NULL,
    segmento VARCHAR(100),
    cotacao VARCHAR(20),
    ffo_yield VARCHAR(20),
    dividend_yield VARCHAR(20),
    p_vp VARCHAR(20),
    valor_mercado VARCHAR(50),
    liquidez VARCHAR(50),
    qtd_imoveis VARCHAR(20),
    preco_m2 VARCHAR(20),
    aluguel_m2 VARCHAR(20),
    cap_rate VARCHAR(20),
    vacancia_media VARCHAR(20),
    data_atualizacao TIMESTAMP WITH TIME ZONE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Criar índice para melhor performance
CREATE INDEX idx_papel ON fii_fundamentus(papel);
CREATE INDEX idx_data_atualizacao ON fii_fundamentus(data_atualizacao);
```

### 3. Configurar GitHub Secrets

No seu repositório GitHub:

1. Vá em **Settings** > **Secrets and variables** > **Actions**
2. Clique em **New repository secret**
3. Adicione os seguintes secrets:
   - `SUPABASE_URL`: URL do seu projeto Supabase
   - `SUPABASE_KEY`: Service Role Key do Supabase

## 🔧 Configuração Local (Opcional)

Para testar localmente antes de fazer deploy:

1. Clone o repositório:
```bash
git clone <seu-repositorio>
cd <seu-repositorio>
```

2. Crie um ambiente virtual Python:
```bash
python -m venv venv
source venv/bin/activate  # No Windows: venv\Scripts\activate
```

3. Instale as dependências:
```bash
pip install -r requirements.txt
```

4. Copie o arquivo de exemplo e configure:
```bash
cp .env.example .env
```

5. Edite o arquivo `.env` com suas credenciais do Supabase

6. Execute o script:
```bash
python script.py
```

## ⚙️ GitHub Actions

O workflow está configurado para:

- **Execução automática**: Todos os dias às 9h UTC (6h Brasília)
- **Execução manual**: Vá em Actions > "Atualizar Dados FII no Supabase" > Run workflow

### Monitorar Execuções

1. Acesse a aba **Actions** no GitHub
2. Veja o histórico de execuções
3. Clique em uma execução para ver os logs detalhados

## 📊 Integração com Power BI

### Opção 1: Conexão Direta via PostgreSQL

1. No Power BI Desktop, clique em **Obter Dados** > **Banco de Dados PostgreSQL**
2. Configure a conexão:
   - **Servidor**: Extraia de `SUPABASE_URL` (ex: `db.xxxxx.supabase.co`)
   - **Banco de dados**: `postgres`
   - **Modo de conectividade**: Import
3. Use suas credenciais do Supabase
4. Selecione a tabela `fii_fundamentus`

### Opção 2: API REST do Supabase

1. No Power BI, use **Obter Dados** > **Web**
2. URL: `https://seu-projeto.supabase.co/rest/v1/fii_fundamentus`
3. Headers:
   - `apikey`: Sua anon key
   - `Authorization`: `Bearer sua-anon-key`

### Opção 3: Power BI Service (Atualização Automática)

Para atualização automática no Power BI Service, configure um gateway de dados local ou use a conexão REST API.

## 📁 Estrutura do Projeto

```
.
├── .github/
│   └── workflows/
│       └── update_fii_data.yml  # Workflow do GitHub Actions
├── script.py                     # Script principal
├── requirements.txt              # Dependências Python
├── .env.example                  # Template de variáveis de ambiente
├── .gitignore                    # Arquivos ignorados pelo Git
└── README.md                     # Esta documentação
```

## 🔍 Dados Coletados

O script coleta as seguintes informações de cada FII:

- Papel (código do FII)
- Segmento
- Cotação
- FFO Yield
- Dividend Yield
- P/VP (Preço sobre Valor Patrimonial)
- Valor de Mercado
- Liquidez
- Quantidade de Imóveis
- Preço do m²
- Aluguel por m²
- Cap Rate
- Vacância Média
- Data de Atualização

## 🛠️ Solução de Problemas

### Erro: "SUPABASE_URL e SUPABASE_KEY são obrigatórias"
- Verifique se os secrets estão configurados corretamente no GitHub

### Erro no ChromeDriver
- O workflow instala automaticamente a versão compatível do ChromeDriver
- Se houver problemas, verifique os logs do GitHub Actions

### Dados não aparecem no Power BI
- Verifique se a tabela foi criada corretamente no Supabase
- Confirme que o script rodou com sucesso (veja os logs no GitHub Actions)
- Teste a conexão diretamente no Supabase Dashboard

## 📝 Licença

Este projeto é de código aberto e está disponível para uso livre.

## 🤝 Contribuições

Contribuições são bem-vindas! Sinta-se à vontade para abrir issues ou pull requests.
