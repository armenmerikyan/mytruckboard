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

			PreparedStatement psMain = null;
			psMain = connection.prepareStatement("select * from test.maids_msg_board_ack where ack_by = ?");
			psMain.setString(1, (String)session.getAttribute("login_id"));
			ResultSet resultMsgGotItSet = psMain.executeQuery();
			HashMap gotItMMap = new  HashMap();
			HashMap gotItMAnaMap = new  HashMap();
			while (resultMsgGotItSet.next()) {
			gotItMMap.put(resultMsgGotItSet.getString("message_id"),resultMsgGotItSet.getString("message_id"));
			}
			psMain = connection.prepareStatement("select * from test.maids_msg_board_ack where provider_group_id = ?");
			psMain.setString(1, uuid);
			resultMsgGotItSet = psMain.executeQuery();
			while (resultMsgGotItSet.next()) {
			if(gotItMAnaMap.containsKey(resultMsgGotItSet.getString("message_id"))){
			HashMap gotItMAnaMsgMap = (HashMap)gotItMAnaMap.get(resultMsgGotItSet.getString("message_id"));
			gotItMAnaMsgMap.put(resultMsgGotItSet.getString("ack_by"),resultMsgGotItSet.getString("ack_by"));
			gotItMAnaMap.put(resultMsgGotItSet.getString("message_id"),gotItMAnaMsgMap);
			}else{
			HashMap gotItMAnaMsgMap = new  HashMap();
			gotItMAnaMsgMap.put(resultMsgGotItSet.getString("ack_by"),resultMsgGotItSet.getString("ack_by"));
			gotItMAnaMap.put(resultMsgGotItSet.getString("message_id"),gotItMAnaMsgMap);
			}
			}

			psMain = connection.prepareStatement("select CITY, STATE, ID, DATE_MODIFIED, LAST_MODIFIED_BY, LAST_MODIFIED_DATE, COMMENTS, TRUCKINFO, X(city_point) as city_lat, Y(city_point) as city_lng from test.maids_msg_board where company_id = ? order by DATE_MODIFIED desc");
			psMain.setString(1, uuid);
			ResultSet resultMsgSet = psMain.executeQuery();
			DateFormat formatter = new SimpleDateFormat("MM-dd-yyyy.HH.mm.ss");
			int countOfUnreadmsgs = 0;
			while (resultMsgSet.next()) {
			%>


			<% if(!gotItMMap.containsKey(resultMsgSet.getString("id"))){
							countOfUnreadmsgs = countOfUnreadmsgs + 1;

							}

						}
						%>
			<%if(countOfUnreadmsgs>0){

				   session.setAttribute("msg_count", countOfUnreadmsgs);


					}else{

					session.removeAttribute("msg_count");
					}

					%>




			<%

		 }catch (Exception ex){
		     %><%="Error Posting " + ex%><%
		     System.out.println(""+ ex);
		 }
				%>

			<%}%>
	<%}%>


