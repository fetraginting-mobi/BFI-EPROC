<%@ Page Title="" Language="C#" MasterPageFile="~/iproc.master" AutoEventWireup="true" CodeFile="fadepretiationlistlist.aspx.cs" Inherits="module_fa_fadepretiationlistlist" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cph" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cpb" Runat="Server">
      <section class="panel">
        <header class="panel-heading">
          <span>Fixed Asset Depreciation List2</span>
        </header>                            
        <div class="panel-heading">
            <div class="row">
              <div class="col-sm-8">
                  
                   <asp:LinkButton RoleCode="" ID="btnCancel" runat="server" CssClass="btn btn-danger" OnClick="btnCancel_Click"><i class="icon-remove"></i>  Return</asp:LinkButton>
                </div>
                <div class="col-sm-4">
                    <asp:Panel ID="pnlSearch" runat="server" DefaultButton="btnSearch" class="input-group">
                    <asp:TextBox ID="txtSearch" runat="server" CssClass="form-control" placeholder="Keywords"></asp:TextBox>  
                      <asp:TextBox ID="txtYear" runat="server" CssClass="form-control"  DataType="String" BindType="None" style="display:none"></asp:TextBox>  
                      <asp:TextBox ID="txtMonth" runat="server" CssClass="form-control"  DataType="String" BindType="None" style="display:none"></asp:TextBox>  
                    <div class="input-group-btn">
                        <asp:LinkButton ID="btnSearch" runat="server" CssClass="btn btn-info" OnClick="btnSearch_Click"><i class="icon-search"></i>  Search</asp:LinkButton>
                    </div>
                    </asp:Panel>
                </div> 
             </div>
          </div>
          <div class="panel-body">
                <asp:UpdatePanel ID="updDepre" runat="server">
                    <ContentTemplate>
                        <asp:GridView ID="gvwListDepre" runat="server" AutoGenerateColumns="false" CssClass="display table table-bordered table-striped"
                            AllowPaging="True" PageSize="5000" DataKeyNames="CAT_CODE" OnPageIndexChanging="gvwListDepre_PageIndexChanging"
                            EmptyDataText="There is no data">
                            <Columns>
                                <asp:TemplateField>
                                     <HeaderTemplate>
                                          <span>No</span>
                                     </HeaderTemplate> 
                                <ItemTemplate>
                                    <%# Container.DataItemIndex + 1 %>
                                 </ItemTemplate>
                                 </asp:TemplateField>
                                <asp:BoundField DataField="CAT_CODE" HeaderText="Category Code">
                                    <ItemStyle Width="10%" HorizontalAlign="Left"/>
                                </asp:BoundField>
                                  <asp:BoundField DataField="CAT_NAME" HeaderText="Category Name">
                                    <ItemStyle Width="20%" HorizontalAlign="Center"/>
                                </asp:BoundField>
                                <asp:BoundField DataField="FISCAL_VALUE" HeaderText="Fiscal Value" DataFormatString="{0:N2}">
                                    <ItemStyle Width="15%" HorizontalAlign="Left"/>
                                </asp:BoundField>
                                 <asp:BoundField DataField="COM_VALUE" HeaderText="Com Valuer" DataFormatString="{0:N2}">
                                    <ItemStyle Width="15%" HorizontalAlign="Left"/>
                                </asp:BoundField>
                                 <asp:BoundField DataField="NBV_COM" HeaderText="Net Book COM Value " DataFormatString="{0:N2}">
                                    <ItemStyle Width="15%" HorizontalAlign="Right"/>
                                </asp:BoundField>
                                <asp:BoundField DataField="NBV_FISCAL" HeaderText="Net Book Fiscal Value " DataFormatString="{0:N2}">
                                    <ItemStyle Width="15%" HorizontalAlign="Right"/>
                                </asp:BoundField>
                                <asp:BoundField DataField="DEPRECIATION_DATE" HeaderText="Depreciation Date" DataFormatString="{0:dd/MM/yyyy}">
                                    <ItemStyle Width="10%" HorizontalAlign="Center"/>
                                </asp:BoundField>
                                <%-- <asp:BoundField DataField="NILAI_RESIDUAL" HeaderText="Residual Value"  DataFormatString="{0:N2}">
                                    <ItemStyle Width="10%" HorizontalAlign="Right"/>
                                </asp:BoundField>--%>
                               
                            </Columns>
                     </asp:GridView>
                </ContentTemplate>
                <Triggers>
                  
                </Triggers>
            </asp:UpdatePanel>
        </div>
    </section>
</asp:Content>
