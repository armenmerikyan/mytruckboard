<%@ page import="com.big.util.*,java.text.*,java.util.*,java.io.*,javax.xml.parsers.*,org.w3c.dom.*,java.sql.*,java.text.DateFormat,java.net.URL" %>			
<%@ page import="javax.mail.*" %>
<%@ page import="javax.mail.internet.*" %>
<%@ page import="java.util.*" %>
<%@ page import="com.twilio.sdk.TwilioRestClient" %>
<%@ page import="com.twilio.sdk.resource.factory.SmsFactory" %>
<%@ page import="com.twilio.sdk.resource.instance.Sms" %>
<%
String uuid = (String)session.getAttribute("uuid");
boolean needStatusUpdate = false;
if(uuid !=null){
		 try{
		 	System.out.println(request.getParameter("pickup_time"));
		 	System.out.println(request.getParameter("drop_time"));
			Class.forName("com.mysql.jdbc.Driver");
			String url = "jdbc:mysql://localhost/test?zeroDateTimeBehavior=convertToNull";		
			Connection connection = DriverManager.getConnection(url,"<USERNAME>", "<PASSWORD>");	
				PreparedStatement ps ;
				float driver_pay = 0.0f;
				float miscel_pay = 0.0f;
				String goingRate = "";
				int rate = 0;
				int miles = 0; 
				float truckmpg = 0.0f;
				float avg_diesel = 0.0f;
				float length = 0.0f;
				float height = 0.0f;
				int weight = 0; 
				float width = 0.0f;
				String latLong = "POINT(1 2)";
				DateFormat formatter = new SimpleDateFormat("MM-dd-yyyy:HH:mm:ss");		
				java.sql.Timestamp drop_date_sql = null;
				java.sql.Timestamp pickup_date_sql = null;
				if(request.getParameter("drop_date")!=null && !request.getParameter("drop_date").equals(""))drop_date_sql = new java.sql.Timestamp((formatter.parse(request.getParameter("drop_date") + ":" + request.getParameter("drop_time") + ":00" )).getTime());
				if(request.getParameter("pickup_date")!=null && !request.getParameter("pickup_date").equals(""))pickup_date_sql = new java.sql.Timestamp((formatter.parse(request.getParameter("pickup_date") +  ":" + request.getParameter("pickup_time") + ":00" )).getTime());

				if(!request.getParameter("rate").equals(""))rate = Integer.parseInt(request.getParameter("rate").trim());
				if(!request.getParameter("miles").equals("") && request.getParameter("miles").contains(".")){
					miles = Integer.parseInt(request.getParameter("miles").substring(0, request.getParameter("miles").indexOf(".")));
				}else if(!request.getParameter("miles").equals("")){
					miles = Integer.parseInt(request.getParameter("miles"));
				}
				if(!request.getParameter("truckmpg").equals(""))truckmpg = Float.parseFloat(request.getParameter("truckmpg").trim());
				if(!request.getParameter("avg_diesel").equals(""))avg_diesel = Float.parseFloat(request.getParameter("avg_diesel").trim());
				if(!request.getParameter("driver_pay").equals(""))driver_pay = Float.parseFloat(request.getParameter("driver_pay").trim());
				if(!request.getParameter("miscel_pay").equals(""))miscel_pay = Float.parseFloat(request.getParameter("miscel_pay").trim());
				
				ps = connection.prepareStatement("select * from test.trucking_quote where quote_id = ? order by ts desc ");
				ps.setString(1, request.getParameter("quote_id"));
				ResultSet resultSet = ps.executeQuery();
				String stringResponseAll =  new String();
				boolean isNewQuote= true;
				while (resultSet.next()) {	
					isNewQuote = false ;
				}
				if(isNewQuote){
					ps = connection.prepareStatement("INSERT INTO test.trucking_quote(quote_id, ts, user_id, company_id, rate, miles, truck_mpg, avg_diesel, driver_pay_mpg, miscel_pay,equipment_id,status, pickCity, pickState, pickCityLocation, destCity, destState, destCityLocation, pickup_date, drop_date, load_type, pickup_address, pickup_notes, drop_address, drop_notes, pickup_contact, drop_contact, pickup_phone, drop_phone ) VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,GeomFromText(?),?,?,GeomFromText(?),?,?,?,?,?,?,?,?,?,?,?)");
					ps.setString(1, request.getParameter("quote_id"));			
					ps.setTimestamp(2, new java.sql.Timestamp((new java.util.Date()).getTime()));			
					ps.setString(3, (String)session.getAttribute("login_id"));	
					ps.setString(4, uuid);
					ps.setInt(5, rate);
					ps.setInt(6, miles);
					ps.setFloat(7, truckmpg);
					ps.setFloat(8, avg_diesel);
					ps.setFloat(9, driver_pay);
					ps.setFloat(10, miscel_pay);
					ps.setString(11, request.getParameter("equipment_id"));
					ps.setString(12, request.getParameter("SaveCalculation"));
					ps.setString(13, request.getParameter("pickCity"));
					ps.setString(14, request.getParameter("pickState"));
					if(request.getParameter("pickCity_lat")!=null && request.getParameter("pickCity_lng")!=null){
						latLong = "POINT(" + request.getParameter("pickCity_lat") + " " + request.getParameter("pickCity_lng") + ")";
					}
					ps.setString(15, latLong);				
					ps.setString(16, request.getParameter("destCity"));
					ps.setString(17, request.getParameter("destState"));
					latLong = "POINT(1 2)";
					if(request.getParameter("destCity_lat")!=null && request.getParameter("destCity_lng")!=null){
						latLong = "POINT(" + request.getParameter("destCity_lat") + " " + request.getParameter("destCity_lng") + ")";
					}
					ps.setString(18, latLong);
					ps.setTimestamp(19, pickup_date_sql);			
					ps.setTimestamp(20, drop_date_sql);			
					ps.setString(21, request.getParameter("trailer"));
					ps.setString(22, request.getParameter("pickup_address"));
					ps.setString(23, request.getParameter("pickup_notes"));
					ps.setString(24, request.getParameter("drop_address"));
					ps.setString(25, request.getParameter("drop_notes"));	
					ps.setString(26, request.getParameter("pickup_contact"));
					ps.setString(27, request.getParameter("drop_contact"));	
					ps.setString(28, request.getParameter("pickup_contact_phone"));
					ps.setString(29, request.getParameter("drop_contact_phone"));	
					ps.executeUpdate();
				
					%>ADD ONLYE<%
				}else{
					ps = connection.prepareStatement("Update test.trucking_quote Set rate = ?, miles = ?, truck_mpg = ?, avg_diesel = ?, driver_pay_mpg = ?, miscel_pay = ?, pickCity = ?, pickState = ?, pickCityLocation = GeomFromText(?), destCity = ?, destState = ?, destCityLocation = GeomFromText(?), pickup_date = ?, drop_date = ?, load_type = ?, pickup_address = ?, pickup_notes = ?, drop_address = ?, drop_notes = ?, pickup_contact = ?, drop_contact = ? , pickup_phone = ?, drop_phone = ?      where quote_id = ?");
					ps.setInt(1, rate);	
					ps.setInt(2, miles);
					ps.setFloat(3, truckmpg);
					ps.setFloat(4, avg_diesel);
					ps.setFloat(5, driver_pay);
					ps.setFloat(6, miscel_pay);
					ps.setString(7, request.getParameter("pickCity"));
					ps.setString(8, request.getParameter("pickState"));
					if(request.getParameter("pickCity_lat")!=null && request.getParameter("pickCity_lng")!=null){
						latLong = "POINT(" + request.getParameter("pickCity_lat") + " " + request.getParameter("pickCity_lng") + ")";
					}
					ps.setString(9, latLong);				
					ps.setString(10, request.getParameter("destCity"));
					ps.setString(11, request.getParameter("destState"));
					latLong = "POINT(1 2)";
					if(request.getParameter("destCity_lat")!=null && request.getParameter("destCity_lng")!=null){
						latLong = "POINT(" + request.getParameter("destCity_lat") + " " + request.getParameter("destCity_lng") + ")";
					}
					ps.setString(12, latLong);
					ps.setTimestamp(13, pickup_date_sql);			
					ps.setTimestamp(14, drop_date_sql);			
					ps.setString(15, request.getParameter("trailer"));	
					ps.setString(16, request.getParameter("pickup_address"));	
					ps.setString(17, request.getParameter("pickup_notes"));	
					ps.setString(18, request.getParameter("drop_address"));	
					ps.setString(19, request.getParameter("drop_notes"));
					ps.setString(20, request.getParameter("pickup_contact"));	
					ps.setString(21, request.getParameter("drop_contact"));			
					ps.setString(22, request.getParameter("pickup_contact_phone"));		
					ps.setString(23, request.getParameter("drop_contact_phone"));		
					ps.setString(24, request.getParameter("quote_id"));
					ps.executeUpdate();				
					%>Update ONLYE<%
				}	
				connection.close();	
			
		 }catch (Exception ex){	         
		     %><%="Error Posting " + ex%><%  
		     System.out.println(""+ ex + "Rate : " + request.getParameter("per_mile"));
		 }				
				%>	DONE
<%}else{%>
	        	<a href="../index4.html">Please Login</a>
<%}%>