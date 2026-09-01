IF OBJECT_ID('[dbo].[xsp_fa_request_mutation_upload_id_getrow]', 'P') IS NOT NULL
    DROP PROCEDURE [dbo].[xsp_fa_request_mutation_upload_id_getrow]
GO

CREATE PROCEDURE [dbo].[xsp_fa_request_mutation_upload_id_getrow]
(
    @p_code_barcode NVARCHAR(50)
)
AS
BEGIN
    SET NOCOUNT ON;

    SELECT TOP 1
        CONVERT(NVARCHAR(36), s.upload_id) AS upload_id
    FROM FA_REQUEST_MUTATION_HEADER h
    JOIN FA_REQUEST_MUTATION_DETAIL d
        ON d.IR_CODE = h.code_barcode
    JOIN fa_mutation_upload_staging s
        ON s.asset_code COLLATE database_default = d.ITEM_CODE COLLATE database_default
        AND s.from_cost_center COLLATE database_default = h.BRANCH_CODE COLLATE database_default
        AND s.from_location COLLATE database_default = h.FROM_LOCATION_CODE COLLATE database_default
        AND s.to_cost_center COLLATE database_default = h.to_cost_center COLLATE database_default
        AND s.to_location COLLATE database_default = h.TO_LOCATION_CODE COLLATE database_default
        AND s.owner COLLATE database_default = h.owner COLLATE database_default
    WHERE h.code_barcode = @p_code_barcode
        AND s.process_flag = 's'
        AND h.FLAG_PROCESS = 'UPL'
        AND h.REMARKS = 'bulk upload mutation'
    ORDER BY s.process_date DESC;
END
GO
