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
<%@ page import="org.apache.commons.fileupload.disk.*,org.apache.commons.fileupload.servlet.*,org.apache.commons.fileupload.*,java.text.*,java.util.*,java.io.*,javax.xml.parsers.*,org.w3c.dom.*,java.sql.*,java.text.DateFormat" %>
<%@ page import="net.tanesha.recaptcha.ReCaptchaImpl" %>
<%@ page import="net.tanesha.recaptcha.ReCaptchaResponse" %>
<%@ page import="com.big.util.*,java.text.*,java.util.*,java.io.*,javax.xml.parsers.*,org.w3c.dom.*,java.sql.*,java.text.DateFormat" %>
<%
     final String ACCOUNT_SID = "ACbc6b5f29c1627c6aa7e51f5ad340fa2d";
     final String AUTH_TOKEN = "767154b209800bd1be13e38d8a01fc1b";
     final String FROM = "info@yawadi.com";   // Replace with your "From" address. This address must be verified.
     final String SMTP_USERNAME = "AKIAINFCRKGVZNSB7DHQ";  // Replace with your SMTP username.
     final String SMTP_PASSWORD = "Ar/mcRQJkM9i7Vl45r+CzSrgx/QGb+vuJIuIDfJp/mj8";  // Replace with your SMTP password.
     final String HOST = "email-smtp.us-east-1.amazonaws.com";    
     final int PORT = 25;


    /*
    Enumeration requestParameters = request.getParameterNames();

    while (requestParameters.hasMoreElements()) {
        String element = (String) requestParameters.nextElement();
        String value = request.getParameter(element);
        System.out.println("element " + element + " value " + value);
        if(value.contains(new StringBuilder().append("").append('\'').toString())
        || value.contains(new StringBuilder().append("").append('\"').toString())
        || value.contains(new StringBuilder().append("").append('\b').toString())
        || value.contains(new StringBuilder().append("").append('\n').toString())
        || value.contains(new StringBuilder().append("").append('\r').toString())
        || value.contains(new StringBuilder().append("").append('\t').toString())
        || value.contains(new StringBuilder().append("").append('\\').toString())
        || value.toUpperCase().contains("SELECT")
        || value.toUpperCase().contains("UPDATE")
        || value.toUpperCase().contains("DELETE")
        || value.toUpperCase().contains("DROP")
        || value.toUpperCase().contains("INSERT")
        || value.toUpperCase().contains("*")
        || value.toUpperCase().contains("$")
        ){
	        System.out.println(" SQL INJECTION ERROR :::: element " + element + " value " + value);   
	        
				response.sendRedirect("https://mytruckboard.com/mytruckboard/errorRequest.html");
        }
    }	
    */
    
%>

	<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>

	<title>MYTRUCKBOARD 2.0 - Freight management and dispatch made easy.</title>

	<link rel="shortcut icon" href="https://www.mytruckboard.com/trucking-new/images/mtb-favicon.ico">

	<meta http-equiv="content-type" content="text/html; charset=utf-8" />

	<meta name="description" content="The complete freight management software. Get an edge on other brokers and shippers, win shipping deals and effortlessly manage your truck fleet." />
	<meta name="keywords" content="freight, transportation, dispatch management, load optimization, truck broker, transportation management, truck, truck fleet management, shippers, truck brokers, shipping made easy, trucking industry, trucking software, trucking, dispatch for freight brokder, carrier management, load board, load, board" />

	<link href="https://fonts.googleapis.com/css?family=Roboto:100,100italic,300,300italic,400,400italic" rel="stylesheet" type="text/css" />
	<!--[if lte IE 8]><script src="css/ie/html5shiv.js"></script><![endif]-->

	<script type="text/javascript" src="js/jquery.min.js"></script>

	<!-- Bootstrap core CSS -->
	<link href="css/bootstrap.min.css" rel="stylesheet">

	<!-- Custom styles for this template -->
	<link href="css/navbar-fixed-top.css" rel="stylesheet">



	<script language="JavaScript" type="text/javascript">

  var _gaq = _gaq || [];
  _gaq.push(['_setAccount', 'UA-28886039-1']);
  _gaq.push(['_trackPageview']);

  (function() {
    var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
    ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
    var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
  })();

</script>
<!-- Facebook Conversion Code for mtbRegistered -->

<script type="text/javascript">

var fb_param = {};

fb_param.pixel_id = '6013353848856';

fb_param.value = '0.01';

fb_param.currency = 'USD';

