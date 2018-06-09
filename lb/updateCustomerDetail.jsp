<%@ page import="java.sql.SQLException,org.w3c.dom.Node,org.w3c.dom.NodeList,org.xml.sax.InputSource,org.w3c.dom.Document,javax.xml.xpath.XPath,javax.xml.xpath.XPathConstants,javax.xml.xpath.XPathFactory,javax.xml.parsers.DocumentBuilderFactory,java.net.HttpURLConnection,java.net.URL,java.net.URLEncoder,com.big.util.*,java.text.*,java.util.*,java.io.*,javax.xml.parsers.*,org.w3c.dom.*,java.sql.*,java.text.DateFormat,com.twilio.sdk.TwilioRestClient,com.twilio.sdk.TwilioRestException,com.twilio.sdk.TwilioRestClient,com.twilio.sdk.resource.instance.Sms,com.twilio.sdk.resource.list.SmsList,java.util.HashMap,java.util.Map,com.twilio.sdk.resource.factory.SmsFactory" %>
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
     final String FROM = "anita@maidsapp.com";   // Replace with your "From" address. This address must be verified.
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
		String client_name = "";
		try{

		System.out.println("ACTION TEXT : " + request.getParameter("action"));    
		System.out.println("ACTION TEXT : " + request.getParameter("action"));   
		Random randomGenerator = new Random();
		java.sql.Timestamp ts = new java.sql.Timestamp((new java.util.Date()).getTime());
		Class.forName("com.mysql.jdbc.Driver");
		String urldb = "jdbc:mysql://localhost/maids_oltp?user=<USER>&password=<PASSWORD>";		
		Connection connection = DriverManager.getConnection(urldb);
			
			if((!request.getParameter("phone").equals("")) || (!request.getParameter("fname").equals("")) || (!request.getParameter("lname").equals(""))){
				
				float pricePerMile = 0.0f;
				if(request.getParameter("truckRatePerMile")!=null){
					pricePerMile = Float.parseFloat(request.getParameter("truckRatePerMile"));
				}

				String clientid = request.getParameter("client_id"); 
				PreparedStatement ps = connection.prepareStatement("select * from maids_customers WHERE key_client_temp = ?");
				ps.setString(1, clientid);			
				ResultSet resultSetSec = ps.executeQuery();
				while (resultSetSec.next()) {
					clientid = resultSetSec.getString("client_id");
					System.out.println(resultSetSec.getString("client_id"));   
				}
			
 				ps = connection.prepareStatement("Update maids_customers SET f_name = ?, l_name = ?, phone = ?, company_name = ?, owner_name = ?, wtg = ?, basicNotes = ?, specialNotes = ?, price_per_mile = ?, current_state = ?, currenttrucktype = ? WHERE client_id = ?");
				ps.setString(1, request.getParameter("fname"));			
				ps.setString(2, request.getParameter("lname"));			
				//ps.setString(2, request.getParameter("email").toLowerCase());			
				ps.setString(3, request.getParameter("phone"));			
				ps.setString(4, request.getParameter("company_name"));		
				ps.setString(5, request.getParameter("owner_name"));				
				ps.setString(6, request.getParameter("truckWtg"));					
				ps.setString(7, request.getParameter("truckBasicNotes"));					
				ps.setString(8, request.getParameter("truckSpecialNotes"));						
				ps.setFloat(9, pricePerMile);	
				ps.setString(10, request.getParameter("truckStatusTypeIndex"));	
				ps.setString(11, request.getParameter("currentTruckType"));
				ps.setString(12, clientid);			
				ps.executeUpdate();
			}
			
		}catch(SQLException dex){
			%><ERRORSAVINGDUPKEY><%
			System.out.println(dex + "");
		}catch(Exception ex){
			%><ERRORSAVING><%
			System.out.println(ex + "");
		}
		%><%=request.getParameter("email")%><ITEM><%=loginTrue%><ITEM>1<ITEM>1<ITEM><%=client_provider_id%><ITEM><%=client_db_id%><ITEM><%=cc_mask%><ITEM><%=request.getParameter("lname")%><ITEM><ITEM><%=request.getParameter("fname")%><ITEM>Done