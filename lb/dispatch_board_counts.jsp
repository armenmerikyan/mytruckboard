<%@ page import="com.big.util.*,java.text.*,java.util.*,java.io.*,javax.xml.parsers.*,org.w3c.dom.*,java.sql.*,java.text.DateFormat" %><%
if(session.getAttribute("issubscribed")!=null && session.getAttribute("issubscribed").equals("true")){
			String uuid = (String)session.getAttribute("uuid");

			if(uuid !=null){


				int totalCountPending = 0;	
				int totalCountOpen = 0;
				int totalCountRefused = 0;
				int totalCountCovered = 0;
				int totalCountDispatched = 0;
				int totalCountOnRoute = 0;
				int totalCountUnloading = 0;
				int totalCountInYard = 0;
				int totalCountDelivered = 0;	
				int totalCountCompleted = 0;
				int totalCountInvoiced = 0;
				int totalCountPaid = 0;	
				int totalCountCarrierPaymentOpen = 0;		
				int totalCountCarrierPaymentProcessing = 0;		
				int totalCountCarrierPaymentClosed = 0;		
				int totalCountCarrierPaymentArchived = 0;			
		
	         try{
				Class.forName("com.mysql.jdbc.Driver");
				String url = "jdbc:mysql://localhost/test?zeroDateTimeBehavior=convertToNull";
				Connection connection = DriverManager.getConnection(url,"<USERNAME>", "<PASSWORD>");						
				PreparedStatement psMain = connection.prepareStatement("select count(load_board_id) as itemCount from test.load_board WHERE load_board.COMPANY_ID = ? and load_status= 'Pending' and (disdetail like ? or salDetail like ? or managerID like ?)");
				psMain.setString(1, uuid);
				psMain.setString(2, "%"+(String)session.getAttribute("login_id")+"%");
				psMain.setString(3, "%"+(String)session.getAttribute("login_id")+"%");
				psMain.setString(4, "%"+(String)session.getAttribute("login_id")+"%");				
				ResultSet resultSet = psMain.executeQuery();
				while (resultSet.next()) {
					totalCountPending = resultSet.getInt("itemCount");
				}
				psMain = connection.prepareStatement("select count(load_board_id) as itemCount from test.load_board WHERE load_board.COMPANY_ID = ? and load_status= 'Open' and (disdetail like ? or salDetail like ? or managerID like ?)");
				psMain.setString(1, uuid);
				psMain.setString(2, "%"+(String)session.getAttribute("login_id")+"%");
				psMain.setString(3, "%"+(String)session.getAttribute("login_id")+"%");
				psMain.setString(4, "%"+(String)session.getAttribute("login_id")+"%");				
				resultSet = psMain.executeQuery();
				while (resultSet.next()) {
					totalCountOpen = resultSet.getInt("itemCount");
				}
				psMain = connection.prepareStatement("select count(load_board_id) as itemCount from test.load_board WHERE load_board.COMPANY_ID = ? and load_status= 'Refused' and (disdetail like ? or salDetail like ? or managerID like ?)");
				psMain.setString(1, uuid);
				psMain.setString(2, "%"+(String)session.getAttribute("login_id")+"%");
				psMain.setString(3, "%"+(String)session.getAttribute("login_id")+"%");
				psMain.setString(4, "%"+(String)session.getAttribute("login_id")+"%");				
				resultSet = psMain.executeQuery();
				while (resultSet.next()) {
					totalCountRefused = resultSet.getInt("itemCount");
				}
				psMain = connection.prepareStatement("select count(load_board_id) as itemCount from test.load_board WHERE load_board.COMPANY_ID = ? and load_status= 'Covered' and (disdetail like ? or salDetail like ? or managerID like ?)");
				psMain.setString(1, uuid);
				psMain.setString(2, "%"+(String)session.getAttribute("login_id")+"%");
				psMain.setString(3, "%"+(String)session.getAttribute("login_id")+"%");
				psMain.setString(4, "%"+(String)session.getAttribute("login_id")+"%");				
				resultSet = psMain.executeQuery();
				while (resultSet.next()) {
					totalCountCovered = resultSet.getInt("itemCount");
				}
				psMain = connection.prepareStatement("select count(load_board_id) as itemCount from test.load_board WHERE load_board.COMPANY_ID = ? and load_status= 'Dispatched' and (disdetail like ? or salDetail like ? or managerID like ?)");
				psMain.setString(1, uuid);
				psMain.setString(2, "%"+(String)session.getAttribute("login_id")+"%");
				psMain.setString(3, "%"+(String)session.getAttribute("login_id")+"%");
				psMain.setString(4, "%"+(String)session.getAttribute("login_id")+"%");				
				resultSet = psMain.executeQuery();
				while (resultSet.next()) {
					totalCountDispatched = resultSet.getInt("itemCount");
				}
				psMain = connection.prepareStatement("select count(load_board_id) as itemCount from test.load_board WHERE load_board.COMPANY_ID = ? and load_status= 'On Route' and (disdetail like ? or salDetail like ? or managerID like ?)");
				psMain.setString(1, uuid);
				psMain.setString(2, "%"+(String)session.getAttribute("login_id")+"%");
				psMain.setString(3, "%"+(String)session.getAttribute("login_id")+"%");
				psMain.setString(4, "%"+(String)session.getAttribute("login_id")+"%");				
				resultSet = psMain.executeQuery();
				while (resultSet.next()) {
					totalCountOnRoute = resultSet.getInt("itemCount");
				}
				psMain = connection.prepareStatement("select count(load_board_id) as itemCount from test.load_board WHERE load_board.COMPANY_ID = ? and load_status= 'Unloading' and (disdetail like ? or salDetail like ? or managerID like ?)");
				psMain.setString(1, uuid);
				psMain.setString(2, "%"+(String)session.getAttribute("login_id")+"%");
				psMain.setString(3, "%"+(String)session.getAttribute("login_id")+"%");
				psMain.setString(4, "%"+(String)session.getAttribute("login_id")+"%");				
				resultSet = psMain.executeQuery();
				while (resultSet.next()) {
					totalCountUnloading = resultSet.getInt("itemCount");
				}
				psMain = connection.prepareStatement("select count(load_board_id) as itemCount from test.load_board WHERE load_board.COMPANY_ID = ? and load_status= 'In yard' and (disdetail like ? or salDetail like ? or managerID like ?)");
				psMain.setString(1, uuid);
				psMain.setString(2, "%"+(String)session.getAttribute("login_id")+"%");
				psMain.setString(3, "%"+(String)session.getAttribute("login_id")+"%");
				psMain.setString(4, "%"+(String)session.getAttribute("login_id")+"%");				
				resultSet = psMain.executeQuery();
				while (resultSet.next()) {
					totalCountInYard = resultSet.getInt("itemCount");
				}
				
				psMain = connection.prepareStatement("select count(load_board_id) as itemCount from test.load_board WHERE load_board.COMPANY_ID = ? and load_status= 'Delivered' and (disdetail like ? or salDetail like ? or managerID like ?)");
				psMain.setString(1, uuid);
				psMain.setString(2, "%"+(String)session.getAttribute("login_id")+"%");
				psMain.setString(3, "%"+(String)session.getAttribute("login_id")+"%");
				psMain.setString(4, "%"+(String)session.getAttribute("login_id")+"%");				
				resultSet = psMain.executeQuery();
				while (resultSet.next()) {
					totalCountDelivered = resultSet.getInt("itemCount");
				}
				psMain = connection.prepareStatement("select count(load_board_id) as itemCount from test.load_board WHERE load_board.COMPANY_ID = ? and load_status= 'Complete' and (disdetail like ? or salDetail like ? or managerID like ?)");
				psMain.setString(1, uuid);
				psMain.setString(2, "%"+(String)session.getAttribute("login_id")+"%");
				psMain.setString(3, "%"+(String)session.getAttribute("login_id")+"%");
				psMain.setString(4, "%"+(String)session.getAttribute("login_id")+"%");				
				resultSet = psMain.executeQuery();
				while (resultSet.next()) {
					totalCountCompleted = resultSet.getInt("itemCount");
				}
				psMain = connection.prepareStatement("select count(load_board_id) as itemCount from test.load_board WHERE load_board.COMPANY_ID = ? and load_status= 'Invoiced' and (disdetail like ? or salDetail like ? or managerID like ?)");
				psMain.setString(1, uuid);
				psMain.setString(2, "%"+(String)session.getAttribute("login_id")+"%");
				psMain.setString(3, "%"+(String)session.getAttribute("login_id")+"%");
				psMain.setString(4, "%"+(String)session.getAttribute("login_id")+"%");				
				resultSet = psMain.executeQuery();
				while (resultSet.next()) {
					totalCountInvoiced = resultSet.getInt("itemCount");
				}
				psMain = connection.prepareStatement("select count(load_board_id) as itemCount from test.load_board WHERE load_board.COMPANY_ID = ? and load_status= 'Paid' and (disdetail like ? or salDetail like ? or managerID like ?)");
				psMain.setString(1, uuid);
				psMain.setString(2, "%"+(String)session.getAttribute("login_id")+"%");
				psMain.setString(3, "%"+(String)session.getAttribute("login_id")+"%");
				psMain.setString(4, "%"+(String)session.getAttribute("login_id")+"%");				
				resultSet = psMain.executeQuery();
				while (resultSet.next()) {
					totalCountPaid = resultSet.getInt("itemCount");
				}
				psMain = connection.prepareStatement("select count(load_board_id) as itemCount from test.load_board WHERE load_board.COMPANY_ID = ? and (load_status_carrier= 'Open' or load_status_carrier is null) and (disdetail like ? or salDetail like ? or managerID like ?)");
				psMain.setString(1, uuid);
				psMain.setString(2, "%"+(String)session.getAttribute("login_id")+"%");
				psMain.setString(3, "%"+(String)session.getAttribute("login_id")+"%");
				psMain.setString(4, "%"+(String)session.getAttribute("login_id")+"%");				
				resultSet = psMain.executeQuery();
				while (resultSet.next()) {
					totalCountCarrierPaymentOpen = resultSet.getInt("itemCount");
				}
				psMain = connection.prepareStatement("select count(load_board_id) as itemCount from test.load_board WHERE load_board.COMPANY_ID = ? and load_status_carrier= 'Processing' and (disdetail like ? or salDetail like ? or managerID like ?)");
				psMain.setString(1, uuid);
				psMain.setString(2, "%"+(String)session.getAttribute("login_id")+"%");
				psMain.setString(3, "%"+(String)session.getAttribute("login_id")+"%");
				psMain.setString(4, "%"+(String)session.getAttribute("login_id")+"%");				
				resultSet = psMain.executeQuery();
				while (resultSet.next()) {
					totalCountCarrierPaymentProcessing = resultSet.getInt("itemCount");
				}
				psMain = connection.prepareStatement("select count(load_board_id) as itemCount from test.load_board WHERE load_board.COMPANY_ID = ? and load_status_carrier= 'Closed' and (disdetail like ? or salDetail like ? or managerID like ?)");
				psMain.setString(1, uuid);
				psMain.setString(2, "%"+(String)session.getAttribute("login_id")+"%");
				psMain.setString(3, "%"+(String)session.getAttribute("login_id")+"%");
				psMain.setString(4, "%"+(String)session.getAttribute("login_id")+"%");				
				resultSet = psMain.executeQuery();
				while (resultSet.next()) {
					totalCountCarrierPaymentClosed = resultSet.getInt("itemCount");
				}
				psMain = connection.prepareStatement("select count(load_board_id) as itemCount from test.load_board WHERE load_board.COMPANY_ID = ? and load_status_carrier= 'Archived' and (disdetail like ? or salDetail like ? or managerID like ?)");
				psMain.setString(1, uuid);
				psMain.setString(2, "%"+(String)session.getAttribute("login_id")+"%");
				psMain.setString(3, "%"+(String)session.getAttribute("login_id")+"%");
				psMain.setString(4, "%"+(String)session.getAttribute("login_id")+"%");				
				resultSet = psMain.executeQuery();
				while (resultSet.next()) {
					totalCountCarrierPaymentArchived = resultSet.getInt("itemCount");
				}
			%>Start<ITEM><%=totalCountPending%><ITEM><%=totalCountOpen%><ITEM><%=totalCountRefused%><ITEM><%=totalCountCovered%><ITEM><%=totalCountDispatched%><ITEM><%=totalCountOnRoute%><ITEM><%=totalCountUnloading%><ITEM><%=totalCountInYard%><ITEM><%=totalCountDelivered%><ITEM><%=totalCountCompleted%><ITEM><%=totalCountInvoiced%><ITEM><%=totalCountPaid%><ITEM><%=totalCountCarrierPaymentOpen%><ITEM><%=totalCountCarrierPaymentProcessing%><ITEM><%=totalCountCarrierPaymentClosed%><ITEM><%=totalCountCarrierPaymentArchived%><ITEM>Done<%
			connection.close();
	         }catch (Exception ex){
	             %><%=" " + ex %><%
	         }	
	         }}%>