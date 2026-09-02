CREATE PROCEDURE [dbo].[xsp_inventory_mutation_header_upload]
(
	@p_code_barcode					nvarchar(14) output
	,@p_mutation_date				datetime 	
	,@p_expedition_description		nvarchar(50)
	,@p_branch_code					nvarchar(3)='KPO'
	,@p_department_code				NVARCHAR(10)
	,@p_division_code				NVARCHAR(10)
	,@p_sub_department_code			NVARCHAR(50)
	,@p_units_code					NVARCHAR(50)
	,@p_remarks						nvarchar(400)='GENERATE FROM UPLOAD'
	,@p_from_location				NVARCHAR(20)
	,@p_to_branch					NVARCHAR(20)
	,@p_to_location					NVARCHAR(20)
	,@p_req_type					NVARCHAR(20) = 'UPL'
	,@p_requestor					NVARCHAR(20)
	,@p_cre_date					datetime
	,@p_cre_by						nvarchar(15)
	,@p_cre_ip_address				nvarchar(15)=''
	,@p_mod_date					datetime
	,@p_mod_by						nvarchar(15)
	,@p_mod_ip_address				nvarchar(15)=''
	,@p_is_upload					bit =1

)as
begin
	--
	
	declare	@code			nvarchar(18)

	set	@p_code_barcode = dbo.fn_get_next_inventory_mutation_barcode(@p_mutation_date, @p_branch_code)
	set	@code = dbo.fn_get_next_inventory_mutation_code(@p_mutation_date, @p_branch_code)

	insert into inventory_mutation_header
	(
		code_barcode
		,code
		,mutation_date		
		,expedition_description
		,branch_code
		,remarks
		,trans_flag_code
		,department_code
		,division_code
		,UNITS_CODE
		,sub_department_code
		,FROM_LOCATION
		,TO_BRANCH
		,TO_LOCATION
		,REQUESTOR
		,REQ_TYPE
		,cre_date
		,cre_by
		,cre_ip_address
		,mod_date
		,mod_by
		,mod_ip_address
		,is_upload
		---------------------------
		
	)
	values
	(		
		@p_code_barcode				
		,upper(@code)						
		,@p_mutation_date
		,upper(@p_expedition_description)	
		,@p_branch_code
		,upper(@p_remarks)						
		,'NEW'
		,@p_department_code
		,@p_division_code
		,@p_units_code
		,@p_sub_department_code	
		,@p_from_location				
		,@p_to_branch		
		,@p_to_location		
		,@p_requestor	
		,@p_req_type		
		,@p_cre_date
		,@p_cre_by
		,@p_cre_ip_address
		,@p_mod_date
		,@p_mod_by
		,@p_mod_ip_address	
		,@p_is_upload
		-------------------------------------
		)

end
GO


