<%@ Page Title="" Language="C#" MasterPageFile="~/iproc.master" AutoEventWireup="true" CodeFile="updateglheaderaccount.aspx.cs" Inherits="module_accounting_updateglheaderaccount" %>

<%@ Register Assembly="MPF23.XUI" Namespace="MPF23.XUI.Control" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="cph" runat="Server">

    <%--<script type="text/javascript">
    function CheckOne(obj)
    {
        var grid = obj.parentNode.parentNode.parentNode;
        var inputs = grid.getElementsByTagName("input");
        for(var i=0;i<inputs.length;i++)
        {
            if (inputs[i].type =="checkbox")
            {
                if(obj.checked && inputs[i] != obj && inputs[i].checked)
                {
                    inputs[i].checked = false;
                }
            }
        }
    }
    </script>--%>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cpb" runat="Server">    
    <section class="panel">
        <header class="panel-heading">
          <span>Update G/L Header Account</span>
        </header>
        <div class="panel-heading">
            <div class="row">
                <div class="col-sm-8">
                    <cc1:XUILinkButton RoleCode="R12000130O" ID="btnProcess" runat="server" CssClass="btn btn-primary" OnClick="btnProcess_Click" CausesValidation="false"><i class="icon-save"></i> Update G/L </cc1:XUILinkButton>
                    <%--<asp:LinkButton ID="btnGenerate" runat="server" CssClass="btn btn-primary" OnClick="btnGenerate_Click" CausesValidation="false"><i class="icon-save"></i> Generate GL A/C</asp:LinkButton>--%>
                </div>
                <div class="col-sm-4">
                    <asp:Panel ID="pnlSearch" runat="server" DefaultButton="btnSearch" class="input-group">
                        <asp:TextBox ID="txtSearch" runat="server" CssClass="form-control" placeholder="Keywords"></asp:TextBox>  
                        <div class="input-group-btn">
                            <asp:LinkButton ID="btnSearch" runat="server" CssClass="btn btn-info" OnClick="btnSearch_Click"><i class="icon-search"></i>  Search</asp:LinkButton>
                        </div>
                    </asp:Panel>
                </div>
            </div>
        </div>
        <div class="panel-body">
            <%--<div class="row">
                <div class="col-sm-6">
                    <div class="form-group">
                        <label class="col-sm-4">Period</label>
                        <div class="col-sm-3">
                            <cc1:XUITextBox ID="txtPeriod" runat="server" CssClass="form-control" SPParameterName="p_period" DataType="String" BindType="Both" ></cc1:XUITextBox> 
                        </div>
                    </div>                            
                </div>
            </div>--%>
            <div class="row">
                <div class="col-sm-6">
                    <div class="form-group"></div>
                </div>
            </div>
                <asp:UpdatePanel ID="upd" runat="server">
                    <ContentTemplate>
                        <asp:GridView ID="gvwList" runat="server" AutoGenerateColumns="false" CssClass="display table table-bordered table-striped"
                        AllowPaging="true" PageSize="10" DataKeyNames="CODE,ACC_PERIOD"
                            OnPageIndexChanging="gvwList_PageIndexChanging" 
                            onselectedindexchanged="SelectedIndexChanged" EmptyDataText="There is no data">
                           <Columns>
                                <asp:TemplateField>
                                    <HeaderTemplate>
                                        <span>No</span>
                                    </HeaderTemplate> 
                                <ItemTemplate>
                                        <%# Container.DataItemIndex + 1 %>
                                </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField>
                                    <HeaderTemplate>
                                         <asp:CheckBox ID="chbSelectAll" runat="server" onclick="checkAll(this)" />
                                    </HeaderTemplate>
                                    <ItemTemplate>
                                     <asp:CheckBox ID="chbSelect" runat="server" onclick="Check_Click" />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                 <asp:BoundField DataField="CODE" HeaderText="Branch Code">
                                    <ItemStyle Width="30%" HorizontalAlign="Center" />
                                </asp:BoundField> 
                                <asp:BoundField DataField="NAME" HeaderText="Branch Name">
                                    <ItemStyle Width="50%" HorizontalAlign="Left" />
                                </asp:BoundField>  
                                <asp:BoundField DataField="ACC_PERIOD" HeaderText="Current Accounting Period">
                                    <ItemStyle Width="20%" HorizontalAlign="Center" />
                                </asp:BoundField>                       
                            </Columns>
                        </asp:GridView>
                    </ContentTemplate>
                    <Triggers>
                        <asp:AsyncPostBackTrigger ControlID="btnProcess" EventName="Click"/>
                        <asp:AsyncPostBackTrigger ControlID="btnSearch" EventName="Click"/>
                    </Triggers>
                </asp:UpdatePanel>
    </section>
</asp:Content>

