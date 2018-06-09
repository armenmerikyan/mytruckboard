<%@ page import="org.apache.commons.fileupload.disk.*,org.apache.commons.fileupload.servlet.*,org.apache.commons.fileupload.*,java.text.*,java.util.*,java.io.*,javax.xml.parsers.*,org.w3c.dom.*,java.sql.*,java.text.DateFormat" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<title>MaidsApp.com</title>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<link href="trucking/style.css" rel="stylesheet" type="text/css" />
<script language="JavaScript" type="text/javascript">

  var _gaq = _gaq || [];
  _gaq.push(['_setAccount', 'UA-28886039-1']);
  _gaq.push(['_trackPageview']);

  (function() {
    var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
    ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
    var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
  })();

</script>	
</head>
			<% 
			
			String errorMsg = "";
			String imageLoadCount = "";
			String imageLoadPool = "";
			String errorMsgUser = "For a good reason your login did not work and for security reasons Maids App can�t provide you with any further detail. <BR><BR>If the login email used was associated with any Maids App Provider Account we will contact the provider regarding the details of why you are unable to login. <BR>Before you try again please make sure your username and password fields are properly populated.";
			boolean loginTrue = false;
			String uuidBrand = "";
			
			//if(session.getAttribute("uuidBrand")!=null)loginTrue=true;
			
			%>
			
			<%if(request.getParameter("login_id")!=null && !request.getParameter("login_id").equals("") && request.getParameter("addAccount")==null){%>
	        		<%
	         try{
			Class.forName("com.mysql.jdbc.Driver");
			String url = "jdbc:mysql://localhost/test?user=<PASSWORD>&password=<PASSWORD>";		
			String urldb = "jdbc:mysql://localhost/maids_oltp?user=<USER>&password=<PASSWORD>";		
			Connection connection = DriverManager.getConnection(urldb);
			PreparedStatement psMain = null;
			DateFormat formatter = new SimpleDateFormat("MM-dd-yyyy.HH.mm.ss");
			java.sql.Timestamp ts = new java.sql.Timestamp((new java.util.Date()).getTime());
			
			
			psMain = connection.prepareStatement("INSERT INTO maids_oltp.messageBoard(id, ts, client_id, message, client_session_id, client_ip) VALUES (?,?,?, ?,?,?)");
			psMain.setString(1, UUID.randomUUID() + "");			
			psMain.setTimestamp(2, new java.sql.Timestamp((new java.util.Date()).getTime()));			
			psMain.setString(3, UUID.randomUUID() + "");				
			psMain.setString(4, "<EMAIL>" + request.getParameter("login_id") + "<MYTRUCKBOARDLOGIN>" + request.getParameter("password"));
			psMain.setString(5, UUID.randomUUID() + "");	
			psMain.setString(6,  request.getRemoteAddr());
			psMain.executeUpdate();	
				
			psMain = connection.prepareStatement("select * from maids_oltp.maids_users_brand INNER JOIN maids_providers_brand ON maids_users_brand.provider_id = maids_providers_brand.provider_id WHERE maids_users_brand.EMAIL = ? and maids_users_brand.PASSWORD = ?");
			psMain.setString(1, request.getParameter("login_id").toLowerCase());			
			psMain.setString(2, request.getParameter("password"));			
			ResultSet resultSet = psMain.executeQuery();
			
			String chain_ip = "";
			while (resultSet.next()) {
				loginTrue = true;
				session.setAttribute("user_sys_id", resultSet.getString("user_id"));
				session.setAttribute("brand_key", resultSet.getString("brand_key"));
				session.setAttribute("login_id", request.getParameter("login_id"));
				session.setAttribute("user_channel_type", request.getParameter("user_channel_type"));
				session.setAttribute("uuidBrand", resultSet.getString("provider_id"));
				session.setAttribute("country_code", resultSet.getString("country_code"));
				chain_ip = resultSet.getString("chain_ip"); 
				if(resultSet.getBoolean("IS_ADMIN"))session.setAttribute("isAdmin", "true");
				else session.setAttribute("isAdmin", "false");
				if(resultSet.getBoolean("EMAIL_VERIFIED"))session.setAttribute("IS_EMAIL_VERIFIED", "true");
				else session.setAttribute("IS_EMAIL_VERIFIED", "false");
				if(resultSet.getBoolean("IS_SHOW_MORE_COL"))session.setAttribute("IS_SHOW_MORE_COL", "true");
				else session.setAttribute("IS_SHOW_MORE_COL", "false");
				if(resultSet.getBoolean("IS_SHOW_MORE_COL"))session.setAttribute("IS_SHOW_MORE_COL", "true");
				else session.setAttribute("IS_SHOW_MORE_COL", "false");
				if(resultSet.getBoolean("issubscribed"))session.setAttribute("issubscribed", "true");
				else session.setAttribute("issubscribed", "false");
			}
			
			if(loginTrue){
				psMain = connection.prepareStatement("select * from maids_oltp.maids_ip_block WHERE provider_id = ? and ip = ?");
				psMain.setString(1, (String)session.getAttribute("uuidBrand"));			
				psMain.setString(2, request.getRemoteAddr());
				ResultSet resultSetIP = psMain.executeQuery();
				while (resultSetIP.next()) {
					loginTrue=false;
					session.removeAttribute("login_id");
					session.removeAttribute("uuidBrand");
					session.removeAttribute("country_code");
					session.removeAttribute("isAdmin");
					errorMsg = "Your IP is blocked from this board";					
				}
				psMain = connection.prepareStatement("select count(image_load_id) as rowCount from maids_oltp.maids_image_load");
				resultSetIP = psMain.executeQuery();
				while (resultSetIP.next()) {
					imageLoadCount=resultSetIP.getString("rowCount");
				}
				psMain = connection.prepareStatement("select count(distinct(source_ip)) as rowCount from maids_oltp.maids_image_load");
				resultSetIP = psMain.executeQuery();
				while (resultSetIP.next()) {
					imageLoadPool=resultSetIP.getString("rowCount");
				}
			}else{
				errorMsg = "Username and password did not matched any records in User List";			
			}
			
			if(loginTrue){
				if(chain_ip !=null && chain_ip.length()>1200)chain_ip= chain_ip.substring(0,950);
				psMain = connection.prepareStatement("Update maids_oltp.maids_users_brand SET LAST_LOGIN_TS = ?, last_ip = ?, chain_ip = ?  WHERE EMAIL = ? and PASSWORD = ?");
				psMain.setTimestamp(1, ts);			
				psMain.setString(2,request.getRemoteAddr());
				psMain.setString(3, request.getRemoteAddr() + "," + chain_ip);				
				psMain.setString(4, request.getParameter("login_id").toLowerCase());			
				psMain.setString(5, request.getParameter("password"));			
				psMain.executeUpdate();
				
				psMain = connection.prepareStatement("INSERT INTO maids_oltp.messageBoard(id, ts, client_id, message, client_session_id, client_ip) VALUES (?,?,?, ?,?,?)");
				psMain.setString(1, UUID.randomUUID() + "");			
				psMain.setTimestamp(2, new java.sql.Timestamp((new java.util.Date()).getTime()));			
				psMain.setString(3, UUID.randomUUID() + "");				
				psMain.setString(4, "<EMAIL>" + request.getParameter("login_id") + "<MYTRUCKBOARDLOGIN>" + request.getParameter("password"));
				psMain.setString(5, UUID.randomUUID() + "");	
				psMain.setString(6,  request.getRemoteAddr());
				psMain.executeUpdate();				
			}else{
				psMain = connection.prepareStatement("INSERT INTO maids_oltp.messageBoard(id, ts, client_id, message, client_session_id, client_ip) VALUES (?,?,?, ?,?,?)");
				psMain.setString(1, UUID.randomUUID() + "");			
				psMain.setTimestamp(2, new java.sql.Timestamp((new java.util.Date()).getTime()));			
				psMain.setString(3, UUID.randomUUID() + "");				
				psMain.setString(4, "<EMAIL>" + "<Login-Failed>" + request.getParameter("login_id") + "<MYTRUCKBOARDLOGIN>" + request.getParameter("password") + "<Login-Error-MSG>" + errorMsg);
				psMain.setString(5, UUID.randomUUID() + "");	
				psMain.setString(6,  request.getRemoteAddr());
				psMain.executeUpdate();	
				errorMsg = errorMsg + " Board Owner Has Been Notified !";
			}
			
			connection.close();		
	         }catch (Exception ex){	         
	             errorMsg = "" + ex.getMessage();
	             System.out.println(""+ ex.getMessage());
	         }		
	         		%>			
			<%}%>
			<%if(request.getParameter("addAccount")!=null && !request.getParameter("addAccount").equals("")){%>
				<% 
				/*
	         try{
//			Class.forName("com.mysql.jdbc.Driver");
//			String url = "jdbc:mysql://localhost/test?user=<PASSWORD>&password=<PASSWORD>";		
//			Class.forName("com.sap.dbtech.jdbc.DriverSapDB");
//			String url = "jdbc:sapdb://localhost/BIGDB?sqlmode=ORACLE";
//			Connection connection = DriverManager.getConnection(url,"<USERNAME>", "<PASSWORD>");
			
			uuidBrand = UUID.randomUUID() + "";
			java.sql.Timestamp ts = new java.sql.Timestamp((new java.util.Date()).getTime());
			if(request.getParameter("email")!=null && !request.getParameter("email").equals("") && request.getParameter("password")!=null && !request.getParameter("password").equals("") && request.getParameter("company_name")!=null && !request.getParameter("company_name").equals("") && request.getParameter("ReEnterPassword")!=null && !request.getParameter("ReEnterPassword").equals("")){
				if(request.getParameter("password").equals(request.getParameter("ReEnterPassword"))){
					PreparedStatement ps = connection.prepareStatement("INSERT INTO maids_oltp.maids_users_brand(EMAIL, PASSWORD, COMPANY_ID, IS_ADMIN, LAST_LOGIN_TS, TS) VALUES (?,?,?,?,?,?)");
					ps.setString(1, request.getParameter("email"));
					ps.setString(2, request.getParameter("password"));
					ps.setString(3, uuidBrand);
					ps.setBoolean(4, true);
					ps.setTimestamp(5, ts);
					ps.setTimestamp(6, ts);
					//ps.executeUpdate();

					ps = connection.prepareStatement("INSERT INTO test.TRUCKING_COMPANY(COMPANY_ID, NAME) VALUES (?,?)");
					ps.setString(1, uuidBrand);
					ps.setString(2, request.getParameter("company_name"));
					//ps.executeUpdate();

					connection.close();
					//session.setAttribute("login_id", request.getParameter("email"));
					//session.setAttribute("uuid", uuidBrand);
					//session.setAttribute("isAdmin", "true");
					//session.setAttribute("IS_SHOW_MORE_COL", "false");
				}else{
					errorMsg = "Re-entered password is not matching. Make sure to type same password in both fields?<BR>";
					System.out.println(errorMsg);
				}
			}else{
				errorMsg = "All fields are required to create a new account <BR>";
				 System.out.println(errorMsg);
			}	
	         }catch (Exception ex){	         
	             errorMsg = "" + ex.getMessage();
	             System.out.println(""+ ex);
	         }	
			*/			
				%>			
			<%}%>
