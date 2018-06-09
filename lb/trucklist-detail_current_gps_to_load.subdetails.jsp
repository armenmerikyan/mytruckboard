<%@ page buffer="512kb" contentType="text/html" import="com.big.util.*,java.text.*,java.util.*,java.io.*,javax.xml.parsers.*,org.w3c.dom.*,java.sql.*,java.text.DateFormat,java.net.URL" %><%
	try{
		Class.forName("com.mysql.jdbc.Driver");
		String url = "jdbc:mysql://localhost/test?zeroDateTimeBehavior=convertToNull";		
		Connection connection = DriverManager.getConnection(url,"<USERNAME>", "<PASSWORD>");	
		DecimalFormat format=new DecimalFormat("#.##");
		HashMap countMap = new HashMap();
    Enumeration requestParameters = request.getParameterNames();

	        System.out.println("DATA" + request.getParameter("resultRows"));
    while (requestParameters.hasMoreElements()) {
        String element = (String) requestParameters.nextElement();
        String value = request.getParameter(element);
        System.out.println("element " + element + " value " + value);
	        System.out.println(" SQL INJECTION ERROR :::: element " + element + " value " + value);   
	        
		//		response.sendRedirect("https://mytruckboard.com/mytruckboard/errorRequest.html");
        
    }	 		
	        System.out.println("DATA" + request.getParameter("resultRows"));
		for(int j=0;j<Integer.valueOf(request.getParameter("resultRows"));j++){
		Calendar cal = Calendar.getInstance();
		java.util.Date eDate = cal.getTime();
		java.util.Date cDate = cal.getTime();
			String pickCity_lng = request.getParameter("lllng" +j);
			String pickCity_lat = request.getParameter("lllat" +j);
		if(true){			
			PreparedStatement psQ = connection.prepareStatement("select shp.org_name, pickup_date, shp.address, (GLength(LineStringFromWKB(LineString(shp.addresslocation, GeomFromText('POINT(" + pickCity_lat + " " + pickCity_lng + ")'))))) AS distanceFromPickCity  from test.load_board left join test.load_board_line on load_board.load_board_id=load_board_line.load_id left join test.locations as shp on load_board_line.shipper_id=shp.location_id left join test.trucking_equipment on load_board.load_equipment_id=trucking_equipment.id WHERE trucking_equipment.ID = ? and (load_board_line.pickup_date > NOW() ) ORDER BY load_board_line.pickup_date asc LIMIT 1");							
			psQ.setString(1, request.getParameter("eid" +j));
			ResultSet resultSetQ = psQ.executeQuery();
			while (resultSetQ.next()) {
				String miles = "";
				String time = "";
				if(resultSetQ.getString("distanceFromPickCity")!=null && Float.parseFloat(resultSetQ.getString("distanceFromPickCity"))* 62.1371>.1){
					miles = format.format(Float.parseFloat(resultSetQ.getString("distanceFromPickCity")) * 62.1371) + " miles";
				}else{
					miles = "-";
				}	
				

    			    String timeDurration = "" ;
    			    	if(true && resultSetQ.getTimestamp("pickup_date")!=null){
    			    long currentTime = Calendar.getInstance().getTime().getTime();
    			    long postTime = resultSetQ.getTimestamp("pickup_date").getTime();
    			    long diff = postTime - currentTime  ;
    			    long diffSeconds = diff / 1000 % 60;
    			    long diffMinutes = diff / (60 * 1000) % 60;
    			    long diffHours = diff / (60 * 60 * 1000) % 24;
    			    long diffDays = diff / (60 * 60 * 1000 * 24);
    			    if (diffSeconds == 1)timeDurration = "1 Second " + timeDurration;
    			    else if (diffSeconds > 1) timeDurration = diffSeconds + " Seconds " + timeDurration;
     			    timeDurration = "" ;
   			    if (diffMinutes == 1)timeDurration = "1 Minute " + timeDurration;
    			    else if (diffMinutes > 1) timeDurration = diffMinutes + " Minutes " + timeDurration;
    			    if (diffHours == 1)timeDurration = "1 Hour " + timeDurration;
    			    else if (diffHours > 1) timeDurration = diffHours + " Hours " + timeDurration;
    			    if (diffDays == 1)timeDurration = "1 Day " + timeDurration;
    			    else if (diffDays > 1) timeDurration = diffDays + " Days " + timeDurration;  
    			    	}					
				time =new SimpleDateFormat("MM-dd h:mm a").format(resultSetQ.getTimestamp("pickup_date").getTime());
				countMap.put(request.getParameter("eid" +j),resultSetQ.getString("shp.org_name") + "<BR>" + resultSetQ.getString("shp.address") + "<BR>" + miles + "<BR>" + timeDurration + " " + time);
				System.out.println(request.getParameter("eid" +j) + " " + resultSetQ.getString("shp.address") + resultSetQ.getString("pickup_date"));
				eDate = new java.util.Date(resultSetQ.getTimestamp("pickup_date").getTime());
			}
			
		}	
		if(true){
			PreparedStatement psQ = connection.prepareStatement("select con.org_name, load_board_line_consignee.pickup_date, con.address, (GLength(LineStringFromWKB(LineString(con.addresslocation, GeomFromText('POINT(" + pickCity_lat + " " + pickCity_lng + ")'))))) AS distanceFromPickCity from test.load_board left join test.load_board_line_consignee on load_board.load_board_id=load_board_line_consignee.load_id left join test.locations as con on load_board_line_consignee.consignee_id=con.location_id left join test.load_board_line on load_board.load_board_id=load_board_line.load_id left join test.trucking_equipment on load_board.load_equipment_id=trucking_equipment.id WHERE trucking_equipment.ID = ? and (load_board_line_consignee.pickup_date > NOW() ) ORDER BY load_board_line_consignee.pickup_date asc LIMIT 1");							
			psQ.setString(1, request.getParameter("eid" +j));
			ResultSet resultSetQ = psQ.executeQuery();
			while (resultSetQ.next()) {
					java.util.Date jDate = new java.util.Date(resultSetQ.getTimestamp("load_board_line_consignee.pickup_date").getTime());	
					Calendar jcal=Calendar.getInstance();
					jcal.setTimeInMillis(resultSetQ.getTimestamp("load_board_line_consignee.pickup_date").getTime());
					Calendar ecal=Calendar.getInstance();
					ecal.setTime(eDate);
				if(ecal.after(jcal)){
					String miles = "";
					String time = "";
					if(resultSetQ.getString("distanceFromPickCity")!=null && Float.parseFloat(resultSetQ.getString("distanceFromPickCity"))* 62.1371>.1){
						miles = format.format(Float.parseFloat(resultSetQ.getString("distanceFromPickCity")) * 62.1371) + " miles";
					}else{
						miles = "-";
					}
					time =new SimpleDateFormat("MM-dd h:mm a").format(resultSetQ.getTimestamp("pickup_date").getTime());

    			    String timeDurration = "" ;
    			    	if(true && resultSetQ.getTimestamp("pickup_date")!=null){
    			    long currentTime = Calendar.getInstance().getTime().getTime();
    			    long postTime = resultSetQ.getTimestamp("pickup_date").getTime();
    			    long diff = postTime -currentTime;
    			    long diffSeconds = diff / 1000 % 60;
    			    long diffMinutes = diff / (60 * 1000) % 60;
    			    long diffHours = diff / (60 * 60 * 1000) % 24;
    			    long diffDays = diff / (60 * 60 * 1000 * 24);
    			    if (diffSeconds == 1)timeDurration = "1 Second " + timeDurration;
    			    else if (diffSeconds > 1) timeDurration = diffSeconds + " Seconds " + timeDurration;
     			    timeDurration = "" ;
   			    if (diffMinutes == 1)timeDurration = "1 Minute " + timeDurration;
    			    else if (diffMinutes > 1) timeDurration = diffMinutes + " Minutes " + timeDurration;
    			    if (diffHours == 1)timeDurration = "1 Hour " + timeDurration;
    			    else if (diffHours > 1) timeDurration = diffHours + " Hours " + timeDurration;
    			    if (diffDays == 1)timeDurration = "1 Day " + timeDurration;
    			    else if (diffDays > 1) timeDurration = diffDays + " Days " + timeDurration;  
    			    	}					
					countMap.put(request.getParameter("eid" +j),resultSetQ.getString("con.org_name") + "<BR>"+ resultSetQ.getString("con.address") + "<BR>" + miles + "<BR>" + timeDurration+ " " + time );
					System.out.println(request.getParameter("eid" +j) + " " + resultSetQ.getString("con.address"));			
				}else{
				
					System.out.println("AFTER AFTER NOT BEFORE");	
				}
			}
			
		}	
		
		if(true){
			PreparedStatement psQ = connection.prepareStatement("select shp.org_name, pickup_date, shp.address, (GLength(LineStringFromWKB(LineString(shp.addresslocation, GeomFromText('POINT(" + pickCity_lat + " " + pickCity_lng + ")'))))) AS distanceFromPickCity  from test.load_board left join test.load_board_line on load_board.load_board_id=load_board_line.load_id left join test.locations as shp on load_board_line.shipper_id=shp.location_id left join test.trucking_equipment on load_board.load_equipment_id=trucking_equipment.id WHERE trucking_equipment.ID = ? and (load_board_line.pickup_date < NOW() ) ORDER BY load_board_line.pickup_date desc LIMIT 1");							
			psQ.setString(1, request.getParameter("eid" +j));
			ResultSet resultSetQ = psQ.executeQuery();
			while (resultSetQ.next()) {
				String miles = "";
				String time = "";
				if(resultSetQ.getString("distanceFromPickCity")!=null && Float.parseFloat(resultSetQ.getString("distanceFromPickCity"))* 62.1371>.1){
					miles = format.format(Float.parseFloat(resultSetQ.getString("distanceFromPickCity")) * 62.1371) + " miles";
				}else{
					miles = "-";
				}	
				time =new SimpleDateFormat("MM-dd h:mm a").format(resultSetQ.getTimestamp("pickup_date").getTime());
    			    String timeDurration = "" ;
    			    	if(true && resultSetQ.getTimestamp("pickup_date")!=null){
    			    long currentTime = Calendar.getInstance().getTime().getTime();
    			    long postTime = resultSetQ.getTimestamp("pickup_date").getTime();
    			    long diff = currentTime-postTime;
    			    long diffSeconds = diff / 1000 % 60;
    			    long diffMinutes = diff / (60 * 1000) % 60;
    			    long diffHours = diff / (60 * 60 * 1000) % 24;
    			    long diffDays = diff / (60 * 60 * 1000 * 24);
    			    if (diffSeconds == 1)timeDurration = "1 Second " + timeDurration;
    			    else if (diffSeconds > 1) timeDurration = diffSeconds + " Seconds " + timeDurration;
    			    timeDurration = "" ;
    			    if (diffMinutes == 1)timeDurration = "1 Minute " + timeDurration;
    			    else if (diffMinutes > 1) timeDurration = diffMinutes + " Minutes " + timeDurration;
    			    if (diffHours == 1)timeDurration = "1 Hour " + timeDurration;
    			    else if (diffHours > 1) timeDurration = diffHours + " Hours " + timeDurration;
    			    if (diffDays == 1)timeDurration = "1 Day " + timeDurration;
    			    else if (diffDays > 1) timeDurration = diffDays + " Days " + timeDurration;  
    			    	}				
				countMap.put("CC" + request.getParameter("eid" +j),resultSetQ.getString("shp.org_name") + "<BR>" + resultSetQ.getString("shp.address") + "<BR>" + miles + "<BR>" + timeDurration+ " " + time );
				System.out.println(request.getParameter("eid" +j) + " " + resultSetQ.getString("shp.address"));
				cDate = new java.util.Date(resultSetQ.getTimestamp("pickup_date").getTime());
			}
		}
		if(true){
			//PreparedStatement psQ = connection.prepareStatement("select * from test.load_board left join test.load_board_line_consignee on load_board.load_board_id=load_board_line_consignee.load_id left join test.locations as con on load_board_line_consignee.consignee_id=con.location_id left join test.load_board_line on load_board.load_board_id=load_board_line.load_id left join test.locations as shp on load_board_line.shipper_id=shp.location_id left join test.trucking_equipment on load_board.load_equipment_id=trucking_equipment.id WHERE trucking_equipment.ID = ? and (load_board_line.pickup_date > NOW()) ORDER BY GREATEST(load_board_line.pickup_date, load_board_line_consignee.pickup_date) ASC LIMIT 1");							
			PreparedStatement psQ = connection.prepareStatement("select con.org_name, load_board_line_consignee.pickup_date, con.address, (GLength(LineStringFromWKB(LineString(con.addresslocation, GeomFromText('POINT(" + pickCity_lat + " " + pickCity_lng + ")'))))) AS distanceFromPickCity from test.load_board left join test.load_board_line_consignee on load_board.load_board_id=load_board_line_consignee.load_id left join test.locations as con on load_board_line_consignee.consignee_id=con.location_id left join test.trucking_equipment on load_board.load_equipment_id=trucking_equipment.id WHERE trucking_equipment.ID = ? and (load_board_line_consignee.pickup_date < NOW() ) ORDER BY load_board_line_consignee.pickup_date desc LIMIT 1");							
			psQ.setString(1, request.getParameter("eid" +j));
			ResultSet resultSetQ = psQ.executeQuery();
			while (resultSetQ.next()) {
					java.util.Date jDate = new java.util.Date(resultSetQ.getTimestamp("pickup_date").getTime());	
					Calendar jcal=Calendar.getInstance();
					jcal.setTimeInMillis(resultSetQ.getTimestamp("pickup_date").getTime());
					Calendar ecal=Calendar.getInstance();
					ecal.setTime(cDate);
				if(ecal.before(jcal)){
					String miles = "";
					String time = "";
					if(resultSetQ.getString("distanceFromPickCity")!=null && Float.parseFloat(resultSetQ.getString("distanceFromPickCity"))* 62.1371>.1){
						miles = format.format(Float.parseFloat(resultSetQ.getString("distanceFromPickCity")) * 62.1371) + " miles";
					}else{
						miles = "-";
					}
    			    String timeDurration = "" ;
    			    	if(true && resultSetQ.getTimestamp("pickup_date")!=null){
    			    long currentTime = Calendar.getInstance().getTime().getTime();
    			    long postTime = resultSetQ.getTimestamp("pickup_date").getTime();
    			    long diff = currentTime-postTime;
    			    long diffSeconds = diff / 1000 % 60;
    			    long diffMinutes = diff / (60 * 1000) % 60;
    			    long diffHours = diff / (60 * 60 * 1000) % 24;
    			    long diffDays = diff / (60 * 60 * 1000 * 24);
    			    if (diffSeconds == 1)timeDurration = "1 Second " + timeDurration;
    			    else if (diffSeconds > 1) timeDurration = diffSeconds + " Seconds " + timeDurration;
    			    timeDurration = "" ;
    			    if (diffMinutes == 1)timeDurration = "1 Minute " + timeDurration;
    			    else if (diffMinutes > 1) timeDurration = diffMinutes + " Minutes " + timeDurration;
    			    if (diffHours == 1)timeDurration = "1 Hour " + timeDurration;
    			    else if (diffHours > 1) timeDurration = diffHours + " Hours " + timeDurration;
    			    if (diffDays == 1)timeDurration = "1 Day " + timeDurration;
    			    else if (diffDays > 1) timeDurration = diffDays + " Days " + timeDurration;  
    			    	}					
					time =new SimpleDateFormat("MM-dd h:mm a").format(resultSetQ.getTimestamp("pickup_date").getTime());
					countMap.put("CC" + request.getParameter("eid" +j),resultSetQ.getString("con.org_name") + "<BR>" +  resultSetQ.getString("con.address") + "<BR>" + miles + "<BR>"   + timeDurration + " " + time);
				}
			}
		}
		}
		for(int j=0;j<Integer.valueOf(request.getParameter("resultRows"));j++){
			//System.out.println(((String)countMap.get(request.getParameter("eid" +j))));
			//System.out.println(request.getParameter("eid" +j));
			%><%=NullCheck.check(((String)countMap.get("CC" + request.getParameter("eid" +j)))) + "<FIELD>" + NullCheck.check(((String)countMap.get(request.getParameter("eid" +j)))) + "<ROW>" %><%
		}
		connection.close();		
	 }catch (Exception ex){	         
	     %><%="Error Posting " + ex%><%  
	     System.out.println(""+ ex);
	 }	         
						%>