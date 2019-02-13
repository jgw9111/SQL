
DROP TABLE ORDER_DETAILS;
DROP TABLE PRODUCTS;
DROP TABLE CATEGORIES;
DROP TABLE SUPPLIERS;
DROP TABLE ORDERS;
DROP TABLE SHIPPERS;
DROP TABLE EMPLOYEES;
DROP TABLE CUSTOMERS;
DROP SEQUENCE ORDER_ID;
DROP SEQUENCE CATEGORI_ID;
DROP SEQUENCE PRODUCT_ID;
DROP SEQUENCE ORDER_DETAIL_ID;

CREATE TABLE Customers(
CUSTOMER_ID   VARCHAR2 (15) PRIMARY KEY,
CUSTOMER_NAME VARCHAR2 (15) NOT NULL,
PASSWORD      VARCHAR2 (15) NOT NULL,
ADDRESS       VARCHAR2 (50) NOT NULL,
CITY          VARCHAR2 (50) NOT NULL,
POSTAL_CODE   VARCHAR2 (15) NOT NULL,
SSN           VARCHAR2 (15) NOT NULL,
PHOEN_NUMBER  VARCHAR2 (20),
PHOTO         VARCHAR2 (30)
);

CREATE TABLE EMPLOYEES(
EMPLOYEE_ID VARCHAR2 (15) PRIMARY KEY,
NAME VARCHAR2(15) NOT NULL,
BIRTH_DATE VARCHAR2(15) NOT NULL,
PHOTO VARCHAR2(15),
NOTES VARCHAR2(15),
MANAGER     VARCHAR2 (15)
);

CREATE TABLE SHIPPERS(
SHIPPER_ID VARCHAR2(15) PRIMARY KEY,
SHIPPER_NAME VARCHAR2(15) NOT NULL,
PHONE VARCHAR2(15) NOT NULL
);

CREATE SEQUENCE ORDER_ID
START WITH 1000
INCREMENT BY 1;

CREATE TABLE ORDERS(
ORDER_ID NUMBER PRIMARY KEY,
CUSTOMER_ID VARCHAR2(15) NOT NULL,
EMPLOYEE_ID VARCHAR2(15) NOT NULL,
ORDER_DATE DATE DEFAULT SYSDATE NOT NULL,
SHIPPER_ID VARCHAR2(15) NOT NULL,
CONSTRAINT ORDERS_FK_CUSTOMERS FOREIGN KEY(CUSTOMER_ID) REFERENCES CUSTOMERS(CUSTOMER_ID),
CONSTRAINT ORDERS_FK_EMPLOYEES FOREIGN KEY(EMPLOYEE_ID) REFERENCES EMPLOYEES(EMPLOYEE_ID),
CONSTRAINT ORDERS_FK_SHIPPERS FOREIGN KEY(SHIPPER_ID) REFERENCES SHIPPERS(SHIPPER_ID)
);

CREATE TABLE SUPPLIERS(
SUPPLIER_ID VARCHAR2(15) PRIMARY KEY,
SUPPLIER_NAME VARCHAR2(15) NOT NULL,
CONTACT_NAME VARCHAR2(15) NOT NULL,
ADDRESS VARCHAR2(15) NOT NULL,
CITY VARCHAR2(15) NOT NULL,
POSTAL_CODE VARCHAR2(15) NOT NULL,
COUNTRY VARCHAR2(15) NOT NULL,
PHONE VARCHAR2(15) NOT NULL
);

CREATE SEQUENCE CATEGORI_ID
START WITH 1000
INCREMENT BY 1;

CREATE TABLE CATEGORIES(
CATEGORY_ID NUMBER PRIMARY KEY,
CATEGORY_NAME VARCHAR2(15) NOT NULL,
DESCRIPTION VARCHAR2(15)
);


CREATE SEQUENCE PRODUCT_ID
START WITH 1000
INCREMENT BY 1;

CREATE TABLE PRODUCTS(
PRODUCT_ID NUMBER PRIMARY KEY,
PRODUCT_NAME VARCHAR2(15) NOT NULL,
SUPPLIER_ID VARCHAR2(15) NOT NULL,
CATEGORY_ID NUMBER NOT NULL,
UNIT VARCHAR2(15),
PRICE NUMBER NOT NULL,
CONSTRAINT PRODUCTS_FK_SUPPLIERS FOREIGN KEY(SUPPLIER_ID) REFERENCES SUPPLIERS(SUPPLIER_ID),
CONSTRAINT PRODUCTS_FK_CATEGORIES FOREIGN KEY(CATEGORY_ID) REFERENCES CATEGORIES(CATEGORY_ID)
);


