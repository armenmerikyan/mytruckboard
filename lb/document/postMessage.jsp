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
				if(request.getParameter("lat")!=null && request.getParameter("long")!=null){
		String GEOCODER_REQUEST_PREFIX_FOR_XML = "https://maps.google.com/maps/api/geocode/xml";
//			GeocoderRequestBuilder()
		   String address = "1600 Amphitheatre Parkway, Mountain View, CA";

		    // prepare a URL to the geocoder
		    URL url = new URL(GEOCODER_REQUEST_PREFIX_FOR_XML + "?latlng=" + request.getParameter("lat") + "," + request.getParameter("long") +"&key=AIzaSyCb46VbE_7BQ_cCizcKaPzsexEumUrT4tY&sensor=false");

		    // prepare an HTTP connection to the geocoder
		    HttpURLConnection conn = (HttpURLConnection) url.openConnection();

		    Document geocoderResultDocument = null;
		   
		      // open the connection and get results as InputSource.
		      conn.connect();
		      InputSource geocoderResultInputSource = new InputSource(conn.getInputStream());

		      // read result and parse into XML Document
		      geocoderResultDocument = DocumentBuilderFactory.newInstance().newDocumentBuilder().parse(geocoderResultInputSource);
		     System.out.println("DATA REACHED HERE : " + geocoderResultInputSource);
		     // prepare XPath
		     XPath xpath = XPathFactory.newInstance().newXPath();

		     // extract the result
		     NodeList resultNodeList = null;

		     // a) obtain the formatted_address field for every result
		     resultNodeList = (NodeList) xpath.evaluate("/", geocoderResultDocument, XPathConstants.NODESET);
		     resultNodeList = (NodeList) xpath.evaluate("/GeocodeResponse/result/formatted_address", geocoderResultDocument, XPathConstants.NODESET);
		     for(int i=0; i<resultNodeList.getLength(); ++i) {
				       if(responseText .equals(""))responseText = resultNodeList.item(i).getTextContent();
			       	       System.out.println(resultNodeList.item(i).getTextContent());
		     }
			
			System.out.println("Scanned ID : DATA REACHED HERE");
			System.out.println(geocoderResultDocument.getTextContent());
		     // b) extract the locality for the first result
		     resultNodeList = (NodeList) xpath.evaluate("/GeocodeResponse/result[1]/address_component[type/text()='locality']/long_name", geocoderResultDocument, XPathConstants.NODESET);
		     for(int i=0; i<resultNodeList.getLength(); ++i) {
//			       System.out.println(resultNodeList.item(i).getTextContent());
		     }

		     // c) extract the coordinates of the first result
		     resultNodeList = (NodeList) xpath.evaluate("/GeocodeResponse/result[1]/geometry/location/*", geocoderResultDocument, XPathConstants.NODESET);
		     float lat = Float.NaN;
		     float lng = Float.NaN;
		     for(int i=0; i<resultNodeList.getLength(); ++i) {
		       Node node = resultNodeList.item(i);
		       if("lat".equals(node.getNodeName())) lat = Float.parseFloat(node.getTextContent());
		       if("lng".equals(node.getNodeName())) lng = Float.parseFloat(node.getTextContent());
		     }
		     //System.out.println("lat/lng=" + lat + "," + lng);
		     
		     // c) extract the coordinates of the first result
		     resultNodeList = (NodeList) xpath.evaluate("/GeocodeResponse/result[1]/address_component[type/text() = 'administrative_area_level_1']/country[short_name/text() = 'US']/*", geocoderResultDocument, XPathConstants.NODESET);
		     for(int i=0; i<resultNodeList.getLength(); ++i) {
		       Node node = resultNodeList.item(i);
		       if("lat".equals(node.getNodeName())) lat = Float.parseFloat(node.getTextContent());
		       if("lng".equals(node.getNodeName())) lng = Float.parseFloat(node.getTextContent());
		     }		
					}
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
				boolean isApproved = true;
			PreparedStatement ps = connection.prepareStatement("select * from litem_board_approved_clients_mtb WHERE clientId = ?");
			ps.setString(1, request.getParameter("clientID"));			
			ResultSet resultSetSec = ps.executeQuery();
			while (resultSetSec.next()) {
				isApproved = true;
			}				
				
		String latLong = "POINT(0 0)";
		if(request.getParameter("lat")!=null && request.getParameter("long")!=null){
			latLong = "POINT(" + request.getParameter("lat") + " " + request.getParameter("long") + ")";
		}				
				ps = connection.prepareStatement("INSERT INTO litem_board_mtb(messageid, tofield, fromfield, messagefield, TS, client_id, client_ip, isOnline,location, quote_id) VALUES (?,?,?,?,?,?,?,?,GeomFromText(?),?)");
				ps.setString(1, registrationID);
				ps.setString(2, request.getParameter("toField"));
				ps.setString(3, request.getParameter("fromField"));
				ps.setString(4, request.getParameter("messageField"));
				ps.setTimestamp(5, ts);
				ps.setString(6, request.getParameter("clientID"));
				ps.setString(7,  request.getRemoteAddr());
				ps.setBoolean(8,  true);				
				ps.setString(9, latLong);			
				ps.setString(10, request.getParameter("quote_id"));
				responseText = "" + ps.executeUpdate() + "<ITEM>" + registrationID;
				loginTrue = true;				
				connection.close();			
			
		}catch(Exception ex){
			%><%="" + ex%><%
			System.out.println(ex + "");
		}
		%><%=responseText%><ITEM>Done