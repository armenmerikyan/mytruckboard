<%@ page import="org.w3c.dom.Node,org.w3c.dom.NodeList,org.xml.sax.InputSource,org.w3c.dom.Document,javax.xml.xpath.XPath,javax.xml.xpath.XPathConstants,javax.xml.xpath.XPathFactory,javax.xml.parsers.DocumentBuilderFactory,java.net.HttpURLConnection,java.net.URL,java.net.URLEncoder,com.big.util.*,java.text.*,java.util.*,java.io.*,javax.xml.parsers.*,org.w3c.dom.*,java.sql.*,java.text.DateFormat,com.twilio.sdk.TwilioRestClient,com.twilio.sdk.TwilioRestException,com.twilio.sdk.TwilioRestClient,com.twilio.sdk.resource.instance.Sms,com.twilio.sdk.resource.list.SmsList,java.util.HashMap,java.util.Map,com.twilio.sdk.resource.factory.SmsFactory" %>
<%@ page import="com.twilio.sdk.TwilioRestClient" %>
<%@ page import="com.twilio.sdk.resource.factory.SmsFactory" %>
<%@ page import="com.twilio.sdk.resource.instance.Sms" %>
<%@ page import="javax.mail.Message" %>
<%@ page import="javax.mail.MessagingException" %>
<%@ page import="javax.mail.Session" %>
<%@ page import="javax.mail.Transport" %>
<%@ page import="javax.mail.internet.InternetAddress" %>
<%@ page import="javax.mail.internet.MimeMessage" %>
<%
     final String ACCOUNT_SID = "ACbc6b5f29c1627c6aa7e51f5ad340fa2d";
     final String AUTH_TOKEN = "767154b209800bd1be13e38d8a01fc1b";
     final String FROM = "info@yawadi.com";   // Replace with your "From" address. This address must be verified.
     final String SMTP_USERNAME = "AKIAINFCRKGVZNSB7DHQ";  // Replace with your SMTP username.
     final String SMTP_PASSWORD = "Ar/mcRQJkM9i7Vl45r+CzSrgx/QGb+vuJIuIDfJp/mj8";  // Replace with your SMTP password.
     final String HOST = "email-smtp.us-east-1.amazonaws.com";    
     final int PORT = 25;

