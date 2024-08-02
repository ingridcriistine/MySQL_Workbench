create database db_biblioteca;

use db_biblioteca;

create table cliente (
	IDCliente int not null primary key auto_increment,
    Nome varchar(55),
    CPF varchar(55),
    Email varchar(55),
	Endereco varchar(100)
);

create table livro (
	IDLivro int not null primary key auto_increment,
	Titulo varchar(55),
    Autor varchar(55),
    Editora varchar(55)
);

create table funcionario (
	IDFuncionario int not null primary key auto_increment,
    Nome varchar(55),
    CPF varchar(55),
    Email varchar(55),
	Endereco varchar(100)
);

create table emprestimo (
	IDEmprestimo int not null primary key auto_increment,
	IDCliente int,
    foreign key (IDCliente) references cliente(IDCliente),
    IDLivro int,
    foreign key (IDLivro) references livro(IDLivro),
    IDFuncionario int,
    foreign key (IDFuncionario) references funcionario(IDFuncionario),
    Data_Emprestimo datetime,
    Data_Devolucao datetime
);
