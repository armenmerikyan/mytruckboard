<%@ page import="com.big.util.*,java.text.*,java.util.*,java.io.*,javax.xml.parsers.*,org.w3c.dom.*,java.sql.*,java.text.DateFormat" %>
<%
String uuid = (String)session.getAttribute("uuid");
boolean needStatusUpdate = false;
if(uuid !=null){
%>
            <%
		 try{

			Class.forName("com.mysql.jdbc.Driver");
			String url = "jdbc:mysql://localhost/test?user=<PASSWORD>&password=<PASSWORD>";


            String cityall = request.getParameter("pickCity");
            String[] parts = cityall.split(",");
            String cityv = parts[0]; // get the city from the submitted form
            String statev = parts[1]; // get the state from the submitted form

			Connection connection = DriverManager.getConnection(url,"<USERNAME>", "<PASSWORD>");
			DateFormat formatter = new SimpleDateFormat("MM-dd-yyyy.HH.mm.ss");
			DateFormat formatterDate = new SimpleDateFormat("MM-dd-yyyy");
			Calendar cal = Calendar.getInstance();
			java.sql.Date date_mod = null;
			if(request.getParameter("date")==null || request.getParameter("date").equals("")){
				date_mod = new java.sql.Date(((java.util.Date)formatter.parse(formatterDate.format(cal.getTime()) + ".00.00.00" )).getTime());
			}else{
				date_mod = new java.sql.Date(((java.util.Date)formatter.parse(request.getParameter("date") + ".00.00.00" )).getTime());
			}
			String location_id = UUID.randomUUID() + "";
			PreparedStatement ps = connection.prepareStatement("INSERT INTO test.locations(location_id, ts, company_id, created_by, org_name, org_phone, org_email, contact_name, contact_phone, contact_email,  city, address, address2, addressLocation, cityLocation, location_type, isActive) VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,GeomFromText(?),GeomFromText(?),?,1)");
			ps.setString(1, location_id);
			java.sql.Timestamp ts = new java.sql.Timestamp((new java.util.Date()).getTime());
			ps.setTimestamp(2, ts);
			ps.setString(3, uuid);
			ps.setString(4, (String)session.getAttribute("login_id"));
			ps.setString(5, request.getParameter("ship_name_add"));
			ps.setString(6, request.getParameter("ship_phone_add"));
			ps.setString(7, request.getParameter("ship_email_add"));
			ps.setString(8, request.getParameter("ship_contact_name_add"));
			ps.setString(9, request.getParameter("ship_contact_phone_add"));
			ps.setString(10, request.getParameter("ship_contact_email_add"));
			ps.setString(11, request.getParameter("pickCity"));
			ps.setString(12, request.getParameter("pickup_address_add"));
			ps.setString(13, request.getParameter("pickup_address2_add"));
			String latLong = "POINT(1 2)";
			if(request.getParameter("pickCity_lat")!=null && request.getParameter("pickCity_lng")!=null){
				latLong = "POINT(" + request.getParameter("pickCity_lat") + " " + request.getParameter("pickCity_lng") + ")";
			}
			ps.setString(14, latLong);
			latLong = "POINT(1 2)";
			if(request.getParameter("pickup_address_lat")!=null && request.getParameter("pickup_address_lng")!=null){
				latLong = "POINT(" + request.getParameter("pickup_address_lat") + " " + request.getParameter("pickup_address_lng") + ")";
			}
			ps.setString(15, latLong);
			ps.setString(16, request.getParameter("location_type"));
			ps.executeUpdate();
			%>Start<ITEM>True<ITEM><%=location_id%><ITEM><%=request.getParameter("ship_name_add")%><ITEM><%=request.getParameter("pickup_address_add")%><ITEM>DONE<%
			connection.close();
		 }catch (Exception ex){
		     %><%="Error Posting " + ex%><%
		     System.out.println(""+ ex);
		 }
				%>

 <%}else{%>
Login Error
<%}%>