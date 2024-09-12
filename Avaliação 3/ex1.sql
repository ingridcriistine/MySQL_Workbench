create database vendas;
use vendas;
set SQL_SAFE_UPDATES = 0;

drop database vendas;

CREATE TABLE permissao (
    id_permissao INT AUTO_INCREMENT PRIMARY KEY,
    descricao VARCHAR(255),
    nivel_permissao INT
);

CREATE TABLE funcionario (
    id_funcionario INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100),
    cpf VARCHAR(15),
    permissao INT,
    FOREIGN KEY (permissao) REFERENCES permissao(id_permissao)
);

CREATE TABLE produtos (
    id_produto INT AUTO_INCREMENT PRIMARY KEY,
    nome INT NOT NULL,
    disponivel VARCHAR(55) NOT NULL,
    quem_cadastrou INT,
    FOREIGN KEY (quem_cadastrou) REFERENCES funcionario(id_funcionario),
    data_insercao date
);

CREATE TABLE vendas (
    id_venda INT AUTO_INCREMENT PRIMARY KEY,
    produto_vendido INT,
    FOREIGN KEY (produto_vendido) REFERENCES produtos(id_produto),
    quem_vendeu INT,
    FOREIGN KEY (quem_vendeu) REFERENCES funcionario(id_funcionario),
    quantidade_produto_vendido INT
);

CREATE TABLE mensagens (
	id_mensagem INT AUTO_INCREMENT PRIMARY KEY,
    mensagem VARCHAR(255)
);

insert into permissao values
(default, 'nivel 1', 1),
(default, 'nivel 2', 2),
(default, 'nivel 3', 3),
(default, 'nivel 4', 4),
(default, 'nivel 5', 5),
(default, 'nivel 6', 6),
(default, 'nivel 7', 7);

insert into produtos values
(default, 01, 'disponivel', 13, curdate()),
(default, 02, 'indisponivel', 15, curdate()),
(default, 03, 'disponivel', 16, curdate()),
(default, 04, 'disponivel', 13, curdate());

insert into mensagens values 
(default, 'Não foi possivel inserir'),
(default, 'Inserido com sucesso!'),
(default, 'Acesso negado'),
(default, 'Alterações bem sucedidas!'),
(default, 'Data incorreta'),
(default, 'Nenhum atributo pode ser nulo'),
(default, 'Produto indisponível'),
(default, 'Vendido com sucesso!'),
(default, 'Solicitação realizada!');

select * from mensagens;


-- Valide se um atributo que é único de um funcionário, como o cpf, venha a repetir ao inserir um novo registro. caso isso ocorra, desfaça a ação e exiba uma mensagem de " não foi possível inserir "
DELIMITER //
create procedure pd_registrar_funcionario (p_nome VARCHAR(100), p_cpf VARCHAR(15), p_permissao INT)
begin
	START TRANSACTION;
    
	if(p_cpf in (select cpf from funcionario)) then
		set @cpfInvalido = true;
	else
		set @cpfInvalido = false;
	end if;
	
	insert into funcionario values (default, p_nome, p_cpf, p_permissao);
	if(@cpfInvalido = false) then
		select mensagem from mensagens where id_mensagem = 2;
		commit;
	else
		select mensagem from mensagens where id_mensagem = 1;
		rollback;
	end if;
end;
// DELIMITER ;

select * from funcionario;

call pd_registrar_funcionario ('ingrid', '123.456.789-12', 3);
call pd_registrar_funcionario ('milena', '123.456.789-12', 3);
call pd_registrar_funcionario ('milena', '133.456.789-12', 3);
call pd_registrar_funcionario ('helena', '111.222.789-12', 1);
call pd_registrar_funcionario ('mari', '111.222.999-12', 5);
call pd_registrar_funcionario ('ju', '111.222.333-12', 5);
call pd_registrar_funcionario ('kau', '111.555.789-12', 1);


-- Permitir ao funcionário com nível de permissão maior que dois altere a disponibilidade de um produto como "disponível" ou "indisponível"
DELIMITER //
create procedure pd_alterar_disponibilidade (p_id_funcionario INT, p_id_produto INT, p_disponivel enum('disponivel', 'indisponivel'))
begin
	START TRANSACTION;
    
	if((select permissao from funcionario where id_funcionario = p_id_funcionario) > 2) then
		set @autorizado = true;
	else
		set @autorizado = false;
	end if;
	
	
    update produtos
	set disponivel = p_disponivel
	where id_produto = p_id_produto;
    
	if(@autorizado = true) then
		select mensagem from mensagens where id_mensagem = 4;
		commit;
	else
		select mensagem from mensagens where id_mensagem = 3;
		rollback;
	end if;
end;
// DELIMITER ;

select * from funcionario;
select * from produtos;
call pd_alterar_disponibilidade (13, 2, 2);
call pd_alterar_disponibilidade (16, 2, 1);



