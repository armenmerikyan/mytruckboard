<%@ page import="javax.imageio.ImageIO,java.io.OutputStream,java.io.IOException,java.io.File,java.awt.image.BufferedImage,org.w3c.dom.Node,org.w3c.dom.NodeList,org.xml.sax.InputSource,org.w3c.dom.Document,javax.xml.xpath.XPath,javax.xml.xpath.XPathConstants,javax.xml.xpath.XPathFactory,javax.xml.parsers.DocumentBuilderFactory,java.net.HttpURLConnection,java.net.URL,java.net.URLEncoder,com.big.util.*,java.text.*,java.util.*,java.io.*,javax.xml.parsers.*,org.w3c.dom.*,java.sql.*,java.text.DateFormat,com.twilio.sdk.TwilioRestClient,com.twilio.sdk.TwilioRestException,com.twilio.sdk.TwilioRestClient,com.twilio.sdk.resource.instance.Sms,com.twilio.sdk.resource.list.SmsList,java.util.HashMap,java.util.Map,com.twilio.sdk.resource.factory.SmsFactory" %><%
		response.setContentType("image/jpeg");
try{
		System.out.println("Looking For Image : " + request.getParameter("CLIENT_ID"));     
		java.sql.Timestamp ts = new java.sql.Timestamp((new java.util.Date()).getTime());
		Class.forName("com.mysql.jdbc.Driver");
		String urldb = "jdbc:mysql://localhost/maids_oltp?user=<USER>&password=<PASSWORD>";	
		
		String clientid = request.getParameter("CLIENT_ID"); 
				

		System.out.println("Looking For Image : " + clientid); 
		String pathToWeb = getServletContext().getRealPath(File.separator);
		File f = new File("H:\\maidsSecure\\uploadDocs\\" + clientid + "\\face.pic.facePic.jpg");
		if(!f.exists()){
			f = new File("H:\\maidsSecure\\uploadDocs\\pic01.jpg");
		}		
		BufferedImage bi = ImageIO.read(f);
		OutputStream outImage = response.getOutputStream();
		ImageIO.write(bi, "jpg", outImage);
		outImage.close();
			     
		     //System.out.println("lat/lng=" + lat + "," + lng);
		}catch(Exception ex){
			%><%="" + ex%><%
			System.out.println(ex + "");
		}%>