(function(){

var fpw = document.createElement('script');

fpw.async = true;

fpw.src = '//connect.facebook.net/en_US/fp.js';

var ref = document.getElementsByTagName('script')[0];

ref.parentNode.insertBefore(fpw, ref);

})();

</script>

</head>
			<% 
			
			String errorMsg = "";
			boolean loginTrue = false;
			String uuid = "";
			
			
			%>
			
			<%if(request.getParameter("addAccount")!=null && !request.getParameter("addAccount").equals("")){%>
				<% 	
	        	try{
	
			if(true){
			
						/*
						String remoteAddr = request.getRemoteAddr();
						ReCaptchaImpl reCaptcha = new ReCaptchaImpl();
						reCaptcha.setPrivateKey("6LeVLvESAAAAAA0ifKl3CsGS5ZQ30MCm5FKIlibm");
						String challenge = request.getParameter("recaptcha_challenge_field");
						String uresponse = request.getParameter("recaptcha_response_field");
						ReCaptchaResponse reCaptchaResponse = reCaptcha.checkAnswer(remoteAddr, challenge, uresponse);							
						*/
				if(true){
					Class.forName("com.mysql.jdbc.Driver");
					String url = "jdbc:mysql://localhost/test?user=<PASSWORD>&password=<PASSWORD>";		
					Connection connection = DriverManager.getConnection(url,"<USERNAME>", "<PASSWORD>");			
					uuid = UUID.randomUUID() + "";
					java.sql.Timestamp ts = new java.sql.Timestamp((new java.util.Date()).getTime());
//					if(request.getParameter("email")!=null && !request.getParameter("email").equals("") && request.getParameter("password")!=null && !request.getParameter("password").equals("") && request.getParameter("company_name")!=null && !request.getParameter("company_name").equals("") && request.getParameter("f_name")!=null && !request.getParameter("f_name").equals("") && request.getParameter("l_name")!=null && !request.getParameter("l_name").equals("") && request.getParameter("phone")!=null && !request.getParameter("phone").equals("")){
					if(request.getParameter("email")!=null && !request.getParameter("email").equals("") && request.getParameter("password")!=null && !request.getParameter("password").equals("")){
						if(request.getParameter("term_of_service") == null || !request.getParameter("term_of_service").equals("Yes")){
							errorMsg = "To continue, please agree to MyTruckBoard's Terms of Service.<BR>";
							System.out.println(errorMsg);				
						}else if(request.getParameter("password").equals(request.getParameter("password"))){
							PreparedStatement ps = connection.prepareStatement("INSERT INTO test.TRUCKING_USERS(EMAIL, PASSWORD, COMPANY_ID, IS_ADMIN, LAST_LOGIN_TS, TS, IS_OWNER, email_CODE, SMS_CODE, start_ip, last_ip, chain_ip, f_name, l_name, entity, is_online, is_online_register) VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,1,1)");
							ps.setString(1, request.getParameter("email").toLowerCase());
							ps.setString(2, request.getParameter("password"));
							ps.setString(3, uuid);
							ps.setBoolean(4, true);
							ps.setTimestamp(5, ts);
							ps.setTimestamp(6, ts);
							ps.setBoolean(7, true);
							ps.setString(8, (UUID.randomUUID() +"").substring(0,4));
							ps.setString(9, (UUID.randomUUID() +"").substring(0,4));
							ps.setString(10, request.getRemoteAddr());
							ps.setString(11, request.getRemoteAddr());
							ps.setString(12, request.getRemoteAddr());
							ps.setString(13, request.getParameter("f_name"));
							ps.setString(14, request.getParameter("l_name"));
							ps.setString(15, request.getParameter("entity"));

							ps.executeUpdate();

							ps = connection.prepareStatement("INSERT INTO test.TRUCKING_COMPANY(COMPANY_ID, NAME, TS, discount_code, issubscribed, country_code, isAd_account_only, company_pub_id, phone) VALUES (?,?,?,?,?,?,?,?,?)");
							ps.setString(1, uuid);
							ps.setString(2, request.getParameter("company_name"));
							ps.setTimestamp(3, ts);
							ps.setString(4, request.getParameter("discount_code"));
							ps.setBoolean(5, true);
							ps.setString(6, request.getParameter("country_code"));
							if(request.getParameter("ad_network_only") != null && request.getParameter("ad_network_only").equals("Yes")){
								ps.setBoolean(7, true);
								session.setAttribute("isAd_account_only", "true");
							}else{
								ps.setBoolean(7, false);	
								session.setAttribute("isAd_account_only", "false");						
							}
							ps.setString(8, UUID.randomUUID() +"");
							ps.setString(9, request.getParameter("phone"));
							ps.executeUpdate();
							
							String teamID = UUID.randomUUID() + "";
							ps = connection.prepareStatement("INSERT INTO test.TRUCKING_USER_teams(team_id, ts, name, company_id, created_by) VALUES (?,?,?,?,?)");							
							ps.setString(1, teamID);
							ps.setTimestamp(2, ts);
							ps.setString(3, "Home Office");
							ps.setString(4, uuid);
							ps.setString(5, request.getParameter("email").toLowerCase());
							ps.executeUpdate();
			
							ps = connection.prepareStatement("INSERT INTO test.TRUCKING_USER_teams_User_state(u_t_u_id, ts, team_id, user_id, user_state, company_id, created_by) VALUES (?,?,?,?,?,?,?)");
							ps.setString(1, UUID.randomUUID() +"");
							ps.setTimestamp(2, ts);
							ps.setString(3, teamID);
							ps.setString(4, request.getParameter("email").toLowerCase());
							ps.setString(5, "Dispatcher");
							ps.setString(6, uuid);
							ps.setString(7, request.getParameter("email").toLowerCase());
							ps.executeUpdate(); 
							ps.setString(1, UUID.randomUUID() +"");
							ps.setString(5, "Manager");
							ps.executeUpdate();        
							ps.setString(1, UUID.randomUUID() +"");
							ps.setString(5, "Sales");
							ps.executeUpdate(); 
							
							ps = connection.prepareStatement("INSERT INTO test.TRUCKING_USER_teams_User(u_t_u_id, team_id, user_id, ts, company_id, created_by) VALUES (?,?,?,?,?,?)");
							ps.setString(1, UUID.randomUUID() + "");
							ps.setString(2, teamID);
							ps.setString(3, request.getParameter("email").toLowerCase());
							ps.setTimestamp(4, ts);
							ps.setString(5, uuid);
							ps.setString(6, request.getParameter("email").toLowerCase());
							ps.executeUpdate();       

							session.setAttribute("login_id", request.getParameter("email").toLowerCase());
							session.setAttribute("uuid", uuid);
							session.setAttribute("isAdmin", "true");
							session.setAttribute("IS_SHOW_MORE_COL", "false");
							session.setAttribute("issubscribed", "true");
							session.setAttribute("IS_EMAIL_VERIFIED", "false");
							session.setAttribute("country_code", request.getParameter("country_code"));
							loginTrue = true;
						}else{
							errorMsg = "Re-entered password is not matching. Make sure to type same password in both fields<BR>";
							System.out.println(errorMsg);
						}
					}else{
						errorMsg = "Please fill out all the fields to create a new account <BR>";
						 System.out.println(errorMsg);
					}
					connection.close();
				}else{
						errorMsg = "Please make sure to properly complete the Captcha challenge. <BR>";
						 System.out.println(errorMsg);			
				} 	
			}else{
					errorMsg = "Captcha field can't be blank. <BR>";
					 System.out.println(errorMsg);			
			} 	
	         }catch (Exception ex){	         
	             errorMsg = "" + ex.getMessage();
	             System.out.println(""+ ex);
	         }				
				%>			
			<%}%>
			<%
				try{
					if(true){
					TwilioRestClient client = new TwilioRestClient(ACCOUNT_SID, AUTH_TOKEN);
					Map<String, String> params = new HashMap<String, String>();								
//					params.put("Body", "WASH THIS IMAGE LOADED .quotes.wash.jsp?checkForImage=" + UUID.randomUUID());
					params.put("Body", "Customer Registered --- MTB " + request.getParameter("email") + " -- ");
					params.put("To", "+13109036014");
					params.put("From", "+14242887641");
					SmsFactory messageFactory = client.getAccount().getSmsFactory();
					Sms message = messageFactory.create(params);
					System.out.println(message.getSid());	    										
					System.out.print("Message Send TRUE : ");
					System.out.print("Message Send TRUE : LOGIN MESSAGE " + errorMsg);
					
					}
				}catch(TwilioRestException ex2){
					System.out.println(ex2 + "");		
				}	
				%>
<body>
	<%if(loginTrue){%>
	<script>

	window.location.href="../trucking-new/new_features.jsp"

	</script>
         <%}else{%> 
		<script>

		window.location.href="register/?error_msg=<%=errorMsg%>"

		</script>
         <%}%>
</body>
</html>
