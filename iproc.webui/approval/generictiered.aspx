<%@ Page Language="C#" AutoEventWireup="true" CodeFile="generictiered.aspx.cs" Inherits="approval_generictiered" Title="Untitled Page" %>

<%@ Register Assembly="MPF23.XUI" Namespace="MPF23.XUI.Control" TagPrefix="cc1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<!-- (+) Author Anton - 2016-03-16 -->

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <%--<title>Approval</title>--%>
    <!-- Bootstrap core CSS -->
    <link href="../css/bootstrap.min.css" rel="stylesheet">
    <link href="../css/bootstrap-reset.css" rel="stylesheet">
    <!--external css-->
    <link href="../assets/font-awesome/css/font-awesome.css" rel="stylesheet" />
    <!-- Custom styles for this template -->
    <link href="../css/style.css" rel="stylesheet">
    <link href="../css/style-responsive.css" rel="stylesheet" />
    <!-- HTML5 shim and Respond.js IE8 support of HTML5 tooltipss and media queries -->
    <!--[if lt IE 9]>
      <script src="js/html5shiv.js"></script>
      <script src="js/respond.min.js"></script>
    <![endif]-->

    <script src="../js/jquery.js"></script>

    <script src="../js/bootstrap.min.js"></script>

    <script src="../js/hris.js"></script>
</head>
<body>

    <!-- (+) Author Anton - 2016-03-16 -->

    <form id="form1" runat="server">
        <section class="panel">
            <div class="panel-body">
                <table width="100%">
                    <tr>
                        <td width="20%" valign="top">
                            <label>Action</label>
                        </td>
                        <td width="80%">
                            <cc1:XUIRadioButtonList ID="rblAction" runat="server" DataType="String" BindType="None" RepeatDirection="Horizontal">
                                <asp:ListItem Selected="True" Value="APPROVED" Text="Approve &nbsp&nbsp"></asp:ListItem>
                                <asp:ListItem Value="REJECTED" Text="Reject &nbsp&nbsp"></asp:ListItem>
                                <asp:ListItem Value="RETURNED" Text="Return &nbsp&nbsp"></asp:ListItem>
                            </cc1:XUIRadioButtonList>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2"><br /></td>
                    </tr>
                    <tr>
                        <td width="20%" valign="top">
                            <label>Remark</label>
                            <asp:RequiredFieldValidator ID="rfvRemark" runat="server" ErrorMessage="*" ToolTip="Please fill this field" ControlToValidate="txtRemark" Display="Dynamic" ValidationGroup="Approval"></asp:RequiredFieldValidator>
                        </td>
                        <td width="80%">
                            <cc1:XUITextBox ID="txtRemark" runat="server" CssClass="form-control" MaxLength="4000" DataType="String" BindType="None" TextMode="MultiLine" style="max-width:400px; max-height:70px; min-width:400px; min-height:70px"></cc1:XUITextBox>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2"><br /></td>
                    </tr>
                    <tr>
                        <td>
                            <label>Password</label>
                        </td>
                        <td>
                            <cc1:XUITextBox ID="txtPassword" runat="server" CssClass="form-control" DataType="String" BindType="None" Width="400px" TextMode="Password"></cc1:XUITextBox>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2"><br /><br /></td>
                    </tr>
                    <tr>
                        <td colspan="2">
                            <asp:Button ID="btnApproval" runat="server" class="btn btn-success" Text="Submit" OnClick="btnApproval_Click" ValidationGroup="Approval" />
                            <asp:Label ID="lblError" runat="server" Text="Invalid Password!" style="color:Red; padding-left:320px" Visible="false"></asp:Label>
                        </td>
                    </tr>
                </table>
            </div>
        </section>
    </form>
</body>
</html>

