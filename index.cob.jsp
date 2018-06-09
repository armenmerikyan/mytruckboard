<%@ page import="java.util.concurrent.ThreadLocalRandom,com.big.util.*,java.text.*,java.util.*,java.io.*,javax.xml.parsers.*,org.w3c.dom.*,java.sql.*,java.text.DateFormat" %><%
	         try{
	                 
			if(true){
				String clientID = "";
				String cookieName = "lw2_client_id";
				Cookie[] cookies = request.getCookies();
				if (cookies != null) 
				{
				    for(int i=0; i<cookies.length; i++) 
				    {
					Cookie cookie = cookies[i];
					if (cookieName.equals(cookie.getName())) 
					{
					    clientID = cookie.getValue();
					}
				    }
				}	
				if(clientID.equals("")){
					clientID = UUID.randomUUID() + "";
					Cookie userCookie = new Cookie("lw2_client_id", clientID);
					userCookie.setMaxAge(60*60*24*365); //Store cookie for 1 year
					response.addCookie(userCookie);
				}		
				
				Class.forName("com.mysql.jdbc.Driver");
				String url = "jdbc:mysql://localhost/test";
				Connection connection = DriverManager.getConnection(url,"armenmerikyan", "MedFood");

				PreparedStatement psMain = null;
				DateFormat formatter = new SimpleDateFormat("MM-dd-yyyy.HH.mm.ss");
				java.sql.Timestamp ts = new java.sql.Timestamp((new java.util.Date()).getTime());

				psMain = connection.prepareStatement("INSERT INTO test.access_log(uuid, ts, source_ip, source_client_id, user_agent, referer, XForwarded,host_name) VALUES (?,?,?,?,?,?,?,?)");								
				psMain.setString(1, UUID.randomUUID() + "");
				psMain.setTimestamp(2, new java.sql.Timestamp((new java.util.Date()).getTime()));	
				psMain.setString(3, request.getRemoteAddr());
				psMain.setString(4, clientID);
				psMain.setString(5, request.getHeader("User-Agent"));
				psMain.setString(6, request.getHeader("referer"));		
				psMain.setString(7, request.getHeader("X-Forwarded-For"));	
				psMain.setString(8, request.getHeader("Host"));			
				psMain.executeUpdate();	
				connection.close();
				
				
				
			}
		}catch(Exception ex){
		  %><%=ex%><%			
		}
%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8" />
        <title>Cup Of Breakfast</title>
	<META NAME="description" CONTENT="Mobile Notary Service, Loan Signing Agents - goMobileNotary.com - Looking for a mobile notary? You found the right place! A nationwide directory of mobile notaries and notary services.">
    <META NAME="keywords" CONTENT="On Demand, Uber, notary, notaries, notary public, signing agent, loan signing agent, mobile notary, mobile notaries, notary service, notary signing, notary publics, notaries public, gomobilenotary, notarize, loan, mortgage, escrow, document, documents, notarial, title, abstracter, notarization, execute, signature, initial">
<meta name="google-site-verification" content="MYSIf6lkWbSSxsfQ5BVE-qDbIabcIdE_gAqSWE8PKCc" />
<!-- Bootstrap Core CSS -->
<link href="css/bootstrap.min.css" rel="stylesheet">

<!-- Custom CSS -->
<link href="css/landing-page.cob.css" rel="stylesheet">
<link rel="shortcut icon" href="cob_icon.ico" type="image/x-icon">
<link rel="icon" href="cob_icon.ico" type="image/x-icon">
<!-- Custom Fonts -->
<link href="font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css">
</head>
<body>

<!-- Navigation -->
<nav class="navbar navbar-default navbar-fixed-top topnav" role="navigation">
<div class="container topnav">
<!-- Brand and toggle get grouped for better mobile display -->
<div class="navbar-header">
<button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1">
<span class="sr-only">Toggle navigation</span>
<span class="icon-bar"></span>
<span class="icon-bar"></span>
<span class="icon-bar"></span>
</button>
<a class="navbar-brand topnav" href="#">Cup Of Breakfast</a>
</div>
<!-- Collect the nav links, forms, and other content for toggling -->
<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
<ul class="nav navbar-nav navbar-right">
<li>

<a href="tel:1-844-250-3663" target="_top" >Order By:
<i class="fa fa-phone"></i> 844-250-FOOD
</a>
</li>
<!--
<li>
<a href="services.jsp">Services</a>
</li>
-->
</ul>
</div>
<!-- /.navbar-collapse -->
</div>
<!-- /.container -->
</nav>

<BR><BR>
<!-- Header -->
<!--
<div class="intro-header">
<div class="container">
<div class="row">
<div class="col-lg-12">
<div class="intro-message">
<h1>Get Notary Public</h1>
<h3>Legal Notary Public Service</h3>
<hr class="intro-divider">
<ul class="list-inline intro-social-buttons">
<li>
<a href="https://en.wikipedia.org/wiki/Greater_Los_Angeles_Area" class="btn btn-default btn-lg"><span class="network-name">Greater Los Angeles Area</span></a>
</li>
</ul>
</div>
</div>
</div>
</div>
-->
<!-- /.container -->

</div>
<!-- /.intro-header -->

<!-- Page Content -->

<a  name="about"></a>
<div class="content-section-a">

<div class="container">
<div class="row">
<div class="col-lg-5 col-sm-6">
<hr class="section-heading-spacer">
<div class="clearfix"></div>
<h2 class="section-heading">What is<br>"Cup Of Breakfast"?</h2>
<p class="lead">"Cup Of Breakfast" is an exciting new meal delivery startup.
Our goal is to start your day off with a good portion of protein served in a cup.
Most important, "Cup Of Breakfast" delivers restaurant-quality meals prepared by professional chefs in a commercial kitchen facility.
<BR><BR>

