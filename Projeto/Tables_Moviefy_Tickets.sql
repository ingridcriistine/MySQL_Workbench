create database Moviefy_Tickets;
use Moviefy_Tickets;

CREATE TABLE Genero (
    id INTEGER PRIMARY KEY,
    Nome VARCHAR(255)
) DEFAULT CHARSET = utf8;

CREATE TABLE ClassificacaoIndicativa (
    id INTEGER PRIMARY KEY,
    Idade VARCHAR(10)
) DEFAULT CHARSET = utf8;

CREATE TABLE TipoIngresso (
    id INTEGER PRIMARY KEY,
    Tipo VARCHAR(20),
    Porcentagem INTEGER
) DEFAULT CHARSET = utf8;

CREATE TABLE Salas (
    id INTEGER PRIMARY KEY,
    numeroSala VARCHAR(10)
) DEFAULT CHARSET = utf8;

CREATE TABLE Pagamento (
    id INTEGER PRIMARY KEY,
    Tipo INTEGER
) DEFAULT CHARSET = utf8;

CREATE TABLE Cliente (
    id INTEGER PRIMARY KEY,
    Nome VARCHAR(255),
    Sobrenome VARCHAR(255),
    Senha VARCHAR(255),
    Email VARCHAR(255),
    CPF VARCHAR(20),
    DataNascimento DATE
) DEFAULT CHARSET = utf8;

CREATE TABLE Endereco (
    id INTEGER PRIMARY KEY,
    numero VARCHAR(10),
    cep VARCHAR(20),
    logradouro VARCHAR(255),
    Cidade VARCHAR(255)
) DEFAULT CHARSET = utf8;

CREATE TABLE Cinema (
    id INTEGER PRIMARY KEY,
    NomeLocal VARCHAR(255),
    PrecoIngresso FLOAT,
    
    fk_Endereco_id INTEGER,
	FOREIGN KEY (fk_Endereco_id)
   	REFERENCES Endereco (id)
		ON DELETE SET NULL
        ON UPDATE CASCADE
) DEFAULT CHARSET = utf8;

CREATE TABLE Filme (
	id INTEGER PRIMARY KEY,
    data_estreia DATE,
    duracao VARCHAR(10),
    data_saida DATE,
    titulo VARCHAR(255),
   
    fk_ClassificacaoIndicativa_id INTEGER,
    FOREIGN KEY (fk_ClassificacaoIndicativa_id)
    REFERENCES ClassificacaoIndicativa (id)
		ON DELETE SET NULL 
		ON UPDATE CASCADE,
    
     fk_Genero_id INTEGER,
    FOREIGN KEY (fk_Genero_id)
    REFERENCES Genero (id)
		ON DELETE SET NULL 
		ON UPDATE CASCADE
) DEFAULT CHARSET = utf8;

CREATE TABLE Assentos (
    id INTEGER PRIMARY KEY,
    numero VARCHAR(10),
    fk_Salas_id INTEGER,
    
    FOREIGN KEY (fk_Salas_id)
    REFERENCES Salas (id)
		ON DELETE CASCADE 
		ON UPDATE CASCADE
) DEFAULT CHARSET = utf8;

CREATE TABLE Sessao (
    id INTEGER PRIMARY KEY,
    tresD BIT,
    DataHorario DATETIME,
    
    fk_Filme_id INTEGER,
    FOREIGN KEY (fk_Filme_id)
    REFERENCES Filme (id)
		ON DELETE CASCADE
        ON UPDATE CASCADE,
    
    fk_Cinema_id INTEGER,
    FOREIGN KEY (fk_Cinema_id)
    REFERENCES Cinema (id)
		ON DELETE CASCADE
        ON UPDATE CASCADE,
    
    fk_Salas_id INTEGER,
    FOREIGN KEY (fk_Salas_id)
    REFERENCES Salas (id)
		ON DELETE SET NULL
        ON UPDATE CASCADE
    
) DEFAULT CHARSET = utf8;

CREATE TABLE Ingresso (
    id INTEGER PRIMARY KEY,
    
    fk_Compra_Numero VARCHAR(10),
    FOREIGN KEY (fk_Compra_Numero)
    REFERENCES Compra (Numero)
		ON DELETE CASCADE 
		ON UPDATE CASCADE,
    
    fk_Sessao_id INTEGER,
    FOREIGN KEY (fk_Sessao_id)
    REFERENCES Sessao (id)
		ON DELETE CASCADE
		ON UPDATE CASCADE,
        
    fk_TipoIngresso_id INTEGER,
    FOREIGN KEY (fk_TipoIngresso_id)
    REFERENCES TipoIngresso (id)
		ON DELETE RESTRICT 
		ON UPDATE CASCADE
) DEFAULT CHARSET = utf8;

CREATE TABLE Compra (
    Numero VARCHAR(10) PRIMARY KEY,

	fk_Cliente_id INTEGER,
    FOREIGN KEY (fk_Cliente_id)
    REFERENCES Cliente (id)
		ON DELETE SET NULL 
		ON UPDATE CASCADE,
    
    fk_Pagamento_id INTEGER,
    FOREIGN KEY (fk_Pagamento_id)
    REFERENCES Pagamento (id)
		ON DELETE RESTRICT
		ON UPDATE CASCADE
) DEFAULT CHARSET = utf8;
