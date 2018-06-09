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
			String phoneCustomer = "";
			String brokerCount = "";
			String rejectCount = "0";
			String completedCount = "0";
			String companyName = "";
			String ownerName = "";
			String truckDriverName = "";
			String truckDriverFName = "";
			String truckDriverLName = "";
			String truckDriverLocation = "";
			String wtg = "";
			String basicNotes = "";
			String specialNotes = "";
			String ratePerMile = "";
			String truckType = "";
			String driverStatusCode = "";
			while (resultSet.next()) {
				emailCustomer = resultSet.getString("email");
				if(resultSet.getString("phone").length()<18)phoneCustomer = resultSet.getString("phone");
				if(resultSet.getString("f_name")!=null)truckDriverFName = resultSet.getString("f_name");
				if(resultSet.getString("l_name")!=null)truckDriverLName = resultSet.getString("l_name");
				if(resultSet.getString("f_name")!=null && resultSet.getString("l_name")!=null)truckDriverName = resultSet.getString("f_name") + " " + resultSet.getString("l_name");
				if(resultSet.getString("company_name")!=null)companyName = resultSet.getString("company_name");
				if(resultSet.getString("owner_name")!=null)ownerName = resultSet.getString("owner_name");
				if(resultSet.getString("wtg")!=null)wtg = resultSet.getString("wtg");
				if(resultSet.getString("basicNotes")!=null)basicNotes = resultSet.getString("basicNotes");
				if(resultSet.getString("specialNotes")!=null)specialNotes = resultSet.getString("specialNotes");
				if(resultSet.getString("price_per_mile")!=null)ratePerMile = resultSet.getString("price_per_mile");
				if(resultSet.getString("current_state")!=null)driverStatusCode = resultSet.getString("current_state");
				if(resultSet.getString("currentTruckType")!=null)truckType = resultSet.getString("currentTruckType");
			}	
			

			ps = connection2.prepareStatement("select count(company_id) as itemCount from TRUCKING_COMPANY where isTestAccount = 0");	
//			ps = connection2.prepareStatement("select count(distinct(company_id)) as itemCount from TRUCKING_EQUIPMENT where driver_email = ? ");	
//			ps.setString(1, emailCustomer);
			resultSet = ps.executeQuery();
			while (resultSet.next()) {
				brokerCount = resultSet.getString("itemCount");
			}
			
			
				if(request.getParameter("registerType") != null  && request.getParameter("registerType").equals("Ship")){
					ps = connection2.prepareStatement("select count(distinct(quote_id)) as itemCount from trucking_shipping LEFT JOIN trucking_quote_shipping as trk_quote ON trk_quote.equipment_id = trucking_shipping.id where trucking_shipping.driver_email = ? and trk_quote.reject_status = 'Rejected'");	
				}else{
					ps = connection2.prepareStatement("select count(distinct(quote_id)) as itemCount from TRUCKING_EQUIPMENT LEFT JOIN trucking_quote as trk_quote ON trk_quote.equipment_id = TRUCKING_EQUIPMENT.id where TRUCKING_EQUIPMENT.driver_email = ? and trk_quote.reject_status = 'Rejected'");	
				}
			ps.setString(1, emailCustomer);
			resultSet = ps.executeQuery();
			while (resultSet.next()) {
				rejectCount = resultSet.getString("itemCount");
			}

				if(request.getParameter("registerType") != null  && request.getParameter("registerType").equals("Ship")){
			ps = connection2.prepareStatement("select count(distinct(quote_id)) as itemCount from trucking_shipping LEFT JOIN trucking_quote_shipping as trk_quote ON trk_quote.equipment_id = trucking_shipping.id where trucking_shipping.driver_email = ? and trk_quote.completed_status = 'Completed'");	
				}else{
			ps = connection2.prepareStatement("select count(distinct(quote_id)) as itemCount from TRUCKING_EQUIPMENT LEFT JOIN trucking_quote as trk_quote ON trk_quote.equipment_id = TRUCKING_EQUIPMENT.id where TRUCKING_EQUIPMENT.driver_email = ? and trk_quote.completed_status = 'Completed'");	
				}
			ps.setString(1, emailCustomer);
			resultSet = ps.executeQuery();
			while (resultSet.next()) {
				completedCount = resultSet.getString("itemCount");
			}			
			
			stringResponseAll = stringResponseAll + "<ITEM>" + emailCustomer ;
			stringResponseAll = stringResponseAll + "<ITEM>" + phoneCustomer ;
			stringResponseAll = stringResponseAll + "<ITEM>" + brokerCount ;
			stringResponseAll = stringResponseAll + "<ITEM>" + rejectCount ;
			stringResponseAll = stringResponseAll + "<ITEM>" + completedCount ;
			stringResponseAll = stringResponseAll + "<ITEM>" + companyName ;
			stringResponseAll = stringResponseAll + "<ITEM>" + ownerName ;
			stringResponseAll = stringResponseAll + "<ITEM>" + truckDriverName ;
			stringResponseAll = stringResponseAll + "<ITEM>" + truckDriverLocation ;
			stringResponseAll = stringResponseAll + "<ITEM>" + truckDriverFName ;
			stringResponseAll = stringResponseAll + "<ITEM>" + truckDriverLName ;
			stringResponseAll = stringResponseAll + "<ITEM>" + wtg ;
			stringResponseAll = stringResponseAll + "<ITEM>" + basicNotes ;
			stringResponseAll = stringResponseAll + "<ITEM>" + specialNotes ;
			stringResponseAll = stringResponseAll + "<ITEM>" + ratePerMile ;
			stringResponseAll = stringResponseAll + "<ITEM>" + truckType ;
			stringResponseAll = stringResponseAll + "<ITEM>" + driverStatusCode ;
			
		stringResponseAll = stringResponseAll + "<ITEM>Done";
		%><%=stringResponseAll%><%
		connection.close();		     
		     //System.out.println("lat/lng=" + lat + "," + lng);
		}catch(Exception ex){
			%><%="" + ex%><%
			System.out.println(ex + "");
		}%>
		