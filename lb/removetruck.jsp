<%@ page import="com.big.util.*,java.text.*,java.util.*,java.io.*,javax.xml.parsers.*,org.w3c.dom.*,java.sql.*,java.text.DateFormat" %>			
<%
			String uuid = (String)session.getAttribute("uuid");
			if(uuid !=null){
%>

			<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" "http://www.w3.org/TR/REC-html40/loose.dtd">
			<html>
			<head>

<script language="JavaScript" type="text/javascript">

  var _gaq = _gaq || [];
  _gaq.push(['_setAccount', 'UA-28886039-1']);
  _gaq.push(['_trackPageview']);

  (function() {
    var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
    ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
    var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
  })();

</script>			
			</head>
			<body bgcolor="#FFFFFF" text="#000000" link="#0000FF" vlink="#800080" alink="#FF0000" onload="initialize()" onunload="GUnload()">
<%if(session.getAttribute("isAdmin").equals("true")){%>				
<%
				
		 try{
//			Class.forName("com.sap.dbtech.jdbc.DriverSapDB");
//			String url = "jdbc:sapdb://localhost/BIGDB?sqlmode=ORACLE";
			Class.forName("com.mysql.jdbc.Driver");
			String url = "jdbc:mysql://localhost/test?zeroDateTimeBehavior=convertToNull";		
			Connection connection = DriverManager.getConnection(url,"<USERNAME>", "<PASSWORD>");			
			
			PreparedStatement ps = connection.prepareStatement("DELETE from TRUCKING_EQUIPMENT where ID = ? ");
			ps.setString(1, request.getParameter("id"));			
			ps.executeUpdate();						

			connection.close();


						%>

							<script>

							window.location.assign("standard-truckboard.jsp");

							</script>

						<%

		 }catch (Exception ex){	         
		     %><font color="#FF0000"><%="Error Posting " + ex%></font><%  
		     System.out.println(""+ ex);
		 }				
				%>					
<%}%>					
	        	</body>
	        	</html>
	        	<%}else{%>
	        	<a href="myTruckBoard.com">Please Login</a>
	        	<%}%>