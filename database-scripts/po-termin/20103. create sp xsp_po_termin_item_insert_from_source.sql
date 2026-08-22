CREATE PROCEDURE [dbo].[xsp_po_termin_item_insert_from_source]
(
    @p_id             INT = NULL OUTPUT,
    @p_code_barcode   NVARCHAR(28),
    @p_po_barcode     NVARCHAR(28),
    @p_trx_code       NVARCHAR(50),
    @p_cre_by         NVARCHAR(15),
    @p_cre_ip_address NVARCHAR(15)
)
AS
BEGIN
    SET NOCOUNT ON;

    SET @p_id = NULL;

    IF EXISTS (
        SELECT 1
        FROM dbo.term_of_payment_detail
        WHERE po_code = @p_po_barcode
          AND trx_code = @p_trx_code
          AND item_code = @p_code_barcode
    )
    BEGIN
        SELECT @p_id = id
        FROM dbo.term_of_payment_detail
        WHERE po_code = @p_po_barcode
          AND trx_code = @p_trx_code
          AND item_code = @p_code_barcode;

        RETURN;
    END;

    DECLARE @v_total_po_amount DECIMAL(18, 2);
    DECLARE @v_total_paid_prev DECIMAL(18, 2);
    DECLARE @v_outstanding DECIMAL(18, 2);

    SELECT @v_total_po_amount = ((unit_price * order_quantity) + ISNULL(ppn_amount, 0) - ISNULL(pph_amount, 0) + ISNULL(additional_amount, 0))
    FROM dbo.purchase_order_detail WITH(NOLOCK)
    WHERE item_code = @p_code_barcode
      AND po_code = @p_po_barcode;

    SELECT @v_total_paid_prev = ISNULL(SUM(total_amount_termin), 0)
    FROM dbo.term_of_payment_detail WITH(NOLOCK)
    WHERE po_code = @p_po_barcode
      AND item_code = @p_code_barcode
      AND trx_code <> @p_trx_code;

    SET @v_outstanding = ISNULL(@v_total_po_amount, 0) - ISNULL(@v_total_paid_prev, 0);

    INSERT INTO dbo.term_of_payment_detail (
        po_code, trx_code, item_code, unit_price_trm, order_qty,
        ppn_trm, pph_trm, additional_term, total_po_amount,
        outstanding_po_amount, total_amount_termin,
        cre_date, cre_by, cre_ip_address, mod_date, mod_by, mod_ip_address
    )
    SELECT
        pqd.po_code,
        @p_trx_code,
        pqd.item_code,
        pqd.unit_price,
        pqd.order_quantity,
        ISNULL(pqd.ppn_amount, 0),
        ISNULL(pqd.pph_amount, 0),
        pqd.additional_amount,
        @v_total_po_amount,
        @v_outstanding,
        0,
        GETDATE(), @p_cre_by, @p_cre_ip_address, GETDATE(), @p_cre_by, @p_cre_ip_address
    FROM dbo.purchase_order_detail pqd WITH(NOLOCK)
    WHERE pqd.item_code = @p_code_barcode
      AND pqd.po_code = @p_po_barcode;

    SET @p_id = SCOPE_IDENTITY();
END
GO
