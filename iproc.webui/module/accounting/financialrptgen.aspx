<%@ Page Title="" Language="C#" MasterPageFile="~/iproc.master" AutoEventWireup="true" CodeFile="financialrptgen.aspx.cs" Inherits="module_accounting_financialrptgen" %>

<%@ Register Assembly="MPF23.XUI" Namespace="MPF23.XUI.Control" TagPrefix="cc1" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc2"%>
<asp:Content ID="Content1" ContentPlaceHolderID="cph" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cpb" Runat="Server">

    <section class="panel">
        <header class="panel-heading">
          <span>Financial Report Info</span>
        </header>
        <div class="panel-heading">
            <div class="row">
                <div class="col-sm-12">
                     <cc1:XUILinkButton RoleCode="R12000030E" ID="btnSave" runat="server" CssClass="btn btn-primary" OnClick="btnSave_Click" CausesValidation="true"><i class="icon-save"></i>  Save</cc1:XUILinkButton>
                     <cc1:XUILinkButton RoleCode="" ID="btnCancel" runat="server" CssClass="btn btn-danger" OnClick="btnCancel_Click" CausesValidation="false"><i class="icon-remove"></i>  Cancel</cc1:XUILinkButton>
                </div>
            </div>
         </div>
        <div class="panel-body form-horizontal">
        <asp:UpdatePanel ID="UpdatePanel2" runat="server">
            <ContentTemplate>
                    <div class="row">
                <div class="col-sm-12">
                    <div class="form-group">
                        <label class="col-sm-2">Code *</label>
                        <div class="col-sm-2">
                            <cc1:XUITextBox ID="txtCode" runat="server" CssClass="form-control" placeholder="Code" DBColumnName="CODE" SPParameterName="p_code" MaxLength="15" DataType="String" BindType="Both"></cc1:XUITextBox>
                                <asp:RequiredFieldValidator ID="rfvCode" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtCode" Display="Dynamic"></asp:RequiredFieldValidator>
                      </div>
                    </div>                            
                </div>
            </div>
                    <div class="row">  
                <div class="col-sm-12">
                    <div class="form-group">
                        <label class="col-sm-2">Currency</label>
                        <div class="col-sm-2">
                            <cc1:XUIDropDownList ID="ddlCurrencyCode" runat="server" CssClass="form-control" DBColumnName="CURRENCY" SPParameterName="p_currency" DataType="String" BindType="Both"></cc1:XUIDropDownList>
                        </div>
                    </div>                            
                </div>
            </div>
                    <div class="row">
                <div class="col-sm-12">
                    <div class="form-group">
                        <label class="col-sm-2">Description *</label>
                        <div class="col-sm-4">
                            <cc1:XUITextBox ID="txtDescription" runat="server" CssClass="form-control" placeholder="Description" DBColumnName="DESCRIPTION" SPParameterName="p_description" MaxLength="50" DataType="String" BindType="Both" TextMode="MultiLine"></cc1:XUITextBox>
                            <asp:RequiredFieldValidator ID="rfvDescription" ErrorMessage="Required Field!" runat="server" ControlToValidate="txtDescription" Display="Dynamic"></asp:RequiredFieldValidator>
                            <asp:RegularExpressionValidator runat="server" ID="valInput" ControlToValidate="txtDescription" ValidationExpression="^[\s\S]{0,50}$" ErrorMessage="Exceed maximum length 50" Display="Dynamic"></asp:RegularExpressionValidator>
                        </div>
                    </div>                            
                </div>
            </div>
                    <div class="row">
                <div class="col-sm-12">
                    <div class="form-group">
                        <label class="col-sm-2">Title *</label>
                        <div class="col-sm-4">
                            <cc1:XUITextBox ID="txtTitle" runat="server" CssClass="form-control" placeholder="Report Title" DBColumnName="TITLE" SPParameterName="p_title" MaxLength="50" DataType="String" BindType="Both" TextMode="MultiLine"></cc1:XUITextBox>
                            <asp:RequiredFieldValidator ID="rvfTitle"  ErrorMessage="Required Field!" runat="server" ControlToValidate="txtTitle" Display="Dynamic"></asp:RequiredFieldValidator>
                            <asp:RegularExpressionValidator runat="server" ID="revTitle" ControlToValidate="txtTitle" ValidationExpression="^[\s\S]{0,50}$" ErrorMessage="Exceed maximum length 50" Display="Dynamic"></asp:RegularExpressionValidator>
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
      
      <asp:Panel runat="server" ID="pnlFinance">
      <section class="panel">
        <header class="panel-heading tab-bg-dark-navy-blue">
            <asp:TextBox ID="txtTabCode" runat="server" style="display:none"></asp:TextBox>
            <ul class="nav nav-tabs nav-justified">
              <li class="active">
                  <a href="#column" id="reportcolumn" onclick="javascript:fnSetTab('reportcolumn');" data-toggle="tab">
                      Column
                  </a>
              </li>
              <li class="">
                  <a href="#Row" id="reportrow" onclick="javascript:fnSetTab('reportrow');" data-toggle="tab">
                      Row
                  </a>
              </li>
            </ul>
        </header>
        
        <div class="panel-body">                    
        <div class="tab-content tasi-tab">
        <div class="tab-pane active" id="column">
            <header class="panel-heading">
              <%--<span>Sub-Facility List</span>--%>
            </header>
            <div class="panel-heading">
                <div class="row">
                    <div class="col-sm-4">
                    </div>
                   <div class="col-sm-8">
                        <div class="form-group">
                            <label class="col-sm-2">Formula:</label>   
                            <div class="col-sm-8">  
                                <cc1:XUIDropDownList ID="ddlFormula" runat="server" CssClass="form-control" SPParameterName="p_formula" DataType="String" BindType="UIToDBOnly">                                
                                </cc1:XUIDropDownList>
                            </div>
                            <div class="col-sm-1">
                                <cc1:XUILinkButton RoleCode="R12000030E" ID="btnSaveColumn" runat="server" CssClass="btn btn-primary" OnClick="btnSaveColumn_Click"><i class="icon-save"></i>  Save</cc1:XUILinkButton>
                            </div>
                       </div>
                    </div>
                 </div>
             </div>
             <div class="panel-body">
             <%--<cc1:XUILabel ID="lblCol" runat="server" DBColumnName="COL_NO" SPParameterName="p_col_no" DataType="Integer" BindType="DBToUIOnly" style="display:none"></cc1:XUILabel>--%>
               <div class="row">
                  <div class="col-sm-3">
                     <div class="form-group">
                        <label class="col-sm-1">Column</label>
                     </div>
                  </div>
                  <div class="col-sm-3">
                     <div class="form-group" >
                        <label class="col-sm-3">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Header</label>
                     </div>
                  </div>
                  <div class="col-sm-3">
                     <div class="form-group">
                        <label class="col-sm-1">Format</label>
                     </div>
                  </div>
                  <div class="col-sm-3">
                     <div class="form-group">
                        <label class="col-sm-1">Formula</label>
                     </div>
                  </div>
               </div>
               <div class="row">
                  <div class="col-sm-2" >
                     <div class="form-group">
                        <label class="col-sm-6" style="text-align:center;">1</label>
                     </div>
                  </div>
                  <div class="col-sm-1">
                     <div class="form-group">
                        <asp:RadioButton ID="rbl1" SPParameterName="p_rbl1" runat="server" RepeatDirection="Horizontal" GroupName="rblFormula" OnCheckedChanged="Formula_CheckedChanged" >
                             <%--<asp:ListItem Value="1" Text=" "></asp:ListItem>--%>
                        </asp:RadioButton>
                     </div>
                  </div>
                  <div class="col-sm-2">
                     <div class="form-group">
                        <cc1:XUITextBox ID="txtHeader1" runat="server" CssClass="form-control" SPParameterName="p_header1" DBColumnName="HEADER_1"  DataType="String" BindType="Both" MaxLength="25"></cc1:XUITextBox>
                     </div>
                  </div>
                  <div class="col-sm-3">
                     <div class="form-group">
                            <cc1:XUITextBox ID="txtFormat1" runat="server" CssClass="form-control" DBColumnName="FORMAT_1" SPParameterName="p_format1" DataType="Number" BindType="Both" Format="N2" MaxLength="18">
                            </cc1:XUITextBox>
                     </div>
                  </div>
                  <div class="col-sm-4">
                     <div class="form-group">
                        <cc1:XUITextBox ID="txtFormula1" runat="server" CssClass="form-control" OnTextChanged="txtOnTextChanged" DBColumnName="FORMULA_1" SPParameterName="p_formula1" DataType="String" BindType="Both" MaxLength="50">
                        </cc1:XUITextBox>
                     </div>
                  </div>
               </div>
                <div class="row">
                  <div class="col-sm-2" >
                     <div class="form-group">
                        <label class="col-sm-6" style="text-align:center;">2</label>
                     </div>
                  </div>
                  <div class="col-sm-1">
                     <div class="form-group">
                       <asp:RadioButton ID="rbl2" SPParameterName="p_rbl2" runat="server" RepeatDirection="Horizontal" GroupName="rblFormula" OnCheckedChanged="Formula_CheckedChanged" >
                           <%--  <asp:ListItem Value="1" Text=" "></asp:ListItem>--%>
                        </asp:RadioButton>
                     </div>
                  </div>
                  <div class="col-sm-2">
                     <div class="form-group">
                        <cc1:XUITextBox ID="txtHeader2" runat="server" CssClass="form-control" SPParameterName="p_header2" DBColumnName="HEADER_2" DataType="String" BindType="Both" MaxLength="25"></cc1:XUITextBox>
                     </div>
                  </div>
                  <div class="col-sm-3">
                     <div class="form-group">
                        <cc1:XUITextBox ID="txtFormat2" runat="server" CssClass="form-control" DBColumnName="FORMAT_2" SPParameterName="p_format2" DataType="Number" BindType="Both" Format="N2" MaxLength="18">
                        </cc1:XUITextBox>
                     </div>
                  </div>
                  <div class="col-sm-4">
                     <div class="form-group">
                        <cc1:XUITextBox ID="txtFormula2" runat="server" CssClass="form-control" OnTextChanged="txtOnTextChanged" DBColumnName="FORMULA_2" SPParameterName="p_formula2" DataType="String" BindType="Both" MaxLength="50">
                        </cc1:XUITextBox>
                     </div>
                  </div>
               </div>
               <div class="row">
                  <div class="col-sm-2" >
                     <div class="form-group">
                        <label class="col-sm-6" style="text-align:center;">3</label>
                     </div>
                  </div>
                  <div class="col-sm-1">
                     <div class="form-group">
                        <asp:RadioButton ID="rbl3" SPParameterName="p_rbl3" runat="server" RepeatDirection="Horizontal" GroupName="rblFormula" OnCheckedChanged="Formula_CheckedChanged" >
                           <%--  <asp:ListItem Value="1" Text=" "></asp:ListItem>--%>
                        </asp:RadioButton>
                     </div>
                  </div>
                  <div class="col-sm-2">
                     <div class="form-group">
                        <cc1:XUITextBox ID="txtHeader3" runat="server" CssClass="form-control" SPParameterName="p_header3" DBColumnName="HEADER_3" DataType="String" BindType="Both" MaxLength="25"></cc1:XUITextBox>
                     </div>
                  </div>
                  <div class="col-sm-3">
                     <div class="form-group">
                        <cc1:XUITextBox ID="txtFormat3" runat="server" CssClass="form-control" DBColumnName="FORMAT_3" SPParameterName="p_format3" DataType="Number" BindType="Both" Format="N2" MaxLength="18">
                        </cc1:XUITextBox>
                     </div>
                  </div>
                  <div class="col-sm-4">
                     <div class="form-group">
                        <cc1:XUITextBox ID="txtFormula3" runat="server" CssClass="form-control" OnTextChanged="txtOnTextChanged" DBColumnName="FORMULA_3" SPParameterName="p_formula3" DataType="String" BindType="Both" MaxLength="50">
                        </cc1:XUITextBox>
                     </div>
                  </div>
               </div>
               <div class="row">
                  <div class="col-sm-2" >
                     <div class="form-group">
                        <label class="col-sm-6" style="text-align:center;">4</label>
                     </div>
                  </div>
                  <div class="col-sm-1">
                     <div class="form-group">
                       <asp:RadioButton ID="rbl4" SPParameterName="p_rbl4" runat="server" RepeatDirection="Horizontal" GroupName="rblFormula" OnCheckedChanged="Formula_CheckedChanged" >
                           <%--  <asp:ListItem Value="1" Text=" "></asp:ListItem>--%>
                        </asp:RadioButton>
                     </div>
                  </div>
                  <div class="col-sm-2">
                     <div class="form-group">
                        <cc1:XUITextBox ID="txtHeader4" runat="server" CssClass="form-control" SPParameterName="p_header4" DBColumnName="HEADER_4" DataType="String" BindType="Both" MaxLength="25"></cc1:XUITextBox>
                     </div>
                  </div>
                  <div class="col-sm-3">
                     <div class="form-group">
                        <cc1:XUITextBox ID="txtFormat4" runat="server" CssClass="form-control" DBColumnName="FORMAT_4" SPParameterName="p_format4" DataType="Number" BindType="Both" Format="N2" MaxLength="18">
                        </cc1:XUITextBox>
                     </div>
                  </div>
                  <div class="col-sm-4">
                     <div class="form-group">
                        <cc1:XUITextBox ID="txtFormula4" runat="server" CssClass="form-control" OnTextChanged="txtOnTextChanged" DBColumnName="FORMULA_4" SPParameterName="p_formula4" DataType="String" BindType="Both" MaxLength="50">
                        </cc1:XUITextBox>
                     </div>
                  </div>
               </div>
               <div class="row">
                  <div class="col-sm-2" >
                     <div class="form-group">
                        <label class="col-sm-6" style="text-align:center;">5</label>
                     </div>
                  </div>
                  <div class="col-sm-1">
                     <div class="form-group">
                       <asp:RadioButton ID="rbl5" SPParameterName="p_rbl5" runat="server" RepeatDirection="Horizontal" GroupName="rblFormula" OnCheckedChanged="Formula_CheckedChanged" >
                           <%--  <asp:ListItem Value="1" Text=" "></asp:ListItem>--%>
                        </asp:RadioButton>
                     </div>
                  </div>
                  <div class="col-sm-2">
                     <div class="form-group">
                        <cc1:XUITextBox ID="txtHeader5" runat="server" CssClass="form-control" SPParameterName="p_header5" DBColumnName="HEADER_5" DataType="String" BindType="Both" MaxLength="25"></cc1:XUITextBox>
                     </div>
                  </div>
                  <div class="col-sm-3">
                     <div class="form-group">
                        <cc1:XUITextBox ID="txtFormat5" runat="server" CssClass="form-control" DBColumnName="FORMAT_5" SPParameterName="p_format5" DataType="Number" BindType="Both" Format="N2" MaxLength="18">
                        </cc1:XUITextBox>
                     </div>
                  </div>
                  <div class="col-sm-4">
                     <div class="form-group">
                        <cc1:XUITextBox ID="txtFormula5" runat="server" CssClass="form-control" OnTextChanged="txtOnTextChanged" DBColumnName="FORMULA_5" SPParameterName="p_formula5" DataType="String" BindType="Both" MaxLength="50">
                        </cc1:XUITextBox>
                     </div>
                  </div>
               </div<div class="row">
                  <div class="col-sm-2" >
                     <div class="form-group">
                        <label class="col-sm-6" style="text-align:center;">6</label>
                     </div>
                  </div>
                  <div class="col-sm-1">
                     <div class="form-group">
                       <asp:RadioButton ID="rbl6" SPParameterName="p_rbl6" runat="server" RepeatDirection="Horizontal" GroupName="rblFormula" OnCheckedChanged="Formula_CheckedChanged" >
                           <%--  <asp:ListItem Value="1" Text=" "></asp:ListItem>--%>
                        </asp:RadioButton>
                     </div>
                  </div>
                  <div class="col-sm-2">
                     <div class="form-group">
                        <cc1:XUITextBox ID="txtHeader6" runat="server" CssClass="form-control" SPParameterName="p_header6" DBColumnName="HEADER_6" DataType="String" BindType="Both" MaxLength="25"></cc1:XUITextBox>
                     </div>
                  </div>
                  <div class="col-sm-3">
                     <div class="form-group">
                        <cc1:XUITextBox ID="txtFormat6" runat="server" CssClass="form-control" DBColumnName="FORMAT_6" SPParameterName="p_format6" DataType="Number" BindType="Both" Format="N2" MaxLength="18">
                        </cc1:XUITextBox>
                     </div>
                  </div>
                  <div class="col-sm-4">
                     <div class="form-group">
                        <cc1:XUITextBox ID="txtFormula6" runat="server" CssClass="form-control" OnTextChanged="txtOnTextChanged" DBColumnName="FORMULA_6" SPParameterName="p_formula6" DataType="String" BindType="Both" MaxLength="50">
                        </cc1:XUITextBox>
                     </div>
                  </div>
               </div>
               <div class="row">
                  <div class="col-sm-2" >
                     <div class="form-group">
                        <label class="col-sm-6" style="text-align:center;">7</label>
                     </div>
                  </div>
                  <div class="col-sm-1">
                     <div class="form-group">
                        <asp:RadioButton ID="rbl7" SPParameterName="p_rbl7" runat="server" RepeatDirection="Horizontal" GroupName="rblFormula" OnCheckedChanged="Formula_CheckedChanged" >
                           <%--  <asp:ListItem Value="1" Text=" "></asp:ListItem>--%>
                        </asp:RadioButton>
                     </div>
                  </div>
                  <div class="col-sm-2">
                     <div class="form-group">
                        <cc1:XUITextBox ID="txtHeader7" runat="server" CssClass="form-control" SPParameterName="p_header7" DBColumnName="HEADER_7" DataType="String" BindType="Both" MaxLength="25"></cc1:XUITextBox>
                     </div>
                  </div>
                  <div class="col-sm-3">
                     <div class="form-group">
                        <cc1:XUITextBox ID="txtFormat7" runat="server" CssClass="form-control" DBColumnName="FORMAT_7" SPParameterName="p_format7" DataType="Number" BindType="Both" Format="N2" MaxLength="18">
                        </cc1:XUITextBox>
                     </div>
                  </div>
                  <div class="col-sm-4">
                     <div class="form-group">
                        <cc1:XUITextBox ID="txtFormula7" runat="server" CssClass="form-control" OnTextChanged="txtOnTextChanged" DBColumnName="FORMULA_7" SPParameterName="p_formula7" DataType="String" BindType="Both" MaxLength="50">
                        </cc1:XUITextBox>
                     </div>
                  </div>
               </div>
               <div class="row">
                  <div class="col-sm-2" >
                     <div class="form-group">
                        <label class="col-sm-6" style="text-align:center;">8</label>
                     </div>
                  </div>
                  <div class="col-sm-1">
                     <div class="form-group">
                       <asp:RadioButton ID="rbl8" SPParameterName="p_rbl8" runat="server" RepeatDirection="Horizontal" GroupName="rblFormula" OnCheckedChanged="Formula_CheckedChanged" >
                           <%--  <asp:ListItem Value="1" Text=" "></asp:ListItem>--%>
                        </asp:RadioButton>
                     </div>
                  </div>
                  <div class="col-sm-2">
                     <div class="form-group">
                        <cc1:XUITextBox ID="txtHeader8" runat="server" CssClass="form-control" SPParameterName="p_header8" DBColumnName="HEADER_8" DataType="String" BindType="Both" MaxLength="25"></cc1:XUITextBox>
                     </div>
                  </div>
                  <div class="col-sm-3">
                     <div class="form-group">
                        <cc1:XUITextBox ID="txtFormat8" runat="server" CssClass="form-control" DBColumnName="FORMAT_8" SPParameterName="p_format8" DataType="Number" BindType="Both" Format="N2" MaxLength="18">
                        </cc1:XUITextBox>
                     </div>
                  </div>
                  <div class="col-sm-4">
                     <div class="form-group">
                        <cc1:XUITextBox ID="txtFormula8" runat="server" CssClass="form-control" OnTextChanged="txtOnTextChanged" DBColumnName="FORMULA_8" SPParameterName="p_formula8" DataType="String" BindType="Both" MaxLength="50">
                        </cc1:XUITextBox>
                     </div>
                  </div>
               </div>
               <div class="row">
                  <div class="col-sm-2" >
                     <div class="form-group">
                        <label class="col-sm-6" style="text-align:center;">9</label>
                     </div>
                  </div>
                  <div class="col-sm-1">
                     <div class="form-group">
                       <asp:RadioButton ID="rbl9" SPParameterName="p_rbl9" runat="server" RepeatDirection="Horizontal" GroupName="rblFormula" OnCheckedChanged="Formula_CheckedChanged" >
                           <%--  <asp:ListItem Value="1" Text=" "></asp:ListItem>--%>
                        </asp:RadioButton>
                     </div>
                  </div>
                  <div class="col-sm-2">
                     <div class="form-group">
                        <cc1:XUITextBox ID="txtHeader9" runat="server" CssClass="form-control" SPParameterName="p_header9" DBColumnName="HEADER_9" DataType="String" BindType="Both" MaxLength="25"></cc1:XUITextBox>
                     </div>
                  </div>
                  <div class="col-sm-3">
                     <div class="form-group">
                        <cc1:XUITextBox ID="txtFormat9" runat="server" CssClass="form-control" DBColumnName="FORMAT_9" SPParameterName="p_format9" DataType="Number" BindType="Both" Format="N2" MaxLength="18">
                        </cc1:XUITextBox>
                     </div>
                  </div>
                  <div class="col-sm-4">
                     <div class="form-group">
                        <cc1:XUITextBox ID="txtFormula9" runat="server" CssClass="form-control" OnTextChanged="txtOnTextChanged" DBColumnName="FORMULA_9" SPParameterName="p_formula9" DataType="String" BindType="Both" MaxLength="50">
                        </cc1:XUITextBox>
                     </div>
                  </div>
               </div<div class="row">
                  <div class="col-sm-2" >
                     <div class="form-group">
                        <label class="col-sm-6" style="text-align:center;">10</label>
                     </div>
                  </div>
                  <div class="col-sm-1">
                     <div class="form-group">
                       <asp:RadioButton ID="rbl10" SPParameterName="p_rbl10" runat="server" RepeatDirection="Horizontal" GroupName="rblFormula" OnCheckedChanged="Formula_CheckedChanged" >
                           <%--  <asp:ListItem Value="1" Text=" "></asp:ListItem>--%>
                        </asp:RadioButton>
                     </div>
                  </div>
                  <div class="col-sm-2">
                     <div class="form-group">
                        <cc1:XUITextBox ID="txtHeader10" runat="server" CssClass="form-control" SPParameterName="p_header10" DBColumnName="HEADER_10" DataType="String" BindType="Both" MaxLength="25"></cc1:XUITextBox>
                     </div>
                  </div>
                  <div class="col-sm-3">
                     <div class="form-group">
                        <cc1:XUITextBox ID="txtFormat10" runat="server" CssClass="form-control" DBColumnName="FORMAT_10" SPParameterName="p_format10" DataType="Number" BindType="Both" Format="N2" MaxLength="18">
                        </cc1:XUITextBox>
                     </div>
                  </div>
                  <div class="col-sm-4">
                     <div class="form-group">
                        <cc1:XUITextBox ID="txtFormula10" runat="server" CssClass="form-control" OnTextChanged="txtOnTextChanged" DBColumnName="FORMULA_10" SPParameterName="p_formula10" DataType="String" BindType="Both" MaxLength="50">
                        </cc1:XUITextBox>
                     </div>
                  </div>
               </div>
               <div class="row">
                  <div class="col-sm-2" >
                     <div class="form-group">
                        <label class="col-sm-6" style="text-align:center;">11</label>
                     </div>
                  </div>
                  <div class="col-sm-1">
                     <div class="form-group">
                        <asp:RadioButton ID="rbl11" SPParameterName="p_rbl11" runat="server" RepeatDirection="Horizontal" GroupName="rblFormula" OnCheckedChanged="Formula_CheckedChanged" >
                           <%--  <asp:ListItem Value="1" Text=" "></asp:ListItem>--%>
                        </asp:RadioButton>
                     </div>
                  </div>
                  <div class="col-sm-2">
                     <div class="form-group">
                        <cc1:XUITextBox ID="txtHeader11" runat="server" CssClass="form-control" SPParameterName="p_header11" DBColumnName="HEADER_11" DataType="String" BindType="Both" MaxLength="25"></cc1:XUITextBox>
                     </div>
                  </div>
                  <div class="col-sm-3">
                     <div class="form-group">
                        <cc1:XUITextBox ID="txtFormat11" runat="server" CssClass="form-control" DBColumnName="FORMAT_11" SPParameterName="p_format11" DataType="Number" BindType="Both" Format="N2" MaxLength="18">
                        </cc1:XUITextBox>
                     </div>
                  </div>
                  <div class="col-sm-4">
                     <div class="form-group">
                        <cc1:XUITextBox ID="txtFormula11" runat="server" CssClass="form-control" OnTextChanged="txtOnTextChanged" DBColumnName="FORMULA_11" SPParameterName="p_formula11" DataType="String" BindType="Both" MaxLength="50">
                        </cc1:XUITextBox>
                     </div>
                  </div>
               </div>
               <div class="row">
                  <div class="col-sm-2" >
                     <div class="form-group">
                        <label class="col-sm-6" style="text-align:center;">12</label>
                     </div>
                  </div>
                  <div class="col-sm-1">
                     <div class="form-group">
                       <asp:RadioButton ID="rbl12" SPParameterName="p_rbl12" runat="server" RepeatDirection="Horizontal" GroupName="rblFormula" OnCheckedChanged="Formula_CheckedChanged" >
                           <%--  <asp:ListItem Value="1" Text=" "></asp:ListItem>--%>
                        </asp:RadioButton>
                     </div>
                  </div>
                  <div class="col-sm-2">
                     <div class="form-group">
                        <cc1:XUITextBox ID="txtHeader12" runat="server" CssClass="form-control" SPParameterName="p_header12" DBColumnName="HEADER_12" DataType="String" BindType="Both" MaxLength="25"></cc1:XUITextBox>
                     </div>
                  </div>
                  <div class="col-sm-3">
                     <div class="form-group">
                        <cc1:XUITextBox ID="txtFormat12" runat="server" CssClass="form-control" DBColumnName="FORMAT_12" SPParameterName="p_format12" DataType="Number" BindType="Both" Format="N2" MaxLength="18">
                        </cc1:XUITextBox>
                     </div>
                  </div>
                  <div class="col-sm-4">
                     <div class="form-group">
                        <cc1:XUITextBox ID="txtFormula12" runat="server" CssClass="form-control" OnTextChanged="txtOnTextChanged" DBColumnName="FORMULA_12" SPParameterName="p_formula12" DataType="String" BindType="Both" MaxLength="50">
                        </cc1:XUITextBox>
                     </div>
                  </div>
               </div>
               <div class="row">
                  <div class="col-sm-2" >
                     <div class="form-group">
                        <label class="col-sm-6" style="text-align:center;">13</label>
                     </div>
                  </div>
                  <div class="col-sm-1">
                     <div class="form-group">
                        <asp:RadioButton ID="rbl13" SPParameterName="p_rbl13" runat="server" RepeatDirection="Horizontal" GroupName="rblFormula" OnCheckedChanged="Formula_CheckedChanged" >
                           <%--  <asp:ListItem Value="1" Text=" "></asp:ListItem>--%>
                        </asp:RadioButton>
                     </div>
                  </div>
                  <div class="col-sm-2">
                     <div class="form-group">
                        <cc1:XUITextBox ID="txtHeader13" runat="server" CssClass="form-control" SPParameterName="p_header13" DBColumnName="HEADER_13" DataType="String" BindType="Both" MaxLength="25"></cc1:XUITextBox>
                     </div>
                  </div>
                  <div class="col-sm-3">
                     <div class="form-group">
                        <cc1:XUITextBox ID="txtFormat13" runat="server" CssClass="form-control" DBColumnName="FORMAT_13" SPParameterName="p_format13" DataType="Number" BindType="Both" Format="N2" MaxLength="18">
                        </cc1:XUITextBox>
                     </div>
                  </div>
                  <div class="col-sm-4">
                     <div class="form-group">
                        <cc1:XUITextBox ID="txtFormula13" runat="server" CssClass="form-control" OnTextChanged="txtOnTextChanged" DBColumnName="FORMULA_13" SPParameterName="p_formula13" DataType="String" BindType="Both" MaxLength="50">
                        </cc1:XUITextBox>
                     </div>
                  </div>
               </div>
               <div class="row">
                  <div class="col-sm-2" >
                     <div class="form-group">
                        <label class="col-sm-6" style="text-align:center;">14</label>
                     </div>
                  </div>
                  <div class="col-sm-1">
                     <div class="form-group">
                        <asp:RadioButton ID="rbl14" SPParameterName="p_rbl14" runat="server" RepeatDirection="Horizontal" GroupName="rblFormula" OnCheckedChanged="Formula_CheckedChanged" >
                           <%--  <asp:ListItem Value="1" Text=" "></asp:ListItem>--%>
                        </asp:RadioButton>
                     </div>
                  </div>
                  <div class="col-sm-2">
                     <div class="form-group">
                        <cc1:XUITextBox ID="txtHeader14" runat="server" CssClass="form-control" SPParameterName="p_header14" DBColumnName="HEADER_14" DataType="String" BindType="Both" MaxLength="25"></cc1:XUITextBox>
                     </div>
                  </div>
                  <div class="col-sm-3">
                     <div class="form-group">
                        <cc1:XUITextBox ID="txtFormat14" runat="server" CssClass="form-control" DBColumnName="FORMAT_14" SPParameterName="p_format14" DataType="Number" BindType="Both" Format="N2" MaxLength="18">
                        </cc1:XUITextBox>
                     </div>
                  </div>
                  <div class="col-sm-4">
                     <div class="form-group">
                        <cc1:XUITextBox ID="txtFormula14" runat="server" CssClass="form-control" OnTextChanged="txtOnTextChanged" DBColumnName="FORMULA_14" SPParameterName="p_formula14" DataType="String" BindType="Both" MaxLength="50">
                        </cc1:XUITextBox>
                     </div>
                  </div>
               </div>               
             </div>
         </div>
                
        <div class="tab-pane" id="Row">
        <header class="panel-heading">
           <%-- <span>Fee List</span>--%>
        </header>
        <div class="panel-heading">
            <div class="row">
                <div class="col-sm-4">
                    <cc1:XUILinkButton RoleCode="R12000030" ID="btnAddRow" runat="server" CssClass="btn btn-primary" OnClick="btnAddRow_Click"  CausesValidation="false"><i class="icon-plus"></i>  Create</cc1:XUILinkButton>
                    <cc1:XUILinkButton RoleCode="R12000030" ID="btnDeleteRow" runat="server" CssClass="btn btn-danger" OnClick="btnDeleteRow_Click"  CausesValidation="false"><i class="icon-trash"></i>  Delete</cc1:XUILinkButton>
                </div>
                <div class="col-sm-4">    
                    <span>Upload Excel : </span>
                        <asp:FileUpload ID="FileUploadControlAmort" runat="server"/>
                        <cc1:XUIButton ID="btnUploadRowFormat" runat="server" CssClass="btn btn-primary" Text="Upload" OnClick="btnUploadRowFormat_Click"
                             Style="width: auto;" />       
                        <cc1:XUIButton ID="btnDownload" runat="server" Text="Download Template" CssClass="btn btn-primary" OnClick="btnDownload_Click" />

                </div>
                <div class="col-sm-4">
                    <asp:Panel ID="pnlSearchRow" runat="server" DefaultButton="btnSearchRow" class="input-group">
                        <asp:TextBox ID="txtSearchRow" runat="server" CssClass="form-control" placeholder="Keywords"></asp:TextBox>  
                        <div class="input-group-btn">
                            <asp:LinkButton ID="btnSearchRow" runat="server" CssClass="btn btn-info" OnClick="btnSearchRow_Click"  CausesValidation="false"><i class="icon-search"></i>  Search</asp:LinkButton>
                        </div>
                    </asp:Panel>
                </div>
            </div>
         </div>
            <div class="panel-body">
                <asp:UpdatePanel ID="updRow" runat="server">
                    <ContentTemplate>
                        <asp:GridView ID="gvwListRow" runat="server" AutoGenerateColumns="false" CssClass="display table table-bordered table-striped"
                        AllowPaging="true" PageSize="10" DataKeyNames="ID"
                            OnPageIndexChanging="gvwListRow_PageIndexChanging" 
                            onselectedindexchanged="gvwListRow_SelectedIndexChangedRow" EmptyDataText="There is no data">
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
                                        <asp:CheckBox runat="server" ID="chbCheckedAllRow" AutoPostBack="true" 
                                            OnCheckedChanged="chbCheckedAllRow_CheckedChanged"/>
                                    </HeaderTemplate>
                                    <ItemTemplate>
                                        <asp:CheckBox runat="server" ID="chbCheckedRow"/>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:BoundField DataField="ROW_NO" HeaderText="Row No">
                                    <ItemStyle Width="15%" HorizontalAlign="Left"/>
                                </asp:BoundField>
                                <asp:BoundField DataField="FMT_1" HeaderText="Row Status">
                                    <ItemStyle Width="5%" HorizontalAlign="Center"/>
                                </asp:BoundField>
                                 <asp:BoundField DataField="FMT_2" HeaderText="Sign">
                                    <ItemStyle Width="5%" HorizontalAlign="Center"/>
                                </asp:BoundField>
                                <asp:BoundField DataField="FMT_3" HeaderText="Total">
                                    <ItemStyle Width="5%" HorizontalAlign="Left"/>
                                </asp:BoundField>
                                <asp:BoundField DataField="PAGE" HeaderText="Page" >
                                    <ItemStyle Width="5%" HorizontalAlign="Center" />
                                </asp:BoundField>
                                <asp:BoundField DataField="ACC_CODE" HeaderText="Relation Code">
                                    <ItemStyle Width="20%" HorizontalAlign="Left" />
                                </asp:BoundField>
                                <asp:BoundField DataField="FMT_DESC" HeaderText="Description">
                                    <ItemStyle Width="45%" HorizontalAlign="Left" />
                                </asp:BoundField>
                                <asp:CommandField ShowSelectButton="true" />
                            </Columns>
                        </asp:GridView>
                    </ContentTemplate>
                    <Triggers>
                        <asp:AsyncPostBackTrigger ControlID="btnSearchRow" EventName="Click" />
                        <asp:AsyncPostBackTrigger ControlID="btnSaveColumn" EventName="Click" />
                        <asp:AsyncPostBackTrigger ControlID="btnAddRow" EventName="Click" />
                        <asp:AsyncPostBackTrigger ControlID="btnDeleteRow" EventName="Click" />
                    </Triggers>
                </asp:UpdatePanel>
            </div>
         </div>        
</section>
</asp:Panel>
</asp:Content>

