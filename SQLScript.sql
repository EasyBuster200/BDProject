-- Create table 'Modelos'
CREATE TABLE Modelos (
  nome VARCHAR2(30) NOT NULL,
  marca VARCHAR2(30) NOT NULL,
  nLugares SMALLINT NOT NULL,
  PRIMARY KEY (nome, marca)
);

-- Create table 'Veiculos'
CREATE TABLE Veiculos (
  Matr VARCHAR2(6) PRIMARY KEY,
  nome VARCHAR2(30) NOT NULL,
  marca VARCHAR2(30) NOT NULL,
  cor VARCHAR2(30) NOT NULL,
  FOREIGN KEY (nome, marca) REFERENCES Modelos(nome, marca)
);

-- Create table 'Carros'
CREATE TABLE Carros (
  Matr VARCHAR2(6) PRIMARY KEY REFERENCES Veiculos(Matr),
  nLugares SMALLINT NOT NULL
);

-- Create table 'Motas'
CREATE TABLE Motas (
  Matr VARCHAR2(6) PRIMARY KEY REFERENCES Veiculos(Matr)  
);

-- Create table 'Contas'
CREATE TABLE Contas (
  nTelefone VARCHAR2(14) PRIMARY KEY, -- +351 123456789
  email VARCHAR2(30),
  nome VARCHAR2(30)
);

-- Create table 'Condutores'
CREATE TABLE Condutores (
  nTelefone VARCHAR2(14) PRIMARY KEY references Contas(nTelefone),
  nCartaCond VARCHAR2(20) NOT NULL,
  dataVal DATE NOT NULL,
  nEstrelas SMALLINT,
  FOREIGN KEY (idP) REFERENCES Pedidos(idP)
);

-- Create table 'Clientes'
CREATE TABLE Clientes (
  nTelefone VARCHAR2(15) PRIMARY KEY references Contas(nTelefone),
  FOREIGN KEY (idP) REFERENCES Pedidos(idP)
);

-- Create table 'utiliza'
CREATE TABLE utiliza (
  nTelefone VARCHAR2(14) NOT NULL references Contas(nTelefone) , --? References Contas ou Clientes
  nCartao NUMBER(20,0) NOT NULL references Cartoes(nCartao),
  PRIMARY KEY (nTelefone, nCartao)
);

-- Create table 'Cartoes'
CREATE TABLE Cartoes (
  nCartao NUMBER(20,0) PRIMARY KEY,
  dataVal DATE NOT NULL
);

-- Create table 'Pedidos'
CREATE TABLE Pedidos (
  idP NUMBER(10,0) PRIMARY KEY,
  valorTotal DECIMAL(4,2) NOT NULL,
  tempo INT NOT NULL, --? How to savee time (s independentemente do formato local para atributos do tipo DATE)
  destino VARCHAR2(30) NOT NULL
);

-- Create table 'Viagem'
CREATE TABLE Viagem (
  idP NUMBER(10,0) NOT NULL primary KEY references Pedidos(idP),
  origem VARCHAR2(30) NOT NULL
);

-- Create table 'EntregaComida'
CREATE TABLE EntregaComida (
  idP NUMBER(10,0) NOT NULL primary key references Pedidos
);

-- Create table 'Restaurantes'
CREATE TABLE Restaurantes (
  idRestr NUMBER(5,0) PRIMARY KEY,
  nome VARCHAR2(30) NOT NULL,
  endereco VARCHAR2(30) NOT NULL,
  FOREIGN KEY (idP) REFERENCES Pedidos(idP)
);

-- Create table 'Menus'
CREATE TABLE Menus (
  idMenu NUMBER(5,0) PRIMARY KEY,
  FOREIGN KEY (idRestr) REFERENCES Restaurantes(idRestr)
);

-- Create table 'Artigos'
CREATE TABLE Artigos (
  idArtigo NUMBER(10,0) PRIMARY KEY,
  descricao VARCHAR2(30) NOT NULL,
  preco DECIMAL(10,2) NOT NULL,
  nome VARCHAR2(30) NOT NULL,
  FOREIGN KEY (idMenu) REFERENCES Menus(idMenu)
);

CREATE SEQUENCE seq_idP
start with 0000000000
increment by 1;

CREATE SEQUENCE seq_idRestr 
START WITH 00000
INCREMENT by 1;

CREATE SEQUENCE seq_idMenu
START with 00000
INCREMENT by 1;

CREATE SEQUENCE idArtigo
START with 0000000000
INCREMENT BY 1;


/* TODO: 
  Make sure that Carro e Mota são disjuntos
  Create something similar to this for: idP, idRestr, IdMenu, idArtigo
    create sequence seq_num_aluno
    start with 60000
    increment by 1;
  
*/

/* TODO: Restrições
  - Um cliente não pode fazer pedido se não tiver pelo menos um cartao associado
  - A origem e destino de um pedido não pode ser igual
  - Nº de estrelas do condutor tem de ser entre 0-5 
  - Uma pessoa não pode pedir algo que n pertenca ao menu do restaurante onde o pedido foi feito
*/