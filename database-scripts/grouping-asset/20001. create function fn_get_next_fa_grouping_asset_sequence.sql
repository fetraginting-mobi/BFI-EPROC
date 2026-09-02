Create function [dbo].[fn_get_next_fa_grouping_asset_sequence]()
returns nvarchar(4)
as
begin
	
	declare @next_run_number	nvarchar(4)
			
	select	@next_run_number = replace(str(cast((isnull(max(group_asset_sequence), 0)+ 1) as nvarchar), 4, 0), ' ', '0')
	from	fa_grouping_asset

	return @next_run_number

end


