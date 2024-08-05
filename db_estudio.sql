create database db_estudio;

use db_estudio;

CREATE TABLE tb_estudio ( 
	IDEstudio INT NOT NULL PRIMARY KEY, 
	Nome VARCHAR(45) NOT NULL,
	Proprietario VARCHAR(45) NOT NULL,
	FaturamentoAnoAnterior DECIMAL(10,2) NOT NULL,
	DataFundacao DATE NOT NULL
) DEFAULT CHARSET=utf8;

CREATE TABLE tb_filmes ( 
	IDFilme INT NOT NULL PRIMARY KEY, 
	Meses INT NOT NULL,
	Nome VARCHAR(45) NOT NULL, 
    AnoLancamento YEAR NOT NULL,
	CustoTotal DECIMAL(10,2) NOT NULL,
	IDEstudio INT NOT NULL, FOREIGN KEY (IDEstudio) REFERENCES tb_estudio(IDEstudio)
) DEFAULT CHARSET=utf8;

CREATE TABLE tb_atores ( 
	IDAtor INT NOT NULL PRIMARY KEY,
	Nome VARCHAR(45) NOT NULL,
	Nacionalidade VARCHAR(45) NOT NULL,
	Idade INT NOT NULL, Sexo CHAR(1) NOT NULL
) DEFAULT CHARSET=utf8;

CREATE TABLE tb_papel (
	IDPapel INT NOT NULL PRIMARY KEY,
	CacheAtor DECIMAL(10,2) NOT NULL,
	Personagem VARCHAR(45) NOT NULL,
	IDAtor INT NOT NULL, 
    IDFilme INT NOT NULL, 
    FOREIGN KEY (IDAtor) REFERENCES tb_atores (IDAtor),
	FOREIGN KEY (IDFilme) REFERENCES tb_filmes (IDFilme)
) DEFAULT CHARSET=utf8;

INSERT INTO tb_estudio (IDEstudio, Nome, Proprietario, FaturamentoAnoAnterior, DataFundacao) VALUES
(1, 'Warner Bros.', 'John Stankey', 2500000.00, '1923-04-04'),
(2, 'Universal Pictures', 'Jeff Shell', 3000000.00, '1912-06-08'),
(3, 'Paramount Pictures', 'Brian Robbins', 2800000.00, '1912-05-08'),
(4, '20th Century Fox', 'James Murdoch', 2200000.00, '1935-05-31'),
(5, 'Sony Pictures', 'Tony Vinciquerra', 2100000.00, '1987-10-07'),
(6, 'Netflix', 'Reed Hastings', 5000000.00, '1997-08-29'),
(7, 'Disney', 'Bob Chapek', 4900000.00, '1923-10-16'),
(8, 'Lionsgate', 'Jon Feltheimer', 1300000.00, '1997-07-10');

INSERT INTO tb_filmes (IDFilme, Meses, Nome, AnoLancamento, CustoTotal, IDEstudio) VALUES
 (1, 18, 'The Batman', 2022, 18500000.00, 1),
 (2, 12, 'Jurassic World: Dominion', 2022, 16000000.00, 2), 
(3, 15, 'Mission: Impossible - Fallout', 2018, 17800000.00, 3),
 (4, 20, 'Avatar', 2009, 23700000.00, 4), 
(5, 10, 'Spider-Man: No Way Home', 2021, 20500000.00, 5), 
(6, 24, 'Red Notice', 2021, 22000000.00, 6),
 (7, 16, 'Frozen II', 2019, 15000000.00, 7), 
(8, 14, 'John Wick: Chapter 3 – Parabellum', 2019, 7500000.00, 8), 
(9, 11, 'Tenet', 2020, 21000000.00, 1), 
(10, 12, 'Fast & Furious 9', 2021, 25000000.00, 2), 
(11, 18, 'Top Gun: Maverick', 2022, 17000000.00, 3), 
(12, 13, 'Deadpool', 2016, 5800000.00, 4), (13, 16, 'Jumanji: The Next Level', 2019, 13200000.00, 5), 
(14, 12, 'The Irishman', 2019, 15900000.00, 6), (15, 17, 'Black Panther', 2018, 20000000.00, 7),
 (16, 9, 'Knives Out', 2019, 4000000.00, 8);

INSERT INTO tb_atores (IDAtor, Nome, Nacionalidade, Idade, Sexo) VALUES 
(1, 'Robert Pattinson', 'Britânica', 36, 'M'),
(2, 'Chris Pratt', 'Americana', 44, 'M'), 
(3, 'Tom Cruise', 'Americana', 61, 'M'), 
(4, 'Sam Worthington', 'Australiana', 47, 'M'),
(5, 'Tom Holland', 'Britânica', 27, 'M'), 
(6, 'Dwayne Johnson', 'Americana', 52, 'M'), 
(7, 'Idina Menzel', 'Americana', 53, 'F'), 
(8, 'Keanu Reeves', 'Canadense', 59, 'M'), 
(9, 'John David Washington', 'Americana', 39, 'M'), 
(10, 'Vin Diesel', 'Americana', 56, 'M'), 
(11, 'Tom Cruise', 'Americana', 61, 'M'),
(12, 'Ryan Reynolds', 'Canadense', 47, 'M'),
(13, 'Dwayne Johnson', 'Americana', 52, 'M'),
(14, 'Joe Pesci', 'Americana', 81, 'M'), 
(15, 'Chadwick Boseman', 'Americana', 43, 'M'),
(16, 'Chris Evans', 'Americana', 43, 'M'), 
(17, 'Ana de Armas', 'Cubana', 36, 'F'), 
(18, 'Chris Hemsworth', 'Australiana', 40, 'M');

