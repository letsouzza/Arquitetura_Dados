-- ======================
-- 1. Criar Banco
-- ======================
drop database if exists escola;
create database escola;
use escola;

-- ===========================
-- 2. Tabela de cursos (1,n)
-- Um curso pode ter vários alunos
-- ===========================
create table cursos(
	id_curso int auto_increment primary key,
    nome_curso varchar(100)
);

-- ==========================
-- 3. Inserir dados em curso
-- ==========================
insert into cursos(nome_curso) values
	('ADS'),
    ('Engenharia'),
    ('Direito'),
    ('Medicina');
    
select * from cursos;

-- ==============================
-- 4. Tabela de alunos 
-- Foreign Key: liga com o curso
-- ===============================
create table alunos(
	id_aluno int auto_increment primary key,
    nome_aluno varchar(100),
    id_curso int,
    foreign key (id_curso) references cursos(id_curso)
);

-- ===============================
-- 5. Inserir dados em alunos
-- ===============================
insert into alunos(nome_aluno, id_curso) values
	('Ana', 1),
    ('João', 1),
    ('Maria', 2),
    ('Pedro', 3),
    ('Bianca', 2),
    ('Felipe', 4),
    ('Lucas', null);

select * from alunos;

-- ==========================
-- 6. Tabela de disciplinas
-- ==========================
create table disciplinas(
	id_disciplina int auto_increment primary key,
    nome_disciplina varchar(100) not null
);

-- =========================
-- 7. Inserir disciplinas 
-- =========================
insert into disciplinas(nome_disciplina) values
	('SQL'),
    ('Python'),
    ('Power BI'),
    ('Estatística'),
    ('História');

select * from disciplinas;

-- ==========================
-- 8. Tabela intermediária 
-- ==========================
create table aluno_disciplina(
	id_aluno int,
    id_disciplina int, 
    primary key(id_aluno, id_disciplina),
    foreign key (id_aluno) references alunos(id_aluno),
    foreign key (id_disciplina) references disciplinas (id_disciplina)
);

-- ===========================
-- 9. Inserir relacionamentos
-- ===========================
insert into aluno_disciplina(id_aluno, id_disciplina) values
	(1,1),
    (1,2),
    (2,1),
    (2,3),
    (3,2),
    (3,4),
    (4,1),
    (5,3),
    (6,4);

-- ============================
-- 10. Inner Join
-- Só alunos com curso
-- ============================
select a.id_aluno, a.nome_aluno as aluno, c.nome_curso as curso
	from alunos a inner join cursos c 
    on a.id_curso = c.id_curso;
    
/* =============================
RESULTADO:
	Retorna apenas alunos que possuem curso associado, 
    nesse caso o aluno Lucas não aparece pois seu curso é null
===============================*/

-- 11. Left Join
select a.nome_aluno as aluno, c.nome_curso as curso
	from alunos a left join cursos c
    on a.id_curso = c.id_curso;
    
/* Resultado:
	Retornar todos os alunos
    Lucas aparece mesmo sem curso, e seu curso será null
*/

-- 12. Right Join
select a.nome_aluno as aluno, c.nome_curso as curso
	from alunos a right join cursos c 
    on a.id_curso = c.id_curso;

/* Resultado:
	Retorna todos os cursos
    Mesmo cursos sem alunos aparece, e se isso ocorrer alunos será null
*/

-- ====================================
-- 13. JOIN N:N (aluno + disciplina)
-- ====================================
select a.nome_aluno as aluno, d.nome_disciplina as disciplina 
	from aluno_disciplina ad
    inner join alunos a on ad.id_aluno = a.id_aluno
    inner join disciplinas d on ad.id_disciplina = d.id_disciplina;

/* Resultado:
	Cada linha representa uma combinação aluno + disciplina
    Um aluno pode aparecer várias vezes (em disciplinas diferentes)
*/

-- ================================================
-- 14. Join completo (aluno + curso + disciplina)
-- ================================================
select a.nome_aluno as aluno, c.nome_curso as curso, d.nome_disciplina as disciplinas
	from aluno_disciplina ad
    inner join alunos a on ad.id_aluno = a.id_aluno
    inner join cursos c on a.id_curso = c.id_curso
    inner join disciplinas d on ad.id_disciplina = d.id_disciplina
    order by a.nome_aluno asc;

-- 15. Disciplinas sem alunos
select a.nome_aluno as alunos, d.nome_disciplina as disciplinas 
	from aluno_disciplina ad 
    right join alunos a on ad.id_aluno = a.id_aluno
	right join disciplinas d on ad.id_disciplina = d.id_disciplina
    where a.nome_aluno is null;

-- ================================================
-- 1. Distinct
-- ================================================
select distinct id_curso from alunos where id_curso is not null;

-- ================================================
-- 2. Distinct com Join
-- Mostrar nomes dos cursos que possuem alunos
-- ================================================
select distinct 
	c.nome_curso
from alunos a
inner join cursos c 
on a.id_curso = c.id_curso;

-- ================================================
-- 3. Distinct com mais de uma coluna
-- Considera a combinação das colunas e n cada coluna separadamente 
-- ================================================
select distinct 
	id_curso,
    nome_aluno
from alunos 
where id_curso is not null;

-- ================================================
-- 4. Order by com mais de uma coluna
-- ================================================
select distinct 
    nome_aluno,
    id_curso
from alunos 
where id_curso is not null
order by id_curso asc , nome_aluno asc;

-- ================================================
-- 5. Limit
-- Mostrar apenas os 3 primeiros alunos
-- ================================================
select * from alunos limit 3;

