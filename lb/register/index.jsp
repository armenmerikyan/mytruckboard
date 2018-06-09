<%@ page import="com.big.util.*,java.text.*,java.util.*,java.io.*,javax.xml.parsers.*,org.w3c.dom.*,java.sql.*,java.text.DateFormat" %>
<!DOCTYPE html>
<html lang="en">

    <head>

        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Bootstrap Login &amp; Register Templates</title>

        <!-- CSS -->
        <link rel="stylesheet" href="http://fonts.googleapis.com/css?family=Roboto:400,100,300,500">
        <link rel="stylesheet" href="assets/bootstrap/css/bootstrap.min.css">
        <link rel="stylesheet" href="assets/font-awesome/css/font-awesome.min.css">
		<link rel="stylesheet" href="assets/css/form-elements.css">
        <link rel="stylesheet" href="assets/css/style.css">

        <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
        <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
        <!--[if lt IE 9]>
            <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
            <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
        <![endif]-->

        <!-- Favicon and touch icons -->
        <link rel="shortcut icon" href="assets/ico/favicon.png">
        <link rel="apple-touch-icon-precomposed" sizes="144x144" href="assets/ico/apple-touch-icon-144-precomposed.png">
        <link rel="apple-touch-icon-precomposed" sizes="114x114" href="assets/ico/apple-touch-icon-114-precomposed.png">
        <link rel="apple-touch-icon-precomposed" sizes="72x72" href="assets/ico/apple-touch-icon-72-precomposed.png">
        <link rel="apple-touch-icon-precomposed" href="assets/ico/apple-touch-icon-57-precomposed.png">

    </head>

    <body>
    <nav class="navbar navbar-default navbar-fixed-top">
    <div class="container">
    <div class="navbar-header">
    <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar">
    <span class="sr-only">Toggle navigation</span>
    <span class="icon-bar"></span>
    <span class="icon-bar"></span>
    <span class="icon-bar"></span>
    </button>

        <a href="https://www.mytruckboard.com"><span class="image navbar-brand"  style="height: 35px; margin-left: 10px; padding: 10px 0px 0px; border-right-width: 0px;"><img src="/trucking-new/images/mtb_app_logo.png" style="width:35px;height:35px;" ></span></a>

    </div>
    <div id="navbar" class="navbar-collapse collapse">
    <ul class="nav navbar-nav">
    <li ><a href="/mytruckboard-pricing-plans.html">SERVICES</a></li>
    <li class="active"><a href="https://www.mytruckboard.com/trucking-new/register">SUBSCRIBE</a></li>
    <li ><a href="https://itunes.apple.com/us/app/mytruckboard-driver/id1044398785?mt=8">iOS APP</a></li>
    <li ><a href="/mtbnlp.html">WHAT'S NLP</a></li>
    <li ><a href="/AAAHOME/loadboard.jsp">NLP BOARD</a></li>
    <li ><a href="/mtbapi.html">TMS APIs</a></li>
    <li ><a href="http://news.mytruckboard.com">MY NEWS</a></li>



    </ul>
   <!--
    <form class="navbar-form navbar-right" action="trucking-new/new_features.jsp" method="post">
    <div class="form-group">
    <input type="email" placeholder="Email" name="login_id" class="form-control">
    </div>
    <div class="form-group">
    <input type="password" placeholder="Password" name="password" class="form-control">
    </div>
    <button type="submit" class="btn btn-success">Sign in</button>
    </form>
    -->
    </div><!--/.nav-collapse -->
    </div>
    </nav>
        <!-- Top content -->
        <div class="top-content">

            <div class="inner-bg">
                <div class="container">

                    <div class="row">
                        <div class="col-sm-8 col-sm-offset-2 text">
                        <h1>
            <span class="image"><img src="../images/mytryckboard_logo_v2i.png" alt="MYTRUCKBOARD logo"></span><br /></h1>

                        </div>
                    </div>

                    <div class="row">

                        <div class="col-sm-5">

                        	<div class="form-box">
                        		<div class="form-top">
	                        		<div class="form-top-left">
	                        			<h3>Sign up now</h3>
	                            		<p>Fill in the form below to get instant access:</p>
	                            		
						 <%if(request.getParameter("error_msg")!=null){%><p> <B>
						 	<%if(request.getParameter("error_msg").contains("'PRIMARY'")){%>
						 	This email is already a registered user please reset your password. 
						 	<%}else{%><%=NullCheck.check(request.getParameter("error_msg"))%></B></p>
						 	<%}%>
						 <%}%>

	                        		</div>
	                        		<div class="form-top-right">
	                        			<i class="fa fa-pencil"></i>
	                        		</div>
	                            </div>
	                            <div class="form-bottom">
				                    <form role="form" action="../../trucking-new/add_board.jsp" method="post" class="registration-form">
				                        	<input type="hidden" name="phone"  id="phone" value="555-555-5555">
				                        	<input type="hidden" name="company_name"  id="company_name" value="Company Name">
                    						<INPUT type="hidden" name="addAccount" value="true">
                    						<INPUT type="hidden" name="discount_code" value="<%=request.getParameter("discount_code")%>">
				                    	<div class="form-group">
				                    		<label class="sr-only" for="form-first-name">First name</label>
				                        	<input type="text" name="form-first-name" placeholder="First name..." class="form-first-name form-control" id="form-first-name">
				                        </div>
				                        <div class="form-group">
				                        	<label class="sr-only" for="form-last-name">Last name</label>
				                        	<input type="text" name="form-last-name" placeholder="Last name..." class="form-last-name form-control" id="form-last-name">
				                        </div>
				                        <div class="form-group">
				                        	<label class="sr-only" for="form-email">Email</label>
				                        	<input type="text" name="email" placeholder="Email..." class="form-email form-control" id="email">
				                        </div>
				                        <div class="form-group">
				                        	<label class="sr-only" for="form-email">Email</label>
				                        	<input type="password" name="password" placeholder="Choose Password" class="form-email form-control" id="password">
				                        </div>
				                        <div class="form-group">
				                            <INPUT type="checkbox" name="term_of_service" value="Yes"> I agree to <a href="/trucking-new/terms_of_service.html" >Terms of Service</a> & <a href="/trucking-new/privacy_policy.html" >Privacy Policy</a>.
				                        </div>

				                        <button type="submit" class="btn">Sign me up!</button>
				                    </form>
			                    </div>
                        	</div>

                        </div>
                        <div class="col-sm-1 middle-border"></div>
                        <div class="col-sm-1"></div>
                        <div class="col-sm-5">

                        	<div class="form-box">
	                        	<div class="form-top">
	                        		<div class="form-top-left">
	                        			<h3>Login to our site</h3>
	                            		<p>Enter username and password to log on:</p>
	                        		</div>
	                        		<div class="form-top-right">
	                        			<i class="fa fa-lock"></i>
	                        		</div>
	                            </div>
	                            <div class="form-bottom">
				                    <form role="form" action="../../trucking-new/new_features.jsp" method="post" class="login-form">
				                    	<div class="form-group">
				                    		<label class="sr-only" for="form-username">Username</label>
				                        	<input type="text" name="login_id" placeholder="Username..." class="form-username form-control" id="login_id">
				                        </div>
				                        <div class="form-group">
				                        	<label class="sr-only" for="form-password">Password</label>
				                        	<input type="password" name="password" placeholder="Password..." class="password form-control" id="form-password">
				                        </div>
				                        <button type="submit" class="btn">Sign in!</button>
				                    </form>
			                    </div>
		                    </div>
