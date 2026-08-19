CREATE PROCEDURE [dbo].[xsp_grn_getrows]
(
	@p_code			nvarchar(50)
)
AS
BEGIN
SELECT 
    poh.code                    AS PO_CODE,
    poh.CODE_BARCODE            AS PO_BARCODE,
    poh.TRANS_FLAG_CODE         AS PO_STATUS,

    pod.ITEM_CODE               AS POD_ITEM_CODE,
    pod.ORDER_QUANTITY			AS PO_QTY,
	pod.ORDER_REMAINING			AS PO_REMAIN_QTY,

    grnh.CODE                   AS GRN_CODE,
    grnh.CODE_BARCODE           AS GRN_BARCODE,
    grnh.TRANS_FLAG_CODE        AS GRN_STATUS,

    grnd.ITEM_CODE              AS GRN_ITEM_CODE,
    grnd.PO_QUANTITY            AS GRN_PO_QTY,
    grnd.RECEIVE_QUANTITY       AS GRN_RECEIVE,
	grnd.REMAINING_QUANTITY		AS GRN_REMAIN_QTY,

    airh.CODE                   AS INVOICE_REGIS_CODE,
    airh.CODE_BARCODE           AS INVOICE_REGIS_BARCODE,
    airh.TRANS_FLAG_CODE        AS INVOICE_REGIS_STATUS,

    aird.ITEM_CODE              AS INVOICE_ITEM_CODE,
    aird.IS_ASSET				AS IS_ASSET,
    aird.IS_EXPEND				AS IS_EXPEND,

    aprh.CODE                   AS PAYMENT_REQ_CODE,
    aprh.CODE_BARCODE           AS PAYMENT_REQ_BARCODE,
    aprh.TRANS_FLAG_CODE        AS PAYMENT_REQ_STATUS,

    ISNULL(NULLIF(aprd.PAID, ''), '0') AS PAYMENT_STATUS_BAYAR

FROM PURCHASE_ORDER_HEADER poh
INNER JOIN PURCHASE_ORDER_DETAIL pod
    ON pod.PO_CODE = poh.CODE_BARCODE

INNER JOIN good_receipt_note_header grnh
    ON grnh.PURCHASE_ORDER_CODE = poh.CODE_BARCODE

INNER JOIN good_receipt_note_detail grnd
    ON grnd.GRN_CODE = grnh.CODE_BARCODE
   AND grnd.ITEM_CODE = pod.ITEM_CODE

LEFT JOIN ap_invoice_registration_header airh
    ON airh.PO_NO = poh.CODE_BARCODE

LEFT JOIN ap_invoice_registration_detail aird
    ON aird.INVOICE_CODE = airh.CODE_BARCODE
   AND aird.ITEM_CODE = pod.ITEM_CODE

LEFT JOIN AP_PAYMENT_REQUEST_header aprh
    ON aprh.REFERENCE_NO = airh.CODE_BARCODE

LEFT JOIN AP_PAYMENT_REQUEST_DETAIL aprd
    ON aprd.PAYMENT_CODE = aprh.CODE_BARCODE
   AND aprd.INVOICE_CODE = airh.CODE_BARCODE
WHERE poh.code = @p_code;

end
GO


