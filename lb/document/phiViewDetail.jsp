<%@ page import="com.big.util.*,java.text.*,java.util.*,java.io.*,javax.xml.parsers.*,org.w3c.dom.*,java.sql.*,java.text.DateFormat,com.twilio.sdk.TwilioRestClient,com.twilio.sdk.TwilioRestException,com.twilio.sdk.TwilioRestClient,com.twilio.sdk.resource.instance.Sms,com.twilio.sdk.resource.list.SmsList,java.util.HashMap,java.util.Map,com.twilio.sdk.resource.factory.SmsFactory,java.text.DecimalFormat" %><%
		System.out.println( request.getParameter("CLIENT_ID"));
		Class.forName("com.mysql.jdbc.Driver");
		String url = "jdbc:mysql://localhost/maids_oltp?user=<USER>&password=<PASSWORD>";		
		Connection connection = DriverManager.getConnection(url);
		PreparedStatement ps = connection.prepareStatement("select count(item_id) as itemCount from litem_board_heart where item_id = ? ");	
		ps.setString(1, request.getParameter("spark_id"));
		ResultSet resultSet = ps.executeQuery();
		String stringResponse = new String();
		String countResult = "0";
		String countResultClient = "F";
		while (resultSet.next()) {
		 	countResult = resultSet.getString("itemCount");
		}
		stringResponse += countResult + "<ITEM>";
		countResultClient = "F<ITEM>";
		ResultSet resultClientSet ;
		if(!countResult.equals("0")){
			ps = connection.prepareStatement("select count(item_id) as itemCount from litem_board_heart where item_id = ? and client_id = ?");	
			ps.setString(1, request.getParameter("spark_id"));
			ps.setString(2, request.getParameter("clientID"));
			resultClientSet = ps.executeQuery();		
			while (resultClientSet.next()) {
				countResultClient = "T<ITEM>";
			}	
		}
		stringResponse += countResultClient;
		countResult = "0";
		ps = connection.prepareStatement("select count(item_id) as itemCount from litem_board_fake where item_id = ? ");	
		ps.setString(1, request.getParameter("spark_id"));
		resultSet = ps.executeQuery();
		while (resultSet.next()) {
		 	countResult = resultSet.getString("itemCount");
		}
		stringResponse += countResult + "<ITEM>";
		countResultClient = "F<ITEM>";
		if(!countResult.equals("0")){
			ps = connection.prepareStatement("select count(item_id) as itemCount from litem_board_block where item_id = ? and client_id = ?");	
			ps.setString(1, request.getParameter("spark_id"));
			ps.setString(2, request.getParameter("clientID"));
			resultClientSet = ps.executeQuery();		
			while (resultClientSet.next()) {
				countResultClient = "T<ITEM>";
			}	
		}
		stringResponse += countResultClient;
		
		countResult = "0";
		ps = connection.prepareStatement("select count(item_id) as itemCount from litem_board_vote where item_id = ? and vote_type = 'Up' ");	
		ps.setString(1, request.getParameter("spark_id"));
		resultSet = ps.executeQuery();
		while (resultSet.next()) {
		 	countResult = resultSet.getString("itemCount");
		}
		stringResponse += countResult + "<ITEM>";
		countResultClient = "F<ITEM>";
		if(!countResult.equals("0")){
			ps = connection.prepareStatement("select count(item_id) as itemCount from litem_board_vote where item_id = ? and client_id = ? and vote_type = 'Up'");	
			ps.setString(1, request.getParameter("spark_id"));
			ps.setString(2, request.getParameter("clientID"));
			resultClientSet = ps.executeQuery();		
			while (resultClientSet.next()) {
				countResultClient = "T<ITEM>";
			}	
		}
		stringResponse += countResultClient;

		
		countResult = "0";
		ps = connection.prepareStatement("select count(item_id) as itemCount from litem_board_vote where item_id = ? and vote_type = 'Down' ");	
		ps.setString(1, request.getParameter("spark_id"));
		resultSet = ps.executeQuery();
		while (resultSet.next()) {
		 	countResult = resultSet.getString("itemCount");
		}
		stringResponse += countResult + "<ITEM>";
		countResultClient = "F<ITEM>";
		if(!countResult.equals("0")){
			ps = connection.prepareStatement("select count(item_id) as itemCount from litem_board_vote where item_id = ? and client_id = ? and vote_type = 'Down'");	
			ps.setString(1, request.getParameter("spark_id"));
			ps.setString(2, request.getParameter("clientID"));
			resultClientSet = ps.executeQuery();		
			while (resultClientSet.next()) {
				countResultClient = "T<ITEM>";
			}	
		}
		stringResponse += countResultClient;


		countResult = "0";
		ps = connection.prepareStatement("select count(item_id) as itemCount from litem_board_block where item_id = ? ");	
		ps.setString(1, request.getParameter("spark_id"));
		resultSet = ps.executeQuery();
		while (resultSet.next()) {
		 	countResult = resultSet.getString("itemCount");
		}
		stringResponse += countResult + "<ITEM>";
		countResultClient = "F<ITEM>";
		if(!countResult.equals("0")){
			ps = connection.prepareStatement("select count(item_id) as itemCount from litem_board_block where item_id = ? and client_id = ?");	
			ps.setString(1, request.getParameter("spark_id"));
			ps.setString(2, request.getParameter("clientID"));
			resultClientSet = ps.executeQuery();		
			while (resultClientSet.next()) {
				countResultClient = "T<ITEM>";
			}	
		}
		stringResponse += countResultClient;
		
		connection.close();
		%><%=stringResponse %>