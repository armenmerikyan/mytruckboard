<%@ page import="com.big.util.*,java.text.*,java.util.*,java.io.*,javax.xml.parsers.*,org.w3c.dom.*,java.sql.*,java.text.DateFormat,com.twilio.sdk.TwilioRestClient,com.twilio.sdk.TwilioRestException,com.twilio.sdk.TwilioRestClient,com.twilio.sdk.resource.instance.Sms,com.twilio.sdk.resource.list.SmsList,java.util.HashMap,java.util.Map,com.twilio.sdk.resource.factory.SmsFactory,java.text.DecimalFormat" %><%
		System.out.println( request.getParameter("CLIENT_ID"));
		Class.forName("com.mysql.jdbc.Driver");
		String url = "jdbc:mysql://localhost/maids_oltp?user=<USER>&password=<PASSWORD>";		
		Connection connection = DriverManager.getConnection(url);
		System.out.println(request.getParameter("quote_id"));
		PreparedStatement ps = connection.prepareStatement("select * from litem_board_mtb where quote_id = ? order by ts desc limit 100");
		ps.setString(1,request.getParameter("quote_id"));
			
		ResultSet resultSet = ps.executeQuery();
		String stringResponse = new String();
		while (resultSet.next()) {
		long currentTime = Calendar.getInstance().getTime().getTime();
		long postTime = resultSet.getTimestamp("ts").getTime();
    long diff = currentTime - postTime;
    long diffSeconds = diff / 1000 % 60;
    long diffMinutes = diff / (60 * 1000) % 60;
    long diffHours = diff / (60 * 60 * 1000) % 24;
    long diffDays = diff / (60 * 60 * 1000 * 24);
    String timeDurration = "ago" ;
    if (diffSeconds == 1)timeDurration = "1 Second " + timeDurration;
    else if (diffSeconds > 1) timeDurration = diffSeconds + " Seconds " + timeDurration;
    if (diffMinutes == 1)timeDurration = "1 Minute " + timeDurration;
    else if (diffMinutes > 1) timeDurration = diffMinutes + " Minutes " + timeDurration;
    if (diffHours == 1)timeDurration = "1 Hour " + timeDurration;
    else if (diffHours > 1) timeDurration = diffHours + " Hours " + timeDurration;
    if (diffDays == 1)timeDurration = "1 Day " + timeDurration;
    else if (diffDays > 1) timeDurration = diffDays + " Days " + timeDurration;
    
		 	stringResponse += resultSet.getString("messageID") + "<FIELD>" + resultSet.getString("toField") + "<FIELD>" + resultSet.getString("fromField") + "<FIELD>" + resultSet.getString("messageField") + "<FIELD>" + timeDurration +  "<FIELD>DONE" + "<ROW>" ;
		}
		connection.close();
		if(stringResponse.indexOf("<ROW>") > 0)stringResponse = stringResponse.substring(0, stringResponse.length()-5);
		%><%=stringResponse %>