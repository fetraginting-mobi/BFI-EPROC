CREATE PROCEDURE [dbo].[xsp_fa_grouping_asset_move_update]
    @p_source_ga_code      NVARCHAR(50),     
    @p_target_ga_code      NVARCHAR(50),     
    @p_barcodes_string     NVARCHAR(MAX),    
    @p_user_id             NVARCHAR(50),     
    @p_ip_address          NVARCHAR(50)      
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT ON; 

    DECLARE @TmpBarcodes TABLE (
        Barcode NVARCHAR(50) PRIMARY KEY,
        OldDetailID INT
    );
    
    DECLARE @XmlData XML;
    SET @XmlData = CAST('<x>' + REPLACE(@p_barcodes_string, ',', '</x><x>') + '</x>' AS XML);

    INSERT INTO @TmpBarcodes (Barcode)
    SELECT LTRIM(RTRIM(t.value('.', 'NVARCHAR(50)')))
    FROM @XmlData.nodes('/x') AS x(t)
    WHERE t.value('.', 'NVARCHAR(50)') <> '';

    UPDATE t
    SET t.OldDetailID = d.ID
    FROM @TmpBarcodes t
    INNER JOIN dbo.fa_grouping_asset_detail d ON d.BARCODE = t.Barcode
    WHERE d.FA_GA_CODE = @p_source_ga_code AND d.IS_ACTIVE = 1;

	DECLARE @ParentBarcode NVARCHAR(50);

    SELECT TOP 1 @ParentBarcode = t.Barcode
    FROM dbo.fa_grouping_asset_detail d
    INNER JOIN @TmpBarcodes t ON d.ID = t.OldDetailID
    WHERE d.IS_PARENT = 1;

	IF @ParentBarcode IS NOT NULL
    BEGIN
        SELECT 'FAILED' AS StatusResult, 
               'Asset Parent : ' + @ParentBarcode + ' tidak dapat di pindahkan' AS MessageResult;
        RETURN;
    END;

    BEGIN TRY
        BEGIN TRAN MoveAssetTran;
			DECLARE @InsertedMapping TABLE (NewDetailID INT, Barcode NVARCHAR(50));

			UPDATE d
			SET d.IS_ACTIVE = 0,
				d.MOD_DATE = GETDATE(),
				d.MOD_BY = @p_user_id,
				d.MOD_IP_ADDRESS = @p_ip_address
			FROM dbo.fa_grouping_asset_detail d
			INNER JOIN @TmpBarcodes t ON d.ID = t.OldDetailID;

			INSERT INTO dbo.fa_grouping_asset_detail 
			(
				FA_GA_CODE, FA_ASSET_ID, CODE_ASSET, NAME_ASSET, BARCODE, 
				DESCRIPTION, IS_PARENT, IS_ACTIVE, 
				CRE_DATE, CRE_BY, CRE_IP_ADDRESS, MOD_DATE, MOD_BY, MOD_IP_ADDRESS
			)
			OUTPUT inserted.ID, inserted.BARCODE INTO @InsertedMapping(NewDetailID, Barcode)
			SELECT 
				@p_target_ga_code, d.FA_ASSET_ID, d.CODE_ASSET, d.NAME_ASSET, d.BARCODE, 
				d.DESCRIPTION, 0, 1, 
				GETDATE(), @p_user_id, @p_ip_address, GETDATE(), @p_user_id, @p_ip_address
			FROM dbo.fa_grouping_asset_detail d
			INNER JOIN @TmpBarcodes t ON d.ID = t.OldDetailID;

			INSERT INTO dbo.FA_GROUPING_ASSET_HISTORY
			(
				FA_GA_DETAIL_ID, BARCODE, ACTION, MOVE_TO, 
				CRE_DATE, CRE_BY, CRE_IP_ADDRESS, MOD_DATE, MOD_BY, MOD_IP_ADDRESS
			)
			SELECT 
				t.OldDetailID, t.Barcode, 'MOVE OUT', @p_target_ga_code,
				GETDATE(), @p_user_id, @p_ip_address, GETDATE(), @p_user_id, @p_ip_address
			FROM @TmpBarcodes t
			WHERE t.OldDetailID IS NOT NULL;

			INSERT INTO dbo.FA_GROUPING_ASSET_HISTORY
			(
				FA_GA_DETAIL_ID, BARCODE, ACTION, MOVE_TO, 
				CRE_DATE, CRE_BY, CRE_IP_ADDRESS, MOD_DATE, MOD_BY, MOD_IP_ADDRESS
			)
			SELECT 
				m.NewDetailID, m.Barcode, 'MOVE IN', @p_target_ga_code,
				GETDATE(), @p_user_id, @p_ip_address, GETDATE(), @p_user_id, @p_ip_address
			FROM @InsertedMapping m;

			COMMIT TRAN MoveAssetTran;
			SELECT 'SUCCESS' AS StatusResult, 'Asset(s) successfully moved.' AS MessageResult;

		END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0 ROLLBACK TRAN MoveAssetTran;
        
        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
        SELECT 'FAILED' AS StatusResult, @ErrorMessage AS MessageResult;
    END CATCH
END
GO


