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

			Connection connection = DriverManager.getConnection(url,"<USERNAME>", "<PASSWORD>");
			DateFormat formatter = new SimpleDateFormat("MM-dd-yyyy.HH.mm.ss");
			DateFormat formatterDate = new SimpleDateFormat("MM-dd-yyyy");
				String stringResponse = "";
			if(!request.getParameter("location_type").equals("Carrier")){
				PreparedStatement ps = connection.prepareStatement("select * from test.locations where company_id = ? and org_name like ? and location_type = ? ");
				ps.setString(1, uuid);
				ps.setString(2, "%"+request.getParameter("search_key") +"%");
				ps.setString(3, request.getParameter("location_type"));
				ResultSet resultSet = ps.executeQuery();
				while (resultSet.next()) {
					if(resultSet.getString("address2")!=null && !resultSet.getString("address2").equals("")){
						stringResponse = stringResponse + "Start<ITEM>True<ITEM>" + resultSet.getString("org_name")+ "<ITEM>" + resultSet.getString("location_id")+ "<ITEM>" + NullCheck.check(resultSet.getString("address2")) + " " +resultSet.getString("address") + "<ITEM>DONE<ROW>";  
					}else{
						stringResponse = stringResponse + "Start<ITEM>True<ITEM>" + resultSet.getString("org_name")+ "<ITEM>" + resultSet.getString("location_id")+ "<ITEM>" + resultSet.getString("address") + "<ITEM>DONE<ROW>";  
					}
				}
			}else{
				PreparedStatement ps = connection.prepareStatement("select * from test.TRUCKING_EQUIPMENT where company_id = ? and name like ?");
				ps.setString(1, uuid);
				ps.setString(2, "%"+request.getParameter("search_key") +"%");
				ResultSet resultSet = ps.executeQuery();
				while (resultSet.next()) {
					if(resultSet.getString("city")!=null && !resultSet.getString("city").equals("")){
						stringResponse = stringResponse + "Start<ITEM>True<ITEM>" + resultSet.getString("name")+ "<ITEM>" + resultSet.getString("id")+ "<ITEM>" + NullCheck.check(resultSet.getString("city")) + " " +resultSet.getString("state") + "<ITEM>DONE<ROW>";  
					}else{
						stringResponse = stringResponse + "Start<ITEM>True<ITEM>" + resultSet.getString("name")+ "<ITEM>" + resultSet.getString("id")+ "<ITEM>" + resultSet.getString("address") + "<ITEM>DONE<ROW>";  
					}
				}
			
			}
			
			if(stringResponse.indexOf("<ROW>") > 0)stringResponse = stringResponse.substring(0, stringResponse.length()-5);

			connection.close();
			%><%=stringResponse%><%
		 }catch (Exception ex){
		     %><%="Error Posting " + ex%><%
		     System.out.println(""+ ex);
		 }
				%>

 <%}else{%>
Login Error
<%}%>