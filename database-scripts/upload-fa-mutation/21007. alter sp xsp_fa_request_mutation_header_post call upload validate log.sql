DECLARE @sql NVARCHAR(MAX);
DECLARE @pos INT;

SELECT @sql = OBJECT_DEFINITION(OBJECT_ID('[dbo].[xsp_fa_request_mutation_header_post]'));

IF @sql IS NULL
BEGIN
    RAISERROR('Stored procedure [dbo].[xsp_fa_request_mutation_header_post] tidak ditemukan.', 16, 1);
    RETURN;
END

IF CHARINDEX('xsp_fa_request_mutation_header_post_upload_validate_log', @sql) = 0
BEGIN
    SET @sql = REPLACE(
        @sql,
        'CREATE PROCEDURE [dbo].[xsp_fa_request_mutation_header_post]',
        'ALTER PROCEDURE [dbo].[xsp_fa_request_mutation_header_post]'
    );

    SET @pos = CHARINDEX('    BEGIN TRY', @sql);

    IF @pos = 0
    BEGIN
        RAISERROR('Marker BEGIN TRY pada [dbo].[xsp_fa_request_mutation_header_post] tidak ditemukan.', 16, 1);
        RETURN;
    END

    SET @pos = @pos + LEN('    BEGIN TRY');

    SET @sql = STUFF(
        @sql,
        @pos,
        0,
        CHAR(13) + CHAR(10) +
        '        IF @v_flag_process = ''UPL''' + CHAR(13) + CHAR(10) +
        '        BEGIN' + CHAR(13) + CHAR(10) +
        '            EXEC dbo.xsp_fa_request_mutation_header_post_upload_validate_log' + CHAR(13) + CHAR(10) +
        '                @p_code_barcode = @p_code_barcode,' + CHAR(13) + CHAR(10) +
        '                @p_mod_by = @p_mod_by,' + CHAR(13) + CHAR(10) +
        '                @p_mod_ip_address = @p_mod_ip_address;' + CHAR(13) + CHAR(10) +
        '        END' + CHAR(13) + CHAR(10)
    );

    EXEC sp_executesql @sql;
END
