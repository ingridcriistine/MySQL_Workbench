CREATE DATABASE db_loja_eletronicos;

USE db_loja_eletronicos;

-- Tabela `produtos`
CREATE TABLE produtos (
    id_produto INT PRIMARY KEY AUTO_INCREMENT,
    nome_produto VARCHAR(100) NOT NULL,
    categoria VARCHAR(50) NOT NULL,
    preco DECIMAL(10, 2) NOT NULL,
    quantidade_estoque INT NOT NULL
);

-- Tabela `clientes`
CREATE TABLE clientes (
    id_cliente INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    telefone VARCHAR(20) DEFAULT NULL,
    valor_total_compras DECIMAL(10, 2) DEFAULT 0.00
);

-- Tabela `vendas`
CREATE TABLE vendas (
    id_venda INT PRIMARY KEY AUTO_INCREMENT,
    id_produto INT NOT NULL,
    id_cliente INT NOT NULL,
    data_venda DATE NOT NULL,
    quantidade INT NOT NULL,
    valor_total DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (id_produto) REFERENCES produtos(id_produto),
    FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente)
);

-- Tabela `promocoes`
CREATE TABLE promocoes (
    id_promocao INT PRIMARY KEY AUTO_INCREMENT,
    nome_promocao VARCHAR(100) NOT NULL,
    data_inicio DATE NOT NULL,
    data_fim DATE NOT NULL,
    desconto DECIMAL(5, 2) NOT NULL
);

