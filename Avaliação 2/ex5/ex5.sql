use db_loja;

-- 1 - Ao registrar um novo veículo, crie um registro ("Veículo x cadastrado na data de xx/xx/xxxx")
create table novoVeiculo (
	id int primary key not null auto_increment, 
    mensagem varchar(255)
);

DELIMITER //
CREATE TRIGGER logNovoVeiculo
AFTER insert ON veiculos
FOR EACH ROW
BEGIN
    insert into novoVeiculo(mensagem) values 
    (concat('Veiculo ', new.modelo, ' cadastrado na data de ', curdate()));
END;
// DELIMITER ;

select * from novoVeiculo;

INSERT INTO `veiculos` (`id`, `id_marca`, `modelo`, `ano`, `preco`, `cor`) VALUES
(19, 1, 'Corolla', 2020, '85000.00', 'Roxo');


-- 2 - Ao deletar um usuário, salve os dados importantes dentro de uma tabela chamada "deleted_users"
create table deleted_users (
	id int primary key not null auto_increment, 
    nome varchar(255),
    telefone varchar(20),
    data_remocao date
);

DELIMITER //
CREATE TRIGGER logClienteRemovido
AFTER delete ON clientes
FOR EACH ROW
BEGIN
    insert into deleted_users(nome, telefone, data_remocao) values 
    (old.nome, old.telefone, curdate());
END;
// DELIMITER ;

select * from deleted_users;

delete from clientes where id = 2;


-- 3 - Criar um log de cada vez que o dado de algum veículo for alterado e exibir uma mensagem de ("Veículo x teve alterações no item x. valor antigo: x, valor novo: x")
create table alteracaoVeiculo (
	id int primary key not null auto_increment, 
    mensagem varchar(255)
);

DELIMITER //
CREATE TRIGGER logVeiculoAlterado
AFTER update ON veiculos
FOR EACH ROW
BEGIN
    insert into alteracaoVeiculo(mensagem) values 
    (concat('Veiculo ', new.modelo, ' teve alterações em um item','. Valor antigo: ', old.cor, ', valor novo: ', new.cor));
END;
// DELIMITER ;

select * from alteracaoVeiculo;

update veiculos
set cor = 'Vermelho'
where id = 2;

-- 4 - Cada vez que um veículo for vendido, exiba uma mensagem para seu cliente o parabenizando que contenha seu nome, nome do veículo.
create table veiculoVendido (
	id int primary key not null auto_increment, 
    mensagem varchar(255)
);

DELIMITER //
CREATE TRIGGER logVeiculoVendido
AFTER insert ON vendas
FOR EACH ROW
BEGIN
    insert into veiculoVendido(mensagem) values 
    (concat('Parabéns ', (select nome from clientes where id = new.id_cliente), '! Você acaba de adquirir um ', (select modelo from veiculos where id = new.id_veiculo)));
END;
// DELIMITER ;

select * from veiculoVendido;

INSERT INTO `vendas` (`id`, `id_veiculo`, `id_cliente`, `data_venda`) VALUES
(16, 1, 1, '2024-08-16')
