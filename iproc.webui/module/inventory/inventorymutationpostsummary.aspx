<%@ Page Language="C#" AutoEventWireup="true"
    CodeFile="inventorymutationpostsummary.aspx.cs"
    Inherits="module_inventory_inventorymutationpostsummary" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Inventory Mutation - Post Summary</title>

    <style type="text/css">
        .table
        {
            width: 100%;
            border-collapse: collapse;
        }
        .table th
        {
            background-color: #f2f2f2;
            text-align: center;
        }
        .table td
        {
            padding: 5px;
        }
    </style>
</head>

<body>
    <form id="form1" runat="server">

        <h3>Post Inventory Mutation - Summary</h3>

        <asp:GridView ID="gvSummary" runat="server"
            AutoGenerateColumns="false"
            CssClass="table table-bordered">
            <Columns>
                <asp:BoundField DataField="CodeBarcode" HeaderText="Barcode" />
                <asp:BoundField DataField="IsSuccess" HeaderText="Result" />
                <asp:BoundField DataField="Message" HeaderText="Message" />
            </Columns>
        </asp:GridView>

        <br />

        <asp:Button ID="btnBack"
            runat="server"
            Text="Back"
            OnClick="btnBack_Click" />

    </form>
</body>
</html>
