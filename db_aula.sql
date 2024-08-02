create database db_aula;

use db_aula;

create table tb_alunos (
	id int not null primary key auto_increment,
    nome varchar(60),
    data_nasc date
) default charset utf8;

insert into tb_alunos values 
(1, "Ingrid", "2005-01-15");

insert into tb_alunos values 
(default, "Mariana", "2006-05-28"),
(default, "Milena", "2005-09-23"),
(default, "Juliana", "2003-07-01"),
(default, "Helena", "2006-02-04")
;

select * from tb_alunos where nome="Ingrid";

show tables;
