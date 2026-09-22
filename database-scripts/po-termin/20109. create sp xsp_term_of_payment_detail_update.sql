CREATE PROCEDURE [dbo].[xsp_term_of_payment_detail_update]
(
    @p_id int,   
	@p_total_amount_termin  decimal(18, 2)
)
AS
BEGIN
    SET NOCOUNT ON;

	DECLARE @v_po_code NVARCHAR(28),
	@v_item_code NVARCHAR(28),
	@v_trx_code NVARCHAR(28),
    @v_total_po_amount DECIMAL(18, 2),
    @v_total_paid_others DECIMAL(18, 2),
    @v_max_allowed DECIMAL(18, 2),
	@ErrorMessage NVARCHAR(250);

	SELECT 
        @v_po_code = po_code,
        @v_item_code = item_code,
        @v_trx_code = trx_code,
        @v_total_po_amount = TOTAL_PO_AMOUNT
    FROM term_of_payment_detail 
    WHERE ID = @p_id;

	SELECT @v_total_paid_others = ISNULL(SUM(TOTAL_AMOUNT_TERMIN), 0)
	FROM term_of_payment_detail
    WHERE po_code = @v_po_code 
      AND item_code = @v_item_code
      AND ID <> @p_id;

	SET @v_max_allowed = @v_total_po_amount - @v_total_paid_others;

	IF (@p_total_amount_termin <= 0)
    BEGIN
        SET @ErrorMessage = 'Termin Amount untuk item ' + @v_item_code + ' must grater than 0 ';        
        RAISERROR (@ErrorMessage, 16, 1);
        RETURN;
	END

	IF (@p_total_amount_termin > @v_max_allowed)
    BEGIN
        SET @ErrorMessage = 'Input melebihi sisa PO! Maksimal yang diperbolehkan untuk item ' + @v_item_code + ' adalah ' + CAST(CAST(@v_max_allowed AS MONEY) AS VARCHAR);
        RAISERROR (@ErrorMessage, 16, 1);
        RETURN;
    END

	UPDATE term_of_payment_detail 
    SET TOTAL_AMOUNT_TERMIN = @p_total_amount_termin,
        OUTSTANDING_PO_AMOUNT = (@v_max_allowed - @p_total_amount_termin),
        MOD_DATE = GETDATE()
    WHERE ID = @p_id;

END
GO


