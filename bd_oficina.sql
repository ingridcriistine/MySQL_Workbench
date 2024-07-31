create database bd_oficina;

use bd_oficina;

create table veiculo (
	IDVeiculo int not null primary key auto_increment,
    Marca varchar(50) not null,
    Modelo varchar(50) not null, 
    Ano datetime not null,
    Placa varchar(50) not null,
    IDCliente int not null,
    foreign key (IDCliente) references cliente(IDCliente)
) default charset utf8;

create table cliente (
	IDCliente int not null primary key auto_increment,
    Nome varchar(60) not null,
    Telefone varchar(15) not null,
    Endereco varchar(100) not null
) default charset utf8;

create table pessoa_fisica (
	IDPessoa_Fisica int not null primary key auto_increment,
    CPF varchar(20) not null,
    IDCliente int not null,
    foreign key (IDCliente) references cliente(IDCliente)
) default charset utf8;

create table pessoa_juridica (
	IDPessoa_Juridica int not null primary key auto_increment,
    CNPJ varchar(20) not null,
    IDCliente int not null,
    foreign key (IDCliente) references cliente(IDCliente)
) default charset utf8;

create table servico (
	IDServico int not null primary key auto_increment,
    Itens_Servico varchar(50) not null,
    Quantidade int not null,
    Tipo varchar(50) not null,
    Descricao varchar(100) not null,
    Preco float not null
) default charset utf8;

create table ordem_servico (
	IDOrdem_Servico int not null primary key auto_increment,
    Data_Entrada datetime not null,
    Data_Conclusao datetime not null,
    Status varchar(60) not null,
    Preco float not null,
    Observacoes varchar(100),
    IDCliente int not null,
    foreign key (IDCliente) references cliente(IDCliente),
    IDVeiculo int not null,
    foreign key (IDVeiculo) references veiculo(IDVeiculo)
) default charset utf8;

create table ordem_servico_servico (
	IDOrdem_Servico_Servico int not null primary key auto_increment,
	IDServico int not null,
    foreign key (IDServico) references servico(IDServico),
    IDOrdem_Servico int not null,
    foreign key (IDOrdem_Servico) references ordem_servico(IDOrdem_Servico)
) default charset utf8;

show tables;
