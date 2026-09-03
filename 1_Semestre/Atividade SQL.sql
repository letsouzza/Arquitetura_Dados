-- Atividades SQL 

-- Preparação: Criando Banco de Dados
create database atividades; 
use atividades;



-- ATIVIDADE 1: Funcionários
-- 1: Criando a tabela de funcionários e adicionando os atributos
create table funcionarios(
	id INT auto_increment primary key,
    nome varchar(100),
    departamento varchar(100),
    idade int, 
    salario decimal(10,2)
);

show tables;

-- 2: Inserindo registros na tabela funcionarios
insert into funcionarios(nome, departamento, idade, salario)
values
('Ana', 'TI', 22, 5000.00),
('Bruno', 'RH', 24, 3200.00),
('Carla', 'Financeiro', 30, 4500.00),
('Daniel', 'TI', 21, 5500.00),
('Eduarda', 'Administrativo', 32, 2800.00),
('Felipe', 'Financeiro', 25, 4700.00),
('Gabriela', 'RH', 20, 3100.00),
('Henrique', 'TI', 27, 6000.00);

-- 3: Apresentando todos os funcionarios
select * from funcionarios;

-- 4: Mostrando todos os funcionarios, ordenando pelo salario (maior para menor)
select * from funcionarios order by salario desc;

-- 5: Atualizando o salário da Gabriela e verificando a alteração
set sql_safe_updates = 0; -- Permitir atualizar por outro parametro sem ser ID
update funcionarios set salario = 3300.00 where nome = 'Gabriela';
select * from funcionarios where nome = 'Gabriela';

-- 6: Atualizando o departamento do Bruno
update funcionarios set departamento = 'TI' where nome = 'Bruno';
select * from funcionarios where nome = 'Bruno';

-- 7: Removendo a funcionária Eduarda 
delete from funcionarios where nome = 'Eduarda'; 
select * from funcionarios;

-- 8: Contando a quantidade de funcionários da empresa
select count(*) as total_funcionarios from funcionarios;

-- 9: Mostrando quantidade de funcionários por departamento 
select departamento, count(*) as total_funcionarios_departamento from funcionarios group by departamento;

-- 10: Mostrando a média salarial por departamento
select departamento, avg(salario) as media_salarial from funcionarios group by departamento;

-- 11: Mostrando o salario total pago por departamento 
select departamento, sum(salario) as total_pago from funcionarios group by departamento;

-- 12: Relatório por departamento 
select 
	departamento,
    count(*) as quantidade_funcionarios,
    avg(salario) as media_salarial,
    max(salario) as maior_salario,
    min(salario) as menor_salario,
    sum(salario) as total_pago
from funcionarios group by departamento;

-- 13: Filtro por departamentos com mais de um funcionário e média maior que 3000
select departamento, 
	count(*) as quantidade_funcionarios, 
    avg(salario) as media_salarial 
    from funcionarios 
	group by departamento
    having quantidade_funcionarios > 1 and media_salarial > 3000;

-- 14: Ordenando relatório por total pago
select 
	departamento,
    count(*) as quantidade_funcionarios,
    avg(salario) as media_salarial,
    max(salario) as maior_salario,
    min(salario) as menor_salario,
    sum(salario) as total_pago
from funcionarios group by departamento order by total_pago desc;

/* Resposta 15: Qual departamento parece ser o mais caro para a empresa?
    O departamento que parece mais caro para a empresa é o de TI, é possível perceber pois ao analisar os dados
    a soma dos salários dos funcionários no departamento de TI e mais que o dobro do que a soma do departamento
    Financeiro, sendo totalizada em 19.700,00. 
*/



-- ATIVIDADE 2- Vendas
-- Criando a tabela de Vendas
create table vendas(
	id INT auto_increment primary key,
    produto varchar(100),
    categoria varchar(100),
    quantidade int,
    valor decimal(10,2)
);

-- 1: Inserindo os valores na tabela vendas
insert into vendas(produto, categoria, quantidade, valor)
values
('Notebook', 'Eletronicos', 2, 3500.00),
('Mouse', 'Eletronicos', 5, 80.00),
('Mesa', 'Moveis', 1, 900.00),
('Cadeira', 'Moveis', 4, 450.00),
('Curso SQL', 'Educacao', 10, 200.00),
('Livro Python', 'Educacao', 6, 120.00),
('Monitor', 'Eletronicos', 3, 1200.00),
('Estante', 'Moveis', 2, 700.00);

-- 2: Apresentando todos os valores
select * from vendas;

