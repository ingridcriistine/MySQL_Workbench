create database funcionarios;
use funcionarios;
set SQL_SAFE_UPDATES = 0;

CREATE TABLE funcionarios (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    cargo VARCHAR(50) NOT NULL,
    salario DECIMAL(10, 2) NOT NULL,
    departamento VARCHAR(50) NOT NULL,
    data_contratacao DATE NOT NULL
);

CREATE TABLE historico_cargos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    funcionario_id INT,
    cargo_anterior VARCHAR(50),
    cargo_novo VARCHAR(50),
    salario_anterior DECIMAL(10, 2),
    salario_novo DECIMAL(10, 2),
    data_mudanca TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (funcionario_id) REFERENCES funcionarios(id)
);

CREATE TABLE aumento_salario_audit (
    id INT AUTO_INCREMENT PRIMARY KEY,
    funcionario_id INT,
    salario_antigo DECIMAL(10, 2),
    salario_novo DECIMAL(10, 2),
    data_aumento TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (funcionario_id) REFERENCES funcionarios(id)
);

CREATE TABLE departamentos_estatisticas (
    departamento VARCHAR(50) PRIMARY KEY,
    total_funcionarios INT DEFAULT 0
);



-- 1 - Desenvolva uma trigger que registre todos os aumentos de salário em uma tabela de auditoria chamada aumento_salario_audit. A trigger deve ser acionada antes da atualização do salário e inserir o ID do funcionário, o valor anterior, o valor novo, e a data do aumento.
DELIMITER //
create trigger tg_aumento_salario
after update on funcionarios
for each row
begin
	if((select old.salario from funcionarios where old.id = new.id) != new.salario ) then
		insert into aumento_salario_audit values (default, new.id, (select old.salario from funcionarios where id = new.id), new.salario, curdate());
    end if;
end;
// DELIMITER ;

drop trigger tg_aumento_salario;

select * from funcionarios;
select * from aumento_salario_audit;

insert into funcionarios values (default, 'ingrid', 'aprendiz', '1000', 'ETS', '2024-02-05');
update funcionarios
set salario = '4000'
where id = 1;



-- 2 - Crie uma trigger que, ao alterar o cargo de um funcionário, registre o histórico da mudança na tabela historico_cargos, gravando o cargo anterior e o novo cargo.
DELIMITER //
create trigger tg_cargo_alterado 
after update on funcionarios
for each row
begin
	if(new.cargo != old.cargo ) then
		insert into historico_cargos values (default, old.id, old.cargo, new.cargo, old.salario, new.salario, curdate());
    end if;
end;
// DELIMITER ;

select * from funcionarios;
select * from historico_cargos;

update funcionarios
set cargo = 'meio-oficial',
    salario = '2000'
where id = 1;



-- 3 - Crie uma trigger que, ao inserir ou excluir um funcionário, atualize a tabela departamentos_estatisticas com o número total de funcionários por departamento. A trigger deve incrementar o contador ao inserir um novo funcionário e decrementar ao excluir.  
DELIMITER //
create trigger tg_estatisticas_atualizadas_novo
after insert on funcionarios
for each row
begin
	update departamentos_estatisticas 
    set total_funcionarios = total_funcionarios+1
    where new.departamento = departamento;
    
end;
// DELIMITER ;

DELIMITER //
create trigger tg_estatisticas_atualizadas_antigo
after delete on funcionarios
for each row
begin
	update departamentos_estatisticas 
    set total_funcionarios = total_funcionarios-1
    where old.departamento = departamento;
end;
// DELIMITER ;

select * from departamentos_estatisticas;
select * from funcionarios;

insert into departamentos_estatisticas values 
('ETS', 0),
('RH', 0),
('Logistica', 0);

insert into funcionarios values (default, 'mariana', 'aprendiz', '1000', 'ETS', '2024-02-05');
delete from funcionarios where id = 2;
