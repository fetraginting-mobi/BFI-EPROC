ALTER PROCEDURE [dbo].[xsp_inventory_mutation_header_getrows]
(
     @p_keywords      nvarchar(50)
    ,@p_status        nvarchar(20)
    ,@p_cre_by        nvarchar(15)
    ,@p_branch_code   nvarchar(10)
    ,@p_to_branch_code nvarchar(10)
    ,@p_process       nvarchar(100)
)as
begin
    if (@p_status = 'ALL')
    begin
        select  im.code_barcode
                ,im.code
                ,im.mutation_date
                ,mgs.description        'trans_flag_desc'
                ,mb1.description        'to_branch'
                ,mb.description         'from_branch'
                ,(case when isnull(im.is_upload, 0) = 1 then 'UPLOAD' else 'MANUAL' end) 'process'
        from    inventory_mutation_header im
                left join master_general_subcode mgs on (im.trans_flag_code = mgs.code)
                left join dbo.master_branch mb on (mb.code = im.branch_code)
                left join dbo.master_branch mb1 on (mb1.code = im.to_branch)
        where   im.branch_code = @p_branch_code
        and     (
                    isnull(im.is_upload, 0) <> 1
                    or im.trans_flag_code = 'POST'
                )
        and     (
                    isnull(@p_to_branch_code, '') = ''
                    or @p_to_branch_code = 'ALL'
                    or im.to_branch = @p_to_branch_code
                )
        and     (
                    @p_process = 'ALL'
                    or (@p_process = 'UPL' and isnull(convert(nvarchar(10), im.is_upload), '0') = '1')
                    or (@p_process = '' and isnull(convert(nvarchar(10), im.is_upload), '0') <> '1')
                )
        and     (
                    im.code like '%' + @p_keywords + '%'
                    or im.code_barcode like '%' + @p_keywords + '%'
                    or im.expedition_description like '%' + @p_keywords + '%'
                    or im.remarks like '%' + @p_keywords + '%'
                    or convert(nvarchar(20), im.mutation_date, 103) like '%' + @p_keywords + '%'
                    or mgs.description like '%' + @p_keywords + '%'
                    or mb.description like '%' + @p_keywords + '%'
                    or mb1.description like '%' + @p_keywords + '%'
                )
        order by im.code desc, mutation_date desc
    end
    else
    begin
        select  im.code_barcode
                ,im.code
                ,im.mutation_date
                ,mgs.description        'trans_flag_desc'
                ,mb1.description        'to_branch'
                ,mb.description         'from_branch'
                ,(case when isnull(im.is_upload, 0) = 1 then 'UPLOAD' else 'MANUAL' end) 'process'
        from    inventory_mutation_header im
                left join master_general_subcode mgs on (im.trans_flag_code = mgs.code)
                left join dbo.master_branch mb on (mb.code = im.branch_code)
                left join dbo.master_branch mb1 on (mb1.code = im.to_branch)
        where   mgs.code = @p_status
        and     im.branch_code = @p_branch_code
        and     (
                    isnull(im.is_upload, 0) <> 1
                    or im.trans_flag_code = 'POST'
                )
        and     (
                    isnull(@p_to_branch_code, '') = ''
                    or @p_to_branch_code = 'ALL'
                    or im.to_branch = @p_to_branch_code
                )
        and     ((@p_process = 'UPL' and isnull(convert(nvarchar(10), im.is_upload), '0') = '1')
                    or (@p_process = '' and isnull(convert(nvarchar(10), im.is_upload), '0') <> '1')
                )
        and     (
                    im.code like '%' + @p_keywords + '%'
                    or im.code_barcode like '%' + @p_keywords + '%'
                    or im.expedition_description like '%' + @p_keywords + '%'
                    or im.remarks like '%' + @p_keywords + '%'
                    or convert(nvarchar(20), im.mutation_date, 103) like '%' + @p_keywords + '%'
                    or mgs.description like '%' + @p_keywords + '%'
                    or mb.description like '%' + @p_keywords + '%'
                    or mb1.description like '%' + @p_keywords + '%'
                )
        order by im.code desc, mutation_date desc
    end
end