-- 3: Mosrando os produtos em ordem de maior ao menor valor
select * from vendas order by valor desc;

-- 4: Aumentando 25% o valor do item Livro Python
update vendas set valor = valor * 1.25 where produto = 'Livro Python';
select * from vendas where produto = 'Livro Python';

-- 5: Deletando o registro da mesa 
delete from vendas where produto = 'mesa';
select * from vendas;

-- 6: Contando quantas vendas existem 
select count(*) as quantidade_vendas from vendas;

-- 7: Mostrando quantidade de vendas por categoria 
select categoria, count(*) as quantidade_vendas from vendas group by categoria;

-- 8: Mostrando o valor médio por categoria
select categoria, round(avg(valor), 2) as valor_medio from vendas group by categoria;

-- 9: Mostrando o valor total vendido por categoria 
select categoria, sum(valor) as valor_total from vendas group by categoria;

-- 10: Relatório por categoria
select categoria,
	count(*) as quantidade_vendas,
    round(avg(valor), 2) as valor_medio,
    max(valor) as maior_valor,
    min(valor) as menor_valor,
    sum(valor) as valor_total
from vendas group by categoria;

-- 11: Mostrando categorias com mais de 2 vendas 
select categoria, count(*) as quantidade_vendas from vendas group by categoria having quantidade_vendas > 2;

-- 12: Ordenando as ctegorias pelo total vendido (maior -> menor)
select categoria, sum(valor) as valor_total from vendas group by categoria order by valor_total desc;



-- ATIVIDADE 3- Impacto na atividade 1
-- 1: Atualizando salário do Bruno
update funcionarios set salario = 4000.00 where nome = 'Bruno';
select * from funcionarios where nome = 'Bruno';

-- 2: Excluindo a funcionária Gabriela 
delete from funcionarios where nome = 'Gabriela';
select * from funcionarios;

-- 3: Executando novamente o relatório
select 
	departamento,
    count(*) as quantidade_funcionarios,
    round(avg(salario),2) as media_salarial,
    max(salario) as maior_salario,
    min(salario) as menor_salario,
    sum(salario) as total_pago
from funcionarios group by departamento;

/* Respostas 4: 
	a- O que mudou nos resultados? 
		Alterou nos resultados que a média salarial e o total dos salários do departamento de TI aumentou,
        a média salarial de 4925.00 foi para 5125.00 e o total de salrios aumentou 800 reais (19700 -> 20500),
        além de que o menor salário que antes era 3200.00 alterou para 4000.00.
        Também ocorreu que o departamento de RH foi apagado da empresa, já que sua única funcionária foi demitida.
	b- Qual operação teve o maior impacto? Por quê?
		Depende do ponto de vista, o impacto do Update eu considero que foi maior pois alterou os valores dos salários
        pagos pela empresa, e aumentou o custo para a amepresa. No entanto o Delete também teve um impacto considerativo 
        pois tendo em vista que havia apenas uma funcionária do RH, com a exclusão dela, ocorreu que o departamento de RH
        parou de existir dentro da empresa.
*/



-- ATIVIDADE 4- Conceitual: WHERE vs HAVING 
/* Respostas: Indique qual cláusula deve ser utilizada 
	1- Mostrar apenas alunos com idade maior que 21:
		Podemos utilizar o WHERE pois não é necessário um agrupamento para realizar o filtro, 
        basta dentro da tabela alunos utilizarmos o where para buscar a idade desejada; Código:
        select * from alunos where idade > 21;
	2- Mostrar apenas curso com mais de 2 alunos:
		Necessário utilizar o HAVING, pois é necessário primeiro realizar a contagem de alunos e o 
        agrupamento por cursos, para depois fazer o filtro desejado; Código:
        select curso, count(*) as quantidade_alunos from universidade group by curso having quantidade_alunos > 2;
	3- Mostrar apenas funcionários do departamento de TI:
		Para realizar essa pesquisa, não é necessário agrupar algum elemento, dentro da tabela de funcionarios
        já existe o atributo departamento em que ao se utilizar o WHERE já encontra o valor que deseja, sem a
        necessidade de agrupar ou realizar alguma contagem; Código:
		select * from funcionarios where departamento = 'TI';
	4- Mostrar apenas departamentos com média salarial maior que 4000:
		Para essa atividade é preciso o HAVING, pois há a necessidade de realizar um cálculo, 
		a média salarial, e de agrupar os departamentos, por isso quando for realizar o filtro 
        precisa utilizar o HAVING; Código:
        select departamentos, avg(salario) as media_salarial from funcionarios group by departamentos having media_salarial > 4000;
        