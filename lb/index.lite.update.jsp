<%@ page import="com.big.util.*,java.text.*,java.util.*,java.io.*,javax.xml.parsers.*,org.w3c.dom.*,java.sql.*,java.text.DateFormat" %>			
<%
	try{
			String uuid = (String)session.getAttribute("uuid");
if(session.getAttribute("issubscribed")!=null && session.getAttribute("issubscribed").equals("true") && uuid !=null){	
		Class.forName("com.mysql.jdbc.Driver");
		String url = "jdbc:mysql://localhost/test?zeroDateTimeBehavior=convertToNull";		
		Connection connection = DriverManager.getConnection(url,"<USERNAME>", "<PASSWORD>");			
		PreparedStatement psMain = null;
		System.out.println("INDEX UPDATE : " + request.getParameter("timestamp"));
		DateFormat formatter = new SimpleDateFormat("MM/dd/yyyy.HH.mm.ss");
		java.sql.Date start = new java.sql.Date(((java.util.Date)formatter.parse(request.getParameter("timestamp"))).getTime());
		psMain = connection.prepareStatement("select * from test.trucking_msg_board_update where ts > ? and company_id = ? order by ts desc");
		psMain.setTimestamp(1, new java.sql.Timestamp(start.getTime()));			
		psMain.setString(2,uuid);
		ResultSet resultSet = psMain.executeQuery();			
		while (resultSet.next()) {
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
			formatter = new SimpleDateFormat("MM-dd-yyyy.HH.mm.ss");
			int countOfUnreadmsgs = 0;
			while (resultMsgSet.next()) {
				%>


            			<% if(!gotItMMap.containsKey(resultMsgSet.getString("id"))){
					countOfUnreadmsgs = countOfUnreadmsgs + 1;

				}

			}
				%>
			    <%if(countOfUnreadmsgs>0){
					%><BR><UPDATELIST><%
			   session.setAttribute("msg_count", countOfUnreadmsgs);

			    }else{

			    session.removeAttribute("msg_count");
			    }
		}	
			connection.close();

	%>
			
	<%}else{%>
		<a href="http://www.myTruckBoard.com">Account is not Active : Reason None Payment</a><BR>
		It may take from 30 minutes to 24 hours to restore the account after payment<BR>
	<%}%>
	<%				
	         }catch (Exception ex){	         
	             %><font color="#FF0000"><%="Error Posting " + ex%></font><%  
	             System.out.println(""+ ex);
	         }		        	
%>	

	        	