-- Tabela `notificacoes`
CREATE TABLE notificacoes (
    id_notificacao INT PRIMARY KEY AUTO_INCREMENT,
    mensagem TEXT NOT NULL,
    data_notificacao DATETIME DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO produtos (nome_produto, categoria, preco, quantidade_estoque) VALUES
('Smartphone XYZ', 'Celulares', 699.99, 50),
('Laptop ABC', 'Computadores', 1299.99, 30),
('Tablet Pro', 'Tablets', 399.99, 70),
('Headphones Bluetooth', 'Acessórios', 129.99, 100),
('Smartwatch Series 5', 'Relógios', 249.99, 60),
('Teclado Mecânico RGB', 'Periféricos', 89.99, 150),
('Mouse Gamer', 'Periféricos', 59.99, 200),
('Câmera Digital 4K', 'Câmeras', 499.99, 40),
('Monitor 24 Pol.', 'Monitores', 179.99, 80),
('Estabilizador 1200VA', 'Acessórios', 119.99, 90);

INSERT INTO clientes (nome, email, telefone, valor_total_compras) VALUES
('Ana Silva', 'ana.silva@example.com', '123456789', 1249.97),
('João Souza', 'joao.souza@example.com', '987654321', 2399.99),
('Maria Oliveira', 'maria.oliveira@example.com', '456789123', 399.99),
('Carlos Santos', 'carlos.santos@example.com', '654321987', 349.98),
('Patrícia Costa', 'patricia.costa@example.com', '321654987', 799.99),
('Roberto Lima', 'roberto.lima@example.com', '789456123', 1399.98),
('Fernanda Rocha', 'fernanda.rocha@example.com', '159753468', 299.97),
('Marcos Pereira', 'marcos.pereira@example.com', '753159486', 1199.99),
('Juliana Almeida', 'juliana.almeida@example.com', '951753486', 179.99),
('Ricardo Martins', 'ricardo.martins@example.com', '852741963', 239.99);

INSERT INTO vendas (id_produto, id_cliente, data_venda, quantidade, valor_total) VALUES
(1, 1, '2024-08-01', 1, 699.99),
(2, 2, '2024-08-02', 1, 1299.99),
(3, 3, '2024-08-03', 1, 399.99),
(4, 4, '2024-08-04', 2, 259.98),
(5, 5, '2024-08-05', 1, 249.99),
(6, 6, '2024-08-06', 1, 89.99),
(7, 7, '2024-08-07', 1, 59.99),
(8, 8, '2024-08-08', 1, 499.99),
(9, 9, '2024-08-09', 1, 179.99),
(10, 10, '2024-08-10', 1, 119.99);

INSERT INTO promocoes (nome_promocao, data_inicio, data_fim, desconto) VALUES
('Desconto de Primavera', '2024-03-01', '2024-03-31', 10.00),
('Promoção de Outono', '2024-09-01', '2024-09-30', 15.00),
('Ofertas de Fim de Ano', '2024-12-01', '2024-12-31', 20.00),
('Semana do Computador', '2024-08-01', '2024-08-07', 12.00),
('Liquidação de Verão', '2024-06-01', '2024-06-30', 25.00),
('Promoção de Natal', '2024-12-15', '2024-12-25', 18.00),
('Semana de Ofertas Especiais', '2024-11-01', '2024-11-07', 30.00),
('Desconto em Acessórios', '2024-07-01', '2024-07-15', 8.00),
('Semana de Celulares', '2024-10-01', '2024-10-07', 10.00),
('Ofertas Relâmpago de Black Friday', '2024-11-25', '2024-11-30', 40.00);

INSERT INTO notificacoes (mensagem, data_notificacao) VALUES
('Novo smartphone disponível com desconto!', '2024-08-01 09:00:00'),
('Aproveite a promoção de computadores esta semana!', '2024-08-02 10:00:00'),
('Novo tablet com 20% de desconto até o final do mês!', '2024-08-03 11:00:00'),
('Headphones Bluetooth em promoção por tempo limitado!', '2024-08-04 12:00:00'),
('Smartwatch Series 5 com desconto especial!', '2024-08-05 13:00:00'),
('Teclado mecânico RGB em oferta!', '2024-08-06 14:00:00'),
('Mouse gamer com 15% de desconto!', '2024-08-07 15:00:00'),
('Câmera digital 4K com preço reduzido!', '2024-08-08 16:00:00'),
('Monitor 24 polegadas com oferta imperdível!', '2024-08-09 17:00:00'),
('Estabilizador 1200VA com 10% de desconto!', '2024-08-10 18:00:00');


select * from produtos;
select * from clientes;
select * from vendas;
select * from promocoes;
select * from notificacoes;

-- 1.Registrar uma nova venda e atualizar o valor total de compras por cliente.
DELIMITER //
CREATE trigger trigger_atualiza_valor
after insert on vendas
for each row 
begin
    update clientes 
    set clientes.valor_total_compras = clientes.valor_total_compras + NEW.valor_total
    where clientes.id_cliente = NEW.id_cliente;
end;
// 
DELIMITER ;

INSERT INTO vendas (id_produto, id_cliente, data_venda, quantidade, valor_total) VALUES
(1, 1, '2024-08-14', 1, 699.99);

INSERT INTO vendas (id_produto, id_cliente, data_venda, quantidade, valor_total) VALUES
(1, 2, '2024-08-14', 1, 699.99);


-- 2. Trigger para aplicar desconto de promoção em vendas
DELIMITER //
CREATE trigger trigger_aplica_desconto
before insert on vendas
for each row 
begin
	declare desconto decimal;
    set desconto = 0;
    
    select promocoes.desconto into desconto from promocoes
    where new.data_venda >= promocoes.data_inicio and new.data_venda <= promocoes.data_fim limit 1;
    set new.valor_total = new.valor_total - (new.valor_total * (desconto / 100));
end;
// 
DELIMITER ;

INSERT INTO promocoes (nome_promocao, data_inicio, data_fim, desconto) VALUES
('Desconto de agosto', '2024-08-14', '2024-08-15', 100.00);
INSERT INTO vendas (id_produto, id_cliente, data_venda, quantidade, valor_total) VALUES
(1, 1, '2024-08-14', 1, 699.99);


-- 3.Atualizar o preço médio de um produto após uma nova venda.
ALTER TABLE produtos
add column preco_medio float;

DELIMITER //
create trigger trigger_preco_medio 
after insert on vendas
for each row
begin
	update produtos set preco_medio = (select avg(valor_total) from vendas where id_produto = new.id_produto)
    where id_produto = new.id_produto;
    
end;
//
DELIMITER ;

INSERT INTO vendas (id_produto, id_cliente, data_venda, quantidade, valor_total) VALUES
(1, 2, '2024-08-15', 1, 699.99);


-- 4.Rastrear alterações no estoque de produtos e registrar uma notificação dentro de um log.
DELIMITER //
create trigger trigger_alteracao_estoque
before update on produtos 
for each row
begin
	if(new.quantidade_estoque != (select quantidade_estoque from produtos where id_produto = new.id_produto)) then
		 insert into notificacoes(mensagem, data_notificacao) VALUES 
		 (CONCAT('Estoque alterado: id_produto = ', new.id_produto, ' | qtd_anterior: ', (select quantidade_estoque from produtos where id_produto = new.id_produto), ' | qtd_atual: ', new.quantidade_estoque), curdate());
	end if;
end;
//
DELIMITER ;

update produtos 
set quantidade_estoque = quantidade_estoque + 10
where id_produto = 1;

select * from produtos;
select * from notificacoes;


-- 5.Registrar novos clientes e gerar uma mensagem de usuário cadastrado dentro de um log.
create table log_novoCliente (
	id_novoCliente int primary key not null auto_increment,
    id_cliente int,
    foreign key (id_cliente) references clientes(id_cliente),
    nome VARCHAR(100),
    descricao VARCHAR(100)
);

DELIMITER //
create trigger trigger_novo_cliente
after insert on clientes
for each row
begin
	insert into log_novoCliente(id_cliente, nome, descricao) values
    (new.id_cliente, new.nome, 'Novo cliente adicionado');
end;
// 
DELIMITER ;

INSERT INTO clientes (nome, email, telefone, valor_total_compras) VALUES
('Ingrid Rocha', 'ingrid.rocha@example.com', '123456799', 0);

INSERT INTO clientes (nome, email, telefone, valor_total_compras) VALUES
('Mari Marques', 'mari.rocha@example.com', '123456889', 0);

select * from clientes;
select * from log_novoCliente;


-- 6.Monitorar vendas de produtos em promoção e registrar uma notificação.
DELIMITER //
CREATE trigger trigger_vendas_promocao
after insert on vendas
for each row 
begin
    if(new.data_venda >= (select data_inicio from promocoes where new.data_venda >= data_inicio and new.data_venda <= data_fim LIMIT 1) and new.data_venda <= (select data_fim from promocoes where new.data_venda >= data_inicio and new.data_venda <= data_fim LIMIT 1)) then
		insert into notificacoes(mensagem, data_notificacao) VALUES 
		(CONCAT('Nova venda do produto ', new.id_produto, ' que está em promoção.'), curtime());
    end if;
end;
// 
DELIMITER ;

INSERT INTO vendas (id_produto, id_cliente, data_venda, quantidade, valor_total) VALUES
(1, 1, '2024-08-02', 1, 699.99);

select * from notificacoes;
select * from vendas;

DROP TRIGGER trigger_vendas_promocao

-- 7.Registrar produtos em falta no estoque e gerar uma notificação.
DELIMITER //
create trigger trigger_produto_falta
after update on produtos 
for each row
begin
	if(new.quantidade_estoque = 0) then
		insert into notificacoes(mensagem, data_notificacao) VALUES 
		(CONCAT('O produto ', new.nome_produto, ' (id_produto: ', new.id_produto, ') está em falta no estoque'), curtime());
    end if;
end;
// 
DELIMITER ;

update produtos 
set quantidade_estoque = 0
where id_produto = 2;

select * from notificacoes;


-- 8.Atualizar o valor total de vendas de um produto após uma nova venda.
ALTER TABLE produtos
add column total_vendas float;

DELIMITER //
create trigger trigger_total_vendas
after insert on vendas
for each row
begin
	update produtos
    set total_vendas = (select sum(valor_total) from vendas where id_produto = new.id_produto)
    where id_produto = new.id_produto;
end;
// 
DELIMITER ;

INSERT INTO vendas (id_produto, id_cliente, data_venda, quantidade, valor_total) VALUES
(5, 5, '2024-08-15', 1, 249.99);

INSERT INTO vendas (id_produto, id_cliente, data_venda, quantidade, valor_total) VALUES
(5, 5, '2024-08-18', 1, 249.99);

select * from produtos;
select * from vendas;


-- 9.Rastrear alterações no valor de produtos e registrar uma notificação.
DELIMITER //
create trigger trigger_valor_alterado
before update on produtos
for each row
begin
	if(new.preco != (select preco from produtos where id_produto = new.id_produto)) then
		insert into notificacoes(mensagem, data_notificacao) VALUES 
		(CONCAT('O preco do produto ', new.nome_produto, ' (id_produto: ', new.id_produto, ') foi alterado.'), curtime());
    end if;
end;
// DELIMITER ;

drop trigger trigger_valor_alterado;

update produtos
set preco = 100.00
where id_produto = 10;

select * from produtos;
select * from notificacoes;
