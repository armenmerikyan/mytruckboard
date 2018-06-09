<%@ page import="com.big.util.*,java.text.*,java.util.*,java.io.*,javax.xml.parsers.*,org.w3c.dom.*,java.sql.*,java.text.DateFormat" %>
<%
String uuid = (String)session.getAttribute("uuid");
if(uuid !=null){
		 try{

			Class.forName("com.mysql.jdbc.Driver");
			String url = "jdbc:mysql://localhost/test?user=<PASSWORD>&password=<PASSWORD>";

			Connection connection = DriverManager.getConnection(url,"<USERNAME>", "<PASSWORD>");			
			int status = 0;
				PreparedStatement ps = ps = connection.prepareStatement("Update test.load_board Set load_status_agent = ? where load_board_id = ? and company_id = ?");
				ps.setString(1, request.getParameter("load_status"));	
				ps.setString(2, request.getParameter("load_id"));
				ps.setString(3, uuid);
				status = ps.executeUpdate();			
			
			System.out.println("DONE UPDATE ::::::");
			%>Start<ITEM>True<ITEM><%=request.getParameter("load_id")%><ITEM><%=request.getParameter("load_status")%><ITEM><%=""+status%><ITEM>DONE<%
			System.out.println("DONE UPDATE ::::::");
			connection.close();
		 }catch (Exception ex){
		     %><%="Error Posting " + ex%><%
		     System.out.println(""+ ex);
		 }
				%>

 <%}else{%>
Login Error
<%}%>