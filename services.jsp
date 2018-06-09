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
                if(request.getParameter("firstname") !=null){
                    psMain = connection.prepareStatement("INSERT INTO test.GNP_REQUEST_LOG(uuid, ts, first_name, last_name, phone, email, city, question) VALUES (?,?,?,?,?,?,?,?)");
                    psMain.setString(1, UUID.randomUUID() + "");
                    psMain.setTimestamp(2, new java.sql.Timestamp((new java.util.Date()).getTime()));
                    psMain.setString(3, request.getParameter("firstname"));
                    psMain.setString(4, request.getParameter("lastname"));
                    psMain.setString(5, request.getParameter("phone"));
                    psMain.setString(6, request.getParameter("email"));
                    psMain.setString(7, request.getParameter("city"));
                    psMain.setString(8, request.getParameter("question"));
                    psMain.executeUpdate();
                }
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
        <title>GetNotaryPublic.com - Services</title>
	<META NAME="description" CONTENT="Mobile Notary Service, Loan Signing Agents - goMobileNotary.com - Looking for a mobile notary? You found the right place! A nationwide directory of mobile notaries and notary services.">
    <META NAME="keywords" CONTENT="On Demand, Uber, notary, notaries, notary public, signing agent, loan signing agent, mobile notary, mobile notaries, notary service, notary signing, notary publics, notaries public, gomobilenotary, notarize, loan, mortgage, escrow, document, documents, notarial, title, abstracter, notarization, execute, signature, initial">

<link href="css/bootstrap.min.css" rel="stylesheet">
<script src="https://code.jquery.com/ui/jquery-ui-git.js" ></script>

<!-- Latest compiled and minified CSS -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">

<!-- Optional theme -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" integrity="sha384-rHyoN1iRsVXV4nD0JutlnGaslCJuC7uwjduW9SVrLvRYooPp2bWYgmgJQIXwl/Sp" crossorigin="anonymous">

<!-- Latest compiled and minified JavaScript -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa" crossorigin="anonymous"></script>
<!-- Custom CSS -->
<link href="css/landing-page.css" rel="stylesheet">
<link rel="shortcut icon" href="oneepmfavicon.ico" type="image/x-icon">
<link rel="icon" href="icon.ico" type="image/x-icon">
<!-- Custom Fonts -->
<link href="font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css">
<script src='https://cdn.jsdelivr.net/jquery/1.12.4/jquery.min.js'></script>
<script src='https://cdn.jsdelivr.net/jquery.validation/1.15.1/jquery.validate.min.js'></script>
<script>
// Wait for the DOM to be ready
$(function() {
// Initialize form validation on the registration form.
// It has the name attribute "registration"
$("form[name='registration']").validate({
// Specify validation rules
rules: {
// The key name on the left side is the name attribute
// of an input field. Validation rules are defined
// on the right side
firstname: "required",
lastname: "required",
email: {
required: true,
// Specify that email should be validated
// by the built-in "email" rule
email: true
},
},
// Specify validation error messages
messages: {
firstname: "Please enter your firstname",
lastname: "Please enter your lastname",
email: "Please enter a valid email address"
},
// Make sure the form is submitted to the destination defined
// in the "action" attribute of the form when valid
submitHandler: function(form) {
form.submit();
}
});
});
</script>
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
<a class="navbar-brand topnav" href="index.jsp">Get Notary Public</a>
</div>
<!-- Collect the nav links, forms, and other content for toggling -->
<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
<ul class="nav navbar-nav navbar-right">
<li>
<a href="index.jsp#about">About</a>
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
<a  name="about"></a>
<div class="content-section-a">

<div class="container">
<div class="row">
<div class="col-lg-5 col-sm-6">
<h2 class="section-heading">Services Overview</h2>
<p class="lead">Our notaries are licensed by the State of California to verify the identities of document signers for all kinds of documents such as grant deeds, loans, trust deeds, consent to travel letters, benefit payments, 401(k)'s and IRA disbursements, powers of attorney, advanced health care directives, quitclaim deeds, notices to vacate, affidavits, contractors bids, and more.</p>
</div>
<div class="col-lg-5 col-lg-offset-2 col-sm-6">
<hr class="section-heading-spacer">
<img class="img-responsive" src="img/ipad.png" alt="">
</div>
</div>

</div>
<!-- /.container -->

</div>

<!-- /.container -->

</div>
<!-- /.content-section-a -->
<div class="content-section-a">

<div class="container">
<div class="row">
<div class="col-lg-10 col-sm-12">
<div class="clearfix"></div>
<%
if(request.getParameter("firstname") !=null){
%>
<h1 class="section-heading"><mark>YOUR REQUEST WAS SENT</mark></h1>
<%
}else{
%>
<h1 class="section-heading">REQUEST A FREE CONSULTATION</h1>
<FORM id="registration" name="registration" action="services.jsp" method="post" class="form-horizontal"
data-fv-framework="bootstrap"
data-fv-icon-valid="glyphicon glyphicon-ok"
data-fv-icon-invalid="glyphicon glyphicon-remove"
data-fv-icon-validating="glyphicon glyphicon-refresh">
<div class="form-group"><label for="usr">First Name:</label><input type="text" class="form-control" id="firstname" name="firstname" required data-fv-notempty message="The First Name is required" ></div>
<div class="form-group"><label for="usr">Last Name:</label><input type="text" class="form-control" id="lastname" name="lastname" required></div>
<div class="form-group"><label for="usr">Your Phone:</label><input type="text" class="form-control" id="phone" name="phone" required></div>
<div class="form-group"><label for="usr">Your Email:</label><input type="text" class="form-control" id="email" name="email" required></div>
<div class="form-group"><label for="usr">Your City:</label><input type="text" class="form-control" id="city" name="city" required></div>
<div class="form-group"><label for="usr">Question:</label><input type="text" class="form-control" id="question" name="question" required></div>
<div class="form-group"><button type="submit" class="btn btn-success">Submit Your Request</button></div>
</form>
<%
}
%>

</div>
</div>

</div>
<!-- /.container -->

</div>

<!-- /.container -->

</div>
<a  name="contact"></a>
<div class="banner">

<div class="container">

<div class="row">
<div class="col-lg-6">
<h2>Need More Info? Contact Us</h2>
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
