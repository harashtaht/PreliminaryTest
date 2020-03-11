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
    modified_at TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
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
    modified_at TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
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
    modified_at TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
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
    modified_at TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
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
    modified_at TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
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
    modified_at TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
    );

-- INSERT INTO ku_product_status (name) VALUES
-- ("active"),
-- ("inactive");

-- select * from ku_product_status;

/* TABLE 7 - ku_user_location TABLE Creation*/
-- 
CREATE TABLE ku_user_location
(
	id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    type INT DEFAULT NULL, 
    status INT DEFAULT NULL,
    user_id INT DEFAULT NULL,
	location GEOMETRY NOT NULL,
    address VARCHAR(255),
    created_at TIMESTAMP DEFAULT current_timestamp,
    modified_at TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	FOREIGN KEY (type) REFERENCES ku_user_location_type(id),
    FOREIGN KEY (status) REFERENCES ku_user_location_status(id),
    FOREIGN KEY (user_id) REFERENCES ku_user(id)
)
-- 

-- select *, ST_ASTEXT(location) AS 'loc2' from ku_user_location;

select id, type, status, user_id, ST_ASTEXT(location) AS 'location', address from ku_user_location;

-- INSERT INTO ku_user_location (type, status, user_id, location, address) VALUES
-- (4,1,1,ST_GeomFromText('POINT(-6.2266765 106.8034134)'),"Jl. Jend. Sudirman No.Kav. 61-62, RT.5/RW.3, Senayan, Kec. Kby. Baru, Kota Jakarta Selatan, Daerah Khusus Ibukota Jakarta 12190, Indonesia"),
-- (4,1,2,ST_GeomFromText('POINT(-6.2261233 106.8042908)'),"Gedung Summitmas II, Jl. Jend. Sudirman No.Kav 61-62, RT.5/RW.3, Senayan, Kec. Kby. Baru, Kota Jakarta Selatan, Daerah Khusus Ibukota Jakarta 12190, Indonesia"),
-- (4,1,3,ST_GeomFromText('POINT(-6.2061424 106.9099350)'),"Jalan Rawagatel Blok 5/37 No.38, RW.9, Jatinegara, Cakung, RW.9, Jatinegara, Kec. Cakung, Kota Jakarta Timur, Daerah Khusus Ibukota Jakarta 13930, Indonesia");


/* ## CODE for ST_GeomFromText POINT()
select 
*, ST_ASTEXT(position) AS 'pos_wkt' 
FROM testgeo2;
select
location.STAsText(), from

ref: https://stackoverflow.com/questions/53466771/mysql-how-to-insert-geometry-data
ref: https://itnext.io/playing-with-geometry-spatial-data-type-in-mysql-645b83880331
ref: https://books.google.co.id/books?id=pHeWWBY3cPEC&pg=PA251&lpg=PA251&dq=st+geomfromtext+table+properties&source=bl&ots=SUXl8kqTYq&sig=ACfU3U2Ihlyj3eJD31xx2tgrp0B58mS6uw&hl=en&sa=X&ved=2ahUKEwiOt56VhpPoAhXQZCsKHcnJBhMQ6AEwAHoECAYQAQ#v=onepage&q=st%20geomfromtext%20table%20properties&f=false
*/