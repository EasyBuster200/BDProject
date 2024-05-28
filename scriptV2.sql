drop table modelos cascade constraints;
drop table contas cascade constraints;
drop table clientes cascade constraints;
drop table cartoes cascade constraints;
drop table utiliza cascade constraints;
drop table condutores cascade constraints;
drop table veiculos cascade constraints;
drop table carros cascade constraints;
drop table motas cascade constraints;
drop table pedidos cascade constraints;
drop table viagem cascade constraints;
drop table entregacomida cascade constraints;
drop table restaurantes cascade constraints;
drop table menus cascade constraints;
drop table artigos cascade constraints;

-- Create table 'modelos'
CREATE TABLE modelos (
    nome VARCHAR2(30) NOT NULL,
    marca VARCHAR2(30) NOT NULL,
    PRIMARY KEY (nome, marca)
);

-- Create table 'contas'
CREATE TABLE contas (
    email VARCHAR2(30) NOT NULL,
    ntelefone VARCHAR2(14) PRIMARY KEY,
    nome VARCHAR2(30) NOT NULL
);

-- Create table 'clientes'
CREATE TABLE clientes (
    ntelefone VARCHAR2(14) PRIMARY KEY REFERENCES contas(ntelefone)
);

-- Create table 'cartoes'
CREATE TABLE cartoes (
    ncartao NUMBER(16, 0) PRIMARY KEY,
    cvc NUMBER(3, 0) NOT NULL,
    dataval DATE NOT NULL
);

-- Create table 'utiliza'
CREATE TABLE utiliza (
    ntelefone VARCHAR2(14) NOT NULL,
    ncartao NUMBER(16, 0) NOT NULL,
    PRIMARY KEY (ntelefone, ncartao),
    FOREIGN KEY (ntelefone) REFERENCES clientes(ntelefone),
    FOREIGN KEY (ncartao) REFERENCES cartoes(ncartao)
);

-- Create table 'condutores'
CREATE TABLE condutores (
    ntelefone VARCHAR2(14) PRIMARY KEY REFERENCES contas(ntelefone),
    ncartacond VARCHAR2(20) NOT NULL,
    dataval DATE NOT NULL,
    nestrelas SMALLINT,
    matr VARCHAR2(6) NOT NULL,
    FOREIGN KEY (matr) REFERENCES veiculos(matr) --? Acho que temos de adicionar isto com um alter table, pois at this momnet a tabela veiculos não existe
);

-- Create table 'veiculos'
CREATE TABLE veiculos (
    matr VARCHAR2(6) PRIMARY KEY,
    nome VARCHAR2(30) NOT NULL,
    marca VARCHAR2(30) NOT NULL,
    telCondutor VARCHAR2(14) NOT NULL,
    FOREIGN KEY (nome, marca) REFERENCES modelos(nome, marca),
    FOREIGN KEY (telCondutor) REFERENCES condutores(ntelefone)
);

-- Create table 'carros'
CREATE TABLE carros (
    matr VARCHAR2(6) PRIMARY KEY REFERENCES veiculos(matr),
    nlugares SMALLINT NOT NULL,
    cor VARCHAR2(30) NOT NULL
);

-- Create table 'motas'
CREATE TABLE motas (
    matr VARCHAR2(6) PRIMARY KEY REFERENCES veiculos(matr)
);

-- Create table 'pedidos'
CREATE TABLE pedidos (
    idp NUMBER(10, 0) PRIMARY KEY,
    valortotal DECIMAL(4, 2) NOT NULL,
    tempo_in_sec INT NOT NULL,
    destino VARCHAR2(30) NOT NULL,
    telCliente VARCHAR2(14) NOT NULL,
    telCondutor VARCHAR2(14) NOT NULL,
    FOREIGN KEY (telCliente) REFERENCES clientes(ntelefone),
    FOREIGN KEY (telCondutor) REFERENCES condutores(ntelefone)
);

-- Create table 'viagem'
CREATE TABLE viagem (
    origem VARCHAR2(30) NOT NULL,
    idp NUMBER(10, 0) NOT NULL PRIMARY KEY REFERENCES pedidos(idp)
);

-- Create table 'entregacomida'
CREATE TABLE entregacomida (
    idp NUMBER(10, 0) NOT NULL PRIMARY KEY REFERENCES pedidos(idp),
    idrestr NUMBER(5, 0) NOT NULL
);

-- Create table 'restaurantes'
CREATE TABLE restaurantes (
    idrestr NUMBER(5, 0) PRIMARY KEY,
    nome VARCHAR2(30) NOT NULL,
    endereco VARCHAR2(30) NOT NULL,
    idMenu NUMBER(5, 0) NOT NULL,
    FOREIGN KEY (idMenu) REFERENCES menus(idmenu)
);

-- Create table 'menus'
CREATE TABLE menus (
    idmenu NUMBER(5, 0) PRIMARY KEY,
    FOREIGN KEY (idrestr) REFERENCES restaurantes(idrestr)
);

-- Create table 'artigos'
CREATE TABLE artigos (
    idartigo NUMBER(10, 0) PRIMARY KEY,
    nome VARCHAR2(30) NOT NULL,
    preco DECIMAL(4, 2) NOT NULL,
    idmenu NUMBER(5, 0) NOT NULL,
    FOREIGN KEY (idmenu) REFERENCES menus(idmenu)
);

-- Constraints
alter table condutores add constraint numEstr check(nestrelas >= 1 and nestrelas <=5);
alter table condutores add constraint carta_valida check (dataval >= CURRENT_DATE);
alter table carros add constraint num_lugar check (nlugares >= 3);
alter table pedidos add constraint tempo_pos check (tempo > 0);
alter table pedidos add constraint valor_pos check (valortotal > 0);
alter table cartoes add constraint cartao_valido check (dataval >= CURRENT_DATE);
alter table artigos add constraint preco_pos check (preco > 0);

--Sequences 
create sequence seq_idp start with 0000000000 increment by 1;

create sequence seq_idrestr start with 00000 increment by 1;

create sequence seq_idmenu start with 00000 increment by 1;

create sequence seq_idartigo start with 0000000000 increment by 1;


CREATE OR REPLACE TRIGGER no_assoc_card
BEFORE INSERT OR UPDATE ON pedidos
FOR EACH ROW
DECLARE
    cardCount NUMBER;
BEGIN
    SELECT COUNT(*)
    INTO cardCount
    FROM utiliza 
    WHERE ntelefone = :new.telCliente;

    IF cardCount = 0 THEN
        raise_application_error(-20100, 'O cliente não tem um cartão associado');
    END IF;
END;
/

CREATE OR REPLACE TRIGGER pertence_restr
BEFORE INSERT OR UPDATE ON entregacomida
FOR EACH ROW
BEGIN
  IF :new.idartigo IS NOT NULL THEN
    SELECT 1 INTO FOUND
    FROM artigos a
    JOIN menus m ON a.idmenu = m.idmenu
    WHERE a.idartigo = :new.idartigo
      AND m.idrestr = :new.idrestr;

    IF FOUND IS NULL THEN
      RAISE_APPLICATION_ERROR(-20001, 'Artigo não pertence ao restaurante associado');
    END IF;
  END IF;
END;
/

