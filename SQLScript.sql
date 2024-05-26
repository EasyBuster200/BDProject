-- Create table 'Modelos'
create table modelos (
	nome varchar2(30) not null,
	marca varchar2(30) not null,
	primary key (nome, marca)
);

-- Create table 'Veiculos' --? How to go from the ERD to Table form properly
--! Can be both ways
create table veiculos (
	matr varchar2(6) primary key,
	nome varchar2(30) not null,
	marca varchar2(30) not null,
	
	foreign key (nome, marca) references modelos (nome, marca)
)

-- Create table 'Carros'
create table carros (
	matr varchar2(6) primary key references veiculos (matr),
	nlugares smallint not null
	cor varchar2(30) not null,
);

-- Create table 'Motas'
create table motas (
	matr varchar2(6) primary key references veiculos (matr)
);

-- Create table 'Contas'
create table contas (
	ntelefone varchar2(14) primary key, -- +351 123456789
	email varchar2(30),
	nome varchar2(30)
);

-- Create table 'Condutores'
create table condutores (
	ntelefone  varchar2(14) primary key
		references contas ( ntelefone ),
	ncartacond varchar2(20) not null,
	dataval    date not null,
	nestrelas  smallint,
	foreign key ( idp )
		references pedidos ( idp )
);

-- Create table 'Clientes'
create table clientes (
	ntelefone varchar2(15) primary key
		references contas ( ntelefone ),
	foreign key ( idp )
		references pedidos ( idp )
);

-- Create table 'utiliza'
create table utiliza (
	ntelefone varchar2(14) not null
		references contas ( ntelefone ), --? References Contas ou Clientes
	ncartao   number(20,0) not null
		references cartoes ( ncartao ),
	primary key ( ntelefone,
	              ncartao )
);

-- Create table 'Cartoes'
create table cartoes (
	ncartao number(20,0) primary key,
	dataval date not null
);

-- Create table 'Pedidos'
create table pedidos (
	idp        number(10,0) primary key,
	valortotal decimal(4,2) not null,
	tempo      int not null, --? How to save time (independentemente do formato local para atributos do tipo DATE)
	destino    varchar2(30) not null
);

--?ADD CONSTRAINT ck_distinct_destination_origin CHECK (destination <> origin);

-- Create table 'Viagem'
create table viagem (
	idp    number(10,0) not null primary key
		references pedidos ( idp ),
	origem varchar2(30) not null
);

-- Create table 'EntregaComida'
create table entregacomida (
	idp number(10,0) not null primary key
		references pedidos
);

-- Create table 'Restaurantes'
create table restaurantes (
	idrestr  number(5,0) primary key,
	nome     varchar2(30) not null,
	endereco varchar2(30) not null,
	foreign key ( idp )
		references pedidos ( idp )
);

-- Create table 'Menus'
create table menus (
	idmenu number(5,0) primary key,
	foreign key ( idrestr )
		references restaurantes ( idrestr )
);

-- Create table 'Artigos'
create table artigos (
	idartigo  number(10,0) primary key,
	descricao varchar2(30) not null,
	preco     decimal(10,2) not null,
	nome      varchar2(30) not null,
	foreign key ( idmenu )
		references menus ( idmenu )
);

create sequence seq_idp start with 0000000000 increment by 1;

create sequence seq_idrestr start with 00000 increment by 1;

create sequence seq_idmenu start with 00000 increment by 1;

create sequence idartigo start with 0000000000 increment by 1;

