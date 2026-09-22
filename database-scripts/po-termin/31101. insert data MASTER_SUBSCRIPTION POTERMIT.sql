begin tran a
IF NOT EXISTS ( select 1 from MASTER_SUBSCRIPTION where SUBSCRIBE_CODE = 'POTERMIT')
	begin 
		insert into MASTER_SUBSCRIPTION
			select 'POTERMIT','xsp_po_termin_item_getrows_for_subscription','xsp_po_termin_item_getrows_subscription','xsp_po_termin_item_insert_from_source','xsp_po_termin_item_update_from_source','','p_code_barcode',getdate(),'1000000001','127.0.0.1',getdate(), '1000000001','127.0.0.1'
	end 
else
	select 'ALREADY EXIST' as MESSAGE
commit tran a