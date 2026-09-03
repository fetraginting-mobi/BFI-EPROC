CREATE procedure [dbo].[xsp_inventory_post_mutation_upload_history_getrows]
(
	@p_im_code			nvarchar(56) 

)as
begin
select 
	apl.code_barcode,
	apl.process_name, 
	apl.barcode 'item_code', 
	mi.item_name,
	apl.quantity, 
	apl.[error_message], 
	apl.cre_date 'date'
from app_process_error_log apl
left join master_item mi on apl.barcode =  mi.item_code
where code_barcode = @p_im_code
order by apl.cre_date desc
end 


