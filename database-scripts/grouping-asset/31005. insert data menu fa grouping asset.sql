declare 
	@p_id int
select @p_id = ID from master_menu where NAME = 'Master' and PARENT_ID is null and IS_ACTIVE_FLAG = 1 and MODULE_CODE = 'FIX'


if not exists(select 1 from master_role_sec where code = 'R90000160' and NAME = 'FA ITEM GROUP' and APPLICATION_CODE = 'PR')
begin 
	insert into master_role_sec
		select 'R90000160','FA ITEM GROUP','PR',getdate(),'ADMIN','127.0.0.1',getdate(),'ADMIN','127.0.0.1'
		union 
		select 'R90000160C','FA ITEM GROUP CREATE','PR',getdate(),'ADMIN','127.0.0.1',getdate(),'ADMIN','127.0.0.1'
		union
		select 'R90000160D','FA ITEM GROUP DELETE','PR',getdate(),'ADMIN','127.0.0.1',getdate(),'ADMIN','127.0.0.1'
		union
		select 'R90000160E','FA ITEM GROUP FA ITEM GROUP EDIT','PR',getdate(),'ADMIN','127.0.0.1',getdate(),'ADMIN','127.0.0.1'
end 
ELSE 
BEGIN 
	SELECT 'DATA master_role_sec ALREADY EXIST'
END 

if not exists (select 1 from master_menu where NAME = 'FA Grouping Asset' and URL='module/fa/fagroupingassetlist.aspx')
begin 
insert into master_menu(code,NAME,PARENT_ID,ROLE_CODE,URL, IS_ACTIVE_FLAG)
	select '90000160','FA Grouping Asset',@p_id,'R90000160','module/fa/fagroupingassetlist.aspx','1'
end 
ELSE
BEGIN 
SELECT 'DATA master_menu ALREADY EXIST'
END

insert into master_group_role_sec
select 'SPR','R90000160C','PR',getdate(),'048115','127.0.0.1',getdate(), '048115','127.0.0.1'
union 
select 'SPR','R90000160D','PR',getdate(),'048115','127.0.0.1',getdate(), '048115','127.0.0.1'
union 
select 'SPR','R90000160E','PR',getdate(),'048115','127.0.0.1',getdate(), '048115','127.0.0.1'
