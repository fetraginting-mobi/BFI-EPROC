<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ApprovalReport.aspx.cs" Inherits="lookup_ApprovalReport"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Lookup</title>
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
</head>
<body>
    <form id="form1" runat="server">
    <asp:ScriptManager ID="smMain" runat="server">
    </asp:ScriptManager>
    <section class="panel">
        <div class="panel-body">
            <div class="row">
                <div class="col-sm-12 col-md-12">
                    <asp:Panel ID="pnlSearch" runat="server" DefaultButton="btnSearch"   class="input-group">
                        <asp:TextBox ID="txtSearch" runat="server" CssClass="form-control" placeholder="Keywords"></asp:TextBox>  
                        <div class="input-group-btn">
                            <asp:LinkButton ID="btnSearch" runat="server" CssClass="btn btn-info" OnClick="btnSearch_Click" CausesValidation="false"><i class="icon-search"></i>  Search</asp:LinkButton>
                            <asp:LinkButton ID="btnClear" runat="server" CssClass="btn btn-danger" OnClick="btnClear_Click" CausesValidation="false"><i class="icon-trash"></i>  Reset</asp:LinkButton>
                        </div>
                   </asp:Panel>
                </div>
            </div>
            <div class="row">
                <div class="col-sm-12 col-md-12">
                    <asp:UpdatePanel ID="upd" runat="server">
                        <ContentTemplate>
                            <asp:GridView ID="gvwList" runat="server" AutoGenerateColumns="false" CssClass="display table table-bordered table-striped"
                            AllowPaging="true" PageSize="5"
                                OnPageIndexChanging="gvwList_PageIndexChanging" 
                                onselectedindexchanged="gvwList_SelectedIndexChanged" EmptyDataText="There is no data">
                                <Columns>    
                                </Columns>
                            </asp:GridView>
                        </ContentTemplate>
                        <Triggers>
                            <asp:AsyncPostBackTrigger ControlID="btnSearch" EventName="Click" />
                        </Triggers>
                    </asp:UpdatePanel>
                </div>
            </div>
        </div>
    </section>

    <script src="../js/jquery.js"></script>

    <script src="../js/jquery-1.8.3.min.js"></script>

    <script src="../js/bootstrap.min.js"></script>

    <script src="../js/common-scripts.js"></script>

    </form>
</body>
</html>


