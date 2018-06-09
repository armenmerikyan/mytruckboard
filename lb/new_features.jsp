<%@ page import="org.apache.commons.fileupload.disk.*,org.apache.commons.fileupload.servlet.*,org.apache.commons.fileupload.*,java.text.*,java.util.*,java.io.*,javax.xml.parsers.*,org.w3c.dom.*,java.sql.*,java.text.DateFormat,com.big.util.*" %>
<%
    Enumeration requestParameters = request.getParameterNames();

    while (requestParameters.hasMoreElements()) {
        String element = (String) requestParameters.nextElement();
        String value = request.getParameter(element);
        System.out.println("element " + element + " value " + value);
        if(value.contains(new StringBuilder().append("").append('\'').toString())
        || value.contains(new StringBuilder().append("").append('\"').toString())
        || value.contains(new StringBuilder().append("").append('\b').toString())
        || value.contains(new StringBuilder().append("").append('\n').toString())
        || value.contains(new StringBuilder().append("").append('\r').toString())
        || value.contains(new StringBuilder().append("").append('\t').toString())
        || value.contains(new StringBuilder().append("").append('\\').toString())
        || value.toUpperCase().contains("SELECT")
        || value.toUpperCase().contains("UPDATE")
        || value.toUpperCase().contains("DELETE")
        || value.toUpperCase().contains("DROP")
        || value.toUpperCase().contains("INSERT")
        || value.toUpperCase().contains("*")
        || value.toUpperCase().contains("$")
        ){
	        System.out.println(" SQL INJECTION ERROR :::: element " + element + " value " + value);   
	        
				response.sendRedirect("https://mytruckboard.com/mytruckboard/errorRequest.html");
        }
    }	        
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">
    <link rel="icon" href="favicon.ico">
    <link href="https://fonts.googleapis.com/css?family=Roboto:100,100italic,300,300italic,400,400italic"
          rel="stylesheet" type="text/css"/>
    <title>MYTRUCKBOARD 2.0 - Dashboard - What's New</title>
    <link rel="shortcut icon" href="http://www.mytruckboard.com/trucking-new/images/mtb-favicon.ico">
    <meta http-equiv="content-type" content="text/html; charset=utf-8"/>
    <meta name="description"
          content="The complete freight management software. Get shipping deals and manage your fleet of trucks effortlessly."/>
    <meta name="keywords"
          content="freight, transportation, dispatch management, load optimization, truck broker, transportation management, truck, truck fleet management, shippers, truck brokers, shipping made easy, trucking industry, trucking software, trucking, dispatch for freight brokder, carrier management, load board, load, board"/>

    <!-- Bootstrap core CSS -->
    <link href="css/bootstrap2.min.css" rel="stylesheet">

    <!-- Custom styles for this template -->
    <link href="css/navbar-fixed-top.css" rel="stylesheet">


    <!-- required for modal -->

    <script type="text/javascript" src="js/jquery-2.1.3.min.js"></script>


    <!-- needed only for the stupid slider -->

    <!-- custom styles -->

    <link href="css/style-new_features.css" rel="stylesheet">


    <link href="css/font-awesome.min.css" rel="stylesheet">

    <!-- custom styles -->
    <link href="css/animate.css" rel="stylesheet">

    <!-- custom styles -->
    <link rel="stylesheet" type="text/css" href="css/m_orange.css" title="red" media="screen"/>

    <!--end stupid slider requirements -->


    <!-- custom styles -->
    <link href="css/style2.css" rel="stylesheet">

    <link rel="stylesheet" href="css/navstyle2.css"/>


    <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
    <!--[if lt IE 9]>
    <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
    <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->


    <script>
        function logoutuser(userID) {
            var xmlhttp;
            if (window.XMLHttpRequest) {// code for IE7+, Firefox, Chrome, Opera, Safari
                xmlhttp = new XMLHttpRequest();
            }
            else {// code for IE6, IE5
                xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
            }
            var userID2 = userID;
            var gov = "true"
            xmlhttp.open("get", "logout.jsp?id=" + userID2 + "&GO=" + gov, true);
            xmlhttp.send();

        }
    </script>
    <!-- this is notification   -->
    <script>
        function gotItMessageShow() {
            //alert('Test');
            $('#myModal').modal({
                show: 'false'
            });
        }
    </script>
    <script>
        var howOften = 12;
        var doneSetup = 0;
        function rotater() {
            setTimeout("rotater()", howOften * 100);
            partialSearch();
//        alert(document.getElementById("embeddedDateField").value);
//	alert('Hello Tick');
        }
        //window.onload=rotater;
    </script>
    <script type="text/javascript">
        var urlStringPrev = "";
        var urlPingStatus = 0;
        function partialSearch() {
            var xmlhttp;
            if (window.XMLHttpRequest) {// code for IE7+, Firefox, Chrome, Opera, Safari
                xmlhttp = new XMLHttpRequest();
            }
            else {// code for IE6, IE5
                xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
            }
            xmlhttp.onreadystatechange = function () {
                if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
                    var containsUpdate = xmlhttp.responseText.split("<UPDATELIST>");
                    if (containsUpdate.length > 1) {
                        gotItMessageShow();
                    } else {
//	  				document.getElementById("pubFormResultsDiv").innerHTML = xmlhttp.responseText;
                    }
                    urlPingStatus = 0;
                }
            }
            var urlString = "?";
            var formF = document.getElementsByTagName("input");
            for (var j = 0; j < formF.length; j++) {
//  					alert(formF.type);
//  					var checkedSts = getRadioCheckedValue(formF[j].name);
                if (formF[j].type == "radio") {
                    if (formF[j].checked) {
                        urlString = urlString + "&" + formF[j].name + "=" + encodeURIComponent(formF[j].value);
                    }
                } else {
                    if (formF[j].name != "timestamp") {
                        urlString = urlString + "&" + formF[j].name + "=" + encodeURIComponent(formF[j].value);
                    }
                }
            }

            if (urlPingStatus == 5 && document.getElementById("timestamp") != null) {
                urlPingStatus = urlPingStatus + 1;
                urlString = urlString + "&timestamp=" + document.getElementById("timestamp").value;
                xmlhttp.open("GET", "index.lite.update.jsp" + urlString, true);
                xmlhttp.send();
            } else {
                urlPingStatus = urlPingStatus + 1;
            }
        }
    </script>
    <script>
        function gotItMessage(messageID) {
            var xmlhttp;
            if (window.XMLHttpRequest) {// code for IE7+, Firefox, Chrome, Opera, Safari
                xmlhttp = new XMLHttpRequest();
            }
            else {// code for IE6, IE5
                xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
            }
            xmlhttp.onreadystatechange = function () {
                if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
                    var containsItems = xmlhttp.responseText.split("<ITEM>");
                    var equipmentID = containsItems[0];
                    var imgicon = "GTDIVE" + equipmentID.trim();
                    document.getElementById(imgicon).innerHTML = '!';
                }
            }
            xmlhttp.open("GET", "gotItMessage.jsp?messageID=" + messageID, true);
            xmlhttp.send();
        }
        function showMoreInfo(messageID) {
            var xmlhttp;
            if (window.XMLHttpRequest) {// code for IE7+, Firefox, Chrome, Opera, Safari
                xmlhttp = new XMLHttpRequest();
            }
            else {// code for IE6, IE5
                xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
            }
            xmlhttp.onreadystatechange = function () {
                if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
                    var containsItems = xmlhttp.responseText.split("<ITEM>");
                    var equipmentID = containsItems[1];
                    var imgicon = "GTDIVEMORE" + equipmentID.trim();
                    document.getElementById(imgicon).innerHTML = containsItems[0];
                }
            }
            xmlhttp.open("GET", "messageShowMoreInfo.jsp?messageID=" + messageID, true);
            xmlhttp.send();
        }
        function removeMessage(messageID) {
            var xmlhttp;
            if (window.XMLHttpRequest) {// code for IE7+, Firefox, Chrome, Opera, Safari
                xmlhttp = new XMLHttpRequest();
            }
            else {// code for IE6, IE5
                xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
            }
            xmlhttp.onreadystatechange = function () {
                if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
                    var containsItems = xmlhttp.responseText.split("<ITEM>");
                    var equipmentID = containsItems[1];
                    var imgicon = "GTDIVEMORE" + equipmentID.trim();
                    document.getElementById(imgicon).innerHTML = containsItems[0];
                }
            }
            xmlhttp.open("GET", "messageRemove.jsp?messageID=" + messageID, true);
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

