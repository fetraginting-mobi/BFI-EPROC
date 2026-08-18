create PROCEDURE [dbo].[xsp_po_termin_check_type_getrows]
(
    @p_code_barcode NVARCHAR(28) 
)
AS
BEGIN
    SET NOCOUNT ON;
    SELECT *
    FROM 
        dbo.TERM_OF_PAYMENT 
    WHERE 
        CODE_BARCODE = @p_code_barcode
    ORDER BY 
        ID ASC; 
END
GO