INSERT INTO tb_papel (IDPapel, CacheAtor, Personagem, IDAtor, IDFilme) VALUES (1, 120000.00, 'Bruce Wayne / Batman', 1, 1), 
(2, 160000.00, 'Owen Grady', 2, 2), 
(3, 250000.00, 'Ethan Hunt', 3, 3), 
(4, 60000.00, 'Jake Sully', 4, 4), 
(5, 45000.00, 'Peter Parker / Spider-Man', 5, 5),
 (6, 230000.00, 'John Hartley', 6, 6), 
(7, 7500.00, 'Elsa', 7, 7),
 (8, 140000.00, 'John Wick', 8, 8), 
(9, 110000.00, 'The Protagonist', 9, 9), 
(10, 130000.00, 'Dominic Toretto', 10, 10), 
(11, 220000.00, 'Maverick', 11, 11), 
(12, 140000.00, 'Wade Wilson / Deadpool', 12, 12),
 (13, 200000.00, 'Spencer', 13, 13), 
(14, 120000.00, 'Frank Sheeran', 14, 14),
 (15, 250000.00, 'T\'Challa / Black Panther', 15, 15), 
(16, 150000.00, 'Ransom Drysdale', 16, 16);

show tables;


-- Quais são os estúdios cadastrados no banco de dados?
SELECT nome from tb_estudio;


-- Quantos filmes foram lançados em cada ano?
SELECT 
	AnoLancamento as 'Ano de lançamento',
    COUNT(AnoLancamento) as 'Qtd. Lançamento'

    from tb_filmes
    group by AnoLancamento;
    
    
-- Quais são os atores estrangeiros no banco de dados e quantos são?
SELECT 
    Nacionalidade as 'Nacionalidade',
    COUNT(*) as 'Qtd de estrangeiros'
    
    from tb_atores 
    where Nacionalidade != 'Americana'
    group by Nacionalidade;


-- Qual é o filme mais recente lançado?
SELECT 
	Nome as 'Filme mais recente',
    AnoLancamento as 'Ano de Lançamento'
    from tb_filmes
    order by AnoLancamento DESC
    LIMIT 1;
    
    
-- Quais são os estúdios que tiveram um faturamento superior a 1 milhão no ano anterior?
SELECT 
	Nome as 'Nome Estudio',
    FaturamentoAnoAnterior as 'Faturamento Anterior'
    
    from tb_estudio
    where FaturamentoAnoAnterior > 1000000;


-- Quantos atores têm menos de 30 anos?
SELECT 
	COUNT(Idade) as 'Qtd atores com menos de 30 anos'
    
    from tb_atores
    where Idade < 30
    group by Idade;
 
 
-- Qual é a média de meses de produção dos filmes?
SELECT
	AVG(Meses) as 'Media de meses'
    from tb_filmes;


-- Qual é o filme em que um ator recebeu o maior cachê?
SELECT
	tb_filmes.Nome as 'Filme',
    CacheAtor as 'Maior Cache'
    
    from tb_papel
    inner join tb_filmes
    on tb_papel.IDFilme = tb_filmes.IDFilme
    
    order by CacheAtor desc
    limit 2;
	

-- Quais são os filmes que foram lançados nos últimos 5 anos?
SELECT 
	Nome as 'Filme',
    AnoLancamento as 'Ano de Lançamento'
    
    from tb_filmes
    where AnoLancamento > 2017;


-- Qual é o estúdio com a data de fundação mais recente?
SELECT
	Nome as 'Estudio',
    DataFundacao as 'Data de Fundação'
    
    from tb_estudio 
    order by DataFundacao desc
    limit 1;
	

-- Quais são os atores que já atuaram em mais de 5 filmes?
SELECT
	tb_atores.Nome as 'Ator',
    COUNT(tb_papel.IDAtor) as 'Qtd de filmes'
    
    from tb_papel
    inner join tb_atores
    on tb_papel.IDAtor = tb_atores.IDAtor
    
    group by tb_papel.IDAtor, tb_atores.Nome
    having COUNT(tb_papel.IDAtor) > 5;
    

-- Qual é o custo médio total dos filmes produzidos por cada estúdio?
SELECT
	tb_estudio.Nome as 'Estudio',
    AVG(tb_filmes.CustoTotal) as 'Custo medio total'
    
    from tb_filmes
    inner join tb_estudio
    on tb_filmes.IDEstudio = tb_estudio.IDEstudio
    
    group by tb_estudio.Nome;
	

-- Quais são os atores brasileiros que têm mais de 40 anos?
SELECT
	Nome as 'Ator',
    Nacionalidade,
    Idade
    
    from tb_atores
    where Nacionalidade = 'Americana' and Idade > 40;
    

-- Quais são os filmes e seus custos totais, ordenados pelo custo total em ordem crescente?
SELECT
	Nome as 'Filme',
    CustoTotal as 'Custo Total'
    
    from tb_filmes
    order by CustoTotal;


-- Quantos atores têm a letra inicial do seu nome entre K e W?
SELECT
	COUNT(Nome) as 'Qtd de Atores'
    
    from tb_atores
    where Nome between 'K%' and 'W%';


-- Quantos filmes têm custo total entre $100.00 e $500.00?
SELECT
	COUNT(IDFilme) as 'Qtd de filmes'
    
    from tb_filmes
    where CustoTotal between 10000.00 and 50000.00;


-- Quantos estúdios têm um faturamento no ano anterior superior a $1 milhão e uma data de fundação anterior a 2000?
SELECT
	COUNT(IDEstudio) as 'Qtd de Estudios'
    
    from tb_estudio
    where FaturamentoAnoAnterior > 1000000 and DataFundacao < 2000;
