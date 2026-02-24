CREATE OR REPLACE FUNCTION "TransactionDetails".fn_intcalc(
	Amount decimal(18,5),
	FromDate date,
	ToDate date,
	InterestRate decimal(6,3)=10)
RETURNS decimal(18,5)
SECURITY INVOKER
AS $$
	DECLARE
		IntCalculated decimal(18,5);

	BEGIN
		IntCalculated := Amount * (InterestRate / 100.00) *
				(EXTRACT (DAY FROM ToDate::timestamp-FromDate::timestamp)/365.00);
		RETURN COALESCE(IntCalculated,0);
	END;
$$ LANGUAGE plpgsql;

================

SELECT "TransactionDetails".fn_intcalc (2000, '2023-03-01', '2023-03-10', 10);

================

CREATE OR REPLACE FUNCTION "TransactionDetails".fn_returntransactions (
	CustID bigint)
RETURNS TABLE (
	transactionid bigint,
	customerid bigint,
	transactiondescription varchar(30),
	dateentered timestamp(0),
	amount money)
SECURITY INVOKER
AS $$
SELECT
	t.transactionid as transactionid,
	t.customerid as customerid,
	tt.transactiondescription as transactiondescription,
	t.dateentered as dateentered,
	t.amount as amount
FROM "TransactionDetails".transactions t
JOIN "TransactionDetails".transactiontypes tt
	ON tt.transactiontypesid = t.transactiontype
WHERE t.customerid = CustID;
$$ LANGUAGE sql;

================

INSERT INTO "TransactionDetails".transactions
	(customerid, transactiontype, dateentered, amount,
	relatedproductid)
VALUES
	(1, 1, '2023-08-01', 100.00, 1),
	(1, 1, '2023-08-03', 75.67, 1),
	(1, 2, '2023-08-05', 35.20, 1),
	(1, 2, '2023-08-06', 20.00, 1);

================

INSERT INTO "TransactionDetails".Transactiontypes
	(transactiondescription, credittype, affectcashbalance)
VALUES
	( 'proc+', true, true),
	( 'proc-', true, true);

================

SELECT * FROM "TransactionDetails".fn_returntransactions(1);

================

SELECT
	c.customerfirstname,
	c.customerlastname,
	trans.transactionid,
	trans.transactiondescription,
	trans.dateentered,
	trans.amount
FROM "CustomerDetails".customers AS c
JOIN "TransactionDetails".fn_returntransactions (c.customerid) AS trans
	on c.customerid = trans.customerId;

================

CREATE PROCEDURE "CustomerDetails".spu_inscustomer(
	FirstName varchar(50),
	LastName varchar(50),
	CustTitle int,
	CustInitials varchar(10),
	AddressId int,
	AccountNumber varchar(15),
	AccountTypeId int
)
LANGUAGE plpgsql
AS $$
BEGIN
	INSERT INTO "CustomerDetails".customers (
		customertitleid,
		customerfirstname,
		customerotherinitials,
		customerlastname,
		addressid,
		accountnumber,
		accounttypeid,
		clearebalance,
		unclearebalance)
	VALUES (
		custtitle,
		firstname,
		custinitials,
		lastname,
		addressid,
		accountnumber,
		accounttypeid,
		0,
		0);
END;
$$

=======================

CALL "CustomerDetails".spu_inscustomer ('Henry','Williams',1,NULL,431,'22067531',1);

=======================

CALL "CustomerDetails".spu_inscustomer(
	custtitle => 1,
	firstname => 'Julie',
	custinitials => 'A',
	lastname => 'Dewson',
	addressid => 643,
	accountnumber => 'SS865',
	accounttypeid => 7);

=======================

CREATE OR REPLACE FUNCTION "CustomerDetails".fn_instransactions()
RETURNS TRIGGER
AS $$
BEGIN
	UPDATE "CustomerDetails".customers
	SET clearebalance = clearebalance + (
		SELECT
			CASE
				WHEN tt.credittype = false THEN (i.amount * -1)::money
				ELSE (i.amount)::money
			END
		FROM NEW AS i
		JOIN "TransactionDetails".transactiontypes AS tt
			ON tt.transactiontypesid = i.transactiontype
		WHERE tt.affectcashbalance = true )
	WHERE customerid = NEW.customerid;
	RETURN NULL;
END;
$$
LANGUAGE plpgsql;

========================

CREATE OR REPLACE TRIGGER tg_instransactions
	AFTER INSERT ON "TransactionDetails".transactions
	REFERENCING NEW TABLE AS NEW
	FOR EACH ROW EXECUTE FUNCTION "CustomerDetails".fn_instransactions();

========================

SELECT clearebalance FROM "CustomerDetails".customers WHERE customerid=1;

========================

INSERT INTO "TransactionDetails".transactions
(customerid, transactiontype, amount, relatedproductid, dateentered)
VALUES (1, 2, 200, 1, current_date);


========================

SELECT CleareBalance FROM "CustomerDetails".Customers WHERE CustomerId=1;

========================

INSERT INTO "TransactionDetails".transactions
(customerid, transactiontype, amount, relatedproductid, dateentered)
VALUES (1, 3, 200, 1, current_date);

========================

CREATE OR REPLACE FUNCTION "CustomerDetails".fn_instransactions()
RETURNS TRIGGER
AS $$
BEGIN
	UPDATE "CustomerDetails".customers
	SET clearebalance = clearebalance + COALESCE ((
		SELECT
			CASE
				WHEN tt.credittype = false THEN (i.amount * -1)::money
				ELSE (i.amount)::money
			END
		FROM NEW AS i
		JOIN "TransactionDetails".transactiontypes AS tt
			ON tt.transactiontypesid = i.transactiontype
		WHERE tt.affectcashbalance = true ),0::money)
	WHERE customerid = NEW.customerid;
	RETURN NULL;
END;
$$
LANGUAGE plpgsql;

========================

SELECT CleareBalance FROM "CustomerDetails".Customers WHERE CustomerId=1;

========================

INSERT INTO "TransactionDetails".transactions
(customerid, transactiontype, amount, relatedproductid, dateentered)
VALUES (1, 3, 200, 1, current_date);

========================

SELECT CleareBalance FROM "CustomerDetails".Customers WHERE CustomerId=1;