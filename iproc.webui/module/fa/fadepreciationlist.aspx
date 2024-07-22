<%@ Page Title="" Language="C#" MasterPageFile="~/iproc.master" AutoEventWireup="true" CodeFile="fadepreciationlist.aspx.cs" Inherits="module_fa_fadepreciationlist" %>

<%@ Register Assembly="MPF23.XUI" Namespace="MPF23.XUI.Control" TagPrefix="cc1" %>
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
                    <cc1:XUILinkButton ID="btnGenerate" RoleCode="R90000110O" runat="server" CssClass="btn btn-primary" OnClick="btnGenerate_Click"><i class="icon-plus"></i>  Generate</cc1:XUILinkButton>
                    <cc1:XUILinkButton ID="btnPost" RoleCode="R90000110O" runat="server" CssClass="btn btn-danger" OnClick="btnPost_Click"><i class="icon-alert-danger"></i>  Post</cc1:XUILinkButton>
                    <cc1:XUILinkButton ID="btnDownload" RoleCode="R90000110E" runat="server" CssClass="btn btn-primary" OnClick="btnDownload_Click"><i class="icon-print"></i>  Download</cc1:XUILinkButton>
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
            <div class="row">
                <div class="col-sm-4">
                    <div class="form-group">
                        <label class="col-sm-4">Cost Center</label>
                        <div class="col-sm-6">
                            <cc1:XUIDropDownList ID="ddlBranch" runat="server" CssClass="form-control" DBColumnName="BRANCH_CODE" SPParameterName="p_branch_code" DataType="String" BindType="Both" ></cc1:XUIDropDownList>
                        </div>
                    </div>
                </div>
                <div class="col-sm-4">
                    <div class="input-group">
                        <label class="col-sm-3">Period</label>
                        <div class="col-sm-9">
                           <asp:TextBox ID="txtYearDepre" runat="server" CssClass="form-control" placeholder="Year" MaxLength="4" Width="70"></asp:TextBox>
                           <asp:RequiredFieldValidator ID="rfvYearDepre" runat="server" ErrorMessage="*" ControlToValidate="txtYearDepre" Display="Dynamic"></asp:RequiredFieldValidator>
                           <%--<asp:TextBox ID="txtMonthDepre" runat="server" CssClass="form-control" placeholder="Month" MaxLength="2" Width="70"></asp:TextBox>--%>  
                           <asp:DropDownList ID="ddlMonthDepre" runat="server" CssClass="form-control" placeholder="Month" MaxLength="2" Width="70">
                               <asp:ListItem Text="01" Value="01"></asp:ListItem>
                               <asp:ListItem Text="02" Value="02"></asp:ListItem>
                               <asp:ListItem Text="03" Value="03"></asp:ListItem>
                               <asp:ListItem Text="04" Value="04"></asp:ListItem>
                               <asp:ListItem Text="05" Value="05"></asp:ListItem>
                               <asp:ListItem Text="06" Value="06"></asp:ListItem>
                               <asp:ListItem Text="07" Value="07"></asp:ListItem>
                               <asp:ListItem Text="08" Value="08"></asp:ListItem>
                               <asp:ListItem Text="09" Value="09"></asp:ListItem>
                               <asp:ListItem Text="10" Value="10"></asp:ListItem>
                               <asp:ListItem Text="11" Value="11"></asp:ListItem>
                               <asp:ListItem Text="12" Value="12"></asp:ListItem>
                           </asp:DropDownList>
                           <asp:RequiredFieldValidator ID="rfvMonthDepre" style="display:none;" runat="server" ErrorMessage="*" ControlToValidate="ddlMonthDepre" Display="Dynamic"></asp:RequiredFieldValidator>                                                                    
                           <cc1:XUILinkButton ID="btnViewGvwListDepre" style="display:none;" RoleCode="R90000110O" runat="server" CssClass="btn btn-primary" onclick="btnViewGvwListDepre_OnClick"><i class="icon-plus"></i>  View</cc1:XUILinkButton>           
                        </div>
                    </div>     
                 </div>                
                </div>  
                <div class="row">
                   <div class="col-sm-6">
                       <div class="form-group"></div>
                   </div>
                </div>
                <asp:UpdatePanel ID="updDepre" runat="server">
                    <ContentTemplate>
                        <asp:GridView ID="gvwListDepre" runat="server" AutoGenerateColumns="false" CssClass="display table table-bordered table-striped"
                            AllowPaging="True" PageSize="5000" DataKeyNames="CODE" OnPageIndexChanging="gvwListDepre_PageIndexChanging"
                            onselectedindexchanged="gvwListDepre_SelectedIndexChanged" 
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
                                  <asp:TemplateField>
                                   <HeaderTemplate>
                                         <asp:CheckBox ID="chbSelectAll" runat="server" onclick="checkAll(this)" />
                                   </HeaderTemplate>
                                   <ItemTemplate>
                                         <asp:CheckBox ID="chbSelect" runat="server" onclick="Check_Click" />
                                   </ItemTemplate>
                                   </asp:TemplateField>
                          
                                <asp:BoundField DataField="BRANCH_CODE" HeaderText="Cost Center">
                                    <ItemStyle Width="20%" HorizontalAlign="Left"/>
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
                              <%--  <asp:BoundField DataField="PURCHASE_AMOUNT" HeaderText="Original Amount"  DataFormatString="{0:N2}">
                                    <ItemStyle Width="12%" HorizontalAlign="Right"/>
                                </asp:BoundField>--%>
                                <asp:CommandField ShowSelectButton="true" />
                            </Columns>
                     </asp:GridView>
                </ContentTemplate>
                <Triggers>
                    <asp:AsyncPostBackTrigger ControlID="btnViewGvwListDepre" EventName="Click" />
                </Triggers>
            </asp:UpdatePanel>
        </div>
    </section>
</asp:Content>


