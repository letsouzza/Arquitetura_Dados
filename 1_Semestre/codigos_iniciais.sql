-- Apagar o banco de dados caso ele já exista 
drop database if exists universidade;

-- Criar banco de dados
create database universidade; 

-- Selecionar o banco para uso 
use universidade;

-- Criar tabela alunos 
create table alunos(
	id int auto_increment primary key,
    nome varchar(100) not null,
    curso varchar(100) not null,
    idade int
);

-- Inserir registros na tabela 
insert into alunos(nome, curso, idade)
values('Ana', 'Ciencia de dados', 21);

insert into alunos(nome, curso, idade)
values('Carlos', 'Engenharia', 23);

insert into alunos(nome, curso, idade)
values('Maria', 'ADS', 20);

insert into alunos(nome, curso, idade)
values('João', 'ADS', 25);

insert into alunos(nome, curso, idade)
values
('Fernanda', 'ADS', 22),
('Pedro', 'Engenharia', 24),
('Juliana', 'Ciencia de Dados', 24),
('Rafael', 'ADS', 21),
('Camila', 'Engenharia', 24),
('Bruno', 'Ciencia de Dados', 25),
('Larissa', 'ADS', 20),
('Patricia', 'ADS', 24),
('Daniel', 'Engenharia', 25),
('Marcos', 'Ciencia de Dados', 21);

-- Visualizar todos os registros 
select * from alunos;

-- Visualizar apenas a coluna do nome 
select nome from alunos;

-- Visualizar nome e curso 
select nome, curso from alunos;

-- Filtrar alunos maiores de 21 anos
select * from alunos where idade >= 21;

-- Filtrar alunos no curso ADS
select * from alunos where curso = 'ADS';

-- Filtrar alunos com idade entre 21 e 23 anos 
select * from alunos where idade between 21 and 23;

-- Outra forma defiltrar intervalo
select * from alunos where idade >= 21 and idade <=23;

-- Ordenar alunos pela idade 
select * from alunos order by idade;

-- Ordenar aluno pela idade (maior para menor)
select * from alunos order by idade desc;

-- Uptade-> Alterar idade da ana
set sql_safe_updates = 0; -- Permitir atualizar por outro parametro sem ser ID
update alunos set idade = 22 where nome = 'Ana';

select * from alunos where nome= 'Ana';

-- Update -> Curso do joao
update alunos set curso = 'Ciencia de Dados' where nome = 'joao';
select * from alunos where nome= 'joao';

-- Uptade -> Aumentar 1 ano da idade de todos do curso de ADS
update alunos set idade = idade + 1 where curso = 'ADS';
select * from alunos where curso= 'ADS' order by idade;

-- Delete -> Apagar o rafael
select * from alunos where nome = 'Rafael';
delete from alunos where nome = 'rafael';

--

-- Delete -> Alunos com idade menor que 21
delete from alunos where idade < 21;
select * from alunos order by idade;

-- Count -> quantidade total de alunos
select count(*) as total_alunos from alunos;

-- Count -> com filtro
select count(*) as alunos_ads from alunos where curso = 'ADS';

-- AVG -> média das idades
select avg(idade) as media_idade from alunos;

-- Min -> menor idade
select min(idade) as menor_idade from alunos;

-- Max -> maior idade 
select max(idade) as menor_idade from alunos;

-- Sum -> soma das idades
select sum(idade) as soma_idades from alunos;

-- várias funcoes juntas
select
	count(*) as quantidade,
    avg(idade) as media_idade,
    min(idade) as menor_idade,
    max(idade) as maior_idade,
    sum(idade) as soma_idade
from alunos where curso = 'ads';

-- Group by -> quantidade de alunos por curso
select curso, count(*) as quantidade from alunos group by curso;

-- Group by -> quantidade de alunos por idade
select idade, count(*) as quantidade from alunos group by idade;

-- Group by -> media de idade por curso
select curso, avg(idade) as media_idade from alunos group by curso;

-- Group by -> menor idade por curso
select curso, min(idade) as menor_idade from alunos group by curso;

-- Group by -> maior idade por curso
select curso, max(idade) as maior_idade from alunos group by curso;

-- Group by -> soma das idades por curso
select curso, sum(idade) as soma_idade from alunos group by curso;

-- Order by com Group by

-- Quantidade de aluno por curso do maior para o menor
select curso, count(*) as quantidade from alunos 
	group by curso order by quantidade desc;
    
-- Media de idade por curso do maior para o menor
select curso, avg(idade) as media_idade from alunos 
	group by curso order by media_idade desc;
    
-- Ordenar cursos em ordem alfabética
select curso, count(*) as quantidade from alunos 
	group by curso order by curso;
    
-- Having -> Mostrar apenas cursos com mais de 2 alunos
select curso, count(*) as quantidade from alunos
	group by curso having quantidade > 2;

-- Having -> Mostrar apenas idade com mais de 1 aluno
select idade, count(*) as quantidade from alunos
	group by idade having quantidade > 1;

-- Having -> Mostrar cursos com media de idade maior que 22
select curso, avg(idade) as media_idade from alunos
	group by curso having media_idade > 22;
    
-- Having -> Mostrar cursos cuja soma das idades é maior que 40
select curso, sum(idade) as soma_idade from alunos
	group by curso having soma_idade > 40;
    
-- Where e Having
-- Where -> filtra linhas
-- Having -> filtra grupos

select curso, count(*) as quantidade from alunos 
	where idade >= 22 group by curso having quantidade>2;
    
select curso, avg(idade) as media_idade from alunos 
	where idade >= 22 group by curso having media_idade >= 23;

-- curso e quantidade de alunos
select curso, count(*) as quantidade from alunos 
	group by curso order by quantidade desc;

-- quantidade de alunos por curso, considerando apenas idade maior que 21
select curso, count(*) as quantidade from alunos 
	where idade >= 21 group by curso order by quantidade desc;
    
-- apenas cursos com pelo menos 2 alunos
select curso, count(*) as quantidade from alunos 
	group by curso having quantidade >= 2 order by curso;
    
-- Quantidade de alunos por idade 	
select idade, count(*) as quantidade from alunos 
	group by idade order by idade desc;
    
-- Media de idade por curso
select curso, avg(idade) as media_idade from alunos 
	group by curso order by media_idade desc;
    
-- maior e menor idade por curso
select curso, min(idade) as menor_idade, max(idade) as maior_idade from alunos 
	group by curso order by curso;
    
-- relatório completo por curso
-- quantidade, media, minimo, maximo e soma
select curso,
	count(*) as quantidade,
    round(avg(idade),2) as media_idade,
    min(idade) as menor_idade,
    max(idade) as maior_idade,
    sum(idade) as soma_idade
from alunos group by curso order by curso;
    