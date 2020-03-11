##### Database and SQL ######

#### Part 1: Database Design

SHOW DATABASES;

CREATE DATABASE IF NOT EXISTS Kulina;

USE Kulina;

show tables;

/* 1 - ku_user_status TABLE Creation*/

CREATE TABLE ku_user_status
(
	id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(10) NOT NULL,
    created_at TIMESTAMP DEFAULT current_timestamp,
    updated_at TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
    );
    
-- DROP TABLE ku_user_status;-- 
-- INSERT INTO ku_user_status (name) VALUES
-- ("pending"),
-- ("active"),
-- ("suspended"),
-- ("banned");

-- select * from ku_user_status;

-- UPDATE ku_user_status
-- SET name = "banned"
-- WHERE id = 4;

/* 2 - ku_user_location_type TABLE Creation*/

CREATE TABLE ku_user_location_type
(
	id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(10) NOT NULL,
    created_at TIMESTAMP DEFAULT current_timestamp,
    updated_at TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
    );
    
show tables;
select * from ku_user_location_type;

-- INSERT INTO ku_user_location_type (name) VALUES
-- ("house"),
-- ("appartment"),
-- ("office"),
-- ("other");


/* TABLE 3- ku_user_location_status TABLE Creation*/

CREATE TABLE ku_user_location_status
(
	id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(10) NOT NULL,
    created_at TIMESTAMP DEFAULT current_timestamp,
    updated_at TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
    );

-- INSERT INTO ku_user_location_status (name) VALUES
-- ("main"),
-- ("additional");

select * from ku_user_location_status;


/* TABLE 4 - ku_user */

CREATE TABLE ku_user
(
	id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(320) NOT NULL,
    phone VARCHAR(17),
    password_hash VARCHAR(128) NOT NULL,
    salt VARCHAR(128) NOT NULL,
    photo BLOB NOT NULL,
    status INT DEFAULT NULL,
	created_at TIMESTAMP DEFAULT current_timestamp,
    updated_at TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (status) REFERENCES ku_user_status(id)
);

-- DROP TABLE ku_user;

-- INSERT INTO ku_user (name, email, phone, password_hash, salt, photo, status) VALUES
-- ("Edithya Muthiara","hydedith@gmail.com","6281280551388","GGc.OfF/PXYAg","GGp38eENBZs0Y","hydedith.jpg",2),
-- ("Arie Rusmiaty","arus1812@gmail.com","628129384702","GGpysNGBQHsoM","GGE80vX1BxTLg","arus1812.jpg",2);
-- 
-- select * from ku_user;


/* TABLE 5- ku_order_status TABLE Creation*/

CREATE TABLE ku_order_status
(
	id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(30) NOT NULL,
    created_at TIMESTAMP DEFAULT current_timestamp,
    updated_at TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
    );

-- DROP TABLE ku_order_status;
-- 
-- INSERT INTO ku_order_status (name) VALUES
-- ("pending"),
-- ("success"),
-- ("waiting_for_payment_service"),
-- ("error"),
-- ("void"),
-- ("user_cancel"),
-- ("payment_timeout"),
-- ("refund_requested"),
-- ("refund_approved"),
-- ("refund_declined");-- 

-- select * from ku_order_status;

/* TABLE 6 - ku_product_status TABLE Creation*/

CREATE TABLE ku_product_status
(
	id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(30) NOT NULL,
    created_at TIMESTAMP DEFAULT current_timestamp,
    updated_at TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
    );

-- INSERT INTO ku_product_status (name) VALUES
-- ("active"),
-- ("inactive");

-- select * from ku_product_status;

/* TABLE 7 - ku_user_location TABLE Creation*/

CREATE TABLE ku_user_location
(
	id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    type INT DEFAULT NULL, 
    status INT DEFAULT NULL,
    user_id INT DEFAULT NULL,
	location GEOMETRY NOT NULL,
    address VARCHAR(255),
    created_at TIMESTAMP DEFAULT current_timestamp,
    updated_at TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	FOREIGN KEY (type) REFERENCES ku_user_location_type(id),
    FOREIGN KEY (status) REFERENCES ku_user_location_status(id),
    FOREIGN KEY (user_id) REFERENCES ku_user(id)
);

