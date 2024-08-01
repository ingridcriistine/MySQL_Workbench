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
) default charset utf8mb4;

create table cliente (
	IDCliente int not null primary key auto_increment,
    Nome varchar(60) not null,
    Telefone varchar(15) not null,
    Endereco varchar(100) not null
) default charset utf8mb4;

create table pessoa_fisica (
	IDPessoa_Fisica int not null primary key auto_increment,
    CPF varchar(20) not null,
    IDCliente int not null,
    foreign key (IDCliente) references cliente(IDCliente)
) default charset utf8mb4;

create table pessoa_juridica (
	IDPessoa_Juridica int not null primary key auto_increment,
    CNPJ varchar(20) not null,
    IDCliente int not null,
    foreign key (IDCliente) references cliente(IDCliente)
) default charset utf8mb4;

create table servico (
	IDServico int not null primary key auto_increment,
    Itens_Servico varchar(50) not null,
    Quantidade int not null,
    Tipo varchar(50) not null,
    Descricao varchar(100) not null,
    Preco float not null
) default charset utf8mb4;

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
) default charset utf8mb4;

create table ordem_servico_servico (
	IDOrdem_Servico_Servico int not null primary key auto_increment,
	IDServico int not null,
    foreign key (IDServico) references servico(IDServico),
    IDOrdem_Servico int not null,
    foreign key (IDOrdem_Servico) references ordem_servico(IDOrdem_Servico)
) default charset utf8mb4;


show tables;



alter table ordem_servico modify column Data_Conclusao datetime;
alter table ordem_servico change Status staatus varchar(50);
alter table ordem_servico_servico add column Qtd int;
alter table veiculo modify column Ano int;

insert into cliente (Nome, Telefone, Endereco) values ('João Silva', 123456789, 'Rua A, 123, Cidade X'), ('Maria Oliveira', 987654321, 'Av. B, 456, Cidade Y'), ('Carlos Santos', 456123789, 'Rua C, 789, Cidade Z');
insert into servico (Itens_Servico, Quantidade, Tipo, Descricao, Preco) values ('Óleo', 1, 'Troca de Óleo do Motor', 'Trocar Óleo', 150.00), ('Pneu', 4, 'Trocar todos os Pneus', 'Troca de Pneu', 300.00), ('Chave de Fenda', 1, 'Ver se o carro ta bem', 'Revisão Periódica', 200.00), ('Jumper', 1, 'Reparar os fios do carro', 'Reparo Elétrico', 180.00);
insert into veiculo (Marca, Modelo, Ano, Placa, IDCliente) values ('Ford', 'Fiesta', 2018, 'ABC-1234', 1), ('Chevrolet', 'Onix', 2020, 'DEF-5678', 1), ('Volkswagen', 'Gol', 2019, 'GHI-9101', 2), ('Toyota', 'Corolla', 2021, 'JKL-1122', 3);
insert into ordem_servico (Data_Entrada, Data_Conclusao, staatus, Preco, Observacoes, IDCliente, IDVeiculo) values ('2024-07-15', '2024-07-16', 'Concluída', 214.98, 'Não temos filtro', 1, 1), ('2024-07-20', '2024-07-22', 'Em Andamento', 356.27, 'Tudo nos trinque', 2, 3), ('2024-07-25', null, 'Em Andamento', 252.65, 'É isso ai', 1, 2), ('2024-07-28', '2024-07-30', 'Concluída', 196.42, 'Acho que não vai explodir', 3, 4);
insert into ordem_servico_servico (IDServico, IDOrdem_Servico, Qtd) values (1, 1, 5), (2, 2, 4), (3, 3, 1), (4, 4, 2);


select * from cliente;
select * from servico;
select * from veiculo;
select * from ordem_servico;
select * from ordem_servico_servico;
