ALTER PROCEDURE [dbo].[approval_request_start_by_approval_type] 
( 
	@p_approval_type nvarchar(50) 
	,@p_user nvarchar(10) 
	,@p_priority_code nvarchar(20) 
	,@p_remark nvarchar(200) 
	,@p_object_id nvarchar(50) 
	,@p_mod_date datetime 
	,@p_mod_ip_address nvarchar(15) 
	,@p_object_amount decimal(18,2) = 100 
	,@p_branch_code nvarchar(10) = '' 
	,@p_object_description nvarchar(200) = '' 
	,@p_object_code nvarchar(50) = '' 
) as 
begin 
	declare @table_name nvarchar(100) 
			,@approval_code nvarchar(20) 
			,@msg nvarchar(500) 
			,@sp_validation nvarchar(500) 
			,@is_flag nvarchar(1) = '0' 
			,@validation NVARCHAR(20) 
			,@trans_type nvarchar(2)

	declare @current_owner nvarchar(20)
	declare @owner_count int = 0
	declare @virtual_amount decimal(18,2)

	SET @trans_type = SUBSTRING(@p_object_id,4,2)

	IF @trans_type = '03' begin SELECT @validation = TRANS_FLAG_CODE FROM dbo.PURCHASE_ORDER_HEADER WHERE CODE_BARCODE = @p_object_id END 
	IF @trans_type = '26' begin SELECT @validation = TRANS_FLAG_CODE FROM dbo.SUPPLIER_SELECTION_HEADER WHERE CODE_BARCODE = @p_object_id END 
	IF @trans_type = '21' begin SELECT @validation = TRANS_FLAG_CODE FROM dbo.FA_SALE_HEADER WHERE CODE_BARCODE = @p_object_id END 
	IF @trans_type = '20' begin SELECT @validation = TRANS_FLAG_CODE FROM dbo.FA_DISPOSAL_HEADER WHERE CODE_BARCODE = @p_object_id end 
	IF @trans_type = '06' begin SELECT @validation = TRANS_FLAG_CODE FROM dbo.INVENTORY_ISSUE_HEADER WHERE CODE_BARCODE = @p_object_id END 
	IF @trans_type = '08' BEGIN SELECT @validation = TRANS_FLAG_CODE FROM dbo.INVENTORY_ISSUE_HEADER WHERE CODE_BARCODE = @p_object_id END 
	IF @trans_type = '07' begin SELECT @validation = TRANS_FLAG_CODE FROM dbo.INVENTORY_MUTATION_HEADER WHERE CODE_BARCODE = @p_object_id END 
	IF @trans_type = '31' begin SELECT @validation = TRANS_FLAG_DESC FROM dbo.INVENTORY_OPNAME WHERE CODE_BARCODE = @p_object_id END 
	IF @trans_type = '16' begin SELECT @validation = TRANS_FLAG_CODE FROM dbo.AP_INVOICE_REGISTRATION_HEADER WHERE CODE_BARCODE = @p_object_id END 
	IF @trans_type = '39' begin SELECT @validation = TRANS_FLAG_CODE FROM dbo.PURCHASE_TICKET_HEADER WHERE BARCODE = @p_object_id END 
	IF @trans_type = '83' begin SELECT @validation = TRANS_FLAG_CODE FROM dbo.REFUND_INVENTORY_AMORTIZATION_HEADER WHERE CODE_BARCODE = @p_object_id END 

	IF (@validation in ('ONPROGRESS','POST')) 
	begin 
		raiserror ('Approval sudah diprosess', 16, 1) 
		return 
	END 

	select @table_name = table_name ,@sp_validation = sp_validation from dbo.approval_type_category where type_code = @p_approval_type 

	if (@sp_validation is not null or @sp_validation <> '') 
	begin 
		exec @sp_validation @p_object_id ,@p_user ,@p_mod_date ,@p_mod_ip_address ,@is_flag OUTPUT 
	end 

	if @is_flag <> '1' 
	begin 
		DECLARE @item_owners TABLE (
			owner_code nvarchar(20),
			amount decimal(18,2)
		)

		IF @trans_type = '21'
		BEGIN
			INSERT INTO @item_owners (owner_code, amount)
			SELECT mi.OWNER, ISNULL(SUM(fsd.SALE_VALUE), 0)
			FROM dbo.FA_SALE_DETAIL fsd with (nolock)
			INNER JOIN dbo.MASTER_ITEM mi with (nolock) on fsd.CODE_ASSET = mi.ITEM_CODE
			WHERE fsd.FA_SALE_CODE = @p_object_id
			GROUP BY mi.OWNER
		END
		ELSE IF @trans_type IN ('07', '08')
		BEGIN
			INSERT INTO @item_owners (owner_code, amount)
			SELECT mi.OWNER, 0.00
			FROM dbo.fa_request_mutation_detail farm with (nolock)
			INNER JOIN dbo.MASTER_ITEM mi with (nolock) on farm.ITEM_CODE = mi.ITEM_CODE
			WHERE farm.ir_code = @p_object_id
			GROUP BY mi.OWNER
		END
		ELSE IF @trans_type = '20'
		BEGIN
			INSERT INTO @item_owners (owner_code, amount)
			SELECT mi.OWNER, ISNULL(SUM(fdd.ORIG_PRICE), 0)
			FROM dbo.fa_disposal_detail fdd with (nolock)
			INNER JOIN dbo.MASTER_ITEM mi with (nolock) on fdd.CODE_ASSET = mi.ITEM_CODE
			WHERE fdd.fa_disposal_code = @p_object_id
			GROUP BY mi.OWNER
		END

		SELECT @owner_count = COUNT(1) FROM @item_owners

		IF @owner_count > 1
		BEGIN
			DECLARE owner_cursor CURSOR LOCAL FAST_FORWARD FOR
			SELECT owner_code, amount FROM @item_owners

			OPEN owner_cursor
			FETCH NEXT FROM owner_cursor INTO @current_owner, @virtual_amount

			WHILE @@FETCH_STATUS = 0
			BEGIN
				BEGIN TRY 
					EXEC dbo.xsp_master_approval_group_get_by_type 
						@approval_code output 
						,@p_reff_table = @table_name 
						,@p_reff_no = @p_object_id 
						,@p_approval_type = @p_approval_type
						,@p_owner = @current_owner 
				END TRY 
				BEGIN CATCH 
					SELECT TOP 1 @approval_code = code from dbo.approval_type where type = @p_approval_type 
				END CATCH 

				IF (isnull(@approval_code,'') ='') 
				begin 
					select @msg = 'There is no setting approval for ' + isnull(@p_approval_type,'-') + ' for Owner: ' + @current_owner
					raiserror(@msg, 16, -1) 
					return 
				end 

				EXEC dbo.xsp_approval_request_start 
					@approval_code 
					,@p_user 
					,'LOW' 
					,@p_remark 
					,@p_object_id 
					,@p_branch_code 
					,@p_mod_date 
					,@p_mod_ip_address 
					,@virtual_amount   
					,@p_branch_code 
					,@p_object_description 
					,@p_object_code 

				FETCH NEXT FROM owner_cursor INTO @current_owner, @virtual_amount
			END

			CLOSE owner_cursor
			DEALLOCATE owner_cursor
		END

		ELSE
		BEGIN
			BEGIN TRY 
				EXEC dbo.xsp_master_approval_group_get_by_type 
					@approval_code output 
					,@p_reff_table = @table_name 
					,@p_reff_no = @p_object_id 
					,@p_approval_type = @p_approval_type 
					,@p_owner = NULL 
			END TRY 
			BEGIN CATCH 
				SELECT TOP 1 @approval_code = code from dbo.approval_type where type = @p_approval_type 
			END CATCH 

			if (isnull(@approval_code,'') ='') 
			begin 
				select @msg = 'There is no setting approval for this approval category ' + isnull(@p_approval_type,'-') + isnull(type_description,'-') from dbo.approval_type_category where type_code = @p_approval_type 
				raiserror(@msg, 16, -1) 
				return 
			end 

			EXEC dbo.xsp_approval_request_start 
				@approval_code 
				,@p_user 
				,'LOW' 
				,@p_remark 
				,@p_object_id 
				,@p_branch_code 
				,@p_mod_date 
				,@p_mod_ip_address 
				,@p_object_amount 
				,@p_branch_code 
				,@p_object_description 
				,@p_object_code 
		END
	end 
end