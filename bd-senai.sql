-- create database bd_senai;

use bd_senai;
show databases;

create table aluno (
    id_aluno int not null primary key auto_increment,
    nome varchar(60) not null,
    sobrenome varchar(60) not null
)default charset utf8;

create table professor (
    id_professor int not null primary key auto_increment,
    nome varchar(60) not null, 
    sobrenome varchar(60) not null
)default charset utf8;

create table turma(
    id_turma int not null auto_increment primary key,
    id_aluno int,
    foreign key (id_aluno) references aluno(id_aluno),
    id_professor int,
    foreign key (id_professor) references professor(id_professor)
) default charset utf8mb4;

show tables;

select * from turma;

-- drop table professor;
-- drop table aluno;