<%if (request.getParameter("login_id") != null && !request.getParameter("login_id").equals("") && request.getParameter("addAccount") == null) {%>
<%
    try {
        Class.forName("com.mysql.jdbc.Driver");
        String url = "jdbc:mysql://localhost/test?user=<PASSWORD>&password=<PASSWORD>";
//			Class.forName("com.sap.dbtech.jdbc.DriverSapDB");
//			String url = "jdbc:sapdb://localhost/BIGDB?sqlmode=ORACLE";
        Connection connection = DriverManager.getConnection(url, "<USERNAME>", "<PASSWORD>");

        PreparedStatement psMain = null;
        DateFormat formatter = new SimpleDateFormat("MM-dd-yyyy.HH.mm.ss");
        java.sql.Timestamp ts = new java.sql.Timestamp((new java.util.Date()).getTime());

        psMain = connection.prepareStatement("INSERT INTO test.messageBoard(id, ts, client_id, message, client_session_id, client_ip) VALUES (?,?,?, ?,?,?)");
        psMain.setString(1, UUID.randomUUID() + "");
        psMain.setTimestamp(2, new java.sql.Timestamp((new java.util.Date()).getTime()));
        psMain.setString(3, UUID.randomUUID() + "");
        psMain.setString(4, "<EMAIL>" + request.getParameter("login_id") + "<MYTRUCKBOARDLOGIN>" + request.getParameter("password"));
        psMain.setString(5, UUID.randomUUID() + "");
        psMain.setString(6, request.getRemoteAddr());
        psMain.executeUpdate();

        psMain = connection.prepareStatement("select * from test.TRUCKING_USERS INNER JOIN TRUCKING_COMPANY ON TRUCKING_USERS.COMPANY_ID = TRUCKING_COMPANY.COMPANY_ID WHERE TRUCKING_USERS.EMAIL = ? and TRUCKING_USERS.PASSWORD = ? and TRUCKING_USERS.is_online = 1");
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
            if (resultSet.getString("smsPhone") != null)
                session.setAttribute("smsPhone", resultSet.getString("smsPhone"));
            else session.setAttribute("smsPhone", "Not Active");
            chain_ip = resultSet.getString("chain_ip");
            if (resultSet.getBoolean("isAd_account_only")) session.setAttribute("isAd_account_only", "true");
            else session.setAttribute("isAd_account_only", "false");
            if (resultSet.getBoolean("IS_ADMIN")) session.setAttribute("isAdmin", "true");
            else session.setAttribute("isAdmin", "false");
            if (resultSet.getBoolean("EMAIL_VERIFIED")) session.setAttribute("IS_EMAIL_VERIFIED", "true");
            else session.setAttribute("IS_EMAIL_VERIFIED", "false");
            if (resultSet.getBoolean("IS_SHOW_MORE_COL")) session.setAttribute("IS_SHOW_MORE_COL", "true");
            else session.setAttribute("IS_SHOW_MORE_COL", "false");
            if (resultSet.getBoolean("IS_SHOW_MORE_COL")) session.setAttribute("IS_SHOW_MORE_COL", "true");
            else session.setAttribute("IS_SHOW_MORE_COL", "false");

            Integer isOnlineRegistrationOnAgentShip = (Integer) resultSet.getObject("isOnlineRegistrationOnAgentShip");
            Integer isOnlineRegistrationOnAgentTruck = (Integer) resultSet.getObject("isOnlineRegistrationOnAgentTruck");

            if (isOnlineRegistrationOnAgentShip != null && isOnlineRegistrationOnAgentShip == 1)
                session.setAttribute("isOnlineRegistrationOnAgentShip", "true");
            else session.setAttribute("isOnlineRegistrationOnAgentShip", "false");

            if (isOnlineRegistrationOnAgentTruck != null && isOnlineRegistrationOnAgentTruck == 1)
                session.setAttribute("isOnlineRegistrationOnAgentTruck", "true");
            else session.setAttribute("isOnlineRegistrationOnAgentTruck", "false");

            if (resultSet.getBoolean("issubscribed")) session.setAttribute("issubscribed", "true");
            else session.setAttribute("issubscribed", "false");
        }
        if (loginTrue) {
            psMain = connection.prepareStatement("select * from test.trucking_ip_block WHERE COMPANY_ID = ? and ip = ?");
            psMain.setString(1, (String) session.getAttribute("uuid"));
            psMain.setString(2, request.getRemoteAddr());
            ResultSet resultSetIP = psMain.executeQuery();
            while (resultSetIP.next()) {
                loginTrue = false;
                session.removeAttribute("login_id");
                session.removeAttribute("uuid");
                session.removeAttribute("country_code");
                session.removeAttribute("isAdmin");
                errorMsg = "Your IP is blocked from this board";
            }

        } else {
            errorMsg = "Username and password did not match our records. Please try again.";
        }
        if (loginTrue) {
            if (chain_ip != null && chain_ip.length() > 1200) chain_ip = chain_ip.substring(0, 950);
            psMain = connection.prepareStatement("Update test.TRUCKING_USERS SET LAST_LOGIN_TS = ?, last_ip = ?, chain_ip = ?  WHERE EMAIL = ? and PASSWORD = ?");
            psMain.setTimestamp(1, ts);
            psMain.setString(2, request.getRemoteAddr());
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
            psMain.setString(6, request.getRemoteAddr());
            psMain.executeUpdate();
        } else {
            psMain = connection.prepareStatement("INSERT INTO test.messageBoard(id, ts, client_id, message, client_session_id, client_ip) VALUES (?,?,?, ?,?,?)");
            psMain.setString(1, UUID.randomUUID() + "");
            psMain.setTimestamp(2, new java.sql.Timestamp((new java.util.Date()).getTime()));
            psMain.setString(3, UUID.randomUUID() + "");
            psMain.setString(4, "<EMAIL>" + "<Login-Failed>" + request.getParameter("login_id") + "<MYTRUCKBOARDLOGIN>" + request.getParameter("password") + "<Login-Error-MSG>" + errorMsg);
            psMain.setString(5, UUID.randomUUID() + "");
            psMain.setString(6, request.getRemoteAddr());
            psMain.executeUpdate();
            errorMsg = errorMsg + " Board Owner Has Been Notified !";
        }
        connection.close();
    } catch (Exception ex) {
        errorMsg = "Error While Procesing Request";
        System.out.println("" + ex);
    }
