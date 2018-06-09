<%@ page import="com.big.util.*,java.text.*,java.util.*,java.io.*,javax.xml.parsers.*,org.w3c.dom.*,java.sql.*,java.text.DateFormat,java.io.*,java.net.*,net.sf.json.*" %><%
        String st_no = "";
        String st = "";
        String city = "";
        String state = "";
        String zip = "";
        String lat = "";
        String lng = "";
        String arrivaleTime = "";
        String driverName = "";
	if(true){
		try{
		System.out.println(request.getParameter("location"));
	URL yahoo = new URL("https://maps.googleapis.com/maps/api/place/details/json?reference=" + request.getParameter("location") + "&sensor=true&key=AIzaSyCb46VbE_7BQ_cCizcKaPzsexEumUrT4tY");
		
        //URL yahoo = new URL("https://maps.googleapis.com/maps/api/place/autocomplete/json?input=" + URLEncoder.encode(request.getParameter("location")) + "&components=country:us&sensor=true&key=AIzaSyA_vtLue-wqsFJ4iTpAaa8yveWU_p64Ai4");
        URLConnection yc = yahoo.openConnection();
        BufferedReader in = new BufferedReader(
                                new InputStreamReader(
                                yc.getInputStream()));
        String inputLine;
        String jsonTxt = new String();
        while ((inputLine = in.readLine()) != null){
        	jsonTxt += inputLine;
            	//System.out.println("FILL ADDRESS : " + inputLine);
		}
        in.close();
        JSONObject json = (JSONObject) JSONSerializer.toJSON(jsonTxt );        
        JSONObject result = (JSONObject)json.get("result");
        //System.out.println(json.getString("result"));
        JSONArray address = result.getJSONArray("address_components");
        for(int j=0;j<address.size();j++){
        	
            String long_n = address.getJSONObject(j).getString("long_name");
            String short_n = address.getJSONObject(j).getString("short_name");
            String type = address.getJSONObject(j).getString("types");
            if(type.contains("street_number"))st_no = long_n;
            if(type.contains("route"))st = long_n;
            if(type.contains("locality"))city = long_n;
            if(type.contains("administrative_area_level_1"))state = short_n;
            if(type.contains("postal_code"))zip = long_n;
        } 
        JSONObject locationLatLong = (JSONObject)result.get("geometry");
        lat = ((JSONObject)locationLatLong.get("location")).getString("lat");
        lng = ((JSONObject)locationLatLong.get("location")).getString("lng");
        
        	System.out.println(st_no + "|" + st + "|" + city + "|" + state + "|" + zip + "|" + lat + "|" + lng);

             
		}catch (Exception Ex)
		{
			System.out.println(Ex.getMessage());
			Ex.printStackTrace();
		}
	}	
	if(true){
 try{
	    	   	
	    	   		float newLng = Float.parseFloat(lng);
	    			   float newLat = Float.parseFloat(lat);
	    			// TODO Auto-generated method stub
	        		System.out.println("The Terminator Has Started : Quote Engine Started");
	    			String matchEngineID = UUID.randomUUID()+ "";
	    			Class.forName("com.mysql.jdbc.Driver");
	    			String url = "jdbc:mysql://localhost/maids_oltp?user=<USER>&password=<PASSWORD>&zeroDateTimeBehavior=convertToNull";		
	    			java.sql.Connection connection = DriverManager.getConnection(url);
	    			java.sql.PreparedStatement ps = connection.prepareStatement("select * from maids_oltp.maids_quotes where status = ?");		
	    				boolean foundMaidTrue = false;
	    			        String inputLine;
	    			        String assnProviderID = "";
	    			        String assnProviderID_group_id = "";
	    			        String assnAddress = "";
	    			        String assnCity = "";
	    			        String assnState = "";
	    			        String assnZip = "";
	    			        String assnLat = "";
	    			        String assnLong = "";
	    			        String assnUser_channel_Type = "";
	    			        String responseMsgDistance = "0";
	    			       float assndistanceFromPickCity = 0f;
	    			        boolean zillowLookupDone = false;
	    			        
	        			        float distanceTo = 0f;
	        			        int totalRooms = 1;
	        			        float bathRooms = 1f;
	        			        int bedRooms = 1;
	        			        int sqlFoot = 1;
	        			        String homeType = "";
	        			        		//resultSetLocked.getBoolean("Zillow_done");
	        			        	
	        			       
	        			    ps = connection.prepareStatement("select  ZIP, Y(LOCATION) as my_lat, X(LOCATION) as my_long, user_channel_type, user_quote_type, address1, city, state, user_id, provider_id, ts, (GLength(LineStringFromWKB(LineString(location, GeomFromText('POINT(" + newLat + " " + newLng + ")'))))) AS distanceFromPickCity from maids_oltp.maids_users where quote_status = 'Available' and isonline = 1 order by distanceFromPickCity asc  LIMIT 100");        			    	
	    					ResultSet resultSubscriber = ps.executeQuery();
							boolean isMoveAble = false; 
							String quote_type = "";
	    					while (resultSubscriber.next()) {
	    						distanceTo = (Float.parseFloat(resultSubscriber.getString("distanceFromPickCity"))*100) * 0.621371f;
	    						System.out.println("IS Distance BEFORE IF ::" + distanceTo);
	    						//System.out.println("IS Brand and Type BEFORE IF : " + resultSubscriber.getString("user_quote_type") + resultSetLocked.getString("quote_Type") + " "+ resultSubscriber.getString("user_channel_type") + " "+ resultSetLocked.getString("channel_Type"));
		    					foundMaidTrue = true;
								assnProviderID = resultSubscriber.getString("user_id");	
								assnProviderID_group_id = resultSubscriber.getString("provider_id");	
								assnAddress = resultSubscriber.getString("city");
								assnCity = resultSubscriber.getString("address1");
								assnZip = resultSubscriber.getString("zip");
								assnLat = resultSubscriber.getString("my_lat");
								assnLong = resultSubscriber.getString("my_long");
								//quote_type = resultSetLocked.getString("quote_Type");
								assnUser_channel_Type = resultSubscriber.getString("user_channel_Type");
								assndistanceFromPickCity = resultSubscriber.getFloat("distanceFromPickCity");
								break;
	    					}

	    					if(foundMaidTrue){
							System.out.println("IS Distance NEW RELEASE : " + distanceTo);
							//URL gURL = new URL("https://maps.googleapis.com/maps/api/directions/json?origin=" + assnLong + URLEncoder.encode(", ") + assnLat + "&destination=" + newLat + URLEncoder.encode(", ") + newLng + "=true&key=AIzaSyCb46VbE_7BQ_cCizcKaPzsexEumUrT4tY");
							System.out.println("https://maps.googleapis.com/maps/api/directions/json?origin=" + URLEncoder.encode(assnLong + ", " + assnLat) + "&destination=" + URLEncoder.encode(newLng + ", " + newLat) + "=true&key=AIzaSyCb46VbE_7BQ_cCizcKaPzsexEumUrT4tY");
							System.out.println("https://maps.googleapis.com/maps/api/directions/json?origin=" + assnLong + URLEncoder.encode(", ") + assnLat + "&destination=" + newLng + URLEncoder.encode(", ") + newLat + "=true&key=AIzaSyCb46VbE_7BQ_cCizcKaPzsexEumUrT4tY");
							URL gURL = new URL("https://maps.googleapis.com/maps/api/directions/json?origin=" + URLEncoder.encode(assnLong + ", " + assnLat) + "&destination=" + URLEncoder.encode(newLat + ", " + newLng) + "&key=AIzaSyCb46VbE_7BQ_cCizcKaPzsexEumUrT4tY");

					        URLConnection gc = gURL.openConnection();
					        BufferedReader gin = new BufferedReader(
					                                new InputStreamReader(
					                                gc.getInputStream()));
					        String ginputLine;
					        String jsonTxt = new String();
					        while ((ginputLine = gin.readLine()) != null){
					        	jsonTxt += ginputLine;
					            	System.out.println(ginputLine);
							}
					  
					        JSONObject json = (JSONObject) JSONSerializer.toJSON(jsonTxt );        
					        //System.out.println(json.getJSONArray("predictions"));        	
					        JSONArray routes = json.getJSONArray("routes");
					        for(int j=0;j<routes.size();j++){
					        	System.out.println(routes.getJSONObject(j).getString("summary"));
					        	JSONArray legs = ((JSONObject)routes.getJSONObject(j)).getJSONArray("legs");
					        	for(int k=0;k<legs.size();k++){
					        		System.out.println(((JSONObject)legs.getJSONObject(j).get("distance")).getString("text"));
					        		responseMsgDistance = ((JSONObject)legs.getJSONObject(j).get("distance")).getString("text");
					        		responseMsgDistance += "|" + ((JSONObject)legs.getJSONObject(j).get("duration")).getString("text");
					        	}
					        }						
	    					}	
	    					arrivaleTime = responseMsgDistance;
	    					System.out.println(responseMsgDistance);
	    			connection.close();
	    		}catch(Exception ex){
	    	        System.out.println("JOB ERROR-----ERROR comAudit File Loader: " + ex.getMessage());    		
	    		} 		
	}
%><%=st_no + "|" + st + "|" + city + "|" + state + "|" + zip + "|" + lat + "|" + lng + "|" + arrivaleTime + "|" + driverName %>
