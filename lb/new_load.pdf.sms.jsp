<%@ page import="com.twilio.sdk.resource.instance.Sms,com.twilio.sdk.resource.factory.SmsFactory,com.twilio.sdk.TwilioRestClient,twitter4j.JSONTokener,twitter4j.JSONObject,twitter4j.JSONArray,java.util.Iterator,java.net.URL,java.net.URLConnection,java.net.HttpURLConnection,java.io.InputStream,java.io.OutputStream,com.itextpdf.text.Font,com.itextpdf.text.Rectangle,com.itextpdf.text.pdf.PdfContentByte,com.itextpdf.text.pdf.PdfPCell,com.itextpdf.text.pdf.PdfPCellEvent,com.itextpdf.text.pdf.PdfPTable,com.itextpdf.text.pdf.PdfPTableEvent,com.itextpdf.text.pdf.PdfWriter,com.itextpdf.text.pdf.BaseFont,com.itextpdf.text.Phrase,com.itextpdf.text.Element,com.itextpdf.text.pdf.ColumnText,com.itextpdf.text.pdf.PdfContentByte,com.itextpdf.text.pdf.PdfWriter,com.itextpdf.text.PageSize,com.itextpdf.text.Paragraph,com.itextpdf.text.DocumentException,com.itextpdf.text.Document,java.security.SecureRandom,com.big.util.*,java.text.*,java.util.*,java.io.*,javax.xml.parsers.*,org.w3c.dom.*,java.sql.*,java.text.DateFormat,javax.mail.*" %><%
     final String ACCOUNT_SID = "ACbc6b5f29c1627c6aa7e51f5ad340fa2d";
     final String AUTH_TOKEN = "767154b209800bd1be13e38d8a01fc1b";
			
    String FROM = "info@ipubsub.com";   // Replace with your "From" address. This address must be verified.
    String SMTP_USERNAME = "AKIAINFCRKGVZNSB7DHQ";  // Replace with your SMTP username.
    String SMTP_PASSWORD = "Ar/mcRQJkM9i7Vl45r+CzSrgx/QGb+vuJIuIDfJp/mj8";  // Replace with your SMTP password.
    String HOST = "email-smtp.us-east-1.amazonaws.com";    
    int PORT = 25;
			String uuid = (String)session.getAttribute("uuid");

			if(uuid !=null){
		String bill_to_old = "";
		String bill_to_old_id = "";
		String bill_to_old_address = "";
		String ln_number = "";
		String ln_status = "";
		String wo_number = "";
		String type = "";
		String rate = "";
		String units = "";
		String pds = "";
		String fsc_rate = "";
		String other_charges = "";
		String rate_all = "";
		String carrier_id = "";
		String carrier_name = "";
		String carrier_address = "";
		String carrier_type = "";
		String carrier_fee = "";
		String carrier_rate = "";
		String carrier_advances = "";
		String carrier_currency = "";
		String disList = "";
		String slList = "";
		String bill_to_advances = "";
		String company_info = "";
		String company_name = "";
		String currency = "";
		String carrier_phone = "";
		String carrier_fax = "";
		String carrier_company_name = "";
		String carrier_terms = "";
		String today_date = new SimpleDateFormat("MM-dd-yyyy").format(new java.sql.Timestamp((new java.util.Date()).getTime()));;
		Vector shipperList = new Vector();
		Vector consigneeList = new Vector();
		int currentPageCount = 1;
		int totalPageCount = 2;
		int totalParties = 0;
		String first_ship_date = "";
		HashMap user_map = new HashMap();
		String dispatcher_name = "";
		String dispatcher_phone = "";
		String dispatcher_fax = "";
		String dispatcher_email = "";
		String load_id_pub = "";
		
		if(request.getParameter("load_id")!=null){
	        	try{
			Class.forName("com.mysql.jdbc.Driver");
			String url = "jdbc:mysql://localhost/test?zeroDateTimeBehavior=convertToNull";
			Connection connection = DriverManager.getConnection(url,"<USERNAME>", "<PASSWORD>");
			PreparedStatement psMain = null;	
			psMain = connection.prepareStatement("select * from test.TRUCKING_USERS WHERE COMPANY_ID = ?");
			psMain.setString(1, uuid);
			ResultSet resultSet = psMain.executeQuery();
			while (resultSet.next()) {
				String[] userItem = new String[4];
				userItem[0] = resultSet.getString("email");
				userItem[1] = resultSet.getString("f_name");
				userItem[2] = resultSet.getString("l_name");
				userItem[3] = resultSet.getString("phone");
				user_map.put(resultSet.getString("email") , userItem);
			}	
			psMain = connection.prepareStatement("select * from test.load_board left join test.trucking_equipment on load_board.load_equipment_id=trucking_equipment.id left join test.locations on load_board.bill_to_id = locations.location_id WHERE load_board.COMPANY_ID = ? and load_board.load_board_id = ? order by load_board.ts asc");			
			psMain.setString(1, uuid);
			psMain.setString(2, request.getParameter("load_id"));
			resultSet = psMain.executeQuery();
			while (resultSet.next()) {
				wo_number = resultSet.getString("load_wo");
				ln_status = resultSet.getString("load_status");
				ln_number = resultSet.getString("load_number_float");
				type = resultSet.getString("load_type");
				bill_to_old = NullCheck.check(resultSet.getString("locations.org_name"));
				bill_to_old_id = NullCheck.check(resultSet.getString("bill_to_id"));
				bill_to_old_address = NullCheck.check(resultSet.getString("locations.address"));
				
				carrier_advances = resultSet.getString("advances_total");
				carrier_fee = resultSet.getString("load_carrier_fee");
				carrier_rate = resultSet.getString("carrier_rate");
				other_charges = resultSet.getString("load_other");
				rate = resultSet.getString("load_rate");
				units = resultSet.getString("load_units");
				fsc_rate = resultSet.getString("load_fsc");
				rate_all = resultSet.getString("load_rate_all");
				carrier_name = NullCheck.check(resultSet.getString("trucking_equipment.name"));
				carrier_id = NullCheck.check(resultSet.getString("trucking_equipment.id"));
				carrier_address = NullCheck.check(resultSet.getString("trucking_equipment.city"));
				disList = resultSet.getString("disDetail");
				carrier_type = NullCheck.check(resultSet.getString("carrier_type"));
				slList = resultSet.getString("salDetail");
				bill_to_advances = resultSet.getString("bill_to_advances");
				pds = resultSet.getString("load_pd");
				carrier_phone =  NullCheck.check(resultSet.getString("trucking_equipment.phone"));
				carrier_fax =  NullCheck.check(resultSet.getString("trucking_equipment.fax"));
				carrier_company_name =  NullCheck.check(resultSet.getString("trucking_equipment.company_name"));
				load_id_pub = NullCheck.check(resultSet.getString("load_board_id_pub"));
				
				if(resultSet.getString("disdetail")!=null && !resultSet.getString("disdetail").equals("")){
					for(int jk =0;jk<resultSet.getString("disdetail").split(":").length;jk++){
						if(user_map.containsKey((resultSet.getString("disdetail").split(":")[jk]))){
							dispatcher_name = NullCheck.check(((String[])user_map.get((resultSet.getString("disdetail").split(":")[jk])))[1]);
							dispatcher_name = dispatcher_name + " " + NullCheck.check(((String[])user_map.get((resultSet.getString("disdetail").split(":")[jk])))[2]);
							dispatcher_phone = NullCheck.check(((String[])user_map.get((resultSet.getString("disdetail").split(":")[jk])))[3]);
							dispatcher_email = NullCheck.check(((String[])user_map.get((resultSet.getString("disdetail").split(":")[jk])))[0]);
						}	
					}	
				}			
			}
				
				psMain = connection.prepareStatement("select * from test.trucking_company where COMPANY_ID = ? ");
				psMain.setString(1, uuid);
				resultSet = psMain.executeQuery();
				while (resultSet.next()) {
					company_name = NullCheck.check(resultSet.getString("NAME"));
					company_info = company_info + NullCheck.check(resultSet.getString("address")) + "\n";
					company_info = company_info + NullCheck.check(resultSet.getString("email")) + "\n" + NullCheck.check(resultSet.getString("phone"));
				}
				
				psMain = connection.prepareStatement("select * from test.locations right join test.load_board_line on locations.location_id=load_board_line.shipper_id left join test.locations as customs on load_board_line.customs_id=customs.location_id WHERE load_board_line.COMPANY_ID = ? and load_id = ? order by load_board_line.ts asc");
				psMain.setString(1, uuid);
				psMain.setString(2, request.getParameter("load_id"));
				resultSet = psMain.executeQuery();
				int shipCount = 0;
				while (resultSet.next()) {
					String[] tmpRow = new String[13];
					tmpRow[0] = resultSet.getString("load_line_id");
					if(resultSet.getTimestamp("pickup_date")!=null){
						tmpRow[1] = new SimpleDateFormat("MM-dd-yyyy").format(resultSet.getTimestamp("pickup_date"));
						tmpRow[2] = new SimpleDateFormat("HH:mm").format(resultSet.getTimestamp("pickup_date"));
						if(first_ship_date.equals(""))first_ship_date = new SimpleDateFormat("MM-dd-yyyy").format(resultSet.getTimestamp("pickup_date"));
					}
					 
					tmpRow[3] = resultSet.getString("type");
					tmpRow[4] = resultSet.getString("units");
					tmpRow[5] = resultSet.getString("weight");
					tmpRow[6] = "";
					tmpRow[7] = resultSet.getString("po_numbers");
					tmpRow[8] = resultSet.getString("description");
					tmpRow[9] = resultSet.getString("locations.org_name");
					tmpRow[11] = resultSet.getString("address2");
					tmpRow[12] = resultSet.getString("address");
					tmpRow[10] = resultSet.getString("load_board_line.notes");

					shipperList.add(tmpRow);
					totalParties +=1;
				}
				psMain = connection.prepareStatement("select * from test.locations right join test.load_board_line_consignee on locations.location_id=load_board_line_consignee.consignee_id WHERE load_board_line_consignee.COMPANY_ID = ? and load_id = ? order by load_board_line_consignee.ts asc");
				psMain.setString(1, uuid);
				psMain.setString(2, request.getParameter("load_id"));
				resultSet = psMain.executeQuery();
				while (resultSet.next()) {
					String[] tmpRow = new String[13];
					tmpRow[0] = resultSet.getString("load_line_id");
					if(resultSet.getTimestamp("pickup_date")!=null){
						tmpRow[1] = new SimpleDateFormat("MM-dd-yyyy").format(resultSet.getTimestamp("pickup_date"));
						tmpRow[2] = new SimpleDateFormat("HH:mm").format(resultSet.getTimestamp("pickup_date"));
					}
					tmpRow[3] = resultSet.getString("type");
					tmpRow[4] = resultSet.getString("units");
					tmpRow[5] = resultSet.getString("weight");
					tmpRow[6] = "";
					tmpRow[7] = resultSet.getString("po_numbers");
					tmpRow[8] = resultSet.getString("description");
					tmpRow[9] = resultSet.getString("locations.org_name");
					tmpRow[11] = resultSet.getString("address2");
					tmpRow[12] = resultSet.getString("address");
					tmpRow[10] = resultSet.getString("load_board_line_consignee.notes");

					consigneeList.add(tmpRow);	
					totalParties +=1;
				}	
				psMain = connection.prepareStatement("select * from test.trucking_company_dispatch_terms where COMPANY_ID = ? limit 1 ");
				psMain.setString(1, uuid);
				resultSet = psMain.executeQuery();
				while (resultSet.next()) {
					carrier_terms = resultSet.getString("term");
				}			
				
			connection.close();
			 }catch (Exception ex){
			     %><%="Error Posting " + ex%><%
			     System.out.println(""+ ex);
			 }	         
			}
	         

        	try{
        	//carrier_phone
        	String shortURL = ""; 
   	String newURLGoogle = "https://www.googleapis.com/urlshortener/v1/url?longUrl=http://www.myTruckBoard.com&key=AIzaSyBdjyI5UVVbiQumyT9wSLM9YbDt2AvGQZs";
   	String jsonStringGoogle = "{\"longUrl\":\"https://www.myTruckBoard.com?trucking-new/new_load.pdf.jsp?load_id="+ request.getParameter("load_id") +"\"}";
		  String charset = "UTF-8"; 
		  java.net.URLConnection connectionHttp = new java.net.URL(newURLGoogle).openConnection();
		  connectionHttp.setDoOutput(true); // Triggers POST.
		  connectionHttp.setRequestProperty("Accept-Charset", charset);
		  connectionHttp.setRequestProperty("Content-Type", "application/json;charset=" + charset);

		  OutputStream output = connectionHttp.getOutputStream();
		  output.write(jsonStringGoogle.getBytes(charset));

		  InputStream responseGoogle = connectionHttp.getInputStream();
		  JSONTokener tokenizer = new JSONTokener(responseGoogle);
	      JSONObject jsonObject = new JSONObject(tokenizer);
	      System.out.println(jsonObject.toString());
	      Iterator keys = jsonObject.keys();
	      while(keys.hasNext() ) {
	          String key = (String)keys.next();
		      System.out.println( key);
		      if(key.equals("id")){
			  System.out.println(jsonObject.get(key).toString());
			  shortURL = jsonObject.get(key).toString();
		      }
	          if ( jsonObject.get(key) instanceof JSONObject ) {
	        	  System.out.println(jsonObject.get(key).toString());
	              JSONObject xx = new JSONObject(jsonObject.get(key).toString());
	              JSONArray yy = xx.getJSONArray("id");
	              System.out.println( xx.getString("id"));
	              for(int i = 0; i < yy.length(); i++)
	              {
	                    JSONObject objects = yy.getJSONObject(i);
	              }
	          }
	      }	   
	      
				
						System.out.println(request.getParameter("equipmentID"));
						TwilioRestClient client = new TwilioRestClient(ACCOUNT_SID, AUTH_TOKEN);
						Map<String, String> params = new HashMap<String, String>();								
						params.put("Body", "myTruckBoard.com message from " + "www.myTruckBoard.com/po.jsp?load_id="+ load_id_pub);
						params.put("To", "+1" + carrier_phone);
						params.put("From", "+14242887641");
						SmsFactory messageFactory = client.getAccount().getSmsFactory();
						Sms message = messageFactory.create(params);
						System.out.println(message.getSid());	    										
						System.out.print("Message Send TRUE : ");  										
	      %>Message Sent<%
	    }catch (Exception de) {
		 System.out.println(""+ de.getMessage());
	    	%>Error Sending Message<%
	    }        
        } 
        %>