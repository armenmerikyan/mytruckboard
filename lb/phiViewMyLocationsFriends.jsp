<%@ page import="com.big.util.*,java.text.*,java.util.*,java.io.*,javax.xml.parsers.*,org.w3c.dom.*,java.sql.*,java.text.DateFormat,com.twilio.sdk.TwilioRestClient,com.twilio.sdk.TwilioRestException,com.twilio.sdk.TwilioRestClient,com.twilio.sdk.resource.instance.Sms,com.twilio.sdk.resource.list.SmsList,java.util.HashMap,java.util.Map,com.twilio.sdk.resource.factory.SmsFactory,java.text.DecimalFormat" %><%
		String clientid = request.getParameter("CLIENT_ID"); 
		System.out.println(request.getParameter("client_id"));
		java.sql.Timestamp ts = new java.sql.Timestamp((new java.util.Date()).getTime());
		Class.forName("com.mysql.jdbc.Driver");
		String urldb = "jdbc:mysql://localhost/maids_oltp?user=<USER>&password=<PASSWORD>";	
		String stringResponseAll = "";
		Connection connection = DriverManager.getConnection(urldb);
			PreparedStatement ps = connection.prepareStatement("select * from maids_customers WHERE key_client_temp = ?");
			ps.setString(1, clientid);			
			ResultSet resultSetSec = ps.executeQuery();
			while (resultSetSec.next()) {
				clientid = resultSetSec.getString("client_id");
				System.out.println(resultSetSec.getString("client_id"));   
			}
		ps = connection.prepareStatement("select mtb_mylocations.mylocation_id_public, mtb_mylocations.mylocation_id, mtb_mylocations.client_id, mtb_mylocations.mylocation_name, mtb_mylocations.TS, Y(mtb_mylocations.mylocation_LOCATION) as my_lat, X(mtb_mylocations.mylocation_LOCATION) as my_long, aswkt(mtb_mylocations.mylocation_LOCATION)as LOCATIONS from mtb_approved_location_viewer LEFT JOIN mtb_mylocations ON mtb_mylocations.client_id = mtb_approved_location_viewer.client_id_approved where mtb_approved_location_viewer.client_id = ? and mtb_mylocations.isfriendsviewable = 1 and mtb_mylocations.ispublicviewable = 0");		
		ps.setString(1, clientid);
		ResultSet resultSet = ps.executeQuery();
		String stringResponse = new String();
		while (resultSet.next()) {
		 	stringResponse += resultSet.getString("mylocation_id_public") + "<FIELD>" + resultSet.getString("mylocation_name") + "<FIELD>" + resultSet.getString("my_lat") + "<FIELD>" + resultSet.getString("my_long") + "<FIELD>" + resultSet.getString("LOCATIONS") + "<FIELD>" + resultSet.getString("TS") +"<ROW>" ;
		}
		connection.close();
		if(stringResponse.indexOf("<ROW>") > 0)stringResponse = stringResponse.substring(0, stringResponse.length()-5);
		%><%=stringResponse %>