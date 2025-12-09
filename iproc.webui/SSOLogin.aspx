<%@ Page Language="C#" AutoEventWireup="true" CodeFile="SSOLogin.aspx.cs" Inherits="SSOLogin" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="">
    <meta name="author" content="Mosaddek">
    <meta name="keyword" content="FlatLab, Dashboard, Bootstrap, Admin, Template, Theme, Responsive, Fluid, Retina">
    <link rel="shortcut icon" href="img/favicon.png">
    <title>iProcurement</title>
    <!-- Bootstrap core CSS -->
    <link href="css/bootstrap.min.css" rel="stylesheet">
    <link href="css/bootstrap-reset.css" rel="stylesheet">
    <!--external css-->
    <link href="assets/font-awesome/css/font-awesome.css" rel="stylesheet" />
    <!-- Custom styles for this template -->
    <link href="css/style.css" rel="stylesheet">
    <link href="css/style-responsive.css" rel="stylesheet" />
    <!-- HTML5 shim and Respond.js IE8 support of HTML5 tooltipss and media queries -->
    <!--[if lt IE 9]>
    <script src="js/html5shiv.js"></script>
    <script src="js/respond.min.js"></script>
    <![endif]-->

    <script src="js/jquery.js"></script>

    <script src="js/bootstrap.min.js"></script>

    <script src="js/hris.js"></script>
</head>
<body class="login-body">
    <form id="Form1" class="form-signin" runat="server">
        <div class="auth-box">
            <div class="auth-title">Authentication Required</div>
            <div class="auth-desc">
                You will be redirected to SSO Provider for credentials verification.
            </div>
            <%--<asp:button ID="btnSignIn" runat="server" class="btn btn-sso" Text="Start SSO Login" OnClick="btnSignIn_Click" />--%>
                <%--<asp:span class="glyphicon glyphicon-log-in lock-icon"></span>     --%>      
                           
            <%--</button>--%>
            <button id="btnSignIn" runat="server" class="btn btn-sso" onserverclick="btnSignIn_Click">
                <span class="glyphicon glyphicon-log-in lock-icon"></span> Start SSO Login
            </button>
        </div>
   </form>
</body>
</html>
