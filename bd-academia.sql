create database bd_academia;

use bd_academia;

create table aluno (
	IDAluno int not null primary key auto_increment,
    Nome varchar(60),
    Idade int,
	Sexo varchar(60),
	Instituicao varchar(60),
    Telefone varchar(15)
) default charset utf8;

create table aula (
	IDAula int not null primary key auto_increment,
    Modalidade varchar(60),
    Nivel_Dificuldade varchar(60),
    IDProfessor int,
    foreign key (IDProfessor) references professor(IDProfessor),
    IDSala int,
    foreign key (IDSala) references sala(IDSala)
) default charset utf8;

create table professor(
	IDProfessor int not null auto_increment primary key,
    Nome varchar(60),
    Sobrenome varchar(60),
    Telefone varchar(15)
) default charset utf8;

create table sala(
	IDSala int not null auto_increment primary key,
    Nome varchar(60),
    Descricao varchar(100),
    Capacidade int
) default charset utf8;

create table participar (
	IDParticipar int not null auto_increment primary key,
    IDAluno int,
    foreign key (IDAluno) references aluno(IDAluno),
    IDAula int,
    foreign key (IDAula) references aula(IDAula)
) default charset utf8;

show tables;
