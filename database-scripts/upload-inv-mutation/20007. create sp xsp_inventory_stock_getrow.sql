CREATE PROCEDURE [dbo].[xsp_inventory_stock_getrow]
(
    @p_item_code     NVARCHAR(50),
    @p_location_code NVARCHAR(10),
    @p_branch_code   NVARCHAR(10)
)
AS
BEGIN
    SET NOCOUNT ON;

    SELECT ISNULL(MAX(ONHAND_QTY), 0) AS ONHAND_QTY
    FROM
    (
        SELECT
            ic.ONHAND_QTY,
            ROW_NUMBER() OVER (
                PARTITION BY ic.ITEM_CODE, ic.LOCATION_CODE
                ORDER BY ic.ID DESC
            ) rn
        FROM INVENTORY_CARD ic
        WHERE ic.ITEM_CODE = @p_item_code
          AND ic.LOCATION_CODE = @p_location_code
          AND ic.BRANCH_CODE = @p_branch_code
    ) x
    WHERE rn = 1;
END


