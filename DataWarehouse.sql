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