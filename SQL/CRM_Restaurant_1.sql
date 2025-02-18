create table Nomenclature
(
	id_measure_unit SERIAL PRIMARY KEY,
	measure_unit CHARACTER VARYING(30)
);

create table Categories 
(
	id_category SERIAL PRIMARY KEY,
	name_category CHARACTER VARYING(100)
);

create table Price_List 
(
	id_price SERIAL PRIMARY KEY,
	price INTEGER,
	start_date TIMESTAMP,
	end_date TIMESTAMP
);

create table Dishes 
(
	id_dish SERIAL PRIMARY KEY,
	id_price INTEGER,
	id_category INTEGER,
	name_dish CHARACTER VARYING(100),
	cooking_time CHARACTER VARYING(30),
	id_measure_unit INTEGER,
	unit INTEGER
);

create table Ingredients 
(
	id_ingredient SERIAL PRIMARY KEY,
	name_ingredient CHARACTER VARYING(30)
);
 
create table Compositions 
(
	id_composition SERIAL PRIMARY KEY,
	id_dish INTEGER,
	id_ingredient INTEGER,
	id_measure_unit INTEGER,
	unit INTEGER
);

create table Restaurant_Tables
(
	id_table SERIAL PRIMARY KEY,
	table_number INTEGER,
	quantity_of_seats INTEGER
);

create table Clients 
(
	id_client SERIAL PRIMARY KEY,
	name_client CHARACTER VARYING(100),
	phone_number CHARACTER VARYING(11),
	day_of_birth TIMESTAMP
);

create table Promcodes 
(
	id_promocode SERIAL PRIMARY KEY,
	promocode CHARACTER VARYING(100),
	discount INTEGER
);

create table Staff 
(
	id_staff SERIAL PRIMARY KEY,
	fullname_staff CHARACTER VARYING(100)
);

create table Shift 
(
	id_shift SERIAL PRIMARY KEY,
	open_datetime TIMESTAMP,
	close_datetime TIMESTAMP DEFAULT '0001-01-01 00:00:01',
	status_shift CHARACTER VARYING(30) DEFAULT 'Открыта'
);

create table Staff_shift 
(
	id_staffshift SERIAL PRIMARY KEY,
	id_shift INTEGER,
	id_staff INTEGER,
	open_datetime TIMESTAMP,
	close_datetime TIMESTAMP DEFAULT '0001-01-01 00:00:01',
	status_staffshift CHARACTER VARYING(30) DEFAULT 'Закрыта'
);

create table Client_Orders 
(
	id_order SERIAL PRIMARY KEY,
	id_staffshift INTEGER,
	id_client INTEGER,
	id_table INTEGER,
	id_promocode INTEGER,
	open_datetime TIMESTAMP,
	close_datetime TIMESTAMP DEFAULT '0001-01-01 00:00:01',
	status_order CHARACTER VARYING(30)
);

create table Order_Positions
(
	id_position SERIAL PRIMARY KEY,
	id_order INTEGER,
	id_dish INTEGER,
	count_dish INTEGER,
	price INTEGER,
	discount INTEGER,
	start_time TIMESTAMP,
	status_position CHARACTER VARYING(30)
);
