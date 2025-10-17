<%@ Page Language="C#" MasterPageFile="~/iproc.master" AutoEventWireup="true" CodeFile="refundinventoryamortizationheader.aspx.cs"
    Inherits="module_inventory_refundinventoryamortizationheader" Title="Untitled Page" %><%@ Register Assembly="MPF23.XUI" Namespace="MPF23.XUI.Control" TagPrefix="cc1" %> <asp:Content ID="Content1" ContentPlaceHolderID="cph" runat="Server"></asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cpb" runat="Server">
  <section class="panel">
    <header class="panel-heading">
      <span>Refund Inventory Amortization Info</span>
    </header>
    <div class="panel-heading">
      <div class="row">
        <div class="col-sm-12">
          <cc1:XUILinkButton ID="btnSave" RoleCode="R90000153C" runat="server" CssClass="btn btn-primary" OnClick="btnSave_Click">
            <i class="icon-save"></i> Save
          </cc1:XUILinkButton>
          <cc1:XUILinkButton ID="btnPost" RoleCode="R90000153E" runat="server" CssClass="btn btn-success" CausesValidation="true" ValidationGroup="Header">
            <i class="icon-envelope"></i> Post
          </cc1:XUILinkButton>
          <cc1:XUILinkButton ID="btnCancel" RoleCode="R90000153D" runat="server" CssClass="btn btn-danger" OnClick="btnCancel_Click" CausesValidation="false">
            <i class="icon-remove"></i> Cancel
          </cc1:XUILinkButton>
          <cc1:XUILinkButton ID="btnApprovalTiered" RoleCode="R90000153O" runat="server" CssClass="btn btn-success">
            <i class="icon-ok"></i> Approval
          </cc1:XUILinkButton>
          <cc1:XUILinkButton ID="btnBack" RoleCode="" runat="server" CssClass="btn btn-custome" OnClick="btnBack_Click" CausesValidation="false">
            <i class="icon-arrow-left"></i> Back
          </cc1:XUILinkButton>
        </div>
      </div>
    </div>
    <div class="panel-body form-horizontal">
      <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
          <cc1:XUILabel ID="lblApprovalRequestTargetID" runat="server" DBColumnName="approval_request_target_id" DataType="Integer" style="display:none;" BindType="DBToUIOnly"></cc1:XUILabel>
          <div class="row">
            <div class="col-sm-6">
              <div class="form-group">
                <label class="col-sm-4">No.</label>
                <!--CODE BARCODE-->
                <cc1:XUILabel ID="lblCodeBarcode" runat="server" DBColumnName="CODE_BARCODE" SPParameterName="p_code_barcode" MaxLength="14" DataType="String" BindType="Both" style="display:none"></cc1:XUILabel>
                <div class="col-sm-8">
                  <cc1:XUILabel ID="lblCode" runat="server" DBColumnName="CODE" DataType="String" BindType="DBToUIOnly" Text="--"></cc1:XUILabel>
                  <cc1:XUILinkButton ID="btnViewHistory" runat="server" CausesValidation="false" Text="Approval History"></cc1:XUILinkButton>
                </div>
              </div>
            </div>
            <div class="col-sm-6">
              <div class="form-group">
                <label class="col-sm-4">Status</label>
                <div class="col-sm-8">
                  <cc1:XUILabel ID="lblStatus" runat="server" Enabled=false DBColumnName="STATUS" DataType="String" BindType="DBToUIOnly" Text="--"></cc1:XUILabel>
                </div>
              </div>
            </div>
          </div>
          <div class="row">
            <div class="col-sm-6">
              <div class="form-group">
                <label class="col-sm-4">Branch *</label>
                <div class="col-sm-4">
                  <cc1:XUIDropDownList ID="ddlBranch" runat="server" CssClass="form-control" DBColumnName="BRANCH_CODE" SPParameterName="p_branch_code" OnSelectedIndexChanged="ddlBranch_SelectedIndexChanged" AutoPostBack="true" DataType="String" BindType="Both"></cc1:XUIDropDownList>
                  <cc1:XUILabel ID="lblBranch" runat="server" CssClass="form-control" DBColumnName="BRANCH_CODE" SPParameterName="p_branch_code" DataType="String" MaxLength="18" BindType="DBToUIOnly" style="display:none"></cc1:XUILabel>
                  <asp:RequiredFieldValidator ID="rfvDdlBranch" runat="server" ControlToValidate="ddlBranch" ErrorMessage="Branch Required!"></asp:RequiredFieldValidator>
                </div>
              </div>
            </div>
            <div class="col-sm-6">
              <div class="form-group">
                <label class="col-sm-4">Inventory Amortization No. *</label>
                <div class="col-sm-1">
                  <asp:LinkButton runat="server" ID="btnLookupInventoryAmort" class="btn btn-primary" data-toggle="modal" CausesValidation="false">
                    <i class="icon-table"></i>
                  </asp:LinkButton>
                </div>
                <div class="col-sm-3">
                  <cc1:XUITextBox ID="txtReferenceCodeBarcode" runat="server" Enabled="false" CssClass="form-control" DBColumnName="reference_code_barcode" SPParameterName="p_reference_code_barcode" DataType="String" BindType="Both" style="display:none"></cc1:XUITextBox>
                  <cc1:XUITextBox ID="txtReferenceCode" runat="server" Enabled="false" CssClass="form-control" placeholder="Inventory Amortization No." DBColumnName="reference_code" SPParameterName="p_reference_code" DataType="String" BindType="Both"></cc1:XUITextBox>
                  <asp:RequiredFieldValidator ID="rfvTxtReferenceCode" runat="server" ControlToValidate="txtReferenceCode" ErrorMessage="Inventory Amortization No Required"></asp:RequiredFieldValidator>
                </div>
              </div>
            </div>
          </div>
          <div class="row">
            <div class="col-sm-6">
              <div class="form-group">
                <label class="col-sm-4">Po No</label>
                <div class="col-sm-4">
                  <cc1:XUITextBox ID="lblPoNo" CssClass="form-control" Enabled=false runat="server" DBColumnName="PO_NO" DataType="String" BindType="DBToUIOnly" Text="--"></cc1:XUITextBox>
                </div>
              </div>
            </div>
            <div class="col-sm-6">
              <div class="form-group">
                <label class="col-sm-4">Amortization Date</label>
                <div class="col-sm-4">
                  <cc1:XUITextBox ID="txtAmortizationDate" Enabled=false runat="server" CssClass="form-control default-date-picker" placeholder="Amortization Date" DBColumnName="AMORTIZATION_DATE" SPParameterName="p_amortization_date" MaxLength="10" DataType="Datetime" BindType="Both" Format="dd/MM/yyyy"></cc1:XUITextBox>
                </div>
              </div>
            </div>
          </div>
          <div class="row">
            <div class="col-sm-6">
              <div class="form-group">
                <label class="col-sm-4">Barcode</label>
                <div class="col-sm-4">
                  <cc1:XUITextBox ID="txtBarcode" runat="server" Enabled="false" CssClass="form-control" placeholder="Inventory Barcode" DBColumnName="INVENTORY_BARCODE" SPParameterName="p_inventory_barcode" DataType="String" BindType="Both"></cc1:XUITextBox>
                </div>
              </div>
            </div>
            <div class="col-sm-6">
              <div class="form-group">
                <label class="col-sm-4">Amount Prepaid</label>
                <div class="col-sm-4">
                  <cc1:XUITextBox ID="txtUnitPrice" Enabled="false" runat="server" CssClass="form-control" placeholder="Amount Prepaid" DBColumnName="UNITE_PRICE" DataType="Number" Format="N2" BindType="DBToUIOnly"></cc1:XUITextBox>
                  <cc1:XUILabel ID="lblAmountAmort" runat="server" CssClass="form-control" Enabled="false" placeholder="Total Amount" DBColumnName="UNITE_PRICE" SPParameterName="p_unite_price" MaxLength="15" DataType="Number" Text="0.00" Format="N2" BindType="DBToUIOnly" style="display:none"></cc1:XUILabel>
                </div>
              </div>
            </div>
          </div>
          <div class="row">
            <div class="col-sm-6">
              <div class="form-group">
                <label class="col-sm-4">Item</label>
                <div class="col-sm-4">
                  <cc1:XUITextBox ID="txtItemCode" runat="server" CssClass="form-control" placeholder="Item Code" DBColumnName="ITEM_CODE" SPParameterName="p_item_code" DataType="String" BindType="Both" style="display:none;"></cc1:XUITextBox>
                  <cc1:XUITextBox ID="txtItemName" runat="server" Enabled="false" CssClass="form-control" placeholder="Item Name" DBColumnName="ITEM_NAME" SPParameterName="p_item_name" DataType="String" BindType="Both"></cc1:XUITextBox>
                </div>
              </div>
            </div>
            <div class="col-sm-6">
              <div class="form-group">
                <label class="col-sm-4">Period / Month</label>
                <div class="col-sm-4">
                  <cc1:XUITextBox ID="txtPeriod" runat="server" Enabled="false" CssClass="form-control" placeholder="Period" DBColumnName="PERIOD" SPParameterName="p_period" DataType="Integer" BindType="Both" AutoPostBack="true"></cc1:XUITextBox>
                </div>
              </div>
            </div>
          </div>
          <div class="row">
            <div class="col-sm-6">
              <div class="form-group">
                <label class="col-sm-4">Accrue %</label>
                <div class="col-sm-4">
                  <cc1:XUITextBox ID="txtAccruePct" Enabled="false" runat="server" CssClass="form-control" DBColumnName="ACCRUED_PCT" SPParameterName="p_accrued_pct" DataType="Number" Format="N2" BindType="Both"></cc1:XUITextBox>
                </div>
              </div>
            </div>
            <div class="col-sm-6">
              <div class="form-group">
                <label class="col-sm-4">Accrue Amount</label>
                <div class="col-sm-4">
                  <cc1:XUITextBox ID="txtAccrueAmount" Enabled="false" runat="server" CssClass="form-control" DBColumnName="ACCRUED_AMOUNT" SPParameterName="p_accrued_amount" DataType="Number" Format="N2" BindType="Both"></cc1:XUITextBox>
                </div>
              </div>
            </div>
          </div>
          <div class="row">
            <div class="col-sm-6">
              <div class="form-group">
                <label class="col-sm-4">Start Contract Date</label>
                <div class="col-sm-4">
                  <cc1:XUITextBox ID="txtStartContractDate" Enabled="false" runat="server" CssClass="form-control default-date-picker" placeholder="Start Contract Date" DBColumnName="START_CONTRACT_DATE" SPParameterName="p_start_contract_date" MaxLength="10" DataType="Datetime" BindType="Both" Format="dd/MM/yyyy"></cc1:XUITextBox>
                </div>
              </div>
            </div>
            <div class="col-sm-6">
              <div class="form-group">
                <label class="col-sm-4">End Contract Date </label>
                <div class="col-sm-4">
                  <cc1:XUITextBox ID="txtEndContractDate" Enabled="false" runat="server" CssClass="form-control default-date-picker" placeholder="End Contract Date" DBColumnName="END_CONTRACT_DATE" SPParameterName="p_end_contract_date" MaxLength="10" DataType="Datetime" BindType="Both" Format="dd/MM/yyyy"></cc1:XUITextBox>
                </div>
              </div>
            </div>
          </div>
          <div class="row">
            <div class="col-sm-6">
              <div class="form-group">
                <label class="col-sm-4">Remarks</label>
                <div class="col-sm-4">
                  <cc1:XUITextBox ID="txtRemarks" runat="server" CssClass="form-control" placeholder="Remarks" DBColumnName="REMARKS" SPParameterName="p_remarks" DataType="String" BindType="Both" MaxLength="4000" TextMode="MultiLine" Height="58px"></cc1:XUITextBox>
                  <asp:RegularExpressionValidator runat="server" ID="valInput" ControlToValidate="txtRemarks" ValidationExpression="^[\s\S]{0,4000}$" ErrorMessage="Exceed maximum length 400" Display="Dynamic"></asp:RegularExpressionValidator>
                </div>
              </div>
            </div>
            <div class="col-sm-6">
              <div class="form-group">
                <label class="col-sm-4">Refund Post Date</label>
                <div class="col-sm-4">
                  <cc1:XUITextBox ID="txtRefundPostDate" Enabled="false" runat="server" CssClass="form-control" placeholder="Refund Post Date" DBColumnName="POST_DATE" SPParameterName="p_post_date" MaxLength="10" DataType="Datetime" BindType="Both" Format="dd/MM/yyyy"></cc1:XUITextBox>
                </div>
              </div>
            </div>
          </div>
          <div class="row">
            <div class="col-sm-6">
              <div class="form-group">
                <label class="col-sm-4">With Actual Cash Inflow</label>
                <div class="col-sm-4">
                  <cc1:XUIDropDownList ID="ddlActualCashInflow" runat="server" Width="200px" CssClass="form-control" DBColumnName="IS_ACTUAL_CASH_INFLOW" SPParameterName="p_is_actual_cash_inflow" DataType="String" BindType="Both" AutoPostBack="true" OnSelectedIndexChanged="ddlActualCashInflow_SelectedIndexChanged" >
                    <asp:ListItem Value="1">YES</asp:ListItem>
                    <asp:ListItem Value="0">NO</asp:ListItem>
                  </cc1:XUIDropDownList>
                </div>
              </div>
            </div>
            <div class="col-sm-6">
              <div class="form-group">
                <label class="col-sm-4">Paid Status</label>
                <div class="col-sm-4">
                  <cc1:XUILabel ID="lblPaidStatus" runat="server" Enabled=false DBColumnName="PAID_STATUS" DataType="String" BindType="DBToUIOnly"></cc1:XUILabel>
                </div>
              </div>
            </div>
          </div>
          <div class="row">
            <div class="col-sm-6">
              <div class="form-group">
                <label class="col-sm-4">Original Refund Amount</label>
                <div class="col-sm-4">
                  <cc1:XUITextBox ID="txtOriginalRefundAmount" Enabled="false" runat="server" CssClass="form-control" DBColumnName="ORIGINAL_REFUND_AMOUNT" SPParameterName="p_original_refund_amount" DataType="Number" Format="N2" BindType="Both"></cc1:XUITextBox>
                </div>
              </div>
            </div>
            <div class="col-sm-6">
              <div class="form-group">
                <label class="col-sm-4">Jurnal ID Receive</label>
                <div class="col-sm-4">
                  <cc1:XUITextBox ID="txtJurnalId" runat="server" Enabled="false" CssClass="form-control" placeholder="Jurnal ID Receive" DBColumnName="jurnal_id" SPParameterName="p_jurnal_id" DataType="String" BindType="Both"></cc1:XUITextBox>
                </div>
              </div>
            </div>
          </div>
          <div class="row">
            <div class="col-sm-6">
              <div class="form-group">
                <label class="col-sm-4">Refund Amount</label>
                <div class="col-sm-4">
                  <cc1:XUITextBox ID="txtRefundAmount" runat="server" CssClass="form-control" DBColumnName="REFUND_AMOUNT" SPParameterName="p_refund_amount" DataType="Number" Format="N2" BindType="Both"></cc1:XUITextBox>
                </div>
              </div>
            </div>
            <div class="col-sm-6">
              <div class="form-group">
                <label class="col-sm-4">Non-Refunded Amount(Expense)</label>
                <div class="col-sm-4">
                  <cc1:XUITextBox ID="txtNonRefundAmount" Enabled="false" runat="server" CssClass="form-control" DBColumnName="NON_REFUND_AMOUNT" SPParameterName="p_non_refund_amount" DataType="Number" Format="N2" BindType="Both"></cc1:XUITextBox>
                </div>
              </div>
            </div>
          </div>
          <div class="row">
            <div class="col-sm-6">
              <div class="form-group">
                <label class="col-sm-4">Created</label>
                <div class="col-sm-8">
                  <cc1:XUILabel ID="lblCreby" runat="server" DBColumnName="EMP_CRE" DataType="String" BindType="DBToUIOnly"></cc1:XUILabel>
                  <span>@</span>
                  <cc1:XUILabel ID="lblCreDate" runat="server" DBColumnName="CRE_DATE" DataType="DateTime" BindType="DBToUIOnly" Format="dd/MM/yyyy HH:mm:ss"></cc1:XUILabel>
                </div>
              </div>
            </div>
            <div class="col-sm-6">
              <div class="form-group">
                <label class="col-sm-4">Modified</label>
                <div class="col-sm-8">
                  <cc1:XUILabel ID="lblModBy" runat="server" DBColumnName="EMP_MOD" DataType="String" BindType="DBToUIOnly"></cc1:XUILabel>
                  <span>@</span>
                  <cc1:XUILabel ID="lblModDate" runat="server" DBColumnName="MOD_DATE" DataType="DateTime" BindType="DBToUIOnly" Format="dd/MM/yyyy HH:mm:ss"></cc1:XUILabel>
                </div>
              </div>
            </div>
          </div>
        </ContentTemplate>
        <Triggers>
          <asp:AsyncPostBackTrigger ControlID="btnSave" EventName="Click" />
          <asp:AsyncPostBackTrigger ControlID="btnCancel" EventName="Click" />
        </Triggers>
      </asp:UpdatePanel>
    </div>
  </section>
  <asp:Panel runat="server" ID="pnlAmortization">
    <section class="panel">
      <header class="panel-heading tab-bg-dark-navy-blue">
        <ul class="nav nav-tabs nav-justified">
          <li class="active">
            <a href="#schedule" id="amortschedule" onclick="javascript:fnSetTab('amortschedule');" data-toggle="tab" style="padding-bottom:28px"> Amortization Schedule </a>
          </li>
          <li class="" runat="server" id="UploadDoc">
            <a href="#UploadDoc" id="A1" onclick="javascript:fnSetTab('uploadodc');" data-toggle="tab" style="padding-bottom:28px"> Upload Doc </a>
          </li>
        </ul>
      </header>
      <div class="panel-body">
        <div class="tab-content tasi-tab">
          <div class="tab-pane active" id="schedule">
            <div class="panel-heading">
              <div class="row">
                <div class="col-sm-8"></div>
                <div class="col-sm-4">
                  <asp:Panel ID="pnlSearch" runat="server" DefaultButton="btnSearch" class="input-group">
                    <asp:TextBox ID="txtSearch" runat="server" CssClass="form-control" placeholder="Keywords"></asp:TextBox>
                    <div class="input-group-btn">
                      <asp:LinkButton ID="btnSearch" runat="server" CssClass="btn btn-info" OnClick="btnSearch_Click" CausesValidation="false">
                        <i class="icon-search"></i> Search
                      </asp:LinkButton>
                    </div>
                  </asp:Panel>
                </div>
              </div>
            </div>
            <div class="panel-body">
              <asp:UpdatePanel ID="upd" runat="server">
                <ContentTemplate>
                  <asp:GridView ID="gvwList" runat="server" AutoGenerateColumns="false" CssClass="display table table-bordered table-striped" AllowPaging="true" PageSize="10" DataKeyNames="ID" OnPageIndexChanging="gvwList_PageIndexChanging" EmptyDataText="There Is No Data" Width="100%">
                    <Columns>
                      <asp:TemplateField>
                        <HeaderTemplate>
                          <span>No</span>
                        </HeaderTemplate>
                        <ItemTemplate><%# Container.DataItemIndex + 1 %> </ItemTemplate>
                      </asp:TemplateField>
                      <asp:BoundField DataField="PERIOD" HeaderText="Period">
                        <ItemStyle Width="20%" HorizontalAlign="Left" />
                      </asp:BoundField>
                      <asp:BoundField DataField="AMORTIZATION_DATE" HeaderText="Amortization Date" DataFormatString="{0:dd/MM/yyyy}">
                        <ItemStyle Width="35%" HorizontalAlign="Center" />
                      </asp:BoundField>
                      <asp:BoundField DataField="ACCRUED_AMOUNT" HeaderText="Accrue Amount" DataFormatString="{0:N0}">
                        <ItemStyle Width="35%" HorizontalAlign="Right" />
                      </asp:BoundField>
                      <asp:BoundField DataField="STATUS" HeaderText="Amortization Status">
                        <ItemStyle Width="10%" HorizontalAlign="Left" />
                      </asp:BoundField>
                    </Columns>
                  </asp:GridView>
                </ContentTemplate>
                <Triggers>
                  <asp:AsyncPostBackTrigger ControlID="btnSearch" EventName="Click" />
                </Triggers>
              </asp:UpdatePanel>
            </div>
          </div>
          <div class="tab-pane" id="UploadDoc">
            <div class="panel-heading">
              <div class="row">
                <div class="col-sm-8 ">
                  <cc1:XUILinkButton RoleCode="R90000153C" ID="btnAddUploadDoc" runat="server" CssClass="btn btn-primary" OnClick="btnAddUploadDoc_Click" CausesValidation="false">
                    <i class="icon-plus"></i> Create
                  </cc1:XUILinkButton>
                </div>
                <div class="col-sm-4 ">
                  <asp:Panel ID="pnlSearchDocReq" runat="server" DefaultButton="btnSearchDocReq" class="input-group">
                    <asp:TextBox ID="txtSearchDocReq" runat="server" CssClass="form-control"></asp:TextBox>
                    <div class="input-group-btn">
                      <asp:LinkButton ID="btnSearchDocReq" runat="server" CssClass="btn btn-info" OnClick="btnSearchDocReq_Click">
                        <i class="icon-search"></i> Search
                      </asp:LinkButton>
                    </div>
                  </asp:Panel>
                </div>
              </div>
            </div>
            <div class="panel-body">
              <asp:GridView ID="gvwListDocReq" runat="server" AutoGenerateColumns="false" CssClass="display table table-bordered table-striped" AllowPaging="true" PageSize="10" DataKeyNames="GENERAL_DOC_CODE, REFUND_CODE, PATHS, FILE, ID" OnPageIndexChanging="gvwListDocReq_PageIndexChanging" OnRowDataBound="gvwListDocReq_OnRowDataBound" OnRowCommand="gvwListDocReq_RowCommand" onselectedindexchanged="gvwListDocReq_SelectedIndexChanged" EmptyDataText="There is no data" AllowSorting="true">
                <Columns>
                  <asp:TemplateField>
                    <HeaderTemplate>
                      <span>No</span>
                    </HeaderTemplate>
                    <ItemTemplate><%# Container.DataItemIndex + 1 %> </ItemTemplate>
                  </asp:TemplateField>
                  <asp:BoundField DataField="DESCRIPTION" HeaderText="Document">
                    <ItemStyle Width="40%" HorizontalAlign="Center" />
                  </asp:BoundField>
                  <asp:TemplateField HeaderText="File Name">
                    <ItemStyle Width="60%" HorizontalAlign="Left" />
                    <ItemTemplate>
                      <asp:Label runat="server" Text='
						
												<%# Eval("PATHS") %>' ID="lblFileName" />
                      <br />
                    </ItemTemplate>
                  </asp:TemplateField>
                  <asp:TemplateField HeaderText="">
                    <ItemStyle Width="10%" HorizontalAlign="Left" />
                    <ItemTemplate>
                      <asp:LinkButton ID="btnPreviewDoc" runat="server" CausesValidation="false" Text="Preview" />
                    </ItemTemplate>
                  </asp:TemplateField>
                  <asp:TemplateField HeaderText="">
                    <ItemStyle Width="10%" HorizontalAlign="Left" />
                    <ItemTemplate>
                      <asp:LinkButton ID="btnDeleteDoc" runat="server" CausesValidation="false" Text="Delete" CommandName="del" />
                    </ItemTemplate>
                  </asp:TemplateField>
                </Columns>
              </asp:GridView>
            </div>
          </div>
        </div>
      </div>
  </asp:Panel>
</asp:Content>