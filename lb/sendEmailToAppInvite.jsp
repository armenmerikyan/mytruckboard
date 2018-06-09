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
		String responseText = "";
		String registration_id = "";
		boolean loginTrue = false;
		boolean isEmailVerified = false;
		boolean isPhoneVerified = false;
		String client_provider_id = "";
		String client_db_id = "";
		String cc_mask = "";
		String cc_brand = "";
		String client_name = "";
		String returnEmail = "";
		String returnPhone = "";						
		String phoneNumber = request.getParameter("phone");
		String emailAddress = request.getParameter("email");
		System.out.println("--" + emailAddress + "--");
		
		try{
		
		
					Properties props = System.getProperties();
					props.put("mail.transport.protocol", "smtp");
					props.put("mail.smtp.port", PORT); 
					props.put("mail.smtp.auth", "true");
					props.put("mail.smtp.starttls.enable", "true");
					props.put("mail.smtp.starttls.required", "true");
					javax.mail.Session sessionMail = javax.mail.Session.getDefaultInstance(props);
					MimeMessage msg = new MimeMessage(sessionMail);
					msg.setFrom(new InternetAddress(FROM));
					msg.setRecipient(Message.RecipientType.TO, new InternetAddress(emailAddress));
					msg.setSubject("Your contact sent this Msg from myTruckBoard.com App");
					String email_footer = " <BR> This email is sent for ...</B>";
					msg.setContent("Please join myTruckBoard.com download myTruckBoard app at myTruckBoardApp.com <a href=\"http:\\mytruckBoard.com\" >myTruckBoardApp</a>","text/html; charset=utf-8");
					Transport transport = sessionMail.getTransport();
				        System.out.println("Attempting to send an email through the Amazon SES SMTP interface..." + request.getParameter("email"));
				        transport.connect(HOST, SMTP_USERNAME, SMTP_PASSWORD);
				        transport.sendMessage(msg, msg.getAllRecipients());
				        System.out.println("Email sent!");
				        transport.close(); 
				        
			
		}catch(Exception ex){
			%>Error Sending Message<%
			System.out.println(ex + "");
		}
		%>SENT<ITEM>Done<ITEM>Done