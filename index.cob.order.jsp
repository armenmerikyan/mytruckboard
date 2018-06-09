<%@ page import="com.stripe.*,com.stripe.model.Charge,java.util.concurrent.ThreadLocalRandom,com.big.util.*,java.text.*,java.util.*,java.io.*,javax.xml.parsers.*,org.w3c.dom.*,java.sql.*,java.text.DateFormat" %><%
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
<link href="css/landing-page.css" rel="stylesheet">
<link rel="shortcut icon" href="cob_icon.ico" type="image/x-icon">
<link rel="icon" href="cob_icon.ico" type="image/x-icon">
<!-- Custom Fonts -->
<link href="font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css">
<script language="JavaScript" type="text/javascript">

function initMap() {
}
function initialize() {

var options = {
types: ['(cities)'],
componentRestrictions: {country: ['us', 'ca','mx'] }
};



var input = /** @type {HTMLInputElement} */(
document.getElementById('address'));


var autocomplete = new google.maps.places.Autocomplete(input);

google.maps.event.addListener(autocomplete, 'place_changed', function() {


var place = autocomplete.getPlace();

if (!place.geometry) {
return;
}


document.getElementById('pickCity_lat').value = place.geometry.location.lat();
document.getElementById('pickCity_lng').value = place.geometry.location.lng();
var pickCity_latv = (document.getElementById('pickCity_lat').value);
var pickCity_lngv = (document.getElementById('pickCity_lng').value);
var pickCityall = (document.getElementById('address').value);
var parts = pickCityall.split(",");
var pickCityv = (document.getElementById('address').value); // get the city from the submitted form in case it's already split
var pickStatev = ""; //
if(parts.length>1){
pickCityv = parts[0]; // get the city from the submitted form
pickStatev = parts[1]; // get the state from the submitted form
document.getElementById('pickCity').value = pickCityv;
document.getElementById('pickState').value = pickStatev;
}
});

}

</script>

<script async defer src="https://maps.googleapis.com/maps/api/js?&libraries=places&key=AIzaSyBpeQ3zGuTunYzxmiNMUltHL352e4beac4&callback=initMap"
type="text/javascript"></script>
</head>
<body onload="initialize()">

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
<a class="navbar-brand topnav" href="index.cob.jsp">Cup Of Breakfast</a>
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
</div>
-->

<!-- /.container -->
<!-- /.intro-header -->

<!-- Page Content -->

<div class="content-section-a">

<div class="container">
<div class="row">

<div class="col-md-6 col-xs-6 col-md-offset-3 col-xs-offset-3" >
<h2>Order and Pay Online</h2>
</div>
</div>

<div class="row">

