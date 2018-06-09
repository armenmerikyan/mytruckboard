<%@ page import="com.big.util.*,java.text.*,java.util.*,java.io.*,javax.xml.parsers.*,org.w3c.dom.*,java.sql.*,java.text.DateFormat" %>
            <%
String uuid = (String)session.getAttribute("uuid");
boolean needStatusUpdate = false;
if(uuid !=null){
%>
            <%if(request.getParameter("messageID")!=null && !request.getParameter("messageID").equals("")){%>
            <%
		 try{
			Class.forName("com.mysql.jdbc.Driver");
			String url = "jdbc:mysql://localhost/test?user=<PASSWORD>&password=<PASSWORD>";
			Connection connection = DriverManager.getConnection(url,"<USERNAME>", "<PASSWORD>");
			PreparedStatement ps = connection.prepareStatement("DELETE from maids_msg_board where ID = ? ");
			ps.setString(1, request.getParameter("messageID"));			
			ps.executeUpdate();
			ps = connection.prepareStatement("DELETE from maids_msg_board_ack where message_ID = ? ");
			ps.setString(1, request.getParameter("messageID"));			
			ps.executeUpdate();			
			%>Message Removed<ITEM><%=request.getParameter("messageID")%><ITEM>Done<%
		 }catch (Exception ex){
		     %><%="Error Posting "%><%
		     System.out.println(""+ ex);
		 }
				%>

        <%}%>
<%}%>