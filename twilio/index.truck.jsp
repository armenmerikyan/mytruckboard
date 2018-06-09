<%@ page import="java.net.URL,java.net.URLDecoder,javax.net.ssl.HttpsURLConnection,java.security.cert.Certificate,java.net.MalformedURLException,java.net.URLEncoder,org.apache.commons.codec.binary.Base64,java.net.HttpURLConnection,com.big.braintree.GetPaymentToken,com.big.opennlp.FindNLP,java.util.concurrent.ThreadLocalRandom,com.big.util.*,java.text.*,java.util.*,java.io.*,javax.xml.parsers.*,org.w3c.dom.*,java.sql.*,java.text.DateFormat" %>
<%@ page import="com.twilio.sdk.TwilioRestClient" %>
<%@ page import="com.twilio.sdk.resource.factory.SmsFactory" %>
<%@ page import="com.twilio.sdk.resource.instance.Sms" %>
<%@ page import="com.twilio.sdk.resource.instance.Message" %>
<%@ page import="com.twilio.sdk.resource.instance.Media" %>
<%@ page import="com.twilio.sdk.resource.list.MediaList" %>
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
				psMain = connection.prepareStatement("INSERT INTO test.sms_callback_truck(call_back_id, ts, fromMessage, textMessage, location, toMessage, sms_sid) VALUES (?,?,?,?,?,?,?)");
				psMain.setString(1, orderID);
				psMain.setTimestamp(2, new java.sql.Timestamp((new java.util.Date()).getTime()));	
				psMain.setString(3, request.getParameter("From"));
				psMain.setString(4, request.getParameter("Body"));
				psMain.setString(5, request.getParameter("FromCity"));		
				psMain.setString(6, request.getParameter("To"));	
				psMain.setString(7, request.getParameter("MessageSid"));					
				if(!request.getParameter("Body").equals("")){psMain.executeUpdate();}	
				
				
					if(true){
						TwilioRestClient client = new TwilioRestClient(ACCOUNT_SID, AUTH_TOKEN);
						MediaList medias = client.getAccount().getMessage(request.getParameter("MessageSid")).getMedia();
						for (Media media : medias) {
							java.net.URL url2 = new java.net.URL("https://api.twilio.com" + URLDecoder.decode(media.getUri().split("\\.")[0]));      
						
	    	java.net.HttpURLConnection conn = (java.net.HttpURLConnection) url2.openConnection();
	    	conn.setReadTimeout(5000);
	    	conn.addRequestProperty("Accept-Language", "en-US,en;q=0.8");
	    	conn.addRequestProperty("User-Agent", "Mozilla");
	    	conn.addRequestProperty("Referer", "google.com");

	    	System.out.println("Request URL ... " + url);

	    	boolean redirect = false;

	    	// normally, 3xx is redirect
	    	int status = conn.getResponseCode();
	    	if (status != HttpURLConnection.HTTP_OK) {
	    		if (status == HttpURLConnection.HTTP_MOVED_TEMP
	    			|| status == HttpURLConnection.HTTP_MOVED_PERM
	    				|| status == HttpURLConnection.HTTP_SEE_OTHER)
	    		redirect = true;
	    	}

	    	System.out.println("Response Code ... " + status);

	    	if (redirect) {

	    		// get redirect url from "location" header field
	    		String newUrl = conn.getHeaderField("Location");

	    		// get the cookie if need, for login
	    		String cookies = conn.getHeaderField("Set-Cookie");

	    		// open the new connnection again
	    		conn = (HttpURLConnection) new URL(newUrl).openConnection();
	    		conn.setRequestProperty("Cookie", cookies);
	    		conn.addRequestProperty("Accept-Language", "en-US,en;q=0.8");
	    		conn.addRequestProperty("User-Agent", "Mozilla");
	    		conn.addRequestProperty("Referer", "google.com");
	    								
	    		System.out.println("Redirect to URL : " + newUrl);

	    	}
           InputStream inputStream = conn.getInputStream();
            //String saveFilePath = saveDir + File.separator + fileName;
             
            // opens an output stream to save into file
            String fileId = UUID.randomUUID() +"";
            FileOutputStream outputStream = new FileOutputStream("H:\\maidsSecure\\mmsUpload\\" + fileId + ".jpg");
 
            int bytesRead = -1;
            byte[] buffer = new byte[1024];
            while ((bytesRead = inputStream.read(buffer)) != -1) {
                outputStream.write(buffer, 0, bytesRead);
            }
 
            outputStream.close();
            inputStream.close();		

				String orderIDTmp = UUID.randomUUID() + "";
				psMain = connection.prepareStatement("INSERT INTO test.sms_callback_truck(call_back_id, ts, fromMessage, textMessage, location, toMessage, sms_sid, sms_type, call_back_id_pub) VALUES (?,?,?,?,?,?,?,?,?)");
				psMain.setString(1, orderIDTmp);
				psMain.setTimestamp(2, new java.sql.Timestamp((new java.util.Date()).getTime()));	
				psMain.setString(3, request.getParameter("From"));
				psMain.setString(4, fileId);
				psMain.setString(5, request.getParameter("FromCity"));		
				psMain.setString(6, request.getParameter("To"));	
				psMain.setString(7, request.getParameter("MessageSid"));
				psMain.setString(8, media.getContentType());
				psMain.setString(9, UUID.randomUUID() + "");							
				psMain.executeUpdate();	

	    		}			
	    					
						Map<String, String> params = new HashMap<String, String>();								
						params.put("Body", "We Got It ");
						params.put("To", request.getParameter("From"));
						params.put("From", request.getParameter("To"));
						SmsFactory messageFactory = client.getAccount().getSmsFactory();
						Sms message = messageFactory.create(params);
						System.out.println(message.getSid());	    										
						System.out.print("Message Send TRUE : ");
						
					}	
					
			

		}catch(Exception ex){
			System.out.println("Exception CODE STARTED:" + ex + " ERROR");
			System.out.println("Exception CODE STARTED:" + (ex+"").split(" ")[9]);
				
		}					
%>