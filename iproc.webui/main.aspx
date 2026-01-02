<%@ Page Language="C#" AutoEventWireup="true" CodeFile="main.aspx.cs" Inherits="main" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ Register Src="wcmenu.ascx" TagName="wcmenu" TagPrefix="uc1" %>
<%@ Register Src="wcheader.ascx" TagName="wcheader" TagPrefix="uc2" %>
<%@ Register Assembly="MPF23.XUI" Namespace="MPF23.XUI.Control" TagPrefix="cc1" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>iProcurement</title>
    <!-- Bootstrap core CSS -->
    <link href="css/bootstrap.min.css" rel="stylesheet">
    <link href="css/bootstrap-reset.css" rel="stylesheet">
    <!--external css-->
    <link href="assets/font-awesome/css/font-awesome.css" rel="stylesheet" />
    <link href="assets/gritter/css/jquery.gritter.css" rel="stylesheet" type="text/css" />
    <!-- Custom styles for this template -->
    <link href="css/style.css" rel="stylesheet">
    <link href="css/style-responsive.css" rel="stylesheet" />
    <!-- HTML5 shim and Respond.js IE8 support of HTML5 tooltipss and media queries -->
    <!--[if lt IE 9]>
      <script src="js/html5shiv.js"></script>
      <script src="js/respond.min.js"></script>
    <![endif]-->
</head>
<body>
    <form id="form1" runat="server">
    <section id="container">
      <!--header start-->
      <header class="header white-bg">
        <uc2:wcheader ID="wcheader" runat="server" />
      </header>
      <!--header end-->
      <!--sidebar start-->
      <aside>
        <uc1:wcmenu ID="wcmenu" runat="server" />
      </aside>
      <!--main content start-->
      <section id="main-content">
        <section class="wrapper">
             <iframe id="ifr" src="module/dashboard/default2.aspx" frameborder="0" name="ifr" width="100%"  height="100%"
                scrolling="auto"></iframe>
        </section>
      </section>
        <!--main content end-->
        <!--footer start-->
      
      <!--footer end-->
    </section>
    <footer class="site-footer">
          <div class="text-center">
              2016 &copy; PT. MobiTech Media Integrasi.
              <a href="#" class="go-top">
                  <i class="icon-angle-up"></i>
              </a>
          </div>
      </footer>

<%--    <style>
        a.active{color:#FF6C60 !important;}
        .moduleitem{float:left;text-align:center;display:block;margin:0 3px;padding:0 5px;border-radius:5px;-moz-border-radius:5px;-webkit-border-radius:5px}
    </style>--%>
    
    <script src="js/jquery.js"></script>

    <script src="js/jquery-1.8.3.min.js"></script>

    <script src="js/bootstrap.min.js"></script>

    <script src="js/jquery.dcjqaccordion.2.7.js" type="text/javascript"></script>

    <script src="js/jquery.scrollTo.min.js"></script>

    <script src="js/jquery.nicescroll.js" type="text/javascript"></script>

    <script src="js/respond.min.js"></script>

    <script src="assets/gritter/js/jquery.gritter.min.js" type="text/javascript"></script>

    <!--common script for all pages-->

    <script src="js/common-scripts.js"></script>

    <script type="text/javascript">
//        $(function() {
//            $.post("menu.ashx", function(response) {
//                $("#sidebar").html(response);
//                $("#sidebar").dcAccordion();
//            });
//        });

        function selmenu(ctrl) {
            $('.menuitem').css('font-weight', 'normal');
            $('.menuitem').css('color', '#AEB2B7');
            $(ctrl).css('font-weight', 'bold');
            $(ctrl).css('color', '#FE2E2E');             
        }

        function selmodule(ctrl) {
            $('.moduleitem').css('font-weight', 'normal');

            if (($(".top-module").width() < 260)) {
                $('.moduleitem').css('background', 'none');
                ctrl.children[0].style.color = '#333';

                $.each($(".moduleitem"), function(key, val) {
                    if (ctrl != val) {
                        val.children[0].style.color = '#FFF';
                    }
                });
                
                if ($(".top-module").width() < 260) {
                    if ($(".top-module").css('right') == '-20px') {
                        $(".toggle-right").click();
                    }
                }
            } else {
                $('.moduleitem').css('background-color', '#FFFFFF');
                $.each($(".moduleitem"), function(key, val) {
                    if (ctrl != val) {
                        val.children[0].style.color = '#333';
                    }
                });
            }

            $(ctrl).css('font-weight', 'bold');
            $(ctrl).css('background-color', '#DBEAF9');
        }  

        function jsRenderMenu(id) {
            $.post("menu.ashx?mod=" + id, function(response) {
                $("#sidebar").html(response);
                $("#sidebar").dcAccordion({ autoExpand: true });
                $("#nav-accordian").show();
            });
        }

        $.post("notification.ashx", function(response) {
            $("#notif").html(response);
        });

        var timer = setInterval(function() {
            $.post("notification.ashx", function(response) {
                $("#notif").html(response);
            });

        }, 30000)

        function showHideRightModule() {
            if ($(".top-module").width() < 260) {
                if ($(".top-module").css('right') == '-20px') {
                    hideRightModule();
                } else {
                    showRightModule();
                }
            }
        }

        function hideRightModule() {
            $(".top-module").css({
                'right': '-255px'
            });
            $(".toggle-right")[0].src = "img/left-arrow-black.png"
        }

        function showRightModule() {
            $(".top-module").css({
                'right': '-20px'
            });
            $(".toggle-right")[0].src = "img/left-arrow-white.png"
        }

        function showUserSession() {
            $(".holder-user-session").css({
                'top': '0px'
            });
        }

        function hideUserSession() {
            $(".holder-user-session").css({
                'top': '-60px'
            });
        }

        function showHideUserSession() {
            if ($(".holder-user-session").css('top') == '0px') {
                hideUserSession();
            } else {
                showUserSession();
            }
        }

        $(window).resize(function() {
            if ($(".toggle-user-session").css('display') == "none") {
                showUserSession();
            } else {
                hideUserSession();
            }

            $.each($(".moduleitem"), function(key, val) {
                var color = $(val).css("background-color");
                if ($(".top-module").width() < 260) {
                    if (color != "rgb(255, 255, 255)") {
                        selmodule(val);
                        return false;
                    }
                } else {
                    if (color != "rgb(0, 0, 0)") {
                        selmodule(val);
                        return false;
                    }
                }
            });
        });

        $(document).ready(function() {
            //alert(window.innerWidth);
        });

        $(window).bind("load", function() {

            jsRenderMenu('DAS');

            $(".toggle-right").click(function() {
                showHideRightModule();
                if ($(this).css("transform") == 'none') {
                    $(this).css("transform", "rotate(180deg)");
                } else {
                    $(this).css("transform", "");
                }
            });

            $("#main-content").on("click", function() {
                if ($(".top-module").width() < 260) {
                    if ($(".top-module").css('right') == '-20px') {
                        hideRightModule();
                    }
                }
            });

            $(".panel-body").on("click", function() {
                if ($(".top-module").width() < 250) {
                    if ($(".top-module").css('right') == '-20px') {
                        hideRightModule();
                    }
                }
            });
            $(".moduleitem")[0].click();
        });
    </script>

    </form>
</body>
</html>
