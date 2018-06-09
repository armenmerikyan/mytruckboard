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
			PreparedStatement psMain = connection.prepareStatement("select * from test.maids_msg_board_ack where message_id = ?");
			psMain.setString(1, request.getParameter("messageID"));
			ResultSet resultMsgGotItSet = psMain.executeQuery();
			HashMap gotItMMap = new  HashMap();
			while (resultMsgGotItSet.next()) {
				gotItMMap.put(resultMsgGotItSet.getString("ack_by"),resultMsgGotItSet.getString("ack_by"));
			}			
			psMain = connection.prepareStatement("select * from test.TRUCKING_USERS WHERE COMPANY_ID = ?");
			psMain.setString(1, uuid);
			ResultSet resultSet = psMain.executeQuery();
			while (resultSet.next()) {
			%><%if(gotItMMap.containsKey(resultSet.getString("EMAIL"))){%><span style="color:green;"><%}else{%><span style="color:red;"><%}%><%=NullCheck.check(resultSet.getString("EMAIL"))%></span><BR><%			
			}
			%><input type="submit" class="btn btn-primary" value="Remove This Message" name="submit1" onclick="removeMessage('<%=request.getParameter("messageID")%>');"><ITEM><%=request.getParameter("messageID")%><ITEM>Done<%
		 }catch (Exception ex){
		     %><%="Error Posting " + ex%><%
		     System.out.println(""+ ex);
		 }
				%>

        <%}%>
<%}%>