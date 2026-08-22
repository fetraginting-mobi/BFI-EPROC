CREATE PROCEDURE [dbo].[xsp_term_of_payment_detail_cancel]
(
    @p_code_barcode NVARCHAR(50),
    @p_trx_code NVARCHAR(20)
)
AS
BEGIN
    SET NOCOUNT ON;

    DELETE FROM dbo.term_of_payment_detail
    WHERE po_code = @p_code_barcode
      AND trx_code = @p_trx_code;

    DELETE FROM dbo.term_of_payment_item
    WHERE po_code = @p_code_barcode
      AND trx_code = @p_trx_code;

    DELETE FROM dbo.term_of_payment
    WHERE code_barcode = @p_code_barcode
      AND trx_code = @p_trx_code
      AND ISNULL(percentage, 0) = 0
      AND ISNULL(amount, 0) = 0
      AND ISNULL(paid, '0') = '0';
END
GO
