ALTER PROCEDURE [dbo].[xsp_term_of_payment_insert] (
    @p_id INT OUTPUT,
    @p_code_barcode NVARCHAR(50),
    @p_trx_code NVARCHAR(20),
    @p_percentage DECIMAL(9, 6),
    @p_amount DECIMAL(18, 2),
    @p_cre_date DATETIME,
    @p_cre_by NVARCHAR(15),
    @p_cre_ip_address NVARCHAR(15),
    @p_mod_date DATETIME,
    @p_mod_by NVARCHAR(15),
    @p_mod_ip_address NVARCHAR(15),
    @p_remarks NVARCHAR(200) = '',
    @p_termin_type NVARCHAR(30)
) AS 
BEGIN
    SET NOCOUNT ON;

    DECLARE @count INT = 0,
            @total_amount DECIMAL(18, 2),
            @total_percentage DECIMAL(18, 2),
            @is_termin NVARCHAR(1),
            @count_type INT,
            @ppn_amt_awal DECIMAL(18, 2),
            @pph_amt_awal DECIMAL(18, 2),
            @ppn_amt DECIMAL(18, 2),
            @pph_amt DECIMAL(18, 2),
            @currency_code NVARCHAR(10),
            @total_amount_idr DECIMAL(18, 2),
            @tax_code NVARCHAR(10),
            @ppn_pct DECIMAL(9, 6),
            @pph_pct DECIMAL(9, 6);

    -- 1. AMBIL DATA HEADER & SCHEME PAJAK DI AWAL (WAJIB UNTUK KALKULASI)
    SELECT
        @is_termin = is_termin,
        @currency_code = CURRENCY_CODE,
        @total_amount = total_amount,
        @ppn_amt_awal = ppn,
        @pph_amt_awal = pph
    FROM dbo.purchase_order_header
    WHERE code_barcode = @p_code_barcode;

    SELECT TOP 1 @tax_code = tax_code
    FROM dbo.purchase_order_detail
    WHERE po_code = @p_code_barcode;

    SELECT @ppn_pct = ppn_pct, @pph_pct = pph_pct
    FROM master_tax_scheme
    WHERE tax_code = @tax_code;

    -- 2. HITUNG NILAI PERSENTASE & PAJAK (Agar tidak NULL saat Update/Insert)
    -- Hitung Total PO (Netto + PPN - PPH)
    SET @total_amount = ISNULL(@total_amount, 0) + ISNULL(@ppn_amt_awal, 0) - ISNULL(@pph_amt_awal, 0);

    IF ISNULL(@p_percentage, 0) = 0 AND ISNULL(@total_amount, 0) <> 0
        SET @p_percentage = (ISNULL(@p_amount, 0) / @total_amount) * 100;

    IF ISNULL(@p_amount, 0) = 0
        SET @p_amount = @total_amount * (ISNULL(@p_percentage, 0) / 100);

    SET @pph_amt = @p_amount * ISNULL(@pph_pct, 0) / 100;
    SET @ppn_amt = @p_amount * ISNULL(@ppn_pct, 0) / 100;

     IF @p_trx_code = '0'
    BEGIN
        RAISERROR('Harap Pilih Termin !', 16, 1);
        RETURN 0;
    END;

    IF (@is_termin = '0')
    BEGIN
        RAISERROR('PO bukan Termin !', 16, 1);
        RETURN 0;
    END;

	if (@count_type > 0)
	begin
		raiserror('Harap input Amount/Percentage sesuai inputan pertama !', 16, 1) ;

		return 0 ;
	end ;

	IF (ISNULL(@p_percentage, 0) <= 0 AND ISNULL(@p_amount, 0) <= 0)
    BEGIN
        RAISERROR('Percentage or Amount cannot be blank or zero', 16, 1);
        RETURN;
    END;

    -- 4. VALIDASI TERMIN 1 TIDAK BOLEH 100% (Mengecek @p_percentage hasil kalkulasi di atas)
    IF (@p_trx_code IN ('TM1', 'tm1') AND @p_percentage >= 100)
    BEGIN
        RAISERROR('Termin pertama tidak dapat langsung diisi 100%%. Silakan bagi persentase ke termin berikutnya.', 16, 1);
        RETURN;
    END;

    -- 5. CEK EXISTENCE UNTUK LOGIKA UPSERT
    SELECT @count = COUNT(id) FROM dbo.term_of_payment WHERE code_barcode = @p_code_barcode AND trx_code = @p_trx_code;

    IF (@count <> 0)
    BEGIN
        IF (@p_termin_type = 'AMT')
        BEGIN
            -- UPDATE: Pastikan Percentage, PPN, dan PPH ikut di-update
            UPDATE dbo.term_of_payment
            SET
                percentage = @p_percentage, -- Perbaikan: @p_percentage tidak lagi NULL
                amount = @p_amount,
                ppn_amount = @ppn_amt,
                pph_amount = @pph_amt,
                mod_date = @p_mod_date,
                mod_by = @p_mod_by,
                mod_ip_address = @p_mod_ip_address,
                remarks = UPPER(ISNULL(@p_remarks, '')),
                termin_type = @p_termin_type
            WHERE
                code_barcode = @p_code_barcode AND trx_code = @p_trx_code;

            SELECT @p_id = id FROM dbo.term_of_payment 
            WHERE code_barcode = @p_code_barcode AND trx_code = @p_trx_code;

            GOTO SYNC_DATA_LABEL;
        END
        ELSE
        BEGIN
            RAISERROR('term of payment cannot duplicate', 16, 1);
            RETURN;
        END
    END;

    -- 6. INSERT SECTION (UNTUK DATA BARU)
    INSERT INTO dbo.term_of_payment (
        code_barcode, trx_code, percentage, amount, cre_date, cre_by, 
        cre_ip_address, mod_date, mod_by, mod_ip_address, remarks, 
        termin_type, ppn_amount, pph_amount
    ) VALUES (
        @p_code_barcode, @p_trx_code, @p_percentage, @p_amount, @p_cre_date, @p_cre_by, 
        @p_cre_ip_address, @p_mod_date, @p_mod_by, @p_mod_ip_address, UPPER(ISNULL(@p_remarks, '')), 
        @p_termin_type, @ppn_amt, @pph_amt
    );

    SET @p_id = SCOPE_IDENTITY();

