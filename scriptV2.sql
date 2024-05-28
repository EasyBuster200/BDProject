-- Create table 'modelos'
CREATE TABLE modelos (
    nome VARCHAR2(30) NOT NULL,
    marca VARCHAR2(30) NOT NULL,
    PRIMARY KEY (nome, marca)
);

-- Create table 'contas'
CREATE TABLE contas (
    email VARCHAR2(30) NOT NULL,
    ntelefone NUMBER(14, 0) PRIMARY KEY,
    nome VARCHAR2(30) NOT NULL
);

-- Create table 'clientes'
CREATE TABLE clientes (
    ntelefone NUMBER(14, 0) PRIMARY KEY REFERENCES contas(ntelefone)
);

-- Create table 'cartoes'
CREATE TABLE cartoes (
    ncartao NUMBER(16, 0) PRIMARY KEY,
    cvc NUMBER(3, 0) NOT NULL,
    dataval DATE NOT NULL
);

-- Create table 'utiliza'
CREATE TABLE utiliza (
    ntelefone NUMBER(14, 0) NOT NULL,
    ncartao NUMBER(16, 0) NOT NULL,
    PRIMARY KEY (ntelefone, ncartao),
    FOREIGN KEY (ntelefone) REFERENCES clientes(ntelefone),
    FOREIGN KEY (ncartao) REFERENCES cartoes(ncartao)
);

-- Create table 'condutores'
CREATE TABLE condutores (
    ntelefone NUMBER(14, 0) PRIMARY KEY REFERENCES contas(ntelefone),
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
    telCondutor NUMBER(14, 0) NOT NULL,
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
    telCliente NUMBER(14, 0) NOT NULL,
    telCondutor NUMBER(14, 0) NOT NULL,
    FOREIGN KEY (telCliente) REFERENCES clientes(ntelefone),
    FOREIGN KEY (telCondutor) REFERENCES condutores(ntelefone)
);

-- Create table 'viagem'
CREATE TABLE viagem (
    idp NUMBER(10, 0) NOT NULL PRIMARY KEY REFERENCES pedidos(idp),
    origem VARCHAR2(30) NOT NULL
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
