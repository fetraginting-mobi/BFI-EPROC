CREATE PROCEDURE [dbo].[xsp_fa_mutation_upload_bulk_process] (
@p_upload_id UNIQUEIDENTIFIER,
@p_cre_by NVARCHAR(50),
@p_cre_ip_address NVARCHAR(50),
@p_department_code NVARCHAR(20),
@p_division_code NVARCHAR(20),
@p_units_code NVARCHAR(100),
@p_sub_department_code NVARCHAR(100))
AS
BEGIN
  SET NOCOUNT ON;

  DECLARE @now DATETIME = GETDATE()

  -------------------------------------------------
  -- 1. staging table
  -------------------------------------------------
  CREATE TABLE #staging (
    upload_id UNIQUEIDENTIFIER
   ,row_number INT
   ,from_cost_center NVARCHAR(50) COLLATE database_default
   ,from_location NVARCHAR(50) COLLATE database_default
   ,to_cost_center NVARCHAR(50) COLLATE database_default
   ,to_location NVARCHAR(50) COLLATE database_default
   ,owner NVARCHAR(50) COLLATE database_default
   ,asset_code NVARCHAR(50) COLLATE database_default
   ,description NVARCHAR(255) COLLATE database_default
   ,error_message NVARCHAR(500) COLLATE database_default
   ,process_flag CHAR(1) COLLATE database_default
   ,process_date DATETIME
  )

  INSERT INTO #staging
    SELECT
      upload_id
     ,row_number
     ,LTRIM(RTRIM(from_cost_center))
     ,LTRIM(RTRIM(from_location))
     ,LTRIM(RTRIM(to_cost_center))
     ,LTRIM(RTRIM(to_location))
     ,LTRIM(RTRIM(owner))
     ,LTRIM(RTRIM(asset_code))
     ,description
     ,error_message
     ,process_flag
     ,process_date
    FROM fa_mutation_upload_staging
    WHERE upload_id = @p_upload_id
    AND process_flag IS NULL


  -------------------------------------------------
  -- 2. error table
  -------------------------------------------------
  CREATE TABLE #all_error (
    row_number INT
   ,error_message NVARCHAR(500) COLLATE database_default
  )

  -------------------------------------------------
  -- 3. validasi field wajib
  -------------------------------------------------
  INSERT INTO #all_error
    SELECT
      row_number
     ,'from cost center tidak boleh kosong'
    FROM #staging
    WHERE ISNULL(from_cost_center, '') = ''

    UNION ALL 
    SELECT
      row_number,
      'from cost center tidak valid'
    FROM #staging
    WHERE from_cost_center LIKE '%[^a-zA-Z0-9]%'

    UNION ALL
    SELECT
      row_number
     ,'from location tidak boleh kosong'
    FROM #staging
    WHERE ISNULL(from_location, '') = ''

    UNION ALL 
    SELECT
      row_number,
      'from location center tidak valid'
    FROM #staging
    WHERE from_location LIKE '%[^a-zA-Z0-9]%'

    UNION ALL
    SELECT
      row_number
     ,'to cost center tidak boleh kosong'
    FROM #staging
    WHERE ISNULL(to_cost_center, '') = ''

    UNION ALL 
    SELECT
      row_number,
      'to cost center tidak valid'
    FROM #staging
    WHERE to_cost_center LIKE '%[^a-zA-Z0-9]%'

    UNION ALL
    SELECT
      row_number
     ,'to location tidak boleh kosong'
    FROM #staging
    WHERE ISNULL(to_location, '') = ''

    UNION ALL 
    SELECT
      row_number,
      'to cost center tidak valid'
    FROM #staging
    WHERE to_location LIKE '%[^a-zA-Z0-9]%'

    UNION ALL
    SELECT
      row_number
     ,'owner tidak boleh kosong'
    FROM #staging
    WHERE ISNULL(owner, '') = ''

    UNION ALL 
    SELECT
      row_number,
      'owner tidak valid'
    FROM #staging
    WHERE owner LIKE '%[^a-zA-Z0-9]%'

    UNION ALL
    SELECT
      row_number
     ,'asset code tidak boleh kosong'
    FROM #staging
    WHERE ISNULL(asset_code, '') = ''

    UNION ALL 
    SELECT
      row_number,
      'asset code tidak valid'
    FROM #staging
    WHERE asset_code LIKE '%[^a-zA-Z0-9]%'


  -------------------------------------------------
  -- 4. validasi sale
  -------------------------------------------------
  INSERT INTO #all_error
    SELECT
      s.row_number
     ,'asset sedang dalam proses sale (code_barcode: ' + fsh.code_barcode + ')'
    FROM #staging s
    JOIN FA_SALE_DETAIL fsd
      ON fsd.BARCODE COLLATE database_default = s.asset_code
    JOIN FA_SALE_HEADER fsh
      ON fsh.code_barcode = fsd.FA_SALE_CODE
    WHERE fsh.TRANS_FLAG_CODE IN ('new', 'onprogress')


  -------------------------------------------------
  -- 5. validasi disposal
  -------------------------------------------------
  INSERT INTO #all_error
    SELECT
      s.row_number
     ,'asset sedang dalam proses disposal (code_barcode: ' + fdh.code_barcode + ')'
    FROM #staging s
    JOIN FA_DISPOSAL_DETAIL fdd
      ON fdd.BARCODE COLLATE database_default = s.asset_code
    JOIN FA_DISPOSAL_HEADER fdh
      ON fdh.code_barcode = fdd.FA_DISPOSAL_CODE
    WHERE fdh.TRANS_FLAG_CODE IN ('new', 'onprogress')


  -------------------------------------------------
  -- 6. validasi mutation
  -------------------------------------------------
  INSERT INTO #all_error
    SELECT
      s.row_number
     ,'asset sedang dalam proses mutation (code_barcode: ' + farh.code_barcode + ')'
    FROM #staging s
    JOIN FA_REQUEST_MUTATION_DETAIL farm
      ON farm.ITEM_CODE COLLATE database_default = s.asset_code
    JOIN FA_REQUEST_MUTATION_HEADER farh
      ON farh.code_barcode = farm.IR_CODE
    WHERE farm.STATUS_RECEIVED IN ('sent', 'returned')
    OR farm.STATUS_RECEIVED IS NULL

  -------------------------------------------------
  -- validasi invalid location
  -------------------------------------------------
  INSERT INTO #all_error
    SELECT
      s.row_number
     ,'Asset '+s.asset_code +' tidak berada di lokasi: ' + s.from_location
    FROM #staging s
    JOIN fa_asset  fa
      ON fa.BARCODE COLLATE database_default = s.asset_code
    WHERE fa.CURRENT_BRANCH <> s.from_location

  -------------------------------------------------
  -- update staging error
  -------------------------------------------------
  UPDATE s
  SET process_flag = 'e'
     ,error_message = e.error_message
     ,process_date = @now
  FROM fa_mutation_upload_staging s
  JOIN #all_error e
    ON s.row_number = e.row_number
  WHERE s.upload_id = @p_upload_id

  UPDATE fa_mutation_upload_staging
    SET process_flag = 's'
    WHERE upload_id = @p_upload_id AND process_flag IS NULL;

  -------------------------------------------------
  -- 9. data valid
  -------------------------------------------------
  CREATE TABLE #valid (
    row_number INT
   ,from_cost_center NVARCHAR(50)
   ,from_location NVARCHAR(50)
   ,to_cost_center NVARCHAR(50)
   ,to_location NVARCHAR(50)
   ,owner NVARCHAR(50)
   ,asset_code NVARCHAR(50)
   ,description NVARCHAR(255)
  )

  INSERT INTO #valid
    SELECT
      v.row_number
     ,v.from_cost_center
     ,v.from_location
     ,v.to_cost_center
     ,v.to_location
     ,v.owner
     ,v.asset_code
     ,v.description
    FROM #staging v
    WHERE NOT EXISTS (SELECT
        1
      FROM #all_error e
      WHERE e.row_number = v.row_number)


  -------------------------------------------------
  -- 10. header group
  -------------------------------------------------
  CREATE TABLE #header_group (
    rn INT IDENTITY (1, 1)
   ,from_cost_center NVARCHAR(50)
   ,from_location NVARCHAR(50)
   ,to_cost_center NVARCHAR(50)
   ,to_location NVARCHAR(50)
   ,owner NVARCHAR(50)
  )

  INSERT INTO #header_group
    SELECT
      from_cost_center
     ,from_location
     ,to_cost_center
     ,to_location
     ,owner
    FROM #valid
    GROUP BY from_cost_center
            ,from_location
            ,to_cost_center
            ,to_location
            ,owner


  -------------------------------------------------
  -- 11. generate header number safe
  -------------------------------------------------
  CREATE TABLE #header (
    rn INT
   ,code_barcode NVARCHAR(14)
   ,code NVARCHAR(18)
   ,from_cost_center NVARCHAR(50)
   ,from_location NVARCHAR(50)
   ,to_cost_center NVARCHAR(50)
   ,to_location NVARCHAR(50)
   ,owner NVARCHAR(50)
  )

  DECLARE @yy NVARCHAR(2)
         ,@mm NVARCHAR(2)
         ,@last_run INT

  SET @yy = RIGHT(CAST(YEAR(@now) AS NVARCHAR), 2)
  SET @mm = RIGHT('0' + CAST(MONTH(@now) AS NVARCHAR), 2)

  SELECT
    @last_run = ISNULL(MAX(CAST(SUBSTRING(code_barcode, 10, 5) AS INT)), 0)
  FROM FA_REQUEST_MUTATION_HEADER
  WHERE SUBSTRING(code_barcode, 6, 2) = @yy
  AND SUBSTRING(code_barcode, 8, 2) = @mm


  INSERT INTO #header
    SELECT
      g.rn
     ,g.from_cost_center + '40' + @yy + @mm +
      RIGHT('00000' + CAST(@last_run + ROW_NUMBER() OVER (ORDER BY g.rn) AS VARCHAR), 5)
     ,g.from_cost_center + '/FR/' + @yy + '/' + @mm + '/' +
      RIGHT('00000' + CAST(@last_run + ROW_NUMBER() OVER (ORDER BY g.rn) AS VARCHAR), 5)
     ,g.from_cost_center
     ,g.from_location
     ,g.to_cost_center
     ,g.to_location
     ,g.owner

    FROM #header_group g


  -------------------------------------------------
  -- 12. insert header
  -------------------------------------------------
  INSERT INTO FA_REQUEST_MUTATION_HEADER (code_barcode,
  code,
  REQUEST_DATE,
  DEPARTMENT_CODE,
  REQUESTOR,
  REMARKS,
  TRANS_FLAG_CODE,
  FLAG_PROCESS,
  CRE_DATE,
  CRE_BY,
  CRE_IP_ADDRESS,
  MOD_DATE,
  MOD_BY,
  MOD_IP_ADDRESS,
  BRANCH_CODE,
  DIVISION_CODE,
  UNITS_CODE,
  SUB_DEPARTMENT_CODE,
  FROM_LOCATION_CODE,
  TO_LOCATION_CODE,
  to_cost_center,
  owner)
    SELECT
      h.code_barcode
     ,h.code
     ,@now
     ,@p_department_code
     ,@p_cre_by
     ,'bulk upload mutation'
     ,'NEW'
     ,'UPL'
     ,@now
     ,@p_cre_by
     ,@p_cre_ip_address
     ,@now
     ,@p_cre_by
     ,@p_cre_ip_address
     ,h.from_cost_center
     ,@p_division_code
     ,@p_units_code
     ,@p_sub_department_code
     ,h.from_location
     ,h.to_location
     ,h.to_cost_center
     ,h.owner
    FROM #header h


  -------------------------------------------------
  -- 13. insert detail
  -------------------------------------------------
  INSERT INTO FA_REQUEST_MUTATION_DETAIL (IR_CODE,
  ITEM_CODE,
  ITEM_DESCRIPTION,
  BRANCH_CODE,
  CRE_DATE,
  CRE_BY,
  CRE_IP_ADDRESS,
  MOD_DATE,
  MOD_BY,
  MOD_IP_ADDRESS,
  LOCATION_CODE,
  TO_BRANCH_CODE,
  TO_LOCATION_CODE)
    SELECT
      h.code_barcode
     ,v.asset_code
     ,UPPER(v.description)
     ,v.from_cost_center
     ,@now
     ,@p_cre_by
     ,@p_cre_ip_address
     ,@now
     ,@p_cre_by
     ,@p_cre_ip_address
     ,v.from_location
     ,v.to_cost_center
     ,v.to_location
    FROM #valid v
    JOIN #header h
      ON v.from_cost_center = h.from_cost_center
        AND v.from_location = h.from_location
        AND v.to_cost_center = h.to_cost_center
        AND v.to_location = h.to_location
        AND v.owner = h.owner


  -------------------------------------------------
  -- 14. update success
  -------------------------------------------------
  UPDATE fa_mutation_upload_staging
  SET process_flag = 's'
     ,process_date = @now
  WHERE upload_id = @p_upload_id
  AND process_flag IS NULL

END
GO


