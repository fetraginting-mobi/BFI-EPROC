ALTER PROCEDURE [dbo].[xsp_master_approval_group_get_by_type] 
( 
	@p_approval_code nvarchar(20) output 
	,@p_reff_table nvarchar(50) 
	,@p_reff_no nvarchar(50) 
	,@p_approval_type nvarchar(10) 
	,@p_owner nvarchar(20) = NULL 
) as 
begin 
	declare @dim_code nvarchar(10), 
			@dim_tbl nvarchar(50), 
			@dim_column nvarchar(50), 
			@dim_value nvarchar(100), 
			@dim_primary_col nvarchar(50)

	declare @dim_1 nvarchar(10), 
			@dim_2 nvarchar(10), 
			@dim_3 nvarchar(10), 
			@dim_4 nvarchar(10), 
			@dim_5 nvarchar(10), 
			@dim_6 nvarchar(10), 
			@dim_7 nvarchar(10), 
			@dim_8 nvarchar(10), 
			@dim_9 nvarchar(10), 
			@dim_10 nvarchar(10)

	declare @operation_1 nvarchar(10), 
			@operation_2 nvarchar(10), 
			@operation_3 nvarchar(10), 
			@operation_4 nvarchar(10), 
			@operation_5 nvarchar(10), 
			@operation_6 nvarchar(10), 
			@operation_7 nvarchar(10), 
			@operation_8 nvarchar(10), 
			@operation_9 nvarchar(10), 
			@operation_10 nvarchar(10)


	declare @dimension_tbl table(
				code nvarchar(10), 
				table_name nvarchar(50), 
				column_name nvarchar(50), 
				primary_column nvarchar(50), 
				join_table nvarchar(50), 
				join_column nvarchar(50), 
				value nvarchar(100), 
				operator_1 nvarchar(10), 
				operator_2 nvarchar(10), 
				operator_3 nvarchar(10), 
				operator_4 nvarchar(10), 
				operator_5 nvarchar(10), 
				operator_6 nvarchar(10), 
				operator_7 nvarchar(10), 
				operator_8 nvarchar(10), 
				operator_9 nvarchar(10), 
				operator_10 nvarchar(10)
			)


	declare dim_cur cursor local fast_forward for 
		select 
		  dim_1, 
		  operator_1, 
		  dim_2, 
		  operator_2, 
		  dim_3, 
		  operator_3, 
		  dim_4, 
		  operator_4, 
		  dim_5, 
		  operator_5, 
		  dim_6, 
		  operator_6, 
		  dim_7, 
		  operator_7, 
		  dim_8, 
		  operator_8, 
		  dim_9, 
		  operator_9, 
		  dim_10, 
		  operator_10 
		from 
		  dbo.approval_type 
		where 
		  type = @p_approval_type


	open dim_cur fetch next 
		from 
		  dim_cur into @dim_1, 
		  @operation_1, 
		  @dim_2, 
		  @operation_2, 
		  @dim_3, 
		  @operation_3, 
		  @dim_4, 
		  @operation_4, 
		  @dim_5, 
		  @operation_5, 
		  @dim_6, 
		  @operation_6, 
		  @dim_7, 
		  @operation_7, 
		  @dim_8, 
		  @operation_8, 
		  @dim_9, 
		  @operation_9, 
		  @dim_10, 
		  @operation_10

	while @@fetch_status = 0 
	begin 
		if not exists (select 1 from @dimension_tbl where code = @dim_1) and @dim_1 is not null begin insert into @dimension_tbl (code, table_name, column_name, primary_column, operator_1) select code, table_name, column_name, primary_column, @operation_1 from dbo.SYS_DIMENSION where code = @dim_1 end 
		if not exists (select 1 from @dimension_tbl where code = @dim_2) and @dim_2 is not null begin insert into @dimension_tbl (code, table_name, column_name, primary_column, operator_2) select code, table_name, column_name, primary_column, @operation_2 from dbo.sys_dimension where code = @dim_2 end 
		if not exists (select 1 from @dimension_tbl where code = @dim_3) and @dim_3 is not null begin insert into @dimension_tbl (code, table_name, column_name, primary_column, operator_3) select code, table_name, column_name, primary_column, @operation_3 from dbo.sys_dimension where code = @dim_3 end 
		if not exists (select 1 from @dimension_tbl where code = @dim_4) and @dim_4 is not null begin insert into @dimension_tbl (code, table_name, column_name, primary_column, operator_4) select code, table_name, column_name, primary_column, @operation_4 from dbo.sys_dimension where code = @dim_4 end 
		if not exists (select 1 from @dimension_tbl where code = @dim_5) and @dim_5 is not null begin insert into @dimension_tbl (code, table_name, column_name, primary_column, operator_5) select code, table_name, column_name, primary_column, @operation_5 from dbo.sys_dimension where code = @dim_5 end 
		if not exists (select 1 from @dimension_tbl where code = @dim_6) and @dim_6 is not null begin insert into @dimension_tbl (code, table_name, column_name, primary_column, operator_6) select code, table_name, column_name, primary_column, @operation_6 from dbo.sys_dimension where code = @dim_6 end 
		if not exists (select 1 from @dimension_tbl where code = @dim_7) and @dim_7 is not null begin insert into @dimension_tbl (code, table_name, column_name, primary_column, operator_7) select code, table_name, column_name, primary_column, @operation_7 from dbo.sys_dimension where code = @dim_7 end 
		if not exists (select 1 from @dimension_tbl where code = @dim_8) and @dim_8 is not null begin insert into @dimension_tbl (code, table_name, column_name, primary_column, operator_8) select code, table_name, column_name, primary_column, @operation_8 from dbo.sys_dimension where code = @dim_8 end 
		if not exists (select 1 from @dimension_tbl where code = @dim_9) and @dim_9 is not null begin insert into @dimension_tbl (code, table_name, column_name, primary_column, operator_9) select code, table_name, column_name, primary_column, @operation_9 from dbo.sys_dimension where code = @dim_9 end 
		if not exists (select 1 from @dimension_tbl where code = @dim_10) and @dim_10 is not null begin insert into @dimension_tbl (code, table_name, column_name, primary_column, operator_10) select code, table_name, column_name, primary_column, @operation_10 from dbo.sys_dimension where code = @dim_10 end 
		
		fetch next from dim_cur into @dim_1,@operation_1, @dim_2,@operation_2, @dim_3,@operation_3, @dim_4,@operation_4, @dim_5,@operation_5, @dim_6,@operation_6, @dim_7,@operation_7, @dim_8,@operation_8, @dim_9,@operation_9, @dim_10,@operation_10 
	end 
	close dim_cur 
	deallocate dim_cur 

	declare dim_cur cursor local fast_forward for 
	select code ,table_name ,column_name ,primary_column from @dimension_tbl 

	open dim_cur 
	fetch next from dim_cur into @dim_code, @dim_tbl, @dim_column, @dim_primary_col 
	while @@fetch_status = 0 
	BEGIN 
		IF @dim_column = 'OWNER' AND @p_owner IS NOT NULL
		BEGIN
			SET @dim_value = @p_owner
		END
		ELSE
		BEGIN
			exec dbo.xsp_get_table_value_by_dimension @p_dim_code = @dim_code, @p_reff_code = @p_reff_no, @p_reff_table = @p_reff_table, @p_output = @dim_value output 
		END

		update @dimension_tbl set value = @dim_value where code = @dim_code 
		fetch next from dim_cur into @dim_code, @dim_tbl, @dim_column, @dim_primary_col 
	END 
	close dim_cur 
	deallocate dim_cur 

	if (SELECT count(code) FROM @dimension_tbl) <> 0 
	BEGIN 
		select top 1 @p_approval_code = dg.code from dbo.approval_type dg 
		where dg.type = @p_approval_type 
		and (dg.dim_1 is null or (exists (select dt.code from @dimension_tbl dt where dt.code = isnull(dg.dim_1,dt.code) and dbo.fn_search_operator_approval(dt.value,dg.dim_value_from_1,dg.dim_value_to_1,dt.operator_1) = 1))) 
		and (dg.dim_2 is null or (exists (select dt.code from @dimension_tbl dt where dt.code = isnull(dg.dim_2,dt.code) and dbo.fn_search_operator_approval(dt.value,dg.dim_value_from_2,dg.dim_value_to_2,dt.operator_2) = 1))) 
		and (dg.dim_3 is null or (exists (select dt.code from @dimension_tbl dt where dt.code = isnull(dg.dim_3,dt.code) and dbo.fn_search_operator_approval(dt.value,dg.dim_value_from_3,dg.dim_value_to_3,dt.operator_3) = 1))) 
		and (dg.dim_4 is null or (exists (select dt.code from @dimension_tbl dt where dt.code = isnull(dg.dim_4,dt.code) and dbo.fn_search_operator_approval(dt.value,dg.dim_value_from_4,dg.dim_value_to_4,dt.operator_4) = 1))) 
		and (dg.dim_5 is null or (exists (select dt.code from @dimension_tbl dt where dt.code = isnull(dg.dim_5,dt.code) and dbo.fn_search_operator_approval(dt.value,dg.dim_value_from_5,dg.dim_value_to_5,dt.operator_5) = 1))) 
		and (dg.dim_6 is null or (exists (select dt.code from @dimension_tbl dt where dt.code = isnull(dg.dim_6,dt.code) and dbo.fn_search_operator_approval(dt.value,dg.dim_value_from_6,dg.dim_value_to_6,dt.operator_6) = 1))) 
		and (dg.dim_7 is null or (exists (select dt.code from @dimension_tbl dt where dt.code = isnull(dg.dim_7,dt.code) and dbo.fn_search_operator_approval(dt.value,dg.dim_value_from_7,dg.dim_value_to_7,dt.operator_7) = 1))) 
		and (dg.dim_8 is null or (exists (select dt.code from @dimension_tbl dt where dt.code = isnull(dg.dim_8,dt.code) and dbo.fn_search_operator_approval(dt.value,dg.dim_value_from_8,dg.dim_value_to_8,dt.operator_8) = 1))) 
		and (dg.dim_9 is null or (exists (select dt.code from @dimension_tbl dt where dt.code = isnull(dg.dim_9,dt.code) and dbo.fn_search_operator_approval(dt.value,dg.dim_value_from_9,dg.dim_value_to_9,dt.operator_9) = 1))) 
		and (dg.dim_10 is null or (exists (select dt.code from @dimension_tbl dt where dt.code = isnull(dg.dim_10,dt.code) and dbo.fn_search_operator_approval(dt.value,dg.dim_value_from_10,dg.dim_value_to_10,dt.operator_10) = 1))) 
		and dg.is_valid = 1 
		order by dim_count desc, dg.cre_date desc 
	END 
	else 
	BEGIN 
		select top 1 @p_approval_code = dg.code from dbo.approval_type dg where type = @p_approval_type and dg.is_valid = 1 order by dg.cre_date desc 
	end 
end