-- 
-- select *, ST_ASTEXT(location) AS 'loc2' from ku_user_location;

select id, type, status, user_id, ST_ASTEXT(location) AS 'location', address from ku_user_location;

select count(*) from ku_user_location;

/* ## CODE for ST_GeomFromText POINT()
select 
*, ST_ASTEXT(position) AS 'pos_wkt' 
FROM testgeo2;
select
location.STAsText(), from

source:
https://stackoverflow.com/questions/53466771/mysql-how-to-insert-geometry-data
https://itnext.io/playing-with-geometry-spatial-data-type-in-mysql-645b83880331
https://books.google.co.id/books?id=pHeWWBY3cPEC&pg=PA251&lpg=PA251&dq=st+geomfromtext+table+properties&source=bl&ots=SUXl8kqTYq&sig=ACfU3U2Ihlyj3eJD31xx2tgrp0B58mS6uw&hl=en&sa=X&ved=2ahUKEwiOt56VhpPoAhXQZCsKHcnJBhMQ6AEwAHoECAYQAQ#v=onepage&q=st%20geomfromtext%20table%20properties&f=false
*/

/* TABLE 8 - ku_order TABLE Creation*/

CREATE TABLE ku_order
(
	id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
	user_id INT DEFAULT NULL,
    status INT DEFAULT NULL,
    created_at TIMESTAMP DEFAULT current_timestamp,
    updated_at TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (status) REFERENCES ku_order_status(id),
    FOREIGN KEY (user_id) REFERENCES ku_user(id)
);

select * from ku_order;

/* TABLE 9 - ku_product TABLE Creation*/

CREATE TABLE ku_product
(
	id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    effective_date DATE,
    effective_until DATE,
    photo BLOB NOT NULL,
    price DECIMAL(19,1),
    status INT DEFAULT NULL,
    created_at TIMESTAMP DEFAULT current_timestamp,
    updated_at TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	FOREIGN KEY (status) REFERENCES ku_product_status(id)
);

-- INSERT INTO ku_product (name, effective_date, effective_until, photo, price, status) VALUES
-- ("Basic Lunch",DATE("2019-12-22"),DATE("2019-12-28"),"basic-lunch.jpg",20000.0,2),
-- ("Deluxe Lunch",DATE("2019-12-22"),DATE("2019-12-28"),"kulina-deluxe-lunch.jpg",33250.0,2);

select * from ku_product;
DROP TABLE ku_product;

/* TABLE 10 - ku_category TABLE Creation*/


CREATE TABLE ku_category
(
	id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(80) NOT NULL,
    created_at TIMESTAMP DEFAULT current_timestamp,
    updated_at TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

select * from ku_category;

/* TABLE 11 - ku_order_detail_status TABLE Creation*/

CREATE TABLE ku_order_detail_status
(
	id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(20) NOT NULL,
    created_at TIMESTAMP DEFAULT current_timestamp,
    updated_at TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

select * from ku_order_detail_status;


/* TABLE 12 - ku_product_category TABLE Creation*/

CREATE TABLE ku_product_category
(
	id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    product_id INT DEFAULT NULL,
    category_id INT DEFAULT NULL,
    created_at TIMESTAMP DEFAULT current_timestamp,
    updated_at TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	FOREIGN KEY (product_id) REFERENCES ku_product(id),
    FOREIGN KEY (category_id) REFERENCES ku_category(id)
);

SELECT * FROM ku_product_category;

/* TABLE 13 - ku_product_category TABLE Creation*/

CREATE TABLE ku_order_detail
(
	id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    user_location_id INT DEFAULT NULL,
    order_id INT DEFAULT NULL,
    product_id INT DEFAULT NULL,
    quantity INT NOT NULL,
    delivery_date DATE,
    status INT DEFAULT NULL,
    created_at TIMESTAMP DEFAULT current_timestamp,
    updated_at TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (product_id) REFERENCES ku_product(id),
    FOREIGN KEY (order_id) REFERENCES ku_order(id),
    FOREIGN KEY (user_location_id) REFERENCES ku_user_location(id),
    FOREIGN KEY (status) REFERENCES ku_order_detail_status(id)
);


show tables;

select * from ku_user_status;
select * from ku_order_detail;