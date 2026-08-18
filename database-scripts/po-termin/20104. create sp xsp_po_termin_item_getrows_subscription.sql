CREATE PROCEDURE [dbo].[xsp_po_termin_item_getrows_subscription]  
(  
	@p_code_barcode NVARCHAR(28), 
	@p_trx_code   NVARCHAR(28)
)  
as  
begin  
SELECT TOP (1000) [ID]
      ,topd.[PO_CODE]
      ,topd.[TRX_CODE]
      ,topd.[ITEM_CODE] 'code'
	  ,mi.item_name		'description'
      ,topd.[UNIT_PRICE_TRM]
      ,topd.[ORDER_QTY]
      ,topd.[PPN_TRM]
      ,topd.[PPH_TRM]
      ,topd.[DISCOUNT_TERM]
      ,topd.[FEE_TERM]
      ,topd.[ADDITIONAL_TERM]
      ,topd.[TOTAL_PO_AMOUNT]
	  ,topd.TOTAL_AMOUNT_TERMIN
	  ,topd.OUTSTANDING_PO_AMOUNT
      ,topd.[CRE_DATE]
      ,topd.[CRE_BY]
      ,topd.[CRE_IP_ADDRESS]
      ,topd.[MOD_DATE]
      ,topd.[MOD_BY]
      ,topd.[MOD_IP_ADDRESS]
  FROM [TERM_OF_PAYMENT_DETAIL] topd
  LEFT JOIN master_item mi WITH (nolock) ON (topd.item_code = mi.item_code)
  where PO_CODE = @p_code_barcode 
	and trx_code = @p_trx_code
END
GO


