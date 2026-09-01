CREATE PROCEDURE [dbo].[xsp_fa_grouping_asset_detail_update]
(
     @p_id              int
    ,@p_fa_ga_code      nvarchar(50)
    ,@p_is_parent       bit
    ,@p_mod_date        datetime
    ,@p_mod_by          nvarchar(15)
    ,@p_mod_ip_address  nvarchar(15)
)
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE dbo.fa_grouping_asset_detail
    SET     is_parent       = 0
           ,mod_date        = @p_mod_date
           ,mod_by          = @p_mod_by
           ,mod_ip_address  = @p_mod_ip_address
    WHERE   FA_GA_CODE      = @p_fa_ga_code
        AND is_parent       = 1
        AND id              <> @p_id;

    UPDATE dbo.fa_grouping_asset_detail
    SET     is_parent       = @p_is_parent
           ,mod_date        = @p_mod_date
           ,mod_by          = @p_mod_by
           ,mod_ip_address  = @p_mod_ip_address
    WHERE   id              = @p_id;
END
GO