-- ================================================
-- 6. Order by + Limit
-- Mostrar apenas os 3 primeiros alunos em ordem alfabética
-- ================================================
select * from alunos 
order by nome_aluno asc limit 3;

-- ================================================
-- 7. Multiplos filtros com AND
-- Alunos do curso 1 e com id maior que 1
-- As duas combinações devem ser verdadeiras
-- ================================================
select * from alunos 
where id_curso = 1 and id_aluno > 1; 

-- ================================================
-- 8. Multiplos filtros com OR
-- Alunos do curso 1 ou 2 
-- Basta uma das condições ser verdadeira
-- ================================================
select * from alunos 
where id_curso = 1 or id_curso = 2; 

-- ================================================
-- 9. AND + Is not null
-- Alunos do curso 1 ou 2 
-- Basta uma das condições ser verdadeira
-- ================================================
select * from alunos 
where id_curso is not null
and id_curso = 2; 

-- ================================================
-- 10. AND e OR juntos sem parênteses
-- ================================================
select * from alunos 
where id_curso = 1 or id_curso = 2
	and id_aluno > 2; 
    
-- ================================================
-- 11. AND e OR juntos com parênteses
-- Controlamos explicitamente a lógica
-- ================================================
select * from alunos 
where (id_curso = 1 or id_curso = 2)
	and id_aluno > 2; 
    
-- ================================================
-- 12. Consulta completa com Join + Filtro + Ordem 
-- ================================================
select 
	a.nome_aluno as aluno,
    c.nome_curso as curso
from alunos a
left join cursos c
	on a.id_curso = c.id_curso
where a.id_curso is not null
order by c.nome_curso asc, a.nome_aluno asc;
    
-- ================================================
-- 13. Group by
-- Quantidade de alunos por curso
-- ================================================
select 
	c.nome_curso,
    count(a.id_aluno) as quantidade_alunos
from cursos c
left join alunos a 
on a.id_curso = c.id_curso
group by c.nome_curso; 

-- ================================================
-- 14. Having
-- Mostrar apenas cursos com mais de 1 aluno
-- ================================================
select 
	c.nome_curso,
    count(a.id_aluno) as quantidade_alunos
from cursos c
left join alunos a 
on a.id_curso = c.id_curso
group by c.nome_curso
having count(a.id_aluno) > 1;

-- ================================================
-- 15. Case when 
-- Classificar alunos conforme possuem ou não curso 
-- ================================================
select 
	nome_aluno,
    case 
		when id_curso is null then "Sem Curso"
        else "Com Curso"
	end as situacao
from alunos; 

-- ================================================
-- 16. Case when com mais de uma condição
-- Classificar alunos conforme o curso
-- ================================================
select 
	nome_aluno,
    case 
		when id_curso = 1 then "Curso ADS"
        when id_curso = 2 then "Curso Engenharia"
        when id_curso = 3 then "Curso Direito"
        when id_curso = 4 then "Curso Medicina"
        else "Sem Curso"
	end as classificacao
from alunos; 

-- ================================================
-- 17. Case when + Relatorio
-- Classificar cursos pela quantidade de alunos
-- ================================================
select 
	c.nome_curso,
    case 
		when count(a.id_aluno) >= 2 then "Turma Maior"
        when count(a.id_aluno) = 2 then "Turma Menor"
        else "Sem Alunos"
	end as situacao_turma
from cursos c
left join alunos a
	on c.id_curso = a.id_curso
group by c.nome_curso;

 -- ================================================
-- 18. CTE
-- Funciona como uma consulta temporária
-- ================================================
with alunos_com_curso as(
	select 
    id_aluno, nome_aluno, id_curso
    from alunos
    where id_curso is not null
)
select * from alunos_com_curso;

-- ================================================
-- 19. CTE + Join
-- Primeiro organizamos os alunos com curso
-- Depois ligamos com a tabela cursos
-- ================================================
with alunos_com_curso as(
	select 
    id_aluno, nome_aluno, id_curso
    from alunos
    where id_curso is not null
)
select 
	ac.nome_aluno,
    c.nome_curso
from alunos_com_curso ac
inner join cursos c
on ac.id_curso = c.id_curso;

-- ================================================
-- 20. CTE + Agregação
-- Calcular total de alunos por curso e depois filtrar 
-- ================================================
with total_por_curso as(
	select 
    id_curso, count(*) as total
    from alunos
    where id_curso is not null
    group by id_curso
)
select *
from total_por_curso 
where total > 1;

-- ================================================
-- 21. Window Function - Row Number
-- Gera uma numeração linha a linha
-- Sem agrupar os dados
-- Vamos criar um ranking alfabético geral 
-- ================================================
select 
	nome_aluno,
    row_number() over(order by nome_aluno asc) as ranking_alfabetico
from alunos;

-- ================================================
-- 22. Window Function com partition by
-- A numeração recomeça dentro de cada curso
-- ================================================
select 
	nome_aluno,
    id_curso,
    row_number() over(
		partition by id_curso
        order by nome_aluno asc
	) as ranking_alfabetico
from alunos
where id_curso is not null;

-- ================================================
-- 23. Window Function com Rank
-- RANK seria diferente do Row_Number
-- ================================================
select 
	nome_aluno,
    id_curso,
    rank() over(
		partition by id_curso
        order by nome_aluno asc
	) as ranking_alfabetico
from alunos
where id_curso is not null;

-- ================================================
-- 24. Consulta completa
-- Join + Case + Order by
-- ================================================
select 
	a.nome_aluno as aluno,
    c.nome_curso as curso,
    case
		when a.id_curso is null then "Sem Curso"
        else "Com Curso"
	end as situacao
from alunos a
left join cursos c
	 on a.id_curso = c.id_curso
	order by a.nome_aluno asc;