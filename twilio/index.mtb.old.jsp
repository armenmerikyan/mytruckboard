<%@ page import="com.big.braintree.GetPaymentToken,com.big.opennlp.FindNLP,java.util.concurrent.ThreadLocalRandom,com.big.util.*,java.text.*,java.util.*,java.io.*,javax.xml.parsers.*,org.w3c.dom.*,java.sql.*,java.text.DateFormat" %>
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

	System.out.println("Twilio CALL BACK URL ");
	System.out.println(request.getParameter("From"));
	System.out.println(request.getParameter("To"));
	System.out.println(request.getParameter("Body"));
	System.out.println(request.getParameter("FromCity"));
	
	String phoneFrom = request.getParameter("From").substring(2,request.getParameter("From").length());
	System.out.println(phoneFrom);
	
%><%
		try{

				Class.forName("com.mysql.jdbc.Driver");
				String url = "jdbc:mysql://localhost/test?user=<PASSWORD>&password=<PASSWORD>";
				Connection connection = DriverManager.getConnection(url,"<USERNAME>", "<PASSWORD>");
				boolean isFound = false;
				PreparedStatement psMain = null;

				java.sql.Timestamp ts = new java.sql.Timestamp((new java.util.Date()).getTime());
				String orderID = UUID.randomUUID() + "";
				psMain = connection.prepareStatement("INSERT INTO test.sms_callback(call_back_id, ts, fromMessage, textMessage, location) VALUES (?,?,?,?,?)");								
				psMain.setString(1, orderID);
				psMain.setTimestamp(2, new java.sql.Timestamp((new java.util.Date()).getTime()));	
				psMain.setString(3, request.getParameter("From"));
				psMain.setString(4, request.getParameter("Body"));
				psMain.setString(5, request.getParameter("FromCity"));						
				psMain.executeUpdate();	
				
				String fromLocation = "";
				String fromDate = "";
				String toLocation = "";
				String toDate = "";
				
				String uuidBrand = (String)session.getAttribute("uuidBrand");
				String[] dates = FindNLP.getDate(request.getParameter("Body"));
				for(int j=0;j<dates.length;j++){
				 	if(j==0){fromDate=dates[j];}
				 	if(j==1){toDate=dates[j];}
				}
				String[] locations = FindNLP.getLocation(request.getParameter("Body"));
				for(int j=0;j<locations.length;j++){
				 	if(j==0){fromLocation=locations[j];}
				 	if(j==1){toLocation=locations[j];}
				}				
				DateFormat formatter = new SimpleDateFormat("MM/dd/yyyy.HH.mm.ss");
				 String pickCity_lat = "0.0";
				 String pickCity_lng = "0.0";
				java.sql.Date start = new java.sql.Date((new java.util.Date()).getTime());
				java.sql.Date end = new java.sql.Date((new java.util.Date()).getTime());
				try{
					start = new java.sql.Date(((java.util.Date)formatter.parse(fromDate + ".00.00.01" )).getTime());
					end = new java.sql.Date(((java.util.Date)formatter.parse(toDate + ".00.00.01" )).getTime());
				}catch(Exception ex){
					System.out.println(ex + "");
				}
				
					// 
					
					boolean isBooked = false;
					if(request.getParameter("Body").contains("Booked")){
						isBooked = true;
					}
					if(!isBooked){
				psMain = connection.prepareStatement("select * from loads_nlp WHERE phone = ? and ts >= SYSDATE() - INTERVAL 5 Minute");
				psMain.setString(1, request.getParameter("From"));			
				ResultSet resultSetOldPost = psMain.executeQuery();	
				boolean isNewPost = false;
				while (resultSetOldPost.next()) {
					isNewPost = true;
					psMain = connection.prepareStatement("Update loads_nlp SET message = ? WHERE load_nlp_id =?");
					psMain.setString(1, resultSetOldPost.getString("message") + " Updated " + request.getParameter("Body"));			
					psMain.setString(2, resultSetOldPost.getString("load_nlp_id"));				
					psMain.executeUpdate();	
				}
				if(!isNewPost){
					psMain = connection.prepareStatement("INSERT INTO test.loads_nlp(load_nlp_id, ts, source_ip, source_client_id, user_agent, referer, message, phone, messageSourceLocation, fromLocation, fromDate, toLocation, toDate, fromDateDate, toDateDate) VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");								
					psMain.setString(1, UUID.randomUUID() + "");
					psMain.setTimestamp(2, new java.sql.Timestamp((new java.util.Date()).getTime()));	
					psMain.setString(3, request.getParameter("From"));
					psMain.setString(4, request.getParameter("From"));
					psMain.setString(5, "SMS Mobile Twilio");
					psMain.setString(6, request.getHeader("referer"));
					psMain.setString(7, request.getParameter("Body"));	
					psMain.setString(8, request.getParameter("From"));
					psMain.setString(9, request.getParameter("FromCity"));	
					psMain.setString(10, fromLocation);	
					psMain.setString(11, fromDate);	
					psMain.setString(12, toLocation);	
					psMain.setString(13, toDate);						
					psMain.setTimestamp(14, new java.sql.Timestamp(start.getTime()));							
					psMain.setTimestamp(15, new java.sql.Timestamp(end.getTime()));					
					psMain.executeUpdate();	
					

					if(true){
						TwilioRestClient client = new TwilioRestClient(ACCOUNT_SID, AUTH_TOKEN);
						Map<String, String> params = new HashMap<String, String>();								
						params.put("Body", "Text Booked to remove your listing");
						params.put("To", request.getParameter("From"));
						params.put("From", request.getParameter("To"));
						SmsFactory messageFactory = client.getAccount().getSmsFactory();
						Sms message = messageFactory.create(params);
						System.out.println(message.getSid());	    										
						System.out.print("Message Send TRUE : ");
					}					
				}
					}
					
				if(!isBooked){	
					if(!fromLocation.equals("") || !toLocation.equals("")){
						if(true){
							TwilioRestClient client = new TwilioRestClient(ACCOUNT_SID, AUTH_TOKEN);
							Map<String, String> params = new HashMap<String, String>();								
							params.put("Body", "We Got It " + fromLocation + " " +fromDate + " " + toLocation + " " + toDate);
							params.put("To", request.getParameter("From"));
							params.put("From", request.getParameter("To"));
							SmsFactory messageFactory = client.getAccount().getSmsFactory();
							Sms message = messageFactory.create(params);
							System.out.println(message.getSid());	    										
							System.out.print("Message Send TRUE : ");
						}					
					}else{
						if(true){
							TwilioRestClient client = new TwilioRestClient(ACCOUNT_SID, AUTH_TOKEN);
							Map<String, String> params = new HashMap<String, String>();								
							params.put("Body", "Can you provide location information like pickup and drop off Cities.");
							params.put("To", request.getParameter("From"));
							params.put("From", request.getParameter("To"));
							SmsFactory messageFactory = client.getAccount().getSmsFactory();
							Sms message = messageFactory.create(params);
							System.out.println(message.getSid());	    										
							System.out.print("Message Send TRUE : ");
						}				
					}
				}else{
							psMain = connection.prepareStatement("delete from loads_nlp WHERE phone = ?");
							psMain.setString(1, request.getParameter("From"));				
							psMain.executeUpdate();	
							
						if(true){
							TwilioRestClient client = new TwilioRestClient(ACCOUNT_SID, AUTH_TOKEN);
							Map<String, String> params = new HashMap<String, String>();								
							params.put("Body", "Booked! Listing removed");
							params.put("To", request.getParameter("From"));
							params.put("From", request.getParameter("To"));
							SmsFactory messageFactory = client.getAccount().getSmsFactory();
							Sms message = messageFactory.create(params);
							System.out.println(message.getSid());	    										
							System.out.print("Message Send TRUE : ");
						}
				
				}	
				
				
				
				
				
				
			
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
		String client_id = "";
		String  btCustomerID = "";
		String  btPaymentToken = "";
		Random randomGenerator = new Random();
		

			String urldb = "jdbc:mysql://localhost/maids_oltp?user=<USER>&password=<PASSWORD>";		
			Connection connection2 = DriverManager.getConnection(urldb);
			System.out.println("Connection ID " + request.getParameter("From").substring(2,request.getParameter("From").length()));
		
			PreparedStatement ps = connection2.prepareStatement("select * from maids_customers WHERE phone =? and smsaccountsid = ?");
			ps.setString(1, request.getParameter("From").substring(2,request.getParameter("From").length()));			
			ps.setString(2, request.getParameter("AccountSid"));			
			ResultSet resultSet = ps.executeQuery();
			System.out.println("##" + request.getParameter("From") + "##" + request.getParameter("cardno")+ "##" + request.getParameter("expmm")+request.getParameter("expyy")+request.getParameter("cvv"));
			
			while (resultSet.next()) {
				loginTrue = true;
				isEmailVerified = resultSet.getBoolean("isemailverified");
				isPhoneVerified = resultSet.getBoolean("isphoneverified");
				client_provider_id =   resultSet.getString("maid_user_id");
				returnEmail = resultSet.getString("email");
				returnPhone = resultSet.getString("phone");
				btCustomerID = resultSet.getString("btCustomerID");
				btPaymentToken = resultSet.getString("btPaymentId");
				client_id= resultSet.getString("client_id");
				if(resultSet.getString("ccName")!=null && !resultSet.getString("ccName").equals("(null)"))client_name = resultSet.getString("ccName");
				client_db_id = UUID.randomUUID() + "";				
				cc_mask = resultSet.getString("cc_mask_no");		
				cc_brand = resultSet.getString("ccBrand");
			}
			
			
					/*
					if(!loginTrue || cc_mask==null || cc_mask.equals("")){
						TwilioRestClient client = new TwilioRestClient(ACCOUNT_SID, AUTH_TOKEN);
						Map<String, String> params = new HashMap<String, String>();								
						params.put("Body", "For Premium Listing https://www.mytruckboard.com/m/payment.jsp?p=" + request.getParameter("From") + "&a=" + request.getParameter("AccountSid"));
						params.put("To", request.getParameter("From"));
						params.put("From", request.getParameter("To"));
						SmsFactory messageFactory = client.getAccount().getSmsFactory();
						Sms message = messageFactory.create(params);
						System.out.println(message.getSid());	    										
						System.out.print("Message Send TRUE : ");
					}else{
						boolean statusPayment = GetPaymentToken.processPaymenForExistingCustomerSMS(btCustomerID,btPaymentToken,".95");
						%><%=statusPayment%><%
						TwilioRestClient client = new TwilioRestClient(ACCOUNT_SID, AUTH_TOKEN);
						Map<String, String> params = new HashMap<String, String>();								
						params.put("Body", "Charged $0.95 on " + cc_mask);
						params.put("To", request.getParameter("From"));
						params.put("From", request.getParameter("To"));
						SmsFactory messageFactory = client.getAccount().getSmsFactory();
						Sms message = messageFactory.create(params);
						System.out.println(message.getSid());	    										
						System.out.print("Message Send TRUE : ");
					
					}
					*/

		}catch(Exception ex){
			%><%="" + ex%><%
			System.out.println(ex + "");
		}					
%>