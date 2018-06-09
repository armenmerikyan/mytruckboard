<%@ page import="com.big.util.*,java.text.*,java.util.*,java.io.*,javax.xml.parsers.*,org.w3c.dom.*,java.sql.*,java.text.DateFormat" %><%
if(session.getAttribute("issubscribed")!=null && session.getAttribute("issubscribed").equals("true")){
			String uuid = (String)session.getAttribute("uuid");

			if(uuid !=null){

	
				int totalCountOpenManager = 0;
				int totalCountProcessingManager = 0;
				int totalCountClosedManager = 0;
				int totalCountArchivedManager = 0;
				int totalCountOpenSales = 0;
				int totalCountProcessingSales = 0;
				int totalCountClosedSales = 0;
				int totalCountArchivedSales = 0;
				int totalCountOpenAgent = 0;
				int totalCountProcessingAgent = 0;
				int totalCountClosedAgent = 0;
				int totalCountArchivedAgent = 0;
		
	         try{
				Class.forName("com.mysql.jdbc.Driver");
				String url = "jdbc:mysql://localhost/test?zeroDateTimeBehavior=convertToNull";
				Connection connection = DriverManager.getConnection(url,"<USERNAME>", "<PASSWORD>");						
				PreparedStatement psMain = connection.prepareStatement("select count(load_board_id) as itemCount from test.load_board WHERE load_board.COMPANY_ID = ? and (load_status_manager= 'Open' or load_status_manager is null)");
				psMain.setString(1, uuid);
				ResultSet resultSet = psMain.executeQuery();
				while (resultSet.next()) {
					totalCountOpenManager = resultSet.getInt("itemCount");
				}
				psMain = connection.prepareStatement("select count(load_board_id) as itemCount from test.load_board WHERE load_board.COMPANY_ID = ? and load_status_manager= 'Processing'");
				psMain.setString(1, uuid);
				resultSet = psMain.executeQuery();
				while (resultSet.next()) {
					totalCountProcessingManager = resultSet.getInt("itemCount");
				}
				psMain = connection.prepareStatement("select count(load_board_id) as itemCount from test.load_board WHERE load_board.COMPANY_ID = ? and load_status_manager= 'Closed'");
				psMain.setString(1, uuid);
				resultSet = psMain.executeQuery();
				while (resultSet.next()) {
					totalCountClosedManager = resultSet.getInt("itemCount");
				}
				psMain = connection.prepareStatement("select count(load_board_id) as itemCount from test.load_board WHERE load_board.COMPANY_ID = ? and load_status_manager= 'Archived'");
				psMain.setString(1, uuid);
				resultSet = psMain.executeQuery();
				while (resultSet.next()) {
					totalCountArchivedManager = resultSet.getInt("itemCount");
				}
				
				psMain = connection.prepareStatement("select count(load_board_id) as itemCount from test.load_board WHERE load_board.COMPANY_ID = ? and (load_status_sales= 'Open' or load_status_sales is null)");
				psMain.setString(1, uuid);
				resultSet = psMain.executeQuery();
				while (resultSet.next()) {
					totalCountOpenSales = resultSet.getInt("itemCount");
				}
				psMain = connection.prepareStatement("select count(load_board_id) as itemCount from test.load_board WHERE load_board.COMPANY_ID = ? and load_status_sales= 'Processing'");
				psMain.setString(1, uuid);
				resultSet = psMain.executeQuery();
				while (resultSet.next()) {
					totalCountProcessingSales = resultSet.getInt("itemCount");
				}
				psMain = connection.prepareStatement("select count(load_board_id) as itemCount from test.load_board WHERE load_board.COMPANY_ID = ? and load_status_sales= 'Closed'");
				psMain.setString(1, uuid);
				resultSet = psMain.executeQuery();
				while (resultSet.next()) {
					totalCountClosedSales = resultSet.getInt("itemCount");
				}
				psMain = connection.prepareStatement("select count(load_board_id) as itemCount from test.load_board WHERE load_board.COMPANY_ID = ? and load_status_sales= 'Archived'");
				psMain.setString(1, uuid);
				resultSet = psMain.executeQuery();
				while (resultSet.next()) {
					totalCountArchivedSales = resultSet.getInt("itemCount");
				}
				
				psMain = connection.prepareStatement("select count(load_board_id) as itemCount from test.load_board WHERE load_board.COMPANY_ID = ? and (load_status_agent= 'Open' or load_status_agent is null)");
				psMain.setString(1, uuid);
				resultSet = psMain.executeQuery();
				while (resultSet.next()) {
					totalCountOpenAgent = resultSet.getInt("itemCount");
				}
				psMain = connection.prepareStatement("select count(load_board_id) as itemCount from test.load_board WHERE load_board.COMPANY_ID = ? and load_status_agent= 'Processing'");
				psMain.setString(1, uuid);
				resultSet = psMain.executeQuery();
				while (resultSet.next()) {
					totalCountProcessingAgent = resultSet.getInt("itemCount");
				}
				psMain = connection.prepareStatement("select count(load_board_id) as itemCount from test.load_board WHERE load_board.COMPANY_ID = ? and load_status_agent= 'Closed'");
				psMain.setString(1, uuid);
				resultSet = psMain.executeQuery();
				while (resultSet.next()) {
					totalCountClosedAgent = resultSet.getInt("itemCount");
				}
				psMain = connection.prepareStatement("select count(load_board_id) as itemCount from test.load_board WHERE load_board.COMPANY_ID = ? and load_status_agent= 'Archived'");
				psMain.setString(1, uuid);
				resultSet = psMain.executeQuery();
				while (resultSet.next()) {
					totalCountArchivedAgent = resultSet.getInt("itemCount");
				}
			%>Start<ITEM><%=totalCountOpenManager%><ITEM><%=totalCountProcessingManager%><ITEM><%=totalCountClosedManager%><ITEM><%=totalCountArchivedManager%><ITEM><%=totalCountOpenSales%><ITEM><%=totalCountProcessingSales%><ITEM><%=totalCountClosedSales%><ITEM><%=totalCountArchivedSales%><ITEM><%=totalCountOpenAgent%><ITEM><%=totalCountProcessingAgent%><ITEM><%=totalCountClosedAgent%><ITEM><%=totalCountArchivedAgent%><ITEM>Done<%
			connection.close();
	         }catch (Exception ex){
	             %><%=" " + ex %><%
	         }	
	         }}%>