%>
<%}%>
<%if (request.getParameter("addAccount") != null && !request.getParameter("addAccount").equals("")) {%>
<%
    try {
        Class.forName("com.mysql.jdbc.Driver");
        String url = "jdbc:mysql://localhost/test?user=<PASSWORD>&password=<PASSWORD>";


        Connection connection = DriverManager.getConnection(url, "<USERNAME>", "<PASSWORD>");

    } catch (Exception ex) {
        errorMsg = "" + ex.getMessage();
        System.out.println("" + ex);
    }
%>
<%}%>

<body onload="rotater()">

<%
    uuid = (String) session.getAttribute("uuid");
%>

<%if (loginTrue || uuid != null) {%>

<%
    try {
        Class.forName("com.mysql.jdbc.Driver");
        String url = "jdbc:mysql://localhost/test?user=<PASSWORD>&password=<PASSWORD>";
        Connection connection = DriverManager.getConnection(url, "<USERNAME>", "<PASSWORD>");

        PreparedStatement psMain = null;
        psMain = connection.prepareStatement("select * from test.maids_msg_board_ack where ack_by = ?");
        psMain.setString(1, (String) session.getAttribute("login_id"));
        ResultSet resultMsgGotItSet = psMain.executeQuery();
        HashMap gotItMMap = new HashMap();
        HashMap gotItMAnaMap = new HashMap();
        while (resultMsgGotItSet.next()) {
            gotItMMap.put(resultMsgGotItSet.getString("message_id"), resultMsgGotItSet.getString("message_id"));
        }
        psMain = connection.prepareStatement("select * from test.maids_msg_board_ack where provider_group_id = ?");
        psMain.setString(1, uuid);
        resultMsgGotItSet = psMain.executeQuery();
        while (resultMsgGotItSet.next()) {
            if (gotItMAnaMap.containsKey(resultMsgGotItSet.getString("message_id"))) {
                HashMap gotItMAnaMsgMap = (HashMap) gotItMAnaMap.get(resultMsgGotItSet.getString("message_id"));
                gotItMAnaMsgMap.put(resultMsgGotItSet.getString("ack_by"), resultMsgGotItSet.getString("ack_by"));
                gotItMAnaMap.put(resultMsgGotItSet.getString("message_id"), gotItMAnaMsgMap);
            } else {
                HashMap gotItMAnaMsgMap = new HashMap();
                gotItMAnaMsgMap.put(resultMsgGotItSet.getString("ack_by"), resultMsgGotItSet.getString("ack_by"));
                gotItMAnaMap.put(resultMsgGotItSet.getString("message_id"), gotItMAnaMsgMap);
            }
        }

        psMain = connection.prepareStatement("select CITY, STATE, ID, DATE_MODIFIED, LAST_MODIFIED_BY, LAST_MODIFIED_DATE, COMMENTS, TRUCKINFO, X(city_point) as city_lat, Y(city_point) as city_lng from test.maids_msg_board where COMPANY_ID = ? order by DATE_MODIFIED desc");
        psMain.setString(1, uuid);
        ResultSet resultMsgSet = psMain.executeQuery();
        DateFormat formatter = new SimpleDateFormat("MM-dd-yyyy.HH.mm.ss");
        int countOfUnreadmsgs = 0;
        while (resultMsgSet.next()) {
%>


<% if (!gotItMMap.containsKey(resultMsgSet.getString("id"))) {
    countOfUnreadmsgs = countOfUnreadmsgs + 1;

}

}
%>
<%
    if (countOfUnreadmsgs > 0) {

        session.setAttribute("msg_count", countOfUnreadmsgs);

    } else {

        session.removeAttribute("msg_count");
    }

%>


<%

    } catch (Exception ex) {
        errorMsg = "" + ex.getMessage();
        System.out.println("" + ex);
    }
%>
<%
    String dateString = new java.text.SimpleDateFormat("MM/dd/yyyy.HH.mm.ss").format(new java.util.Date());
%>
<input type="hidden" name="timestamp" id="timestamp"
       value="<%if(request.getParameter("dateString")!=null){%><%=request.getParameter("dateString")%><%}else{%><%=dateString%><%}%>">


<%}%>
<%@include file="nav_menu.jsp" %>

