create database Academia_morebuilder; 

create table cliente (
cli_id INT AUTO_INCREMENT PRIMARY KEY,
cli_nome varchar(100),
cli_cpf varchar(20),
cli_endereço varchar (100),
cli_telefone varchar(20),
cli_obs varchar(200),
-- fazer trigger, somar +1 no total comprado para cada suplemento comprado
cli_total_comp int 
);

insert into cliente (cli_nome,cli_cpf,cli_endereço,cli_telefone,cli_obs)
values ('Vagner', '123.456.789-00', 'Rua Mario Augusto, 772. Mochila.', '(75)98823-4567', 'Foco: perder peso.');
insert into cliente (cli_nome,cli_cpf,cli_endereço,cli_telefone,cli_obs)
values ('Andressa', '987.654.321-00', 'Rua Lorenzo Piote, 314. Jardim Acacia.', '(71)99181-5447', 'Foco: Ganhar massa.');
insert into cliente (cli_nome,cli_cpf,cli_endereço,cli_telefone,cli_obs)
values ('Mauta', '879.654.123-00', 'Rua Venus, 1023. Mochila.', '(75)3011-1010', 'Foco: manter peso.');

create table funcionario (
func_id int auto_increment primary key,
func_nome varchar(100),
func_cpf varchar(20),
func_nasc date,
func_salario float
);

insert into funcionario (func_nome,func_cpf,func_nasc,func_salario)
values ('Ronnie', '843.951.762-11', '1990-02-17', '1250');
insert into funcionario (func_nome,func_cpf,func_nasc,func_salario)
values ('Arnold', '321.456.987-22', '1994-07-21', '1250');

create table plano (
plano_id int auto_increment primary key,
plano_nome varchar (50),
plano_preco float
);

insert into plano (plano_nome, plano_preco)
values ('mensal', '80');
insert into plano (plano_nome, plano_preco)
values ('trimensal', '200');
insert into plano (plano_nome, plano_preco)
values ('anual', '650');

create table forma_pagamento 
(
fpag_id INT AUTO_INCREMENT PRIMARY KEY,
fpag_nome varchar(50)
);

insert into forma_pagamento (fpag_nome)
values ('Credito');
insert into forma_pagamento (fpag_nome)
values ('Debito');
insert into forma_pagamento (fpag_nome)
values ('Pix');
insert into forma_pagamento (fpag_nome)
values ('Cheque');
insert into forma_pagamento (fpag_nome)
values ('Outros');

-- fazer trigger de atualizar estoque: saida e entrada.
create table Estoque (
estoque_id int auto_increment primary key,
estoque_nome varchar (100),
estoque_lote int,
estoque_data_fab date,
estoque_data_val date,
estoque_obs varchar (100),
estoque_quantidade float
);

insert into Estoque (estoque_nome, estoque_lote,estoque_data_fab,estoque_data_val,estoque_obs,estoque_quantidade)
values ('Suplemento','01', '2024-01-01', '2025-01-01', 'N/A', '3');
insert into Estoque (estoque_nome, estoque_lote,estoque_data_fab,estoque_data_val,estoque_obs,estoque_quantidade)
values ('Drogas','01', '2024-01-01', '2024-09-24', 'Fragil.', '2');
insert into Estoque (estoque_nome, estoque_lote,estoque_data_fab,estoque_data_val,estoque_obs,estoque_quantidade)
values ('Alimenticios', '01', '2024-01-01', '2024-03-17', 'Manter em temperatura ambiente', '4');


create table exercicios (
exer_id int auto_increment primary key,
exer_nome varchar(100),
exer_num_exercicios int,
exer_series int,
exer_rep int
);