SYNC_DATA_LABEL:
    
    -- Re-Calculate All Rows for this PO (Memastikan proporsi pajak konsisten)
    DECLARE @temp_id INT, @temp_amt DECIMAL(18, 2);
    DECLARE c_temp CURSOR FOR SELECT id, amount FROM dbo.term_of_payment WHERE code_barcode = @p_code_barcode;
    OPEN c_temp;
    FETCH NEXT FROM c_temp INTO @temp_id, @temp_amt;
    WHILE @@FETCH_STATUS = 0
    BEGIN
        UPDATE dbo.term_of_payment
        SET ppn_amount = @temp_amt * ISNULL(@ppn_pct, 0) / 100,
            pph_amount = @temp_amt * ISNULL(@pph_pct, 0) / 100
        WHERE id = @temp_id;
        FETCH NEXT FROM c_temp INTO @temp_id, @temp_amt;
    END;
    CLOSE c_temp; DEALLOCATE c_temp;

    -- 8. ROUNDING ADJUSTMENT (PEMBULATAN PADA BARIS AKTIF)
    DECLARE @curr_ppn_total DECIMAL(18, 2), @curr_pph_total DECIMAL(18, 2);
    SELECT @curr_ppn_total = ISNULL(SUM(ppn_amount), 0), @curr_pph_total = ISNULL(SUM(pph_amount), 0)
    FROM dbo.term_of_payment WHERE code_barcode = @p_code_barcode;

    IF (ISNULL(@ppn_amt_awal, 0) - @curr_ppn_total) <> 0
        UPDATE dbo.term_of_payment SET ppn_amount = ppn_amount + (ISNULL(@ppn_amt_awal, 0) - @curr_ppn_total) WHERE id = @p_id;

    IF (ISNULL(@pph_amt_awal, 0) - @curr_pph_total) <> 0
        UPDATE dbo.term_of_payment SET pph_amount = pph_amount + (ISNULL(@pph_amt_awal, 0) - @curr_pph_total) WHERE id = @p_id;

	SELECT @ppn_amt = ISNULL(SUM(ppn_amount), 0), @pph_amt = ISNULL(SUM(pph_amount), 0)
    FROM dbo.term_of_payment WHERE code_barcode = @p_code_barcode;

    IF ISNULL(@pph_amt_awal, 0) <> ISNULL(@pph_amt, 0)
    BEGIN
        RAISERROR('Nilai PPH Awal tidak sama dengan nilai PPH akhir setelah TOP!', 16, -1);
        RETURN;
    END;

    IF ISNULL(@ppn_amt_awal, 0) <> ISNULL(@ppn_amt, 0)
    BEGIN
        RAISERROR('Nilai PPN Awal tidak sama dengan nilai PPN akhir setelah TOP!', 16, -1);
        RETURN;
    END;

    -- 9. VALIDASI AKHIR PERSENTASE TOTAL
    SELECT @total_percentage = ISNULL(SUM(percentage), 0) FROM dbo.term_of_payment WHERE code_barcode = @p_code_barcode;

    IF (@total_percentage > 100.00001)
    BEGIN
        RAISERROR('Total percentage cannot be more than 100', 16, 1);
        RETURN;
    END;
END;