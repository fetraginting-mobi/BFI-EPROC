ALTER PROCEDURE [dbo].[xsp_fa_location_mut_ddl_getrows]
(
	@p_keywords			nvarchar(50)
	,@p_branch_code		NVARCHAR(10)
)as
begin

	select	fa_locationid
			,loc_code
			,loc_name
			,FA_ADDRESS
			,mb.DESCRIPTION'BRANCH'
	from	dbo.fa_location fl
			left JOIN master_branch mb ON (mb.CODE = fl.BRANCH_CODE)
	
	WHERE  fl.BRANCH_CODE = @p_branch_code
	AND	(	
				loc_code			like 	'%' + @p_keywords + '%'
			or	loc_name			like 	'%' + @p_keywords + '%'
			OR  FA_ADDRESS			like 	'%' + @p_keywords + '%'
			
		 )
		  ORDER BY mb.DESCRIPTION

end

GO


