	select * from MASTER_SUBSCRIPTION where SUBSCRIBE_CODE='FADISP' --where SP_TABLE_SOURCE = 'xsp_fa_disposal_getrows_subsciption'
	update MASTER_SUBSCRIPTION set SP_TABLE_SOURCE='xsp_fa_asset_getrows_for_subscription' where SUBSCRIBE_CODE='FADISP' -- xsp_fa_disposal_getrows_for_subscription
	