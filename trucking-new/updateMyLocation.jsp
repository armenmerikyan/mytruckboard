<%@ page import="org.w3c.dom.Node,org.w3c.dom.NodeList,org.xml.sax.InputSource,org.w3c.dom.Document,javax.xml.xpath.XPath,javax.xml.xpath.XPathConstants,javax.xml.xpath.XPathFactory,javax.xml.parsers.DocumentBuilderFactory,java.net.HttpURLConnection,java.net.URL,java.net.URLEncoder,com.big.util.*,java.text.*,java.util.*,java.io.*,javax.xml.parsers.*,org.w3c.dom.*,java.sql.*,java.text.DateFormat,com.twilio.sdk.TwilioRestClient,com.twilio.sdk.TwilioRestException,com.twilio.sdk.TwilioRestClient,com.twilio.sdk.resource.instance.Sms,com.twilio.sdk.resource.list.SmsList,java.util.HashMap,java.util.Map,com.twilio.sdk.resource.factory.SmsFactory" %><%

    Enumeration requestParameters = request.getParameterNames();

    while (requestParameters.hasMoreElements()) {
        String element = (String) requestParameters.nextElement();
        String value = request.getParameter(element);
        System.out.println("element " + element + " value " + value);
        if(value.contains(new StringBuilder().append("").append('\'').toString())
        || value.contains(new StringBuilder().append("").append('\"').toString())
        || value.contains(new StringBuilder().append("").append('\b').toString())
        || value.contains(new StringBuilder().append("").append('\n').toString())
        || value.contains(new StringBuilder().append("").append('\r').toString())
        || value.contains(new StringBuilder().append("").append('\t').toString())
        || value.contains(new StringBuilder().append("").append('\\').toString())
        || value.toUpperCase().contains("SELECT")
        || value.toUpperCase().contains("UPDATE")
        || value.toUpperCase().contains("DELETE")
        || value.toUpperCase().contains("DROP")
        || value.toUpperCase().contains("INSERT")
        || value.toUpperCase().contains("*")
        || value.toUpperCase().contains("$")
        ){
	        System.out.println(" SQL INJECTION ERROR :::: element " + element + " value " + value);   
	        
        }
    }
		String responseText = "";
		try{
		
		response.addHeader("Expires","-1");
		response.addHeader("Pragma","no-cache");
		System.out.println("Update My Location CLIENT ID : " + request.getParameter("clientid"));
		System.out.println("Update My Location CLIENT ID : --" + request.getParameter("lat")+ "--");
		System.out.println("Update My Location CLIENT ID : --" + request.getParameter("long")+ "--");
		String GEOCODER_REQUEST_PREFIX_FOR_XML = "https://maps.google.com/maps/api/geocode/xml";
//			GeocoderRequestBuilder()
		   String address = "1600 Amphitheatre Parkway, Mountain View, CA";
			System.out.println("Client ID --" + request.getParameter("clientid") + "--");
		    // prepare a URL to the geocoder
		    URL url = new URL(GEOCODER_REQUEST_PREFIX_FOR_XML + "?latlng=" + request.getParameter("lat") + "," + request.getParameter("long") +"&key=AIzaSyA_vtLue-wqsFJ4iTpAaa8yveWU_p64Ai4&sensor=false");
			System.out.println(GEOCODER_REQUEST_PREFIX_FOR_XML + "?latlng=" + request.getParameter("lat") + "," + request.getParameter("long") +"&key=AIzaSyA_vtLue-wqsFJ4iTpAaa8yveWU_p64Ai4&sensor=false");	
		    // prepare an HTTP connection to the geocoder
		    HttpURLConnection conn = (HttpURLConnection) url.openConnection();

		    Document geocoderResultDocument = null;
		   
		      // open the connection and get results as InputSource.
		      conn.connect();
				/*
			BufferedReader reader = new BufferedReader(new InputStreamReader(conn.getInputStream()));
			String line = "";
			StringWriter writer = new StringWriter();
			while((line=reader.readLine())!=null){
			    System.out.println("NEWLINE" + line);
			}
			reader.close();
			writer.close();  
			*/
		      InputSource geocoderResultInputSource = new InputSource(conn.getInputStream());
			
		      // read result and parse into XML Document

		      geocoderResultDocument = DocumentBuilderFactory.newInstance().newDocumentBuilder().parse(geocoderResultInputSource);
		     System.out.println(geocoderResultInputSource.toString());
		     // prepare XPath
		     XPath xpath = XPathFactory.newInstance().newXPath();

		     // extract the result
		     NodeList resultNodeList = null;

		     // a) obtain the formatted_address field for every result
		     resultNodeList = (NodeList) xpath.evaluate("/", geocoderResultDocument, XPathConstants.NODESET);
		     resultNodeList = (NodeList) xpath.evaluate("/GeocodeResponse/result/formatted_address", geocoderResultDocument, XPathConstants.NODESET);
		     for(int i=0; i<resultNodeList.getLength(); ++i) {
				       if(responseText .equals(""))responseText = resultNodeList.item(i).getTextContent();
			       	       System.out.println(resultNodeList.item(i).getTextContent());
		     }
			System.out.println(geocoderResultDocument.getTextContent()+ "RESPONSE BACK");
			if(geocoderResultDocument!=null){
		     		// b) extract the locality for the first result
		     		resultNodeList = (NodeList) xpath.evaluate("/GeocodeResponse/result[1]/address_component[type/text()='locality']/long_name", geocoderResultDocument, XPathConstants.NODESET);
			     for(int i=0; i<resultNodeList.getLength(); ++i) {
	//			       System.out.println(resultNodeList.item(i).getTextContent());
			     }

		     // c) extract the coordinates of the first result
			     resultNodeList = (NodeList) xpath.evaluate("/GeocodeResponse/result[1]/geometry/location/*", geocoderResultDocument, XPathConstants.NODESET);
			     float lat = Float.NaN;
			     float lng = Float.NaN;
			     for(int i=0; i<resultNodeList.getLength(); ++i) {
			       Node node = resultNodeList.item(i);
			       if("lat".equals(node.getNodeName())) lat = Float.parseFloat(node.getTextContent());
			       if("lng".equals(node.getNodeName())) lng = Float.parseFloat(node.getTextContent());
			     }
		     		resultNodeList = (NodeList) xpath.evaluate("/GeocodeResponse/result[1]/address_component[type/text() = 'administrative_area_level_1']/country[short_name/text() = 'US']/*", geocoderResultDocument, XPathConstants.NODESET);
			     for(int i=0; i<resultNodeList.getLength(); ++i) {
			       Node node = resultNodeList.item(i);
			       if("lat".equals(node.getNodeName())) lat = Float.parseFloat(node.getTextContent());
			       if("lng".equals(node.getNodeName())) lng = Float.parseFloat(node.getTextContent());
			     }
		     }
        }catch(Exception ex){
            %>Unable To Translate To Address<%
            System.out.println(ex + "");
        }
        try{
		  if(responseText.equals(""))System.out.println("TEST ADDRESS RESPONSE : " + responseText);   
//		PreparedStatement ps = connection.prepareStatement("INSERT INTO maids_quotes(quote_id, client_id, TS, lat, lngt, address1, status, process_by_lock, city, state, zip, order_status) VALUES (?,?,?,?,?,?,?,0,?,?,?,?)");
//			ps.setFloat(4, Float.parseFloat(request.getParameter("lat")));
//			ps.setFloat(5, Float.parseFloat(request.getParameter("long")));
//			ps.setString(6, responseText.trim().split(",")[0]);
//			ps.setString(8, responseText.trim().split(",")[1].trim());
//			ps.setString(9, responseText.trim().split(",")[2].split(" ")[1].trim());
//			ps.setString(10, responseText.trim().split(",")[2].split(" ")[2].trim());
//			ps.setString(11, "Quote");
//			
//			System.out.println(request.getParameter("clientid"));
		String latLong = "";
		if(request.getParameter("lat")!=null && request.getParameter("long")!=null){
			latLong = "POINT(" + request.getParameter("lat") + " " + request.getParameter("long") + ")";
		}
		
		java.sql.Timestamp ts = new java.sql.Timestamp((new java.util.Date()).getTime());
		Class.forName("com.mysql.jdbc.Driver");
		String urldb = "jdbc:mysql://localhost/maids_oltp?user=<USER>&password=<PASSWORD>";	
		String clientid = request.getParameter("clientid"); 
        String f_name = "";
        String l_name = "";
        String company_name = "";
        String owner_name = "";
        String wtg = "";
        String basicNotes = "";
        String specialNotes = "";
        int current_state = 0;
        int currentTruckType = 0;
        String[] driver_state = {"OFFLINE", "SLEEPING", "RESTING", "DRIVING", "ONLINE"};
        String[] current_truck_type = {"DRY VAN TRUCK", "FLATBED TRUCK", "REEFER TRUCK", "BOX TRUCK", "CAR CARRIER TRUCK"};

        System.out.println(request.getParameter("clientid"));
		String stringResponseAll = "";
		Connection connection = DriverManager.getConnection(urldb);
			PreparedStatement ps = connection.prepareStatement("select * from maids_customers WHERE key_client_temp = ? or client_id = ?");
			ps.setString(1, clientid);			
            ps.setString(2, clientid);
			ResultSet resultSetSec = ps.executeQuery();
			while (resultSetSec.next()) {
				clientid = resultSetSec.getString("client_id");
                f_name = resultSetSec.getString("f_name");
                l_name = resultSetSec.getString("l_name");
                company_name = resultSetSec.getString("company_name");
                owner_name = resultSetSec.getString("owner_name");
                wtg = resultSetSec.getString("wtg");
                basicNotes = resultSetSec.getString("basicNotes");
                specialNotes = resultSetSec.getString("specialNotes");
                if(resultSetSec.getString("current_state")!=null) current_state = Integer.valueOf(resultSetSec.getString("current_state"));
                if(resultSetSec.getString("currentTruckType")!=null) currentTruckType = Integer.valueOf(resultSetSec.getString("currentTruckType"));
				System.out.println(resultSetSec.getString("client_id"));
			}
			String currentSpeed = ".69";
			String currentDirection = "-1";
			String price_per_mile = "0";
			if(request.getParameter("speed")!=null)currentSpeed = request.getParameter("speed");
			if(request.getParameter("direction")!=null)currentDirection = request.getParameter("direction");
			if(request.getParameter("price")!=null)price_per_mile = request.getParameter("price");
		
			ps = connection.prepareStatement("update maids_customers set location = GeomFromText(?), address1 = ?, city = ?, state = ?, zip = ?, speedCurrent = ?, ts_last_update = ?, directionCurrent = ?, search_key = ? where client_id = ? ");
			ps.setString(1, latLong);
			if(!responseText.equals(""))ps.setString(2, responseText.trim().split(",")[0]);
			if(responseText.equals(""))ps.setString(2, "");
			if(!responseText.equals(""))ps.setString(3, responseText.trim().split(",")[1].trim());
			if(responseText.equals(""))ps.setString(3, "");
			if(!responseText.equals(""))ps.setString(4, responseText.trim().split(",")[2].split(" ")[1].trim());
			if(responseText.equals(""))ps.setString(4, "");
			if(!responseText.equals(""))ps.setString(5, responseText.trim().split(",")[2].split(" ")[2].trim());
			if(responseText.equals(""))ps.setString(5, "");
			ps.setFloat(6, Float.parseFloat(request.getParameter("speed")));
			ps.setTimestamp(7, new java.sql.Timestamp((new java.util.Date()).getTime()));
			ps.setFloat(8, Float.parseFloat(currentDirection));
            ps.setString(9, f_name + " " +
            l_name + " " +
            company_name + " " +
            owner_name + " " +
            wtg + " " +
            basicNotes + " " +
            specialNotes + " " +
            current_truck_type[currentTruckType] + " " +
            driver_state[current_state] + " " +
            responseText + " " + request.getParameter("speed") + " " + request.getParameter("wtge") + " " + request.getParameter("price_per_mile"));
			ps.setString(10, clientid);
			System.out.println("Update Location Status : " + ps.executeUpdate());
			
			ps = connection.prepareStatement("INSERT INTO customer_location_archive (location, address, city, state, zip, speedCurrent, archive_id, ts, directionCurrent,  wtg,  basicNotes, specialNotes, price_per_mile, current_state, client_id, temp_client_id) VALUES(GeomFromText(?),?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
			ps.setString(1, latLong);
			if(!responseText.equals(""))ps.setString(2, responseText.trim().split(",")[0]);
			if(responseText.equals(""))ps.setString(2, "");
			if(!responseText.equals(""))ps.setString(3, responseText.trim().split(",")[1].trim());
			if(responseText.equals(""))ps.setString(3, "");
			if(!responseText.equals(""))ps.setString(4, responseText.trim().split(",")[2].split(" ")[1].trim());
			if(responseText.equals(""))ps.setString(4, "");
			if(!responseText.equals(""))ps.setString(5, responseText.trim().split(",")[2].split(" ")[2].trim());
			if(responseText.equals(""))ps.setString(5, "");
			ps.setFloat(6, Float.parseFloat(request.getParameter("speed")));
			ps.setString(7, UUID.randomUUID() + "");
			ps.setTimestamp(8, new java.sql.Timestamp((new java.util.Date()).getTime()));
			ps.setFloat(9, Float.parseFloat(currentDirection));
			ps.setString(10, request.getParameter("wtge"));
			ps.setString(11, request.getParameter("bdetail"));
			ps.setString(12, request.getParameter("sdetail"));
			ps.setFloat(13, Float.parseFloat(price_per_mile));
			ps.setString(14, request.getParameter("orderTYpe"));
			ps.setString(15, clientid);
			ps.setString(16, request.getParameter("clientid") );
			System.out.println("Update Location Status : " + ps.executeUpdate());

		connection.close();		     
		     //System.out.println("lat/lng=" + lat + "," + lng);
		}catch(Exception ex){
			%>Unable To Translate To Address <%=ex + ""%><%
			System.out.println(ex + "");
		}
		%><%if(!responseText.equals("")){%><%=responseText.trim().split(",")[1].trim() + ", " + responseText.trim().split(",")[2].split(" ")[1].trim()%><%}else{%>Location Updated<%}%>
