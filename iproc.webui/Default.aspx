<%@ Page Language="C#" AutoEventWireup="true"  CodeFile="Default.aspx.cs" Inherits="_Default" %>

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
    <div class="container">
        <form id="Form1" class="form-signin" runat="server">
        <h2 class="form-signin-heading">
            sign in now</h2>
        <div class="login-wrap">
            <asp:TextBox ID="txtUID" runat="server" class="form-control" placeholder="User ID"
                MaxLength="10"></asp:TextBox>
            <asp:TextBox ID="txtPassword" runat="server" class="form-control" placeholder="Password"
                TextMode="Password"></asp:TextBox>
            <label class="checkbox">
                <span>
                </span>
            </label>
            <asp:Button ID="btnSignIn" runat="server" Text="Sign In" class="btn btn-lg btn-login btn-block"
                OnClick="btnSignIn_Click" />
        </div>
        <!-- Modal -->
        <%--<div aria-hidden="true" aria-labelledby="myModalLabel" role="dialog" tabindex="-1"
            id="ModalBranch" class="modal fade">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                            &times;</button>
                        <h4 class="modal-title">
                            Branch</h4>
                    </div>
                    <div class="modal-body">
                        <asp:DropDownList ID="ddlBranch" runat="server" CssClass="form-control"></asp:DropDownList>
                    </div>
                    <div class="modal-footer">
                        <asp:Button ID="btnProcess" runat="server" Text="Process" class="btn btn-success" OnClick="btnProcess_Click" />
                    </div>
                </div>
            </div>
        </div>--%>
        <%--<div aria-hidden="true" aria-labelledby="myModalLabel" role="dialog" tabindex="-1"
            id="ModalForgetPassword" class="modal fade">
            <div class="modal-dialog">
                <div class="modal-content">
                  <%--  <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                            &times;</button>
                        <h4 class="modal-title">
                            Forgot Password ?</h4>
                    </div>
                    <div class="modal-body">
                        <p>
                            Enter your User ID to reset your password.</p>
                        <asp:TextBox ID="txtResetUID" runat="server" placeholder="User ID" autocomplete="off"
                            class="form-control placeholder-no-fix"></asp:TextBox>
                    </div>
                    <div class="modal-footer">
                        <button data-dismiss="modal" class="btn btn-default" type="button">
                            Cancel</button>
                        <asp:Button ID="btnSubmit" runat="server" Text="Submit" class="btn btn-success" OnClick="btnSubmit_Click" />
                    </div>
                </div>
            </div>
        </div>--%>
      <%--  <div aria-hidden="true" aria-labelledby="myModalLabel" role="dialog" tabindex="-1"
            id="ModalChangePassword" class="modal fade">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                            &times;</button>
                        <h4 class="modal-title">
                            Change Password ?</h4>
                    </div>
                    <div class="modal-body">
                        <p>
                            Enter your new password.</p>
                        <asp:TextBox ID="txtNewPassword" runat="server" placeholder="New password" autocomplete="off"
                            class="form-control placeholder-no-fix" TextMode="Password"></asp:TextBox>
                        <p>
                            Enter your new password again.</p>
                        <asp:TextBox ID="txtConfirmPassword" runat="server" placeholder="Confirm password"
                            autocomplete="off" class="form-control placeholder-no-fix" TextMode="Password"></asp:TextBox>
                    </div>
                    <div class="modal-footer">
                        <button data-dismiss="modal" class="btn btn-default" type="button">
                            Cancel</button>
                        <asp:Button ID="btnChangePassword" runat="server" Text="Submit" class="btn btn-success"
                            OnClick="btnChangePassword_Click" />
                    </div>
                </div>
            </div>
        </div>--%>
        <div class="modal fade" id="ErrorNotif" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
            aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                            &times;</button>
                        <h4 class="modal-title">
                            Fail</h4>
                    </div>
                    <div class="modal-body">
                        <h4>
                            <i class="icon-thumbs-down-alt"></i>Oh no!!
                        </h4>
                        <p id="ErrorMsg">
                        </p>
                        <div class="panel panel-default" id="PanelTechMsg" style="display: none">
                            <div class="panel-heading">
                                <h4 class="panel-title">
                                    <a class="accordion-toggle" style="color: Red" data-toggle="collapse" data-parent="#accordion"
                                        href="#collapseOne">Technical Error </a>
                                </h4>
                            </div>
                            <div id="collapseOne" class="panel-collapse collapse">
                                <div class="panel-body">
                                    <p id="ErrorTechMsg" style="color: Red">
                                    </p>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button data-dismiss="modal" class="btn btn-default" type="button">
                            OK</button>
                    </div>
                </div>
            </div>
        </div>
        <div class="modal fade" id="SuccessNotif" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
            aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                            &times;</button>
                        <h4 class="modal-title">
                            Success</h4>
                    </div>
                    <div class="modal-body">
                        <h4>
                            <i class="icon-thumbs-up-alt"></i>Horayyy!
                        </h4>
                        <p>
                            Your data is at the safe place now</p>
                    </div>
                    <div class="modal-footer">
                        <button data-dismiss="modal" class="btn btn-default" type="button">
                            OK</button>
                    </div>
                </div>
            </div>
        </div>
        <!-- modal -->
        </form>
    </div>
</body>
</html>
