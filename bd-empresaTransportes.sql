create database bd_empresa_transportes;

use bd_empresa_transportes;

create table armazem (
	IDArmazem int not null auto_increment primary key,
    Nome varchar(60),
    Endereco varchar(100)
) default charset utf8;

create table loja (
	IDLoja int not null auto_increment primary key,
    Nome varchar(60),
    Endereco varchar(100)
) default charset utf8;

create table encomenda (
	IDEncomenda int not null auto_increment primary key,
    Data datetime,
    Peso varchar(10),
    Destino varchar(100),
    IDCaminhao int,
    foreign key (IDCaminhao) references caminhao(IDCaminhao)
) default charset utf8;

create table caminhao (
	IDCaminhao int not null auto_increment primary key,
    IDLoja int, 
    foreign key (IDLoja) references loja(IDLoja),
    Capacidade int,
    Tipo varchar(60)
) default charset utf8;

create table enviar (
	IDEnviar int not null auto_increment primary key,
    IDArmazem int, 
    foreign key (IDArmazem) references armazem(IDArmazem),
    IDEncomenda int, 
    foreign key (IDEncomenda) references encomenda(IDEncomenda)
) default charset utf8;

create table entregar (
	IDEntregar int not null auto_increment primary key,
    IDLoja int, 
    foreign key (IDLoja) references loja(IDLoja),
    IDCaminhao int,
    foreign key (IDCaminhao) references caminhao(IDCaminhao)
) default charset utf8;

create table armazemLoja (
	IDArmazemLoja int not null auto_increment primary key,
     IDLoja int, 
    foreign key (IDLoja) references loja(IDLoja),
    IDArmazem int, 
    foreign key (IDArmazem) references armazem(IDArmazem)
) default charset utf8;

show tables;