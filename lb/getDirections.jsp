<%@ page import="java.util.*,java.io.*,java.net.*,org.json.simple.*" %><%
		try{
	System.out.println("Adress Called : " + request.getParameter("origin"));
	System.out.println("Adress Called : " + request.getParameter("destination"));
        URL yahoo = new URL("https://maps.googleapis.com/maps/api/directions/json?origin=" + request.getParameter("origin") + "&destination=" + request.getParameter("destination") + "&sensor=true&key=AIzaSyCb46VbE_7BQ_cCizcKaPzsexEumUrT4tY");
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
        Object obj=(Object)JSONValue.parse(jsonTxt);   
        JSONObject result = (JSONObject)obj;  
        String responseMsgDistance = "0";
		JSONArray msg = (JSONArray)(((JSONObject)obj).get("routes"));
		Iterator<JSONObject> iterator = msg.iterator();
		while (iterator.hasNext()) {  
			JSONObject tmpObj = (JSONObject)iterator.next();
			//System.out.println(tmpObj.toString()); 
			JSONArray msg2 = (JSONArray)tmpObj.get("legs");
			Iterator<JSONObject> iterator2 = msg2.iterator();
			while (iterator2.hasNext()) {  
				JSONObject tmpObj2 = (JSONObject)iterator2.next();
				System.out.println(tmpObj2.toString()); 
				System.out.println(tmpObj2.get("duration")); 
				System.out.println(tmpObj2.get("distance")); 
				JSONObject msg3 = (JSONObject)tmpObj2.get("duration");
				JSONObject msg4 = (JSONObject)tmpObj2.get("distance");
				responseMsgDistance = (String)msg4.get("text"); 
				responseMsgDistance += "|" + (String)msg3.get("text"); 
			}
		}
         
		%><%=responseMsgDistance%><% 
		}catch (Exception Ex)
		{
			Ex.printStackTrace();
		}

%>