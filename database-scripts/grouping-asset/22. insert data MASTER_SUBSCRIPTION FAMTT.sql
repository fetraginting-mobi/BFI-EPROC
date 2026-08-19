begin tran a
IF NOT EXISTS ( SELECT 1 FROM MASTER_SUBSCRIPTION where SUBSCRIBE_CODE = 'FAMTT')
	begin 
		insert into MASTER_SUBSCRIPTION
			select 'FAMTT','xsp_fa_asset_getrows_for_subscription','xsp_fa_mutation_getrows_subsciption','xsp_fa_mutation_insert_from_source','xsp_fa_mutation_update_from_source','xsp_fa_mutation_insert_from_source','p_barcode',getdate(),'1000000001','127.0.0.1',getdate(),'1000000001','127.0.0.1'
		SELECT * FROM MASTER_SUBSCRIPTION where SUBSCRIBE_CODE = 'FAMTT'
	end
print 'FAMTT ALREADY EXIST'
commit 