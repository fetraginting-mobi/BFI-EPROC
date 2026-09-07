CREATE PROCEDURE [dbo].[xsp_fa_mutation_upload_header_getrows]
(
	 @p_keywords		NVARCHAR(50)
	,@p_branch_code		NVARCHAR(10)
	,@p_from_location	NVARCHAR(40)
	,@p_to_branch		NVARCHAR(40)
	,@p_to_location		NVARCHAR(20)
)AS
BEGIN
	SELECT 
		frmh.code_barcode,
		frmh.code,
		frmh.request_date 'mutation_date',
		mb.description	 'from_branch',
		fa.loc_name 'from_location',
		mb1.description 'to_branch',
		fa1.loc_name 'to_location',
		(CASE WHEN Rtrim(Ltrim(frmh.flag_process)) = 'upl' THEN 'UPLOAD'
			ELSE 'MANUAL' END) 'is_upload',
		frmh.trans_flag_code 'trans_flag_desc' 
	FROM fa_request_mutation_header frmh
		LEFT JOIN dbo.master_branch mb	WITH (nolock) ON (mb.code = frmh.branch_code)
		LEFT JOIN dbo.master_branch mb1 WITH (nolock) ON (mb1.code = frmh.to_cost_center)
		LEFT JOIN fa_location fa		WITH (nolock) ON (fa.loc_code =frmh.from_location_code AND fa.branch_code =frmh.branch_code)
		LEFT JOIN fa_location fa1		WITH (nolock) ON (fa1.loc_code =frmh.to_location_code AND fa1.branch_code =frmh.to_cost_center)
	WHERE	frmh.trans_flag_code = 'new'
			AND	(frmh.branch_code	= @p_branch_code OR @p_branch_code='')
			AND	(frmh.from_location_code	= @p_from_location OR @p_from_location = '')
			AND	(frmh.to_cost_center = @p_to_branch OR @p_to_branch='')
			AND	(frmh.to_location_code = @p_to_location OR @p_to_location ='')
			AND  Rtrim(Ltrim(frmh.flag_process)) = 'UPL'
			AND	(
					frmh.code											LIKE '%'+ @p_keywords +'%'
					OR	frmh.code_barcode								LIKE '%'+ @p_keywords +'%'
					OR	CONVERT(NVARCHAR(20), frmh.request_date, 103)	LIKE '%'+ @p_keywords +'%'
					OR	mb.description									LIKE '%'+ @p_keywords +'%'
					OR	mb1.description									LIKE '%'+ @p_keywords +'%'
				)
	ORDER BY frmh.cre_date DESC
END
GO


