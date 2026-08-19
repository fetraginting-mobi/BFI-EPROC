ALTER PROCEDURE [dbo].[xsp_fa_sale_getrows_subsciption]
(
	@p_keywords			nvarchar(50)
	,@p_fa_sale_code	nvarchar(20)
)as
begin
	select  barcode			'code'
			,name_asset		'description'
			--,sale_value
			--,net_book_value
	from	fa_sale_detail 
	where(
				code_asset													like '%'+ @p_keywords +'%'
			or	name_asset													like '%'+ @p_keywords +'%'
			or	barcode														like '%'+ @p_keywords +'%'
			--or	description													like '%'+ @p_keywords +'%'
			or	convert(nvarchar(25),convert(money,sale_value), 1)			like '%' + @p_keywords + '%'
		 )
	and		fa_sale_code = @p_fa_sale_code 
	
end

GO


