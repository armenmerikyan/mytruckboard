<%@ page
        import="com.big.util.*,java.text.*,java.util.*,java.io.*,javax.xml.parsers.*,org.w3c.dom.*,java.sql.*,java.text.DateFormat" %>
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
    <title>Manage Users - MYTRUCKBOARD 2.0 - freight dispatch and management software</title>
    <link rel="shortcut icon" href="http://www.mytruckboard.com/trucking-new/images/mtb-favicon.ico">
    <meta http-equiv="content-type" content="text/html; charset=utf-8"/>
    <meta name="description"
          content="The complete freight management software. Win shipping deals and manage your fleet of trucks effortlessly."/>
    <meta name="keywords"
          content="freight, transportation, dispatch management, load optimization, truck broker, transportation management, truck, truck fleet management, shippers, truck brokers, shipping made easy, trucking industry, trucking software, trucking, dispatch for freight brokder, carrier management, load board, load, board"/>

    <!-- Bootstrap core CSS -->
    <link href="css/bootstrap2.min.css" rel="stylesheet">

    <!-- Custom styles for this template -->
    <link href="css/navbar-fixed-top.css" rel="stylesheet">

    <!-- custom styles -->
    <link href="css/style2.css" rel="stylesheet">
    <!--- custom style -->
    <link href="css/style4.css" rel="stylesheet">
    <!--- custom style -->
    <link href="css/portlet.css" rel="stylesheet">


    <script type="text/javascript" src="js/jquery-2.1.3.min.js"></script>
    <script type="text/javascript" src="js/jquery-ui.min.js"></script>

    <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
    <!--[if lt IE 9]>
    <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
    <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->


    <!-- Bootstrap core JavaScript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster -->

    <script src="js/bootstrap2.min.js"></script>

    <link rel="stylesheet" href="css/navstyle2.css"/>

    <style>

        .btn-block {

            display: -webkit-inline-box;
        }

    </style>


    <script language="JavaScript" type="text/javascript">
        function updateCounts() {
            //alert("called load trucks");
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

                    var addressList = xmlhttp.responseText.split("<ITEM>");
                    document.getElementById("divCountUsers").innerHTML = addressList[1];
                    document.getElementById("divCountTeams").innerHTML = addressList[2];

                }
            }

            xmlhttp.open("GET", "manage_users.jsp" ,true);
            xmlhttp.send();
        }
    </script>

</head>

