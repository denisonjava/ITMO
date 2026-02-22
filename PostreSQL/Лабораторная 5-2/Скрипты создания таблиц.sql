CREATE MATERIALIZED VIEW "ShareDetails"."V_currentshares"
AS
SELECT sharedesc, sharetickerid, currentprice AS "Last Price"
FROM "ShareDetails".shares
WHERE currentprice > 0
ORDER BY sharedesc
WITH NO DATA;

ALTER TABLE IF EXISTS "ShareDetails"."V_currentshares"
    OWNER TO denis;

=====================

CREATE MATERIALIZED VIEW "ShareDetails".v_shareprices
AS
SELECT
	sp.shareid,
	sp.price,
	sp.pricedate,
	vcs.sharedesc
FROM "ShareDetails".shareprices sp
INNER JOIN "ShareDetails".v_currentshares vcs
	ON sp.shareid = vcs.shareid
ORDER BY vcs.sharedesc, sp.pricedate DESC
WITH NO DATA;

ALTER TABLE IF EXISTS "ShareDetails".v_shareprices
    OWNER TO denis;

=====================

INSERT INTO "ShareDetails".shareprices
(shareid, price, pricedate)
VALUES
	(1, 2.155, '2023-08-01 10:10:10'),
	(1, 2.2125, '2023-08-01 10:12:00'),
	(1, 2.4175, '2023-08-01 10:16:00'),
	(1, 2.21, '2023-08-01 11:22:00'),
	(1, 2.17, '2023-08-01 14:54:00'),
	(1, 2.34125, '2023-08-01 16:10:00'),
	(2, 41.10, '2023-08-01 10:10:00'),
	(2, 43.22, '2023-08-02 10:10:00'),
	(2, 45.20, '2023-08-03 10:10:00');

=======================

INSERT INTO "ShareDetails".shares
(sharedesc, sharetickerid, currentprice)
VALUES ('FAT-BELLY.COM', 'FBC', 45.2000);

=======================

SELECT * FROM  "ShareDetails".v_shareprices

=======================

CREATE VIEW "CustomerDetails".v_custtrans
AS
SELECT
	c.accountnumber,
	c.customerfirstname,
	c.customerotherinitials,
	tt.transactiondescription,
	t.dateentered,
	t.amount,
	t.referencedetails
FROM "CustomerDetails".customers AS c
JOIN "TransactionDetails".transactions AS t
	ON t.customerid = c.customerid
JOIN "TransactionDetails".transactiontypes AS tt
	ON tt.transactiontypesid = t.transactiontype
ORDER BY c.accountnumber ASC, t.dateentered DESC;

========================

INSERT INTO "CustomerDetails".financialproducts
(productid, productname)
VALUES
	(1, 'Regular Savings'),
	(2, 'Bonds Account'),
	(3, 'Share Account'),
	(4, 'Life Insurance');

========================

INSERT INTO "CustomerDetails".customersproducts
(customerid, financialproductid, amounttocollect,
frequency, lastcollected, lastcollection, renewable)
VALUES
(1, 1, 200, 1, '31.08.2021', '31.08.2035', false),
(1, 2, 50, 1, '24.08.2023', '24 March 2025', false),
(2, 4, 150, 3, '20.08.2023', '20.08.2025', true),
(3, 3, 500, 0, '24.08.2023', '24.08.2025', true);

========================

DROP VIEW IF EXISTS "CustomerDetails".v_custfinproducts;

========================

CREATE VIEW "CustomerDetails".v_custfinproduct
AS SELECT
c.customerfirstname || ' ' || c.customerlastname as customername,
c.accountnumber, fp.productname, cp.amounttocollect,
cp.frequency, cp.lastcollected
FROM "CustomerDetails".customers AS c
JOIN "CustomerDetails".customersproducts AS cp
	ON cp.customerid = c.customerid
JOIN "CustomerDetails".financialproducts AS fp
	ON fp.productid = cp.financialproductid;

========================

ALTER TABLE "CustomerDetails".customers
ALTER COLUMN CustomerFirstName TYPE varchar(100);

========================

DROP VIEW IF EXISTS "CustomerDetails".v_custfinproduct;

========================


CREATE VIEW "CustomerDetails".v_custfinproduct
AS SELECT
c.customerfirstname || ' ' || c.customerlastname as customername,
c.accountnumber, fp.productname, cp.amounttocollect,
cp.frequency, cp.lastcollected
FROM "CustomerDetails".customers AS c
JOIN "CustomerDetails".customersproducts AS cp
	ON cp.customerid = c.customerid
JOIN "CustomerDetails".financialproducts AS fp
	ON fp.productid = cp.financialproductid;

========================

UPDATE "CustomerDetails".customers
SET customerlastname = 'Brusten'
WHERE customerlastname = 'Brust';

========================

SELECT * FROM "CustomerDetails".v_custfinproducts;