USE MASTER;
GO

CREATE DATABASE DataWarehouse;
GO

USE DataWarehouse;
GO

CREATE SCHEMA Bronze;   
GO

CREATE SCHEMA Silver;
GO

CREATE SCHEMA Gold;
GO

DROP TABLE dbo.crm_cust_info;
CREATE TABLE bronze.crm_cust_info(
    cst_id INT PRIMARY KEY,
    cst_key VARCHAR(50),
    cst_firstname VARCHAR(50),
    cst_lastname VARCHAR(50),
    cst_marital_status VARCHAR(50),
    cst_gndr VARCHAR(50),
    cst_create_date DATE
);

CREATE TABLE bronze.crm_prod_info(
    prod_id INT PRIMARY KEY,
    prod_key VARCHAR(50),
    prod_name VARCHAR(50),
    prod_cost INT,
    prod_line VARCHAR(50),
    prod_start_date DATE,
    prod_end_date DATE
);

CREATE TABLE bronze.crm_prod_info(
    prod_id INT PRIMARY KEY,
    prod_key VARCHAR(50),
    prod_name VARCHAR(50),
    prod_cost INT,
    prod_line VARCHAR(50),
    prod_start_date DATE,
    prod_end_date DATE
);

CREATE TABLE bronze.crm_sales_details(
    sales_order_number INT,
    sales_production_key VARCHAR(50),
    sales_customer_id INT,
    sales_order_date DATE,
    sales_ship_date DATE,
    sales_due_date DATE,
    sales_sales_amount INT,
    sales_quantity INT,
    sales_price INT,
);

CREATE TABLE bronze.erp_customers(
    customer_id INT PRIMARY KEY,
    customer_birth_date DATE,
    customer_gender VARCHAR(50)
  
);

CREATE TABLE bronze.erp_locations(
    location_id INT PRIMARY KEY,
    location_county VARCHAR(50)
);

CREATE TABLE bronze.erp_item(
    item_id INT PRIMARY KEY,
    item_category VARCHAR(50),
    item_subcategory VARCHAR(50),
    item_maintenance VARCHAR(50)

);