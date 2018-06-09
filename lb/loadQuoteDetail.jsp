<%@ page import="org.w3c.dom.Node,org.w3c.dom.NodeList,org.xml.sax.InputSource,org.w3c.dom.Document,javax.xml.xpath.XPath,javax.xml.xpath.XPathConstants,javax.xml.xpath.XPathFactory,javax.xml.parsers.DocumentBuilderFactory,java.net.HttpURLConnection,java.net.URL,java.net.URLEncoder,com.big.util.*,java.text.*,java.util.*,java.io.*,javax.xml.parsers.*,org.w3c.dom.*,java.sql.*,java.text.DateFormat,com.twilio.sdk.TwilioRestClient,com.twilio.sdk.TwilioRestException,com.twilio.sdk.TwilioRestClient,com.twilio.sdk.resource.instance.Sms,com.twilio.sdk.resource.list.SmsList,java.util.HashMap,java.util.Map,com.twilio.sdk.resource.factory.SmsFactory" %><%
try{
		System.out.println("LINE ITEM CLIENT ID: " + request.getParameter("CLIENT_ID")); 
		System.out.println("LINE ITEM QUOTE ID: " + request.getParameter("quote_id")); 
		
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
			String palletsCount = "";
			String shippmentTypes = "";
				if(request.getParameter("registerType") != null  && request.getParameter("registerType").equals("Ship")){
			ps = connection2.prepareStatement("select sum(qt) as itemCount from trucking_quote_lineitem_shipping WHERE quote_id = ? ");	
				}else{
			ps = connection2.prepareStatement("select sum(qt) as itemCount from trucking_quote_lineitem WHERE quote_id = ? ");	
				}
			ps.setString(1, request.getParameter("quote_id"));
			ResultSet resultSet = ps.executeQuery();
			while (resultSet.next()) {
				palletsCount = NullCheck.check(resultSet.getString("itemCount"));
			}
			if(!palletsCount.equals("")){
				if(request.getParameter("registerType") != null  && request.getParameter("registerType").equals("Ship")){
			ps = connection2.prepareStatement("select distinct(type) as itemType from trucking_quote_lineitem_shipping WHERE quote_id = ? ");	
				}else{
			ps = connection2.prepareStatement("select distinct(type) as itemType from trucking_quote_lineitem WHERE quote_id = ? ");	
				}
			ps.setString(1, request.getParameter("quote_id"));
			resultSet = ps.executeQuery();
			while (resultSet.next()) {
				shippmentTypes = NullCheck.check(shippmentTypes) + " " + NullCheck.check(resultSet.getString("itemType"));
			}					
			stringResponseAll = stringResponseAll + "<ITEM>" + palletsCount ;
			stringResponseAll = stringResponseAll + "<ITEM>" + shippmentTypes ;
			}else{
				stringResponseAll = "<ITEM>zero<ITEM>zero"  ;
			
			}
	
		stringResponseAll = stringResponseAll + "<ITEM>Done";
		%><%=stringResponseAll%><%
		connection.close();		     
		     //System.out.println("lat/lng=" + lat + "," + lng);
		}catch(Exception ex){
			%><%="" + ex%><%
			System.out.println(ex + "");
		}%>
		