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
if(request.getHeader("Host")!=null && request.getHeader("User-Agent")!=null){	
       if(request.getHeader("Host").equals("www.unenveloped.com") || request.getHeader("Host").equals("unenveloped.com")){
			try{
				response.sendRedirect("http://unenveloped.com/un/index.jsp");
			}catch(Exception ex){
			    %><%=ex%><%			
			}
	}
}
if(request.getHeader("Host")!=null && request.getHeader("User-Agent")!=null){	
       if(request.getHeader("Host").equals("www.accu-raters.com") || request.getHeader("Host").equals("accu-raters.com")){
			try{
				response.sendRedirect("http://accu-raters.com/accu/index.html");
			}catch(Exception ex){
			    %><%=ex%><%			
			}
	}
}
if(request.getHeader("Host")!=null && request.getHeader("User-Agent")!=null){	
       if(request.getHeader("Host").equals("www.mytruckboard.com") || request.getHeader("Host").equals("mytruckboard.com")){
			try{
				response.sendRedirect("http://mytruckboard.com/index5.html");
			}catch(Exception ex){
			    %><%=ex%><%			
			}
	}
}
if(request.getHeader("Host")!=null && request.getHeader("User-Agent")!=null){
if(request.getHeader("Host").equals("www.oneepm.com") || request.getHeader("Host").equals("oneepm.com")){
try{
response.sendRedirect("http://oneepm.com/preference/management");
}catch(Exception ex){
%><%=ex%><%
}
}
}
if(request.getHeader("Host")!=null && request.getHeader("User-Agent")!=null){
if(request.getHeader("Host").equals("www.lorryboard.com") || request.getHeader("Host").equals("lorryboard.com")){
try{
response.sendRedirect("http://lorryboard.com/lb/");
}catch(Exception ex){
%><%=ex%><%
}
}
}
if(request.getHeader("Host")!=null && request.getHeader("User-Agent")!=null){
if(request.getHeader("Host").equals("www.bluecountry.org") || request.getHeader("Host").equals("bluecountry.org")){
try{
response.sendRedirect("http://bluecountry.org/bc/");
}catch(Exception ex){
%><%=ex%><%
}
}
}
if(request.getHeader("Host")!=null && request.getHeader("User-Agent")!=null){
if(request.getHeader("Host").equals("www.cupofbreakfast.com") || request.getHeader("Host").equals("cupofbreakfast.com")){
try{
response.sendRedirect("http://cupofbreakfast.com/index.cob.jsp");
}catch(Exception ex){
%><%=ex%><%
}
}
}
if(request.getHeader("Host")!=null && request.getHeader("User-Agent")!=null){
if(request.getHeader("Host").equals("www.browniecoins.org") || request.getHeader("Host").equals("browniecoins.org")){
try{
response.sendRedirect("http://browniecoin.org/index.bc.jsp");
}catch(Exception ex){
%><%=ex%><%
}
}
}
if(request.getHeader("Host")!=null && request.getHeader("User-Agent")!=null){
if(request.getHeader("Host").equals("www.browniecoin.org") || request.getHeader("Host").equals("browniecoin.org")){
try{
response.sendRedirect("http://browniecoin.org/index.bc.jsp");
}catch(Exception ex){
%><%=ex%><%
}
}
}
%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8" />
        <title>GetNotaryPublic.com</title>
	<META NAME="description" CONTENT="Mobile Notary Service, Loan Signing Agents - goMobileNotary.com - Looking for a mobile notary? You found the right place! A nationwide directory of mobile notaries and notary services.">
    <META NAME="keywords" CONTENT="On Demand, Uber, notary, notaries, notary public, signing agent, loan signing agent, mobile notary, mobile notaries, notary service, notary signing, notary publics, notaries public, gomobilenotary, notarize, loan, mortgage, escrow, document, documents, notarial, title, abstracter, notarization, execute, signature, initial">
    <meta name="google-site-verification" content="fkeRg4Mhoefa9iViNud4SVzGlcixL9p-kke-eCzI4wM" />
