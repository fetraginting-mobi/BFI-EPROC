<%@ Control Language="C#" AutoEventWireup="true" CodeFile="wcbirthdayinfo.ascx.cs" Inherits="widget_wcbirthdayinfo" %>

<%@ Register Assembly="MPF23.XUI" Namespace="MPF23.XUI.Control" TagPrefix="cc1" %>

<section class="panel">
    <header class="panel-heading">
      <span>Birthday Info</span>
    </header>
    <div class="panel-body">
        <div class="row">
            <div class="col-sm-12">
                <div class="row">
                    <div class="form-group">                        
                        <div class="col-sm-12">
                            <span>Birthday list on </span>
                            <cc1:XUILabel ID="lblMonth" runat="server" DataType="String"></cc1:XUILabel>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="panel-body">
                        <asp:UpdatePanel ID="updBDay" runat="server">
                            <ContentTemplate>
                                <cc1:XUIGridView ID="gvwListBDay" runat="server" AutoGenerateColumns="false" CssClass="display table table-bordered table-striped" AllowPaging="true" PageSize="5" DataKeyNames="EMP_CODE" OnPageIndexChanging="gvwListBDay_PageIndexChanging" EmptyDataText="No Birthday This Month">
                                    <Columns>
                                        <asp:BoundField DataField="EMP_NAME" HeaderText="Name">
                                            <ItemStyle Width="60%"/>
                                        </asp:BoundField>
                                        <asp:BoundField DataField="DATE_OF_BIRTH" HeaderText="Date Of Birth" DataFormatString="{0:dd/MM/yyyy}">
                                            <ItemStyle Width="30%" HorizontalAlign="Center"/>
                                        </asp:BoundField>
                                        <asp:BoundField DataField="AGE" HeaderText="Age">
                                            <ItemStyle Width="10%" HorizontalAlign="Center"/>
                                        </asp:BoundField>
                                    </Columns>
                                </cc1:XUIGridView>
                            </ContentTemplate>
                        </asp:UpdatePanel>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>
