<%@ page import="org.w3c.dom.Node,org.w3c.dom.NodeList,org.xml.sax.InputSource,org.w3c.dom.Document,javax.xml.xpath.XPath,javax.xml.xpath.XPathConstants,javax.xml.xpath.XPathFactory,javax.xml.parsers.DocumentBuilderFactory,java.net.HttpURLConnection,java.net.URL,java.net.URLEncoder,com.big.util.*,java.text.*,java.util.*,java.io.*,javax.xml.parsers.*,org.w3c.dom.*,java.sql.*,java.text.DateFormat,com.twilio.sdk.TwilioRestClient,com.twilio.sdk.TwilioRestException,com.twilio.sdk.TwilioRestClient,com.twilio.sdk.resource.instance.Sms,com.twilio.sdk.resource.list.SmsList,java.util.HashMap,java.util.Map,com.twilio.sdk.resource.factory.SmsFactory" %><%
try{
		System.out.println(request.getParameter("CLIENT_ID"));     
		java.sql.Timestamp ts = new java.sql.Timestamp((new java.util.Date()).getTime());
		Class.forName("com.mysql.jdbc.Driver");
		String urldb = "jdbc:mysql://localhost/maids_oltp?user=<USER>&password=<PASSWORD>";	
		String url = "jdbc:mysql://localhost/test?zeroDateTimeBehavior=convertToNull";

//			Class.forName("com.sap.dbtech.jdbc.DriverSapDB");
//			String url = "jdbc:sapdb://localhost/BIGDB?sqlmode=ORACLE";
		String clientid = request.getParameter("client_id"); 
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
			
				if(request.getParameter("registerType") != null  && request.getParameter("registerType").equals("Ship")){
			ps = connection2.prepareStatement("select * from trucking_quote_lineitem_shipping where quote_id = ? order by ts desc");	
				}else{
			ps = connection2.prepareStatement("select * from trucking_quote_lineitem where quote_id = ? order by ts desc");	
				}
			ps.setString(1, request.getParameter("quote_id"));
			ResultSet resultSet = ps.executeQuery();
			DateFormat df = new SimpleDateFormat("MM/dd/yyyy");
			DateFormat dfTime = new SimpleDateFormat("hh:mm aa");
			while (resultSet.next()) {
				stringResponseAll = stringResponseAll + "Start<FIELD>" + resultSet.getString("qt") + "<FIELD>" + resultSet.getString("type") + "<FIELD>" + resultSet.getString("line_item_id") + "<FIELD>" + resultSet.getInt("pickup_qt") + "<FIELD>" + resultSet.getInt("dropoff_qt") + "<FIELD>Done<ROW>" ;
			}	
			if(stringResponseAll.indexOf("<ROW>") > 0)stringResponseAll = stringResponseAll.substring(0, stringResponseAll.length()-5);		
		%><%=stringResponseAll%><%
		connection.close();		     
		     //System.out.println("lat/lng=" + lat + "," + lng);
		}catch(Exception ex){
			%><%="" + ex%><%
			System.out.println(ex + "");
		}%>
		