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
		try{
		java.sql.Timestamp ts = new java.sql.Timestamp((new java.util.Date()).getTime());
		Class.forName("com.mysql.jdbc.Driver");
		String urldb = "jdbc:mysql://localhost/maids_oltp?user=<USER>&password=<PASSWORD>";	
		String url = "jdbc:mysql://localhost/test?zeroDateTimeBehavior=convertToNull";

//			Class.forName("com.sap.dbtech.jdbc.DriverSapDB");
//			String url = "jdbc:sapdb://localhost/BIGDB?sqlmode=ORACLE";
		String clientid = request.getParameter("clientID"); 
		String clientidToAccessEmail = request.getParameter("client_id_access"); 
		String clientidToAccessPhone = request.getParameter("client_id_access"); 
		String emailAccess = request.getParameter("email"); 
		String phoneAccess = request.getParameter("name"); 
		System.out.println(request.getParameter("client_id"));
		String stringResponseAll = "";
		Connection connection = DriverManager.getConnection(urldb);
		Connection connection2 = DriverManager.getConnection(url,"<USERNAME>", "<PASSWORD>");
			PreparedStatement ps = connection.prepareStatement("select * from maids_customers WHERE key_client_temp = ?");
			ps.setString(1, clientid);			
			ResultSet resultSetSec = ps.executeQuery();
			while (resultSetSec.next()) {
				clientid = resultSetSec.getString("client_id");
				System.out.println(resultSetSec.getString("client_id"));   
			}
			
			if(!request.getParameter("email").equals("") || !request.getParameter("phone").equals("")){
				ps = connection.prepareStatement("select * from maids_customers WHERE (EMAIL = ?)");
				ps.setString(1, request.getParameter("email").toLowerCase());			
				ResultSet resultSet = ps.executeQuery();			
				while (resultSet.next()) {
					clientidToAccessEmail = resultSet.getString("client_id");
				}				

				ps = connection.prepareStatement("INSERT INTO mtb_approved_location_viewer(approved_id, client_id, is_Approved, TS, email_approved, name_approved, client_id_approved) VALUES (?,?,?,?,?,?,?)");
				ps.setString(1, UUID.randomUUID() + "");
				ps.setString(2, clientid);
				ps.setInt(3, 0);
				ps.setTimestamp(4, ts);
				ps.setString(5, emailAccess);
				ps.setString(6, phoneAccess);
				ps.setString(7, clientidToAccessEmail);
				ps.executeUpdate();
				
			}
		connection.close();	
		}catch(Exception ex){
			%><%="" + ex%><%
			System.out.println(ex + "");
		}
		%>Done<ITEM>Fixed<ITEM>Done