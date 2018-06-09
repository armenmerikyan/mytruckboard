<%@ page import="org.w3c.dom.Node,org.w3c.dom.NodeList,org.xml.sax.InputSource,org.w3c.dom.Document,javax.xml.xpath.XPath,javax.xml.xpath.XPathConstants,javax.xml.xpath.XPathFactory,javax.xml.parsers.DocumentBuilderFactory,java.net.HttpURLConnection,java.net.URL,java.net.URLEncoder,com.big.util.*,java.text.*,java.util.*,java.io.*,javax.xml.parsers.*,org.w3c.dom.*,java.sql.*,java.text.DateFormat,com.twilio.sdk.TwilioRestClient,com.twilio.sdk.TwilioRestException,com.twilio.sdk.TwilioRestClient,com.twilio.sdk.resource.instance.Sms,com.twilio.sdk.resource.list.SmsList,java.util.HashMap,java.util.Map,com.twilio.sdk.resource.factory.SmsFactory" %><%
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
		    URL url = new URL(GEOCODER_REQUEST_PREFIX_FOR_XML + "?latlng=" + request.getParameter("lat") + "," + request.getParameter("long") +"&key=AIzaSyCb46VbE_7BQ_cCizcKaPzsexEumUrT4tY&sensor=false");
			System.out.println(GEOCODER_REQUEST_PREFIX_FOR_XML + "?latlng=" + request.getParameter("lat") + "," + request.getParameter("long") +"&key=AIzaSyCb46VbE_7BQ_cCizcKaPzsexEumUrT4tY&sensor=false");	
		    // prepare an HTTP connection to the geocoder
		    HttpURLConnection conn = (HttpURLConnection) url.openConnection();

		    Document geocoderResultDocument = null;
		   
		      // open the connection and get results as InputSource.
		      conn.connect();
		      InputSource geocoderResultInputSource = new InputSource(conn.getInputStream());

		      // read result and parse into XML Document
		      geocoderResultDocument = DocumentBuilderFactory.newInstance().newDocumentBuilder().parse(geocoderResultInputSource);
		     System.out.println(geocoderResultInputSource);
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
			System.out.println(geocoderResultDocument.getTextContent());
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
		     //System.out.println("lat/lng=" + lat + "," + lng);
		     
		     // c) extract the coordinates of the first result
		     resultNodeList = (NodeList) xpath.evaluate("/GeocodeResponse/result[1]/address_component[type/text() = 'administrative_area_level_1']/country[short_name/text() = 'US']/*", geocoderResultDocument, XPathConstants.NODESET);
		     for(int i=0; i<resultNodeList.getLength(); ++i) {
		       Node node = resultNodeList.item(i);
		       if("lat".equals(node.getNodeName())) lat = Float.parseFloat(node.getTextContent());
		       if("lng".equals(node.getNodeName())) lng = Float.parseFloat(node.getTextContent());
		     }
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
		String clientid = request.getParameter("clientID"); 
		System.out.println(request.getParameter("clientid"));
		String stringResponseAll = "";
		Connection connection = DriverManager.getConnection(urldb);
			PreparedStatement ps = connection.prepareStatement("select * from maids_customers WHERE key_client_temp = ?");
			ps.setString(1, clientid);			
			ResultSet resultSetSec = ps.executeQuery();
			while (resultSetSec.next()) {
				clientid = resultSetSec.getString("client_id");
				System.out.println(resultSetSec.getString("client_id"));   
			}
				boolean isPublicView = false;
				boolean isFriendsView = false;
				if(request.getParameter("viewPub")!=null && request.getParameter("viewPub").equals("YES"))isPublicView=true;
				if(request.getParameter("viewFriend")!=null && request.getParameter("viewFriend").equals("YES"))isFriendsView=true;
			
			ps = connection.prepareStatement("update mtb_mylocations set mylocation_email = ?, mylocation_name = ?, ispublicviewable = ?, isfriendsviewable =?, mylocation_type = ?  WHERE mylocation_id = ? and client_id = ?");	
			ps.setString(1, request.getParameter("email"));
			ps.setString(2, request.getParameter("name"));
			ps.setBoolean(3, isPublicView);
			ps.setBoolean(4,isFriendsView);		
			ps.setString(5, request.getParameter("placeType"));	
			ps.setString(6, request.getParameter("access_id"));
			ps.setString(7, clientid);
			System.out.println("Update Location Status : " + ps.executeUpdate());
			
			
		connection.close();		     
		     //System.out.println("lat/lng=" + lat + "," + lng);
		}catch(Exception ex){
			%>Unable To Translate To Address<%
			System.out.println(ex + "");
		}
		%><%if(!responseText.equals("")){%><%=responseText.trim().split(",")[1].trim() + ", " + responseText.trim().split(",")[2].split(" ")[1].trim()%><%}else{%>Update Error<%}%>		