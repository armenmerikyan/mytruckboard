<%@ page import="java.io.*,java.net.*,net.sf.json.*" %><%
		try{
		System.out.println("Adress Called : " + request.getParameter("location"));
        URL yahoo = new URL("https://maps.googleapis.com/maps/api/place/autocomplete/json?input=" + URLEncoder.encode(request.getParameter("location")) + "&types=address&components=country:us&location=34.1708,-118.2500&radius=500&sensor=true&key=AIzaSyCb46VbE_7BQ_cCizcKaPzsexEumUrT4tY");
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
        JSONObject json = (JSONObject) JSONSerializer.toJSON(jsonTxt );        
        //System.out.println(json.getJSONArray("predictions"));        	
        JSONArray predictions = json.getJSONArray("predictions");
        String stringResponse = "";
        for(int j=0;j<predictions.size();j++){
            String description = predictions.getJSONObject(j).getString("description");
            String city = "";
            String state = "";
            String reference = predictions.getJSONObject(j).getString("reference");
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
           %><%=stringResponse %><%
		}catch (Exception Ex)
		{
		%>Error<%
			Ex.printStackTrace();
		}

%>