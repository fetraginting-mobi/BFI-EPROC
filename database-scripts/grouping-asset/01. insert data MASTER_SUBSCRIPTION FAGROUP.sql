DECLARE @v_SUBSCRIBE_CODE       NVARCHAR(20)  = 'FAGROUP',
        @v_SP_TABLE_SOURCE      NVARCHAR(400) = 'xsp_fa_grouping_asset_getrows_for_subscription',
        @v_SP_TABLE_TARGET      NVARCHAR(400) = 'xsp_fa_grouping_asset_getrows_subsciption',
        @v_SP_SOURCE_TO_TARGET  NVARCHAR(400) = 'xsp_fa_grouping_asset_insert_from_source',
        @v_SP_TARGET_TO_SOURCE  NVARCHAR(400) = 'xsp_fa_grouping_asset_update_from_source',
        @v_SP_SAVE_NAME         NVARCHAR(400) = 'xsp_fa_grouping_asset_insert_from_source',
        @v_SP_PARAMETER_CODE    NVARCHAR(100) = 'p_barcode',
        @v_USER_ID              NVARCHAR(30)  = '1000000001',
        @v_IP_ADDRESS           NVARCHAR(30)  = '127.0.0.1';

IF NOT EXISTS (
    SELECT 1 
    FROM dbo.MASTER_SUBSCRIPTION 
    WHERE SUBSCRIBE_CODE = @v_SUBSCRIBE_CODE
)
BEGIN
    -- Eksekusi Insert Data jika Kode belum terdaftar
    INSERT INTO dbo.MASTER_SUBSCRIPTION
    (
        SUBSCRIBE_CODE,
        SP_TABLE_SOURCE,
        SP_TABLE_TARGET,
        SP_SOURCE_TO_TARGET,
        SP_TARGET_TO_SOURCE,
        SP_SAVE_NAME,
        SP_PARAMETER_CODE,
        CRE_DATE,
        CRE_BY,
        CRE_IP_ADDRESS,
        MOD_DATE,
        MOD_BY,
        MOD_IP_ADDRESS
    )
    VALUES
    (
        @v_SUBSCRIBE_CODE,
        @v_SP_TABLE_SOURCE,
        @v_SP_TABLE_TARGET,
        @v_SP_SOURCE_TO_TARGET,
        @v_SP_TARGET_TO_SOURCE,
        @v_SP_SAVE_NAME,
        @v_SP_PARAMETER_CODE,
        GETDATE(),       
        @v_USER_ID,
        @v_IP_ADDRESS,
        GETDATE(),       
        @v_USER_ID,
        @v_IP_ADDRESS
    );

    PRINT 'Data dengan SUBSCRIBE_CODE: ' + @v_SUBSCRIBE_CODE + ' berhasil ditambahkan.';
END
ELSE
BEGIN
    PRINT 'Data Gagal Ditambahkan! SUBSCRIBE_CODE: ' + @v_SUBSCRIBE_CODE + ' sudah ada di database.';
END