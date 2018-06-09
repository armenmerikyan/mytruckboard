<%@ page import="com.twilio.sdk.resource.instance.Sms,com.twilio.sdk.TwilioRestClient,com.twilio.sdk.resource.factory.SmsFactory,com.big.util.*,java.text.*,java.util.*,java.io.*,javax.xml.parsers.*,org.w3c.dom.*,java.sql.*,java.text.DateFormat,com.twilio.sdk.TwilioRestClient,com.twilio.sdk.TwilioRestException,com.twilio.sdk.TwilioRestClient,com.twilio.sdk.resource.instance.Sms,com.twilio.sdk.resource.list.SmsList,java.util.HashMap,java.util.Map,com.twilio.sdk.resource.factory.SmsFactory,java.text.DecimalFormat" %>			
			<link rel="stylesheet" href="css/skel-noscript.css" />
			<link rel="stylesheet" href="css/style.css" />
			<link rel="stylesheet" href="css/style-wide.css" />
<%
		
					String errorMsg = "";
				Class.forName("com.mysql.jdbc.Driver");
				String url = "jdbc:mysql://localhost/test?user=<PASSWORD>&password=<PASSWORD>";
				Connection connection = DriverManager.getConnection(url, "<USERNAME>", "<PASSWORD>");
			if(request.getParameter("password")!=null && request.getParameter("password").length()>6 && request.getParameter("email") !=null && request.getParameter("tempID")!=null){
				PreparedStatement ps = connection.prepareStatement("Update trucking_users SET password = ? WHERE EMAIL = ? and key_client_temp = ?");
				ps.setString(1, request.getParameter("password"));			
				ps.setString(2, request.getParameter("email").toLowerCase());			
				ps.setString(3, request.getParameter("tempID"));			
				ps.executeUpdate();				
			}
%>
        <!DOCTYPE HTML>
<html>
<head>
    <meta name="google-site-verification" content="1QihUOuRwEWAj8QtNgUtpFsrC2CI7cY100legePbzWQ" />
    <meta http-equiv="cache-control" content="max-age=0" />
    <meta http-equiv="cache-control" content="no-cache" />
    <meta http-equiv="expires" content="0" />
    <meta http-equiv="expires" content="Tue, 01 Jan 1980 1:00:00 GMT" />
    <meta http-equiv="pragma" content="no-cache" />


    <script type="text/javascript">
        var RecaptchaOptions = {
            theme : 'white'
        };
    </script>

    <title>MYTRUCKBOARD 2.0 - Freight management and dispatch made easy.</title>

    <link rel="shortcut icon" href="https://www.mytruckboard.com/images/mtb-favicon.ico">

    <meta http-equiv="content-type" content="text/html; charset=utf-8" />

    <meta name="description" content="Manage independent truck drivers and un-utilized capacity with GPS based dispatch system designed to drive more profit to your brokerage." />
    <meta name="keywords" content="freight, transportation, dispatch management, load optimization, truck broker, transportation management, truck, truck fleet management, shippers, truck brokers, shipping made easy, trucking industry, trucking software, trucking, dispatch for freight brokder, carrier management, load board, load, board" />

    <link href="https://fonts.googleapis.com/css?family=Roboto:100,100italic,300,300italic,400,400italic" rel="stylesheet" type="text/css" />
    <!--[if lte IE 8]><script src="css/ie/html5shiv.js"></script><![endif]-->

    <script type="text/javascript" src="js/jquery.min.js"></script>
    <script src="js/skel.min.js"></script>
    <script src="js/init2.js"></script>


    <noscript>
        <link rel="stylesheet" href="css/skel-noscript.css" />
        <link rel="stylesheet" href="css/style-wide.css" />
     </noscript>


    <!-- Bootstrap core CSS -->
    <link href="css/bootstrap.min.css" rel="stylesheet">

    <link href="css/style.css" rel="stylesheet">


    <!-- Custom styles for this template -->
    <link href="css/navbar-fixed-top.css" rel="stylesheet">


    <!--[if lte IE 8]><link rel="stylesheet" href="css/ie/v8.css" /><![endif]-->
    <!--[if lte IE 9]><link rel="stylesheet" href="css/ie/v9.css" /><![endif]-->

    <style>
        .dark .button
        {
            background: #47A249;
            box-shadow: inset 0 0 0 1px #fff;
            color: #fff;
        }

        .button
        {
            background: #47A249;
           }

    .checkbox input
        {
        border: 3px #47A249;
        margin-top: 8px;

            }

    .checkbox label {
    padding-left: 5px;
    padding-bottom: 3px;
    font-size: 1em;
    color: #337ab7;
    font-weight: 300;
    }
    </style>
</head>
<body>



<!-- First -->


<section id="first" class="main">

        <div class="content style4 featured">
            <div class="container small">
                <div class="row">
                    <div class="col-md-12">
         <span class="image"  style="margin-left: 0px; padding: 10px 0px 0px; border-right-width: 0px;"><img src="images/mytryckboard_logo_v2i_small.png"></span>



        <strong><h2 style="margin-bottom: 0px; font-weight: 700; font-size: 2.3em">CHANGE PASSWORD FORM</h2></strong>
<p>
<%if(request.getParameter("email")!=null && !request.getParameter("email").equals("")){%>
	Password Reset Done <BR>
	<a href="http://www.mytruckboard.com" >Sign In</a>
	<%=errorMsg%>
<%}%>
</p>
                    </div>


                </div>
                            <FORM action="https://www.mytruckboard.com/trucking-new/resetPassword.jsp" method="post">
                             <INPUT type="hidden" name="tempID" value="<%=request.getParameter("tempID")%>">
                             		<div class="12u" style="padding:15px"><input type="text" class="text" name="email" placeholder="Email" value="" /></div>
                             	       <div class="12u" style="padding:15px"><input type="password" class="text" name="password" placeholder="Choose Password" /></div>
                                    <input type="submit" class="button" value="Save Password" />


                            </form>

            </div>
        </div>





		<!-- Footer -->
			<section id="footer">
				<ul class="icons">
					<li><a href="https://twitter.com/MyTruckBoard" class="fa fa-twitter solo"><span>Twitter</span></a></li>
					<li><a href="https://www.facebook.com/myTruckBoard" class="fa fa-facebook solo"><span>Facebook</span></a></li>

				</ul>
				<div class="copyright">
					<ul class="menu">
                        <li>Copyright &copy; 2015 Litewsorks2 Inc. All rights reserved.</li>

					</ul>
					<ul class="menu">
						<li>&copy;<a href="http://liteworks2.com">Litewsorks2 Inc</a> </li>
                        <li>599 Fairchild Dr, Mountain View, CA 94043 United States</li>
                        <li>email: LW2@liteworks2.com </li>
                        <li>twitter: @liteworks2</li>
                        <li>voice: 1.650.384.3294</li>
					</ul>
				</div>
			</section>

    <!-- the jScrollPane script -->
    <script type="text/javascript" src="js/jquery.jscrollpane.min.js"></script>

    <!-- Bootstrap core JavaScript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster -->
    <script src="js/bootstrap2.min.js"></script>


    <script>
        (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
                    (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
                m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
        })(window,document,'script','//www.google-analytics.com/analytics.js','ga');

        ga('create', 'UA-28886039-1', 'auto');
        ga('send', 'pageview');

    </script>
	</body>
</html>			