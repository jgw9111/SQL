CREATE TABLE Customers(
customer_id VARCHAR2(15) PRIMARY KEY,
customer_name VARCHAR2(15) NOT NULL,
contact_name VARCHAR2(15) NOT NULL UNIQUE,
address VARCHAR2(15) NOT NULL,
city VARCHAR2(15) NOT NULL,
postal_code VARCHAR2(15) NOT NULL,
country VARCHAR2(15) NOT NULL
);

CREATE TABLE Employees(
employee_id VARCHAR2(15) PRIMARY KEY,
name VARCHAR2(15) NOT NULL,
birth_date VARCHAR2(15) NOT NULL UNIQUE,
photo VARCHAR2(15),
notes VARCHAR2(15)
);

SELECT * FROM Employees;
ALTER TABLE Employees ADD MANAGER VARCHAR2(15);

CREATE TABLE Shippers(
shipper_id VARCHAR2(15) PRIMARY KEY,
shipper_name VARCHAR2(15) NOT NULL,
phone VARCHAR2(15) NOT NULL
);

CREATE SEQUENCE order_id
START WITH 1000
INCREMENT BY 1;

CREATE TABLE Orders(
order_id NUMBER PRIMARY KEY,
customer_id VARCHAR2(15) NOT NULL,
employee_id VARCHAR2(15) NOT NULL,
order_date DATE DEFAULT SYSDATE NOT NULL,
shipper_id VARCHAR2(15) NOT NULL,
CONSTRAINT Orders_FK_Customers FOREIGN KEY(customer_id) REFERENCES Customers(customer_id),
CONSTRAINT Orders_FK_Employees FOREIGN KEY(employee_id) REFERENCES Employees(employee_id),
CONSTRAINT Orders_FK_Shippers FOREIGN KEY(shipper_id) REFERENCES Shippers(shipper_id)
);

CREATE TABLE Suppliers(
supplier_id VARCHAR2(15) PRIMARY KEY,
supplier_name VARCHAR2(15) NOT NULL,
contact_name VARCHAR2(15) NOT NULL,
address VARCHAR2(15) NOT NULL,
city VARCHAR2(15) NOT NULL,
postal_code VARCHAR2(15) NOT NULL,
country VARCHAR2(15) NOT NULL,
phone VARCHAR2(15) NOT NULL
);

CREATE SEQUENCE categori_id
START WITH 1000
INCREMENT BY 1;

CREATE TABLE Categories(
category_id NUMBER PRIMARY KEY,
category_name VARCHAR2(15) NOT NULL,
description VARCHAR2(15)
);


CREATE SEQUENCE product_id
START WITH 1000
INCREMENT BY 1;

CREATE TABLE Products(
product_id NUMBER PRIMARY KEY,
product_name VARCHAR2(15) NOT NULL,
supplier_id VARCHAR2(15) NOT NULL,
category_id NUMBER NOT NULL,
unit VARCHAR2(15),
price NUMBER NOT NULL,
CONSTRAINT Products_FK_Suppliers FOREIGN KEY(supplier_id) REFERENCES Suppliers(supplier_id),
CONSTRAINT Products_FK_Categories FOREIGN KEY(category_id) REFERENCES Categories(category_id)
);


CREATE SEQUENCE order_detail_id
START WITH 1000
INCREMENT BY 1;

CREATE TABLE Order_Details(
order_detail_id NUMBER PRIMARY KEY,
order_id NUMBER NOT NULL,
product_id NUMBER NOT NULL,
quantity NUMBER NOT NULL,
CONSTRAINT Orderdetails_FK_Orders FOREIGN KEY(order_id) REFERENCES Orders(order_id),
CONSTRAINT Orderdetails_FK_Products FOREIGN KEY(product_id) REFERENCES Products(product_id)
);

SELECT * FROM TAB;
SELECT * FROM CUSTOMERS;
DROP TABLE Order_Details;
