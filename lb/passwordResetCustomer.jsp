<%@ page import="org.w3c.dom.Node,org.w3c.dom.NodeList,org.xml.sax.InputSource,org.w3c.dom.Document,javax.xml.xpath.XPath,javax.xml.xpath.XPathConstants,javax.xml.xpath.XPathFactory,javax.xml.parsers.DocumentBuilderFactory,java.net.HttpURLConnection,java.net.URL,java.net.URLEncoder,com.big.util.*,java.text.*,java.util.*,java.io.*,javax.xml.parsers.*,org.w3c.dom.*,java.sql.*,java.text.DateFormat,com.twilio.sdk.TwilioRestClient,com.twilio.sdk.TwilioRestException,com.twilio.sdk.TwilioRestClient,com.twilio.sdk.resource.instance.Sms,com.twilio.sdk.resource.list.SmsList,java.util.HashMap,java.util.Map,com.twilio.sdk.resource.factory.SmsFactory" %>
<%@ page import="com.twilio.sdk.TwilioRestClient" %>
<%@ page import="com.twilio.sdk.resource.factory.SmsFactory" %>
<%@ page import="com.twilio.sdk.resource.instance.Sms" %>
<%@ page import="javax.mail.Message" %>
<%@ page import="javax.mail.MessagingException" %>
<%@ page import="javax.mail.Session" %>
<%@ page import="javax.mail.Transport" %>
<%@ page import="javax.mail.internet.InternetAddress" %>
<%@ page import="javax.mail.internet.MimeMessage" %>
<%
     final String ACCOUNT_SID = "ACbc6b5f29c1627c6aa7e51f5ad340fa2d";
     final String AUTH_TOKEN = "767154b209800bd1be13e38d8a01fc1b";
     final String FROM = "info@myTruckBoard.com";   // Replace with your "From" address. This address must be verified.
     final String SMTP_USERNAME = "AKIAINFCRKGVZNSB7DHQ";  // Replace with your SMTP username.
     final String SMTP_PASSWORD = "Ar/mcRQJkM9i7Vl45r+CzSrgx/QGb+vuJIuIDfJp/mj8";  // Replace with your SMTP password.
     final String HOST = "email-smtp.us-east-1.amazonaws.com";
     final int PORT = 25;

%>
<%
if(request.getParameter("action")!=null && request.getParameter("action").equals("resetPassword")){
		String responseText = "";
		String registration_id = "";
		boolean loginTrue = false;
		boolean isEmailVerified = false;
		boolean isPhoneVerified = false;
		String client_provider_id = "";
		String client_db_id = "";
		String cc_mask = "";
		try{

		System.out.println("ACTION TEXT : " + request.getParameter("action"));
		Random randomGenerator = new Random();
		java.sql.Timestamp ts = new java.sql.Timestamp((new java.util.Date()).getTime());

			if(!request.getParameter("email").equals("")){
				Class.forName("com.mysql.jdbc.Driver");
				String url = "jdbc:mysql://localhost/test?user=<PASSWORD>&password=<PASSWORD>";
				Connection connection = DriverManager.getConnection(url, "<USERNAME>", "<PASSWORD>");

			PreparedStatement ps = connection.prepareStatement("select * from TRUCKING_USERS where email = ?");
			ps.setString(1, request.getParameter("email").toLowerCase());
            ResultSet resultSet = ps.executeQuery();
            System.out.println(request.getParameter("email").toLowerCase());

			while (resultSet.next()) {
				loginTrue = true;
				//isEmailVerified = resultSet.getBoolean("isemailverified");
				//isPhoneVerified = resultSet.getBoolean("isphoneverified");
				//client_provider_id =   resultSet.getString("maid_user_id");
				client_db_id = UUID.randomUUID() + "";
				//cc_mask = resultSet.getString("cc_mask_no");
 				ps = connection.prepareStatement("Update TRUCKING_USERS SET key_client_temp = ? where email = ? ");
				ps.setString(1, client_db_id);
				ps.setString(2, resultSet.getString("email"));
				ps.executeUpdate();

					Properties props = System.getProperties();
					props.put("mail.transport.protocol", "smtp");
					props.put("mail.smtp.port", PORT);
					props.put("mail.smtp.auth", "true");
					props.put("mail.smtp.starttls.enable", "true");
					props.put("mail.smtp.starttls.required", "true");
					javax.mail.Session sessionMail = javax.mail.Session.getDefaultInstance(props);
					MimeMessage msg = new MimeMessage(sessionMail);
					msg.setFrom(new InternetAddress(FROM));
					msg.setRecipient(Message.RecipientType.TO, new InternetAddress(request.getParameter("email")));
					msg.setSubject("My Truck Board - Password Reset");
					String email_footer = " <BR> This email is sent because it was used to register to myTruckBoard.com for more info visit www.myTruckBoard.com.";
					msg.setContent("reset Link http://www.myTruckBoard.com/trucking-new/resetPassword.jsp?tempID=" + client_db_id + " " + email_footer,"text/html; charset=utf-8");
					Transport transport = sessionMail.getTransport();
				        System.out.println("Attempting to send an email through the Amazon SES SMTP interface..." + request.getParameter("email"));
				        transport.connect(HOST, SMTP_USERNAME, SMTP_PASSWORD);
				        transport.sendMessage(msg, msg.getAllRecipients());
				        System.out.println("Email sent!");
				        transport.close();
			}
			}
		}catch(Exception ex){
			%><%="" + ex%><%
			System.out.println(ex + "");
		}
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



        <strong><h2 style="margin-bottom: 0px; font-weight: 700; font-size: 2.3em">PASSWORD RESET FORM</h2></strong>
<p>
<%if(request.getParameter("action")!=null && request.getParameter("action").equals("resetPassword")){%>
	Please Check Your Email
<%}%>
</p>
                    </div>


                </div>

                <%if(request.getParameter("error_msg")!=null){%><p> <B><%=NullCheck.check(request.getParameter("error_msg"))%></B></p><%}%>


                <FORM action="passwordResetCustomer.jsp" method="post">

                    <INPUT type="hidden" name="action" value="resetPassword">
                    <INPUT type="hidden" name="discount_code" value="<%=request.getParameter("discount_code")%>">

                    <div class="row" style="margin-right: 2px;">
        <div class="2u" style="height: 2px;">&nbsp;</div>
                        <div class="8u"><input type="text" class="text" name="email" placeholder="Email" value="" /></div>
        <div class="2u" style="height: 2px;">&nbsp;</div>
                    </div>


                    <div class="row">
        <div class="2u" style="height: 2px;">&nbsp;</div>
                        <div class="8u">
                            <input type="submit" class="button" value="RESET PASSWORD" />

                        </div>
        <div class="2u" style="height: 2px;">&nbsp;</div>
                    </div>
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

                        <li>voice: 1.310.903.6014</li>
					</ul>
				</div>
			</section>

    <!-- the jScrollPane script -->
    <script type="text/javascript" src="js/jquery.jscrollpane.min.js"></script>

    <!-- Bootstrap core JavaScript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster -->
    <script src="js/bootstrap2.min.js"></script>
	</body>
</html>
