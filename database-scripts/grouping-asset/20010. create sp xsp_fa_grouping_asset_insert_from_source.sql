CREATE procedure [dbo].[xsp_fa_grouping_asset_insert_from_source]  
(  
  @p_barcode    nvarchar(20)  
 ,@p_fa_group_asset_code nvarchar(15)  
 ,@p_cre_date   datetime  
 ,@p_cre_by    nvarchar(15)  
 ,@p_cre_ip_address  nvarchar(15)  
 ,@p_mod_date   datetime  
 ,@p_mod_by    nvarchar(15)  
 ,@p_mod_ip_address  nvarchar(15)  
)   
as  
begin  
  
 declare @code_asset   nvarchar(18)  
   ,@name_asset  nvarchar(60)  
   ,@description  nvarchar(2000)  
   ,@orig_price  decimal(18,2)  
   ,@tot_depre   decimal(18,2)  
   ,@net_book_value decimal(18,2)  
   ,@fa_asset_id  int  
             ,@barcode_valid  int  

IF LEFT(LTRIM(RTRIM(@p_barcode)), 2) = 'EX'   
BEGIN  
  select @fa_asset_id = 0  
    ,@code_asset = ib.item_code  
    ,@name_asset = mi.item_name  
  from dbo.inventory_barcode ib  
    inner join dbo.master_item mi on (ib.item_code = mi.item_code)  
  where ib.barcode_status = 'AVAILABLE' and ib.barcode = @p_barcode  
END 
ELSE
 BEGIN   
  select @fa_asset_id  = id  
    ,@code_asset  = ast_code  
    ,@name_asset  = ast_name   
    ,@description  = remarks  
  from dbo.fa_asset  
  where barcode    = @p_barcode  
 END 
  
 select  @barcode_valid    = count(barcode)   
 from     dbo.fa_grouping_asset_detail  
 where  fa_ga_code = @p_fa_group_asset_code  
 and   barcode    = @p_barcode  
 and   is_active='1'  
  
 if @barcode_valid > 0  
 begin   
  raiserror ('barcode sudah ada', 16, 1)  
  return  
 end  
  
 exec dbo.xsp_fa_grouping_asset_detail_insert   
   0  
   ,@p_fa_group_asset_code  
   ,@fa_asset_id  
   ,@code_asset   
   ,@name_asset  
   ,@p_barcode     
   ,@description  
   ,'0'  
   ,@p_cre_date   
   ,@p_cre_by   
   ,@p_cre_ip_address   
   ,@p_mod_date  
   ,@p_mod_by   
   ,@p_mod_ip_address  
   
end  