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
			PreparedStatement ps = connection.prepareStatement("INSERT INTO test.maids_msg_board_ack(ack_ID, ack_by, ts, provider_group_id, ack_type, message_id) VALUES (?,?,?,?,?,?)");
			ps.setString(1, UUID.randomUUID() + "");
			ps.setString(2, (String)session.getAttribute("login_id"));
			ps.setTimestamp(3, new java.sql.Timestamp((new java.util.Date()).getTime()));
			ps.setString(4, uuid);
			ps.setString(5, "Got It");
			ps.setString(6, request.getParameter("messageID"));
			ps.executeUpdate();
			connection.close();

			%><%=request.getParameter("messageID")%><ITEM>Done


		<%

		 }catch (Exception ex){
		     %><%="Error Posting " + ex%><%
		     System.out.println(""+ ex);
		 }
				%>

        <%}%>
<%}%>