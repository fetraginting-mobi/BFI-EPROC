CREATE PROCEDURE [dbo].[xsp_inventory_mutation_detail_upload]
(
	@p_id						int	 output
	,@p_im_code					nvarchar(14)
	,@p_item_code				nvarchar(14)
	,@p_quantity				decimal(18,0)
	,@p_remarks					nvarchar(400)
	,@p_cre_date				datetime
	,@p_cre_by					nvarchar(15)
	,@p_cre_ip_address			nvarchar(15)
	,@p_mod_date				datetime
	,@p_mod_by					nvarchar(15)
	,@p_mod_ip_address			nvarchar(15)
	,@p_from_branch_code		nvarchar(10)
	,@p_from_location_code	    NVARCHAR(50)
	,@p_to_branch_code			nvarchar(10)
	,@p_to_location_code		NVARCHAR(50)
	,@p_status					nvarchar(10)	
)as
begin	
	insert into inventory_mutation_detail
	(
		im_code
		,item_code
		,quantity
		,remarks
		,cre_date
		,cre_by
		,cre_ip_address
		,mod_date
		,mod_by
		,mod_ip_address
		,from_branch_code
		,from_location_code
		,to_branch_code	
		,to_location_code
		,status	
	)
	values
	(		
		 upper(@p_im_code)
		,upper(@p_item_code)
		,@p_quantity
		,upper(@p_remarks)
		,@p_cre_date
		,@p_cre_by
		,@p_cre_ip_address
		,@p_mod_date
		,@p_mod_by
		,@p_mod_ip_address
		,@p_from_branch_code
		,@p_from_location_code	
		,@p_to_branch_code
		,@p_to_location_code
		,@p_status
	)
	set @p_id	= @@identity

end


GO


