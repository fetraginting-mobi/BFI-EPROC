<%@ Control Language="C#" AutoEventWireup="true" CodeFile="wcheader.ascx.cs" Inherits="wcheader" %>

<link rel="stylesheet" type="text/css" href="css/headermenu.css" />
<script src="js/modernizr.custom.js"></script>

<div class="sidebar-toggle-box">
    <div data-original-title="Toggle Navigation" data-placement="right" class="icon-reorder tooltips">
    </div>
</div>
<!--logo start-->
<a href="main.aspx" class="logo">i<span>Procurement</span></a>
<!--logo end-->
<!--  notification start -->
<%--<ul class="nav top-menu" id="ModuleList" runat="server"></ul>
--%>
<ul class="nav top-menu top-module" id="module-holder">
    <li>
        <div class="moduleitem" onclick="selmodule(this)">
            <a href="javascript:jsRenderMenu('DAS');">
                <img src="img/module/dashboard.png" alt="Dashboard" title="Dashboard" />
                 <p style="font-size:x-small">Dashboard</p>
            </a>
        </div>
    </li>
    <li>
        <div class="moduleitem" onclick="selmodule(this)">
            <a href="javascript:jsRenderMenu('PAR');">
                <img src="img/module/sysparam.png" alt="System Parameter" title="Setting" />
                 <p style="font-size:x-small">Setting</p>
            </a>
        </div>
   </li>
    <li>
        <div class="moduleitem" onclick="selmodule(this)">
            <a href="javascript:jsRenderMenu('ADM');">
                <img src="img/module/sysadmin.png" alt="System Admin" title="Parameter"/>
                 <p style="font-size:x-small">Parameter</p>
            </a>
        </div>
    </li>
    <li>
        <div class="moduleitem" onclick="selmodule(this)">
            <a href="javascript:jsRenderMenu('SEC');">
                <img src="img/module/syssecurity.png" alt="System Security" title="Security" />
                 <p style="font-size:x-small">Security</p>
            </a>
        </div>
    </li>
    <li>
        <div class="moduleitem" onclick="selmodule(this)">
            <a href="javascript:jsRenderMenu('POR');">
                <img src="img/module/purchaseorder.png" alt="Purchase Order" title="Purchase Order" />
                 <p style="font-size:x-small">Purchase Order</p>
            </a>
        </div>
    </li>
    <li>
        <div class="moduleitem" onclick="selmodule(this)">
            <a href="javascript:jsRenderMenu('INV');">
                <img src="img/module/inventory.png" alt="Inventory" title="Inventory" />
                 <p style="font-size:x-small">Inventory</p>
            </a>
        </div>
    </li>
    <li>
        <div class="moduleitem" onclick="selmodule(this)">
            <a href="javascript:jsRenderMenu('ACP');">
                <img src="img/module/ap.png" alt="Account Payable" title="Account Payable" />
                 <p style="font-size:x-small">Account Payable</p>
            </a>
        </div>
    </li>
    <li>
        <div class="moduleitem" onclick="selmodule(this)">
            <a href="javascript:jsRenderMenu('FIX');">
                <img src="img/module/fixedasset.png" alt="Fixed Asset" title="Fixed Asset" />
                 <p style="font-size:x-small">Fixed Asset</p>
            </a>
        </div>
    </li>
    <li>
        <div class="moduleitem" onclick="selmodule(this)">
            <a href="javascript:jsRenderMenu('FIN');">
                <img src="img/module/finance.png" alt="Finance" title="Finance"/>
                 <p style="font-size:x-small">Finance</p>
            </a>
        </div>
    </li>
    <li>
        <div class="moduleitem" onclick="selmodule(this)">
            <a href="javascript:jsRenderMenu('ACC');">
                <img src="img/module/accounting.png" alt="Accounting" title="Accounting" />
                 <p style="font-size:x-small">Accounting</p>
            </a>
        </div>
    </li>
    <li>
        <div class="moduleitem" onclick="selmodule(this)">
            <a href="javascript:jsRenderMenu('SPL');">
                <img src="img/module/supplier.png" alt="Supplier" title="Supplier" />
                 <p style="font-size:x-small">Supplier</p>
            </a>
        </div>
    </li>
    <li>
        <div class="moduleitem" onclick="selmodule(this)">
            <a href="javascript:jsRenderMenu('RPT');">
                <img src="img/module/report.png" alt="Report" title="Report" />
                 <p style="font-size:x-small">Report</p>
            </a>
        </div>
    </li>
    <li>
        <div class="moduleitem" onclick="selmodule(this)">
            <a href="javascript:jsRenderMenu('UTI');">
                <img src="img/module/utility.png" alt="Utility" title="Utility"/>
                 <p style="font-size:x-small">Utility</p>
            </a>
        </div>
    </li>
</ul>

 <div class="top-nav header-notify pull-right" id="top_menu">
    <!--  notification start -->
    <ul class="nav top-menu" id="notif">
        <!-- notification dropdown start-->
        <!-- notification dropdown end -->
    </ul>
    <!--  notification end -->
</div>

<div class="top-nav holder-user-session" id="topnav">
    <!--search & user info start-->
    <ul class="nav top-menu">
        <%--<li>
            <input type="text" class="form-control search" placeholder="Search">
        </li>--%>
        <!-- user login dropdown start-->
        <!-- user login dropdown start-->
        <li class="dropdown"><a data-toggle="dropdown" class="dropdown-toggle" href="#">
            <%--<img alt="" src="img/avatar1_small.jpg">--%>
            <%--<span class="username">{{user.fullname}}</span> <b class="caret"></b></a>--%>
            <span class="username">
                <asp:Label ID="lblFullname" runat="server" Text="-"></asp:Label></span> <b class="caret">
                </b></a>
            <ul class="dropdown-menu extended logout">
                <div class="log-arrow-up">
                </div>
                <div class="branch-div2">
                    <asp:Label ID="lblBranchDesc2" runat="server" CssClass="form-control"></asp:Label>
                </div>
                <li><a href="module/shared/profile.aspx" target="ifr"><i class="icon-suitcase"></i>Profile</a></li>
                <li><a href="module/shared/setting.aspx" target="ifr"><i class="icon-cog"></i>Settings</a></li>
                <li><a href="module/shared/notification.aspx" target="ifr"><i class="icon-bell-alt"></i>Notification</a></li>
                <li><a href="module/shared/myapproval.aspx" target="ifr"><i class="icon-ok-sign"></i>My Approval</a></li>
                <li><a href="module/shared/approvalhistory.aspx" target="ifr"><i class="icon-cogs"></i>Approval History</a></li>
                <li><a href="logout.aspx"><i class="icon-key"></i>Log Out</a></li>
            </ul>
        </li>
        <!-- user login dropdown end -->
        <!-- branch-->
        <li>
            <div class="branch-div">
                <asp:Label ID="lblBranchCode" runat="server" Style="display: none;"></asp:Label>
                <span><asp:Label ID="lblBranchDesc" runat="server" CssClass="form-control"></asp:Label></span>
            </div>
        </li>
    </ul>
    <!--search & user info end-->
</div>

<img class="toggle-right rotate-img-180" src="img/left-arrow-black.png"/>

<div class="toggle-user-session pull-right" onclick="showHideUserSession();">
    <img src="img/module/utility.png"/>
</div>