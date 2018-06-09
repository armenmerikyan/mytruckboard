<%@ page import="com.big.util.*,java.text.*,java.util.*,java.io.*,javax.xml.parsers.*,org.w3c.dom.*,java.sql.*,java.text.DateFormat,java.net.URL" %>			
<%@ page import="javax.mail.*" %>
<%@ page import="javax.mail.internet.*" %>
<%@ page import="java.util.*" %>
<%@ page import="com.twilio.sdk.TwilioRestClient" %>
<%@ page import="com.twilio.sdk.resource.factory.SmsFactory" %>
<%@ page import="com.twilio.sdk.resource.instance.Sms" %>
<%
		 try{
		 	System.out.println(request.getParameter("pickup_time"));
		 	System.out.println(request.getParameter("drop_time"));
			Class.forName("com.mysql.jdbc.Driver");
			String url = "jdbc:mysql://localhost/test?zeroDateTimeBehavior=convertToNull";		
			Connection connection = DriverManager.getConnection(url,"<USERNAME>", "<PASSWORD>");	
			PreparedStatement ps ;
				
			int qt = 0; 
			if(!request.getParameter("qt").equals(""))qt = Integer.parseInt(request.getParameter("qt").trim());
				
				
			if(request.getParameter("actionType")!=null && request.getParameter("actionType").equals("PickUp")){
				ps = connection.prepareStatement("Update test.trucking_quote_lineitem Set pickup_status = 'Picked Up', pickup_ts = ?, pickup_qt  = ?, pickup_notes  = ?  where line_item_id = ?");
				ps.setTimestamp(1, new java.sql.Timestamp((new java.util.Date()).getTime()));
				ps.setInt(2, qt);
				ps.setString(3, request.getParameter("notes"));
				ps.setString(4, request.getParameter("line_item_id"));
				ps.executeUpdate();
				connection.close();	
			}
			if(request.getParameter("actionType")!=null && request.getParameter("actionType").equals("DropOff")){
				ps = connection.prepareStatement("Update test.trucking_quote_lineitem Set dropoff_status = 'Drop Off', dropoff_ts = ?, dropoff_qt = ?, dropoff_notes  = ?   where line_item_id = ?");
				ps.setTimestamp(1, new java.sql.Timestamp((new java.util.Date()).getTime()));
				ps.setInt(2, qt);
				ps.setString(3, request.getParameter("notes"));
				ps.setString(4, request.getParameter("line_item_id"));
				ps.executeUpdate();
				connection.close();	
			}
			
		 }catch (Exception ex){	         
		     %><%="Error Posting " + ex%><%  
		     System.out.println(""+ ex + "Rate : " + request.getParameter("per_mile"));
		 }				
				%>Done