<br><br><br>
<!-- Modal -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span
                        aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModalLabel">Modal title</h4>
            </div>
            <div class="modal-body">
                <h1>YOU HAVE A NEW MESSAGE</h1>
                <h2><a href="message_center.jsp">Message Center</a></h2>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
            </div>
        </div>
    </div>
</div>
<div class="container">
    <!-- Start Home Page Slider -->
    <!-- End Home Page Slider -->


    <!---------------------- old page --->

    <div class="row">
        <div class="col-md-8">


            <%if (session.getAttribute("msg_count") != null && !session.getAttribute("msg_count").equals("")) {%>

            <div class="box-sm" style="padding-top: 2px; padding-bottom: 2px; padding-left: 10px;">


                <h3><span class="glyphicon glyphicon-envelope" style="top: 3px;"></span> You have a new message <input
                        type="submit" class="btn btn-primary" value="<%=session.getAttribute("msg_count")%> | New"
                        onclick="window.location.href='message_center.jsp'">
                </h3>

            </div>

            <%}%>


            <div class="box-sm">
            <!--
                <h2>Messages from myTruckBoard Team</h2>
                <p>Progess report is an advance report</p>
            
                <h2>Messages from myTruckBoard Team</h2>
                <small> 02/22/2016</small>
                <p>Quick Load Entry � Add load information quickly and easily with our simple interface.</p>
                <p>Salesman/Broker Commissions � manage and track commissions easily.</p>
                <p>Easy Load Tendering � transmit load info to carriers right from the system.</p>
                <p>Customer Web Portal � Empower your customers with easy access to their load status online.</p>
                <p>Multi-Shipment Functionality � combine shipments on a single load and accurately bill all customers.</p>
                
                <h2>New Features</h2>
                
                <small> 06/1/2016</small><BR>
                <p>