insert into exercicios (exer_nome,exer_num_exercicios,exer_series,exer_rep)
values ('Peito', '5 ', '3', '12');
insert into exercicios (exer_nome,exer_num_exercicios,exer_series,exer_rep)
values ('Pernas', '7 ', '4', '9');
insert into exercicios (exer_nome,exer_num_exercicios,exer_series,exer_rep)
values ('Biceps', '4 ', '3', '15');
insert into exercicios (exer_nome,exer_num_exercicios,exer_series,exer_rep)
values ('Triceps', '4 ', '3', '15');
insert into exercicios (exer_nome,exer_num_exercicios,exer_series,exer_rep)
values ('Cardio', '2', '1', '0');

create table produtos (
prod_id int auto_increment primary key,
prod_nome varchar (100),
prod_preco float,
prod_fk_estoque int,
foreign key (prod_fk_estoque) references estoque (estoque_id)
);

insert into produtos (prod_nome,prod_preco,prod_fk_estoque)
values ('creatina', '79.99', 1);
insert into produtos (prod_nome,prod_preco,prod_fk_estoque)
values ('beta-alanina', '54.49', 1);

insert into produtos (prod_nome,prod_preco,prod_fk_estoque)
values ('termogenico 120cap', '70', 2);
insert into produtos (prod_nome,prod_preco,prod_fk_estoque)
values ('ioimbina 60cap', '29.99', 2);

insert into produtos (prod_nome,prod_preco,prod_fk_estoque)
values ('Barra proteica 20g', '10', 3);
insert into produtos (prod_nome,prod_preco,prod_fk_estoque)
values ('Whey zero 500g', '149.99', 3);

create table instrutor (
inst_id int auto_increment primary key,
inst_fk_funcionario int,
inst_dias varchar(50),
inst_valor float,
-- fazer trigger para cada cliente que estiver sendo seu aluno
inst_num_cli int,
foreign key (inst_fk_funcionario) references funcionario (func_id)
);


insert into instrutor (inst_fk_funcionario,inst_dias,inst_valor)
values (1, 'Seg, Ter, Sex', '149.49' );

CREATE VIEW vw_ver_instrutor AS
SELECT func_id AS id_funcionario, func_nome AS nome_funcionario,
       inst_dias AS dias_instrutor, inst_valor AS valor_instrutor
FROM funcionario
LEFT JOIN instrutor ON funcionario.func_id = instrutor.inst_fk_funcionario;




create table itens_venda (
iven_id int auto_increment primary key,
iven_quantidade int,
iven_fk_produto int,

foreign key (iven_fk_produto) references produtos (prod_id)
);

insert into itens_venda (iven_quantidade,iven_fk_produto)
values ('1', 1);
insert into itens_venda (iven_quantidade,iven_fk_produto)
values ('2', 4);
insert into itens_venda (iven_quantidade,iven_fk_produto)
values ('4', 5);





create table venda(
vend_id int auto_increment primary key,
vend_total float,
vend_data date,
vend_fk_cliente int,
vend_fk_fpag int,
vend_fk_funcionario int,

foreign key (vend_fk_cliente) references cliente (cli_id),
foreign key (vend_fk_fpag) references forma_pagamento (fpag_id),
foreign key (vend_fk_funcionario) references funcionario (func_id)
);

CREATE VIEW vw_detalhes_da_venda AS
SELECT iven_id, iven_quantidade, prod_nome AS nome_produto, prod_preco AS preço,
       estoque_nome AS tipo_produto, estoque_data_fab AS data_fabricacao,
       estoque_data_val AS validade, estoque_obs AS observacao
FROM itens_venda
JOIN produtos ON itens_venda.iven_fk_produto = produtos.prod_id
JOIN Estoque ON produtos.prod_fk_estoque = Estoque.estoque_id;




create table ficha_de_treino (
ftrein_id INT AUTO_INCREMENT PRIMARY KEY,
ftrein_fk_plano int,
ftrein_fk_cliente int,
ftrein_ultimo_treino date,
ftrein_renovacao_plano date,
ftrein_fim_plano date,
ftrein_fk_instrutor int,
ftrein_fk_exercicio int,

foreign key (ftrein_fk_plano) references plano (plano_id),
foreign key (ftrein_fk_cliente) references cliente (cli_id),
foreign key (ftrein_fk_instrutor) references instrutor (inst_id),
foreign key (ftrein_fk_exercicio) references exercicios (exer_id)
);

