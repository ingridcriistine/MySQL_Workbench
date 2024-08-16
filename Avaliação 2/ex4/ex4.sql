create database transacao;
use transacao;

create table agencia (
	id_agencia int primary key not null, 
    id_usuario int,
    foreign key (id_usuario) references usuario(id_usuario),
    numero int, 
    nome varchar(255)
);

create table instituicao (
	id_instituicao int primary key not null, 
	id_usuario int,
    foreign key (id_usuario) references usuario(id_usuario),
	nome varchar(255)
);

create table usuario (
	id_usuario int primary key not null auto_increment,
    Num_Conta int, 
	Nome_Usuario varchar(255), 
	CPF int
);

create table transação (
	id_transacao int primary key not null, 
	Valor float, 
	Tipo_De_Transferencia varchar(255), 
	Valor_Taxa float, 
	Total float, 
    id_usuario int,
    foreign key (id_usuario) references usuario(id_usuario),
    id_usuario int,
    foreign key (id_usuario) references usuario(id_usuario),
	id_Usuario_Origem int,
    foreign key (id_Usuario_Origem) references Usuario_Origem(id_Usuario_Origem),
	id_Usuario_Destino int,
    foreign key (id_Usuario_Destino) references Usuario_Destino(id_Usuario_Destino)
    
    on delete cascade
    on update cascade
);

create table Usuario_Origem (
	id_Usuario_Origem int primary key not null, 
    id_usuario int,
    foreign key (id_usuario) references usuario(id_usuario)
    
    on delete cascade
    on update cascade
);

create table Usuario_Destino (
	id_Usuario_Destino int primary key not null, 
    id_usuario int,
    foreign key (id_usuario) references usuario(id_usuario)
    
    on delete cascade
    on update cascade
);

insert into usuario values (1, '123456', 'Ingrid Rocha', 1234561234);
insert into agencia values (1, 1, 1234 ,'a1');



