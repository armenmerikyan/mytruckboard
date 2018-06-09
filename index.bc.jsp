<%@ page import="java.util.concurrent.ThreadLocalRandom,com.big.util.*,java.text.*,java.util.*,java.io.*,javax.xml.parsers.*,org.w3c.dom.*,java.sql.*,java.text.DateFormat" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8" />
        <title>BrownieCoin</title>
	<META NAME="description" CONTENT="Mobile Notary Service, Loan Signing Agents - goMobileNotary.com - Looking for a mobile notary? You found the right place! A nationwide directory of mobile notaries and notary services.">
    <META NAME="keywords" CONTENT="On Demand, Uber, notary, notaries, notary public, signing agent, loan signing agent, mobile notary, mobile notaries, notary service, notary signing, notary publics, notaries public, gomobilenotary, notarize, loan, mortgage, escrow, document, documents, notarial, title, abstracter, notarization, execute, signature, initial">
<meta name="google-site-verification" content="MYSIf6lkWbSSxsfQ5BVE-qDbIabcIdE_gAqSWE8PKCc" />
<!-- Bootstrap Core CSS -->
<link href="css/landing-page.bc.css" rel="stylesheet">
<link href="css/bootstrap.min.css" rel="stylesheet">

<!-- Custom CSS -->
<link rel="shortcut icon" href="bc_icon.ico" type="image/x-icon">
<link rel="icon" href="bc_icon.ico" type="image/x-icon">
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
<a class="navbar-brand topnav" href="#">BrownieCoin</a>
</div>
<!-- Collect the nav links, forms, and other content for toggling -->
<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
<ul class="nav navbar-nav navbar-right">
<!--
<li>
<a href="mailto:info@CupofBreakfast.com?Subject=Info%20Request" target="_top" >
<i class="fa fa-envelope-o"></i> info@brownicoins.org
</a>
</li>
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
<div class="intro-header">
<div class="container">
<div class="row">
<div class="col-lg-12">
<div class="intro-message">
<h1>BrownieCoin</h1>
<h3>The Recognition Cryptocurrency</h3>
<hr class="intro-divider">
<ul class="list-inline intro-social-buttons">
<li>
<a href="https://en.wikipedia.org/wiki/Peer-to-peer" class="btn btn-default btn-lg"><span class="network-name">Fast peer-to-peer
transactions</span></a>
</li>
</ul>
</div>
</div>
</div>
</div>
<!-- /.container -->

</div>
<!-- /.intro-header -->
<div class="content-section-a">

<div class="container">
<div class="row">
<div class="col-lg-5 col-sm-6" >
<hr class="section-heading-spacer">
<div class="clearfix"></div>
<h2 class="section-heading">What is BrownieCoin?</h2>
<p class="lead">
BrownieCoin is a Recognition Cryptocurrency.
Want more engaged employees, friends or family? Give them the technology to recognize each other in real time.
</p>
</div>
<div class="col-lg-5 col-lg-offset-2 col-sm-6" >
<img class="img-responsive" src="img/bc.1.png" alt="">
</div>
</div>

<div class="row">
<div class="col-md-12 col-xs-12" >
<hr >
<p class="lead">
BrownieCoin uses peer-to-peer technology to operate with no central authority or banks; managing transactions and the issuing of BrownieCoin is carried out collectively by the network. BrownieCoin is open-source; its design is public, nobody owns or controls BrownieCoin and everyone can take part. Through many of its unique properties, BrownieCoin allows exciting uses that could not be covered by any previous payment system.</p>
</div>
</div>

<div class="row">
<div class="col-md-12 col-xs-12" >
<%if(request.getParameter("email")==null){%>
<form action="/index.bc.jsp" method="POST">
<BR><BR>
<p>Keep up with blockchain and BrownieCoin technology trends with our insider reports.</p>
Simply enter your email address in the box below and select which newsletters you'd like to receive.
<BR>

<div class="form-group"><label for="usr">Email:</label><input type="text" class="form-control" id="email" name="email" placeholder="name@email.com" required></div>

<div class="form-check">
<label class="form-check-label">
<input type="checkbox" class="form-check-input" id="weekly" name="weekly" >
BrownieCoin Weekly - Every Friday you'll get a curated run down of the 5 hottest topics.
</label>
</div>

<div class="form-check">
<label class="form-check-label">
<input type="checkbox" class="form-check-input" id="daily" name="daily" >
Daily News - Daily feed of all published BrownieCoin stories - Sent once per day.
</label>
</div>

<div class="form-check">
<label class="form-check-label">
<input type="checkbox" class="form-check-input" id="research" name="research" >
BrownieCoin Research - Be the first to know about our digital currency research.
</label>
</div>

<div class="form-check">
<label class="form-check-label">
<input type="checkbox" class="form-check-input" id="events" name="events" >
BrownieCoin Events - Get exclusive offers to BrownieCoin and blockchain events.
</label>
</div>
<div class="form-check">
<div class="form-group"><button type="submit" class="btn btn-success">Sign Up</button></div>
</div>
</form>
<%}else{%>
<%
try{
if(true){
Class.forName("com.mysql.jdbc.Driver");
String url = "jdbc:mysql://localhost/test";
Connection connection = DriverManager.getConnection(url,"armenmerikyan", "MedFood");

PreparedStatement psMain = null;
DateFormat formatter = new SimpleDateFormat("MM-dd-yyyy.HH.mm.ss");
java.sql.Timestamp ts = new java.sql.Timestamp((new java.util.Date()).getTime());

psMain = connection.prepareStatement("INSERT INTO test.bc_emaillist(uuid, ts, email, weekly, daily, research, events) VALUES (?,?,?,?,?,?,?)");
psMain.setString(1, UUID.randomUUID() + "");
psMain.setTimestamp(2, new java.sql.Timestamp((new java.util.Date()).getTime()));
psMain.setString(3, request.getParameter("email"));
psMain.setString(4, request.getParameter("weekly"));
psMain.setString(5, request.getParameter("daily"));
psMain.setString(6, request.getParameter("research"));
psMain.setString(7, request.getParameter("events"));
psMain.executeUpdate();
connection.close();
}
}catch(Exception ex){
%><%=ex%><%
}
%>
<%}%>
Thank you for subscribing to the Newsletter.
</div>
</div>

<div class="row">
<div class="col-md-12 col-xs-12" >
<BR><BR>
<h2>Bitcoin Donations</h2>
<p>Our bitcoin address is: 1D42Vn3KeUEnQPkVt6wpvFSWu7rYpWUyB8</p>
</div>
</div>
</div>

<div class="banner">

<div class="container">

<div class="row">
<div class="col-lg-6">
<h2>Contact Us:</h2>
</div>
<div class="col-lg-6">
<ul class="list-inline banner-social-buttons">
<li>
<a href="https://www.facebook.com/browniecoins/" target="_top" class="btn btn-default btn-lg"><i class="fa fa-facebook"></i> <span class="network-name">Facebook</span></a>
</li>
<li>
<a href="https://angel.co/brownie-coins" target="_top" class="btn btn-default btn-lg"><i class="fa fa-angellist"></i> <span class="network-name">AngelList</span></a>
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
<li class="footer-menu-divider">&nbsp;</li>
</ul>
<p class="copyright text-muted small">
Copyright &copy;BrownieCoin 2014-2017 Released under the <a href="https://opensource.org/licenses/mit-license.php" >MIT license</a>
</p>
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

ga('create', 'UA-110409027-1', 'auto');
ga('send', 'pageview');
</script>

</html>
