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
			if(request.getParameter("isSentView")!=null && request.getParameter("isSentView").equals("YES")){
				ps = connection.prepareStatement("select * from mtb_approved_location_viewer WHERE client_id = ?");
				ps.setString(1, clientid);			
				ResultSet resultSet = ps.executeQuery();
				String emailCustomer = "";
				while (resultSet.next()) {
					String pickUpDate = "No Info";
					String pickUpTime = "NA";
					stringResponseAll = stringResponseAll + "Start<FIELD>" + NullCheck.check(resultSet.getString("email_approved")) + "<FIELD>" + NullCheck.check(resultSet.getString("name_approved")) + "<FIELD>" + NullCheck.check(resultSet.getString("approved_id")) + "<FIELD>" + resultSet.getBoolean("is_approved")+ "<FIELD>Done<ROW>" ;
				}			
			}else{
				ps = connection.prepareStatement("select * from mtb_approved_location_viewer LEFT JOIN maids_customers as trk_customer ON trk_customer.client_id = mtb_approved_location_viewer.client_id WHERE client_id_approved = ?");			
				ps.setString(1, clientid);			
				ResultSet resultSet = ps.executeQuery();
				String emailCustomer = "";
				while (resultSet.next()) {
					String pickUpDate = "No Info";
					String pickUpTime = "NA";
					stringResponseAll = stringResponseAll + "Start<FIELD>" + NullCheck.check(resultSet.getString("email")) + "<FIELD>" + NullCheck.check(resultSet.getString("f_name")) + " " + NullCheck.check(resultSet.getString("l_name")) + "<FIELD>" + NullCheck.check(resultSet.getString("approved_id")) + "<FIELD>" + resultSet.getBoolean("is_approved")+ "<FIELD>Done<ROW>" ;
				}				
			}
	
			if(stringResponseAll.indexOf("<ROW>") > 0)stringResponseAll = stringResponseAll.substring(0, stringResponseAll.length()-5);		
		%><%=stringResponseAll%><%
		connection.close();		     
		     //System.out.println("lat/lng=" + lat + "," + lng);
		}catch(Exception ex){
			%><%="" + ex%><%
			System.out.println(ex + "");
		}%>
		