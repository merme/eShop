CREATE TABLE SHOPS( SHOP_ID INTEGER PRIMARY KEY, NAME TEXT UNIQUE NOT NULL);

CREATE TABLE PRODUCTS(PRODUCT_ID INTEGER PRIMARY KEY, NAME TEXT UNIQUE NOT NULL);

CREATE TABLE PRICES(PRODUCT_ID INT NOT NULL REFERENCES SHOPS(SHOP_ID), SHOP_ID INT NOT NULL REFERENCES PRODUCTS(PRODUCT_ID),PRICE INT NOT NULL);