create database bd_paiefilho;
use bd_paiefilho;

create table tb_pai (
	id_pai int primary key not null,
    nome_pai varchar(55)
);

create table tb_filho (
	id_filho int primary key not null,
    nome_filho varchar(55),
    id_pai int,
    foreign key (id_pai) references tb_pai(id_pai)
    -- on delete CASCADE on update CASCADE
    -- on delete SET NULL on update SET NULL
    on delete RESTRICT on update CASCADE
);

insert into tb_pai values 
(1, "Darth Vader"),
(2, "Goku"),
(3, "Vegeta"),
(4, "Seu Cebola"),
(5, "Zurg"),
(6, "Neymar");

insert into tb_filho values 
(1, "Luke Skywalker", 1),
(2, "Gohan", 2),
(3, "Trunks", 3),
(4, "Cebolinha", 4),
(5, "Buzz Ligthyear", 5),
(6, "Neymar Jr", 6);

-- set SQL_SAFE_UPDATES=0

delete from tb_filho where nome_filho='Cebolinha';
delete from tb_pai where nome_pai='Neymar';
delete from tb_pai where nome_pai='Darth Vader';

drop table tb_filho;
truncate table tb_pai;

select * from tb_filho;
select * from tb_pai;
