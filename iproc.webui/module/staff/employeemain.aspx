<%@ Page Title="" Language="C#" MasterPageFile="~/iproc.master" AutoEventWireup="true" CodeFile="employeemain.aspx.cs" Inherits="module_personel_employeemain" %>

<%@ Register Assembly="MPF23.XUI" Namespace="MPF23.XUI.Control" TagPrefix="cc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cph" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cpb" Runat="Server">   
    <div class="row">
        <div class="col-sm-8">
            <section class="panel form-horizontal">
                <%--<asp:UpdatePanel ID="UpdatePanel1" runat="server">
                    <ContentTemplate> --%>
                <header class="panel-heading">
                    <span>Basic Info</span>
                </header>
                <div class="panel-heading">
                    <div class="row">
                        <div class="col-sm-12">
                            <cc1:XUILinkButton RoleCode="R40000010" ID="btnSave" runat="server" CssClass="btn btn-primary" OnClick="btnSave_Click"><i class="icon-save"></i>  Save</cc1:XUILinkButton>
                            <cc1:XUILinkButton RoleCode="" ID="btnReActive" runat="server" CssClass="btn btn-primary" OnClick="btnReActive_Click" CausesValidation="false"><i class=""></i>  Re-Active</cc1:XUILinkButton>
                            <cc1:XUILinkButton RoleCode="" ID="btnCancel" runat="server" CssClass="btn btn-danger" OnClick="btnCancel_Click" CausesValidation="false"><i class="icon-remove"></i>  Cancel</cc1:XUILinkButton>
                        </div>
                    </div>
                </div>
                <div class="panel-body">
                    <div class="row">
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4 ">User ID</label>
                                <div class="col-sm-7">
                                    <cc1:XUILabel ID="lblCode" runat="server" DBColumnName="EMP_CODE" SPParameterName="p_emp_code"  DataType="String" BindType="Both" ></cc1:XUILabel>
                                    <cc1:XUILabel ID="lblUid" runat="server" DBColumnName="UID" SPParameterName="p_uid"  DataType="String" BindType="DBToUIOnly"  Style="display:none"></cc1:XUILabel>
                                </div>
                            </div> 
                        </div>
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4 ">Employee Name *</label>
                                <div class="col-sm-7">
                                    <cc1:XUITextBox ID="txtName" runat="server" CssClass="form-control" placeholder="Name" DBColumnName="EMP_NAME" SPParameterName="p_emp_name" MaxLength="50" DataType="String" BindType="Both"></cc1:XUITextBox>
                                    <asp:RequiredFieldValidator ID="rfvName" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtName" Display="Dynamic"></asp:RequiredFieldValidator>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4 ">NIK *</label>
                                <div class="col-sm-7">
                                    <cc1:XUITextBox ID="txtNik" runat="server" CssClass="form-control" placeholder="NIK" DBColumnName="NIK" SPParameterName="p_nik" MaxLength="50" DataType="String" BindType="Both"></cc1:XUITextBox>
                                    <asp:RequiredFieldValidator ID="rfvNik" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtNik" Display="Dynamic"></asp:RequiredFieldValidator>
                                </div>
                            </div> 
                        </div>
                     </div>   
                    <div class="row">
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4 ">Date Of Birth </label>
                                <div class="col-sm-7">
                                    <cc1:XUITextBox ID="txtDateOfBirth" runat="server" CssClass="form-control default-date-picker" placeholder="Date Of Birth" DBColumnName="DATE_OF_BIRTH" SPParameterName="p_date_of_birth" DataType="DateTime" Format="dd/MM/yyyy" BindType="Both"></cc1:XUITextBox>
                                    <%--<asp:RequiredFieldValidator ID="rfvDateOfBirth" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtDateOfBirth" Display="Dynamic"></asp:RequiredFieldValidator>--%>
                                </div>
                            </div>
                        </div>
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4 ">Place Of Birth </label>
                                <div class="col-sm-7">
                                    <cc1:XUITextBox ID="txtPlaceOfBirth" runat="server" CssClass="form-control" placeholder="Place Of Birth" DBColumnName="PLACE_OF_BIRTH" SPParameterName="p_place_of_birth" MaxLength="20" DataType="String" BindType="Both"></cc1:XUITextBox>
                                   <%-- <asp:RequiredFieldValidator ID="rfvPlaceOfBirth" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtPlaceOfBirth" Display="Dynamic"></asp:RequiredFieldValidator>--%>
                                </div>
                            </div>                            
                        </div>            
                    </div>
                    <div class="row">
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4 ">Gender</label>
                                <div class="col-sm-7">
                                    <cc1:XUIRadioButtonList ID="rblGender" runat="server" RepeatDirection="Horizontal" DBColumnName="GENDER" SPParameterName="p_gender" DataType="String" BindType="Both">
                                        <asp:ListItem Value="M" Selected="True">Male</asp:ListItem>
                                        <asp:ListItem Value="F">Female</asp:ListItem>
                                    </cc1:XUIRadioButtonList>
                                </div>
                            </div>
                        </div>  
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4 ">Religion</label>
                                <div class="col-sm-7">
                                    <cc1:XUIDropDownList ID="ddlReligion" runat="server" CssClass="form-control" DBColumnName="RELIGION_CODE" SPParameterName="p_religion_code" DataType="String" BindType="Both"></cc1:XUIDropDownList>
                                </div>
                            </div>                            
                        </div>                    
                    </div>
                    <div class="row">
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4 ">Weight </label>
                                <div class="col-sm-7">
                                    <cc1:XUITextBox ID="txtWeight" runat="server" CssClass="form-control" placeholder="Weight" DBColumnName="WEIGHT" SPParameterName="p_weight" MaxLength="3" DataType="Integer" BindType="Both"></cc1:XUITextBox>
                                    <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" ErrorMessage="Format Invalid!" ControlToValidate="txtWeight" ValidationExpression="[0-9 -.,/()+]*[0-9 -.,/()+]" Display="Dynamic" ></asp:RegularExpressionValidator>
                      
                                </div>
                            </div>
                        </div>                        
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4 ">Height </label>
                                <div class="col-sm-7">
                                    <cc1:XUITextBox ID="txtHeight" runat="server" CssClass="form-control" placeholder="Height" DBColumnName="HEIGHT" SPParameterName="p_height" MaxLength="3" DataType="Integer" BindType="Both"></cc1:XUITextBox>
                                    <asp:RegularExpressionValidator ID="RegularExpressionValidator3" runat="server" ErrorMessage="Format Invalid!" ControlToValidate="txtHeight" ValidationExpression="[0-9 -.,/()+]*[0-9 -.,/()+]" Display="Dynamic" ></asp:RegularExpressionValidator>
                                   
                                </div>
                            </div>                            
                        </div>
                    </div>
                    <div class="row">
                     <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4">Blood Type</label>                                
                                <div class="col-sm-7">
                                    <cc1:XUIDropDownList ID="ddlBloodType" runat="server" CssClass="form-control" placeholder="" DBColumnName="BLOOD_TYPE" SPParameterName="p_blood_type"  MaxLength="10" DataType="String" BindType="Both"></cc1:XUIDropDownList>
                                </div>
                            </div>                            
                        </div>
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4 ">Children </label>
                                <div class="col-sm-7">
                                    <cc1:XUITextBox ID="txtChildren" runat="server" CssClass="form-control" placeholder="Children" DBColumnName="CHILDREN" SPParameterName="p_children" MaxLength="3" DataType="Integer" BindType="Both"></cc1:XUITextBox>
                                    <asp:RegularExpressionValidator ID="RegularExpressionValidator4" runat="server" ErrorMessage="Format Invalid!" ControlToValidate="txtChildren" ValidationExpression="[0-9 -.,/()+]*[0-9 -.,/()+]" Display="Dynamic" ></asp:RegularExpressionValidator>
                                   
                                </div>
                            </div>
                        </div>                    
                    </div>
                    <div class="row">
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4 ">Marital Status</label>
                                <div class="col-sm-7">
                                    <cc1:XUIDropDownList ID="ddlMarital" runat="server" CssClass="form-control" DBColumnName="MARITAL_CODE" SPParameterName="p_marital_code" DataType="String" BindType="Both" AutoPostBack="true" OnSelectedIndexChanged="ddlMarital_SelectedIndex"></cc1:XUIDropDownList>
                                </div>
                            </div>                            
                        </div> 
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4 ">Nationality</label>
                                <div class="col-sm-7">
                                    <cc1:XUIDropDownList ID="ddlNationality" runat="server" CssClass="form-control" DBColumnName="NATIONALITY_CODE" SPParameterName="p_nationality_code" DataType="String" BindType="Both"></cc1:XUIDropDownList>
                                </div>
                            </div>                            
                        </div>                         
                    </div>
                    <div class="row"> 
                         <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4"> Photo<p class="help-block">Size (4X6)</p></label>
                                <div class="col-sm-7">
                                    <%--<asp:Image ID="imgPhoto" runat="server"  Width="133px" Height="170px" ImageUrl='<%#Eval("imgPhoto") %>'></asp:Image>--%>
                                    <!-- -->
                                    <cc1:XUILabel ID="lblImageName" runat="server" DBColumnName="IMAGE_NAME" SPParameterName="p_image_name" DataType="String" BindType="Both" style="display:none"></cc1:XUILabel>
                                    <asp:FileUpload ID="fupPhoto" runat="server" />
                                    <asp:Image ID="imgPhoto" runat="server" Width="133px" Height="170px" ImageUrl='<%#Eval("imgPath") %>'></asp:Image>
                                </div>
                            </div>                            
                        </div>
                         <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4 ">Job Grade</label>
                                <div class="col-sm-7">
                                   <cc1:XUITextBox ID="txtJobGrade" runat="server" CssClass="form-control" placeholder="Job Grade" DBColumnName="JOB_GRADE" SPParameterName="p_job_grade" DataType="String" BindType="Both"></cc1:XUITextBox>
                                </div>
                            </div>                            
                        </div>        
                    </div>
               <%-- </ContentTemplate>
                <Triggers>
                    <asp:AsyncPostBackTrigger ControlID="btnSave" EventName="Click" />
                    <asp:AsyncPostBackTrigger ControlID="btnReActive" EventName="Click" />
                    <asp:AsyncPostBackTrigger ControlID="btnCancel" EventName="Click" />
                </Triggers>
            </asp:UpdatePanel>--%>
        </div>
    </section>
            
            <section class="panel form-horizontal">
                <header class="panel-heading">
                  <span>Address Info</span>
                </header>
                <div class="panel-body">
                    <div class="row">
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-3">City </label>
                                <div class="col-sm-7">
                                    <cc1:XUITextBox ID="txtCity" runat="server" CssClass="form-control" placeholder="City" DBColumnName="CITY" SPParameterName="p_city" MaxLength="20" DataType="String" BindType="Both"></cc1:XUITextBox>
                                   <%-- <asp:RequiredFieldValidator ID="rfvCity" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtCity" Display="Dynamic"></asp:RequiredFieldValidator>--%>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row"> 
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-3">Post Code </label>
                                <div class="col-sm-7">
                                    <cc1:XUITextBox ID="txtPostCode" runat="server" CssClass="form-control" placeholder="Post Code" DBColumnName="POST_CODE" SPParameterName="p_post_code" MaxLength="10" DataType="String" BindType="Both"></cc1:XUITextBox>
                                    <asp:RegularExpressionValidator ID="RegularExpressionValidator5" runat="server" ErrorMessage="Format Invalid!" ControlToValidate="txtPostCode" ValidationExpression="[0-9 -.,/()+]*[0-9 -.,/()+]" Display="Dynamic" ></asp:RegularExpressionValidator>
                                  <%--  <asp:RequiredFieldValidator ID="rvfPostCode" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtPostCode" Display="Dynamic"></asp:RequiredFieldValidator>--%>
                                </div>
                            </div>                            
                        </div>                        
                    </div>
                     <div class="row"> 
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-3">Address </label>
                                <div class="col-sm-8">
                                    <cc1:XUITextBox ID="txtAddress" runat="server" CssClass="form-control" placeholder="Address" DBColumnName="ADDRESS" SPParameterName="p_address" MaxLength="700" DataType="String" BindType="Both" TextMode="MultiLine"></cc1:XUITextBox>
                                   <%-- <asp:RequiredFieldValidator ID="rfvAddress" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtAddress" Display="Dynamic"></asp:RequiredFieldValidator>--%>
                                </div>
                            </div>                            
                        </div>                        
                    </div>
                </div>
            </section>
        </div>
        <div class="col-sm-4">
            <section class="panel form-horizontal">
                <div class="panel-body">
                <div class="row">                        
                        <div class="col-sm-12">
                            <div class="form-group">
                                <label class="col-sm-3">Status</label>
                                <div class="col-sm-9">
                                    <cc1:XUILabel ID="lblStatus" runat="server" DBColumnName="STATUS" DataType="String" BindType="DBToUIOnly"></cc1:XUILabel>
                                </div>
                            </div> 
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-sm-12"> 
                            <div class="form-group">
                                <label class="col-sm-3">Report To</label>
                                <div class="col-sm-9">
                                    <asp:LinkButton runat="server" ID="btnLookUpReportTo" class="btn btn-primary" data-toggle="modal" CausesValidation="false"><i class="icon-table"></i></asp:LinkButton>
                                    <cc1:XUITextBox ID="txtEmpCode" style="display:none" runat="server"  CssClass="form-control" DBColumnName="REPORT_TO" SPParameterName="p_report_to" DataType="String" BindType="Both"></cc1:XUITextBox>
                                    <cc1:XUILabel ID="lblEmpName" runat="server"  DBColumnName="REPORT_TO_NAME" DataType="String" BindType="DBToUIOnly" Text="-"></cc1:XUILabel>
                                </div>
                            </div> 
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-sm-12">
                            <div class="form-group">
                                <label class="col-sm-3">Branch</label>
                                <div class="col-sm-9">
                                    <cc1:XUIDropDownList ID="ddlBranch" runat="server" CssClass="form-control" DBColumnName="BRANCH_CODE" SPParameterName="p_branch_code" DataType="String" OnSelectedIndexChanged= "ddlBranch_SelectedIndex" AutoPostBack= "true" BindType="Both"></cc1:XUIDropDownList>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-sm-12">
                            <div class="form-group">
                                <label class="col-sm-3">Division</label>
                                <div class="col-sm-9">
                                    <asp:UpdatePanel ID="updDiv" runat="server">
                                        <ContentTemplate>
                                            <cc1:XUIDropDownList ID="ddlDivision" runat="server" CssClass="form-control" DBColumnName="DIVISION_CODE"  SPParameterName="p_division_code" OnSelectedIndexChanged= "ddlDivision_SelectedIndexChanged" AutoPostBack= "true" DataType="String" BindType="Both"></cc1:XUIDropDownList>
                                             <asp:RequiredFieldValidator ID="revddlDivision" runat="server" ControlToValidate="ddlDivision"
                                                 ErrorMessage="Value Required!" InitialValue="-"></asp:RequiredFieldValidator>
                                        </ContentTemplate>
                                    </asp:UpdatePanel>
                                </div>
                            </div>                             
                        </div>
                    </div>
                    <div class="row">
                         <div class="col-sm-12">
                            <div class="form-group">
                                <label class="col-sm-3">Department</label>
                                    <div class="col-sm-9">
                                        <asp:UpdatePanel ID="updDep" runat="server">
                                            <ContentTemplate>
                                                <cc1:XUIDropDownList ID="ddlDepartment" runat="server" CssClass="form-control" DBColumnName="DEPARTMENT_CODE" SPParameterName="p_department_code"  AutoPostBack= "true" OnSelectedIndexChanged= "ddlDepartment_SelectedIndexChanged" DataType="String" BindType="Both"></cc1:XUIDropDownList>
                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="Required Field!" ControlToValidate="ddlSubDepartment" InitialValue="0" Display="Dynamic"></asp:RequiredFieldValidator> 
                                        </ContentTemplate>
                                       <Triggers>
                                                <asp:AsyncPostBackTrigger ControlID="ddlDivision" EventName="SelectedIndexChanged" />
                                       </Triggers>
                                     </asp:UpdatePanel> 
                                </div>
                            </div>                             
                        </div>
                    </div>
                    <div class="row">
                         <div class="col-sm-12">
                            <div class="form-group">
                                <label class="col-sm-3">Sub Department</label>
                            <div class="col-sm-9">
                               <asp:UpdatePanel ID="updSub" runat="server">
                                 <ContentTemplate>
                                    <cc1:XUIDropDownList ID="ddlSubDepartment" runat="server" CssClass="form-control" DBColumnName="SUB_DEPARTMENT_CODE" SPParameterName="p_sub_department_code"  DataType="String" BindType="Both"  AutoPostBack= "true" OnSelectedIndexChanged= "ddlSubDepartment_SelectedIndexChanged" ></cc1:XUIDropDownList>
                                 </ContentTemplate>
                                 <Triggers>
                                     <asp:AsyncPostBackTrigger ControlID="ddlDepartment" EventName="SelectedIndexChanged" />
                                 </Triggers>
                               </asp:UpdatePanel>
                            </div>
                         </div>                            
                       </div>
                     </div>
                     <div class="row">
                         <div class="col-sm-12">
                            <div class="form-group">
                                <label class="col-sm-3">Units</label>
                                <div class="col-sm-9">
                                    <asp:UpdatePanel ID="updUn" runat="server">
                                        <ContentTemplate>
                                            <cc1:XUIDropDownList ID="ddlUnits" runat="server" CssClass="form-control" DBColumnName="UNITS_CODE" SPParameterName="p_units_code"  DataType="String" BindType="Both"></cc1:XUIDropDownList>
                                            <asp:RequiredFieldValidator ID="rfvddlUnits" runat="server" ErrorMessage="Required Field!" ControlToValidate="ddlUnits" InitialValue="0" Display="Dynamic"></asp:RequiredFieldValidator> 
                                        </ContentTemplate>
                                           <Triggers>
                                            <asp:AsyncPostBackTrigger ControlID="ddlSubDepartment" EventName="SelectedIndexChanged" />
                                       </Triggers>
                                    </asp:UpdatePanel>
                                </div>
                            </div>                             
                        </div>               
                    </div>
                    <div class="row">
                    <div class="col-sm-12">
                        <div class="form-group">
                            <div class="col-sm-3">
                                <label>Position</label>
                            </div>    
                            <div class="col-sm-9">
                                <div class="input-group">
                                    <asp:LinkButton runat="server" ID="btnLookupPosition" class="btn btn-primary" data-toggle="modal" CausesValidation="false"><i class="icon-table"></i></asp:LinkButton>
                                    <cc1:XUITextBox ID="txtCode" CssClass="form-control" runat="server"  DBColumnName="POSITION_CODE" DataType="String" BindType="Both" SPParameterName="p_position_code" Text="-"  Width="100px" style="border:0px; background:inherit; display:none" ></cc1:XUITextBox>
                                  
                                    <cc1:XUITextBox ID="txtDesc" Enabled="false"  runat="server" DBColumnName="DESCRIPTION" DataType="String" BindType="DBToUIOnly" TextMode="MultiLine"  style="border:0; background:inherit;"></cc1:XUITextBox>
                                    <asp:RequiredFieldValidator ID="rfvPosition" runat="server"  ErrorMessage="Required Field!" ToolTip="Please fill this field." ControlToValidate="txtCode" Display="Dynamic"></asp:RequiredFieldValidator>
                                </div>
                            </div>
                           
                        </div>                            
                    </div>
                </div>
                    
                </div>
            </section>
            
              <section class="panel form-horizontal">
                <header class="panel-heading">
                  <span>Contact Info</span>
                </header>
                <div class="panel-body">
                    <div class="row">
                        <div class="col-sm-12">
                            <div class="form-group">
                                <label class="col-sm-3">Phone</label>
                                <div class="col-sm-9">
                                    <cc1:XUITextBox ID="txtPhone" runat="server" CssClass="form-control" placeholder="Phone No" DBColumnName="PHONE_NO" SPParameterName="p_phone_no" MaxLength="15" DataType="String" BindType="Both"></cc1:XUITextBox>
                                    <asp:RegularExpressionValidator ID="revPhoneNo" runat="server" ErrorMessage="Format Invalid!" ControlToValidate="txtPhone" ValidationExpression="[0-9 -.,/()+]*[0-9 -.,/()+]" Display="Dynamic" ></asp:RegularExpressionValidator>
                                </div>
                            </div>                            
                        </div>  
                      <div class="row">
                      </div>
                        <div class="col-sm-12">
                            <div class="form-group">
                                <label class="col-sm-3">HandPhone</label>
                                <div class="col-sm-9">
                                    <cc1:XUITextBox ID="txtHandPhone" runat="server" CssClass="form-control" placeholder="HandPhone No" DBColumnName="HANDPHONE_NO" SPParameterName="p_handphone_no" MaxLength="15" DataType="String" BindType="Both"></cc1:XUITextBox>
                                    <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ErrorMessage="Format Invalid!" ControlToValidate="txtHandPhone" ValidationExpression="[0-9 -.,/()+]*[0-9 -.,/()+]" Display="Dynamic" ></asp:RegularExpressionValidator>
                                </div>
                            </div>
                        </div>                      
                    </div>
                    <div class="row">
                        <div class="col-sm-12">
                            <div class="form-group">
                                <label class="col-sm-3">Email</label>
                                <div class="col-sm-9">
                                    <cc1:XUITextBox ID="txtEmail" runat="server" CssClass="form-control" placeholder="Email" DBColumnName="EMAIL" SPParameterName="p_email" MaxLength="200" DataType="String" BindType="Both"></cc1:XUITextBox>
                                    <asp:RegularExpressionValidator ID="revEmail" runat="server" 
                                    ErrorMessage="Email Not Valid" 
                                    ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" ControlToValidate="txtEmail" Display="Dynamic"></asp:RegularExpressionValidator>
                                </div>
                            </div>
                        </div>
                        </div>
                        <div class="row">
                        <div class="col-sm-12">
                            <div class="form-group">
                                <label class="col-sm-3">Other Email</label>
                                <div class="col-sm-9">
                                    <cc1:XUITextBox ID="txtAltEmail" runat="server" CssClass="form-control" placeholder="Alternative Email" DBColumnName="EMAIL2" SPParameterName="p_email2" MaxLength="200" DataType="String" BindType="Both"></cc1:XUITextBox>
                                </div>
                            </div>
                        </div>                        
                    </div>
                </div>
            </section>
             <section class="panel form-horizontal">
                <div class="panel-body">
                    <div class="row">
                        <div class="col-sm-12">
                            <div class="form-group">
                                <label class="col-sm-5">ID No. </label>
                                <div class="col-sm-7">
                                    <cc1:XUITextBox ID="txtIDNo" runat="server" CssClass="form-control" placeholder="ID/SIM/Passport No" DBColumnName="ID_NO" SPParameterName="p_id_no" MaxLength="20" DataType="String" BindType="Both"></cc1:XUITextBox>
                                    <%--<asp:RegularExpressionValidator ID="RegularExpressionValidator6" runat="server" ErrorMessage="Format Invalid!" ControlToValidate="txtIDNo" ValidationExpression="[0-9 -.,/()+]*[0-9 -.,/()+]" Display="Dynamic" ></asp:RegularExpressionValidator>
                                    <asp:RequiredFieldValidator ID="rfvIDNo" runat="server" ErrorMessage="Required Field!" ControlToValidate="txtIDNo" Display="Dynamic"></asp:RequiredFieldValidator>--%>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-sm-12">
                            <div class="form-group">
                                <label class="col-sm-5">NPWP</label>
                                <div class="col-sm-7">
                                    <cc1:XUITextBox ID="txtNPWP" runat="server" CssClass="form-control" placeholder="NPWP No" DBColumnName="NPWP_NO" SPParameterName="p_npwp_no" MaxLength="20" DataType="String" BindType="Both"></cc1:XUITextBox>
                                    <asp:RegularExpressionValidator Display="Dynamic" ID="revNPWP" runat="server" ErrorMessage="Format is incorrect! Format = 00.000.000.0-000.000" ControlToValidate="txtNPWP" ValidationExpression="([0-9 ]{2}\.[0-9 ]{3}\.[0-9 ]{3}\.[0-9 ]{1}\-[0-9 ]{3}\.[0-9]{3})" />
                                </div>
                            </div>   
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-sm-12">
                            <div class="form-group">
                                <label class="col-sm-5">BPJS No</label>
                                <div class="col-sm-7">
                                    <cc1:XUITextBox ID="txtJamsostek" runat="server" CssClass="form-control" placeholder="Jamsostek No" DBColumnName="JAMSOSTEK_NO" SPParameterName="p_jamsostek_no" MaxLength="20" DataType="String" BindType="Both"></cc1:XUITextBox>
                                    <asp:RegularExpressionValidator ID="RegularExpressionValidator8" runat="server" ErrorMessage="Format Invalid!" ControlToValidate="txtJamsostek" ValidationExpression="[0-9 -.,/()+]*[0-9 -.,/()+]" Display="Dynamic" ></asp:RegularExpressionValidator>
                                </div>
                            </div>   
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-sm-12">
                            <div class="form-group">
                                <label class="col-sm-5">Pension</label>
                                <div class="col-sm-7">
                                    <cc1:XUITextBox ID="txtPension" runat="server" CssClass="form-control" placeholder="Pension No" DBColumnName="PENSION_NO" SPParameterName="p_pension_no" MaxLength="20" DataType="String" BindType="Both"></cc1:XUITextBox>
                                    <asp:RegularExpressionValidator ID="RegularExpressionValidator9" runat="server" ErrorMessage="Format Invalid!" ControlToValidate="txtPension" ValidationExpression="[0-9 -.,/()+]*[0-9 -.,/()+]" Display="Dynamic" ></asp:RegularExpressionValidator>
                                </div>
                            </div>
                        </div>
                    </div>
                  
                </div>
            </section>
        </div>
    </div>
       
        <asp:Panel runat="server" ID="pnlAllEmployee">
        <section class="panel">
        <header class="panel-heading tab-bg-dark-navy-blue">
            <ul class="nav nav-tabs nav-justified">
              <li class="active">
                  <a href="#EmployeeBranch" id="employeenotificationsubscribe" onclick="javascript:fnSetTab('employeenotificationsubscribe');" style="padding-bottom:28px" data-toggle="tab" >
                      Staff Branch
                  </a>
              </li>
              <li class="">
                  <a href="#Widget" id="employeenotificationsubscribe" onclick="javascript:fnSetTab('employeenotificationsubscribe');" style="padding-bottom:28px" data-toggle="tab" >
                      Widget Subscribe
                  </a>
              </li>
              <li class="">
                  <a href="#loginlog" id="employeenotificationsubscribe" onclick="javascript:fnSetTab('employeenotificationsubscribe');" style="padding-bottom:28px" data-toggle="tab" >
                      Login Log
                  </a>
              </li>
              <li class="">
                  <a href="#activitylog" id="employeenotificationsubscribe" onclick="javascript:fnSetTab('employeenotificationsubscribe');" style="padding-bottom:28px" data-toggle="tab" >
                      Activity Log
                  </a>
              </li>
               <li class="" runat="server" id="notification">
                  <a href="#notification" id="employeenotificationsubscribe" onclick="javascript:fnSetTab('employeenotificationsubscribe');" style="padding-bottom:28px" data-toggle="tab" >
                      Notification Subscribe
                  </a>
              </li>
          </ul>
        </header>
        
        <div class="panel-body">                    
            <div class="tab-content tasi-tab">
              <div class="tab-pane active" id="EmployeeBranch">
                <div class="panel-heading">
                    <div class="row">
                        <div class="col-sm-8 ">
                            <cc1:XUILinkButton ID="btnAddEmp" RoleCode="R40000010C" runat="server" CssClass="btn btn-primary" OnClick="btnAddEmp_Click"><i class="icon-plus"></i>  Create</cc1:XUILinkButton>
                            <cc1:XUILinkButton ID="btnDeleteEmp" RoleCode="R40000010E" runat="server" CssClass="btn btn-danger" OnClick="btnDeleteEmp_Click"><i class="icon-trash"></i>  Delete</cc1:XUILinkButton>
                        </div>
                        <asp:Panel ID="pnlSearchEmp" runat="server" DefaultButton="btnSearchEmp"     class="input-group">
                            <div class="input-group">
                                <asp:TextBox ID="txtSearchEmp" runat="server" CssClass="form-control" placeholder="Keywords"></asp:TextBox>  
                                <div class="input-group-btn">
                                    <asp:LinkButton ID="btnSearchEmp" runat="server" CssClass="btn btn-info" OnClick="btnSearchEmp_Click"><i class="icon-search"></i>  Search</asp:LinkButton>
                                </div>
                            </asp:Panel>
                        </div>
                    </div>
                </div>
                <div class="panel-body">
                    <asp:UpdatePanel ID="UpdEmp" runat="server">
                        <ContentTemplate>
                            <asp:GridView ID="gvwListEmp" runat="server" AutoGenerateColumns="false" CssClass="display table table-bordered table-striped"
                                 AllowPaging="true" PageSize="10" DataKeyNames="ID"
                                OnPageIndexChanging="gvwListEmp_PageIndexChanging" 
                                onselectedindexchanged="gvwListEmp_SelectedIndexChanged" EmptyDataText="There is no data">
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
                                            <asp:CheckBox runat="server" ID="chbCheckedAllEmp" AutoPostBack="true" OnCheckedChanged="chbCheckedAllEmp_CheckedChanged"/>
                                        </HeaderTemplate>
                                        <ItemTemplate>
                                            <asp:CheckBox runat="server" ID="chbCheckedEmp"/>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:BoundField DataField="DESCRIPTION" HeaderText="Branch">
                                        <ItemStyle Width="30%"/>
                                    </asp:BoundField>
                                    <asp:BoundField DataField="NAME" HeaderText="Group Role">
                                        <ItemStyle Width="50%"/>
                                    </asp:BoundField>
                                     <asp:BoundField DataField="IS_BASE" HeaderText="Home Base" SortExpression="IS_BASE">
                                        <ItemStyle Width="20%"/>
                                    </asp:BoundField>
                                    <asp:CommandField ShowSelectButton="true" />
                                </Columns>
                            </asp:GridView>
                        </ContentTemplate>
                        <Triggers>
                            <asp:AsyncPostBackTrigger ControlID="btnSearchEmp" EventName="Click" />
                            <asp:AsyncPostBackTrigger ControlID="btnDeleteEmp" EventName="Click" />
                        </Triggers>
                    </asp:UpdatePanel>
                 </div>
                </div>
                
                <div class="tab-pane" id="Widget">
                    <div class="panel-heading">
                        <div class="row">
                            <div class="col-sm-8" >
                                <!-- Subscription pop up here-->
                                <cc1:XUILinkButton runat="server" ID="btnSubscriptionWidget" RoleCode="R03000003E" CssClass="btn btn-primary" data-toggle="modal" CausesValidation="false"><i class="icon-plus"></i>  Create</cc1:XUILinkButton>
                                <cc1:XUILinkButton ID="btnDeleteSubscribeWidget" RoleCode="R03000003E" runat="server" CssClass="btn btn-danger" onclick="btnDeleteSubscribeWidget_OnClick"><i class="icon-trash"></i>  Delete</cc1:XUILinkButton>                                      
                            </div>
                            <div class="col-sm-4">
                                <asp:Panel ID="pnlSearch" runat="server" DefaultButton="btnSearchWid" class="input-group">
                                    <asp:TextBox ID="txtSearchWid" runat="server" CssClass="form-control" placeholder="Keywords"></asp:TextBox>  
                                    <div class="input-group-btn">
                                        <asp:LinkButton ID="btnSearchWid" runat="server" CssClass="btn btn-info" OnClick="btnSearchWid_Click" CausesValidation="false"><i class="icon-search"></i>  Search</asp:LinkButton>
                                    </div>
                                </asp:Panel>
                            </div>
                        </div>
                    </div>
                    <div class="panel-body">
                        <asp:UpdatePanel ID="updWidget" runat="server">
                            <ContentTemplate>
                                <asp:GridView ID="gvwListWidget" runat="server" 
                                    AutoGenerateColumns="false" CssClass="display table table-bordered table-striped"
                                    AllowPaging="true" PageSize="10" OnPageIndexChanging="gvwListWidget_PageIndexChanging" 
                                    onselectedindexchanged="gvwListWidget_SelectedIndexChanged"
                                    DataKeyNames="EMP_CODE, WIDGET_CODE" EmptyDataText="There is no data">
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
                                                <asp:CheckBox runat="server" ID="chbWidgetCheckedAll" AutoPostBack="true" OnCheckedChanged="chbWidgetCheckedAll_CheckedChanged"/>
                                            </HeaderTemplate>
                                            <ItemTemplate>
                                                <asp:CheckBox runat="server" ID="chbWidgetChecked"/>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:BoundField DataField="WIDGET_DESC" HeaderText="Widget">
                                            <ItemStyle Width="90%" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="ORIENTATION" HeaderText="Orientation">
                                            <ItemStyle Width="10%" />
                                        </asp:BoundField>
                                        <asp:CommandField ShowSelectButton="true" />
                                    </Columns>
                                </asp:GridView>
                            </ContentTemplate>
                            <Triggers>
                                <asp:AsyncPostBackTrigger ControlID="btnSearchWid" EventName="Click" />
                                <asp:AsyncPostBackTrigger ControlID="btnDeleteSubscribeWidget" EventName="Click" />
                            </Triggers>
                        </asp:UpdatePanel>
                    </div>
                </div> 
                   <div class="tab-pane" id="loginlog">                            
                    <div class="panel-heading">
                        <div class="row">
                            <div class="col-sm-6" >
                                <div class="input-group">
                                     <asp:TextBox ID="txtYearLoginLog" runat="server" CssClass="form-control" placeholder="Year" MaxLength="4" Width="70"></asp:TextBox>
                                     <asp:RequiredFieldValidator ID="rfvYearLoginLog" runat="server" ErrorMessage="*" ControlToValidate="txtYearLoginLog" Display="Dynamic"></asp:RequiredFieldValidator>
                                     <asp:TextBox ID="txtMonthLoginLog" runat="server" CssClass="form-control" placeholder="Month" MaxLength="2" Width="70"></asp:TextBox>   
                                     <asp:RequiredFieldValidator ID="rfvMonthLoginLog" runat="server" ErrorMessage="*" ControlToValidate="txtMonthLoginLog" Display="Dynamic"></asp:RequiredFieldValidator>                                                                    
                                     <cc1:XUILinkButton ID="btnViewGvwListLoginLog" RoleCode="R03000003E" runat="server" CssClass="btn btn-primary" onclick="btnViewGvwListLoginLog_OnClick"><i class="icon-plus"></i>  View</cc1:XUILinkButton>                                   
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="panel-body">
                        <asp:UpdatePanel ID="updLoginLog" runat="server">
                            <ContentTemplate>
                                <asp:GridView ID="gvwListLoginLog" runat="server" AutoGenerateColumns="false" CssClass="display table table-bordered table-striped"
                                    AllowPaging="true" PageSize="10" DataKeyNames="ID" OnPageIndexChanging="gvwListLoginLog_PageIndexChanging"
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
                                        <asp:BoundField DataField="LOGIN_DATE" HeaderText="Login Date" DataFormatString="{0:dd/MM/yyyy HH:mm}">
                                            <ItemStyle Width="40%" HorizontalAlign="Center"/>
                                        </asp:BoundField>
                                        <asp:BoundField DataField="IP_ADDRESS" HeaderText="IP Address">
                                            <ItemStyle Width="40%" HorizontalAlign="Center"/>
                                        </asp:BoundField>
                                        <asp:BoundField DataField="FLAG_CODE" HeaderText="Status">
                                            <ItemStyle Width="20%"/>
                                        </asp:BoundField>
                                    </Columns>
                                </asp:GridView>
                            </ContentTemplate>
                            <Triggers>
                                <asp:AsyncPostBackTrigger ControlID="btnViewGvwListLoginLog" EventName="Click" />
                            </Triggers>
                        </asp:UpdatePanel>
                    </div>
                </div>
                
                <div class="tab-pane" id="activitylog">                            
                    <div class="panel-heading">
                        <div class="row">
                            <div class="col-sm-6" >
                                <div class="input-group">
                                     <asp:TextBox ID="txtYearActivityLog" runat="server" CssClass="form-control" placeholder="Year" MaxLength="4" Width="70"></asp:TextBox>
                                     <asp:RequiredFieldValidator ID="rfvYearActivityLog" runat="server" ErrorMessage="*" ControlToValidate="txtYearActivityLog" Display="Dynamic"></asp:RequiredFieldValidator>
                                     <asp:TextBox ID="txtMonthActivityLog" runat="server" CssClass="form-control" placeholder="Month" MaxLength="2" Width="70"></asp:TextBox>   
                                     <asp:RequiredFieldValidator ID="rfvMonthActivityLog" runat="server" ErrorMessage="*" ControlToValidate="txtMonthActivityLog" Display="Dynamic"></asp:RequiredFieldValidator>                                                                    
                                     <cc1:XUILinkButton ID="btnViewGvwListActivityLog" RoleCode="R03000003E" runat="server" CssClass="btn btn-primary" onclick="btnViewGvwListActivityLog_OnClick"><i class="icon-plus"></i>  View</cc1:XUILinkButton>                                   
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="panel-body">
                        <asp:UpdatePanel ID="updActivityLog" runat="server">
                            <ContentTemplate>
                                <asp:GridView ID="gvwListActivityLog" runat="server" AutoGenerateColumns="false" CssClass="display table table-bordered table-striped"
                                    AllowPaging="true" PageSize="10" DataKeyNames="ID" OnPageIndexChanging="gvwListActivityLog_PageIndexChanging"
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
                                        <asp:BoundField DataField="ACTIVITY_DATE" HeaderText="Activity Date" DataFormatString="{0:dd/MM/yyyy HH:mm}">
                                            <ItemStyle Width="20%" HorizontalAlign="Center"/>
                                        </asp:BoundField>
                                        <asp:BoundField DataField="ACTIVITY_TYPE_CODE" HeaderText="Activity Type">
                                            <ItemStyle Width="20%"/>
                                        </asp:BoundField>
                                        <asp:BoundField DataField="REMARK" HeaderText="Remark">
                                            <ItemStyle Width="60%"/>
                                        </asp:BoundField>
                                    </Columns>
                                </asp:GridView>
                            </ContentTemplate>
                            <Triggers>
                                <asp:AsyncPostBackTrigger ControlID="btnViewGvwListActivityLog" EventName="Click" />
                            </Triggers>
                        </asp:UpdatePanel>
                    </div>
                </div>
                  <div class="tab-pane" id="notification">
                    <div class="panel-heading">
                        <div class="row">
                            <div class="col-sm-8" >
                                <!-- Subscription pop up here-->
                                <cc1:XUILinkButton RoleCode="R07000003C" runat="server" ID="btnSubscriptionNotifi" class="btn btn-primary" data-toggle="modal" CausesValidation="false"><i class="icon-plus"></i>  Create</cc1:XUILinkButton>
                                <cc1:XUILinkButton RoleCode="R07000003D" ID="btnDeleteSubscribeNotifi" runat="server" 
                                     CssClass="btn btn-danger" onclick="btnDeleteSubscribeNotifi_OnClick"><i class="icon-trash"></i>  Delete</cc1:XUILinkButton>                                      
                            </div>
                            <div class="col-sm-4">
                                <asp:Panel ID="pnlSearchNotif" runat="server" DefaultButton="btnSearchNotif" class="input-group">
                                    <asp:TextBox ID="txtSearchNotif" runat="server" CssClass="form-control" placeholder="Keywords"></asp:TextBox>  
                                    <div class="input-group-btn">
                                        <asp:LinkButton ID="btnSearchNotif" runat="server" CssClass="btn btn-info" OnClick="btnSearchNotif_Click" CausesValidation="false"><i class="icon-search"></i>  Search</asp:LinkButton>
                                    </div>
                                </asp:Panel>
                            </div>
                        </div>
                    </div>
                 <div class="panel-body">
                        <asp:UpdatePanel ID="updNotifi" runat="server">
                            <ContentTemplate>
                                <asp:GridView ID="gvwListNotifi" runat="server" 
                                    AutoGenerateColumns="false" CssClass="display table table-bordered table-striped"
                                    AllowPaging="true" PageSize="10" OnPageIndexChanging="gvwListNotifi_PageIndexChanging"
                                    DataKeyNames="EMP_CODE, NOTIFI_CODE" EmptyDataText="There is no data">
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
                                        <asp:BoundField DataField="NOTIFI_DESC" HeaderText="Notification">
                                            <ItemStyle Width="40%" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="NOTIFI_MESSAGE" HeaderText="Message">
                                            <ItemStyle Width="60%" />
                                        </asp:BoundField>
                                    </Columns>
                                </asp:GridView>
                            </ContentTemplate>
                            <Triggers>
                                <asp:AsyncPostBackTrigger ControlID="btnSearchNotif" EventName="Click" />
                                <asp:AsyncPostBackTrigger ControlID="btnDeleteSubscribeNotifi" EventName="Click" />
                            </Triggers>                            
                        </asp:UpdatePanel>
                    </div>
            </div>
    </section> 
    </asp:Panel>
</asp:Content>
