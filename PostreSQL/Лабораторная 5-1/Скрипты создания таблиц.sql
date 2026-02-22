INSERT INTO "ShareDetails".shares
   (sharedesc, 
	sharetickerid, 
	currentprice)
VALUES
	('ACME''HOMEBAKE COOKIES INC','AHCI',2.34125);

=============================

select * from "ShareDetails".shares;

=============================

INSERT INTO "CustomerDetails".customers (
customertitleid, customerfirstname, customerotherinittials, customerlastname, addressid, accountnumber, accounttypeid, clearebalance, unclearebalance, dateadded) VALUES (
'123'::integer, '{Dmitrij}'::character varying, NULL::character varying, '{Vetrov}'::character varying, '123'::bigint, '{123}', '123'::integer, '123'::money, '123'::money, '2023-07-30'::date)
 returning customerid;

=============================

SELECT * FROM "CustomerDetails".customers
ORDER BY customerid ASC 

=============================

INSERT INTO "CustomerDetails".customers
(customertitleid, customerlastname, customerfirstname, 
customerotherinitials, addressid, accountnumber,
accounttypeid, clearebalance, unclearebalance)
VALUES (3,'Lobel','Leonard', NULL, 145, 53431993, 1, 437.97, -10.56);

=============================

DELETE FROM "CustomerDetails".customers
WHERE customerid = 2;

=============================

ALTER TABLE "CustomerDetails".customers
ALTER COLUMN customerfirstname TYPE character varying(50);

ALTER TABLE "CustomerDetails".customers
ALTER COLUMN customerotherinitials TYPE character varying(10);

ALTER TABLE "CustomerDetails".customers
ALTER COLUMN customerlastname TYPE character varying(50);

ALTER TABLE "CustomerDetails".customers
ALTER COLUMN accountnumber TYPE character varying(15);

=============================

ALTER TABLE "CustomerDetails".customers
ALTER COLUMN customerid
DROP IDENTITY;

=============================

UPDATE "CustomerDetails".customers
SET customerid = 1;

=============================

ALTER TABLE "CustomerDetails".customers
ALTER COLUMN customerid
ADD GENERATED ALWAYS AS IDENTITY;

=============================

INSERT INTO "CustomerDetails".customers
(customertitleid, customerlastname, customerfirstname, 
customerotherinitials, addressid, accountnumber,
accounttypeid, clearebalance, unclearebalance)
VALUES (1, 'Brust', 'Andrew', 'J.', 133, 18176111, 1, 200.00, 2.00),
       (3, 'Lobel', 'Leonard', NULL, 145, 53431993, 1, 437.97, -10.56);

=============================

ALTER SEQUENCE "CustomerDetails".customers_customerid_seq RESTART WITH 2;

=============================

SELECT * FROM "CustomerDetails".customers

=============================

ALTER TABLE "CustomerDetails".customersproducts
ADD CONSTRAINT pk_customersproducts
PRIMARY KEY (customerfinancialproductid);

ALTER TABLE "CustomerDetails".customersproducts
ADD CONSTRAINT ck_custprods_amtcheck
CHECK (amounttocollect > 0::money);

ALTER TABLE "CustomerDetails".customersproducts
ALTER COLUMN renewable
SET DEFAULT false;

=============================

INSERT INTO "CustomerDetails".customersproducts
(customerid,financialproductid,amounttocollect,frequency
,lastcollected,lastcollection,renewable)
VALUES (1, 1, -100, 0, '2023-08-24', '2023-08-24', false);

=============================

INSERT INTO "CustomerDetails".customersproducts
(customerid,financialproductid,amounttocollect,frequency
,lastcollected,lastcollection,renewable)
VALUES (1, 1, 100, 0, '2023-08-24', '2023-08-20', false);

=============================

INSERT INTO "CustomerDetails".customers(
	customertitleid, customerfirstname, customerotherinitials, customerlastname, addressid, accountnumber, accounttypeid, clearebalance, unclearebalance)
	VALUES (3, 'Bernie', 'I', 'McGee', 314, 65368765, 1, 6653.11, 0.00),
	(2, 'Julie', 'A', 'Dewson', 2134, 81625422, 1, 53.32, -12.21),
	(3, 'Kirsty', NULL, 'Hull', 4312, 96565334, 1, 1266.00, 10.32);

=============================

INSERT INTO "ShareDetails".shares
(sharedesc, sharetickerid, currentprice)
VALUES ('FAT-BELLY.COM','FBC',45.20),
('NetRadio Inc','NRI',29.79),
('Texas Oil Industries','TOI',0.455),
('London Bridge Club','LBC',1.46);

=============================

SELECT * FROM "CustomerDetails".customers;

=============================

SELECT customerfirstname, customerlastname, clearebalance
FROM "CustomerDetails".customers;

=============================

SELECT
	customerfirstname AS "First Name",
	customerlastname AS "Last Name",
	clearebalance Balance
FROM "CustomerDetails".customers;

=============================

UPDATE "CustomerDetails".customers
SET customerlastname = 'Brodie'
WHERE customerid = 4;

=============================

DO
$$
DECLARE
	ValueToUpdate VARCHAR(30);
BEGIN
	ValueToUpdate := 'McGlynn';

	UPDATE "CustomerDetails".customers
	SET customerlastname = ValueToUpdate,
		clearebalance = clearebalance + unclearebalance,
		unclearebalance = 0
	WHERE customerlastname = 'Brodie';
END
$$

=============================

DO
$$
DECLARE
	WrongDataType VARCHAR(20) := '4311,22';
BEGIN
	UPDATE "CustomerDetails".customers
	SET clearebalance = WrongDataType::money
	WHERE customerid = 4;
END
$$

=============================

CREATE TEMPORARY TABLE tmp_customers
AS SELECT
	customerid,
	customerfirstname,
	customerotherinitials,
	customerlastname
FROM "CustomerDetails".customers

=============================

SELECT * FROM tmp_customers

=============================

DELETE FROM tmp_customers
WHERE customerid = 4;

=============================

INSERT INTO tmp_customers
(customerfirstname, customerotherinitials, customerlastname)
VALUES ('Dmitrij', 'J', 'Vetrov');

=============================

ALTER TABLE tmp_customers
ALTER COLUMN customerid
SET NOT NULL

=============================

ALTER TABLE tmp_customers
ALTER COLUMN customerid
ADD GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 7 );

=============================

INSERT INTO tmp_customers
(customerfirstname, customerotherinitials, customerlastname)
VALUES ('Dmitrij', 'J', 'Vetrov');

=============================

INSERT INTO tmp_customers
(customerfirstname, customerotherinitials, customerlastname)
VALUES ('Dmitrij', 'J', 'Vetrov')

=============================

TRUNCATE TABLE tmp_customers;

=============================

INSERT INTO tmp_customers
(customerfirstname, customerotherinitials, customerlastname)
VALUES ('Dmitrij', 'J', 'Vetrov')

=============================

ALTER TABLE tmp_customers
ALTER COLUMN customerid
DROP IDENTITY;

=============================

ALTER TABLE tmp_customers
ALTER COLUMN customerid
ADD GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 );

=============================

TRUNCATE TABLE tmp_customers RESTART IDENTITY

=============================

INSERT INTO tmp_customers
(customerfirstname, customerotherinitials, customerlastname)
VALUES ('Dmitrij', 'J', 'Vetrov')

=============================


