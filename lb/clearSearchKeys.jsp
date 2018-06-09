<%@ page import="com.big.util.*,java.text.*,java.util.*,java.io.*,javax.xml.parsers.*,org.w3c.dom.*,java.sql.*,java.text.DateFormat" %>


		<%
			String uuid = (String)session.getAttribute("uuid");
			if(uuid !=null){
		%>


<%

				session.setAttribute("pickCity", null);
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


%>

	<%}%>