<!-- Bootstrap Core CSS -->
<link href="css/bootstrap.min.css" rel="stylesheet">

<!-- Custom CSS -->
<link href="css/landing-page.css" rel="stylesheet">
<link rel="shortcut icon" href="oneepmfavicon.ico" type="image/x-icon">
<link rel="icon" href="icon.ico" type="image/x-icon">
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
<a class="navbar-brand topnav" href="#">Get Notary Public</a>
</div>
<!-- Collect the nav links, forms, and other content for toggling -->
<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
<ul class="nav navbar-nav navbar-right">
<li>
<a href="#about">About</a>
</li>
<li>
<a href="services.jsp">Services</a>
</li>
</ul>
</div>
<!-- /.navbar-collapse -->
</div>
<!-- /.container -->
</nav>


<!-- Header -->
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
<h2 class="section-heading">What is<br>Notary Public</h2>
<p class="lead">A notary public (or notary or public notary) of the common law is a public officer constituted by law to serve the public in non-contentious matters usually concerned with estates, deeds, powers-of-attorney, and foreign and international business - Wikipedia</p>
</div>
<div class="col-lg-5 col-lg-offset-2 col-sm-6">
<img class="img-responsive" src="img/ipad.png" alt="">
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
<hr class="section-heading-spacer">
<div class="clearfix"></div>
<h2 class="section-heading">What is<br>Get Notary Public</h2>
<p class="lead">Get Notary Public is a technology based and on demand notary public service. Our customers think of "Get Notary Public" as the Uber of Public Notary Service</a>
</div>
<div class="col-lg-5 col-sm-pull-6  col-sm-6">
<img class="img-responsive" src="img/dog.png" alt="">
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
<h2 class="section-heading">Single Place Supporting<br>Greater Los Angeles Area</h2>
<p class="lead">Get Notary Public is dedicated to the design, development, support and services of Notary Public Services in Greater Los Angeles Area.
We offer full Notary Public services for any situation.</p>
</div>
<div class="col-lg-5 col-lg-offset-2 col-sm-6">
<img class="img-responsive" src="img/phones.png" alt="">
</div>
</div>

</div>
<!-- /.container -->

</div>
<!-- /.content-section-a -->

<a  name="contact"></a>
<div class="banner">

<div class="container">

<div class="row">
<div class="col-lg-6">
<h2>Contact Us:</h2>
</div>
<div class="col-lg-6">
<ul class="list-inline banner-social-buttons">
<li>
<a href="https://twitter.com/GetNotaryPub" target="_top" class="btn btn-default btn-lg"><i class="fa fa-twitter"></i> <span class="network-name">Twitter</span></a>
</li>
<li>
<a href="https://www.facebook.com/Getnotarypublic-133567350678034/" target="_top" class="btn btn-default btn-lg"><i class="fa fa-facebook"></i> <span class="network-name">Facebook</span></a>
</li>
<li>
<a href="https://www.linkedin.com/company/18348410/" target="_top" class="btn btn-default btn-lg"><i class="fa fa-linkedin"></i> <span class="network-name">LinkedIn</span></a>
</li>
</ul>
<ul class="list-inline banner-social-buttons">
<li>
<a href="mailto:info@GetNotaryPublic.com?Subject=Info%20Request" target="_top" class="btn btn-default btn-lg"><i class="fa fa-envelope"></i> <span class="network-name">Email</span></a>
</li>
<li>
<a href="tel:1-866-418-1148" target="_top" class="btn btn-default btn-lg">
<i class="fa fa-phone"></i> <span class="network-name">866-418-1148</span>
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
<p class="copyright text-muted small">Copyright &copy; Get Notary Public 2017. All Rights Reserved</p>
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

ga('create', 'UA-109842084-1', 'auto');
ga('send', 'pageview');
</script>

</html>
