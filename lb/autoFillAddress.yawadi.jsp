<%@ page import="org.json.simple.*,com.big.util.*,java.text.*,java.util.*,java.io.*,javax.xml.parsers.*,org.w3c.dom.*,java.sql.*,java.text.DateFormat,java.io.*,java.net.*" %><%
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
            	System.out.println("FILL ADDRESS : " + inputLine);
		}
        in.close();
        Object obj=(Object)JSONValue.parse(jsonTxt);   
        JSONObject result = (JSONObject)obj;       	  
	JSONObject msg = (JSONObject)result.get("result");       	  
	JSONArray msgAddress = (JSONArray)msg.get("address_components");
        String st_no = "";
        String st = "";
        String city = "";
        String state = "";
        String zip = "";
        String lat = "";
        String lng = "";
        String arrivaleTime = "";
        String driverName = "";
	
	Iterator<JSONObject> iterator = msgAddress.iterator();
	while (iterator.hasNext()) {	
		JSONObject tmpObj = (JSONObject)iterator.next();    
		System.out.println(tmpObj.toString()); 
		System.out.println(tmpObj.get("types").toString());
		JSONArray tmpObjTypes = (JSONArray)tmpObj.get("types");
		Iterator<String> iterator2 = tmpObjTypes.iterator();
		while (iterator2.hasNext()) {	
			String tmpObj2 = (String)iterator2.next();    
			System.out.println(tmpObj2.toString()); 
			System.out.println(tmpObj.get("short_name"));
			System.out.println(tmpObj.get("long_name"));
			    String long_n = (String)tmpObj.get("long_name");
			    String short_n = (String)tmpObj.get("short_name");
			    String type = tmpObj2.toString();
			    if(type.contains("street_number"))st_no = long_n;
			    if(type.contains("route"))st = long_n;
			    if(type.contains("locality"))city = long_n;
			    if(type.contains("administrative_area_level_1"))state = short_n;
			    if(type.contains("postal_code"))zip = long_n;
		}
	}
        JSONObject locationLatLong = (JSONObject)msg.get("geometry");
        lat = Double.toString((Double)((JSONObject)locationLatLong.get("location")).get("lat"));
        lng = Double.toString((Double)((JSONObject)locationLatLong.get("location")).get("lng"));
	
        
        	System.out.println(st_no + "|" + st + "|" + city + "|" + state + "|" + zip + "|" + lat + "|" + lng);
                %><%=st_no + "|" + st + "|" + city + "|" + state + "|" + zip + "|" + lat + "|" + lng + "| |"%><%

             
		}catch (Exception Ex)
		{
			System.out.println(Ex.getMessage());
			Ex.printStackTrace();
		}

%>