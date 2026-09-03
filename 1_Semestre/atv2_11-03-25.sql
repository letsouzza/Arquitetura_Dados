create database loja;

use loja;

create table produtos(
	id int auto_increment primary key,
    nome varchar(100),
    categoria varchar(50),
    preco decimal(10,2)
);

insert into produtos(nome, categoria, preco)
values('Computador', 'Eletronico', 5000.20);

insert into produtos(nome, categoria, preco)
values('Fone', 'Eletronico', 35);

insert into produtos(nome, categoria, preco)
values('Blusa', 'Roupa', 20);

insert into produtos(nome, categoria, preco)
values('Cafe', 'Alimento', 40);

select * from produtos;

select * from produtos where preco > 100;

select * from produtos where categoria = 'Eletronico';

select * from produtos where preco between 50 and 6000;

select * from produtos order by preco asc;