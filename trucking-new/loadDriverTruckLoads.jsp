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
			stringResponseAll = stringResponseAll + "START";
			ps = connection.prepareStatement("select * from maids_customers WHERE client_id = ?");
			ps.setString(1, clientid);			
			ResultSet resultSet = ps.executeQuery();
			String emailCustomer = "";
			while (resultSet.next()) {
				emailCustomer = resultSet.getString("email");
			}
			
			if(request.getParameter("loadType")!=null && request.getParameter("loadType").equals("Scheduled")){
				ps = connection2.prepareStatement("select Y(pickcityLOCATION) as my_lat, X(pickcitylocation) as my_long, Y(destcityLOCATION) as my_latdest, X(destcityLOCATION) as my_longdest, pickup_date, drop_date, pickCity, pickUp_address, pickUp_notes, pickUp_contact, quote_id,  destCity, miscel_pay  from TRUCKING_EQUIPMENT LEFT JOIN trucking_quote as trk_quote ON trk_quote.equipment_id = TRUCKING_EQUIPMENT.id where TRUCKING_EQUIPMENT.driver_email = ? and trk_quote.accept_status = 'Accepted' and trk_quote.reject_status is null and trk_quote.completed_status is null order by trk_quote.ts desc limit 50");	
			}else if(request.getParameter("loadType")!=null && request.getParameter("loadType").equals("Rejected")){
				ps = connection2.prepareStatement("select Y(pickcityLOCATION) as my_lat, X(pickcitylocation) as my_long, Y(destcityLOCATION) as my_latdest, X(destcityLOCATION) as my_longdest, pickup_date, drop_date, pickCity, pickUp_address, pickUp_notes, pickUp_contact, quote_id,  destCity, miscel_pay   from TRUCKING_EQUIPMENT LEFT JOIN trucking_quote as trk_quote ON trk_quote.equipment_id = TRUCKING_EQUIPMENT.id where TRUCKING_EQUIPMENT.driver_email = ? and trk_quote.reject_status = 'Rejected' order by trk_quote.ts desc limit 50");	
			}else if(request.getParameter("loadType")!=null && request.getParameter("loadType").equals("Completed")){
				ps = connection2.prepareStatement("select Y(pickcityLOCATION) as my_lat, X(pickcitylocation) as my_long, Y(destcityLOCATION) as my_latdest, X(destcityLOCATION) as my_longdest, pickup_date, drop_date, pickCity, pickUp_address, pickUp_notes, pickUp_contact, quote_id,  destCity, miscel_pay   from TRUCKING_EQUIPMENT LEFT JOIN trucking_quote as trk_quote ON trk_quote.equipment_id = TRUCKING_EQUIPMENT.id where TRUCKING_EQUIPMENT.driver_email = ? and trk_quote.completed_status = 'Completed' order by trk_quote.ts desc limit 50");	
			}else if(request.getParameter("loadType")!=null && request.getParameter("loadType").equals("Bybroker")){
				ps = connection2.prepareStatement("select distinct(company_id) from TRUCKING_EQUIPMENT where driver_email = ? ");	
				ps.setString(1, emailCustomer);
				resultSet = ps.executeQuery();
				int j = 1;
				String brokerID = "";
				while (resultSet.next()) {
					if(Integer.parseInt(request.getParameter("brokerCount")) == j){
						brokerID = resultSet.getString("company_id");
					}
					j +=1;
				}
				ps = connection2.prepareStatement("select Y(pickcityLOCATION) as my_lat, X(pickcitylocation) as my_long, Y(destcityLOCATION) as my_latdest, X(destcityLOCATION) as my_longdest, pickup_date, drop_date, pickCity, pickUp_address, pickUp_notes, pickUp_contact, quote_id,  destCity, miscel_pay from TRUCKING_EQUIPMENT LEFT JOIN trucking_quote as trk_quote ON trk_quote.equipment_id = TRUCKING_EQUIPMENT.id where TRUCKING_EQUIPMENT.driver_email = ? and trk_quote.accept_status = 'Accepted' and trk_quote.reject_status is null and trk_quote.completed_status is null and trk_quote.company_id = ? order by trk_quote.ts desc limit 50");	
				ps.setString(1, emailCustomer);
				ps.setString(2, brokerID);
			}else{
				ps = connection2.prepareStatement("select Y(pickcityLOCATION) as my_lat, X(pickcitylocation) as my_long, Y(destcityLOCATION) as my_latdest, X(destcityLOCATION) as my_longdest, pickup_date, drop_date, pickCity, pickUp_address, pickUp_notes, pickUp_contact, quote_id,  destCity, miscel_pay   from TRUCKING_EQUIPMENT LEFT JOIN trucking_quote as trk_quote ON trk_quote.equipment_id = TRUCKING_EQUIPMENT.id where TRUCKING_EQUIPMENT.driver_email = ? and trk_quote.accept_status is null and trk_quote.reject_status is null and trk_quote.completed_status is null order by trk_quote.ts desc limit 50");	
			}
			ps.setString(1, emailCustomer);
			resultSet = ps.executeQuery();
			DateFormat df = new SimpleDateFormat("MM/dd/yyyy");
			DateFormat df2 = new SimpleDateFormat("MM/dd/yyyy");
			DateFormat dfTime = new SimpleDateFormat("hh:mm aa");
			while (resultSet.next()) {
				String pickUpDate = "No Info";
				String dropDate = "No Info";
				String pickUpTime = "NA";
				if(resultSet.getTimestamp("pickup_date")!=null)pickUpDate = df.format(resultSet.getTimestamp("pickup_date"));
				if(resultSet.getTimestamp("pickup_date")!=null)pickUpTime = dfTime.format(resultSet.getTimestamp("pickup_date"));
				if(resultSet.getTimestamp("drop_date")!=null)dropDate = df2.format(resultSet.getTimestamp("drop_date"));
				stringResponseAll = stringResponseAll + "Start<FIELD>" + NullCheck.check(resultSet.getString("pickCity")) + "<FIELD>" + pickUpDate + "<FIELD>" + pickUpTime + "<FIELD>" + NullCheck.check(resultSet.getString("pickUp_address")) + "<FIELD>" + NullCheck.check(resultSet.getString("pickUp_notes")) +  "<FIELD>" + NullCheck.check(resultSet.getString("pickUp_contact")) + "<FIELD>" + resultSet.getString("quote_id") + "<FIELD>" + NullCheck.check(request.getParameter("loadType")) + "<FIELD>" + NullCheck.check(resultSet.getString("destCity")) + "<FIELD>" + dropDate + "<FIELD>" + NullCheck.check(resultSet.getString("miscel_pay")) + "<FIELD>" + resultSet.getString("my_lat") + "<FIELD>" + resultSet.getString("my_long") + "<FIELD>" + resultSet.getString("my_latdest") + "<FIELD>" + resultSet.getString("my_longdest")+ "<FIELD>Done<ROW>";
				System.out.println(resultSet.getString("pickup_date"));
			}	
			if(stringResponseAll.indexOf("<ROW>") > 0)stringResponseAll = stringResponseAll.substring(0, stringResponseAll.length()-5);		
		%><%=stringResponseAll%><%
		connection.close();		     
		     //System.out.println("lat/lng=" + lat + "," + lng);
		}catch(Exception ex){
			%><%="" + ex%><%
			System.out.println(ex + "");
		}%>
		