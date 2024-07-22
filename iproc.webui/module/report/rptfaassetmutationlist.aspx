<%@ Page Title="" Language="C#" MasterPageFile="~/iproc.master" AutoEventWireup="true" CodeFile="rptfaassetmutationlist.aspx.cs" Inherits="module_report_rptfaassetmutationlist" %>

<%@ Register Assembly="MPF23.XUI" Namespace="MPF23.XUI.Control" TagPrefix="cc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cph" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cpb" Runat="Server">
    <section class="panel">
        <header class="panel-heading">
          <span>FA Asset Mutation List Report</span>
        </header>
        <div class="panel-heading">
            <div class="row">
                <div class="col-sm-12 ">
                    <asp:LinkButton ID="btnPrintExcel" runat="server" CssClass="btn btn-primary" OnClick="btnPrintExcel_Click" CausesValidation="false"><i class="icon-print"></i>  Print Excel</asp:LinkButton>
                    <cc1:XUILinkButton ID="btnCancel" RoleCode="" runat="server" CssClass="btn btn-danger" OnClick="btnCancel_Click" CausesValidation="false"><i class="icon-arrow-left"></i>  Back</cc1:XUILinkButton>
                </div>
            </div>
        </div>
        <div class="panel-body form-horizontal">
            <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                <ContentTemplate> 
                     <div class="row">
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-3">From Date</label>
                                <asp:RequiredFieldValidator ID="rfvStartDate" runat="server" ErrorMessage="*" ControlToValidate="txtStartDate" Display="Dynamic"></asp:RequiredFieldValidator>
                                <div class="col-sm-6">
                                    <cc1:XUITextBox ID="txtStartDate" runat="server" CssClass="form-control default-date-picker-all" placeholder="From Date" SPParameterName="p_start_date" MaxLength="10" DataType="DateTime" BindType="UItoDBOnly" Format = "dd/MM/yyyy"></cc1:XUITextBox>
                                </div>
                            </div>
                        </div>
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-3">To Date</label>
                                <asp:RequiredFieldValidator ID="rfvEndDate" runat="server" ErrorMessage="*" ControlToValidate="txtEndDate" Display="Dynamic"></asp:RequiredFieldValidator>
                                <div class="col-sm-6">
                                    <cc1:XUITextBox ID="txtEndDate" runat="server" CssClass="form-control default-date-picker-all" placeholder="To Date" SPParameterName="p_end_date" MaxLength="10" DataType="DateTime" BindType="UItoDBOnly" Format = "dd/MM/yyyy"></cc1:XUITextBox>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-3">Branch</label>
                                <div class="col-sm-6">
                                 <asp:UpdatePanel ID="UpB" runat="server">
                                        <ContentTemplate>
                                    <cc1:XUIDropDownList ID="ddlBranch" runat="server" CssClass="form-control" SPParameterName="p_branch_code" DataType="String" OnSelectedIndexChanged= "ddlLocation_SelectedIndexChanged" AutoPostBack= "true" BindType="UIToDBOnly" ></cc1:XUIDropDownList>
                                    <cc1:XUILabel ID="lblbranch" runat="server"  DBColumnName="BRANCH_CODE" DataType="String" BindType="DBToUIOnly" Text="--" style="display:none;"></cc1:XUILabel>
                                    </ContentTemplate>
                                  </asp:UpdatePanel>
                                </div>
                             </div>
                         </div>                                 
                         <div class="col-sm-6">
							<div class="form-group">
								<label class="col-sm-3">Location</label>
								<div class="col-sm-6">
									<asp:UpdatePanel ID="updUn" runat="server">
										<ContentTemplate>
											<cc1:XUIDropDownList ID="ddlLocation" runat="server" CssClass="form-control" SPParameterName="p_location"  DataType="String" BindType="UIToDBOnly"></cc1:XUIDropDownList>
										</ContentTemplate>
										<Triggers>
											<asp:AsyncPostBackTrigger ControlID="ddlBranch" EventName="SelectedIndexChanged" />
										</Triggers>
									</asp:UpdatePanel>
								</div>
							</div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-3">Item Group</label>
                                <div class="col-sm-6">
                                    <cc1:XUITextBox ID="txtItemGroup" Text="ALL" runat="server"  CssClass="form-control" placeholder="Item Group" SPParameterName="p_item_group" DataType="String" BindType="Both"></cc1:XUITextBox>
                                </div>                                    
                            </div>
                        </div>
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-3">Item Name</label>
                                <div class="col-sm-6">
                                    <cc1:XUITextBox ID="txtItemName" Text="ALL" runat="server"  CssClass="form-control" placeholder="Item Name" SPParameterName="p_item_name" DataType="String" BindType="Both"></cc1:XUITextBox>
                                </div>                                    
                            </div>
                        </div>
                    </div>
                    
                    <div class="row">
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-3">Owner</label>
                                <asp:RequiredFieldValidator ID="rfvddlOwner" runat="server" ErrorMessage="*" ControlToValidate="ddlOwner" Display="Dynamic"></asp:RequiredFieldValidator>
                                <div class="col-sm-6">
                                    <cc1:XUIDropDownList ID="ddlOwner" runat="server" CssClass="form-control" SPParameterName="p_owner" BindType="Both" DataType="String" ></cc1:XUIDropDownList>  
                                </div>
                            </div>
                        </div>
                        <div class="col-sm-6">
                            <div class="form-group">
                            <label runat="server" id="Category" class="col-sm-3">Category</label>
                                <div class="col-sm-6">
                                    <cc1:XUIDropDownList ID="ddlCategory" runat="server" CssClass="form-control" SPParameterName="p_type_code" BindType="Both" DataType="String"></cc1:XUIDropDownList>
                                    <asp:RequiredFieldValidator ID="rfvCategory" runat="server" ErrorMessage="Required Field!" ControlToValidate="ddlCategory" Display="Dynamic" InitialValue="0"></asp:RequiredFieldValidator>
                                </div>
                            </div>                            
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-3">Status</label>
                                <asp:RequiredFieldValidator ID="rfvddlStatus" runat="server" ErrorMessage="*" ControlToValidate="ddlStatus" Display="Dynamic"></asp:RequiredFieldValidator>
                                <div class="col-sm-6">
                                    <cc1:XUIDropDownList ID="ddlStatus" runat="server" CssClass="form-control" SPParameterName="p_status" BindType="Both" DataType="String" >
                                       <asp:ListItem Text="ALL" Value="ALL"></asp:ListItem>
                                       <asp:ListItem Text="NEW" Value="NEW"></asp:ListItem>
                                       <asp:ListItem Text="POST" Value="POST"></asp:ListItem>
                                       <asp:ListItem Text="PENDING" Value="PENDING"></asp:ListItem>
                                       <asp:ListItem Text="RETURNED" Value="RETURNED"></asp:ListItem>
                                    </cc1:XUIDropDownList>  
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-3">Barcode</label>
                                <div class="col-sm-6">
                                    <cc1:XUITextBox ID="txtBarcode" Text="ALL" runat="server"  CssClass="form-control" placeholder="Barcode" SPParameterName="p_barcode" DataType="String" BindType="Both"></cc1:XUITextBox>
                                </div>                                    
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-sm-9">
                            <div class="form-group">
                                <label class="col-sm-2">Search By</label>
                                <div class="col-sm-3">
                                    <cc1:XUIDropDownList ID="ddlSearchBy" Width="200px" runat="server" CssClass="form-control" SPParameterName="p_search_by" DataType="String" BindType="Both">
                                        <asp:ListItem Value="ASSET NAME">ASSET NAME</asp:ListItem>
                                        <asp:ListItem Value="MODEL NAME">MODEL NAME</asp:ListItem>
                                        <asp:ListItem Value="INISIAL CODE">INISIAL CODE</asp:ListItem>
                                    </cc1:XUIDropDownList>
                                </div>
                                <div class="col-sm-5">
                                    <cc1:XUITextBox ID="txtKeywords" runat="server"  CssClass="form-control" placeholder="Keywords" SPParameterName="p_keywords" DataType="String" BindType="Both"></cc1:XUITextBox>
                                </div>                                    
                            </div>
                        </div>
                    </div>
                </ContentTemplate>
                <Triggers>
                   <asp:AsyncPostBackTrigger ControlID="btnPrintExcel" EventName="Click" />
                </Triggers>
            </asp:UpdatePanel>
        </div>
    </section>
</asp:Content>