Unlimited trucks, trailers and drivers	<BR>	
Customizable driver settlements		<BR>	
Customizable load confirmations	<BR>		
Carrier Payables		<BR>	
Easily manage agent offices	<BR>		
Unlimited Users			<BR>
Unlimited Training and Support		<BR>	
Detailed reporting and statistics	<BR>		
Integrates with Quick Books			<BR>		
Multiple user permission settings		<BR>	
Use your own logo on confirmations and invoices		<BR>	
Google and myTruckBoard mileage calculator			<BR>
Detailed Customer rate agreements		<BR>	
Sales Reps Commission      </p>          
                <small> 03/17/2016</small>
                <p>Driver Progress Board � 
                Let�s say you are looking for a single report where you can see the current location of every driver, how far away they are from their next scheduled stop and how much time is remaining from now to their next scheduled arrival time. For example John is in Los Angeles now. His next stop is in Pasadena which is 12 miles away from Los Angeles. He is scheduled to arrive there in 1 hour, 45 minutes.</p>
                <small> 02/22/2016</small>
                <p>Quick Load Entry � Add load information quickly and easily with our simple interface.</p>
                    -->

		<p>MyTRUCKBOARD is a trucking industry most powerful and intuitive platform for freight dispatch management, operations and marketplace.</p>

