CREATE UNIQUE INDEX ix_customers_customerid
    ON "CustomerDetails".customers USING btree
    (customerid ASC NULLS LAST)
    WITH (deduplicate_items=True)
;

==================

CREATE INDEX ix_customersproducts
ON "CustomerDetails".customersproducts (CustomerId);

==================

CREATE UNIQUE INDEX ix_transactiontypes
ON "TransactionDetails".transactiontypes
USING btree
(transactiontypesid ASC);

==================

ALTER TABLE IF EXISTS "TransactionDetails".transactiontypes
	CLUSTER ON ix_transactiontypes;

==================

CREATE INDEX ix_transactions_types
	ON "TransactionDetails".transactions
	USING btree(TransactionType ASC);

==================

DROP INDEX "TransactionDetails".ix_transactiontypes;

==================

CREATE UNIQUE INDEX ix_shareprices
ON "ShareDetails".shareprices (ShareID ASC, PriceDate ASC);

==================

CREATE UNIQUE INDEX ix_shareprices
ON "ShareDetails".shareprices (ShareID ASC, PriceDate ASC, Price);

==================

DROP INDEX IF EXISTS "ShareDetails".ix_shareprices;

CREATE UNIQUE INDEX ix_shareprices
ON "ShareDetails".shareprices (ShareID ASC, PriceDate ASC, Price);