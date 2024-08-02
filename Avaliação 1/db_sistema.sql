create database db_cargos;

use db_cargos;

create table permissao (
	IDPermissao int not null primary key auto_increment,
    Descricao varchar(55)
);

create table perfil_permissao (
	IDPerfilPermissao int not null primary key auto_increment,
    Descricao varchar(100),
    IDPermissao int,
    foreign key (IDPermissao) references permissao(IDPermissao)
);

create table cargo (
	IDCargo int not null primary key auto_increment,
    Nome varchar(55),
    Descricao varchar(100),
    IDPerfilPermissao int,
    foreign key (IDPerfilPermissao) references perfil_permissao(IDPerfilPermissao)
);

create table usuario_pai (
	IDUsuarioPai int not null primary key auto_increment,
	IDCargo int,
	foreign key (IDCargo) references cargo(IDCargo),
    IDPerfilPermissao int,
    foreign key (IDPerfilPermissao) references perfil_permissao(IDPerfilPermissao)
);

create table usuario (
	IDUsuario int not null primary key auto_increment,
    IDUsuarioPai int,
    foreign key (IDUsuarioPai) references usuario_pai(IDUsuarioPai),
    IDCargo int,
	foreign key (IDCargo) references cargo(IDCargo)
);

create table requisicao (
	IDRequisicao int not null primary key auto_increment,
    IDUsuario int,
    foreign key (IDUsuario) references usuario(IDUsuario),
    IDUsuarioPai int,
    foreign key (IDUsuarioPai) references usuario_pai(IDUsuarioPai),
    Descricao varchar(100),
    IDPerfilPermissao int,
    foreign key (IDPerfilPermissao) references perfil_permissao(IDPerfilPermissao)
);

/*create table requisicao_perfil_permissao (
	IDRequisicao_PerfilPermissao int not null primary key auto_increment,
    IDPermissao int,
    foreign key (IDPermissao) references permissao(IDPermissao)
);*/
