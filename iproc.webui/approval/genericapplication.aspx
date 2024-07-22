<%@ Page Language="C#" AutoEventWireup="true" CodeFile="genericapplication.aspx.cs" Inherits="approval_genericapplication" %>

<%@ Register Assembly="MPF23.XUI" Namespace="MPF23.XUI.Control" TagPrefix="cc1" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
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
    <form id="form1" runat="server">
    <section class="panel">
        <div class="panel-body">
            <div class="row">
                <div class="form-body" role="form">
                    <div class="form-group">
                        <div class="row">
                            <asp:Label ID="lblComment" runat="server" style="display:none;" Text="Comment"></asp:Label>
                            <asp:TextBox ID="txtComment" runat="server"  placeholder="Comment"
                                TextMode="MultiLine" style="display:none;" Width="400px"></asp:TextBox>
                                
                        </div>
                        <div class="row">
                            <br />
                            <asp:Label ID="lblPassword" runat="server" Text="Password"></asp:Label>
                            <asp:TextBox ID="txtPassword" runat="server"  placeholder="Password"
                                TextMode="Password"></asp:TextBox>
                            
                        </div>
                        <div class="row">
                            <br />
                            <asp:TextBox ID="txt1" runat="server" Visible="false" Width="80px"></asp:TextBox>
                            <asp:Button ID="btnApprove" runat="server" Text="Approve" class="btn btn-primary"
                                OnClick="btnApprove_Click" />
                        </div>
                        <asp:Label ID="lblValidate" runat="server" Text=""></asp:Label>
                    </div>
                </div>
            </div>
        </div>
    </section>
    </form>
</body>
</html>
