USE MyDatabase
-- CREATE TABLE for creating a new table

CREATE TABLE person(
id INT,
person_name VARCHAR(50) NOT NULL,
birth_date DATE,
phone VARCHAR(15) NOT NULL,
CONSTRAINT pk_persons PRIMARY KEY (id)
)

-- ALTER TABLE for modifing the table structure

ALTER TABLE person
ADD email VARCHAR(50) NOT NULL

--DROP to remove something from a table
ALTER TABLE person
DROP COLUMN phone

DROP TABLE person

--INSERT to insert some data in the table, coming also from other table

INSERT INTO customers(id,first_name,country,score)
VALUES (6, 'Anna', 'USA', NULL)

INSERT INTO person(id,person_name, birth_date, phone)
SELECT
id,
first_name,
NULL,
'Unknow'
FROM customers

--UPDATE for modifing specific data column of a table

UPDATE customers
SET score = 0
WHERE score IS NULL

SELECT * 
FROM customers

--DELETE for cancelling elements from a table

DELETE FROM customers
WHERE id > 5

--TRUNCATE will delete all the data from a table without delete the table itself