<%@ Page Title="" Language="C#" MasterPageFile="~/iproc.master" AutoEventWireup="true" CodeFile="gloperationreportlist.aspx.cs" Inherits="module_report_gloperationreportlist" %>

<%@ Register Assembly="MPF23.XUI" Namespace="MPF23.XUI.Control" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="cph" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cpb" Runat="Server">
    <section class="panel">
        <header class="panel-heading">
          <span>G/L Operation Reports</span>
        </header>
        <header class="panel-heading tab-bg-dark-navy-blue">
          <ul class="nav nav-tabs nav-justified">
              <li class="active">
                  <a href="#trial" data-toggle="tab">Trial Balance</a>
              </li>
              <li class="">
                  <a href="#ledger" data-toggle="tab">Ledger</a>
              </li>
          </ul>
        </header>
         <div class="panel-body">
            <div class="tab-content tasi-tab">
                <div class="tab-pane active" id="trial">
                    <div class="row">
                        <div class="col-sm-4">
                            <div class="form-group">
                                 <label class="col-sm-4">Accounting Period</label>
                            </div>
                        </div>
                        <div class="col-sm-6">
                            <div class="form-group">
                                <cc1:XUIDropDownList ID="ddlAccPeriod" runat="server" BindType="None" DataType="String"></cc1:XUIDropDownList>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="tab-pane" id="ledger">
                    <div class="row">
                        
                    </div>
                    <div>
                        <div class="form-group"></div>
                    </div>
                    <div class="row">
                        
                    </div>   
                </div>
            </div>
        </div>
    </section>
</asp:Content>

