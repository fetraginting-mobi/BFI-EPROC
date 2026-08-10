exec xsp_INVENTORY_MUTATION_HEADER_getrows @p_keywords=N'',@p_status=N'ALL',@p_cre_by=N'048115',@p_branch_code=N'KPO'
exec xsp_INVENTORY_MUTATION_UPLOAD_HEADER_getrows @p_keywords=N'',@p_branch_code=N'KPO',@p_from_location=N'',@p_to_branch=N'',@p_to_location=N''
UPLOAD_ID

(CASE WHEN Rtrim(Ltrim(frmh.flag_process)) = 'upl' THEN 'UPLOAD'
			ELSE 'MANUAL' END) 'is_upload',