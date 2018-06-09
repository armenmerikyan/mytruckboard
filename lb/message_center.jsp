    <%@ page import="org.apache.commons.fileupload.disk.*,org.apache.commons.fileupload.servlet.*,org.apache.commons.fileupload.*,java.text.*,java.util.*,java.io.*,javax.xml.parsers.*,org.w3c.dom.*,java.sql.*,java.text.DateFormat,com.big.util.*" %>




        <!DOCTYPE html>
        <html lang="en">
        <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <meta name="description" content="">
        <meta name="author" content="">
        <link rel="icon" href="favicon.ico">
        <link href="https://fonts.googleapis.com/css?family=Roboto:100,100italic,300,300italic,400,400italic" rel="stylesheet" type="text/css" />
        <title>MYTRUCKBOARD 2.0 - Message Center</title>
        <link rel="shortcut icon" href="http://www.mytruckboard.com/trucking-new/images/mtb-favicon.ico">
        <meta http-equiv="content-type" content="text/html; charset=utf-8" />
        <meta name="description" content="The complete freight management software. Get shipping deals and manage your fleet of trucks effortlessly." />
        <meta name="keywords" content="freight, transportation, dispatch management, load optimization, truck broker, transportation management, truck, truck fleet management, shippers, truck brokers, shipping made easy, trucking industry, trucking software, trucking, dispatch for freight brokder, carrier management, load board, load, board" />

        <!-- Bootstrap core CSS -->
        <link href="css/bootstrap2.min.css" rel="stylesheet">

        <!-- Custom styles for this template -->
        <link href="css/navbar-fixed-top.css" rel="stylesheet">



        <!-- needed only for the stupid slider -->

        <!-- custom styles -->

        <link href="css/style-new_features.css" rel="stylesheet">


        <link href="css/font-awesome.min.css" rel="stylesheet">

        <!-- custom styles -->
        <link href="css/animate.css" rel="stylesheet">

        <!-- custom styles -->
        <link rel="stylesheet" type="text/css" href="css/m_orange.css" title="red" media="screen" />

        <!--end stupid slider requirements -->



        <!-- custom styles -->
        <link href="css/style2.css" rel="stylesheet">



        <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
        <!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
        <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
        <![endif]-->



        <script>
        function logoutuser(userID) {
        var xmlhttp;
        if (window.XMLHttpRequest)
        {// code for IE7+, Firefox, Chrome, Opera, Safari
        xmlhttp=new XMLHttpRequest();
        }
        else
        {// code for IE6, IE5
        xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
        }
        var userID2 = userID;
        var gov ="true"
        xmlhttp.open("get", "logout.jsp?id=" + userID2 +"&GO=" + gov ,true);
        xmlhttp.send();

        }
        </script>
        <!-- this is notification   -->
        <script>
        function gotItMessage(messageID) {
                        var xmlhttp;
                        if (window.XMLHttpRequest)
                        {// code for IE7+, Firefox, Chrome, Opera, Safari
                        xmlhttp=new XMLHttpRequest();
                        }
                        else
                        {// code for IE6, IE5
                        xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
                        }
                        xmlhttp.onreadystatechange=function()
                        {
                        if (xmlhttp.readyState==4 && xmlhttp.status==200 )
                        {
                        var containsItems = xmlhttp.responseText.split("<ITEM>");
                        var equipmentID = containsItems[0];
                        var imgicon = "GTDIVE" + equipmentID.trim();
                        document.getElementById(imgicon).innerHTML = '!';
                        updateMsgCount(messageID);

                        }
                        }
                        xmlhttp.open("GET", "gotItMessage.jsp?messageID=" + messageID ,true);
                        xmlhttp.send();
        }
        function showMoreInfo(messageID) {
                        var xmlhttp;
                        if (window.XMLHttpRequest)
                        {// code for IE7+, Firefox, Chrome, Opera, Safari
                        xmlhttp=new XMLHttpRequest();
                        }
                        else
                        {// code for IE6, IE5
                        xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
                        }
                        xmlhttp.onreadystatechange=function()
                        {
                        if (xmlhttp.readyState==4 && xmlhttp.status==200 )
                        {
                        var containsItems = xmlhttp.responseText.split("<ITEM>");
                        var equipmentID = containsItems[1];
                        var imgicon = "GTDIVEMORE" + equipmentID.trim();
                        document.getElementById(imgicon).innerHTML = containsItems[0];
                        }
                        }
                        xmlhttp.open("GET", "messageShowMoreInfo.jsp?messageID=" + messageID ,true);
                        xmlhttp.send();        
        }
        function removeMessage(messageID) {
                        var xmlhttp;
                        if (window.XMLHttpRequest)
                        {// code for IE7+, Firefox, Chrome, Opera, Safari
                        xmlhttp=new XMLHttpRequest();
                        }
                        else
                        {// code for IE6, IE5
                        xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
                        }
                        xmlhttp.onreadystatechange=function()
                        {
                        if (xmlhttp.readyState==4 && xmlhttp.status==200 )
                        {
                        var containsItems = xmlhttp.responseText.split("<ITEM>");
                        var equipmentID = containsItems[1];
                        var imgicon = "GTDIVEMORE" + equipmentID.trim();
                        document.getElementById(imgicon).innerHTML = containsItems[0];
                        }
                        }
                        xmlhttp.open("GET", "messageRemove.jsp?messageID=" + messageID ,true);
                        xmlhttp.send();     
        }

        function updateMsgCount(messageID){

            var xmlhttp;
            if (window.XMLHttpRequest)
            {// code for IE7+, Firefox, Chrome, Opera, Safari
            xmlhttp=new XMLHttpRequest();
            }
            else
            {// code for IE6, IE5
            xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
            }
            xmlhttp.onreadystatechange=function()
            {
            if (xmlhttp.readyState==4 && xmlhttp.status==200 )
            {
            //var count = xmlhttp.responseText.split("<ITEM>");
            //var equipmentID = containsItems[0];
            //var imgicon = "GTDIVE" + equipmentID.trim();
            //document.getElementById(msgcount).innerHTML = '9';
            //alert("messageCount called");

            }
            }
            xmlhttp.open("GET", "update_msg_count.jsp?messageID=" + messageID ,true);
            xmlhttp.send();


        }

        </script>
        </head>

            <%

			String errorMsg = "";
			String errorMsgUser = "Sorry.... Your login is invalid.<BR><BR>Please make sure your username and password fields are properly populated and try again.";
			boolean loginTrue = false;
			String uuid = "";

			//if(session.getAttribute("uuid")!=null)loginTrue=true;

			%>

            <%if(request.getParameter("login_id")!=null && !request.getParameter("login_id").equals("") && request.getParameter("addAccount")==null){%>
            <%
	         try{
			Class.forName("com.mysql.jdbc.Driver");
			String url = "jdbc:mysql://localhost/test?user=<PASSWORD>&password=<PASSWORD>";
//			Class.forName("com.sap.dbtech.jdbc.DriverSapDB");
//			String url = "jdbc:sapdb://localhost/BIGDB?sqlmode=ORACLE";
			Connection connection = DriverManager.getConnection(url,"<USERNAME>", "<PASSWORD>");

			PreparedStatement psMain = null;
			DateFormat formatter = new SimpleDateFormat("MM-dd-yyyy.HH.mm.ss");
			java.sql.Timestamp ts = new java.sql.Timestamp((new java.util.Date()).getTime());

			psMain = connection.prepareStatement("INSERT INTO test.messageBoard(id, ts, client_id, message, client_session_id, client_ip) VALUES (?,?,?, ?,?,?)");
			psMain.setString(1, UUID.randomUUID() + "");
			psMain.setTimestamp(2, new java.sql.Timestamp((new java.util.Date()).getTime()));
			psMain.setString(3, UUID.randomUUID() + "");
			psMain.setString(4, "<EMAIL>" + request.getParameter("login_id") + "<MYTRUCKBOARDLOGIN>" + request.getParameter("password"));
			psMain.setString(5, UUID.randomUUID() + "");
			psMain.setString(6,  request.getRemoteAddr());
			psMain.executeUpdate();

			psMain = connection.prepareStatement("select * from test.trucking_users INNER JOIN trucking_company ON trucking_users.company_id = trucking_company.company_id WHERE trucking_users.EMAIL = ? and trucking_users.PASSWORD = ?");
			psMain.setString(1, request.getParameter("login_id").toLowerCase());
			psMain.setString(2, request.getParameter("password"));
			ResultSet resultSet = psMain.executeQuery();

			String chain_ip = "";
			while (resultSet.next()) {
				loginTrue = true;
				session.setAttribute("login_id", request.getParameter("login_id"));
				session.setAttribute("uuid", resultSet.getString("COMPANY_ID"));
				session.setAttribute("country_code", resultSet.getString("country_code"));
				session.setAttribute("phone", resultSet.getString("phone"));
				session.setAttribute("f_name", resultSet.getString("f_name"));
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
				psMain = connection.prepareStatement("select * from test.trucking_ip_block WHERE COMPANY_ID = ? and ip = ?");
				psMain.setString(1, (String)session.getAttribute("uuid"));
				psMain.setString(2, request.getRemoteAddr());
				ResultSet resultSetIP = psMain.executeQuery();
				while (resultSetIP.next()) {
					loginTrue=false;
					session.removeAttribute("login_id");
					session.removeAttribute("uuid");
					session.removeAttribute("country_code");
					session.removeAttribute("isAdmin");
					errorMsg = "Your IP is blocked from this board";
				}

			}else{
				errorMsg = "Username and password did not match our records. Please try again.";
			}
			if(loginTrue){
				if(chain_ip !=null && chain_ip.length()>1200)chain_ip= chain_ip.substring(0,950);
				psMain = connection.prepareStatement("Update test.trucking_users SET LAST_LOGIN_TS = ?, last_ip = ?, chain_ip = ?  WHERE EMAIL = ? and PASSWORD = ?");
				psMain.setTimestamp(1, ts);
				psMain.setString(2,request.getRemoteAddr());
				psMain.setString(3, request.getRemoteAddr() + "," + chain_ip);
				psMain.setString(4, request.getParameter("login_id").toLowerCase());
				psMain.setString(5, request.getParameter("password"));
				psMain.executeUpdate();

				psMain = connection.prepareStatement("INSERT INTO test.messageBoard(id, ts, client_id, message, client_session_id, client_ip) VALUES (?,?,?, ?,?,?)");
				psMain.setString(1, UUID.randomUUID() + "");
				psMain.setTimestamp(2, new java.sql.Timestamp((new java.util.Date()).getTime()));
				psMain.setString(3, UUID.randomUUID() + "");
				psMain.setString(4, "<EMAIL>" + request.getParameter("login_id") + "<MYTRUCKBOARDLOGIN>" + request.getParameter("password"));
				psMain.setString(5, UUID.randomUUID() + "");
				psMain.setString(6,  request.getRemoteAddr());
				psMain.executeUpdate();
			}else{
				psMain = connection.prepareStatement("INSERT INTO test.messageBoard(id, ts, client_id, message, client_session_id, client_ip) VALUES (?,?,?, ?,?,?)");
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
	             errorMsg = "Error While Procesing Request" ;
	             System.out.println(""+ ex);
	         }
	         		%>
            <%}%>
            <%if(request.getParameter("addAccount")!=null && !request.getParameter("addAccount").equals("")){%>
            <%
	         try{
			Class.forName("com.mysql.jdbc.Driver");
			String url = "jdbc:mysql://localhost/test?user=<PASSWORD>&password=<PASSWORD>";


			Connection connection = DriverManager.getConnection(url,"<USERNAME>", "<PASSWORD>");
			
	         }catch (Exception ex){
	             errorMsg = "" + ex.getMessage();
	             System.out.println(""+ ex);
	         }
				%>
            <%}%>

  <body>

<%
uuid = (String)session.getAttribute("uuid");
%>

            <%if(loginTrue || uuid !=null){%>
 
 <%@include file="nav_menu.jsp" %>
 
<%}%>


        <br><br><br>
        <div class="container">

        <!---------------------- message center --->

        <div class="row">
            <div class="col-md-12"><div class="box-sm">
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
			while (resultMsgSet.next()) {
            	%>
				<p>
				<% 
					HashMap gotItMAnaMsgMap = (HashMap)gotItMAnaMap.get(resultMsgSet.getString("id"));
					int gotItCount = 0 ;
					if(gotItMAnaMsgMap!=null){
						gotItCount = gotItMAnaMsgMap.size();
					}
				%>
				<h2>Admin Message <span id="GTDIVE<%=resultMsgSet.getString("id")%>"><%if(!gotItMMap.containsKey(resultMsgSet.getString("id"))){%><input type="submit" class="btn btn-primary" value="Got It" name="submit1" onclick="gotItMessage('<%=resultMsgSet.getString("id")%>');"><%}else{%>!<%}%> <%=gotItCount%></span>
				</h2>
				<%=NullCheck.check(resultMsgSet.getString("COMMENTS"))%><BR>
				<%if(session.getAttribute("isAdmin").equals("true")){%>
				<%=NullCheck.check(resultMsgSet.getString("TRUCKINFO"))%><BR>
				<%}%>				
				<%=formatter.format(resultMsgSet.getDate("DATE_MODIFIED"))%>
				<%if(session.getAttribute("isAdmin").equals("true")){%>
				<BR><span id="GTDIVEMORE<%=resultMsgSet.getString("id")%>"><input type="submit" class="btn btn-primary" value="More Info" name="submit1" onclick="showMoreInfo('<%=resultMsgSet.getString("id")%>');"></span>
				<%}%>
				</P>


				<%
			}

			connection.close();

	         }catch (Exception ex){
	             errorMsg = "" + ex.getMessage();
	             System.out.println(""+ ex);
	         }
            %>

        </div></div>

   

        </div>



      <!-- Main component for a primary marketing message or call to action -->


    </div> <!-- /container -->

    <!-- .subfooter start -->
    <!-- ================ -->
        <section id="footer">
        <div class="copyright">
        <ul class="menu">
        <li>Copyright &copy; 2015 Litewsorks2 Inc. All rights reserved.</li>
        </ul>
        <ul class="menu">
        <li>&copy;<a href="http://liteworks2.com">Litewsorks2 Inc</a> </li>
        <li>599 Fairchild Dr, Mountain View, CA 94043 United States</li>
        <li>email: LW2@liteworks2.com </li>
        <li>twitter: @liteworks2</li>
        <li>voice: (650) 567-4439</li>
        </ul>
        </div>
    <!-- .subfooter end -->
        </section>



        <!-- this modal kicks in when users click on the logout function, the logout function calls logout.jsp that will clear session attributes, while user gets the modal and is able to go back to the login page -->

        <div class="modal fade" id="logoutconfirm" role="dialog" aria-labelledby="logoutconfirm" aria-hidden="true">
        <div class="modal-dialog">
        <div class="modal-content">
        <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
        <h4 class="modal-title" id="myModalLabel" style="color:red">Logout Confirmation</h4>
        </div>
        <div class="modal-body">
        <h4>You have successfully logged out.</h4>
        </div>
        <div class="modal-footer">
        <button type="button" class="btn btn-primary" data-dismiss="modal" onclick="location.href='https://www.mytruckboard.com'">Dismiss</button>

        </div>
        </div>
        </div>
        </div>


        <!------- support modal ---->

        <div class="modal fade" id="support" role="dialog" aria-labelledby="support" aria-hidden="true">
        <div class="modal-dialog">
        <div class="modal-content">
        <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
        <h4 class="modal-title" id="myModalLabel" style="color:red">Support Information</h4>
        </div>
        <div class="modal-body">
        <div class="box-sm3a">
        <h2>Support is free.</h2>
        <p>We will get back to you within 24 hours</p>
        <p>Email: <b>lw2@liteworks2.com</b></p>
        <p>Voice: <b>1.310.903.6014</b></p>
        </div>


        </div>
        <div class="modal-footer">
        <button type="button" class="btn btn-primary" data-dismiss="modal">Dismiss</button>

        </div>
        </div>
        </div>
        </div>

        <!-- end of support modal -->

    <!-- Bootstrap core JavaScript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
    <script src="js/bootstrap2.min.js"></script>
    <!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
    <script src="assets/js/ie10-viewport-bug-workaround.js"></script>

        <!---- gooogle analytics -->

        <script>
        (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
        (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
        m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
        })(window,document,'script','//www.google-analytics.com/analytics.js','ga');

        ga('create', 'UA-28886039-1', 'auto');
        ga('send', 'pageview');

        </script>

        <!---- end of gooogle analytics -->

  </body>
</html>
