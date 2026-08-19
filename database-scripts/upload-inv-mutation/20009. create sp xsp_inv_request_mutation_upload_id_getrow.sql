CREATE PROCEDURE [dbo].[xsp_inv_request_mutation_upload_id_getrow]
(
    @p_code_barcode NVARCHAR(50)
)
AS
BEGIN
    SET NOCOUNT ON;

    SELECT TOP 1
        CONVERT(NVARCHAR(36), s.upload_id) AS upload_id,
		s.FILE_NAME
    FROM INVENTORY_MUTATION_HEADER h
    JOIN INVENTORY_MUTATION_DETAIL d
        ON d.IM_CODE = h.code_barcode
    JOIN inv_mutation_upload_staging s
        ON s.item_code COLLATE database_default = d.ITEM_CODE COLLATE database_default
        AND s.from_branch COLLATE database_default = h.BRANCH_CODE COLLATE database_default
        AND s.from_location COLLATE database_default = h.FROM_LOCATION COLLATE database_default
        AND s.to_branch COLLATE database_default = h.TO_BRANCH COLLATE database_default
        AND s.to_location COLLATE database_default = h.TO_LOCATION COLLATE database_default
    WHERE h.code_barcode = @p_code_barcode
        AND s.process_flag = 's'
        AND h.is_upload = '1'
        --AND h.REMARKS = 'bulk upload mutation'
    ORDER BY s.process_date DESC;
END