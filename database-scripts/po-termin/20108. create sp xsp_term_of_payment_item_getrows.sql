CREATE PROCEDURE [dbo].[xsp_term_of_payment_item_getrows]
(
	@p_code_barcode		nvarchar(50),
	@p_trx_code			nvarchar(10)
)as
begin
	
	select	topd.ID 
			,topd.PO_CODE
			,topd.TRX_CODE
			,topd.PO_CODE
			,topd.TRX_CODE
			,topd.ITEM_CODE
			,mi.item_name	'ITEM_NAME'
			,topd.UNIT_PRICE_TRM
			,topd.ORDER_QTY
			,topd.PPN_TRM
			,topd.PPH_TRM
			,topd.DISCOUNT_TERM
			,topd.FEE_TERM
			,topd.ADDITIONAL_TERM
			,topd.TOTAL_PO_AMOUNT 'TOTAL_PO_AMOUNT'
			,topd.TOTAL_AMOUNT_TERMIN 'TOTAL_AMOUNT_TERMIN'
			,topd.OUTSTANDING_PO_AMOUNT 'OUTSTANDING_PO_AMOUNT'
	from	term_of_payment_detail topd 
			inner join master_item mi WITH (nolock) ON ( topd.item_code = mi.item_code)			
	where topd.PO_CODE = @p_code_barcode and topd.TRX_CODE = @p_trx_code												
end


GO


