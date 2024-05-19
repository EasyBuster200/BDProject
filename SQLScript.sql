-- Create table 'Modelos'
CREATE TABLE Modelos (
  nome VARCHAR2(30) NOT NULL,
  marca VARCHAR2(30) NOT NULL,
  PRIMARY KEY (nome, marca)
);

-- Create table 'Veiculos' --? How to go from the ERD to Table form properly
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
  tempo INT NOT NULL, --? How to save time (s independentemente do formato local para atributos do tipo DATE)
  destino VARCHAR2(30) NOT NULL
);

--?ADD CONSTRAINT ck_distinct_destination_origin CHECK (destination <> origin);

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

--Modelos Carros -> 50
insert into Modelos (nome, marca) values ('Discovery', 'Land Rover');
insert into Modelos (nome, marca) values ('Ranger', 'Ford');
insert into Modelos (nome, marca) values ('Prius', 'Toyota');
insert into Modelos (nome, marca) values ('Express 2500', 'Chevrolet');
insert into Modelos (nome, marca) values ('7 Series', 'BMW');
insert into Modelos (nome, marca) values ('Mustang', 'Ford');
insert into Modelos (nome, marca) values ('Sentra', 'Nissan');
insert into Modelos (nome, marca) values ('CX-9', 'Mazda');
insert into Modelos (nome, marca) values ('Crown Victoria', 'Ford');
insert into Modelos (nome, marca) values ('LS', 'Lexus');
insert into Modelos (nome, marca) values ('Optima', 'Kia');
insert into Modelos (nome, marca) values ('S-Series', 'Saturn');
insert into Modelos (nome, marca) values ('SM', 'Citroën');
insert into Modelos (nome, marca) values ('X-90', 'Suzuki');
insert into Modelos (nome, marca) values ('Ranger', 'Ford');
insert into Modelos (nome, marca) values ('5 Series', 'BMW');
insert into Modelos (nome, marca) values ('LS', 'Lexus');
insert into Modelos (nome, marca) values ('MX-5', 'Mazda');
insert into Modelos (nome, marca) values ('Cougar', 'Mercury');
insert into Modelos (nome, marca) values ('Odyssey', 'Honda');
insert into Modelos (nome, marca) values ('Boxster', 'Porsche');
insert into Modelos (nome, marca) values ('Electra', 'Buick');
insert into Modelos (nome, marca) values ('Cooper', 'MINI');
insert into Modelos (nome, marca) values ('Storm', 'Geo');
insert into Modelos (nome, marca) values ('626', 'Mazda');
insert into Modelos (nome, marca) values ('Range Rover', 'Land Rover');
insert into Modelos (nome, marca) values ('riolet', 'Audi');
insert into Modelos (nome, marca) values ('Elantra', 'Hyundai');
insert into Modelos (nome, marca) values ('Sentra', 'Nissan');
insert into Modelos (nome, marca) values ('Pajero', 'Mitsubishi');
insert into Modelos (nome, marca) values ('Element', 'Honda');
insert into Modelos (nome, marca) values ('Neon', 'Dodge');
insert into Modelos (nome, marca) values ('F250', 'Ford');
insert into Modelos (nome, marca) values ('2500', 'Ram');
insert into Modelos (nome, marca) values ('Grand Caravan', 'Dodge');
insert into Modelos (nome, marca) values ('Ranger', 'Ford');
insert into Modelos (nome, marca) values ('Ram 3500', 'Dodge');
insert into Modelos (nome, marca) values ('S80', 'Volvo');
insert into Modelos (nome, marca) values ('LS', 'Lexus');
insert into Modelos (nome, marca) values ('TrailBlazer', 'Chevrolet');
insert into Modelos (nome, marca) values ('Legacy', 'Subaru');
insert into Modelos (nome, marca) values ('Savana 2500', 'GMC');
insert into Modelos (nome, marca) values ('Accord', 'Honda');
insert into Modelos (nome, marca) values ('GS', 'Lexus');
insert into Modelos (nome, marca) values ('Explorer', 'Ford');
insert into Modelos (nome, marca) values ('Sprinter', 'Dodge');
insert into Modelos (nome, marca) values ('Five Hundred', 'Ford');
insert into Modelos (nome, marca) values ('Metro', 'Geo');
insert into Modelos (nome, marca) values ('Aviator', 'Lincoln');
insert into Modelos (nome, marca) values ('Outlander', 'Mitsubishi');



-- Veiculos
--? How


/* TODO: 
  Make sure that Carro e Mota são disjuntos
*/

/* TODO: Restrições
  - Um cliente não pode fazer pedido se não tiver pelo menos um cartao associado
  - A origem e destino de um pedido não pode ser igual
  - Nº de estrelas do condutor tem de ser entre 0-5 
  - Uma pessoa não pode pedir algo que n pertenca ao menu do restaurante onde o pedido foi feito
  - Uma mota não pode fazer transporte de pessoas
*/