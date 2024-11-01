-- CONTEÚDO ########################################################################
-- Criação de tabela a partir de uma query
-- Criação de tabela a partir do zero
-- Deleção de tabelas


-- EXEMPLOS ########################################################################

-- (Exemplo 1) Criação de tabela a partir de uma query
-- Crie uma tabela chamada customers_age com o id e a idade dos clientes. 
-- Chame-a de temp_tables.customers_age

select customer_id,
	datediff('years', birth_date, current_date) idade_cliente
	into temp_tables.customers_age
from sales.customers

select *
from temp_tables.customers_age

-- (Exemplo 2) Criação de tabela a partir do zero
-- Crie uma tabela com a tradução dos status profissionais dos clientes. 
-- Chame-a de temp_tables.profissoes
select distinct professional_status
from sales.customers

create table temp_tables.profissoes(
	professional_status varchar,
	status_profissional varchar
)

select * from temp_tables.profissoes

insert into temp_tables.profissoes 
(professional_status, status_profissional)
values 
('freelancer', 'freelancer'),
('retired', 'aposentado(a)'),
('clt', 'clt'),
('other', 'outro(a)'),
('self_employed', 'autonomo(a)'),
('businessman', 'empresario(a)'),
('civil_servant', 'funcionario publico(a)'),
('student', 'estudante')
-- (Exemplo 3) Deleção de tabelas
-- Delete a tabela temp_tables.profissoes

drop table temp_tables.profissoes



-- RESUMO ##########################################################################
-- (1) Para criar tabelas a partir de uma query basta escrever a query normalmente e
-- colocar o comando INTO antes do FROM informando o schema e o nome da tabela 
-- a ser criada
-- (2) Para criar tabelas a partir do zero é necessário (a) criar uma tabela vazia 
-- com o comando CREATE TABLE (b) Informar que valores serão inseridos com o comando
-- INSERT INTO seguido do nome das colunas (c) Inserir os valores manualmente em forma 
-- de lista após o comando VALUES
-- (3) Para deletar uma tabela utiliza-se o comando DROP TABLE

-----------------------------------------------------------------------------------------

-- CONTEÚDO ########################################################################
-- Inserção de linhas
-- Atualização de linhas
-- Deleção de linhas


-- EXEMPLOS ########################################################################

-- (Exemplo 1) Inserção de linhas
-- Insira os status 'desempregado(a)' e 'estagiário(a)' na temp_table.profissoes

create table temp_tables.profissoes (
	professional_status varchar,
	status_profissional varchar
);

insert into temp_tables.profissoes
(professional_status, status_profissional)

values
('freelancer', 'freelancer'),
('retired', 'aposentado(a)'),
('clt', 'clt'),
('self_employed', 'autônomo(a)'),
('other', 'outro'),
('businessman', 'empresário(a)'),
('civil_servant', 'funcionário público(a)'),
('student', 'estudante')

select * from temp_tables.profissoes

insert into temp_tables.profissoes
(professional_status, status_profissional)

values
('unemployed', 'desempregado(a)'),
('trainee','estagiario(a)')

-- (Exemplo 2) Atualização de linhas
-- Corrija a tradução de 'estagiário(a)' de 'trainee' para 'intern' 

update temp_tables.profissoes
set professional_status = 'intern'
where status_profissional = 'estagiario(a)'


-- (Exemplo 3) Deleção de linhas
-- Delete as linhas dos status 'desempregado(a)' e 'estagiário(a)'
delete from temp_tables.profissoes 
where status_profissional = 'desempregado(a)' 
or status_profissional = 'estagiario(a)'


-- RESUMO ##########################################################################
-- (1) Para inserir linhas em uma tabela é necessário (a) Informar que valores serão 
-- inseridos com o comando INSERT INTO seguido do nome da tabela e nome das colunas 
-- (b) Inserir os valores manualmente em forma de lista após o comando VALUES
-- (2) Para atualizar as linhas de uma tabela é necessário (a) Informar qual tabela
-- será atualizada com o comando UPDATE (b) Informar qual o novo valor com o comando SET 
-- (c) Delimitar qual linha será modificada utilizando o filtro WHERE
-- (3) Para deletar linhas de uma tabela é necessário (a) Informar de qual tabela as
-- linhas serão deletadas com o comando DELETE FROM (b) Delimitar qual linha será 
-- deletada utilizando o filtro WHERE

------------------------------------------------------------------------------------

-- CONTEÚDO ########################################################################
-- Inserção de colunas
-- Alteração de colunas
-- Deleção de colunas


-- EXEMPLOS ########################################################################

-- (Exemplo 1) Inserção de Colunas
-- Insira uma coluna na tabela sales.customers com a idade do cliente
alter table sales.customers
add customer_age int

select * from sales.customers

update sales.customers
set customer_age = datediff('years', current_date, birth_date)
where true


-- (Exemplo 2) Alteração do tipo da coluna
-- Altere o tipo da coluna customer_age de inteiro para varchar
alter table sales.customers
alter column customer_age type varchar

select * from sales.customers limit 10

-- (Exemplo 3) Alteração do nome da coluna
-- Renomeie o nome da coluna "customer_age" para "age"

alter table sales.customers
rename column customer_age to age


-- (Exemplo 4) Deleção de coluna
-- Delete a coluna "age"

alter table sales.customers
drop column age


-- RESUMO ##########################################################################
-- (1) Para fazer qualquer modificação nas colunas de uma tabela utiliza-se o comando 
-- ALTER TABLE seguido do nome da tabela
-- (2) Para adicionar colunas utiliza-se o comando ADD seguido do nome da coluna e da
-- unidade da nova coluna
-- (3) Para mudar o tipo de unidade de uma coluna utiliza-se o comando ALTER COLUMN 
-- (4) Para renomear uma coluna utiliza-se o comando RENAME COLUMN
-- (5) Para deletar uma coluna utiliza-se o comando DROP COLUMN



