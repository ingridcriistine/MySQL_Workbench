create database db_empresa;

use db_empresa;

create table tb_local (
	IDLocal int not null primary key auto_increment,
    Cidade varchar(55),
    Estado varchar(55)
);

create table tb_telefone (
	IDTelefone int not null primary key auto_increment,
    Num_Telefone int,
    Operadora varchar(55)
);

create table tb_pessoa (
	IDPessoa int not null primary key auto_increment,
    Nome varchar(55),
    IDTelefone int,
    foreign key (IDTelefone) references tb_telefone(IDTelefone),
    IDLocal int,
    foreign key (IDLocal) references tb_local(IDLocal)
);

show tables;
