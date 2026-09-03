-- Selecionar o banco para uso 
use universidade;

-- Criar tabela alunos 
create table professor(
	id int auto_increment primary key,
    nome varchar(100) not null,
    disciplina varchar(100),
    idade int
);

-- Inserir registros na tabela 
insert into professor(nome, disciplina, idade)
values('Bethina', 'Arquitetura de dados', 30);

insert into professor(nome, disciplina, idade)
values('Felipe', 'Metodologias Ageis', 35);

insert into professor(nome, disciplina, idade)
values('Aruane', 'Estrutura de dados', 29);

insert into professor(nome, disciplina, idade)
values('Rafael', 'Lógica e programacao', 38);

-- Visualizar todos os registros 
select * from professor;

-- Visualizar apenas a coluna do nome 
select nome from professor;

-- Filtrar professores maiores de 25 anos
select * from professor where idade >= 35;

-- Filtrar professores com idade entre 30 e 40 anos 
select * from professor where idade between 30 and 40;

-- Ordenar professores pela idade 
select * from professor order by idade asc;