insert into ficha_de_treino (ftrein_fk_plano,ftrein_fk_cliente,ftrein_ultimo_treino,ftrein_renovacao_plano,ftrein_fim_plano,ftrein_fk_instrutor,ftrein_fk_exercicio)
values(1,1, '2024-03-18', '2024-03-01', '2024-04-01', 1, 5);
insert into ficha_de_treino (ftrein_fk_plano,ftrein_fk_cliente,ftrein_ultimo_treino,ftrein_renovacao_plano,ftrein_fim_plano,ftrein_fk_exercicio)
values(2,2, '2024-02-29', '2024-02-17', '2024-05-17', 3);
insert into ficha_de_treino (ftrein_fk_plano,ftrein_fk_cliente,ftrein_ultimo_treino,ftrein_renovacao_plano,ftrein_fim_plano,ftrein_fk_exercicio)
values(3,3, '2024-03-01', '2024-01-01', '2025-01-01', 2);

CREATE VIEW vw_ver_plano AS
SELECT ftrein_id AS ficha_do_usuario, cli_nome AS nome,
       ftrein_renovacao_plano AS data_da_renovacao, ftrein_fim_plano AS data_de_encerramento,
       plano_nome AS plano, plano_preco AS valor
FROM cliente
INNER JOIN ficha_de_treino ON ftrein_fk_cliente = cli_id
INNER JOIN plano ON ftrein_fk_plano = plano_id;



CREATE VIEW vw_ver_treino AS
SELECT ftrein_id AS ficha_do_usuario, cli_nome AS nome,
       ftrein_fk_instrutor AS instrutor,
       exer_nome AS treino, exer_num_exercicios AS numero_exercicios,
       exer_series as series, exer_rep as repeticoes
FROM cliente
INNER JOIN ficha_de_treino ON cli_id = ftrein_fk_cliente
INNER JOIN instrutor ON ftrein_fk_instrutor = inst_id
INNER JOIN exercicios ON ftrein_fk_exercicio = exer_id;

-- clientes, ficha de treino, plano

-- views

select*from vw_ver_instrutor;
select*from vw_detalhes_da_venda;
select*from vw_ver_plano;
select*from vw_ver_treino;

-- trigger

DELIMITER $
CREATE TRIGGER atualizar_estoque AFTER INSERT ON itens_venda
FOR EACH ROW
BEGIN
    UPDATE Estoque
    SET estoque_quantidade = estoque_quantidade - NEW.iven_quantidade
    WHERE estoque_id = (SELECT prod_fk_estoque FROM produtos WHERE prod_id = NEW.iven_fk_produto);
END$

DELIMITER ;

DELIMITER $
CREATE TRIGGER devolucao_estoque AFTER DELETE ON itens_venda
FOR EACH ROW
BEGIN
    UPDATE Estoque
    SET estoque_quantidade = estoque_quantidade + OLD.iven_quantidade
    WHERE estoque_id = (SELECT prod_fk_estoque FROM produtos WHERE prod_id = OLD.iven_fk_produto);
END$

DELIMITER ;

DELIMITER $

CREATE TRIGGER atualizar_total_comp AFTER INSERT ON itens_venda
FOR EACH ROW
BEGIN
    UPDATE cliente
    SET cli_total_comp = cli_total_comp + 1
    WHERE cli_id = (SELECT vend_fk_cliente FROM venda WHERE vend_id = NEW.vend_id);
END$

DELIMITER ;

DELIMITER $
CREATE TRIGGER instrutor_numero_cliente AFTER INSERT ON ficha_de_treino
FOR EACH ROW
BEGIN
    UPDATE instrutor
    SET inst_num_cli = inst_num_cli + 1
    WHERE inst_id = NEW.ftrein_fk_instrutor;
END$

DELIMITER ;