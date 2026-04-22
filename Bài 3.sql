create database odersManager;
use odersManager;

create table customers(
	customersId int primary key auto_increment,
    fullName varchar(255) not null,
    email varchar(255) unique
);

create table oders(
	orderID int primary key,
    orderDate datetime default current_timestamp,
    totalPrice decimal(10,2) not null,
    customersId int ,
    foreign key(customersId) references customers(customersId)
);