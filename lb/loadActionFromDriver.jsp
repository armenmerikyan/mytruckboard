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
			if(request.getParameter("actionType")!=null && request.getParameter("actionType").equals("Accept")){
				if(request.getParameter("registerType") != null  && request.getParameter("registerType").equals("Ship")){
					ps = connection.prepareStatement("Update test.trucking_quote_shipping Set accept_status = 'Accepted', accept_ts = ? where quote_id = ?");
				}else{
					ps = connection.prepareStatement("Update test.trucking_quote Set accept_status = 'Accepted', accept_ts = ? where quote_id = ?");
				}
				ps.setTimestamp(1, new java.sql.Timestamp((new java.util.Date()).getTime()));
				ps.setString(2, request.getParameter("quote_id"));
				ps.executeUpdate();
				connection.close();	
			}
			if(request.getParameter("actionType")!=null && request.getParameter("actionType").equals("Reject")){
				if(request.getParameter("registerType") != null  && request.getParameter("registerType").equals("Ship")){
					ps = connection.prepareStatement("Update test.trucking_quote_shipping Set reject_status = 'Rejected', reject_ts = ? where quote_id = ?");
				}else{
					ps = connection.prepareStatement("Update test.trucking_quote Set reject_status = 'Rejected', reject_ts = ? where quote_id = ?");
				}
				ps.setTimestamp(1, new java.sql.Timestamp((new java.util.Date()).getTime()));
				ps.setString(2, request.getParameter("quote_id"));
				ps.executeUpdate();
				connection.close();	
			}
			if(request.getParameter("actionType")!=null && request.getParameter("actionType").equals("Completed")){
				if(request.getParameter("registerType") != null  && request.getParameter("registerType").equals("Ship")){
					ps = connection.prepareStatement("Update test.trucking_quote_shipping Set completed_status = 'Completed', completed_ts = ? where quote_id = ?");
				}else{
					ps = connection.prepareStatement("Update test.trucking_quote Set completed_status = 'Completed', completed_ts = ? where quote_id = ?");
				}
				ps.setTimestamp(1, new java.sql.Timestamp((new java.util.Date()).getTime()));
				ps.setString(2, request.getParameter("quote_id"));
				ps.executeUpdate();
				connection.close();	
			}
			
		 }catch (Exception ex){	         
		     %><%="Error Posting " + ex%><%  
		     System.out.println(""+ ex + "Rate : " + request.getParameter("per_mile"));
		 }				
				%>Done