<%@ page import="java.util.Vector,com.big.util.*,java.text.*,java.util.*,java.io.*,javax.xml.parsers.*,org.w3c.dom.*,java.sql.*,java.text.DateFormat" %><%

if(session.getAttribute("isAdmin").equals("true")){
			String uuid = (String)session.getAttribute("uuid");

			String errorMsg = "";
            		System.out.println("Status NAME:" + request.getParameter("check_status") + ":");
            if(request.getParameter("check_status")!=null && request.getParameter("check_status").equals("true")){
	         try{

            		System.out.println("Status NAME:" + request.getParameter("check_status") + ":");
			Class.forName("com.mysql.jdbc.Driver");
			String url = "jdbc:mysql://localhost/test?zeroDateTimeBehavior=convertToNull";
			Connection connection = DriverManager.getConnection(url,"<USERNAME>", "<PASSWORD>");

			PreparedStatement ps = connection.prepareStatement("INSERT INTO test.TRUCKING_USER_teams_User_state(u_t_u_id, ts, team_id, user_id, user_state, company_id, created_by) VALUES (?,?,?,?,?,?,?)");
			ps.setString(1, UUID.randomUUID() +"");
			java.sql.Timestamp ts = new java.sql.Timestamp((new java.util.Date()).getTime());
			ps.setTimestamp(2, ts);
			ps.setString(3, request.getParameter("team_id"));
			ps.setString(4, request.getParameter("user_id"));
			ps.setString(5, request.getParameter("role"));
			ps.setString(6, uuid);
			ps.setString(7, (String)session.getAttribute("login_id"));
			ps.executeUpdate();
			 %>start<ITEM><%=request.getParameter("team_id")%><ITEM><%=request.getParameter("user_id")%><ITEM><%=request.getParameter("role")%><ITEM>true<ITEM>Done<%
			connection.close();
	         }catch (Exception ex){
	             errorMsg = "" + ex.getMessage();
	             System.out.println(""+ ex);
			 %>start<ITEM><%=request.getParameter("team_id")%><ITEM><%=request.getParameter("user_id")%><ITEM><%=request.getParameter("role")%><ITEM>false<ITEM>Done<%
	         }
				%>
            <%}%>
            <%if(request.getParameter("check_status")!=null && request.getParameter("check_status").equals("false")){%>
            <%
	         try{
//			Class.forName("com.sap.dbtech.jdbc.DriverSapDB");
//			String url = "jdbc:sapdb://localhost/BIGDB?sqlmode=ORACLE";
			Class.forName("com.mysql.jdbc.Driver");
			String url = "jdbc:mysql://localhost/test?zeroDateTimeBehavior=convertToNull";

			Connection connection = DriverManager.getConnection(url,"<USERNAME>", "<PASSWORD>");
			PreparedStatement ps = connection.prepareStatement("delete from test.TRUCKING_USER_teams_User_state where company_id = ? and  team_id = ? and user_state = ? and user_id = ?");
			ps.setString(1, uuid);
			ps.setString(2, request.getParameter("team_id"));
			ps.setString(3, request.getParameter("role"));
			ps.setString(4, request.getParameter("user_id"));
			ps.executeUpdate();
			
			connection.close();
			 %>start<ITEM><%=request.getParameter("team_id")%><ITEM><%=request.getParameter("user_id")%><ITEM><%=request.getParameter("role")%><ITEM>true<ITEM>Done<%
	         }catch (Exception ex){
	             errorMsg = "" + ex.getMessage();
			 %>start<ITEM><%=request.getParameter("team_id")%><ITEM><%=request.getParameter("user_id")%><ITEM><%=request.getParameter("role")%><ITEM>false<ITEM>Done<%
	         }
				%>
            <%}%>       
<%}%>