CREATE SEQUENCE ORDER_DETAIL_ID
START WITH 1000
INCREMENT BY 1;

CREATE TABLE ORDER_DETAILS(
ORDER_DETAIL_ID NUMBER PRIMARY KEY,
ORDER_ID NUMBER NOT NULL,
PRODUCT_ID NUMBER NOT NULL,
QUANTITY NUMBER NOT NULL,
CONSTRAINT ORDERDETAILS_FK_ORDERS FOREIGN KEY(ORDER_ID) REFERENCES ORDERS(ORDER_ID),
CONSTRAINT ORDERDETAILS_FK_PRODUCTS FOREIGN KEY(PRODUCT_ID) REFERENCES PRODUCTS(PRODUCT_ID)
);


INSERT INTO CUSTOMERS(CUSTOMER_ID,CUSTOMER_NAME,PASSWORD,SSN,PHOEN_NUMBER,CITY,ADDRESS,POSTAL_CODE) VALUES ('jgw9111','������','920901','929001-2','010-1992-0901','��õ������ ���� ����� 27','�˴�����1����','22657');
INSERT INTO CUSTOMERS(CUSTOMER_ID,CUSTOMER_NAME,PASSWORD,SSN,PHOEN_NUMBER,CITY,ADDRESS,POSTAL_CODE) VALUES ('easy1228','������','921228','921228-2','010-1992-1228','��õ�� ���� ���ֳ���10���� 21','���̾Ⱥ���','21357');
INSERT INTO CUSTOMERS(CUSTOMER_ID,CUSTOMER_NAME,PASSWORD,SSN,PHOEN_NUMBER,CITY,ADDRESS,POSTAL_CODE) VALUES ('blackbean','������','921214','921214-2','010-1992-1214','���� �������� ���ŷ� 191','���μ�Ʈ����','07258');
INSERT INTO CUSTOMERS(CUSTOMER_ID,CUSTOMER_NAME,PASSWORD,SSN,PHOEN_NUMBER,CITY,ADDRESS,POSTAL_CODE) VALUES ('dididi','������','940613','940613-2','010-1994-0613','��⵵ �Ȼ�� ��ϱ� ����� 48','�������Ʈ','15538');
INSERT INTO CUSTOMERS(CUSTOMER_ID,CUSTOMER_NAME,PASSWORD,SSN,PHOEN_NUMBER,CITY,ADDRESS,POSTAL_CODE) VALUES ('silver0','������','910211','910211-2','010-1991-0211','��⵵ ������ �ǿ���� 92','��â1�����ְ�','11917');
INSERT INTO CUSTOMERS(CUSTOMER_ID,CUSTOMER_NAME,PASSWORD,SSN,PHOEN_NUMBER,CITY,ADDRESS,POSTAL_CODE) VALUES ('jgs1119','������','940407','940407-2','010-1994-0407','��⵵ ��õ�� �Ȱ�� 16���� 47','��������Ʈ','14699');
INSERT INTO CUSTOMERS(CUSTOMER_ID,CUSTOMER_NAME,PASSWORD,SSN,PHOEN_NUMBER,CITY,ADDRESS,POSTAL_CODE) VALUES ('oreooo','��¾�','911104','911104-2','010-1991-1104','����� ������ �Ƹ�����50�� 50','���̾���������Ʈ����','05229');
INSERT INTO CUSTOMERS(CUSTOMER_ID,CUSTOMER_NAME,PASSWORD,SSN,PHOEN_NUMBER,CITY,ADDRESS,POSTAL_CODE) VALUES ('Blackcu','������','931228','931228-1','010-1994-1228','��⵵ ���ֽ� �絿1�� 52','�����Ѿ�����θ����Ӹ���','10819');
INSERT INTO CUSTOMERS(CUSTOMER_ID,CUSTOMER_NAME,PASSWORD,SSN,PHOEN_NUMBER,CITY,ADDRESS,POSTAL_CODE) VALUES ('Blackrr','��â��','930523','930523-1','010-1993-0523','��⵵ ���ֽ� �絿1�� 52','�����Ѿ�����θ����Ӹ���','10819');
INSERT INTO CUSTOMERS(CUSTOMER_ID,CUSTOMER_NAME,PASSWORD,SSN,PHOEN_NUMBER,CITY,ADDRESS,POSTAL_CODE) VALUES ('Black27','����ȣ','960721','960721-1','010-1996-0627','����Ư���� ������ ��ȭ���37�� 15','�ŵ��ƾ���Ʈ','07605');
INSERT INTO CUSTOMERS(CUSTOMER_ID,CUSTOMER_NAME,PASSWORD,SSN,PHOEN_NUMBER,CITY,ADDRESS,POSTAL_CODE) VALUES ('starbucks','������','911227','911227-1','010-1991-1227','����� ������ �Ƹ�����97�� 20','���ϸ�����ũ','05209');
INSERT INTO CUSTOMERS(CUSTOMER_ID,CUSTOMER_NAME,PASSWORD,SSN,PHOEN_NUMBER,CITY,ADDRESS,POSTAL_CODE) VALUES ('parkmih','�ڹ���','920419','920419-2','010-1992-0419','��⵵ ��õ�� ���ȷ� 130-27','������������Ʈ','14778');
INSERT INTO CUSTOMERS(CUSTOMER_ID,CUSTOMER_NAME,PASSWORD,SSN,PHOEN_NUMBER,CITY,ADDRESS,POSTAL_CODE) VALUES ('chichimom','������','921020','921020-2','010-1992-1020','��⵵ ��õ�� ���η�134���� 16','��õ�������','14726');
INSERT INTO CUSTOMERS(CUSTOMER_ID,CUSTOMER_NAME,PASSWORD,SSN,PHOEN_NUMBER,CITY,ADDRESS,POSTAL_CODE) VALUES ('universe','��â��','950123','950123-1','010-1995-0123','����� ������ ��ϻ��1�� 24','��Ͽ�������ũ','03907');
INSERT INTO CUSTOMERS(CUSTOMER_ID,CUSTOMER_NAME,PASSWORD,SSN,PHOEN_NUMBER,CITY,ADDRESS,POSTAL_CODE) VALUES ('seooooh','������','890707','890707-1','010-1989-0707','��õ������ ��籸 �������� 100','��缾Ʈ����1����','21017');
INSERT INTO CUSTOMERS(CUSTOMER_ID,CUSTOMER_NAME,PASSWORD,SSN,PHOEN_NUMBER,CITY,ADDRESS,POSTAL_CODE) VALUES ('youjungchoi','������','911211','911211-2','010-1991-1211','��⵵ ������ �����߾ӷ� 16','����Ǫ������','11902');
INSERT INTO CUSTOMERS(CUSTOMER_ID,CUSTOMER_NAME,PASSWORD,SSN,PHOEN_NUMBER,CITY,ADDRESS,POSTAL_CODE) VALUES ('hojunee','��ȣ��','900211','900211-1','010-1990-0211','��⵵ ������ �����߾ӷ� 16','����Ǫ������','11902');
INSERT INTO CUSTOMERS(CUSTOMER_ID,CUSTOMER_NAME,PASSWORD,SSN,PHOEN_NUMBER,CITY,ADDRESS,POSTAL_CODE) VALUES ('wonwool','�̿���','180901','180901-1','010-2018-0901','��⵵ ������ �����߾ӷ� 16','����Ǫ������','11902');
INSERT INTO CUSTOMERS(CUSTOMER_ID,CUSTOMER_NAME,PASSWORD,SSN,PHOEN_NUMBER,CITY,ADDRESS,POSTAL_CODE) VALUES ('kimkrystal','�����','921023','921023-2','010-1992-1023','��⵵ ����� ����� 93-1','������Ǫ������','14919');
INSERT INTO CUSTOMERS(CUSTOMER_ID,CUSTOMER_NAME,PASSWORD,SSN,PHOEN_NUMBER,CITY,ADDRESS,POSTAL_CODE) VALUES ('kimyounhye','������','930122','930122-2','010-1993-0122','��⵵ ��õ�� �Ȱ�� 54','�ݱ�������','14689');
INSERT INTO CUSTOMERS(CUSTOMER_ID,CUSTOMER_NAME,PASSWORD,SSN,PHOEN_NUMBER,CITY,ADDRESS,POSTAL_CODE) VALUES ('jabjab','�����','921008','921008-2','010-1992-1008','����� ���α� ���η�20�� 6','����������Ƽ','08271');
INSERT INTO CUSTOMERS(CUSTOMER_ID,CUSTOMER_NAME,PASSWORD,SSN,PHOEN_NUMBER,CITY,ADDRESS,POSTAL_CODE) VALUES ('baskinjulen','������','920317','920317-2','010-1992-0317','��⵵ ���ν� ������ ���������� 62','�����������','16943');
INSERT INTO CUSTOMERS(CUSTOMER_ID,CUSTOMER_NAME,PASSWORD,SSN,PHOEN_NUMBER,CITY,ADDRESS,POSTAL_CODE) VALUES ('hongjunee','��ȫ��','920707','920707-1','010-1992-0707','��� ��õ�� ������ 234-38','������ġ���漾Ʈ��','14786');
INSERT INTO CUSTOMERS(CUSTOMER_ID,CUSTOMER_NAME,PASSWORD,SSN,PHOEN_NUMBER,CITY,ADDRESS,POSTAL_CODE) VALUES ('haeinny','������','921004','921004-2','010-1992-1004','��� ��õ�� ���ο���108���� 15','����1������Ʈ','14696');
INSERT INTO CUSTOMERS(CUSTOMER_ID,CUSTOMER_NAME,PASSWORD,SSN,PHOEN_NUMBER,CITY,ADDRESS,POSTAL_CODE) VALUES ('marymom','������','920403','920403-2','010-1992-0403','��⵵ ��õ�� ���η�484���� 68-7','��������Ʈ��','14688');
INSERT INTO CUSTOMERS(CUSTOMER_ID,CUSTOMER_NAME,PASSWORD,SSN,PHOEN_NUMBER,CITY,ADDRESS,POSTAL_CODE) VALUES ('kimone','���ϳ�','920511','920511-2','010-1992-0511','����� ������ ������18�� 11','���̾�����Ʈ��','04091');
INSERT INTO CUSTOMERS(CUSTOMER_ID,CUSTOMER_NAME,PASSWORD,SSN,PHOEN_NUMBER,CITY,ADDRESS,POSTAL_CODE) VALUES ('videditork','������','920707','920707-2','010-1992-2727','���� ������ ������� 262','������Ÿ��Ƽ','05065');
INSERT INTO CUSTOMERS(CUSTOMER_ID,CUSTOMER_NAME,PASSWORD,SSN,PHOEN_NUMBER,CITY,ADDRESS,POSTAL_CODE) VALUES ('sungmun','�ۼ���','960829','960829-1','010-1996-0829','���� ���α� ������2�� 133-15','����������ũ','08331');
INSERT INTO CUSTOMERS(CUSTOMER_ID,CUSTOMER_NAME,PASSWORD,SSN,PHOEN_NUMBER,CITY,ADDRESS,POSTAL_CODE) VALUES ('hasungk','���ϼ�','951017','951017-1','010-1995-1027','���� ��õ�� ������ 170','����6������Ʈ','08110');
INSERT INTO CUSTOMERS(CUSTOMER_ID,CUSTOMER_NAME,PASSWORD,SSN,PHOEN_NUMBER,CITY,ADDRESS,POSTAL_CODE) VALUES ('doyeon','�赵��','991204','991204-2','010-1999-1204','������ ���ֽ� ��ǰ�� 199','���ֹݰ������ũ','26458');
INSERT INTO CUSTOMERS(CUSTOMER_ID,CUSTOMER_NAME,PASSWORD,SSN,PHOEN_NUMBER,CITY,ADDRESS,POSTAL_CODE) VALUES ('haribo','��Ƹ�','920623','920623-2','010-1992-0623','��� ��õ�� ���ο���108���� 15','����1������Ʈ','14696');
INSERT INTO CUSTOMERS(CUSTOMER_ID,CUSTOMER_NAME,PASSWORD,SSN,PHOEN_NUMBER,CITY,ADDRESS,POSTAL_CODE) VALUES ('jeonhayeon','���Ͽ�','920113','920113-2','010-1992-0113','��⵵ ����� �ϻ굿�� ����Ƽ4�� 45','����Ƽ�ϻ�����','10323');

SELECT * FROM EMPLOYEES;
SELECT * FROM TAB;

SELECT COUNT(*) AS COUNT FROM CUSTOMERS;

commit;

SELECT * FROM CUSTOMERS;