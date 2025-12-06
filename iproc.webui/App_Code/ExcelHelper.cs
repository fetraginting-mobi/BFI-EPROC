using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using DocumentFormat.OpenXml;
using DocumentFormat.OpenXml.Packaging;
using DocumentFormat.OpenXml.Spreadsheet;

public class ExcelHelper
{
    public ExcelHelper() { }

    // ================================================================
    // COLUMN CAPTION (A, B, C, ..., Z, AA, AB ...)
    // ================================================================
    internal class ColumnCaption
    {
        private static string[] Alphabets = { "A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z" };

        private static ColumnCaption instance = null;
        private List<string> cellHeaders = null;

        public static ColumnCaption Instance
        {
            get
            {
                if (instance == null)
                    return new ColumnCaption();
                else
                    return ColumnCaption.Instance;
            }
        }

        public ColumnCaption()
        {
            InitCollection();
        }

        private void InitCollection()
        {
            cellHeaders = new List<string>();

            foreach (string s in Alphabets)
                cellHeaders.Add(s);

            foreach (string a in Alphabets)
                foreach (string b in Alphabets)
                    cellHeaders.Add(a + b);
        }

        internal string Get(int rowIndex, int columnIndex)
        {
            return cellHeaders.ElementAt(columnIndex) + (rowIndex + 1).ToString();
        }
    }

    // ================================================================
    // EXPORT MAIN
    // ================================================================
    internal string ExportToExcel(DataTable dt)
    {
        string file = Path.GetTempPath() + Guid.NewGuid() + ".xlsx";

        using (SpreadsheetDocument doc = SpreadsheetDocument.Create(file, SpreadsheetDocumentType.Workbook))
        {
            CreateExcelParts(doc, dt);
        }

        return file;
    }

    // ================================================================
    // BUILD WORKBOOK
    // ================================================================
    private void CreateExcelParts(SpreadsheetDocument doc, DataTable data)
    {
        WorkbookPart wbPart = doc.AddWorkbookPart();
        wbPart.Workbook = new Workbook();

        WorkbookStylesPart stylesPart = wbPart.AddNewPart<WorkbookStylesPart>();
        stylesPart.Stylesheet = CreateStylesheet();
        stylesPart.Stylesheet.Save();

        WorksheetPart wsPart = wbPart.AddNewPart<WorksheetPart>();
        WriteWorksheet(wsPart, data);

        Sheets sheets = new Sheets();
        Sheet sheet = new Sheet()
        {
            Id = doc.WorkbookPart.GetIdOfPart(wsPart),
            SheetId = 1,
            Name = "Report"
        };
        sheets.Append(sheet);

        wbPart.Workbook.Append(sheets);
        wbPart.Workbook.Save();
    }

    // ================================================================
    // STYLESHEET (BOLD HEADER, BORDER, GRAY BACKGROUND)
    // ================================================================
    private Stylesheet CreateStylesheet()
    {
        Fonts fonts = new Fonts(
            new Font( // normal
                new FontSize() { Val = 10 },
                new Color() { Rgb = "000000" },
                new FontName() { Val = "Calibri" }
            ),
            new Font( // bold header
                new Bold(),
                new FontSize() { Val = 11 },
                new Color() { Rgb = "000000" },
                new FontName() { Val = "Calibri" }
            )
        );

        Fills fills = new Fills(
            new Fill(new PatternFill() { PatternType = PatternValues.None }),
            new Fill(new PatternFill() { PatternType = PatternValues.Gray125 }),
            new Fill(new PatternFill(
                new ForegroundColor { Rgb = "FFD9D9D9" }
            ) { PatternType = PatternValues.Solid }) // header gray
        );

        Borders borders = new Borders(
            new Border(),
            new Border(
                new LeftBorder() { Style = BorderStyleValues.Thin },
                new RightBorder() { Style = BorderStyleValues.Thin },
                new TopBorder() { Style = BorderStyleValues.Thin },
                new BottomBorder() { Style = BorderStyleValues.Thin },
                new DiagonalBorder())
        );

        CellFormats cellFormats = new CellFormats(
            new CellFormat(), // default
            new CellFormat() // header style index 1
            {
                FontId = 1,
                FillId = 2,
                BorderId = 1,
                Alignment = new Alignment() { Horizontal = HorizontalAlignmentValues.Center },
                ApplyFont = true,
                ApplyFill = true,
                ApplyBorder = true
            },
            new CellFormat() // normal data style index 2
            {
                FontId = 0,
                FillId = 0,
                BorderId = 1,
                Alignment = new Alignment() { Horizontal = HorizontalAlignmentValues.Left },
                ApplyBorder = true
            }
        );

        return new Stylesheet(fonts, fills, borders, cellFormats);
    }