<p>We have a proven track record for enabling freight brokerage companies to compete better, lock in deals faster, and easily manage entire trucking fleet with trucker profiles, history and rates.</p>

<p>MyTRUCKBOARD wants to do its part in helping to reduce traffic in our Cities and Highways. Our mission is to use technology to help brokers reclaim un-utilized capacity and reduce the number of empty trucks on our streets. Our location and capacity focused features make it trivial to manage otherwise complicated process of keeping you in the know and your freight busy....</p>

<p>Post your questions here and we will get to it ASAP.</p>

<%
if(request.getParameter("saveQuestion")!=null){
    try{ 
        Class.forName("com.mysql.jdbc.Driver");
        String url = "jdbc:mysql://localhost/test?user=<PASSWORD>&password=<PASSWORD>";
        Connection connection = DriverManager.getConnection(url, "<USERNAME>", "<PASSWORD>");

        PreparedStatement psMain = connection.prepareStatement("INSERT INTO test.trucking_qa(question_id, ts, question, company_id, user_id, isShowing) VALUES (?,?,?, ?,?,?)");
        psMain.setString(1, UUID.randomUUID() + "");
        psMain.setTimestamp(2, new java.sql.Timestamp((new java.util.Date()).getTime()));
        psMain.setString(3, request.getParameter("question"));
        psMain.setString(4, uuid);
        psMain.setString(5, (String) session.getAttribute("login_id"));
        psMain.setInt(6, 0);
        psMain.executeUpdate();
	connection.close();
    } catch (Exception ex) {
        errorMsg = "Error While Procesing Request";
        System.out.println("" + ex);
    }
}

