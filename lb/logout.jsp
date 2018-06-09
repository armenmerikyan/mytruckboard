<%@ page import="com.big.util.*,java.text.*,java.util.*,java.io.*,javax.xml.parsers.*,org.w3c.dom.*,java.sql.*,java.text.DateFormat" %>			
<%
			String uuid = (String)session.getAttribute("uuid");
			if(uuid !=null){
%>

			<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" "http://www.w3.org/TR/REC-html40/loose.dtd">
			<html>
			<head>
			  <title>User Logout Page</title>
		
			</head>
			<body bgcolor="#FFFFFF" text="#000000" link="#0000FF" vlink="#800080" alink="#FF0000" onload="initialize()" >

		
<%

if(request.getParameter("id")!=null && request.getParameter("GO")!=null){
				


				session.removeAttribute("login_id");
				session.removeAttribute("uuid");
				session.removeAttribute("country_code");
				session.removeAttribute("isAdmin");
				session.removeAttribute("issubscribed");

				
				//if(session.getAttribute("pickCity")!=null)session.setAttribute("pickCity", null);
				//if(session.getAttribute("pickCity_lat")!=null)session.setAttribute("pickCity_lat", null);
				//if(session.getAttribute("pickCity_lng")!=null)session.setAttribute("pickCity_lng", null);
				//if(session.getAttribute("pickState")!=null)session.setAttribute("pickState", null);
				//if(session.getAttribute("destCity")!=null)session.setAttribute("destCity", null);
				//if(session.getAttribute("destCity_lat")!=null)session.setAttribute("destCity_lat", null);
				//if(session.getAttribute("destCity_lng")!=null)session.setAttribute("destCity_lng", null);
				//if(session.getAttribute("destState")!=null)session.setAttribute("destState", null);
				//if(session.getAttribute("distance")!=null)session.setAttribute("distance", null);
				//if(session.getAttribute("duration")!=null)session.setAttribute("duration", null);
				//if(session.getAttribute("searchKeyCity")!=null)session.setAttribute("searchKeyCity", null);
				//if(session.getAttribute("searchKeyState")!=null)session.setAttribute("searchKeyState", null);
				//if(session.getAttribute("searchKeyCity_lat")!=null)session.setAttribute("searchKeyCity_lat", null);
				//if(session.getAttribute("searchKeyCity_lng")!=null)session.setAttribute("searchKeyCity_lng", null);


				if(session.getAttribute("pickCity")!=null)session.removeAttribute("pickCity");
				if(session.getAttribute("pickCity_lat")!=null)session.removeAttribute("pickCity_lat");
				if(session.getAttribute("pickCity_lng")!=null)session.removeAttribute("pickCity_lng");
				if(session.getAttribute("pickState")!=null)session.removeAttribute("pickState");
				if(session.getAttribute("destCity")!=null)session.removeAttribute("destCity");
				if(session.getAttribute("destCity_lat")!=null)session.removeAttribute("destCity_lat");
				if(session.getAttribute("destCity_lng")!=null)session.removeAttribute("destCity_lng");
				if(session.getAttribute("destState")!=null)session.removeAttribute("destState");
				if(session.getAttribute("distance")!=null)session.removeAttribute("distance");
				if(session.getAttribute("duration")!=null)session.removeAttribute("duration");
				if(session.getAttribute("searchKeyCity")!=null)session.removeAttribute("searchKeyCity");
				if(session.getAttribute("searchKeyState")!=null)session.removeAttribute("searchKeyState");
				if(session.getAttribute("searchKeyCity_lat")!=null)session.removeAttribute("searchKeyCity_lat");
				if(session.getAttribute("searchKeyCity_lng")!=null)session.removeAttribute("searchKeyCity_lng");



		}
						
%>

	<!---- gooogle analytics -->

	<script>
	(function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
	(i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
	m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
	})(window,document,'script','//www.google-analytics.com/analytics.js','ga');

	ga('create', 'UA-28886039-1', 'auto');
	ga('send', 'pageview');

	</script>

	<!---- end of gooogle analytics -->
	
	        	</body>



	        	</html>
	        	<%}else{%>
	        	<a href="myTruckBoard.com">Please Login</a>
	        	<%}%>