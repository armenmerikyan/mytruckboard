<%@ page import="java.util.*,java.io.*,java.net.*,org.json.simple.*" %><%
		try{
		System.out.println("Adress Called : " + request.getParameter("location"));
        URL yahoo = new URL("https://maps.googleapis.com/maps/api/place/autocomplete/json?input=" + URLEncoder.encode(request.getParameter("location")) + "&location=" + request.getParameter("lat")+ "," + request.getParameter("long")+"&radius=500&sensor=true&key=AIzaSyCZnVjU6O2Vo_JqhOYPtCh6qb4ZO-se4z8");
        URLConnection yc = yahoo.openConnection();
        BufferedReader in = new BufferedReader(
                                new InputStreamReader(
                                yc.getInputStream()));
        String inputLine;
        String jsonTxt = new String();
        while ((inputLine = in.readLine()) != null){
        	jsonTxt += inputLine;
            	System.out.println(inputLine);
		}
        in.close();
        String stringResponse = "";
        Object obj=(Object)JSONValue.parse(jsonTxt);      
       	  System.out.println();     
       	  
		JSONArray msg = (JSONArray)(((JSONObject)obj).get("predictions"));
		Iterator<JSONObject> iterator = msg.iterator();
		while (iterator.hasNext()) {	
			JSONObject tmpObj = (JSONObject)iterator.next();
			System.out.println(tmpObj.get("description"));
			String description = (String)tmpObj.get("description");
            String city = "";
            String state = "";
            String reference = (String)tmpObj.get("reference");
            System.out.println(description);
            if(description.endsWith(", United States")){
            	city = description.split(",")[1];
            	state = description.split(",")[2];
            	description = description.split(",")[0];
            }            
            System.out.println(description); 
            stringResponse = stringResponse + description + ":" + city.trim() + ":" + state.trim() + ":" + reference + "<ROW>";    
            
		}       	  
           if(stringResponse.indexOf("<ROW>") > 0)stringResponse = stringResponse.substring(0, stringResponse.length()-5);
           if(stringResponse.equals("")){stringResponse = "Search Service Down:Call : for Quote:na"; }
           %><%=stringResponse %><%
		}catch (Exception Ex)
		{
		%>Error<%
			Ex.printStackTrace();
		}

%>
