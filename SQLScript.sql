-- Create table 'Modelos'
create table modelos (
	nome  varchar2(30) not null,
	marca varchar2(30) not null,
	primary key ( nome,
	              marca )
);

-- Create table 'Veiculos' --? How to go from the ERD to Table form properly
--! Can be both ways
create table veiculos (
	matr  varchar2(6) primary key,
	nome  varchar2(30) not null,
	marca varchar2(30) not null,
	cor   varchar2(30) not null,
	foreign key ( nome,
	              marca )
		references modelos ( nome,
		                     marca )
);

-- Create table 'Carros'
create table carros (
	matr     varchar2(6) primary key
		references veiculos ( matr ),
	nlugares smallint not null
);

-- Create table 'Motas'
create table motas (
	matr varchar2(6) primary key
		references veiculos ( matr )
);

-- Create table 'Contas'
create table contas (
	ntelefone varchar2(14) primary key, -- +351 123456789
	email     varchar2(30),
	nome      varchar2(30)
);

-- Create table 'Condutores'
create table condutores (
	ntelefone varchar2(14) primary key references contas (ntelefone),
	ncartacond varchar2(20) not null,
	dataval date not null,
	nestrelas smallint, -- TEchnically if the driver hasnt been evaluated then it has no starts, therefore the value is null
	foreign key (idp) references pedidos (idp)
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
	dataval DATE not null
);

