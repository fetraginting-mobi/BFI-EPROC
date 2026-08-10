CREATE PROCEDURE [dbo].[xsp_inv_mutation_upload_bulk_process] (
	 @p_upload_id UNIQUEIDENTIFIER
	,@p_branch_code NVARCHAR(10)
	,@p_cre_by NVARCHAR(50)
	,@p_cre_ip_address NVARCHAR(50)
	,@p_file_name NVARCHAR(255)
	,@p_department_code NVARCHAR(20)
	,@p_division_code NVARCHAR(20)
	,@p_units_code NVARCHAR(100)
	,@p_sub_department_code NVARCHAR(100)
	)
AS
BEGIN
    SET NOCOUNT ON;
    DECLARE @now DATETIME = GETDATE();

    UPDATE s
    SET process_flag = 'e',
        error_message = 'Duplicate ITEM CODE '+s.item_code+ ' found at row ' + CAST(s.row_number AS VARCHAR) + ')'
    FROM inv_mutation_upload_staging s
    INNER JOIN (
        SELECT from_location, to_branch, to_location, item_code, MIN(row_number) AS min_row
        FROM inv_mutation_upload_staging
        WHERE upload_id = @p_upload_id
        GROUP BY from_location, to_branch, to_location, item_code
        HAVING COUNT(*) > 1
    ) dup ON s.from_location = dup.from_location 
         AND s.to_branch = dup.to_branch 
         AND s.to_location = dup.to_location 
         AND s.item_code = dup.item_code
    WHERE s.upload_id = @p_upload_id 
      AND s.row_number > dup.min_row;

    ;WITH LatestStock AS (
        SELECT
            ic.ITEM_CODE,
            ic.LOCATION_CODE,
            ic.ONHAND_QTY,
            ROW_NUMBER() OVER (
                PARTITION BY ic.ITEM_CODE, ic.LOCATION_CODE 
                ORDER BY ic.ID DESC
            ) AS rn
        FROM INVENTORY_CARD ic
        WHERE ic.BRANCH_CODE = @p_branch_code
          AND ic.ITEM_CODE IN (
              SELECT item_code FROM inv_mutation_upload_staging WHERE upload_id = @p_upload_id
          )
    )
    UPDATE s
    SET s.process_flag = 'e',
        s.error_message = 'Insufficient stock '+s.item_code+ ' at row ' + CAST(s.row_number AS VARCHAR) + ' Available quantity: ' + CAST(ISNULL(ls.ONHAND_QTY, 0) AS VARCHAR)
    FROM inv_mutation_upload_staging s
    LEFT JOIN LatestStock ls ON RTRIM(s.item_code) = RTRIM(ls.item_code) 
                            AND RTRIM(s.from_location) = RTRIM(ls.location_code) 
                            AND ls.rn = 1
    WHERE s.upload_id = @p_upload_id 
      AND s.process_flag IS NULL
      AND s.quantity > ISNULL(ls.ONHAND_QTY, 0);

    UPDATE inv_mutation_upload_staging
    SET process_flag = 's'
    WHERE upload_id = @p_upload_id AND process_flag IS NULL;

    CREATE TABLE #HeaderTmp (
        row_id INT IDENTITY (1, 1),
        from_loc NVARCHAR(50),
        to_brn NVARCHAR(50),
        to_loc NVARCHAR(50),
        desc_txt NVARCHAR(200)
    )

    INSERT INTO #HeaderTmp (from_loc, to_brn, to_loc, desc_txt)
    SELECT from_location, to_branch, to_location, MAX(description)
    FROM inv_mutation_upload_staging
    WHERE upload_id = @p_upload_id AND process_flag = 's'
    GROUP BY from_location, to_branch, to_location;

    DECLARE @cur_from_loc NVARCHAR(50), @cur_to_brn NVARCHAR(50), @cur_to_loc NVARCHAR(50), @cur_desc NVARCHAR(200)
    DECLARE @p_code_barcode NVARCHAR(50), @code NVARCHAR(18)

    DECLARE cur_h CURSOR FOR SELECT from_loc, to_brn, to_loc, desc_txt FROM #HeaderTmp
    OPEN cur_h
    FETCH NEXT FROM cur_h INTO @cur_from_loc, @cur_to_brn, @cur_to_loc, @cur_desc

    WHILE @@FETCH_STATUS = 0
    BEGIN
        -- Generate Barcode & Code
        SET @p_code_barcode = dbo.fn_get_next_inventory_mutation_barcode(@now, @p_branch_code)
        SET @code = dbo.fn_get_next_inventory_mutation_code(@now, @p_branch_code)

        -- INSERT HEADER
        INSERT INTO inventory_mutation_header (
            code_barcode, code, mutation_date, expedition_description, branch_code,
            remarks, trans_flag_code, department_code, division_code, UNITS_CODE,
            sub_department_code, FROM_LOCATION, TO_BRANCH, TO_LOCATION, REQUESTOR,
            REQ_TYPE, cre_date, cre_by, cre_ip_address, mod_date, mod_by, mod_ip_address, is_upload
        )
        VALUES (
            @p_code_barcode, UPPER(@code), @now, UPPER(@cur_desc), @p_branch_code,
            'UPLOAD BULK', 'NEW', @p_department_code, @p_division_code, @p_units_code,
            @p_sub_department_code, @cur_from_loc, @cur_to_brn, @cur_to_loc, @p_cre_by,
            'UPL', @now, @p_cre_by, @p_cre_ip_address, @now, @p_cre_by, @p_cre_ip_address, 1
        )

        INSERT INTO inventory_mutation_detail (
            im_code, item_code, quantity, remarks, cre_date, cre_by, cre_ip_address,
            mod_date, mod_by, mod_ip_address, from_branch_code, from_location_code,
            to_branch_code, to_location_code, STATUS
        )
        SELECT 
            @p_code_barcode, UPPER(item_code), quantity, UPPER(description), @now, @p_cre_by, @p_cre_ip_address,
            @now, @p_cre_by, @p_cre_ip_address, @p_branch_code, from_location,
            to_branch, to_location, 'NEW'
        FROM inv_mutation_upload_staging
        WHERE upload_id = @p_upload_id 
          AND process_flag = 's'
          AND from_location = @cur_from_loc
          AND to_branch = @cur_to_brn
          AND to_location = @cur_to_loc

        FETCH NEXT FROM cur_h INTO @cur_from_loc, @cur_to_brn, @cur_to_loc, @cur_desc
    END
    CLOSE cur_h
    DEALLOCATE cur_h

    UPDATE inv_mutation_upload_staging
    SET process_date = @now
    WHERE upload_id = @p_upload_id AND process_flag = 's';

    DROP TABLE #HeaderTmp;
END
GO


