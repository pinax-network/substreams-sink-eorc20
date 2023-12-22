-- view (approve-1, valid mint) --
DROP TABLE IF EXISTS approve_1_mv;
CREATE MATERIALIZED VIEW approve_1_mv TO approve AS
SELECT
    op,
    id,
FROM mint
JOIN overrides ON overrides.tick == mint.tick
WHERE
    mint.amt == overrides.mint_per_amt AND
    mint.native_block_number > overrides.mint_start_native_block_number AND
    mint.native_block_number < overrides.mint_stop_native_block_number OR
    (mint.native_block_number == overrides.mint_start_native_block_number AND mint.transaction_index >= overrides.mint_start_transaction_index ) OR
    (mint.native_block_number == overrides.mint_stop_native_block_number AND mint.transaction_index <= overrides.mint_stop_transaction_index );

-- insert --
INSERT INTO approve SELECT
    op,
    id,
FROM mint
JOIN overrides ON overrides.tick == mint.tick
WHERE
    mint.amt == overrides.mint_per_amt AND
    mint.native_block_number > overrides.mint_start_native_block_number AND
    mint.native_block_number < overrides.mint_stop_native_block_number OR
    (mint.native_block_number == overrides.mint_start_native_block_number AND mint.transaction_index >= overrides.mint_start_transaction_index ) OR
    (mint.native_block_number == overrides.mint_stop_native_block_number AND mint.transaction_index <= overrides.mint_stop_transaction_index )