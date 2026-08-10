CREATE PROCEDURE [dbo].[xsp_inventory_list_item_getrows]
as
	begin 
	WITH cte AS (
	  SELECT TOP (10)
           CAST(ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS INT) AS No
    FROM sys.objects
	) 
	SELECT 
	  No AS 'No', 
	  NULL AS 'From Location*', 
	  NULL AS 'To Branch*', 
	  NULL AS 'To Location*', 
	  NULL AS 'Description*', 
	  NULL AS 'ITEM_CODE*', 
	  NULL AS 'Quantity*' 
	FROM 
	  cte;
END

