create PROCEDURE [dbo].[xsp_po_termin_check_type_getrow]
(
    @p_code_barcode NVARCHAR(28) 
)
AS
BEGIN
    SET NOCOUNT ON;
    SELECT TOP 1 
        TERMIN_TYPE 
    FROM 
        dbo.TERM_OF_PAYMENT 
    WHERE 
        CODE_BARCODE = @p_code_barcode
    ORDER BY 
        ID ASC; 
END
GO


