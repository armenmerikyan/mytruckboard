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
			String brokerOwner = "";
			String brokerCompany = "";
			String brokerEmail = "";
			String brokerPhone = "";
			String emailCustomer = "";
			String brokerID = "";
			String brokerLoadCount = "";
			
			while (resultSet.next()) {
				emailCustomer = resultSet.getString("email");
			}
			
			ps = connection2.prepareStatement("select distinct(company_id) from trucking_shipping where driver_email = ? ");	
			ps.setString(1, emailCustomer);
			resultSet = ps.executeQuery();
			int j = 1;
			while (resultSet.next()) {
				if(Integer.parseInt(request.getParameter("brokerCount")) == j){
					brokerID = resultSet.getString("company_id");
				}
				j +=1;
			}			
			ps = connection2.prepareStatement("select * from trucking_company where company_id = ? ");	
			ps.setString(1, brokerID);
			resultSet = ps.executeQuery();
			while (resultSet.next()) {
				brokerCompany = NullCheck.check(resultSet.getString("name"));
				brokerOwner = NullCheck.check(resultSet.getString("contact_name"));
				brokerEmail = NullCheck.check(resultSet.getString("email"));
				brokerPhone = NullCheck.check(resultSet.getString("phone"));
			}
			ps = connection2.prepareStatement("select count(distinct(quote_id)) as quote_count from trucking_shipping LEFT JOIN trucking_quote as trk_quote ON trk_quote.equipment_id = trucking_shipping.id where trucking_shipping.driver_email = ? and trk_quote.accept_status = 'Accepted' and trk_quote.reject_status is null and trk_quote.completed_status is null and trucking_shipping.company_id = ? order by trk_quote.ts desc");	
			ps.setString(1, emailCustomer);		
			ps.setString(2, brokerID);		
			resultSet = ps.executeQuery();
			while (resultSet.next()) {
				brokerLoadCount = resultSet.getString("quote_count");
			}
			stringResponseAll = stringResponseAll + "<ITEM>" + brokerOwner ;
			stringResponseAll = stringResponseAll + "<ITEM>" + brokerCompany ;
			stringResponseAll = stringResponseAll + "<ITEM>" + brokerEmail ;
			stringResponseAll = stringResponseAll + "<ITEM>" + brokerPhone ;
			stringResponseAll = stringResponseAll + "<ITEM>" + brokerLoadCount ;

		stringResponseAll = stringResponseAll + "<ITEM>Done";
		%><%=stringResponseAll%><%
		connection.close();		     
		     //System.out.println("lat/lng=" + lat + "," + lng);
		}catch(Exception ex){
			%><%="" + ex%><%
			System.out.println(ex + "");
		}%>
		