<%@ Page Title="" Language="C#" MasterPageFile="~/iproc.master" AutoEventWireup="true" CodeFile="approvaltype.aspx.cs" Inherits="module_approval_approvaltype" %>

<%@ Register Assembly="MPF23.XUI" Namespace="MPF23.XUI.Control" TagPrefix="cc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cph" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cpb" Runat="Server">
    <section class="panel">
        <header class="panel-heading">
          <span>Approval Type Info</span>
        </header>
        <div class="panel-heading">
            <div class="row">
                <div class="col-sm-12">
                    <cc1:XUILinkButton ID="btnSave" RoleCode="R40000040E" runat="server" CssClass="btn btn-primary" OnClick="btnSave_Click"><i class="icon-save"></i>  Save</cc1:XUILinkButton>
                    <cc1:XUILinkButton ID="btnCancel" RoleCode="" runat="server" CssClass="btn btn-danger" OnClick="btnCancel_Click" CausesValidation="false"><i class="icon-remove"></i>  Cancel</cc1:XUILinkButton>
                </div>
            </div>
        </div>
        <div class="panel-body form-horizontal">
            <div class="row">
                <div class="col-sm-6">
                    <div class="form-group">
                        <label class="col-sm-4">Code *</label>
                        <div class="col-sm-4">
                            <cc1:XUITextBox ID="txtCode" runat="server" CssClass="form-control" placeholder="Code" DBColumnName="CODE" SPParameterName="p_code" MaxLength="15" DataType="String" BindType="Both"></cc1:XUITextBox>
                            <asp:RequiredFieldValidator ID="rfvCode" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtCode" Display="Dynamic"></asp:RequiredFieldValidator>
                        </div>
                    </div>                            
                </div>
                <div class="col-sm-6"> 
                    <div class="form-group">
                        <label class="col-sm-4">Valid</label> 
                        <div class="col-sm-8">
                            <cc1:XUICheckBox ID="cbIsValid" runat="server" DBColumnName="IS_VALID" SPParameterName="p_is_valid" DataType="String" BindType="Both"></cc1:XUICheckBox>        
                        </div>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-sm-6">
                    <div class="form-group">
                        <label class="col-sm-4">Description *</label>
                        <div class="col-sm-8">
                            <cc1:XUITextBox ID="txtDescription" runat="server" CssClass="form-control" placeholder="Name" DBColumnName="NAME" SPParameterName="p_name" MaxLength="50" DataType="String" BindType="Both" ></cc1:XUITextBox>
                            <asp:RequiredFieldValidator ID="rfvDescription" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtDescription" Display="Dynamic"></asp:RequiredFieldValidator>
                        </div>
                    </div>                            
                </div>
                <div class="col-sm-6">
                    <div class="form-group">
                        <label class="col-sm-4">No Of Level *</label>
                        <div class="col-sm-3">
                            <cc1:XUITextBox ID="txtNoOfLevel" runat="server" CssClass="form-control" placeholder="No Of Level" DBColumnName="NO_OF_LEVEL" SPParameterName="p_no_of_level" MaxLength="4" DataType="Integer" BindType="Both" ></cc1:XUITextBox>
                            <asp:RequiredFieldValidator ID="rfvNoOfLevel" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtNoOfLevel" Display="Dynamic"></asp:RequiredFieldValidator>
                            <asp:RegularExpressionValidator ID="revNoOfLevel" runat="server" ErrorMessage="Format Invalid!" ControlToValidate="txtNoOfLevel" ValidationExpression="[0-9 -.,/()+]*[0-9 -.,/()+]" Display="Dynamic" ></asp:RegularExpressionValidator>
                        </div>
                    </div>                            
                </div>
            </div>
            <%--<div class="row">
                <div class="col-sm-12">
                    <div class="form-group">
                        <label class="col-sm-2">SP Name *</label>
                        <div class="col-sm-5">
                            <cc1:XUITextBox ID="txtSPName" runat="server" CssClass="form-control" placeholder="SP Name" DBColumnName="SP_NAME" SPParameterName="p_sp_name" MaxLength="100" DataType="String" BindType="Both" ></cc1:XUITextBox>
                            <asp:RequiredFieldValidator ID="rfvSPName" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtSPName" Display="Dynamic"></asp:RequiredFieldValidator>
                        </div>
                    </div>                            
                </div>
            </div>
            <div class="row">
                <div class="col-sm-12">
                    <div class="form-group">
                        <label class="col-sm-2">SP Update Status Name *</label>
                        <div class="col-sm-5">
                            <cc1:XUITextBox ID="txtSPUpdateStatusName" runat="server" CssClass="form-control" placeholder="SP Update Status Name" DBColumnName="SP_UPDATE_STATUS_NAME" SPParameterName="p_sp_update_status_name" MaxLength="100" DataType="String" BindType="Both" ></cc1:XUITextBox>
                            <asp:RequiredFieldValidator ID="rfvSPUpdateStatusName" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtSPUpdateStatusName" Display="Dynamic"></asp:RequiredFieldValidator>
                        </div>
                    </div>                            
                </div>
            </div>
            <div class="row">
                <div class="col-sm-12">
                    <div class="form-group">
                        <label class="col-sm-2">SP Reject Name</label>
                        <div class="col-sm-5">
                            <cc1:XUITextBox ID="txtSPRejectName" runat="server" CssClass="form-control" placeholder="SP Reject Name" DBColumnName="SP_REJECT_NAME" SPParameterName="p_sp_reject_name" MaxLength="100" DataType="String" BindType="Both" ></cc1:XUITextBox>
                            <asp:RequiredFieldValidator ID="rfvSPRejectName" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtSPRejectName" Display="Dynamic"></asp:RequiredFieldValidator>
                        </div>
                    </div>                            
                </div>
            </div>
            <div class="row">
                <div class="col-sm-12">
                    <div class="form-group">
                        <label class="col-sm-2">SP Return Name</label>
                        <div class="col-sm-5">
                            <cc1:XUITextBox ID="txtSPReturnName" runat="server" CssClass="form-control" placeholder="SP Return Name" DBColumnName="SP_RETURN_NAME" SPParameterName="p_sp_return_name" MaxLength="100" DataType="String" BindType="Both" ></cc1:XUITextBox>
                            <asp:RequiredFieldValidator ID="rfvSPReturnName" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtSPReturnName" Display="Dynamic"></asp:RequiredFieldValidator>
                        </div>
                    </div>                            
                </div>
            </div>--%>
             <div class="row">
                <div class="col-sm-12">
                    <div class="form-group">
                        <div class="col-sm-2">
                            <label>Type *</label>
                            
                        </div>
                        <div class="col-sm-8">
                            <div class="input-group"> <%--(+) Start - 2015/12/15 - 13:20 - Adi penggantian label lookup menjadi textbox---%>
                                <asp:LinkButton ID="btnLookUpType" runat="server" class="btn btn-primary" data-togel="modal" CausesValidation="true" Enabled="true"><i class = "icon-table" ></i> </asp:LinkButton>
                                 
                                <cc1:XUITextBox ID="txtTypeCode" runat="server" CssClass="form-control" DBColumnName="TYPE" SPParameterName="p_type" MaxLength="15" DataType="String" BindType="Both" style="display:none"></cc1:XUITextBox>
                                <cc1:XUITextBox ID="txtDescriptionType" CssClass="form-control" runat="server" DBColumnName="DESCRIPTION" DataType="String" BindType="DBToUIOnly" Text="-" Enabled="false" Width="300px" style="border:0px; background:inherit"></cc1:XUITextBox>
                                <asp:RequiredFieldValidator ID="rfvType" runat="server" ErrorMessage="Required Field!" ToolTip="Please fill this field." ControlToValidate="txtTypeCode" Display="Dynamic" Width="300px"></asp:RequiredFieldValidator>
                            </div> <%--(+) End - 2015/12/15 - 13:20 - Adi -	--%>                                           
                      <%--<cc1:XUIDropDownList ID="ddlType" runat="server" CssClass="form-control" DBColumnName="TYPE" SPParameterName="p_type" BindType="Both" DataType="String"></cc1:XUIDropDownList>--%>
                      </div>
                    </div>                            
                </div>
            </div>
      
            <asp:UpdatePanel ID="updDimension" runat="server" UpdateMode="Conditional">
                <ContentTemplate>
                    <div class="row">
                        <div class="col-sm-12">
                            <div class="form-group">
                                <div class="col-sm-2">
                                    <label>Dimension 1</label>
                                </div>
                                <div class="col-sm-10 input-group">
                                    <asp:LinkButton ID="btnLookUpDim1" runat="server" class="btn btn-primary" data-togel="modal" CausesValidation="false"><i class = "icon-table"></i> </asp:LinkButton>
                                    <asp:LinkButton ID="btnDelDim1" runat="server" CssClass="btn btn-danger" 
                                        CausesValidation="false" onclick="btnDelDim1_Click"><i class="icon-remove"></i></asp:LinkButton>
                                    <cc1:XUITextBox ID="txtDim1Description" runat="server" DBColumnName="DIM1_DESCRIPTION" DataType="String" BindType="DBToUIOnly" Text="-" CssClass="form-control" Enabled="false" Width="30%" style="border:0px; background:inherit"></cc1:XUITextBox>
                                    <cc1:XUITextBox ID="txtDim1Code" runat="server" CssClass="form-control" DBColumnName="DIM_1" SPParameterName="p_dim_1" DataType="String" BindType="Both" style="display:none" ></cc1:XUITextBox>
                                    <cc1:XUIDropDownList ID="ddlOperator1" runat="server" DBColumnName="OPERATOR_1" SPParameterName="p_operator_1" BindType="Both" DataType="String">
                                        <asp:ListItem Selected="True" Value="=">EQUAL</asp:ListItem>
                                        <asp:ListItem Value=">">MORE THAN</asp:ListItem>
                                        <asp:ListItem Value="<">LESS THAN</asp:ListItem>
                                        <asp:ListItem Value="BETWEEN">BETWEEN</asp:ListItem>
                                    </cc1:XUIDropDownList>
                                    &nbsp;
                                    <cc1:XUITextBox ID="txtDimValueFrom1" runat="server" CssClass="form-control" DBColumnName="DIM_VALUE_FROM_1" SPParameterName="p_dim_value_from_1" DataType="String" BindType="Both" Width="15%"></cc1:XUITextBox>
                                    -
                                    <cc1:XUITextBox ID="txtDimValueTo1" runat="server" CssClass="form-control" DBColumnName="DIM_VALUE_TO_1" SPParameterName="p_dim_value_to_1" DataType="String" BindType="Both" Width="15%"></cc1:XUITextBox>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-sm-12">
                            <div class="form-group">
                                <div class="col-sm-2">
                                    <label>Dimension 2</label>
                                </div>
                                <div class="col-sm-10 input-group">
                                    <asp:LinkButton ID="btnLookUpDim2" runat="server" class="btn btn-primary" data-togel="modal" CausesValidation="false"><i class = "icon-table"></i> </asp:LinkButton>
                                    <asp:LinkButton ID="btnDelDim2" runat="server" CssClass="btn btn-danger" 
                                        CausesValidation="false" onclick="btnDelDim2_Click"><i class="icon-remove"></i></asp:LinkButton>
                                    <cc1:XUITextBox ID="txtDim2Description" runat="server" DBColumnName="DIM2_DESCRIPTION" DataType="String" BindType="DBToUIOnly" Text="-" CssClass="form-control" Enabled="false" Width="30%" style="border:0px; background:inherit"></cc1:XUITextBox>
                                    <cc1:XUITextBox ID="txtDim2Code" runat="server" CssClass="form-control" DBColumnName="DIM_2" SPParameterName="p_dim_2" DataType="String" BindType="Both" style="display:none" ></cc1:XUITextBox>
                                    <cc1:XUIDropDownList ID="ddlOperator2" runat="server" DBColumnName="OPERATOR_2" SPParameterName="p_operator_2" BindType="Both" DataType="String">
                                        <asp:ListItem Selected="True" Value="=">EQUAL</asp:ListItem>
                                        <asp:ListItem Value=">">MORE THAN</asp:ListItem>
                                        <asp:ListItem Value="<">LESS THAN</asp:ListItem>
                                        <asp:ListItem Value="BETWEEN">BETWEEN</asp:ListItem>
                                    </cc1:XUIDropDownList>
                                    &nbsp;
                                    <cc1:XUITextBox ID="txtDimValueFrom2" runat="server" CssClass="form-control" DBColumnName="DIM_VALUE_FROM_2" SPParameterName="p_dim_value_from_2" DataType="String" BindType="Both" Width="15%"></cc1:XUITextBox>
                                    -
                                    <cc1:XUITextBox ID="txtDimValueTo2" runat="server" CssClass="form-control" DBColumnName="DIM_VALUE_TO_2" SPParameterName="p_dim_value_to_2" DataType="String" BindType="Both" Width="15%"></cc1:XUITextBox>
                                </div>
                            </div>
                        </div> 
                    </div>
                    <div class="row">
                        <div class="col-sm-12">
                            <div class="form-group">
                                <div class="col-sm-2">
                                    <label>Dimension 3</label>
                                </div>
                                <div class="col-sm-10 input-group">
                                    <asp:LinkButton ID="btnLookUpDim3" runat="server" class="btn btn-primary" data-togel="modal" CausesValidation="false"><i class = "icon-table"></i> </asp:LinkButton>
                                    <asp:LinkButton ID="btnDelDim3" runat="server" CssClass="btn btn-danger" 
                                        CausesValidation="false" onclick="btnDelDim3_Click"><i class="icon-remove"></i></asp:LinkButton>
                                    <cc1:XUITextBox ID="txtDim3Description" runat="server" DBColumnName="DIM3_DESCRIPTION" DataType="String" BindType="DBToUIOnly" Text="-" CssClass="form-control" Enabled="false" Width="30%" style="border:0px; background:inherit"></cc1:XUITextBox>
                                    <cc1:XUITextBox ID="txtDim3Code" runat="server" CssClass="form-control" DBColumnName="DIM_3" SPParameterName="p_dim_3" DataType="String" BindType="Both" style="display:none" ></cc1:XUITextBox>
                                    <cc1:XUIDropDownList ID="ddlOperator3" runat="server" DBColumnName="OPERATOR_3" SPParameterName="p_operator_3" BindType="Both" DataType="String">
                                        <asp:ListItem Selected="True" Value="=">EQUAL</asp:ListItem>
                                        <asp:ListItem Value=">">MORE THAN</asp:ListItem>
                                        <asp:ListItem Value="<">LESS THAN</asp:ListItem>
                                        <asp:ListItem Value="BETWEEN">BETWEEN</asp:ListItem>
                                    </cc1:XUIDropDownList>
                                    &nbsp;
                                    <cc1:XUITextBox ID="txtDimValueFrom3" runat="server" CssClass="form-control" DBColumnName="DIM_VALUE_FROM_3" SPParameterName="p_dim_value_from_3" DataType="String" BindType="Both" Width="15%"></cc1:XUITextBox>
                                    -
                                    <cc1:XUITextBox ID="txtDimValueTo3" runat="server" CssClass="form-control" DBColumnName="DIM_VALUE_TO_3" SPParameterName="p_dim_value_to_3" DataType="String" BindType="Both" Width="15%"></cc1:XUITextBox>
                                </div>
                            </div>
                        </div> 
                    </div>
                    <div class="row">
                        <div class="col-sm-12">
                            <div class="form-group">
                                <div class="col-sm-2">
                                    <label>Dimension 4</label>
                                </div>
                                <div class="col-sm-10 input-group">
                                    <asp:LinkButton ID="btnLookUpDim4" runat="server" class="btn btn-primary" data-togel="modal" CausesValidation="false"><i class = "icon-table"></i> </asp:LinkButton>
                                    <asp:LinkButton ID="btnDelDim4" runat="server" CssClass="btn btn-danger" 
                                        CausesValidation="false" onclick="btnDelDim4_Click"><i class="icon-remove"></i></asp:LinkButton>
                                    <cc1:XUITextBox ID="txtDim4Description" runat="server" DBColumnName="DIM4_DESCRIPTION" DataType="String" BindType="DBToUIOnly" Text="-" CssClass="form-control" Enabled="false" Width="30%" style="border:0px; background:inherit"></cc1:XUITextBox>
                                    <cc1:XUITextBox ID="txtDim4Code" runat="server" CssClass="form-control" DBColumnName="DIM_4" SPParameterName="p_dim_4" DataType="String" BindType="Both" style="display:none" ></cc1:XUITextBox>
                                    <cc1:XUIDropDownList ID="ddlOperator4" runat="server" DBColumnName="OPERATOR_4" SPParameterName="p_operator_4" BindType="Both" DataType="String">
                                        <asp:ListItem Selected="True" Value="=">EQUAL</asp:ListItem>
                                        <asp:ListItem Value=">">MORE THAN</asp:ListItem>
                                        <asp:ListItem Value="<">LESS THAN</asp:ListItem>
                                        <asp:ListItem Value="BETWEEN">BETWEEN</asp:ListItem>
                                    </cc1:XUIDropDownList>
                                    &nbsp;
                                    <cc1:XUITextBox ID="txtDimValueFrom4" runat="server" CssClass="form-control" DBColumnName="DIM_VALUE_FROM_4" SPParameterName="p_dim_value_from_4" DataType="String" BindType="Both" Width="15%"></cc1:XUITextBox>
                                    -
                                    <cc1:XUITextBox ID="txtDimValueTo4" runat="server" CssClass="form-control" DBColumnName="DIM_VALUE_TO_4" SPParameterName="p_dim_value_to_4" DataType="String" BindType="Both" Width="15%"></cc1:XUITextBox>
                                </div>
                            </div>
                        </div> 
                    </div>                        
                    <div class="row">
                        <div class="col-sm-12">
                            <div class="form-group">
                                <div class="col-sm-2">
                                    <label>Dimension 5</label>
                                </div>
                                <div class="col-sm-10 input-group">
                                    <asp:LinkButton ID="btnLookUpDim5" runat="server" class="btn btn-primary" data-togel="modal" CausesValidation="false"><i class = "icon-table"></i> </asp:LinkButton>
                                    <asp:LinkButton ID="btnDelDim5" runat="server" CssClass="btn btn-danger" 
                                        CausesValidation="false" onclick="btnDelDim5_Click"><i class="icon-remove"></i></asp:LinkButton>
                                    <cc1:XUITextBox ID="txtDim5Description" runat="server" DBColumnName="DIM5_DESCRIPTION" DataType="String" BindType="DBToUIOnly" Text="-" CssClass="form-control" Enabled="false" Width="30%" style="border:0px; background:inherit"></cc1:XUITextBox>
                                    <cc1:XUITextBox ID="txtDim5Code" runat="server" CssClass="form-control" DBColumnName="DIM_5" SPParameterName="p_dim_5" DataType="String" BindType="Both" style="display:none" ></cc1:XUITextBox>
                                    <cc1:XUIDropDownList ID="ddlOperator5" runat="server" DBColumnName="OPERATOR_5" SPParameterName="p_operator_5" BindType="Both" DataType="String">
                                        <asp:ListItem Selected="True" Value="=">EQUAL</asp:ListItem>
                                        <asp:ListItem Value=">">MORE THAN</asp:ListItem>
                                        <asp:ListItem Value="<">LESS THAN</asp:ListItem>
                                        <asp:ListItem Value="BETWEEN">BETWEEN</asp:ListItem>
                                    </cc1:XUIDropDownList>
                                    &nbsp;
                                    <cc1:XUITextBox ID="txtDimValueFrom5" runat="server" CssClass="form-control" DBColumnName="DIM_VALUE_FROM_5" SPParameterName="p_dim_value_from_5" DataType="String" BindType="Both" Width="15%"></cc1:XUITextBox>
                                    -
                                    <cc1:XUITextBox ID="txtDimValueTo5" runat="server" CssClass="form-control" DBColumnName="DIM_VALUE_TO_5" SPParameterName="p_dim_value_to_5" DataType="String" BindType="Both" Width="15%"></cc1:XUITextBox>
                                </div>
                            </div>
                        </div> 
                    </div>
                    <div class="row">
                        <div class="col-sm-12">
                            <div class="form-group">
                                <div class="col-sm-2">
                                    <label>Dimension 6</label>
                                </div>
                                <div class="col-sm-10 input-group">
                                    <asp:LinkButton ID="btnLookUpDim6" runat="server" class="btn btn-primary" data-togel="modal" CausesValidation="false"><i class = "icon-table"></i> </asp:LinkButton>
                                    <asp:LinkButton ID="btnDelDim6" runat="server" CssClass="btn btn-danger" 
                                        CausesValidation="false" onclick="btnDelDim6_Click"><i class="icon-remove"></i></asp:LinkButton>
                                    <cc1:XUITextBox ID="txtDim6Description" runat="server" DBColumnName="DIM6_DESCRIPTION" DataType="String" BindType="DBToUIOnly" Text="-" CssClass="form-control" Enabled="false" Width="30%" style="border:0px; background:inherit"></cc1:XUITextBox>
                                    <cc1:XUITextBox ID="txtDim6Code" runat="server" CssClass="form-control" DBColumnName="DIM_6" SPParameterName="p_dim_6" DataType="String" BindType="Both" style="display:none" ></cc1:XUITextBox>
                                    <cc1:XUIDropDownList ID="ddlOperator6" runat="server" DBColumnName="OPERATOR_6" SPParameterName="p_operator_6" BindType="Both" DataType="String">
                                        <asp:ListItem Selected="True" Value="=">EQUAL</asp:ListItem>
                                        <asp:ListItem Value=">">MORE THAN</asp:ListItem>
                                        <asp:ListItem Value="<">LESS THAN</asp:ListItem>
                                        <asp:ListItem Value="BETWEEN">BETWEEN</asp:ListItem>
                                    </cc1:XUIDropDownList>
                                    &nbsp;
                                    <cc1:XUITextBox ID="txtDimValueFrom6" runat="server" CssClass="form-control" DBColumnName="DIM_VALUE_FROM_6" SPParameterName="p_dim_value_from_6" DataType="String" BindType="Both" Width="15%"></cc1:XUITextBox>
                                    -
                                    <cc1:XUITextBox ID="txtDimValueTo6" runat="server" CssClass="form-control" DBColumnName="DIM_VALUE_TO_6" SPParameterName="p_dim_value_to_6" DataType="String" BindType="Both" Width="15%"></cc1:XUITextBox>
                                </div>
                            </div>
                        </div> 
                    </div>
                    <div class="row">
                        <div class="col-sm-12">
                            <div class="form-group">
                                <div class="col-sm-2">
                                    <label>Dimension 7</label>
                                </div>
                                <div class="col-sm-10 input-group">
                                    <asp:LinkButton ID="btnLookUpDim7" runat="server" class="btn btn-primary" data-togel="modal" CausesValidation="false"><i class = "icon-table"></i> </asp:LinkButton>
                                    <asp:LinkButton ID="btnDelDim7" runat="server" CssClass="btn btn-danger" 
                                        CausesValidation="false" onclick="btnDelDim7_Click"><i class="icon-remove"></i></asp:LinkButton>
                                    <cc1:XUITextBox ID="txtDim7Description" runat="server" DBColumnName="DIM7_DESCRIPTION" DataType="String" BindType="DBToUIOnly" Text="-" CssClass="form-control" Enabled="false" Width="30%" style="border:0px; background:inherit"></cc1:XUITextBox>
                                    <cc1:XUITextBox ID="txtDim7Code" runat="server" CssClass="form-control" DBColumnName="DIM_7" SPParameterName="p_dim_7" DataType="String" BindType="Both" style="display:none" ></cc1:XUITextBox>
                                    <cc1:XUIDropDownList ID="ddlOperator7" runat="server" DBColumnName="OPERATOR_7" SPParameterName="p_operator_7" BindType="Both" DataType="String">
                                        <asp:ListItem Selected="True" Value="=">EQUAL</asp:ListItem>
                                        <asp:ListItem Value=">">MORE THAN</asp:ListItem>
                                        <asp:ListItem Value="<">LESS THAN</asp:ListItem>
                                        <asp:ListItem Value="BETWEEN">BETWEEN</asp:ListItem>
                                    </cc1:XUIDropDownList>
                                    &nbsp;
                                    <cc1:XUITextBox ID="txtDimValueFrom7" runat="server" CssClass="form-control" DBColumnName="DIM_VALUE_FROM_7" SPParameterName="p_dim_value_from_7" DataType="String" BindType="Both" Width="15%"></cc1:XUITextBox>
                                    -
                                    <cc1:XUITextBox ID="txtDimValueTo7" runat="server" CssClass="form-control" DBColumnName="DIM_VALUE_TO_7" SPParameterName="p_dim_value_to_7" DataType="String" BindType="Both" Width="15%"></cc1:XUITextBox>
                                </div>
                            </div>                            
                        </div> 
                    </div>
                    <div class="row">
                        <div class="col-sm-12">
                            <div class="form-group">
                                <div class="col-sm-2">
                                    <label>Dimension 8</label>
                                </div>
                                <div class="col-sm-10 input-group">
                                    <asp:LinkButton ID="btnLookUpDim8" runat="server" class="btn btn-primary" data-togel="modal" CausesValidation="false"><i class = "icon-table"></i> </asp:LinkButton>
                                    <asp:LinkButton ID="btnDelDim8" runat="server" CssClass="btn btn-danger" 
                                        CausesValidation="false" onclick="btnDelDim8_Click"><i class="icon-remove"></i></asp:LinkButton>
                                    <cc1:XUITextBox ID="txtDim8Description" runat="server" DBColumnName="DIM8_DESCRIPTION" DataType="String" BindType="DBToUIOnly" Text="-" CssClass="form-control" Enabled="false" Width="30%" style="border:0px; background:inherit"></cc1:XUITextBox>
                                    <cc1:XUITextBox ID="txtDim8Code" runat="server" CssClass="form-control" DBColumnName="DIM_8" SPParameterName="p_dim_8" DataType="String" BindType="Both" style="display:none" ></cc1:XUITextBox>
                                    <cc1:XUIDropDownList ID="ddlOperator8" runat="server" DBColumnName="OPERATOR_8" SPParameterName="p_operator_8" BindType="Both" DataType="String">
                                        <asp:ListItem Selected="True" Value="=">EQUAL</asp:ListItem>
                                        <asp:ListItem Value=">">MORE THAN</asp:ListItem>
                                        <asp:ListItem Value="<">LESS THAN</asp:ListItem>
                                        <asp:ListItem Value="BETWEEN">BETWEEN</asp:ListItem>
                                    </cc1:XUIDropDownList>
                                    &nbsp;
                                    <cc1:XUITextBox ID="txtDimValueFrom8" runat="server" CssClass="form-control" DBColumnName="DIM_VALUE_FROM_8" SPParameterName="p_dim_value_from_8" DataType="String" BindType="Both" Width="15%"></cc1:XUITextBox>
                                    -
                                    <cc1:XUITextBox ID="txtDimValueTo8" runat="server" CssClass="form-control" DBColumnName="DIM_VALUE_TO_8" SPParameterName="p_dim_value_to_8" DataType="String" BindType="Both" Width="15%"></cc1:XUITextBox>
                                </div>
                            </div>                            
                        </div> 
                    </div>
                    <div class="row">
                        <div class="col-sm-12">
                            <div class="form-group">
                                <div class="col-sm-2">
                                    <label>Dimension 9</label>
                                </div>
                                <div class="col-sm-10 input-group">
                                    <asp:LinkButton ID="btnLookUpDim9" runat="server" class="btn btn-primary" data-togel="modal" CausesValidation="false"><i class = "icon-table"></i> </asp:LinkButton>
                                    <asp:LinkButton ID="btnDelDim9" runat="server" CssClass="btn btn-danger" 
                                        CausesValidation="false" onclick="btnDelDim9_Click"><i class="icon-remove"></i></asp:LinkButton>
                                    <cc1:XUITextBox ID="txtDim9Description" runat="server" DBColumnName="DIM9_DESCRIPTION" DataType="String" BindType="DBToUIOnly" Text="-" CssClass="form-control" Enabled="false" Width="30%" style="border:0px; background:inherit"></cc1:XUITextBox>
                                    <cc1:XUITextBox ID="txtDim9Code" runat="server" CssClass="form-control" DBColumnName="DIM_9" SPParameterName="p_dim_9" DataType="String" BindType="Both" style="display:none" ></cc1:XUITextBox>
                                    <cc1:XUIDropDownList ID="ddlOperator9" runat="server" DBColumnName="OPERATOR_9" SPParameterName="p_operator_9" BindType="Both" DataType="String">
                                        <asp:ListItem Selected="True" Value="=">EQUAL</asp:ListItem>
                                        <asp:ListItem Value=">">MORE THAN</asp:ListItem>
                                        <asp:ListItem Value="<">LESS THAN</asp:ListItem>
                                        <asp:ListItem Value="BETWEEN">BETWEEN</asp:ListItem>
                                    </cc1:XUIDropDownList>
                                    &nbsp;
                                    <cc1:XUITextBox ID="txtDimValueFrom9" runat="server" CssClass="form-control" DBColumnName="DIM_VALUE_FROM_9" SPParameterName="p_dim_value_from_9" DataType="String" BindType="Both" Width="15%"></cc1:XUITextBox>
                                    -
                                    <cc1:XUITextBox ID="txtDimValueTo9" runat="server" CssClass="form-control" DBColumnName="DIM_VALUE_TO_9" SPParameterName="p_dim_value_to_9" DataType="String" BindType="Both" Width="15%"></cc1:XUITextBox>
                                </div>
                            </div>                            
                        </div> 
                    </div>
                    <div class="row">
                        <div class="col-sm-12">
                            <div class="form-group">
                                <div class="col-sm-2">
                                    <label>Dimension 10</label>
                                </div>
                                <div class="col-sm-10 input-group">
                                    <asp:LinkButton ID="btnLookUpDim10" runat="server" class="btn btn-primary" data-togel="modal" CausesValidation="false"><i class = "icon-table"></i> </asp:LinkButton>
                                    <asp:LinkButton ID="btnDelDim10" runat="server" CssClass="btn btn-danger" 
                                        CausesValidation="false" onclick="btnDelDim10_Click"><i class="icon-remove"></i></asp:LinkButton>
                                    <cc1:XUITextBox ID="txtDim10Description" runat="server" DBColumnName="DIM10_DESCRIPTION" DataType="String" BindType="DBToUIOnly" Text="-" CssClass="form-control" Enabled="false" Width="30%" style="border:0px; background:inherit"></cc1:XUITextBox>
                                    <cc1:XUITextBox ID="txtDim10Code" runat="server" CssClass="form-control" DBColumnName="DIM_10" SPParameterName="p_dim_10" DataType="String" BindType="Both" style="display:none" ></cc1:XUITextBox>
                                    <cc1:XUIDropDownList ID="ddlOperator10" runat="server" DBColumnName="OPERATOR_10" SPParameterName="p_operator_10" BindType="Both" DataType="String">
                                        <asp:ListItem Selected="True" Value="=">EQUAL</asp:ListItem>
                                        <asp:ListItem Value=">">MORE THAN</asp:ListItem>
                                        <asp:ListItem Value="<">LESS THAN</asp:ListItem>
                                        <asp:ListItem Value="BETWEEN">BETWEEN</asp:ListItem>
                                    </cc1:XUIDropDownList>
                                    &nbsp;
                                    <cc1:XUITextBox ID="txtDimValueFrom10" runat="server" CssClass="form-control" DBColumnName="DIM_VALUE_FROM_10" SPParameterName="p_dim_value_from_10" DataType="String" BindType="Both" Width="15%"></cc1:XUITextBox>
                                    -
                                    <cc1:XUITextBox ID="txtDimValueTo10" runat="server" CssClass="form-control" DBColumnName="DIM_VALUE_TO_10" SPParameterName="p_dim_value_to_10" DataType="String" BindType="Both" Width="15%"></cc1:XUITextBox>
                                </div>
                            </div>                            
                        </div> 
                    </div>
                </ContentTemplate>
            </asp:UpdatePanel>
            </ContentTemplate>
                <Triggers>
                    <asp:AsyncPostBackTrigger ControlID="btnSave" EventName="Click" />
                    <asp:AsyncPostBackTrigger ControlID="btnCancel" EventName="Click" />
                </Triggers>
            </asp:UpdatePanel> 
        </div>
    </section>
    
    <section class="panel">
        <header class="panel-heading">
          <span>Approval Type Level</span>
        </header>
        <div class="panel-heading">
            <div class="row">
                <div class="col-sm-8">
                    <cc1:XUILinkButton RoleCode="R40000040E" ID="btnAddApprovalTypeLevel" runat="server" CssClass="btn btn-primary" OnClick="btnAddApprovalTypeLevel_OnClick" CausesValidation="false"><i class="icon-plus"></i>  Create</cc1:XUILinkButton>
                    <cc1:XUILinkButton RoleCode="R40000040E" ID="btnDeleteApprovalTypeLevel" runat="server" CssClass="btn btn-danger" OnClick="btnDeleteApprovalTypeLevel_OnClick" CausesValidation="false"><i class="icon-trash"></i>  Delete</cc1:XUILinkButton>
                </div>                 
                <div class="col-sm-4">
                    <asp:Panel ID="pnlSearch" runat="server" DefaultButton="btnSearch"     class="input-group">
                        <asp:TextBox ID="txtSearch" runat="server" CssClass="form-control" placeholder="Keywords"></asp:TextBox>  
                        <div class="input-group-btn">
                            <asp:LinkButton ID="btnSearch" runat="server" CssClass="btn btn-info" OnClick="btnSearch_Click" CausesValidation="false"><i class="icon-search"></i>  Search</asp:LinkButton>
                        </div>
                    </asp:Panel>
                </div>
            </div>
        </div>
        <div class="panel-body">
            <asp:UpdatePanel ID="upd" runat="server">
                <ContentTemplate>
                    <asp:GridView ID="gvwListApprovalTypeLevel" runat="server" AutoGenerateColumns="false" CssClass="display table table-bordered table-striped"
                    AllowPaging="true" PageSize="10" DataKeyNames="ID"
                        OnPageIndexChanging="gvwListApprovalTypeLevel_PageIndexChanging" 
                        onselectedindexchanged="gvwListApprovalTypeLevel_SelectedIndexChanged" EmptyDataText="There Is No Data">
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
                            <asp:BoundField DataField="FROM_AMOUNT" HeaderText="From Amount" SortExpression="FROM_AMOUNT" DataFormatString="{0:N2}">
                                <ItemStyle Width="40%" HorizontalAlign="Right"/>
                            </asp:BoundField>
                            <asp:BoundField DataField="TO_AMOUNT" HeaderText="To Amount" SortExpression="TO_AMOUNT" DataFormatString="{0:N2}">
                                <ItemStyle Width="40%" HorizontalAlign="Right"/>
                            </asp:BoundField>
                            <asp:BoundField DataField="MIN_PERSON" HeaderText="Min Person">
                                <ItemStyle Width="10%" HorizontalAlign="Right"/>
                            </asp:BoundField>
                            <asp:BoundField DataField="ORDER_KEY" HeaderText="Order Key">
                                <ItemStyle Width="10%" HorizontalAlign="Right" />
                            </asp:BoundField>
                            <asp:CommandField ShowSelectButton="true" />
                        </Columns>
                    </asp:GridView>
                </ContentTemplate>
                <Triggers>
                    <asp:AsyncPostBackTrigger ControlID="btnDeleteApprovalTypeLevel" EventName="Click" />
                    <asp:AsyncPostBackTrigger ControlID="btnSearch" EventName="Click" />
                </Triggers>
            </asp:UpdatePanel>
        </div>
       </div>
        
    </section>
</asp:Content>