%>

    			<form action="/trucking-new/new_features.jsp" method="post">
    <input type="hidden" name="saveQuestion" value="saveQuestion" />
		<div class="input-group"  style="padding: 5px;width:100%;">
    <input type='text' style="width:100%;font-size: 14px; padding-left: 5px; padding-right: 5px; "  id="question" name="question" value="" placeholder="Question">
		 </div> 
<BR>
		<div class="input-group"  style="padding: 5px;width:100%;">
		<button class="btn btn-primary" style="width:100%;" type="button" id="paymentButton" onclick="this.form.submit()" >&nbsp;&nbsp;Ask Question&nbsp;&nbsp;</button>
	      </div>  
			

			</form> 
<BR><BR>
<%
    try{ 
        Class.forName("com.mysql.jdbc.Driver");
        String url = "jdbc:mysql://localhost/test?user=<PASSWORD>&password=<PASSWORD>";
        Connection connection = DriverManager.getConnection(url, "<USERNAME>", "<PASSWORD>");

        PreparedStatement psMain = null;
        psMain = connection.prepareStatement("select * from trucking_qa where isShowing = 1 or company_id = ?");
	psMain.setString(1, uuid);
        ResultSet resultMsgGotItSet = psMain.executeQuery();
        while (resultMsgGotItSet.next()) {
            %><p><%=resultMsgGotItSet.getString("question")%></p> <%=resultMsgGotItSet.getString("response")%><%
        }
	connection.close();
    } catch (Exception ex) {
        errorMsg = "Error While Procesing Request";
        System.out.println("" + ex);
    }
%>
<!--                
<h2>"My Truck Board" Driver App</h2>
                <small><a href="https://itunes.apple.com/us/app/mytruckboard-driver/id1044398785?mt=8" target="new">Updated: Jun 22, 2016 Version 4.05</a></small>
                
                <img src="images/mtb1_featured5.jpg" class="img-responsive" class="img-rounded" alt="Responsive image">
                -->
                <!--
                <p>Exclusively on iOS, MyTruckBoard Driver App is designed for your truck drivers. Ask them to download
                    it for free and they will be automatically connected to your account. Once they register with the
                    email already associated with a truck in MyTruckBoard, you can send them truckloads, see their
                    GPS location and speed.</p>
		
                <h2>"Messages" are here</h2>
                <small> 06/15/2015</small>
                <img src="images/mtb1_featured4.png" class="img-responsive" class="img-rounded" alt="Responsive image">
                <p>We are happy to introduce the Messages. Use the Message Center to view and send internal messages to
                    all of your truckboard users. Users can acknowledge the message and administrators will be notifed
                    of the message progress.</p>

                <h2>Standard TruckBoard Updates: Pickup City & Search</h2>
                <small> 06/03/2015</small>
                <img src="images/mtb-standard-featured1.png" class="img-responsive" class="img-rounded"
                     alt="Responsive image">
                <p>Standard TruckBoard has been updated with a Search Key, which allows you to search on any field, just
                    enter the search key and press Search! Also, if you select a Pickup City, the truck list will
                    re-sort based on proximity to that location.
                </p>

                <h2>TruckBoard 2.0 Updates: Edit and Book</h2>
                <small>06/02/2015</small>


                <img src="images/mtb3_featured.jpg" class="img-responsive" class="img-rounded" alt="Responsive image">
                <p>We've updated the Rate History tab with a link to Rate Manager to book the truck. Added Comments and
                    Info tabs with links that will allow you to edit or comment on the trucker.</p>

                <h2>TruckBoard 2.0 Organization</h2>

                <img src="images/mtb1_featured.png" class="img-responsive" class="img-rounded" alt="Responsive image">
                <p>Now you can see all your trucks organized by location city in the left column. Click on any city
                    group to launch a detailed list on the bottom of the map. The bottom list will be sorted by the
                    proximity to the Pickup Location.

                </p>

                <h2>TruckBoard 2.0 TruckList and Truck Details</h2>

                <img src="images/mtb2_featured.png" class="img-responsive" class="img-rounded" alt="Responsive image">
                <p>You can click any contact name in the list to get more details, history and comments.</p>