<div class="col-md-3 col-xs-3" style="background-color: white;">
<img class="img-responsive" src="img/cob.6.jpg" alt="">
</div>
<div class="col-md-6 col-xs-6" style="background-color: white;">
<%if(request.getParameter("email")==null){%>
<form action="/index.cob.order.jsp" method="POST">

<div class="form-group"><label for="usr">Full Name:</label><input type="text" class="form-control" id="fullname" name="fullname" required></div>
<div class="form-group"><label for="usr">Phone:</label><input type="text" class="form-control" id="phone" name="phone" required></div>
<div class="form-group"><label for="usr">Email:</label><input type="text" class="form-control" id="email" name="email" required></div>
<div class="form-group"><label for="usr">What's your street address:</label><input type="text" class="form-control" id="address" name="address" required ></div>
<input type="hidden" name="pickCity_lat" id="pickCity_lat" value="" />
<input type="hidden" name="pickCity_lng" id="pickCity_lng" value="" />
<input type="hidden" name="pickCity" id="pickCity" value="">
<input type="hidden" name="pickState" id="pickState" value="">
<div class="form-group"><label for="usr">Schedule my delivery for:</label><input type="text" class="form-control" id="schedule" name="schedule" required value="as soon as possible"></div>
<div class="form-group"><label for="usr">Quantity:</label><input type="text" class="form-control" id="quantity" name="quantity" required value="1"></div>
<div class="form-group"><button type="submit" class="btn btn-success">Add Payment Method</button></div>
</form>

<%}else if(request.getParameter("email")!=null && request.getParameter("stripeToken")==null){%>
<%
int quantity = Integer.valueOf(request.getParameter("quantity"));
float total = (float)((1.0 *quantity) * 7.50f);
DecimalFormat df = new DecimalFormat("0.00##");
String result = df.format(total);
String orderuuid = UUID.randomUUID() + "";
%>
<form action="/index.cob.order.jsp?orderuuid=<%=orderuuid%>" method="POST">
<%
try{
    if(true){
        Class.forName("com.mysql.jdbc.Driver");
        String url = "jdbc:mysql://localhost/test";
        Connection connection = DriverManager.getConnection(url,"armenmerikyan", "MedFood");

        PreparedStatement psMain = null;
        DateFormat formatter = new SimpleDateFormat("MM-dd-yyyy.HH.mm.ss");
        java.sql.Timestamp ts = new java.sql.Timestamp((new java.util.Date()).getTime());

        psMain = connection.prepareStatement("INSERT INTO test.COB_ORDERS(uuid, ts, fullname, phone, email, address, schedule, quantity, total) VALUES (?,?,?,?,?,?,?,?,?)");
        psMain.setString(1, orderuuid);
        psMain.setTimestamp(2, new java.sql.Timestamp((new java.util.Date()).getTime()));
        psMain.setString(3, request.getParameter("fullname"));
        psMain.setString(4, request.getParameter("phone"));
        psMain.setString(5, request.getParameter("email"));
        psMain.setString(6, request.getParameter("address"));
        psMain.setString(7, request.getParameter("schedule"));
        psMain.setString(8, request.getParameter("quantity"));
        psMain.setString(9, result);
        psMain.executeUpdate();
        connection.close();
    }
}catch(Exception ex){
%><%=ex%><%
}
%>

<div class="form-group"><label for="usr">Full Name:</label><input type="text" class="form-control" id="fullname" name="fullname" required value="<%=request.getParameter("fullname")%>" readonly></div>
<div class="form-group"><label for="usr">Phone:</label><input type="text" class="form-control" id="phone" name="phone" required value="<%=request.getParameter("phone")%>" readonly></div>
<div class="form-group"><label for="usr">Email:</label><input type="text" class="form-control" id="email" name="email" required value="<%=request.getParameter("email")%>" readonly></div>
<div class="form-group"><label for="usr">What's your street address:</label><input type="text" class="form-control" id="address" name="address" required value="<%=request.getParameter("address")%>" readonly></div>
<div class="form-group"><label for="usr">Schedule my delivery for:</label><input type="text" class="form-control" id="schedule" name="schedule" required value="as soon as possible" value="<%=request.getParameter("schedule")%>" readonly></div>
<div class="form-group"><label for="usr">Quantity:</label><input type="text" class="form-control" id="quantity" name="quantity" required value="<%=request.getParameter("quantity")%>" readonly></div>


<div class="form-group"><label for="usr">Total:</label><input type="text" class="form-control" id="quantity" name="quantity" required value="<%=result%>" readonly></div>
<script
src="https://checkout.stripe.com/checkout.js" class="stripe-button"
data-key="pk_test_Zeelhvzk1rHm0AlMGTBfydrF"
data-amount="<%=result.replaceAll("\\.", "")%>"
data-name="Cup Of Breakfast"
data-description="Widget"
data-image="https://stripe.com/img/documentation/checkout/marketplace.png"
data-locale="auto">
</script>
</form>
<%}else{%>
<%
String result = "7.50";
try{
    if(true){
        Class.forName("com.mysql.jdbc.Driver");
        String url = "jdbc:mysql://localhost/test";
        Connection connection = DriverManager.getConnection(url,"armenmerikyan", "MedFood");

        PreparedStatement psMain = null;
        DateFormat formatter = new SimpleDateFormat("MM-dd-yyyy.HH.mm.ss");
        java.sql.Timestamp ts = new java.sql.Timestamp((new java.util.Date()).getTime());

        psMain = connection.prepareStatement("select * from test.COB_ORDERS where uuid = ?");
        psMain.setString(1, request.getParameter("orderuuid"));
        ResultSet resultSet = psMain.executeQuery();
        while (resultSet.next()) {
            result = resultSet.getString("total");
        }
        connection.close();
    }
}catch(Exception ex){
%><%=ex%><%
}
%>
<%
Stripe.apiKey = "sk_test_0Y6VPdbhDKWMBnngPnOJnc7D";

// Token is created using Checkout or Elements!
// Get the payment token ID submitted by the form:
String token = request.getParameter("stripeToken");

// Charge the user's card:
Map<String, Object> params = new HashMap<String, Object>();
params.put("amount", Integer.valueOf(result.replaceAll("\\.", "")));
params.put("currency", "usd");
params.put("description", "Example charge");
params.put("source", token);

Charge charge = Charge.create(params);
%>
<%
try{
    if(true){
        Class.forName("com.mysql.jdbc.Driver");
        String url = "jdbc:mysql://localhost/test";
        Connection connection = DriverManager.getConnection(url,"armenmerikyan", "MedFood");

        PreparedStatement psMain = null;
        DateFormat formatter = new SimpleDateFormat("MM-dd-yyyy.HH.mm.ss");
        java.sql.Timestamp ts = new java.sql.Timestamp((new java.util.Date()).getTime());

        psMain = connection.prepareStatement("update test.COB_ORDERS set charge_id = ? where uuid = ?");
        psMain.setString(1, charge.getId());
        psMain.setString(2, request.getParameter("orderuuid"));
        psMain.executeUpdate();
        connection.close();
    }
}catch(Exception ex){
%><%=ex%><%
}
%>
<h2>Order Confirmation</h2>
<h3>Thank You For Your Order <%=request.getParameter("fullname")%></h3>
<p>Your meal order has been entered into our system and processing right now.</p>
<%}%>
</div>

</div>


</div>
<!-- /.container -->

</div>

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
<a href="index.cob.order.jsp" target="_top" class="btn btn-default btn-lg"><i class="fa fa-globe"></i> <span class="network-name">Online</span></a>
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
