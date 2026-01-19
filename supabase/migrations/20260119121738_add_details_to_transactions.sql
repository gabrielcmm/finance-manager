-- Adiciona a coluna 'details' do tipo JSONB
-- Por padrão, colunas novas aceitam NULL, então não precisamos especificar
alter table public.transactions
add column details jsonb;


create index idx_transactions_details on public.transactions using gin (details);