create database bd_sistema_policia_militar;

use bd_sistema_policia_militar;

create table soldado (
	IDSoldado int not null primary key auto_increment,
    Nome varchar(60),
    Registro_Militar varchar(60),
    Data_Nascimento datetime
) default charset utf8;

create table arma (
	IDArma int not null primary key auto_increment,
    Num_Serie varchar(60),
    Tipo varchar(60),
    Calibre varchar(60),
    IDSoldado int,
    foreign key (IDSoldado) references soldado(IDSoldado),
    IDMunicao int,
    foreign key (IDMunicao) references municao(IDMunicao)
) default charset utf8;

create table municao (
	IDMunicao int not null primary key auto_increment,
    Tipo_Municao varchar(60)
) default charset utf8;

create table limpeza (
	IDLimpeza int not null primary key auto_increment,
    IDSoldado int,
    foreign key (IDSoldado) references soldado(IDSoldado),
    IDArma int,
    foreign key (IDArma) references arma(IDArma)
) default charset utf8;

show tables;