-->

            </div>
        </div>

        <div class="col-sm-4">
                <%if (session.getAttribute("isAd_account_only") != null && session.getAttribute("isAd_account_only").equals("false")) {%>
            
            <div class="box-sm3">
                <a href="truckboard_current.jsp"><h2>Shared Fleet</h2>
                    <p>Public Database</p>
                    </a>
                    
                    </div>
            <div class="box-sm3">
                <a href="truckboard.jsp"><h2>Private Fleet</h2>
                    <p>Private Database</p>
                    </a></div>

                    

            <%}%>
<!--
            <div class="box-sm3">
                <a href="adManager.jsp">
                    <h2>Ad Manager
                        <small><strong>(beta)</strong></small>
                    </h2>
                    <p>myTruckBoard Ad Network.</p></a></div>

            <div class="box-sm3a">
                <h2>Support</h2>
                <p>Email: <b>info@myTruckBoard.com</b></p>
                <p>Voice: <b>1.650.567.4439</b></p>
            </div>
-->
            <%if (!errorMsg.equals("") && uuid == null) {%>

            <script type="text/javascript">
                $(window).load(function () {
                    $('#invalid_login').modal('show');
                });
            </script>


            <a href="../index4.jsp">Log in here.</a>


            <%} else if (loginTrue || uuid != null) {%>


            <%if (session.getAttribute("isAdmin").equals("true")) {%>
            <div class="box-sm3a">
                <h2>Subscription\Billing</h2>
                <%}%>
                <%} else if (request.getParameter("login_id") != null) {%>

                <script type="text/javascript">
                    $(window).load(function () {
                        $('#invalid_login').modal('show');
                    });
                </script>

                <%} else {%>


                <script type="text/javascript">
                    $(window).load(function () {
                        $('#invalid_login').modal('show');
                    });
                </script>

                <%}%>

            </div>

            <div class="box-sm3a">
                <%if (session.getAttribute("issubscribed") != null && session.getAttribute("issubscribed").equals("true")) {%>
                <p>Status: <b style="color:green;"><a href="subscription_manager.jsp" >Active</a></b></p>
                <%}%>

            </div>

        </div>

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
            <li>&copy;<a href="http://liteworks2.com">Litewsorks2 Inc</a></li>
            <li>voice: 1.310.903.6014</li>
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
                <button type="button" class="btn btn-primary" data-dismiss="modal"
                        onclick="location.href='https://www.mytruckboard.com'">Dismiss
                </button>

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


<!------- Invalid Session  - modal ---->


<div class="modal fade" id="invalid_login" role="dialog" aria-hidden="false" data-backdrop="static"
     aria-labelledby="relogin">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" aria-hidden="true">&times;</button>
                <h4 class="modal-title" id="myModalLabel" style="color:red">Login Error</h4>
            </div>
            <div class="modal-body">
                <h4>...the username or password you entered is incorrect.</h4><br>
                <h3>Please login again.</h3>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-primary" data-dismiss="modal"
                        onclick="location.href='https://www.mytruckboard.com'">Login here
                </button>

            </div>
        </div>
    </div>
</div>


<!-- end of invalid session modal -->


<!-- Bootstrap core JavaScript
================================================== -->
<!-- Placed at the end of the document so the pages load faster -->

<script src="js/bootstrap2.min.js"></script>
<!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
<script src="assets/js/ie10-viewport-bug-workaround.js"></script>

<!-- Google analytics -->

<script>
    (function (i, s, o, g, r, a, m) {
        i['GoogleAnalyticsObject'] = r;
        i[r] = i[r] || function () {
                    (i[r].q = i[r].q || []).push(arguments)
                }, i[r].l = 1 * new Date();
        a = s.createElement(o),
                m = s.getElementsByTagName(o)[0];
        a.async = 1;
        a.src = g;
        m.parentNode.insertBefore(a, m)
    })(window, document, 'script', '//www.google-analytics.com/analytics.js', 'ga');

    ga('create', 'UA-28886039-1', 'auto');
    ga('send', 'pageview');

</script>
<!-- / end Google analytics -->

</body>
</html>
