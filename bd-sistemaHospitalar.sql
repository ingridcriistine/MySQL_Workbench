create database bd_sistema_hospitalar;

use bd_sistema_hospitalar;

create table medico (
	IDMedico int not null auto_increment primary key,
    CRM varchar(60),
    Nome varchar(60),
    Especialidade varchar(60)
) default charset utf8;

create table paciente (
	IDPaciente int not null auto_increment primary key,
    Nome varchar(60),
    Endereco varchar(60),
    Idade int,
    Cod_Registro varchar(60)
) default charset utf8;

create table consulta (
	IDConsulta int not null auto_increment primary key,
    IDMedico int,
    foreign key (IDMedico) references medico(IDMedico),
    IDPaciente int,
    foreign key (IDPaciente) references paciente(IDPaciente)
) default charset utf8;

create table medicoConsulta (
	IDMedicoConsulta int not null auto_increment primary key,
    IDMedico int,
    foreign key (IDMedico) references medico(IDMedico),
    IDConsulta int,
    foreign key (IDConsulta) references consulta(IDConsulta)
) default charset utf8;

create table consultaPaciente (
	IDConsultaPaciente int not null auto_increment primary key,
    IDPaciente int,
    foreign key (IDPaciente) references paciente(IDPaciente),
    IDConsulta int,
    foreign key (IDConsulta) references consulta(IDConsulta)
) default charset utf8;

create table receita (
	IDReceita int not null auto_increment primary key,
    IDConsulta int,
    foreign key (IDConsulta) references consulta(IDConsulta),
    IDExame int,
    foreign key (IDExame) references exame(IDExame),
    IDMedicamento int,
    foreign key (IDMedicamento) references medicamento(IDMedicamento)
) default charset utf8;

create table exame (
	IDExame int not null auto_increment primary key,
    Nome varchar(60),
    Descricao varchar(100),
    Quantidade int
) default charset utf8;

create table medicamento (
	IDMedicamento int not null auto_increment primary key,
    Num_Serie varchar(60),
    Data_Realizacao datetime,
    Descricao varchar(100)
) default charset utf8;

show tables;
