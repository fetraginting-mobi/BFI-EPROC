CREATE procedure [dbo].[xsp_inventory_mutation_upload_header_getrows]
(
	 @p_keywords		nvarchar(50)
	,@p_branch_code		nvarchar(10)
	,@p_from_location	nvarchar(40)
	,@p_to_branch		nvarchar(40)
	,@p_to_location		nvarchar(20)
)as
begin
		select	im.code_barcode
				,im.code
				,im.mutation_date
				,im.TRANS_FLAG_CODE	'trans_flag_desc'
				,mb1.description	'to_branch'
				,mb.description		'from_branch'
				,(CASE 
                       WHEN im.is_upload = '1' THEN 'UPLOAD'
                       WHEN im.is_upload = '0' THEN 'MANUAL'
                 END) 'is_upload'
		from	inventory_mutation_header im with (nolock)
				left join dbo.master_branch mb with (nolock)		on (mb.code = im.branch_code)
				left join dbo.master_branch mb1 with (nolock)		on (mb1.code = im.to_branch)
		where	im.TRANS_FLAG_CODE = 'NEW'
		and		im.branch_code	= @p_branch_code
		and		(im.from_location	= @p_from_location or @p_from_location = '')
		and		(im.to_branch = @p_to_branch or @p_to_branch='')
		and		(im.to_location = @p_to_location or @p_to_location ='')
		and  im.is_upload ='1'
		and		(   
					im.code												like '%'+ @p_keywords +'%'
					or	im.code_barcode									like '%'+ @p_keywords +'%'
					or	im.remarks										like '%'+ @p_keywords +'%'
					or	convert(nvarchar(20), im.mutation_date, 103)	like '%'+ @p_keywords +'%'
					or	mb.description									like '%'+ @p_keywords +'%'
					or	mb1.description									like '%'+ @p_keywords +'%'
				)

		order by 
				im.code desc,mutation_date desc
end


