<%@ page import="com.big.braintree.GetPaymentToken,com.big.opennlp.FindNLP,java.util.concurrent.ThreadLocalRandom,com.big.util.*,java.text.*,java.util.*,java.io.*,javax.xml.parsers.*,org.w3c.dom.*,java.sql.*,java.text.DateFormat" %>
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
     final String FROM = "info@yawadi.com";   // Replace with your "From" address. This address must be verified.
     final String SMTP_USERNAME = "AKIAINFCRKGVZNSB7DHQ";  // Replace with your SMTP username.
     final String SMTP_PASSWORD = "Ar/mcRQJkM9i7Vl45r+CzSrgx/QGb+vuJIuIDfJp/mj8";  // Replace with your SMTP password.
     final String HOST = "email-smtp.us-east-1.amazonaws.com";    
     final int PORT = 25;

%>
<%

	System.out.println("Twilio CALL BACK URL ");
	System.out.println(request.getParameter("From"));
	System.out.println(request.getParameter("To"));
	System.out.println(request.getParameter("Body"));
	System.out.println(request.getParameter("FromCity"));
	
	String phoneFrom = request.getParameter("From").substring(2,request.getParameter("From").length());
	System.out.println(phoneFrom);
	
%><%
		try{

				Class.forName("com.mysql.jdbc.Driver");
				String url = "jdbc:mysql://localhost/test?user=<PASSWORD>&password=<PASSWORD>";
				Connection connection = DriverManager.getConnection(url,"<USERNAME>", "<PASSWORD>");
				boolean isFound = false;
				PreparedStatement psMain = null;

				java.sql.Timestamp ts = new java.sql.Timestamp((new java.util.Date()).getTime());
				String orderID = UUID.randomUUID() + "";
				psMain = connection.prepareStatement("INSERT INTO test.sms_callback(call_back_id, ts, fromMessage, textMessage, location) VALUES (?,?,?,?,?)");								
				psMain.setString(1, orderID);
				psMain.setTimestamp(2, new java.sql.Timestamp((new java.util.Date()).getTime()));	
				psMain.setString(3, request.getParameter("From"));
				psMain.setString(4, request.getParameter("Body"));
				psMain.setString(5, request.getParameter("FromCity"));						
				psMain.executeUpdate();
                psMain.close();

                if(true){
                    TwilioRestClient client = new TwilioRestClient(ACCOUNT_SID, AUTH_TOKEN);
                    Map<String, String> params = new HashMap<String, String>();
                    params.put("Body", "Thank You, We will contact you shortly to get more information");
                    params.put("To", request.getParameter("From"));
                    params.put("From", request.getParameter("To"));
                    SmsFactory messageFactory = client.getAccount().getSmsFactory();
                    Sms message = messageFactory.create(params);
                    System.out.println(message.getSid());
                    System.out.print("Message Send TRUE : ");
                }

		}catch(Exception ex){
			%><%="" + ex%><%
			System.out.println(ex + "");
		}					
%>
