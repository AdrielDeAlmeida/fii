-- Script SQL para criar a tabela no Supabase
-- Execute este script no SQL Editor do Supabase Dashboard

-- Criar tabela para armazenar dados dos FIIs
CREATE TABLE IF NOT EXISTS fii_fundamentus (
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

-- Criar índices para melhor performance nas consultas
CREATE INDEX IF NOT EXISTS idx_papel ON fii_fundamentus(papel);
CREATE INDEX IF NOT EXISTS idx_data_atualizacao ON fii_fundamentus(data_atualizacao DESC);
CREATE INDEX IF NOT EXISTS idx_segmento ON fii_fundamentus(segmento);

-- Adicionar comentários para documentação
COMMENT ON TABLE fii_fundamentus IS 'Dados de Fundos de Investimento Imobiliário extraídos do Fundamentus';
COMMENT ON COLUMN fii_fundamentus.papel IS 'Código do FII (ex: HGLG11)';
COMMENT ON COLUMN fii_fundamentus.segmento IS 'Segmento de atuação do FII';
COMMENT ON COLUMN fii_fundamentus.data_atualizacao IS 'Data e hora da última atualização dos dados';

-- Habilitar Row Level Security (RLS) - Opcional, mas recomendado
ALTER TABLE fii_fundamentus ENABLE ROW LEVEL SECURITY;

-- Criar política para permitir leitura pública (para Power BI)
CREATE POLICY "Permitir leitura pública" ON fii_fundamentus
    FOR SELECT
    USING (true);

-- Criar política para permitir inserção/atualização apenas via service role
CREATE POLICY "Permitir escrita via service role" ON fii_fundamentus
    FOR ALL
    USING (auth.role() = 'service_role');
