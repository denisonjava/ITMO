CREATE TABLE "CustomerDetails".customers
(
    customerid bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 ),
    customertitleid integer NOT NULL,
    customerfirstname character varying(50) NOT NULL,
    customerotherinittials character varying(10),
    customerlastname character varying(50) NOT NULL,
    addressid bigint NOT NULL,
    accountnumber character(15)[] NOT NULL,
    accounttypeid integer NOT NULL,
    clearebalance money NOT NULL,
    unclearebalance money NOT NULL,
    dateadded date NOT NULL DEFAULT current_date,
    PRIMARY KEY (customerid)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS "TransactionDetails".customers
    OWNER to denis;

COMMENT ON TABLE "TransactionDetails".customers
    IS 'customers table';
	
===============

CREATE TABLE "TransactionDetails".transactions (
	transactionid bigint GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1)
					     PRIMARY KEY NOT NULL,
	customerid bigint NOT NULL,
	transactiontype int NOT NULL,
	dateentered timestamp(0) NOT NULL,
	amount numeric(18,5) NOT NULL,
	referencedetails varchar(50) NULL,
	notes varchar NULL,
	relatedshareid bigint NULL,
	relatedproductid bigint NOT NULL);
	
===============

CREATE TABLE "TransactionDetails".transactiontypes(
	transactiontypesid int GENERATED ALWAYS AS IDENTITY NOT NULL,
	transactiondescription varchar(30) NOT NULL,
	credittype boolean NOT NULL
)

=================

ALTER TABLE "TransactionDetails".transactiontypes
ADD affectcashbalance boolean NULL;

=================

ALTER TABLE "TransactionDetails".transactiontypes
ALTER COLUMN affectcashbalance SET NOT NULL;

=================

ALTER TABLE "TransactionDetails".transactiontypes
ADD CONSTRAINT PK_TransactionnTypes PRIMARY KEY (transactiontypesid);

=================

CREATE SCHEMA IF NOT EXISTS "CustomerDetails"
    AUTHORIZATION denis;

CREATE TABLE "CustomerDetails".customersproducts
(
	customerfinancialproductid bigint GENERATED ALWAYS AS IDENTITY NOT NULL,
	customerid bigint NOT NULL,
	financialproductid bigint NOT NULL,
	amounttocollect money NOT NULL,
	frequency int NOT NULL,
	lastcollected timestamp(0) NOT NULL,
	lastcollection timestamp(0) NOT NULL,
	renewable boolean NOT NULL
);

==================

CREATE TABLE "CustomerDetails".financialproducts
(
	productid bigint NOT NULl,
	productname varchar(50) NOT NULL
);

==================

CREATE SCHEMA "SharedDetails" AUTHORIZATION denis;

==================

CREATE TABLE "ShareDetails".shareprices (
	sharepriceid bigint GENERATED ALWAYS AS IDENTITY NOT NULL,
	shareid bigint NOT NULL,
	price numeric(18,5) NOT NULL,
	pricedate timestamp(0) NOT NULL
)

==================

CREATE TABLE "ShareDetails".shares (
	shareid bigint GENERATED ALWAYS AS IDENTITY NOT NULL,
	sharedesc varchar(50) NOT NULL,
	sharetickerid varchar(50) NOT NULL,
	currentprice numeric(18,5) NOT NULL
);

==================

ALTER TABLE IF EXISTS "TransactionDetails".transactions
    ADD CONSTRAINT fk_customers_transactions FOREIGN KEY (customerid)
    REFERENCES "CustomerDetails".customers (customerid) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;
CREATE INDEX IF NOT EXISTS fki_fk_customers_transactions
    ON "TransactionDetails".transactions(customerid);
	
==================

ALTER TABLE "TransactionDetails".transactions
ADD CONSTRAINT fk_transactions_shares FOREIGN KEY (relatedshareid)
REFERENCES "ShareDetails".shares(shareid);

==================