We also do <a href="#catering">CORPORATE CATERING</a>
</p>
</div>
<div class="col-lg-5 col-lg-offset-2 col-sm-6">
<img class="img-responsive" src="img/cob.4.jpg" alt="">
</div>
</div>

</div>
<!-- /.container -->

</div>
<!-- /.content-section-a -->
<a  name="services"></a>

<div class="content-section-b">

<div class="container">

<div class="row">
<div class="col-lg-5 col-lg-offset-1 col-sm-push-6  col-sm-6">
<div class="clearfix"></div>
<h2 class="section-heading">Ingredients</h2>
<p class="lead">
Two scrambled eggs, sausage links, fried cubed potatoes with Tapatio Sauce and slice of fresh lemon on the side.
<BR><BR>
<small>
<small>
We deliver our delicious breakfast meals hot in 30 minutes or less to most places in the greater los angeles area.</small></small>

</p>
</div>
<div class="col-lg-5 col-sm-pull-6  col-sm-6">
<img class="img-responsive" src="img/cob.1.jpg" alt="">
</div>
</div>

</div>
<!-- /.container -->

</div>
<!-- /.content-section-b -->
<div class="content-section-a">
<div class="container">
<div class="row">
<div class="col-lg-5 col-sm-6">
<hr class="section-heading-spacer">
<div class="clearfix"></div>
<h2 class="section-heading">Price $7.50</h2>
<p class="lead">
Expand your horizons and try our "Cup Of Breakfast".
Served in a 16oz Compostable and Biodegradable Paper Hot Food Cup
</p>
</div>
<div class="col-lg-5 col-lg-offset-2 col-sm-6">
<img class="img-responsive" src="img/cob.2.jpg" alt="">
</div>
</div>
</div>
<!-- /.container -->

</div>
<a  name="catering"></a>
<!-- /.content-section-a -->

<div class="content-section-b">

<div class="container">

<div class="row">
<div class="col-lg-5 col-lg-offset-1 col-sm-push-6  col-sm-6">
<div class="clearfix"></div>
<h2 class="section-heading">CORPORATE CATERING</h2>
<p class="lead">
We'll save you time and energy with our "Cup Of Breakfast". Cup of Breakfast corporate or business event catering in Los Angeles or OC includes these locations: Irvine, San Clemente, Newport beach, Costa mesa, Huntington Beach, Seal Beach, Long Beach, Laguna Beach, Anaheim, and surrounding areas.
</p>
</div>
<div class="col-lg-5 col-sm-pull-6  col-sm-6">
<img class="img-responsive" src="img/cob.5.jpg" alt="">
</div>
</div>

</div>
<!-- /.container -->

</div>

<a  name="contact"></a>
<div class="banner">

<div class="container">

<div class="row">
<div class="col-lg-6">
<h2>Order Now:</h2>
</div>
<div class="col-lg-6">
<ul class="list-inline banner-social-buttons">
<li>
<a href="https://cupofbreakfast.com/index.cob.order.jsp" target="_top" class="btn btn-default btn-lg"><i class="fa fa-globe"></i> <span class="network-name">Online</span></a>
</li>
<li>
<a href="https://twitter.com/CupOfBreakfast" target="_top" class="btn btn-default btn-lg"><i class="fa fa-twitter"></i> <span class="network-name">Twitter</span></a>
</li>
<!--
<li>
<a href="https://www.facebook.com/Getnotarypublic-133567350678034/" target="_top" class="btn btn-default btn-lg"><i class="fa fa-facebook"></i> <span class="network-name">Facebook</span></a>
</li>
<li>
<a href="https://www.linkedin.com/company/18348410/" target="_top" class="btn btn-default btn-lg"><i class="fa fa-linkedin"></i> <span class="network-name">LinkedIn</span></a>
</li>
-->
<li>
<a href="mailto:info@CupofBreakfast.com?Subject=Info%20Request" target="_top" class="btn btn-default btn-lg"><i class="fa fa-envelope"></i> <span class="network-name">Email</span></a>
</li>
<li>
<a href="tel:1-844-250-3663" target="_top" class="btn btn-default btn-lg">
<i class="fa fa-phone"></i> <span class="network-name">Call: 844-250-3663</span>
</a>
</li>
<li>
<a href="sms:1-844-250-3663" target="_top" class="btn btn-default btn-lg">
<i class="fa fa-mobile"></i> <span class="network-name">SMS: 844-250-3663</span>
</a>
</li>
</ul>

</div>
</div>

</div>
<!-- /.container -->

</div>
<!-- /.banner -->

<!-- Footer -->
<footer>
<div class="container">
<div class="row">
<div class="col-lg-12">
<ul class="list-inline">
<li>
<a href="#">Home</a>
</li>
<li class="footer-menu-divider">&sdot;</li>
<li>
<a href="#services">Services</a>
</li>
</ul>
<p class="copyright text-muted small">Copyright &copy; Cup Of Breakfast 2017. All Rights Reserved</p>
</div>
</div>
</div>
</footer>

<!-- jQuery -->
<script src="js/jquery.js"></script>

<!-- Bootstrap Core JavaScript -->
<script src="js/bootstrap.min.js"></script>




</body>
<script>
(function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
(i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
})(window,document,'script','https://www.google-analytics.com/analytics.js','ga');

ga('create', 'UA-110050809-1', 'auto');
ga('send', 'pageview');
</script>

</html>