%>
<%
		String responseText = "";
		String registration_id = "";
		boolean loginTrue = false;
		boolean isEmailVerified = false;
		boolean isPhoneVerified = false;
		String client_provider_id = "";
		String client_db_id = "";
		String cc_mask = "";
		String cc_brand = "";
		String client_name = "";
		String returnEmail = "";
		String returnPhone = "";						
		String phoneNumber = request.getParameter("phone");
		String emailAddress = request.getParameter("email");
		System.out.println("--" + emailAddress + "--");
		if(emailAddress.equals("")){
			emailAddress = phoneNumber + "@myTruckBoard.com";
		}
			if(phoneNumber.equals("")){
			phoneNumber = UUID.randomUUID() + "";
		}
		try{
		
		Random randomGenerator = new Random();
		String promoCodeInt = randomGenerator.nextInt(10000)+""; 
		System.out.println("ACTION TEXT XXXXXXXX: " + request.getParameter("action"));    
		System.out.println("ACTION TEXT XXXXXXXX: " + request.getParameter("action")); 
		System.out.println("ACTION TEXT XXXXXXXX: " + request.getParameter("email"));   
		System.out.println("ACTION TEXT XXXXXXXX: " + request.getParameter("phone"));     
		java.sql.Timestamp ts = new java.sql.Timestamp((new java.util.Date()).getTime());
		Class.forName("com.mysql.jdbc.Driver");
		String urldb = "jdbc:mysql://localhost/maids_oltp?user=<USER>&password=<PASSWORD>";		
		Connection connection = DriverManager.getConnection(urldb);

			if(!request.getParameter("phonePin").equals("")){
				PreparedStatement ps = connection.prepareStatement("Update maids_customers SET isPhoneVerified = 1 WHERE (EMAIL = ? or phone =?) and PASSWORD = ? and phone_pin = ?");
				ps.setString(1, request.getParameter("email").toLowerCase());			
				ps.setString(2, request.getParameter("phone"));			
				ps.setString(3, request.getParameter("password"));			
				ps.setString(4, request.getParameter("phonePin"));			
				ps.executeUpdate();

			}
			if(!request.getParameter("emailPin").equals("")){
				PreparedStatement ps = connection.prepareStatement("Update maids_customers SET isEmailVerified = 1 WHERE (EMAIL = ? or phone =?) and PASSWORD = ? and email_pin = ?");
				ps.setString(1, request.getParameter("email").toLowerCase());			
				ps.setString(2, request.getParameter("phone"));			
				ps.setString(3, request.getParameter("password"));			
				ps.setString(4, request.getParameter("emailPin"));			
				ps.executeUpdate();

			}
			if((request.getParameter("phone") != null  || request.getParameter("email") !=null) && request.getParameter("password") !=null && !request.getParameter("password").equals("")){
			

				
			PreparedStatement ps = connection.prepareStatement("select * from maids_customers WHERE (EMAIL = ? or phone = ?) and PASSWORD = ? limit 1");
			ps.setString(1, emailAddress.toLowerCase());			
			ps.setString(2, phoneNumber);			
			ps.setString(3, request.getParameter("password"));			
			ResultSet resultSet = ps.executeQuery();
			
			while (resultSet.next()) {
				loginTrue = true;
				isEmailVerified = resultSet.getBoolean("isemailverified");
				isPhoneVerified = resultSet.getBoolean("isphoneverified");
				client_provider_id =   resultSet.getString("maid_user_id");
				returnEmail = resultSet.getString("email");
				returnPhone = resultSet.getString("phone");
				if(resultSet.getString("ccName")!=null && !resultSet.getString("ccName").equals("(null)"))client_name = resultSet.getString("ccName");
				client_db_id = UUID.randomUUID() + "";				
				cc_mask = resultSet.getString("cc_mask_no");		
				cc_brand = resultSet.getString("ccBrand");
 				ps = connection.prepareStatement("Update maids_customers SET key_client_temp = ? WHERE (EMAIL = ? and PASSWORD = ?) or (phone = ? and PASSWORD = ?)");
				ps.setString(1, client_db_id);			
				ps.setString(2, emailAddress.toLowerCase());			
				ps.setString(3, request.getParameter("password"));
				ps.setString(4, request.getParameter("phone"));			
				ps.setString(5, request.getParameter("password"));			
				ps.executeUpdate();
			}
			if(!loginTrue && request.getParameter("action").equals("Register")){

				String smsCode = randomGenerator.nextInt(10000)+""; 
				String emailCode = randomGenerator.nextInt(10000)+"";
				String registrationID = UUID.randomUUID() + "";
				client_db_id = registrationID;
				ps = connection.prepareStatement("INSERT INTO maids_customers(registration_id, client_id, email, phone, TS, email_pin, phone_pin, isemailverified, isphoneverified, password, key_client_temp, key_public, key_private, key_db) VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
				ps.setString(1, registrationID);
				ps.setString(2, client_db_id);
				ps.setString(3, emailAddress);
				ps.setString(4, phoneNumber);
				ps.setTimestamp(5, ts);
				ps.setString(6, emailCode);
				ps.setString(7, smsCode);
				ps.setInt(8, 0);
				ps.setInt(9, 0);
				ps.setString(10, request.getParameter("password"));
				ps.setString(11, UUID.randomUUID() + "");
				ps.setString(12, UUID.randomUUID() + "");
				ps.setString(13, UUID.randomUUID() + "");
				ps.setString(14, UUID.randomUUID() + "");
				responseText = "" + ps.executeUpdate();
				loginTrue = true;
					if(true){

				String url2 = "jdbc:mysql://localhost/test?user=<PASSWORD>&password=<PASSWORD>";
				Connection connection2 = DriverManager.getConnection(url2,"<USERNAME>", "<PASSWORD>");
				String equipmentID = UUID.randomUUID()+ "";
				String quoteID = UUID.randomUUID()+ "";
				String company_ID = "1477d595-25c4-483e-aa99-f73848fc2592";
				PreparedStatement psMtb = connection2.prepareStatement("INSERT INTO test.TRUCKING_EQUIPMENT(ID, COMPANY_ID, DRIVER_EMAIL, ts) VALUES (?,?,?,?)");
				if(request.getParameter("registerType") != null  && request.getParameter("registerType").equals("Ship")){
					psMtb = connection2.prepareStatement("INSERT INTO test.TRUCKING_SHIPPING(ID, COMPANY_ID, DRIVER_EMAIL, ts) VALUES (?,?,?,?)");
				}else{
					psMtb = connection2.prepareStatement("INSERT INTO test.TRUCKING_EQUIPMENT(ID, COMPANY_ID, DRIVER_EMAIL, ts) VALUES (?,?,?,?)");
				}
				psMtb.setString(1, equipmentID);
				psMtb.setString(2, company_ID);
				psMtb.setString(3, emailAddress);
				psMtb.setTimestamp(4, ts);
				psMtb.executeUpdate();
				

				if(request.getParameter("registerType") != null  && request.getParameter("registerType").equals("Ship")){
					psMtb = connection2.prepareStatement("INSERT INTO test.trucking_quote_shipping(quote_id, ts, company_id, equipment_id, drop_address, pickUp_address, miscel_pay, pickup_notes, drop_notes, pickup_contact, drop_contact, pickup_phone, drop_phone,pickCity, pickState, destCity, destState) VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
				}else{
					psMtb = connection2.prepareStatement("INSERT INTO test.trucking_quote(quote_id, ts, company_id, equipment_id, drop_address, pickUp_address, miscel_pay, pickup_notes, drop_notes, pickup_contact, drop_contact, pickup_phone, drop_phone,pickCity, pickState, destCity, destState) VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
				}
				psMtb.setString(1, quoteID);			
				psMtb.setTimestamp(2, new java.sql.Timestamp((new java.util.Date()).getTime()));
				psMtb.setString(3, company_ID);
				psMtb.setString(4, equipmentID);
				psMtb.setString(5, "Los Angeles");
				psMtb.setString(6, "Mountain View");
				psMtb.setInt(7, 130);
				psMtb.setString(8, "This is a test note. Check in at the front");
				psMtb.setString(9, "Say hi to Jack");
				psMtb.setString(10, "Jane");
				psMtb.setString(11, "Fred");
				psMtb.setString(12, "555 867-5309");
				psMtb.setString(13, "555 898-8988");
				psMtb.setString(14, "Los Angeles");
				psMtb.setString(15, "CA");
				psMtb.setString(16, "Malibu");
				psMtb.setString(17, "CA");
				psMtb.executeUpdate();	
				
				if(request.getParameter("registerType") != null  && request.getParameter("registerType").equals("Ship")){
					psMtb = connection2.prepareStatement("INSERT INTO test.trucking_quote_lineitem_shipping(line_item_id, external_id, ts, description, type, qt, length, width, height, weight, quote_id) VALUES (?,?,?,?,?,?,?,?,?,?,?)");				
				}else{
					psMtb = connection2.prepareStatement("INSERT INTO test.trucking_quote_lineitem(line_item_id, external_id, ts, description, type, qt, length, width, height, weight, quote_id) VALUES (?,?,?,?,?,?,?,?,?,?,?)");				
				}
				psMtb.setString(1, UUID.randomUUID() + "");
				psMtb.setString(2, "ID2238");
				psMtb.setTimestamp(3, new java.sql.Timestamp((new java.util.Date()).getTime()));	
				psMtb.setString(4, "Boxes of paper");
				psMtb.setString(5, "Boxes");	
				psMtb.setInt(6, 10);	
				psMtb.setFloat(7, 1.0f);
				psMtb.setFloat(8, 1.0f);
				psMtb.setFloat(9, 1.0f);
				psMtb.setInt(10, 1);
				psMtb.setString(11, quoteID);	
				psMtb.executeUpdate();				

				ps = connection.prepareStatement("INSERT INTO maids_promo_codes(promo_id, ts, promo_code, promo_type, promo_amount) VALUES (?,?,?,?,?)");
				ps.setString(1, UUID.randomUUID()+ "" );
				ps.setTimestamp(2, ts);
				ps.setString(3, promoCodeInt);
				ps.setString(4, "Percent Off");
				ps.setFloat(5, Float.parseFloat("0.20"));
				ps.executeUpdate();
				
				connection.close();
				connection2.close();
				
				returnEmail = request.getParameter("email").toLowerCase();
				returnPhone = request.getParameter("phone");
					}
					if(true){
					TwilioRestClient client = new TwilioRestClient(ACCOUNT_SID, AUTH_TOKEN);
					Map<String, String> params = new HashMap<String, String>();								
					params.put("Body", "Customer Registered ");
					params.put("To", "+13109036014");
					params.put("From", "+14242887641");
					SmsFactory messageFactory = client.getAccount().getSmsFactory();
					Sms message = messageFactory.create(params);
					System.out.println(message.getSid());	    										
					System.out.print("Message Send TRUE : ");
					}
					/*
					Properties props = System.getProperties();
					props.put("mail.transport.protocol", "smtp");
					props.put("mail.smtp.port", PORT); 
					props.put("mail.smtp.auth", "true");
					props.put("mail.smtp.starttls.enable", "true");
					props.put("mail.smtp.starttls.required", "true");
					javax.mail.Session sessionMail = javax.mail.Session.getDefaultInstance(props);
					MimeMessage msg = new MimeMessage(sessionMail);
					msg.setFrom(new InternetAddress(FROM));
					msg.setRecipient(Message.RecipientType.TO, new InternetAddress(request.getParameter("email")));
					msg.setSubject("Msg from Yawadi App Email and Promo Code");
					String email_footer = " <BR> This email is sent because it was used to register to Yawadi App.com for more info visit www.Yawadi.com. <BR><B>Please use the following Promo Code " + promoCodeInt + " to save 20% Off</B>";
					msg.setContent("Yawadi.com/verifyPin.jsp?regID=" + registrationID + "&pinCode=" + emailCode + " Email verification Code : " + emailCode + email_footer,"text/html; charset=utf-8");
					Transport transport = sessionMail.getTransport();
				        System.out.println("Attempting to send an email through the Amazon SES SMTP interface..." + request.getParameter("email"));
				        transport.connect(HOST, SMTP_USERNAME, SMTP_PASSWORD);
				        transport.sendMessage(msg, msg.getAllRecipients());
				        System.out.println("Email sent!");
				        transport.close(); 
				        */
				
			}
			}
		}catch(Exception ex){
			%><%="" + ex%><%
			System.out.println(ex + "");
		}
		%><%=emailAddress%><ITEM><%=loginTrue%><ITEM>1<ITEM>1<ITEM><%=client_provider_id%><ITEM><%=client_db_id%><ITEM><%=cc_mask%><ITEM><%=NullCheck.check(client_name)%><ITEM><%=NullCheck.check(returnEmail)%><ITEM><%=NullCheck.check(returnPhone)%><ITEM><%=NullCheck.check(cc_brand)%><ITEM>Done