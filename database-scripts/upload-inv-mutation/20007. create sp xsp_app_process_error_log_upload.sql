CREATE PROCEDURE [dbo].[xsp_app_process_error_log_upload]
(
    @p_process_name      NVARCHAR(100),
    @p_file_name         NVARCHAR(255),
    @p_row_number        INT,
    @p_error_message     NVARCHAR(MAX),
    @p_raw_data          NVARCHAR(MAX),
    @p_cre_by            NVARCHAR(50),
    @p_cre_ip_address    NVARCHAR(50)
)
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO APP_PROCESS_ERROR_LOG
    (
        PROCESS_NAME,
        FILE_NAME,
        ROW_NUMBER,
        ERROR_MESSAGE,
        RAW_DATA,
        CRE_BY,
        CRE_IP_ADDRESS,
        CRE_DATE
    )
    VALUES
    (
        @p_process_name,
        @p_file_name,
        @p_row_number,
        @p_error_message,
        @p_raw_data,
        @p_cre_by,
        @p_cre_ip_address,
        GETDATE()
    );
END
GO


