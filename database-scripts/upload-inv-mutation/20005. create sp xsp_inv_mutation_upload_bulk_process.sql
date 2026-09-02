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
    ;WITH ValidationError AS (
        SELECT row_number, error_message
        FROM (
            SELECT s.row_number, 1 AS priority, 'From Branch is required' AS error_message
            FROM inv_mutation_upload_staging s
            WHERE s.upload_id = @p_upload_id
              AND s.process_flag IS NULL
              AND ISNULL(LTRIM(RTRIM(s.from_branch)), '') = ''

            UNION ALL
            SELECT s.row_number, 2, 'Invalid from Branch. The Branch does not exist or the Branch is inactive.'
            FROM inv_mutation_upload_staging s
            LEFT JOIN MASTER_BRANCH mb ON mb.CODE = LTRIM(RTRIM(s.from_branch))
                                      AND ISNULL(mb.IS_ACTIVE, '0') = '1'
            WHERE s.upload_id = @p_upload_id
              AND s.process_flag IS NULL
              AND ISNULL(LTRIM(RTRIM(s.from_branch)), '') <> ''
              AND mb.CODE IS NULL

            UNION ALL
            SELECT s.row_number, 3, 'From Location is required'
            FROM inv_mutation_upload_staging s
            WHERE s.upload_id = @p_upload_id
              AND s.process_flag IS NULL
              AND ISNULL(LTRIM(RTRIM(s.from_location)), '') = ''

            UNION ALL
            SELECT s.row_number, 4, 'Invalid from Location. The Branch does not exist or the Branch is inactive'
            FROM inv_mutation_upload_staging s
            LEFT JOIN MASTER_LOCATION ml ON ml.CODE = LTRIM(RTRIM(s.from_location))
                                        AND ml.BRANCH_CODE = LTRIM(RTRIM(s.from_branch))
            WHERE s.upload_id = @p_upload_id
              AND s.process_flag IS NULL
              AND ISNULL(LTRIM(RTRIM(s.from_location)), '') <> ''
              AND ml.CODE IS NULL

            UNION ALL
            SELECT s.row_number, 5, 'to Branch is required.'
            FROM inv_mutation_upload_staging s
            WHERE s.upload_id = @p_upload_id
              AND s.process_flag IS NULL
              AND ISNULL(LTRIM(RTRIM(s.to_branch)), '') = ''

            UNION ALL
            SELECT s.row_number, 6, 'Invalid To Branch. The Branch does not exist or the Branch is inactive.'
            FROM inv_mutation_upload_staging s
            LEFT JOIN MASTER_BRANCH mb ON mb.CODE = LTRIM(RTRIM(s.to_branch))
                                      AND ISNULL(mb.IS_ACTIVE, '0') = '1'
            WHERE s.upload_id = @p_upload_id
              AND s.process_flag IS NULL
              AND ISNULL(LTRIM(RTRIM(s.to_branch)), '') <> ''
              AND mb.CODE IS NULL

            UNION ALL
            SELECT s.row_number, 7, 'To Location is Required'
            FROM inv_mutation_upload_staging s
            WHERE s.upload_id = @p_upload_id
              AND s.process_flag IS NULL
              AND ISNULL(LTRIM(RTRIM(s.to_location)), '') = ''

            UNION ALL
            SELECT s.row_number, 8, 'Invalid to Location. The Branch does not exist or the Location is inactive.'
            FROM inv_mutation_upload_staging s
            LEFT JOIN MASTER_LOCATION ml ON ml.CODE = LTRIM(RTRIM(s.to_location))
                                        AND ml.BRANCH_CODE = LTRIM(RTRIM(s.to_branch))
            WHERE s.upload_id = @p_upload_id
              AND s.process_flag IS NULL
              AND ISNULL(LTRIM(RTRIM(s.to_location)), '') <> ''
              AND ml.CODE IS NULL

            UNION ALL
            SELECT s.row_number, 9, 'from branch and Location cannot be the sama as To Branch and Location'
            FROM inv_mutation_upload_staging s
            WHERE s.upload_id = @p_upload_id
              AND s.process_flag IS NULL
              AND ISNULL(LTRIM(RTRIM(s.from_branch)), '') <> ''
              AND ISNULL(LTRIM(RTRIM(s.from_location)), '') <> ''
              AND ISNULL(LTRIM(RTRIM(s.to_branch)), '') <> ''
              AND ISNULL(LTRIM(RTRIM(s.to_location)), '') <> ''
              AND LTRIM(RTRIM(s.from_branch)) = LTRIM(RTRIM(s.to_branch))
              AND LTRIM(RTRIM(s.from_location)) = LTRIM(RTRIM(s.to_location))

            UNION ALL
            SELECT s.row_number, 10, 'Invalid Item Code.'
            FROM inv_mutation_upload_staging s
            LEFT JOIN MASTER_ITEM mi ON mi.ITEM_CODE = LTRIM(RTRIM(s.item_code))
                                    AND ISNULL(mi.IS_ACTIVE, '0') = '1'
            WHERE s.upload_id = @p_upload_id
              AND s.process_flag IS NULL
              AND ISNULL(LTRIM(RTRIM(s.item_code)), '') <> ''
              AND mi.ITEM_CODE IS NULL

            UNION ALL
            SELECT s.row_number, 11, 'Description is required.'
            FROM inv_mutation_upload_staging s
            WHERE s.upload_id = @p_upload_id
              AND s.process_flag IS NULL
              AND ISNULL(LTRIM(RTRIM(s.description)), '') = ''

            UNION ALL
            SELECT s.row_number, 12, 'Quantity cannot be empty.'
            FROM inv_mutation_upload_staging s
            WHERE s.upload_id = @p_upload_id
              AND s.process_flag IS NULL
              AND s.quantity IS NULL
        ) err
        WHERE priority = (
            SELECT MIN(priority)
            FROM (
                SELECT 1 AS priority WHERE EXISTS (SELECT 1 FROM inv_mutation_upload_staging x WHERE x.upload_id = @p_upload_id AND x.row_number = err.row_number AND x.process_flag IS NULL AND ISNULL(LTRIM(RTRIM(x.from_branch)), '') = '')
                UNION ALL SELECT 2 WHERE EXISTS (SELECT 1 FROM inv_mutation_upload_staging x LEFT JOIN MASTER_BRANCH mb ON mb.CODE = LTRIM(RTRIM(x.from_branch)) AND ISNULL(mb.IS_ACTIVE, '0') = '1' WHERE x.upload_id = @p_upload_id AND x.row_number = err.row_number AND x.process_flag IS NULL AND ISNULL(LTRIM(RTRIM(x.from_branch)), '') <> '' AND mb.CODE IS NULL)
                UNION ALL SELECT 3 WHERE EXISTS (SELECT 1 FROM inv_mutation_upload_staging x WHERE x.upload_id = @p_upload_id AND x.row_number = err.row_number AND x.process_flag IS NULL AND ISNULL(LTRIM(RTRIM(x.from_location)), '') = '')
                UNION ALL SELECT 4 WHERE EXISTS (SELECT 1 FROM inv_mutation_upload_staging x LEFT JOIN MASTER_LOCATION ml ON ml.CODE = LTRIM(RTRIM(x.from_location)) AND ml.BRANCH_CODE = LTRIM(RTRIM(x.from_branch)) WHERE x.upload_id = @p_upload_id AND x.row_number = err.row_number AND x.process_flag IS NULL AND ISNULL(LTRIM(RTRIM(x.from_location)), '') <> '' AND ml.CODE IS NULL)
                UNION ALL SELECT 5 WHERE EXISTS (SELECT 1 FROM inv_mutation_upload_staging x WHERE x.upload_id = @p_upload_id AND x.row_number = err.row_number AND x.process_flag IS NULL AND ISNULL(LTRIM(RTRIM(x.to_branch)), '') = '')
                UNION ALL SELECT 6 WHERE EXISTS (SELECT 1 FROM inv_mutation_upload_staging x LEFT JOIN MASTER_BRANCH mb ON mb.CODE = LTRIM(RTRIM(x.to_branch)) AND ISNULL(mb.IS_ACTIVE, '0') = '1' WHERE x.upload_id = @p_upload_id AND x.row_number = err.row_number AND x.process_flag IS NULL AND ISNULL(LTRIM(RTRIM(x.to_branch)), '') <> '' AND mb.CODE IS NULL)
                UNION ALL SELECT 7 WHERE EXISTS (SELECT 1 FROM inv_mutation_upload_staging x WHERE x.upload_id = @p_upload_id AND x.row_number = err.row_number AND x.process_flag IS NULL AND ISNULL(LTRIM(RTRIM(x.to_location)), '') = '')
                UNION ALL SELECT 8 WHERE EXISTS (SELECT 1 FROM inv_mutation_upload_staging x LEFT JOIN MASTER_LOCATION ml ON ml.CODE = LTRIM(RTRIM(x.to_location)) AND ml.BRANCH_CODE = LTRIM(RTRIM(x.to_branch)) WHERE x.upload_id = @p_upload_id AND x.row_number = err.row_number AND x.process_flag IS NULL AND ISNULL(LTRIM(RTRIM(x.to_location)), '') <> '' AND ml.CODE IS NULL)
                UNION ALL SELECT 9 WHERE EXISTS (SELECT 1 FROM inv_mutation_upload_staging x WHERE x.upload_id = @p_upload_id AND x.row_number = err.row_number AND x.process_flag IS NULL AND ISNULL(LTRIM(RTRIM(x.from_branch)), '') <> '' AND ISNULL(LTRIM(RTRIM(x.from_location)), '') <> '' AND ISNULL(LTRIM(RTRIM(x.to_branch)), '') <> '' AND ISNULL(LTRIM(RTRIM(x.to_location)), '') <> '' AND LTRIM(RTRIM(x.from_branch)) = LTRIM(RTRIM(x.to_branch)) AND LTRIM(RTRIM(x.from_location)) = LTRIM(RTRIM(x.to_location)))
                UNION ALL SELECT 10 WHERE EXISTS (SELECT 1 FROM inv_mutation_upload_staging x LEFT JOIN MASTER_ITEM mi ON mi.ITEM_CODE = LTRIM(RTRIM(x.item_code)) AND ISNULL(mi.IS_ACTIVE, '0') = '1' WHERE x.upload_id = @p_upload_id AND x.row_number = err.row_number AND x.process_flag IS NULL AND ISNULL(LTRIM(RTRIM(x.item_code)), '') <> '' AND mi.ITEM_CODE IS NULL)
                UNION ALL SELECT 11 WHERE EXISTS (SELECT 1 FROM inv_mutation_upload_staging x WHERE x.upload_id = @p_upload_id AND x.row_number = err.row_number AND x.process_flag IS NULL AND ISNULL(LTRIM(RTRIM(x.description)), '') = '')
                UNION ALL SELECT 12 WHERE EXISTS (SELECT 1 FROM inv_mutation_upload_staging x WHERE x.upload_id = @p_upload_id AND x.row_number = err.row_number AND x.process_flag IS NULL AND x.quantity IS NULL)
            ) p
        )
    )
    UPDATE s
    SET process_flag = 'e',
        error_message = ve.error_message,
        process_date = @now
    FROM inv_mutation_upload_staging s
    INNER JOIN ValidationError ve ON ve.row_number = s.row_number
    WHERE s.upload_id = @p_upload_id
      AND s.process_flag IS NULL;

    UPDATE s
    SET process_flag = 'e',
        error_message = 'Duplicate ITEM CODE '+s.item_code+ ' found at row ' + CAST(s.row_number AS VARCHAR) + ')'
    FROM inv_mutation_upload_staging s
    INNER JOIN (
        SELECT from_branch, from_location, to_branch, to_location, item_code, MIN(row_number) AS min_row
        FROM inv_mutation_upload_staging
        WHERE upload_id = @p_upload_id
          AND process_flag IS NULL
        GROUP BY from_branch, from_location, to_branch, to_location, item_code
        HAVING COUNT(*) > 1
    ) dup ON s.from_branch = dup.from_branch 
         AND s.from_location = dup.from_location 
         AND s.to_branch = dup.to_branch 
         AND s.to_location = dup.to_location 
         AND s.item_code = dup.item_code
    WHERE s.upload_id = @p_upload_id 
      AND s.row_number > dup.min_row;

    ;WITH LatestStock AS (
        SELECT
            ic.ITEM_CODE,
            ic.BRANCH_CODE,
            ic.LOCATION_CODE,
            ic.ONHAND_QTY,
            ROW_NUMBER() OVER (
                PARTITION BY ic.ITEM_CODE, ic.BRANCH_CODE, ic.LOCATION_CODE 
                ORDER BY ic.ID DESC
            ) AS rn
        FROM INVENTORY_CARD ic
        WHERE ic.BRANCH_CODE IN (
              SELECT from_branch FROM inv_mutation_upload_staging WHERE upload_id = @p_upload_id AND process_flag IS NULL
          )
          AND ic.ITEM_CODE IN (
              SELECT item_code FROM inv_mutation_upload_staging WHERE upload_id = @p_upload_id AND process_flag IS NULL
          )
    )
    UPDATE s
    SET s.process_flag = 'e',
        s.error_message = 'Insufficient stock '+s.item_code+ ' at row ' + CAST(s.row_number AS VARCHAR) + ' Available quantity: ' + CAST(ISNULL(ls.ONHAND_QTY, 0) AS VARCHAR)
    FROM inv_mutation_upload_staging s
    LEFT JOIN LatestStock ls ON RTRIM(s.item_code) = RTRIM(ls.item_code) 
                            AND RTRIM(s.from_branch) = RTRIM(ls.branch_code)
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
        from_brn NVARCHAR(50),
        from_loc NVARCHAR(50),
        to_brn NVARCHAR(50),
        to_loc NVARCHAR(50),
        desc_txt NVARCHAR(200)
    )

    INSERT INTO #HeaderTmp (from_brn, from_loc, to_brn, to_loc, desc_txt)
    SELECT from_branch, from_location, to_branch, to_location, MAX(description)
    FROM inv_mutation_upload_staging
    WHERE upload_id = @p_upload_id AND process_flag = 's'
    GROUP BY from_branch, from_location, to_branch, to_location;

    DECLARE @cur_from_brn NVARCHAR(50), @cur_from_loc NVARCHAR(50), @cur_to_brn NVARCHAR(50), @cur_to_loc NVARCHAR(50), @cur_desc NVARCHAR(200)
    DECLARE @p_code_barcode NVARCHAR(50), @code NVARCHAR(18)

    DECLARE cur_h CURSOR FOR SELECT from_brn, from_loc, to_brn, to_loc, desc_txt FROM #HeaderTmp
    OPEN cur_h
    FETCH NEXT FROM cur_h INTO @cur_from_brn, @cur_from_loc, @cur_to_brn, @cur_to_loc, @cur_desc

    WHILE @@FETCH_STATUS = 0
    BEGIN
        -- Generate Barcode & Code
        SET @p_code_barcode = dbo.fn_get_next_inventory_mutation_barcode(@now, @cur_from_brn)
        SET @code = dbo.fn_get_next_inventory_mutation_code(@now, @cur_from_brn)

        -- INSERT HEADER
        INSERT INTO inventory_mutation_header (
            code_barcode, code, mutation_date, expedition_description, branch_code,
            remarks, trans_flag_code, department_code, division_code, UNITS_CODE,
            sub_department_code, FROM_LOCATION, TO_BRANCH, TO_LOCATION, REQUESTOR,
            REQ_TYPE, cre_date, cre_by, cre_ip_address, mod_date, mod_by, mod_ip_address, is_upload
        )
        VALUES (
            @p_code_barcode, UPPER(@code), @now, UPPER(@cur_desc), @cur_from_brn,
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
            @now, @p_cre_by, @p_cre_ip_address, from_branch, from_location,
            to_branch, to_location, 'NEW'
        FROM inv_mutation_upload_staging
        WHERE upload_id = @p_upload_id 
          AND process_flag = 's'
          AND from_branch = @cur_from_brn
          AND from_location = @cur_from_loc
          AND to_branch = @cur_to_brn
          AND to_location = @cur_to_loc

		Update inv_mutation_upload_staging set im_code = UPPER(@code)
        WHERE upload_id = @p_upload_id 
          AND process_flag = 's'
          AND from_branch = @cur_from_brn
          AND from_location = @cur_from_loc
          AND to_branch = @cur_to_brn
          AND to_location = @cur_to_loc

        FETCH NEXT FROM cur_h INTO @cur_from_brn, @cur_from_loc, @cur_to_brn, @cur_to_loc, @cur_desc
    END
    CLOSE cur_h
    DEALLOCATE cur_h

    UPDATE inv_mutation_upload_staging
    SET process_date = @now
    WHERE upload_id = @p_upload_id AND process_flag = 's';

    DROP TABLE #HeaderTmp;
END





