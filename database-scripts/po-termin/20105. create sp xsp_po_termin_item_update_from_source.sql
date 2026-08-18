CREATE PROCEDURE [dbo].[xsp_po_termin_item_update_from_source]
(
    @p_po_barcode NVARCHAR(28),   
	@p_trx_code   NVARCHAR(28),
	@p_code_barcode   NVARCHAR(28)
)
AS
BEGIN
    delete from term_of_payment_detail 
	where  PO_CODE = @p_po_barcode
		and TRX_CODE = @p_trx_code
		and ITEM_CODE = @p_code_barcode
END
GO


