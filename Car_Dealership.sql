CREATE TABLE "customer" (
  "customer_id" SERIAL,
  "first_name" VARCHAR(50),
  "last_name" VARCHAR(50),
  "address" VARCHAR(150),
  "billing_info" VARCHAR(150),
  PRIMARY KEY ("customer_id")
);

CREATE TABLE mechanic (
  mechanic_id SERIAL primary key,
  first_name VARCHAR(50),
  last_name VARCHAR(50)
);

CREATE TABLE salesperson (
  agent_id SERIAL primary key,
  first_name VARCHAR(50),
  last_name VARCHAR(50)
);

CREATE TABLE car (
  car_id SERIAL primary key,
  car_make VARCHAR(50),
  car_model VARCHAR(50),
  car_year INTEGER,
  car_type VARCHAR(150)
);

CREATE TABLE sales (
  sale_id SERIAL primary key,
  amount DECIMAL,
  sale_date DATE,
  agent_id SERIAL,
  customer_id SERIAL,
  car_id SERIAL,
  FOREIGN KEY (car_id) REFERENCES car(car_id),
  foreign key (agent_id) references salesperson(agent_id),
  foreign key (customer_id) references customer(customer_id)
);

CREATE TABLE service (
  service_id SERIAL primary key,
  amount DECIMAL,
  service_date DATE,
  mechanic_id SERIAL,
  car_id SERIAL,
  customer_id SERIAL,
  agent_id SERIAL,
  foreign key(mechanic_id) references mechanic(mechanic_id),
  foreign key(car_id) references car(car_id),
  foreign key(agent_id) references salesperson(agent_id),
  foreign key(customer_id) references customer(customer_id)
);

insert into customer (
  customer_id,
  first_name,
  last_name,
  address,
  billing_info
) values (
	1, 
	'Adam', 
	'Wright',
	'555 Circle Drive, Chicago IL 60613',
	'4242 2424 5252 2525 01/27 555'
);

insert into customer (
	customer_id,
	first_name,
	last_name,
	address,
	billing_info
) values (
	2,
	'Chelsea',
	'Monroe',
	'123 Main Street, Indianapolis, IN 46163',
	'5656 6565 8585 5858 02/25 565' 
);

insert into customer (
	customer_id,
	first_name,
	last_name,
	address,
	billing_info
) values (
	3,
	'Jason',
	'Willis',
	'123 My Street, Los Angeles, CA 90036',
	'8963 3698 4561 1654 01/27 365' 
);

insert into customer (
	customer_id,
	first_name,
	last_name,
	address,
	billing_info
) values (
	4,
	'Audrey',
	'Hope',
	'563 Elm Street, Nighmarte, US 12345',
	'1234 4321 7894 4987 01/26 789' 
);

insert into mechanic (
  mechanic_id,
  first_name,
  last_name
) values (
	1,
	'Rodney',
	'Price'
);

insert into mechanic (
  mechanic_id,
  first_name,
  last_name
) values (
	2,
	'Travis',
	'Clayton'
);

insert into salesperson (
  agent_id,
  first_name,
  last_name
) values (
	1,
	'Ashley',
	'Smith'
);

insert into salesperson (
  agent_id,
  first_name,
  last_name
) values (
	2,
	'Jonathan',
	'Spencer'
);

insert into car (
  car_id,
  car_make,
  car_model,
  car_year,
  car_type
) values (
	1,
	'Subaru',
	'Outback',
	'2013',
	'Used'
);

insert into car (
  car_id,
  car_make,
  car_model,
  car_year,
  car_type
) values (
	2,
	'Toyota',
	'Tacoma',
	'1986',
	'Used'
);

insert into car (
  car_id,
  car_make,
  car_model,
  car_year,
  car_type
) values (
	3,
	'Lincoln',
	'Navigator',
	'2023',
	'New'
);

insert into car (
  car_id,
  car_make,
  car_model,
  car_year,
  car_type
) values (
	4,
	'Cadillac',
	'Escalade',
	'2023',
	'New'
);

insert into car (
  car_id,
  car_make,
  car_model,
  car_year,
  car_type
) values (
	5,
	'Honda',
	'Accord',
	'2005',
	'Used'
);

insert into sales (
	sale_id,
	amount,
	sale_date,
	agent_id,
	customer_id,
	car_id
) values (
	1,
	8000,
	'7/7/2023',
	1,
	1,
	1
);

insert into sales (
	sale_id,
	amount,
	sale_date,
	agent_id,
	customer_id,
	car_id
) values (
	2,
	23000,
	'7/6/2023',
	2,
	2,
	3
);

insert into sales (
	sale_id,
	amount,
	sale_date,
	agent_id,
	customer_id,
	car_id
) values (
	3,
	35000,
	'7/7/2023',
	1,
	3,
	4
);

insert into service (
  service_id,
  amount,
  service_date,
  mechanic_id,
  car_id,
  customer_id,
  agent_id
) values (
	1,
	500,
	'7/7/2023',
	1,
	2,
	2,
	1	
);

insert into service (
  service_id,
  amount,
  service_date,
  mechanic_id,
  car_id,
  customer_id,
  agent_id
) values (
	2,
	300,
	'7/6/2023',
	2,
	5,
	4,
	2	
);

select * from sales

create or replace procedure salestax(
	customer INTEGER,
	salesTaxAmount DECIMAL
)
language plpgsql
as $$
begin 
	update sales 
	set amount = amount * salesTaxAmount
	where customer_id = customer;
	commit;
end; $$

call salestax(1,8.00);

select * from sales where customer_id = 1;
 

create or replace procedure latefee (
	customer INTEGER,
	lateFee DECIMAL
)
language plpgsql
as $$
begin 
	update service 
	set amount = amount * lateFee
	where customer_id = customer;
	commit;
end; $$

call latefee(2, 0.85); 

select * from service where customer_id = 2;