

-- Create table 'modelos'
create table modelos (
	nome varchar2(30) not null,
	marca varchar2(30) not null,
	primary key (nome, marca)
);

-- Create table 'veiculos' --? How to go from the ERD to Table form properly
--! Can be both ways
create table veiculos (
	matr varchar2(6) primary key,
	nome varchar2(30) not null,
	marca varchar2(30) not null,
	foreign key (nome, marca) references modelos (nome, marca),
	foreign KEY (telCondutor) references condutores (ntelefone)
);

-- Create table 'carros'
create table carros (
	matr varchar2(6) primary key references veiculos (matr),
	nlugares smallint not null,
	cor varchar2(30) not null
);

-- Create table 'motas'
create table motas (
	matr varchar2(6) primary key references veiculos (matr)
);

-- Create table 'contas'
create table contas (
	ntelefone number(14, 0) primary key, -- +351 123456789
	email varchar2(30),
	nome varchar2(30)
);

-- Create table 'condutores'
create table condutores (
	nTelfone varchar2(14) primary key references contas (ntelefone),
	ncartacond varchar2(20) not null,
	dataval date not null,
	nestrelas smallint, -- TEchnically if the driver hasnt been evaluated then it has no starts, therefore the value is null
	Matr varchar2(6) references veiculos (matr)
);

-- Create table 'clientes'
create table clientes (
	ntelefone varchar2(15) primary key references contas (ntelefone)
);

-- Create table 'utiliza'
create table utiliza (
	ntelefone varchar2(14) not null references clientes (ntelefone), --? References contas ou clientes
	ncartao number(20,0) not null references cartoes (ncartao),
	primary key (ntelefone, ncartao)
);

-- Create table 'Cartoes'
create table cartoes (
	ncartao number(16,0) primary key,
	cvc NUMBER (16, 0) not NULL,
	dataval DATE not null
);

-- Create table 'Pedidos'
create table pedidos (
	idp number(10,0) primary key,
	valortotal decimal(4,2) not null,
	tempo_in_sec int not null, --? How to save time (independentemente do formato local para atributos do tipo DATE)
	destino varchar2(30) not null,
	telCliente number (14,0)references clientes (ntelefone) not NULL,
	telCondutor number (14,0) references condutores (ntelefone) not NULL
);

--?ADD CONSTRAINT ck_distinct_destination_origin CHECK (destination <> origin);

-- Create table 'Viagem'
create table viagem (
	idp number(10,0) not null primary key references pedidos ( idp ),
	origem varchar2(30) not null
);

-- Create table 'EntregaComida'
create table entregacomida (
	idp number(10,0) not null primary key references pedidos,
	idrestr number(5,0) references restaurantes (idrestr) not NULL
);

-- Create table 'Restaurantes'
create table restaurantes (
	idrestr number(5,0) primary key,
	nome varchar2(30) not null,
	endereco varchar2(30) not null,
	foreign key (idMenu) references menus (idMenu)
);

-- Create table 'Menus'
create table menus (
	idmenu number(5,0) primary key,
	foreign key (idrestr) references restaurantes (idrestr)
);

-- Create table 'Artigos'
create table artigos (
	idartigo number(10,0) primary key,
	descricao varchar2(30) not null,
	preco decimal(10,2) not null,
	nome varchar2(30) not null,
	foreign key (idmenu) references menus ( idmenu )
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


/* TODO: Restrições
	- Trigger adiciona modelos se não tiver na BD
*/