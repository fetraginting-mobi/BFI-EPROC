<%@ Page Language="C#" AutoEventWireup="true" CodeFile="subscription.aspx.cs" Inherits="lookup_subscription" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Subscription</title>
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
                <div class="col-sm-12">
                    <asp:Panel ID="pnlSearch" runat="server" DefaultButton="btnSearchSource"  class="input-group">
                        <asp:TextBox ID="txtSearchSource" runat="server" CssClass="form-control" placeholder="Keywords"></asp:TextBox>  
                        <div class="input-group-btn">
                            <asp:LinkButton ID="btnSearchSource" runat="server" CssClass="btn btn-info" OnClick="btnSearchSource_Click" CausesValidation="false"><i class="icon-search"></i>  Search</asp:LinkButton>
                        </div>
                    </asp:Panel>
                </div>
            </div>
            
            <div class="row">
                <div class="col-sm-12">
                    <asp:UpdatePanel ID="updSource" runat="server">
                        <ContentTemplate>
                            <asp:GridView ID="gvwListSource" runat="server" AutoGenerateColumns="false" CssClass="display table table-bordered table-striped"
                                AllowPaging="true" PageSize="5"
                                OnPageIndexChanging="gvwListSource_PageIndexChanging" EmptyDataText="There is no data">
                                <Columns>    
                                    <asp:TemplateField>
                                        <ItemTemplate>
                                            <asp:CheckBox runat="server" ID="chbChecked"/>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:BoundField DataField="CODE" HeaderText="Code">
                                        <ItemStyle Width="40%" HorizontalAlign="Center" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="DESCRIPTION" HeaderText="Description">
                                        <ItemStyle Width="60%"/>
                                    </asp:BoundField>                                    
                                </Columns>
                            </asp:GridView>
                        </ContentTemplate>
                        <Triggers>
                            <asp:AsyncPostBackTrigger ControlID="btnSearchSource" EventName="Click" />
                            <asp:AsyncPostBackTrigger ControlID="btnAdd" EventName="Click" />
                            <asp:AsyncPostBackTrigger ControlID="btnRemove" EventName="Click" />
                           <%-- <asp:AsyncPostBackTrigger ControlID="btnSave" EventName="Click" />--%>
                        </Triggers>
                    </asp:UpdatePanel>
                </div>
            </div>
            
            <div class="row">
                <div class="col-sm-4">
                </div>
                <div class="col-sm-8">
                    <asp:LinkButton ID="btnAdd" runat="server" CssClass="btn btn-primary" OnClick="btnAdd_Click" CausesValidation="false"><i class="icon-plus"></i>  Add</asp:LinkButton>
                    <asp:LinkButton ID="btnRemove" runat="server" CssClass="btn btn-primary" OnClick="btnRemove_Click" CausesValidation="false"><i class="icon-minus"></i>  Remove</asp:LinkButton>
                </div>
            </div>
            
            <div class="row">
                <div class="col-sm-12">
                    <asp:Panel ID="Panel2" runat="server" DefaultButton="btnSearchTarget" class="input-group">
                        <asp:TextBox ID="txtSearchTarget" runat="server" CssClass="form-control" placeholder="Keywords"></asp:TextBox>  
                        <div class="input-group-btn">
                            <asp:LinkButton ID="btnSearchTarget" runat="server" CssClass="btn btn-info" OnClick="btnSearchTarget_Click" CausesValidation="false"><i class="icon-search"></i>  Search</asp:LinkButton>
                        </div>
                    </asp:Panel>
                </div>
            </div>
            
            <div class="row">
                <div class="col-sm-12">
                    <asp:UpdatePanel ID="updTarget" runat="server">
                        <ContentTemplate>
                            <asp:GridView ID="gvwListTarget" runat="server" AutoGenerateColumns="false" CssClass="display table table-bordered table-striped"
                                AllowPaging="true" PageSize="5"
                                OnPageIndexChanging="gvwListTarget_PageIndexChanging" EmptyDataText="There is no data">
                                <Columns>     
                                    <asp:TemplateField>
                                        <ItemTemplate>
                                            <asp:CheckBox runat="server" ID="chbChecked"/>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:BoundField DataField="CODE" HeaderText="Code">
                                        <ItemStyle Width="40%" HorizontalAlign="Center" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="DESCRIPTION" HeaderText="Description">
                                        <ItemStyle Width="60%"/>
                                    </asp:BoundField>  
                                </Columns>
                            </asp:GridView>
                        </ContentTemplate>
                        <Triggers>
                            <asp:AsyncPostBackTrigger ControlID="btnSearchTarget" EventName="Click" />
                            <asp:AsyncPostBackTrigger ControlID="btnAdd" EventName="Click" />
                            <asp:AsyncPostBackTrigger ControlID="btnRemove" EventName="Click" />
                            <%--<asp:AsyncPostBackTrigger ControlID="btnSave" EventName="Click" />--%>
                        </Triggers>
                    </asp:UpdatePanel>
                </div>
            </div>
                        
            <%--<div class="row">
                <div class="col-sm-12">
                    <asp:LinkButton ID="btnSave" runat="server" CssClass="btn btn-info" OnClick="btnSave_Click" CausesValidation="false"><i class="icon-save"></i>  Save Change</asp:LinkButton>
                </div>
            </div>      --%> 
            
        </div>
    </section>

    <script src="../js/jquery.js"></script>

    <script src="../js/jquery-1.8.3.min.js"></script>

    <script src="../js/bootstrap.min.js"></script>

    <script src="../js/common-scripts.js"></script>

    </form>
</body>
</html>