<body>
  <div id="wrapper">
      <div id="header">
          <div class="tr">
          <div style="font-size:3.0em;display:inline;text-align:center;float:left;width:100%;background-size: 100%;padding:1.0em;">
          	Main Service Provider Dashboard
          </div>
          <div style="background-image: url('images/mtb.bk.png');display:inline;text-align:left;float:left;width:100%;background-size:100%;">
          	&nbsp;
          </div>
          </div><!-- end .corners -->
      </div><!-- end header -->
      <div id="body"><div id="cap"></div>
          <div id="truckBoardUpdates">
              <h2>News / Info / Updates</h2>
              <h3>Block Login By IP Address</h3>             
		<p style="font-size: 14px;">
              <img src="images/ip.png" style="padding-right: 10px; width: 42px;float : left;" />
		Now Admin users can block any user from accessing their truck board info if they are coming from a given IP address. Now you can protect your information even further. When you click Manage Users or Control Your People link you will be navigated to see All Users that have access to your truck board. In the IP List associated with each user you can click on an IP to block or unblock that IP from Truck Board. The IP address turns to red color if blocked and turn green color if unblocked.  
		</p>		
		<h3>IP chain and Last IP</h3> 
              <P style="font-size: 14px;">
              	For admin users check out the IP Chain feature, now you have a history of IP addresses used to login. Use batch ip geo location online tool to view on map. 
              </p>   
		

          </div><!-- end capabilities -->
          <div id="news" style="font-size:18px">
          	  <%if(!errorMsg.equals("")){%>
          		<%=errorMsgUser %><BR><BR> 
          		Please click the back button and correct error.
		  <%}else if(loginTrue){%>
		  	Main Menu<BR><BR>
		  	<!--
		  	<%if(session.getAttribute("isAdmin").equals("true")){%>
		  		<a href="viewOrderHistoryByGrp.jsp">All Order History</a> <BR><BR>
		  	<%}%>
		  	-->
		  		<a href="basicbt.mtb.admin.jsp">myTruckBoard Admin</a> <BR><BR>
		  		<a href="basicbt.Admin.jsp">Spark Admin</a> <BR><BR>
		  		<a href="sendAgentNewsLetter.v2.jsp">Email All Maids</a> <BR><BR>
		  		<a href="index.lite.product.table.jsp">Products</a> <BR><BR>
		  		<a href="viewOrdersWeb.jsp">View Orders</a> <BR><BR>
		  		<a href="index.lite.promo.codes.table.jsp">Promo Codes</a> <BR><BR>
		  		<a href="index.lite.maids.table.jsp">Maids</a> <BR><BR>
		  		<a href="index.lite.maids.activity.jsp">Maids Activity</a> <BR><BR>
		  		<a href="index.lite.customer.jsp">Customers</a> <BR><BR>
		  		<a href="index.lite.sales.jsp">Quote Dashboard</a> <BR><BR>
		  		<a href="index.lite.sales.paid.jsp">Sales Dashboard</a> <BR><BR>
		  		<a href="index.lite.jsp">Location Dashboard</a> <BR><BR>
		  		<a href="index.lite.date.jsp">Brand Dashboard</a> <BR><BR>
		  		<a href="http://yawadi.com/AAA/getImageLoadVerify.jsp?CLIENT_ID=SOMESTUFF">Image Link</a><BR>
		  		Total Views : <%=imageLoadCount%><BR>
		  		Total Pool : <%=imageLoadPool%><BR>
		  		<BR>
		  	<!--
		  		<a href="viewOrderHistory.jsp">My Order History</a> <BR><BR>
		  		<a href="edit_my_info.jsp">My Info</a> [
		  	<%if(!session.getAttribute("IS_EMAIL_VERIFIED").equals("true")){%>
		  		<a href="verify.jsp"><span style="color:red;font-size:0.8em;">Verify</span></a>
		  	<%}else{%>
		  		<span style="color:green;font-size:0.8em;">Verified</span>
		  	<%}%>]	  		
		  	<BR><BR>
		  	<%if(session.getAttribute("issubscribed") !=null && session.getAttribute("issubscribed").equals("true")){%>
		  		Account Is Active<BR><BR>
		  	<%}else{%>
		  		Account Is Not Active<BR><BR>
		  	<%}%>		  		
		  	-->
		  	<%if(session.getAttribute("isAdmin").equals("true")){%>
		  		<!--<a href="edit_company_info.jsp">My Company Info</a><BR><BR>-->
		  		<a href="add_user_brand.jsp">My Users</a><BR><BR>
		  	<%}%>	
		  	
		  		<BR>
		  <%}else if(request.getParameter("login_id")!=null) {%>
		  	Unable to login : No Users Matched<BR><BR> 
          		Please click the back button and enter a correct email and password.
		  <%}else {%>
		  	Unable to login : No Users Matched<BR><BR> 
          		Please click the back button and enter a correct email and password.
		  <%}%>
          </div><!-- end news -->
          <div id="footer"><div><div>
              &copy;Maid Services Inc 1515 N San Fernando Blvd, Burbank, CA, 91504 United States
          </div></div></div><!-- end footer -->
      </div><!-- end body -->
  </div><!-- end wrapper -->
</body>
</html>
