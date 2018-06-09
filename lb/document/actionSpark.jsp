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
     final String FROM = "info@yawadi.com";   // Replace with your "From" address. This address must be verified.
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
		try{
		
		Random randomGenerator = new Random();
		String promoCodeInt = randomGenerator.nextInt(10000)+""; 
		System.out.println("ACTION TEXT XXXXXXXX: " + request.getParameter("action"));    
		System.out.println("ACTION TEXT XXXXXXXX: " + request.getParameter("action"));   
		java.sql.Timestamp ts = new java.sql.Timestamp((new java.util.Date()).getTime());
			Class.forName("com.mysql.jdbc.Driver");
					String urldb = "jdbc:mysql://localhost/maids_oltp?user=<USER>&password=<PASSWORD>";		
					Connection connection = DriverManager.getConnection(urldb);
		
				String smsCode = randomGenerator.nextInt(10000)+""; 
				String emailCode = randomGenerator.nextInt(10000)+"";
				String registrationID = UUID.randomUUID() + "";
				client_db_id = registrationID;
				if(request.getParameter("sparkType")!=null && request.getParameter("sparkType").equals("Heart")){
					PreparedStatement ps = connection.prepareStatement("delete from maids_oltp.litem_board_heart where item_id = ? and client_id = ?");
					ps.setString(1, request.getParameter("spark_id"));
					ps.setString(2, request.getParameter("clientID"));
					responseText = "" + ps.executeUpdate() + "<ITEM>" + registrationID;

					ps = connection.prepareStatement("INSERT INTO litem_board_heart(heart_id, item_id, client_id, TS, client_ip) VALUES (?,?,?,?,?)");
					ps.setString(1, registrationID);
					ps.setString(2, request.getParameter("spark_id"));
					ps.setString(3, request.getParameter("clientID"));
					ps.setTimestamp(4, ts);
					ps.setString(5,  request.getRemoteAddr());
					responseText = "" + ps.executeUpdate() + "<ITEM>" + registrationID;
					loginTrue = true;	
				}else if(request.getParameter("sparkType")!=null && request.getParameter("sparkType").equals("Up")){
					PreparedStatement ps = connection.prepareStatement("delete from maids_oltp.litem_board_vote where item_id = ? and client_id = ?");
					ps.setString(1, request.getParameter("spark_id"));
					ps.setString(2, request.getParameter("clientID"));
					responseText = "" + ps.executeUpdate() + "<ITEM>" + registrationID;
					ps = connection.prepareStatement("INSERT INTO litem_board_vote(vote_id, item_id, client_id, TS, client_ip, vote_type) VALUES (?,?,?,?,?,'UP')");
					ps.setString(1, registrationID);
					ps.setString(2, request.getParameter("spark_id"));
					ps.setString(3, request.getParameter("clientID"));
					ps.setTimestamp(4, ts);
					ps.setString(5,  request.getRemoteAddr());
					responseText = "" + ps.executeUpdate() + "<ITEM>" + registrationID;
				}else if(request.getParameter("sparkType")!=null && request.getParameter("sparkType").equals("Down")){
					PreparedStatement ps = connection.prepareStatement("delete from maids_oltp.litem_board_vote where item_id = ? and client_id = ?");
					ps.setString(1, request.getParameter("spark_id"));
					ps.setString(2, request.getParameter("clientID"));
					responseText = "" + ps.executeUpdate() + "<ITEM>" + registrationID;
					ps = connection.prepareStatement("INSERT INTO litem_board_vote(vote_id, item_id, client_id, TS, client_ip, vote_type) VALUES (?,?,?,?,?,'Down')");
					ps.setString(1, registrationID);
					ps.setString(2, request.getParameter("spark_id"));
					ps.setString(3, request.getParameter("clientID"));
					ps.setTimestamp(4, ts);
					ps.setString(5,  request.getRemoteAddr());
					responseText = "" + ps.executeUpdate() + "<ITEM>" + registrationID;
				}else if(request.getParameter("sparkType")!=null && request.getParameter("sparkType").equals("Block")){
					PreparedStatement ps = connection.prepareStatement("delete from maids_oltp.litem_board_block where item_id = ? and client_id = ?");
					ps.setString(1, request.getParameter("spark_id"));
					ps.setString(2, request.getParameter("clientID"));
					responseText = "" + ps.executeUpdate() + "<ITEM>" + registrationID;
					ps = connection.prepareStatement("INSERT INTO litem_board_block(block_id, item_id, client_id, TS, client_ip) VALUES (?,?,?,?,?)");
					ps.setString(1, registrationID);
					ps.setString(2, request.getParameter("spark_id"));
					ps.setString(3, request.getParameter("clientID"));
					ps.setTimestamp(4, ts);
					ps.setString(5,  request.getRemoteAddr());
					responseText = "" + ps.executeUpdate() + "<ITEM>" + registrationID;
				}else if(request.getParameter("sparkType")!=null && request.getParameter("sparkType").equals("Fake")){
					PreparedStatement ps = connection.prepareStatement("delete from maids_oltp.litem_board_fake where item_id = ? and client_id = ?");
					ps.setString(1, request.getParameter("spark_id"));
					ps.setString(2, request.getParameter("clientID"));
					responseText = "" + ps.executeUpdate() + "<ITEM>" + registrationID;
					ps = connection.prepareStatement("INSERT INTO litem_board_fake(fake_id, item_id, client_id, TS, client_ip) VALUES (?,?,?,?,?)");
					ps.setString(1, registrationID);
					ps.setString(2, request.getParameter("spark_id"));
					ps.setString(3, request.getParameter("clientID"));
					ps.setTimestamp(4, ts);
					ps.setString(5,  request.getRemoteAddr());
					responseText = "" + ps.executeUpdate() + "<ITEM>" + registrationID;
				}else if(request.getParameter("sparkType")!=null && request.getParameter("sparkType").equals("UnHeart")){
					PreparedStatement ps = connection.prepareStatement("delete from maids_oltp.litem_board_heart where item_id = ? and client_id = ?");
					ps.setString(1, request.getParameter("spark_id"));
					ps.setString(2, request.getParameter("clientID"));
					responseText = "" + ps.executeUpdate() + "<ITEM>" + registrationID;
				}else if(request.getParameter("sparkType")!=null && request.getParameter("sparkType").equals("UnDown")){
					PreparedStatement ps = connection.prepareStatement("delete from maids_oltp.litem_board_vote where item_id = ? and client_id = ?");
					ps.setString(1, request.getParameter("spark_id"));
					ps.setString(2, request.getParameter("clientID"));
					responseText = "" + ps.executeUpdate() + "<ITEM>" + registrationID;
				}else if(request.getParameter("sparkType")!=null && request.getParameter("sparkType").equals("UnUp")){
					PreparedStatement ps = connection.prepareStatement("delete from maids_oltp.litem_board_vote where item_id = ? and client_id = ?");
					ps.setString(1, request.getParameter("spark_id"));
					ps.setString(2, request.getParameter("clientID"));
					responseText = "" + ps.executeUpdate() + "<ITEM>" + registrationID;
				}else if(request.getParameter("sparkType")!=null && request.getParameter("sparkType").equals("UnBlock")){
					PreparedStatement ps = connection.prepareStatement("delete from maids_oltp.litem_board_block where item_id = ? and client_id = ?");
					ps.setString(1, request.getParameter("spark_id"));
					ps.setString(2, request.getParameter("clientID"));
					responseText = "" + ps.executeUpdate() + "<ITEM>" + registrationID;
				}else if(request.getParameter("sparkType")!=null && request.getParameter("sparkType").equals("UnFake")){
					PreparedStatement ps = connection.prepareStatement("delete from maids_oltp.litem_board_fake where item_id = ? and client_id = ?");
					ps.setString(1, request.getParameter("spark_id"));
					ps.setString(2, request.getParameter("clientID"));
					responseText = "" + ps.executeUpdate() + "<ITEM>" + registrationID;
				}
				connection.close();			
			
		}catch(Exception ex){
			%><%="" + ex%><%
			System.out.println(ex + "");
		}
		%><%=responseText%><ITEM>Done