<%
    if (session.getAttribute("isAdmin") == null) {
        response.sendRedirect("../");

    } else {
%>

<%
    int totalCountUsers = 0;
    int totalCountTeams = 0;
%>

<%
    if (session.getAttribute("isAdmin").equals("true")) {
        String uuid = (String) session.getAttribute("uuid");

        String errorMsg = "";
%>
<%if (request.getParameter("offlineEmail") != null && !request.getParameter("offlineEmail").equals("")) {%>
<%
    Class.forName("com.mysql.jdbc.Driver");
    String url = "jdbc:mysql://localhost/test?zeroDateTimeBehavior=convertToNull";
    Connection connection = DriverManager.getConnection(url, "<USERNAME>", "<PASSWORD>");
    PreparedStatement ps = connection.prepareStatement("Update test.TRUCKING_USERS Set IS_ONLINE = ? where COMPANY_ID = ? and EMAIL = ? and IS_OWNER is not true");
    ps.setBoolean(1, false);
    ps.setString(2, uuid);
    ps.setString(3, request.getParameter("offlineEmail"));
    ps.executeUpdate();
%>
<%}%>
<%if (request.getParameter("onlineEmail") != null && !request.getParameter("onlineEmail").equals("")) {%>
<%
    Class.forName("com.mysql.jdbc.Driver");
    String url = "jdbc:mysql://localhost/test?zeroDateTimeBehavior=convertToNull";
    Connection connection = DriverManager.getConnection(url, "<USERNAME>", "<PASSWORD>");
    PreparedStatement ps = connection.prepareStatement("Update test.TRUCKING_USERS Set IS_ONLINE = ? where COMPANY_ID = ? and EMAIL = ? and IS_OWNER is not true");
    ps.setBoolean(1, true);
    ps.setString(2, uuid);
    ps.setString(3, request.getParameter("onlineEmail"));
    ps.executeUpdate();
%>
<%}%>
<%if (request.getParameter("removeEmail") != null && !request.getParameter("removeEmail").equals("")) {%>
<%
    try {
        Class.forName("com.mysql.jdbc.Driver");
        String url = "jdbc:mysql://localhost/test?zeroDateTimeBehavior=convertToNull";

//			Class.forName("com.sap.dbtech.jdbc.DriverSapDB");
//			String url = "jdbc:sapdb://localhost/BIGDB?sqlmode=ORACLE";
        Connection connection = DriverManager.getConnection(url, "<USERNAME>", "<PASSWORD>");
        PreparedStatement ps = connection.prepareStatement("select count(EMAIL) as user_count from test.TRUCKING_USERS WHERE COMPANY_ID = ? and IS_ADMIN = ? ");
        ps.setString(1, uuid);
        ps.setBoolean(2, true);
        ResultSet resultSet = ps.executeQuery();
        while (resultSet.next()) {
            if (resultSet.getInt("user_count") > 0) {
                ps = connection.prepareStatement("Delete from test.TRUCKING_USERS where COMPANY_ID = ? and EMAIL = ? and IS_OWNER is not true");
                ps.setString(1, uuid);
                ps.setString(2, request.getParameter("removeEmail"));
                ps.executeUpdate();
            } else {
                errorMsg = "You must keep one active Admin user Error 1<BR>";
            }
        }
        connection.close();
    } catch (Exception ex) {
        errorMsg = "" + ex.getMessage();
        System.out.println("" + ex);
    }
%>
<%}%>
<%if (request.getParameter("makeEmail") != null && !request.getParameter("makeEmail").equals("")) {%>

<%
    try {
//			Class.forName("com.sap.dbtech.jdbc.DriverSapDB");
//			String url = "jdbc:sapdb://localhost/BIGDB?sqlmode=ORACLE";
        Class.forName("com.mysql.jdbc.Driver");
        String url = "jdbc:mysql://localhost/test?zeroDateTimeBehavior=convertToNull";
        Connection connection = DriverManager.getConnection(url, "<USERNAME>", "<PASSWORD>");
        PreparedStatement ps = connection.prepareStatement("Update test.TRUCKING_USERS Set IS_ADMIN = ? where COMPANY_ID = ? and EMAIL = ? and IS_OWNER is not true");
        if (request.getParameter("command").equals("make_user")) {
            ps.setBoolean(1, false);
        } else {
            ps.setBoolean(1, true);
        }
        ps.setString(2, uuid);
        ps.setString(3, request.getParameter("makeEmail"));
        if (request.getParameter("command").equals("make_user")) {
            PreparedStatement psCheck = connection.prepareStatement("select count(EMAIL) as user_count from test.TRUCKING_USERS WHERE COMPANY_ID = ? and IS_ADMIN = ? ");
            psCheck.setString(1, uuid);
            psCheck.setBoolean(2, true);
            ResultSet resultSet = psCheck.executeQuery();
            while (resultSet.next()) {
                if (resultSet.getInt("user_count") > 0) {
                    ps.executeUpdate();
                } else {
                    errorMsg = "You must keep one active Admin user Error 2<BR>";
                }
            }
        } else {
            ps.executeUpdate();
        }
        connection.close();
    } catch (Exception ex) {
        errorMsg = "" + ex.getMessage();
        System.out.println("" + ex);
    }
%>

<%}%>
<%if (request.getParameter("addaccount") != null) {%>
<%if (request.getParameter("email") != null && !request.getParameter("email").equals("") && request.getParameter("password") != null && !request.getParameter("password").equals("") && request.getParameter("ReEnterPassword") != null && !request.getParameter("ReEnterPassword").equals("")) {%>
<%if (request.getParameter("password").equals(request.getParameter("ReEnterPassword"))) {%>
<%
    try {

        Class.forName("com.mysql.jdbc.Driver");
        String url = "jdbc:mysql://localhost/test?zeroDateTimeBehavior=convertToNull";
        Connection connection = DriverManager.getConnection(url, "<USERNAME>", "<PASSWORD>");

        PreparedStatement ps = connection.prepareStatement("INSERT INTO test.TRUCKING_USERS(EMAIL, PASSWORD, COMPANY_ID, IS_ADMIN, email_code, sms_code, start_ip, last_ip, chain_ip, ts, f_name, l_name, is_online, is_online_register) VALUES (?,?,?,?,?,?,?,?,?,?,?,?,1,0)");
        ps.setString(1, request.getParameter("email").toLowerCase());
        ps.setString(2, request.getParameter("password"));
        ps.setString(3, uuid);
        ps.setBoolean(4, false);
        ps.setString(5, (UUID.randomUUID() + "").substring(0, 4));
        ps.setString(6, (UUID.randomUUID() + "").substring(0, 4));
        ps.setString(7, request.getRemoteAddr());
        ps.setString(8, request.getRemoteAddr());
        ps.setString(9, request.getRemoteAddr());
        java.sql.Timestamp ts = new java.sql.Timestamp((new java.util.Date()).getTime());
        ps.setTimestamp(10, ts);
        ps.setString(11, request.getParameter("f_name"));
        ps.setString(12, request.getParameter("l_name"));
        ps.executeUpdate();


        connection.close();
    } catch (Exception ex) {
        errorMsg = "" + ex.getMessage();
        System.out.println("" + ex);
    }
%>
<%} else {%>
<% errorMsg = "Re-entered password is not matching. Make sure to type same password in both fields?<BR>";%>
<%}%>
<%} else {%>
<% errorMsg = "All fields are required to create a new account <BR>";%>
<%}%>
<%}%>
<%if (request.getParameter("blockIP") != null) {%>
<%
    try {
//			Class.forName("com.sap.dbtech.jdbc.DriverSapDB");
//			String url = "jdbc:sapdb://localhost/BIGDB?sqlmode=ORACLE";
        Class.forName("com.mysql.jdbc.Driver");
        String url = "jdbc:mysql://localhost/test?zeroDateTimeBehavior=convertToNull";
        Connection connection = DriverManager.getConnection(url, "<USERNAME>", "<PASSWORD>");


        PreparedStatement ps = connection.prepareStatement("INSERT INTO test.trucking_ip_block(company_id, ip, ts, blocked_by) VALUES (?,?,?,?)");
        ps.setString(1, uuid);
        ps.setString(2, request.getParameter("ip"));
        java.sql.Timestamp ts = new java.sql.Timestamp((new java.util.Date()).getTime());
        ps.setTimestamp(3, ts);
        ps.setString(4, (String) session.getAttribute("login_id"));
        ps.executeUpdate();


        connection.close();
    } catch (Exception ex) {
        errorMsg = "" + ex.getMessage();
        System.out.println("" + ex);
    }
%>
<%}%>
<%if (request.getParameter("unblockIP") != null) {%>
<%
    try {
//			Class.forName("com.sap.dbtech.jdbc.DriverSapDB");
//			String url = "jdbc:sapdb://localhost/BIGDB?sqlmode=ORACLE";
        Class.forName("com.mysql.jdbc.Driver");
        String url = "jdbc:mysql://localhost/test?zeroDateTimeBehavior=convertToNull";

        Connection connection = DriverManager.getConnection(url, "<USERNAME>", "<PASSWORD>");
        PreparedStatement ps = connection.prepareStatement("delete from test.trucking_ip_block where company_id = ? and  ip = ?");
        ps.setString(1, uuid);
        ps.setString(2, request.getParameter("ip"));
        ps.executeUpdate();

        connection.close();
    } catch (Exception ex) {
        errorMsg = "" + ex.getMessage();
        System.out.println("" + ex);
    }
%>
<%}%>


<%if(true){%>
<%

    try {

        Class.forName("com.mysql.jdbc.Driver");
        String url = "jdbc:mysql://localhost/test?zeroDateTimeBehavior=convertToNull";
        Connection connection = DriverManager.getConnection(url, "<USERNAME>", "<PASSWORD>");

        PreparedStatement psMain = connection.prepareStatement("select count(EMAIL) as itemCount from test.TRUCKING_USERS WHERE COMPANY_ID = ?");
        psMain.setString(1, uuid);
        ResultSet resultSet = psMain.executeQuery();
        while (resultSet.next()) {
            totalCountUsers = resultSet.getInt("itemCount");
        }

        psMain = connection.prepareStatement("select count(team_id) as itemCount from test.TRUCKING_USER_teams where company_id = ?");
        psMain.setString(1, uuid);
        resultSet = psMain.executeQuery();
        while (resultSet.next()) {
            totalCountTeams = resultSet.getInt("itemCount");
        }


        connection.close();
    } catch (Exception ex) {
        errorMsg = "" + ex.getMessage();
        System.out.println("" + ex);
    }
%>
<%}%>




<!-- logout function  -->
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
<body>


<!-- Fixed navbar -->

<%@include file="nav_menu.jsp" %>
<br><br><br>
<!-- Main page: -->


<div class="container">


    <div class="row">


        <div class="col-md-12">
            <div class="row">


                <div class="col-lg-6 col-sx-12">
                    <div class="panel panel-primary">
                        <div class="panel-heading" style="background-color:green">
                            <div class="row">
                                <div class="col-xs-3">
                                    <i class="fa fa-user fa-3x"></i>
                                </div>
                                <div class="col-xs-9 text-right">
                                    <div class="huge"><span id="divCountUsers" ><%=totalCountUsers%></span></div>
                                    <div>Total Users</div>
                                </div>
                            </div>
                        </div>

                    </div>
                </div>


                <a href="manage_teams.jsp">
                    <div class="col-lg-6 col-sx-12">
                        <div class="panel panel-primary">
                            <div class="panel-heading" style="background-color:saddlebrown">
                                <div class="row">
                                    <div class="col-xs-3">
                                        <i class="fa fa-group fa-3x"></i>
                                    </div>
                                    <div class="col-xs-9 text-right">
                                        <div class="huge"><span id="divCountTeams" ><%=totalCountTeams%></span></div>
                                        <div>Teams</div>
                                    </div>
                                </div>
                            </div>

                        </div>
                    </div>
                </a>


            </div>
        </div>


        <div class="col-lg-12 col-sx-12">
            <div class="row">

                <form action="add_user.jsp" id="addtruckform" name="addtruckform" method="post"
                      class="form-horizontal" role="form" data-toggle="validator">


                    <div class="form-group">
                        <label class="col-lg-2 control-label">User:</label>
                        <div class="col-lg-2">
                            <input class="form-control" type="text" name="f_name" placeholder="John">
                            <div class="help-block with-errors"></div>
                        </div>
                        <div class="col-lg-2">
                            <input type="submit" class="btn btn-primary btn-block"
                                   style="background-color:green; border-color:green;" value="Add User" name="submit1">
                        </div>
                    </div>
                </form>

            </div>
        </div>


        <div class="row">


            <div class="col-md-12">

                <div class="portlet box blue">
                    <div class="portlet-title">
                        <div class="caption">
                            <i class="fa fa-user" style="margin-top: 2px;"></i>My Users
                        </div>

                    </div>


                    <div class="portlet-body">
                        <div class="table-scrollable">
                            <table class="table table-striped table-hover">
                                <thead>
                                <tr>

                                    <th>User</th>
                                    <th>Username</th>
                                    <th>Login IP History
                                        <small> ( click on ip to block/unblock )</small>
                                    </th>
                                    <th>Role</th>
                                    <th>Action</th>
                                </tr>
                                </thead>
                                <tbody>


                                <%if (true) {%>
                                <%
                                    try {
                                        Class.forName("com.mysql.jdbc.Driver");
                                        String url = "jdbc:mysql://localhost/test?zeroDateTimeBehavior=convertToNull";
                                        Connection connection = DriverManager.getConnection(url, "<USERNAME>", "<PASSWORD>");

                                        PreparedStatement psMain = null;
                                        psMain = connection.prepareStatement("select * from test.trucking_ip_block WHERE COMPANY_ID = ?");
                                        psMain.setString(1, uuid);
                                        ResultSet resultSet = psMain.executeQuery();
                                        HashMap ip_block_map = new HashMap();
                                        while (resultSet.next()) {
                                            ip_block_map.put(resultSet.getString("ip"), resultSet.getString("ip"));
                                        }

                                        psMain = connection.prepareStatement("select * from test.TRUCKING_USERS WHERE COMPANY_ID = ? order by ts desc");
                                        psMain.setString(1, uuid);
                                        resultSet = psMain.executeQuery();

                                        while (resultSet.next()) {
                                %>

                                <tr>
                                    <td class="col-md-2"><p>
                                        <strong><%=NullCheck.check(resultSet.getString("F_Name"))%> <%=NullCheck.check(resultSet.getString("L_Name"))%>
                                        </strong>
                                        <BR><%if (resultSet.getString("phone") != null) {%>

                                        Phone: <%=NullCheck.check(resultSet.getString("phone"))%>
                                        <BR>
                                        <%}%>
                                        Status: <%if (resultSet.getBoolean("IS_online")) {%>
                                        <span class="label label-sm label-success"> Active </span><BR>
                                        <%} else if (!resultSet.getBoolean("IS_online")) {%>
                                        <span class="label label-sm label-warning"> Disabled </span><BR>
                                        <%}%>
                                    </p>
                                    </td>
                                    <td class="col-md-3"><%=NullCheck.check(resultSet.getString("EMAIL"))%>
                                        <BR>


            <span style="font-size:.7em;">
            <%
                if (true) {
                    String timeDurration = "ago";
                    if (true && resultSet.getTimestamp("last_login_ts") != null) {
                        long currentTime = Calendar.getInstance().getTime().getTime();
                        long postTime = resultSet.getTimestamp("last_login_ts").getTime();
                        long diff = currentTime - postTime;
                        long diffSeconds = diff / 1000 % 60;
                        long diffMinutes = diff / (60 * 1000) % 60;
                        long diffHours = diff / (60 * 60 * 1000) % 24;
                        long diffDays = diff / (60 * 60 * 1000 * 24);
                        if (diffSeconds == 1) timeDurration = "1 Second " + timeDurration;
                        else if (diffSeconds > 1) timeDurration = diffSeconds + " Seconds " + timeDurration;
                        if (diffMinutes == 1) timeDurration = "1 Minute " + timeDurration;
                        else if (diffMinutes > 1) timeDurration = diffMinutes + " Minutes " + timeDurration;
                        if (diffHours == 1) timeDurration = "1 Hour " + timeDurration;
                        else if (diffHours > 1) timeDurration = diffHours + " Hours " + timeDurration;
                        if (diffDays == 1) timeDurration = "1 Day " + timeDurration;
                        else if (diffDays > 1) timeDurration = diffDays + " Days " + timeDurration;
                    }
            %>
            Last Login <%=timeDurration%><BR>
            	<%}%>	
            <%
                if (true) {
                    String timeDurration = "ago";
                    if (true && resultSet.getTimestamp("ts") != null) {
                        long currentTime = Calendar.getInstance().getTime().getTime();
                        long postTime = resultSet.getTimestamp("ts").getTime();
                        long diff = currentTime - postTime;
                        long diffSeconds = diff / 1000 % 60;
                        long diffMinutes = diff / (60 * 1000) % 60;
                        long diffHours = diff / (60 * 60 * 1000) % 24;
                        long diffDays = diff / (60 * 60 * 1000 * 24);
                        if (diffSeconds == 1) timeDurration = "1 Second " + timeDurration;
                        else if (diffSeconds > 1) timeDurration = diffSeconds + " Seconds " + timeDurration;
                        if (diffMinutes == 1) timeDurration = "1 Minute " + timeDurration;
                        else if (diffMinutes > 1) timeDurration = diffMinutes + " Minutes " + timeDurration;
                        if (diffHours == 1) timeDurration = "1 Hour " + timeDurration;
                        else if (diffHours > 1) timeDurration = diffHours + " Hours " + timeDurration;
                        if (diffDays == 1) timeDurration = "1 Day " + timeDurration;
                        else if (diffDays > 1) timeDurration = diffDays + " Days " + timeDurration;
                    }
            %>
            Created <%=timeDurration%>
            	<%}%>	
            </span>

                                    </td>
                                    <td class="col-md-s4">


                                        <%if (resultSet.getString("chain_ip") != null) {%>
                                        <%


                                            String[] ips = resultSet.getString("chain_ip").split(",");
                                            for (int j = 0; j < ips.length; j++) {
                                                if (ip_block_map.containsKey(ips[j])) {%>

                                        <a href="manage_users.jsp?unblockIP=true&ip=<%=ips[j]%>"><span
                                                style="color:red;"><%=ips[j]%></span></a>
                                        <% } else {%>
                                        <a href="manage_users.jsp?blockIP=true&ip=<%=ips[j]%>"><span
                                                style="color:green;"><%=ips[j]%></span></a>
                                        <%
                                                }
                                            }%>


                                    </td>
                                    <td class="col-md-1">
                                        <%if (resultSet.getBoolean("IS_OWNER")) {%>
                                        <strong>Account Owner</strong>
                                        <%} else if (resultSet.getBoolean("IS_ADMIN")) {%>
                                        <strong>Admin</strong>
                                        <%} else {%>
                                        <strong>User</strong>
                                        <%}%>
                                    </td>

                                    <td class="col-md-2">


                                        <a href="javascript:void(0)">
                                            <button type="button" class="btn btn-default btn-sm btn-block"
                                                    onclick="location.href='user_profile_edit.jsp?user_id=<%=resultSet.getString("EMAIL")%>'"
                                                    alt="edit account">
                                                <span class="glyphicon glyphicon-edit"></span> edit user
                                            </button>
                                        </a>


                                        <%if (resultSet.getBoolean("IS_OWNER")) {%>

                                        <%} else if (resultSet.getBoolean("IS_ADMIN")) {%>


                                        <a href="javascript:void(0)">
                                            <button type="button" class="btn btn-default btn-sm btn-block"
                                                    style="color:saddlebrown"
                                                    onclick="location.href='manage_users.jsp?command=make_user&makeEmail=<%=resultSet.getString("EMAIL")%>'"
                                                    alt="change to user">
                                                <span class="glyphicon glyphicon-user"></span> demote to user
                                            </button>
                                        </a>
                                        <a href="javascript:void(0)">
                                            <button type="button" class="btn btn-default btn-sm btn-block"
                                                    style="color:red"
                                                    name="remove_levels" value="delete"
                                                    onclick="location.href='manage_users.jsp?removeEmail=<%=resultSet.getString("EMAIL")%>'"
                                                    alt="delete account">
                                                <span class="glyphicon glyphicon-trash"></span> delete account
                                            </button>
                                        </a>
                                        <%} else {%>
                                        <a href="javascript:void(0)">
                                            <button type="button" class="btn btn-default btn-sm btn-block"
                                                    style="color:saddlebrown"
                                                    onclick="location.href='manage_users.jsp?command=make_admin&makeEmail=<%=resultSet.getString("EMAIL")%>'"
                                                    alt="change role to admin">
                                                <span class="glyphicon glyphicon-user"></span> promote to admin
                                            </button>
                                        </a>
                                        <a href="javascript:void(0)">
                                            <button type="button" class="btn btn-default btn-sm btn-block"
                                                    style="color:red"
                                                    name="remove_levels" value="delete"
                                                    onclick="location.href='manage_users.jsp?removeEmail=<%=resultSet.getString("EMAIL")%>'"
                                                    alt="delete account">
                                                <span class="glyphicon glyphicon-trash"></span> delete account
                                            </button>
                                        </a>

                                        <%}%>

                                        <%if (!resultSet.getBoolean("IS_OWNER") && resultSet.getBoolean("IS_online")) {%>
                                        <a href="javascript:void(0)">
                                            <button type="button" class="btn btn-default btn-sm btn-block"
                                                    style="color:orange"
                                                    onclick="location.href='manage_users.jsp?offlineEmail=<%=resultSet.getString("EMAIL")%>'"
                                                    alt="disable account">
                                                <span class="glyphicon glyphicon-ban-circle"></span> disable account
                                            </button>
                                        </a>
                                        <%} else if (!resultSet.getBoolean("IS_OWNER") && !resultSet.getBoolean("IS_online")) {%>
                                        <a href="javascript:void(0)">
                                            <button type="button" class="btn btn-default btn-sm btn-block"
                                                    style="color:green"
                                                    onclick="location.href='manage_users.jsp?onlineEmail=<%=resultSet.getString("EMAIL")%>'"
                                                    alt="enable account">
                                                <span class="glyphicon glyphicon-eye-open"></span> enable account
                                            </button>
                                        </a>

                                        <%}%>


                                    </td>
                                </tr>

                                <%
                                        }
                                    }
                                %>


                                </tbody>
                            </table>

                            <%
                                connection.close();
                            } catch (Exception ex) {
                            %><%="Error Posting " + ex%><%
                                    System.out.println("" + ex);
                                }
                            }
                        %>

                            <%}%>


                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- .subfooter start -->
    <!-- ================ -->
    <section id="footer">
        <div class="copyright">
            <ul class="menu">
                <li>Copyright &copy; 2015 Litewsorks2 Inc. All rights reserved.</li>
            </ul>
            <ul class="menu">
                <li>&copy;<a href="http://liteworks2.com">Litewsorks2 Inc</a></li>
                <li>599 Fairchild Dr, Mountain View, CA 94043 United States</li>
                <li>email: LW2@liteworks2.com</li>
                <li>twitter: @liteworks2</li>
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
                            onclick="location.href='../'">Dismiss
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

    <!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
    <script src="assets/js/ie10-viewport-bug-workaround.js"></script>

    <!---- gooogle analytics -->

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
</body>
</html>

<%}%>