    // ================================================================
    // WRITE WORKSHEET
    // ================================================================
    private void WriteWorksheet(WorksheetPart wsPart, DataTable data)
    {
        Worksheet ws = new Worksheet();
        SheetData sheetData = new SheetData();

        UInt32Value rowIndex = 1U;

        // Freeze Header Row
        ws.Append(new SheetViews(new SheetView()
        {
            WorkbookViewId = 0,
            Pane = new Pane()
            {
                VerticalSplit = 1,
                TopLeftCell = "A2",
                ActivePane = PaneValues.BottomLeft,
                State = PaneStateValues.Frozen
            }
        }));

        // ------------------ HEADER ROW -------------------
        Row header = new Row() { RowIndex = rowIndex++ };
        List<int> maxWidth = new List<int>();

        for (int c = 0; c < data.Columns.Count; c++)
        {
            string colName = data.Columns[c].ColumnName;

            maxWidth.Add(colName.Length);

            Cell cell = new Cell()
            {
                CellReference = ColumnCaption.Instance.Get((int)rowIndex.Value - 2, c),
                StyleIndex = 1
            };

            SetCellValue(cell, colName);
            header.Append(cell);
        }

        sheetData.Append(header);

        // ------------------ DATA ROWS -------------------
        for (int r = 0; r < data.Rows.Count; r++)
        {
            Row row = new Row() { RowIndex = rowIndex++ };

            for (int c = 0; c < data.Columns.Count; c++)
            {
                object raw = data.Rows[r][c];

                // Fix untuk compiler lama — tanam null check manual
                string value = (raw == null || raw == DBNull.Value) ? "" : raw.ToString();

                if (value.Length > maxWidth[c])
                    maxWidth[c] = value.Length;

                Cell cell = new Cell()
                {
                    CellReference = ColumnCaption.Instance.Get((int)rowIndex.Value - 2, c),
                    StyleIndex = 2
                };

                SetCellValue(cell, value);

                row.Append(cell);
            }

            sheetData.Append(row);
        }

        ws.Append(sheetData);

        // ------------------ AUTO-FIT COLUMNS -------------------
        Columns cols = new Columns();

        for (int i = 0; i < maxWidth.Count; i++)
        {
            double width = maxWidth[i] + 2; // padding
            cols.Append(new Column()
            {
                Min = (UInt32)(i + 1),
                Max = (UInt32)(i + 1),
                Width = width,
                CustomWidth = true
            });
        }

        ws.InsertAt(cols, 1);

        wsPart.Worksheet = ws;
        wsPart.Worksheet.Save();
    }

    // ================================================================
    // INLINE STRING FIX (SUPPORT < >)
    // ================================================================
    private void SetCellValue(Cell cell, string value)
    {
        if (value.Contains("<") || value.Contains(">"))
        {
            cell.DataType = CellValues.InlineString;
            cell.InlineString = new InlineString(
                new Text(value)
                {
                    Space = SpaceProcessingModeValues.Preserve
                });
        }
        else
        {
            cell.DataType = CellValues.String;
            cell.CellValue = new CellValue(value);
        }
    }
}
