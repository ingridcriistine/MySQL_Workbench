create database bd_floricultura;

use bd_floricultura;

create table cliente (
	IDCliente int not null primary key auto_increment,
    Rg varchar(15),
    Nome varchar(60),
    Telefone varchar(15),
    Endereco varchar(100)
) default charset utf8;

create table compra (
	IDCompra int not null primary key auto_increment,
    IDCliente int,
    foreign key (IDCliente) references cliente(IDCliente),
    Data_Compra datetime,
    Valor_Total float,
    IDProduto int,
    foreign key (IDProduto) references produto(IDProduto)
) default charset utf8;

create table produto (
	IDProduto int not null primary key auto_increment,
    Nome varchar(60),
    Tipo varchar(60),
    Preco float,
    Quantidade int
) default charset utf8;

create table compraProduto (
	IDProduto int,
    foreign key (IDProduto) references produto(IDProduto),
    IDCompra int,
    foreign key (IDCompra) references compra(IDCompra)
) default charset utf8;

show tables;
select * from cliente;

