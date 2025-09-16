USE kailua_car_rental;


CREATE TABLE IF NOT EXISTS car_types
(
    car_type_id INT PRIMARY KEY AUTO_INCREMENT,
    car_type    VARCHAR(200)
);

INSERT INTO car_types (car_type)
VALUES ('Luxury (>3000 ccm, automatic gear, air condition, cruise control, leather seats)'),
       ('Family (manual gear, air condition, some with cruise control, 7 seats or more)'),
       ('Sport (manual  gear, > 200 hp)');




CREATE TABLE IF NOT EXISTS cars
(
    car_id                    INT PRIMARY KEY AUTO_INCREMENT,
    brand                     VARCHAR(100) NOT NULL,
    model                     VARCHAR(100) NOT NULL,
    fuel_type                 VARCHAR(20)  NOT NULL,
    registration_number_plate VARCHAR(10)  NOT NULL,
    first_reg_year_and_month  DATE         NOT NULL,
    km_driven                 INT,
    car_type_id               INT          NOT NULL,
    FOREIGN KEY (car_type_id) REFERENCES car_types (car_type_id)
);

INSERT INTO cars (brand, model, fuel_type, registration_number_plate, first_reg_year_and_month, km_driven, car_type_id)
VALUES
    #Luxury
    ('Tesla', 'Model S', 'Electric', 'EL90000', '2022-04-01', 15000, 1),
    ('BMW', '7 Series', 'Petrol', 'BM70000', '2020-09-01', 42000, 1),
    ('Mercedes', 'S-Class', 'Diesel', 'ME12345', '2019-11-01', 61000, 1),

    #Family
    ('Toyota', 'Corolla', 'Petrol', 'AB12345', '2018-05-01', 75000, 2),
    ('Volkswagen', 'Touran', 'Diesel', 'VW33333', '2020-07-01', 39000, 2),
    ('Ford', 'Galaxy', 'Hybrid', 'FO98765', '2017-03-01', 105000, 2),

    #Sport
    ('Porsche', '911 Carrera', 'Petrol', 'PO91111', '2021-06-01', 22000, 3),
    ('Mazda', 'MX-5', 'Petrol', 'MA55555', '2019-08-01', 48000, 3),
    ('Audi', 'TT RS', 'Petrol', 'AU77777', '2020-02-01', 31000, 3);




CREATE TABLE IF NOT EXISTS renters
(
    renter_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(200) NOT NULL,
    address VARCHAR(250) NOT NULL,
    zip_code INT(10) NOT NULL,
    city VARCHAR(100) NOT NULL,
    mobile_phone INT(20) NOT NULL,
    phone INT(20),
    email VARCHAR(100) NOT NULL,
    driver_license_number INT(50) NOT NULL,
    driver_since_date DATE

);

INSERT INTO renters (name, address, zip_code, city, mobile_phone, phone, email, driver_license_number, driver_since_date)
VALUES
    ('Anna Jensen', 'Nørrebrogade 45', 2200, 'København N', 20112233, NULL, 'anna.jensen@email.com', 12345678, '2015-06-15'),
    ('Mikkel Sørensen', 'Åboulevard 12', 1960, 'Frederiksberg', 22446688, 33221144, 'mikkel.soerensen@email.com', 23456789, '2012-03-10'),
    ('Sara Holm', 'Skanderborgvej 89', 8000, 'Aarhus C', 28997766, NULL, 'sara.holm@email.com', 34567890, '2018-09-20'),
    ('Jonas Pedersen', 'Vestergade 101', 5000, 'Odense C', 26778899, 65998877, 'jonas.pedersen@email.com', 45678901, '2010-01-05'),
    ('Maria Kristensen', 'Slotsgade 7', 9000, 'Aalborg', 21114455, NULL, 'maria.kristensen@email.com', 56789012, '2016-11-25');




CREATE TABLE IF NOT EXISTS renter_contract
( #har fjernet de felter der gik igen, da det er bedre, hvis de refererer til renter/car direkte - 3.normalform???
    contract_id INT PRIMARY KEY AUTO_INCREMENT,
    from_date_time DATETIME NOT NULL,
    to_date_time DATETIME NOT NULL,
    max_km INT,
    km_when_rental_start INT,
    renter_id INT NOT NULL,
    car_id INT NOT NULL,
    FOREIGN KEY (renter_id) REFERENCES renters (renter_id),
    FOREIGN KEY (car_id) REFERENCES cars (car_id)
);

INSERT INTO renter_contract (from_date_time, to_date_time, max_km, km_when_rental_start, renter_id, car_id)
VALUES
    #Anna lejer Tesla Model S
    ('2023-05-01 10:00:00', '2023-05-07 14:30:00', 1500, 15000, 1, 1),
    #Mikkel lejer BMW 7 Series
    ('2023-06-10 09:00:00', '2023-06-20 16:00:00', 2000, 42000, 2, 2),
    #Sara lejer Mercedes S-Class
    ('2023-07-01 12:00:00', '2023-07-14 18:00:00', 2500, 61000, 3, 3),
    #Jonas lejer Toyota Corolla
    ('2023-08-05 08:30:00', '2023-08-10 11:00:00', 1000, 75000, 4, 4),
    #Maria lejer VW Touran
    ('2023-09-15 15:00:00', '2023-09-22 10:30:00', 1800, 39000, 5, 5);


