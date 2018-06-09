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
//		ps = connection.prepareStatement("select trk_trucks.directioncurrent, key_public, mtb_approved_location_viewer.client_id_approved, trk_trucks.phone, trk_trucks.f_name, trk_trucks.client_id, trk_trucks.TS, Y(trk_trucks.LOCATION) as my_lat, X(trk_trucks.LOCATION) as my_long, aswkt(trk_trucks.LOCATION)as LOCATIONS from mtb_approved_location_viewer LEFT JOIN maids_customers as trk_trucks ON trk_trucks.client_id = mtb_approved_location_viewer.client_id_approved  where mtb_approved_location_viewer.is_approved = 1 and mtb_approved_location_viewer.client_id = ? and trk_trucks.location is not null");		
		ps = connection.prepareStatement("select trk_trucks.directioncurrent, key_public, trk_trucks.phone, trk_trucks.f_name, trk_trucks.client_id, trk_trucks.TS, Y(trk_trucks.LOCATION) as my_lat, X(trk_trucks.LOCATION) as my_long, aswkt(trk_trucks.LOCATION)as LOCATIONS from maids_customers as trk_trucks  where trk_trucks.location is not null order by ts_last_update desc limit 100");		
//		ps.setString(1, clientid);
		ResultSet resultSet = ps.executeQuery();
		String stringResponse = new String();
		while (resultSet.next()) {
			String phoneTemp = "";
			if(resultSet.getString("phone")!=null && resultSet.getString("phone").length()<13){
				//phoneTemp = " " + resultSet.getString("phone");
			}
			if(!resultSet.getString("client_id").equals(clientid)){
		 	stringResponse += resultSet.getString("key_public") + "<FIELD>" + NullCheck.check(resultSet.getString("f_name")) + phoneTemp +"<FIELD>" + resultSet.getString("my_lat") + "<FIELD>" + resultSet.getString("my_long") + "<FIELD>" + resultSet.getString("LOCATIONS") + "<FIELD>" + resultSet.getString("TS") +  "<FIELD>" + resultSet.getString("trk_trucks.directioncurrent") + "<ROW>" ;
			}
		}
		connection.close();
		if(stringResponse.indexOf("<ROW>") > 0)stringResponse = stringResponse.substring(0, stringResponse.length()-5);
		%><%=stringResponse %>