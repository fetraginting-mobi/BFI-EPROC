CREATE PROCEDURE [dbo].[xsp_po_termin_item_getrows_for_subscription]  
(  
    @p_code_barcode NVARCHAR(28), 
    @p_trx_code     NVARCHAR(28)
)  
AS  
BEGIN  
    SET NOCOUNT ON;

	;WITH AccumulativePaid AS (
        SELECT 
            ITEM_CODE,
            SUM(ISNULL(TOTAL_AMOUNT_TERMIN, 0)) AS TOTAL_PAID
        FROM [TERM_OF_PAYMENT_DETAIL] WITH (NOLOCK)
        WHERE PO_CODE = @p_code_barcode
          AND TRX_CODE <> @p_trx_code 
        GROUP BY ITEM_CODE
    ),
	CalculatedData AS (
        SELECT 
            pod.PO_CODE,
            pod.ITEM_CODE,
            mi.item_name,
            pod.UNIT_PRICE,
            pod.ORDER_QUANTITY,
            ((pod.UNIT_PRICE * pod.ORDER_QUANTITY) + ISNULL(pod.PPN_AMOUNT, 0) - ISNULL(pod.PPH_AMOUNT, 0) + ISNULL(pod.ADDITIONAL_AMOUNT, 0)) AS TOTAL_PO,
            ISNULL(ap.TOTAL_PAID, 0) AS TOTAL_PAID
        FROM PURCHASE_ORDER_DETAIL pod WITH (NOLOCK)
        LEFT JOIN master_item mi WITH (NOLOCK) ON pod.item_code = mi.item_code
        LEFT JOIN AccumulativePaid ap ON pod.ITEM_CODE = ap.ITEM_CODE
        WHERE pod.PO_CODE = @p_code_barcode
    )

	SELECT 
        PO_CODE,
        @p_trx_code AS [TRX_CODE],
        ITEM_CODE AS 'code',
        item_name AS 'description',
        UNIT_PRICE AS [UNIT_PRICE_TRM],
        ORDER_QUANTITY AS [ORDER_QTY],
        TOTAL_PO AS [TOTAL_PO_AMOUNT],
        (TOTAL_PO - TOTAL_PAID) AS [OUTSTANDING_PO_AMOUNT]
    FROM CalculatedData cd
    WHERE (TOTAL_PO - TOTAL_PAID) > 0.01
		and @p_trx_code not in (
			select trx_code 
				from term_of_payment_detail 
				where po_code = @p_code_barcode
		)
END
GO


