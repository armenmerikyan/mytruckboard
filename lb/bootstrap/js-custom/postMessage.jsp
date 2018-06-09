<%@ page import="com.big.util.*,java.text.*,java.util.*,java.io.*,javax.xml.parsers.*,org.w3c.dom.*,java.sql.*,java.text.DateFormat" %>	
<%@ page import="net.tanesha.recaptcha.ReCaptchaImpl" %>
<%@ page import="net.tanesha.recaptcha.ReCaptchaResponse" %>
<% System.out.println("Called Post Message");%>
<% System.out.println(request.getParameter("message"));%>
<% System.out.println(request.getParameter("name"));%>
<% System.out.println(request.getParameter("email"));%>Thank You

<%
		try{
		String keyPairId = "";
		HashMap truckList = (HashMap)session.getAttribute("truckList");
		if(truckList!=null){		
			for (Object key : truckList.keySet()) {
			   keyPairId = keyPairId + " key: " + truckList.get(key).toString();
			}
		}
			Class.forName("com.mysql.jdbc.Driver");
			String url = "jdbc:mysql://localhost/test?zeroDateTimeBehavior=convertToNull";		
			Connection connection = DriverManager.getConnection(url,"<USERNAME>", "<PASSWORD>");				
			DateFormat formatter = new SimpleDateFormat("MM-dd-yyyy.HH.mm.ss"); 
				
				
			PreparedStatement ps = connection.prepareStatement("INSERT INTO test.messageBoard(id, ts, client_id, message, client_session_id, client_ip) VALUES (?,?,?, ?,?,?)");
			ps.setString(1, UUID.randomUUID() + "");			
			ps.setTimestamp(2, new java.sql.Timestamp((new java.util.Date()).getTime()));			
			ps.setString(3, request.getParameter("id"));				
			ps.setString(4, "<NAME>" + request.getParameter("name") + "<EMAIL>" + request.getParameter("email") + "<MESSAGE>" + request.getParameter("message") + keyPairId);
			ps.setString(5, request.getParameter("guid"));	
			ps.setString(6,  request.getRemoteAddr());
			
			ps.executeUpdate();	
		 }catch (Exception ex){	         
		     %>
		     <span style="font-size: 22px;color: #FF0000;" >
		     Error posting make sure to populate all fields <%=ex%>
		     </span>
		     <%  
		     System.out.println(""+ ex + " Rate : " + request.getParameter("per_mile"));
		 }			
			
%>