--Modelos Carros -> 50
insert into modelos (
	nome,
	marca
) values (
	'Discovery',
	'Land Rover'
);
insert into modelos (
	nome,
	marca
) values (
	'Ranger',
	'Ford'
);
insert into modelos (
	nome,
	marca
) values (
	'Prius',
	'Toyota'
);
insert into modelos (
	nome,
	marca
) values (
	'Express 2500',
	'Chevrolet'
);
insert into modelos (
	nome,
	marca
) values (
	'7 Series',
	'BMW'
);
insert into modelos (
	nome,
	marca
) values (
	'Mustang',
	'Ford'
);
insert into modelos (
	nome,
	marca
) values (
	'Sentra',
	'Nissan'
);
insert into modelos (
	nome,
	marca
) values (
	'CX-9',
	'Mazda'
);
insert into modelos (
	nome,
	marca
) values (
	'Crown Victoria',
	'Ford'
);
insert into modelos (
	nome,
	marca
) values (
	'LS',
	'Lexus'
);
insert into modelos (
	nome,
	marca
) values (
	'Optima',
	'Kia'
);
insert into modelos (
	nome,
	marca
) values (
	'S-Series',
	'Saturn'
);
insert into modelos (
	nome,
	marca
) values (
	'SM',
	'Citroën'
);
insert into modelos (
	nome,
	marca
) values (
	'X-90',
	'Suzuki'
);
insert into modelos (
	nome,
	marca
) values (
	'Ranger',
	'Ford'
);
insert into modelos (
	nome,
	marca
) values (
	'5 Series',
	'BMW'
);
insert into modelos (
	nome,
	marca
) values (
	'LS',
	'Lexus'
);
insert into modelos (
	nome,
	marca
) values (
	'MX-5',
	'Mazda'
);
insert into modelos (
	nome,
	marca
) values (
	'Cougar',
	'Mercury'
);
insert into modelos (
	nome,
	marca
) values (
	'Odyssey',
	'Honda'
);
insert into modelos (
	nome,
	marca
) values (
	'Boxster',
	'Porsche'
);
insert into modelos (
	nome,
	marca
) values (
	'Electra',
	'Buick'
);
insert into modelos (
	nome,
	marca
) values (
	'Cooper',
	'MINI'
);
insert into modelos (
	nome,
	marca
) values (
	'Storm',
	'Geo'
);
insert into modelos (
	nome,
	marca
) values (
	'626',
	'Mazda'
);
insert into modelos (
	nome,
	marca
) values (
	'Range Rover',
	'Land Rover'
);
insert into modelos (
	nome,
	marca
) values (
	'riolet',
	'Audi'
);
insert into modelos (
	nome,
	marca
) values (
	'Elantra',
	'Hyundai'
);
insert into modelos (
	nome,
	marca
) values (
	'Sentra',
	'Nissan'
);
insert into modelos (
	nome,
	marca
) values (
	'Pajero',
	'Mitsubishi'
);
insert into modelos (
	nome,
	marca
) values (
	'Element',
	'Honda'
);
insert into modelos (
	nome,
	marca
) values (
	'Neon',
	'Dodge'
);
insert into modelos (
	nome,
	marca
) values (
	'F250',
	'Ford'
);
insert into modelos (
	nome,
	marca
) values (
	'2500',
	'Ram'
);
insert into modelos (
	nome,
	marca
) values (
	'Grand Caravan',
	'Dodge'
);
insert into modelos (
	nome,
	marca
) values (
	'Ranger',
	'Ford'
);
insert into modelos (
	nome,
	marca
) values (
	'Ram 3500',
	'Dodge'
);
insert into modelos (
	nome,
	marca
) values (
	'S80',
	'Volvo'
);
insert into modelos (
	nome,
	marca
) values (
	'LS',
	'Lexus'
);
insert into modelos (
	nome,
	marca
) values (
	'TrailBlazer',
	'Chevrolet'
);
insert into modelos (
	nome,
	marca
) values (
	'Legacy',
	'Subaru'
);
insert into modelos (
	nome,
	marca
) values (
	'Savana 2500',
	'GMC'
);
insert into modelos (
	nome,
	marca
) values (
	'Accord',
	'Honda'
);
insert into modelos (
	nome,
	marca
) values (
	'GS',
	'Lexus'
);
insert into modelos (
	nome,
	marca
) values (
	'Explorer',
	'Ford'
);
insert into modelos (
	nome,
	marca
) values (
	'Sprinter',
	'Dodge'
);
insert into modelos (
	nome,
	marca
) values (
	'Five Hundred',
	'Ford'
);
insert into modelos (
	nome,
	marca
) values (
	'Metro',
	'Geo'
);
insert into modelos (
	nome,
	marca
) values (
	'Aviator',
	'Lincoln'
);
insert into modelos (
	nome,
	marca
) values (
	'Outlander',
	'Mitsubishi'
);



-- Veiculos
--? How


/* TODO: 
  Make sure that Carro e Mota são disjuntos
  Change the diagram so that only Carros has Cor as an attribute
*/

/* TODO: Restrições
  - Um cliente não pode fazer pedido se não tiver pelo menos um cartao associado
  - A origem e destino de um pedido não pode ser igual
  - Nº de estrelas do condutor tem de ser entre 0-5 
  - Uma pessoa não pode pedir algo que n pertenca ao menu do restaurante onde o pedido foi feito
  - Uma mota não pode fazer transporte de pessoas
*/