-- Procedimento para um determinado funcionário solicitar uma alteração na tabela de vendas. Este funcionário só pode fazer isso se seu nível de permissão for 5, ou que algum funcionário de nível 5 lhe conceda acesso. caso contrário exiba uma mensagem de erro. Para isso você pode construir novas tabelas.
create table permissoes_acesso (
	id_permissao_acesso INT AUTO_INCREMENT PRIMARY KEY,
    id_responsavel INT,
    FOREIGN KEY (id_responsavel) REFERENCES funcionario(id_funcionario),
    id_funcionario INT,
    FOREIGN KEY (id_funcionario) REFERENCES funcionario(id_funcionario)
);

select * from funcionario;
select * from permissoes_acesso;
insert into permissoes_acesso values 
(default, 18, 13),
(default, 18, 16);

create table solicitacoes_vendas(
	id_solicitacao INT AUTO_INCREMENT PRIMARY KEY,
    descricao VARCHAR(255),
    id_funcionario INT,
    FOREIGN KEY (id_funcionario) REFERENCES funcionario(id_funcionario)
);

DELIMITER //
create procedure pd_alterar_vendas (p_id_venda INT, p_id_funcionario INT, p_id_produto INT, p_id_vendedor INT, p_qtd_vendida INT)
begin
	START TRANSACTION;
    
	if((select permissao from funcionario where id_funcionario = p_id_funcionario) = 5) then
		set @autorizado = true;
	else
		set @autorizado = false;
	end if;
	if(p_id_funcionario in (select id_funcionario from permissoes_acesso)) then
		set @autorizado = true;
	else
		set @autorizado = false;
	end if;
	
    update vendas
	set produto_vendido = p_id_produto,
		quem_vendeu = p_id_vendedor,
        quantidade_produto_vendido = p_qtd_vendida
	where id_venda = p_id_venda;
    
	if(@autorizado = true) then
		select mensagem from mensagens where id_mensagem = 4;
		commit;
	else
		select mensagem from mensagens where id_mensagem = 9;
		rollback;
        insert into solicitacoes_vendas values (default, 'Solicitação de acesso para alterar a tabela vendas', p_id_funcionario);
	end if;
end;
// DELIMITER ;

select * from funcionarios;
select * from vendas;
select * from permissoes_acesso;
select * from solicitacoes_vendas;
call pd_alterar_vendas(1, 13, 1, 15, 5);
call pd_alterar_vendas(1, 18, 1, 16, 5);



-- Validar se uma data de inserção de novo produto é no dia atual, caso não, bloquear a ação e exibir uma mensagem de erro.
DELIMITER //
create procedure pd_registrar_produto (p_nome INT, p_disponivel VARCHAR(55), p_quem INT, p_data date)
begin
	START TRANSACTION;
    
	if(p_data = curdate()) then
		set @dataValida = true;
	else
		set @dataValida = false;
	end if;
	
	insert into produtos values (default, p_nome, p_disponivel, p_quem, p_data);
	if(@dataValida = true) then
		select mensagem from mensagens where id_mensagem = 2;
		commit;
	else
		select mensagem from mensagens where id_mensagem = 5;
		rollback;
	end if;
end;
// DELIMITER ;

select * from mensagens;
select * from produtos;
call pd_registrar_produto(05, 'disponivel', 13, curdate());
call pd_registrar_produto(06, 'disponivel', 13, '2024-09-09');



-- Bloquear ações na tabela de funcionários caso algum atributo seja enviado como NULL.
DELIMITER //
create procedure pd_bloquear_acoes (p_nome VARCHAR(100), p_cpf VARCHAR(15), p_permissao INT)
begin
	START TRANSACTION;
    
	if(p_nome = null) then
		set @atributoNulo = true;
	else
		set @atributoNulo = false;
	end if;
    if(p_cpf = null) then
		set @atributoNulo = true;
	else
		set @atributoNulo = false;
	end if;
    if(p_permissao = null) then
		set @atributoNulo = true;
	else
		set @atributoNulo = false;
	end if;
	
	
    insert into funcionario values (default, p_nome, p_cpf, p_permissao);
	if(@atributoNulo = false) then
		select mensagem from mensagens where id_mensagem = 2;
		commit;
	else
		select mensagem from mensagens where id_mensagem = 6;
		rollback;
	end if;
end;
// DELIMITER ;

select * from funcionario;
select * from produtos;
call pd_bloquear_acoes ('amilton', '112.112.223-56', 2);
call pd_bloquear_acoes (null, null, null);



-- Bloquear uma venda caso um produto esteja cadastrado como indisponível.
DELIMITER //
create procedure pd_realizar_venda (p_id_produto INT, p_id_funcionario INT, p_qtd_vendida INT)
begin
	START TRANSACTION;
    
	if((select disponivel from produtos where id_produto = p_id_produto) = 'disponivel') then
		set @disponivel = true;
	else
		set @disponivel = false;
	end if;
	
	insert into vendas values (default, p_id_produto, p_id_funcionario, p_qtd_vendida);
	if(@disponivel = true) then
		select mensagem from mensagens where id_mensagem = 8;
		commit;
	else
		select mensagem from mensagens where id_mensagem = 7;
		rollback;
	end if;
end;
// DELIMITER ;

select * from mensagens;
select * from produtos;
select * from vendas;
call pd_realizar_venda(3, 13, 5);
call pd_realizar_venda(2, 13, 5);