<!--
		                	<div class="social-login">
	                        	<h3>...or login with:</h3>
	                        	<div class="social-login-buttons">
		                        	<a class="btn btn-link-2" href="#">
		                        		<i class="fa fa-facebook"></i> Facebook
		                        	</a>
		                        	<a class="btn btn-link-2" href="#">
		                        		<i class="fa fa-twitter"></i> Twitter
		                        	</a>
		                        	<a class="btn btn-link-2" href="#">
		                        		<i class="fa fa-google-plus"></i> Google Plus
		                        	</a>
	                        	</div>
	                        </div>
-->
                        </div>

                    </div>

                </div>
            </div>

        </div>

        <!-- Footer -->
        <footer>
        	<div class="container">
        		<div class="row">

        			<div class="col-sm-8 col-sm-offset-2">
        				<div class="footer-border"></div>
        				LiteWorks2 Inc
        			</div>

        		</div>
        	</div>
        </footer>

        <!-- Javascript -->
        <script src="assets/js/jquery-1.11.1.min.js"></script>
        <script src="assets/bootstrap/js/bootstrap.min.js"></script>
        <script src="assets/js/jquery.backstretch.min.js"></script>
        <script src="assets/js/scripts.js"></script>

        <!--[if lt IE 10]>
            <script src="assets/js/placeholder.js"></script>
        <![endif]-->

    </body>

</html>