-- Create table 'Pedidos'
create table pedidos (
	idp        number(10,0) primary key,
	valortotal decimal(4,2) not null,
	tempo_in_sec    int not null, --? How to save time (independentemente do formato local para atributos do tipo DATE)
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

create sequence idartigo start with 0000000000 increment by 1;

--Condutores -> 100
INSERT all
  into contas values ('dbarca0@vinaora.com', '558 953 8156', 'Dasha Barca', 'LC 21 WM', '06/06/2023', 3)
  into contas values ('mtheunissen1@huffingtonpost.com', '851 489 3214', 'Morganne Theunissen', 'TG 46 ES', '08/09/2024', 5)
  into contas values ('ramiable2@alexa.com', '595 751 6360', 'Ruby Amiable', 'KL 86 TT', '12/21/2025', 2)
  into contas values ('cpurves3@who.int', '102 906 2892', 'Connie Purves', 'JO 00 WC', '06/18/2023', 2)
  into contas values ('mbrimfield4@amazon.co.uk', '405 691 5201', 'Marilee Brimfield', 'IP 04 YG', '01/03/2026', 1)
  into contas values ('jmouatt5@xinhuanet.com', '929 621 2977', 'Jerome Mouatt', 'XL 56 WY', '01/27/2026', 2)
  into contas values ('lrutherforth6@wordpress.org', '828 225 2484', 'Levy Rutherforth', 'JJ 83 MB', '01/21/2026', 2)
  into contas values ('mbuckland7@tuttocitta.it', '794 349 7375', 'Melony Buckland', 'RP 42 RE', '09/25/2023', 1)
  into contas values ('ddinneges8@squidoo.com', '937 471 7788', 'Dorine Dinneges', 'DC 60 SO', '11/10/2024', 5)
  into contas values ('gsprouls9@deliciousdays.com', '761 639 7865', 'Georgetta Sprouls', 'HA 52 MQ', '02/29/2024', 4)
  into contas values ('fkingabya@blog.com', '652 599 7907', 'Fletch Kingaby', 'AC 66 OA', '02/16/2024', 4)
  into contas values ('aburwinb@webs.com', '540 431 9833', 'Ann Burwin', 'AB 74 DH', '07/11/2025', 5)
  into contas values ('tshearmurc@tripadvisor.com', '701 749 8620', 'Tate Shearmur', 'VJ 70 UK', '05/23/2024', null)
  into contas values ('xfranced@cbslocal.com', '772 300 9409', 'Xena France', 'XI 29 JW', '12/26/2025', null)
  into contas values ('pgullivere@godaddy.com', '738 182 8770', 'Perrine Gulliver', 'HB 96 PM', '03/18/2025', 3)
  into contas values ('cheveyf@tinyurl.com', '776 191 1216', 'Cassaundra Hevey', 'DF 51 ZK', '09/07/2023', null)
  into contas values ('hmandifieldg@webmd.com', '633 580 5107', 'Hannis Mandifield', 'NZ 42 FD', '01/24/2024', 1)
  into contas values ('woferrish@instagram.com', '133 623 3679', 'Wilone O''Ferris', 'JS 99 LL', '12/31/2023', 3)
  into contas values ('csieri@last.fm', '937 467 3890', 'Clifford Sier', 'QM 16 IQ', '12/26/2024', 5)
  into contas values ('mpetrichatj@tinypic.com', '367 302 8878', 'Melamie Petrichat', 'HS 78 QF', '07/03/2025', 3)
  into contas values ('atailbyk@t.co', '117 472 6596', 'Arleyne Tailby', 'OO 17 AN', '07/13/2024', 2)
  into contas values ('gpetersenl@netlog.com', '362 165 4606', 'Georgeanna Petersen', 'IO 53 FN', '07/20/2025', 5)
  into contas values ('scatonnem@cnet.com', '126 641 4037', 'Sandra Catonne', 'TG 37 BW', '07/28/2025', 4)
  into contas values ('dphilipsenn@cnn.com', '577 442 8267', 'Dyana Philipsen', 'OM 59 IP', '06/16/2023', null)
  into contas values ('vrouselo@bing.com', '844 855 6730', 'Vivyanne Rousel', 'BB 45 MA', '05/20/2025', 4)
  into contas values ('bcolicotp@ucsd.edu', '957 437 0151', 'Biron Colicot', 'IS 64 MC', '07/23/2023', 2)
  into contas values ('achazetteq@vistaprint.com', '917 893 4163', 'Aime Chazette', 'WR 49 UC', '05/03/2025', 5)
  into contas values ('strottr@loc.gov', '601 412 6422', 'Susette Trott', 'RC 31 KQ', '07/13/2023', 5)
  into contas values ('bdavidovitss@delicious.com', '476 757 4959', 'Bibbie Davidovits', 'RJ 55 EK', '08/07/2024', 2)
  into contas values ('cleijst@quantcast.com', '805 583 8013', 'Clerissa Leijs', 'TV 47 JR', '02/01/2025', 4)
  into contas values ('opuxleyu@quantcast.com', '409 116 3199', 'Oliy Puxley', 'UH 81 XT', '03/22/2024', 5)
  into contas values ('gredsallv@upenn.edu', '750 425 3251', 'Guinevere Redsall', 'FP 87 ED', '12/27/2024', 4)
  into contas values ('cminchiw@reuters.com', '552 266 2822', 'Carmine Minchi', 'YM 82 ZH', '08/07/2025', 5)
  into contas values ('pnuddex@list-manage.com', '441 435 2492', 'Prent Nudde', 'UQ 81 BJ', '08/04/2024', 1)
  into contas values ('dmoncky@china.com.cn', '845 933 7555', 'Dierdre Monck', 'KQ 56 CP', '03/05/2024', 2)
  into contas values ('jboeckez@trellian.com', '742 661 0272', 'Jobina Boecke', 'TN 93 RR', '07/05/2024', 4)
  into contas values ('ashalliker10@mapy.cz', '225 972 4009', 'Allsun Shalliker', 'WD 27 JR', '08/05/2023', 4)
  into contas values ('vpenn11@yale.edu', '568 793 3376', 'Valentine Penn', 'IX 07 XS', '09/19/2025', 2)
  into contas values ('kskones12@alibaba.com', '321 541 4843', 'Kessiah Skones', 'MW 66 SF', '03/19/2024', 3)
  into contas values ('cmillington13@wix.com', '828 149 9035', 'Clementina Millington', 'WR 29 DV', '11/02/2024', 4)
  into contas values ('lpecha14@gizmodo.com', '988 386 7302', 'Laural Pecha', 'PI 11 AK', '12/03/2024', 5)
  into contas values ('edugget15@samsung.com', '154 969 6292', 'Elyssa Dugget', 'HG 65 BJ', '07/31/2023', 4)
  into contas values ('wheisler16@so-net.ne.jp', '672 123 4279', 'Winifred Heisler', 'YI 77 PK', '07/07/2025', 4)
  into contas values ('sbuxy17@barnesandnoble.com', '339 589 9153', 'Stefanie Buxy', 'NS 40 NQ', '07/05/2024', 3)
  into contas values ('rladd18@linkedin.com', '959 296 5654', 'Ray Ladd', 'ZT 39 UV', '07/24/2024', 1)
  into contas values ('nmay19@dagondesign.com', '254 532 2597', 'Nessi May', 'EW 90 JQ', '10/11/2024', 5)
  into contas values ('phammarberg1a@google.de', '406 969 5310', 'Persis Hammarberg', 'PN 85 VT', '04/09/2024', 5)
  into contas values ('clonsbrough1b@amazon.com', '808 120 8838', 'Cristin Lonsbrough', 'UI 73 TM', '11/01/2024', null)
  into contas values ('hdrysdell1c@eventbrite.com', '387 372 0050', 'Haroun Drysdell', 'IP 89 LQ', '06/08/2023', 1)
  into contas values ('hseeks1d@biglobe.ne.jp', '749 459 9070', 'Hildagarde Seeks', 'TP 36 FN', '12/29/2024', 2)
  into contas values ('agrishenkov1e@wikipedia.org', '633 454 1873', 'Amye Grishenkov', 'HO 41 II', '08/14/2024', 5)
  into contas values ('ahusbands1f@creativecommons.org', '768 661 1640', 'Alina Husbands', 'RN 66 QP', '06/08/2023', 3)
  into contas values ('avillalta1g@newsvine.com', '668 394 9102', 'Arlinda Villalta', 'GZ 01 LN', '05/17/2025', 3)
  into contas values ('vguislin1h@google.fr', '758 743 8637', 'Vera Guislin', 'CA 78 SR', '03/14/2024', 1)
  into contas values ('oedinburough1i@cocolog-nifty.com', '686 747 1388', 'Ody Edinburough', 'FH 74 PP', '07/17/2025', null)
  into contas values ('nboram1j@mail.ru', '325 788 0291', 'Nicko Boram', 'LD 25 EV', '11/15/2025', 3)
  into contas values ('masty1k@myspace.com', '400 481 2595', 'Merwin Asty', 'HY 08 WU', '06/26/2025', 5)
  into contas values ('ghaet1l@imageshack.us', '145 964 4538', 'Gustavus Haet', 'JA 85 TR', '04/13/2024', 3)
  into contas values ('lclementucci1m@imgur.com', '533 810 5165', 'Linette Clementucci', 'SM 63 WU', '06/21/2024', 5)
  into contas values ('amacgiany1n@timesonline.co.uk', '405 654 5481', 'Atlanta MacGiany', 'GK 79 MT', '01/24/2025', 4)
  into contas values ('lcolby1o@springer.com', '709 314 2511', 'Lydie Colby', 'OX 69 LB', '06/22/2025', null)
  into contas values ('mbenettini1p@japanpost.jp', '519 969 0610', 'Marlyn Benettini', 'FK 94 QB', '09/01/2023', 1)
  into contas values ('rperillo1q@sfgate.com', '648 169 3926', 'Rhona Perillo', 'SD 52 ZG', '01/23/2024', 2)
  into contas values ('coldland1r@rambler.ru', '972 115 6444', 'Carolyn Oldland', 'IP 65 TL', '09/13/2023', 2)
  into contas values ('leverly1s@homestead.com', '212 953 2551', 'Laureen Everly', 'UO 13 TB', '08/26/2023', 3)
  into contas values ('lgoslin1t@go.com', '494 411 4011', 'Lilia Goslin', 'PE 39 ZH', '11/01/2024', 1)
  into contas values ('rvan1u@washingtonpost.com', '296 820 1836', 'Roi Van Rembrandt', 'TP 27 WK', '09/12/2024', 1)
  into contas values ('abullen1v@cdc.gov', '514 515 0533', 'Amerigo Bullen', 'AZ 48 MF', '01/31/2024', 3)
  into contas values ('bpickard1w@bloomberg.com', '588 552 4716', 'Bevon Pickard', 'WB 22 MN', '02/19/2025', 1)
  into contas values ('dseebright1x@oakley.com', '659 598 2397', 'Davide Seebright', 'OF 10 QW', '03/26/2024', 4)
  into contas values ('mdundridge1y@geocities.com', '731 917 0091', 'Mel Dundridge', 'LS 42 OA', '06/20/2024', 2)
  into contas values ('dstedmond1z@thetimes.co.uk', '546 600 5919', 'Danya Stedmond', 'PU 22 SG', '11/02/2025', 2)
  into contas values ('escritch20@last.fm', '972 370 5533', 'Eugenius Scritch', 'YF 49 KA', '07/27/2025', 5)
  into contas values ('mfuidge21@oaic.gov.au', '163 988 7958', 'Meaghan Fuidge', 'WU 96 PO', '06/09/2024', 3)
  into contas values ('drimell22@ameblo.jp', '547 122 3782', 'Dell Rimell', 'ML 95 IK', '05/17/2024', 4)
  into contas values ('ybamlett23@com.com', '853 983 1125', 'Yoshi Bamlett', 'DR 32 MF', '10/24/2023', 5)
  into contas values ('sgilvear24@imdb.com', '917 258 6671', 'Stillman Gilvear', 'NA 67 RR', '11/30/2023', 5)
  into contas values ('cpasterfield25@quantcast.com', '272 223 1761', 'Cullin Pasterfield', 'XV 79 CP', '04/02/2025', 2)
  into contas values ('eiveans26@mapy.cz', '166 283 2372', 'Ebeneser Iveans', 'NN 25 PJ', '07/30/2023', 2)
  into contas values ('pnafziger27@theglobeandmail.com', '214 678 3498', 'Phylis Nafziger', 'FL 84 IO', '03/18/2024', 1)
  into contas values ('hparnall28@technorati.com', '127 334 9929', 'Hilton Parnall', 'SO 13 KJ', '11/06/2025', 4)
  into contas values ('nsaunier29@delicious.com', '313 689 0093', 'Neala Saunier', 'CC 64 RU', '10/02/2025', 3)
  into contas values ('btitford2a@telegraph.co.uk', '814 231 9324', 'Barton Titford', 'KP 95 NU', '04/05/2025', 3)
  into contas values ('fdargan2b@booking.com', '226 398 4881', 'Franciska Dargan', 'VF 80 PL', '12/06/2024', 5)
  into contas values ('jhentzer2c@geocities.com', '709 811 2587', 'Janel Hentzer', 'PE 98 KN', '08/20/2025', 5)
  into contas values ('yphippard2d@discovery.com', '125 786 3005', 'Yoshiko Phippard', 'YH 01 IC', '12/11/2023', null)
  into contas values ('fmacgiany2e@blogspot.com', '906 409 4528', 'Faulkner MacGiany', 'XZ 78 FG', '03/10/2025', 2)
  into contas values ('bhundal2f@skype.com', '993 871 5736', 'Binny Hundal', 'QN 25 BP', '12/13/2024', 2)
  into contas values ('gchallenger2g@aol.com', '153 757 1214', 'Gwenette Challenger', 'WO 07 MH', '08/24/2023', 1)
  into contas values ('vgilling2h@csmonitor.com', '897 111 4102', 'Valentin Gilling', 'QS 27 GO', '11/17/2025', 2)
  into contas values ('bsirkett2i@mit.edu', '575 674 4542', 'Bonnie Sirkett', 'XR 28 MV', '05/01/2024', null)
  into contas values ('apritchett2j@netlog.com', '831 666 7334', 'Abe Pritchett', 'PI 36 WC', '11/12/2024', null)
  into contas values ('bshapira2k@samsung.com', '322 341 9918', 'Bethina Shapira', 'YP 47 ZE', '01/14/2024', 1)
  into contas values ('onowill2l@intel.com', '559 299 0709', 'Othello Nowill', 'QP 08 SD', '10/06/2025', 3)
  into contas values ('rpraundlin2m@tripadvisor.com', '561 832 6157', 'Raddy Praundlin', 'EF 09 MP', '11/17/2024', null)
  into contas values ('ppanting2n@addthis.com', '908 251 9486', 'Porty Panting', 'GP 54 YF', '08/30/2024', 2)
  into contas values ('lfaires2o@webmd.com', '473 902 6842', 'Lincoln Faires', 'WX 08 GK', '05/19/2024', 2)
  into contas values ('nhakking2p@smugmug.com', '926 700 7968', 'Nicky Hakking', 'JH 55 NG', '12/05/2023', 2)
  into contas values ('achamberlaine2q@linkedin.com', '700 182 1954', 'Aksel Chamberlaine', 'JW 17 CI', '10/12/2023', 5)
  into contas values ('mpretsel2r@mit.edu', '975 570 3970', 'Michell Pretsel', 'ZW 51 YF', '08/13/2023', 3)
select * from dual;


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
  - Um cliente não pode fazer pedido se não tiver pelo menos um cartao associado --> Trigger
  - A origem e destino de um pedido não pode ser igual --> Trigger
  - Nº de estrelas do condutor tem de ser entre 0-5 --> Done
  - Uma pessoa não pode pedir algo que n pertenca ao menu do restaurante onde o pedido foi feito
  - Uma mota não pode fazer transporte de pessoas
*/