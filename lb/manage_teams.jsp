<%@ page
        import="java.util.Vector,com.big.util.*,java.text.*,java.util.*,java.io.*,javax.xml.parsers.*,org.w3c.dom.*,java.sql.*,java.text.DateFormat" %>
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
    <link rel="stylesheet" href="css/portlet.css"/>

    <script language="JavaScript" type="text/javascript">

        function updateStatus(username, newRole, newTeam) {
            //alert("called load trucks");
            var xmlhttp;
            if (window.XMLHttpRequest) {// code for IE7+, Firefox, Chrome, Opera, Safari
                xmlhttp = new XMLHttpRequest();
            }
            else {// code for IE6, IE5
                xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
            }
            xmlhttp.onreadystatechange = function () {
                if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {

                    var addressList = xmlhttp.responseText.split("<ITEM>");
                    var updatedSelectBox = "select" + addressList[2];
                    var updatedSpanBox = "spanWOLink" + addressList[2];
                    var tmpElementName = "";
                    var tmpElementNameL = "L";
                    if (addressList[3] == "Manager") {
                        tmpElementName = "M" + addressList[2] + addressList[1];
                    }
                    if (addressList[3] == "Sales") {
                        tmpElementName = "S" + addressList[2] + addressList[1];
                    }
                    if (addressList[3] == "Dispatcher") {
                        tmpElementName = "D" + addressList[2] + addressList[1];
                    }
                    tmpElementNameL = tmpElementNameL + tmpElementName;
                    if (addressList[4] == "true") {
                        document.getElementById(tmpElementNameL).style.backgroundColor = "";
                    } else {
                        document.getElementById(tmpElementNameL).style.backgroundColor = "red";
                    }
                }
            }
            var responseString = "?consignee_count=0";
            responseString = responseString + "&user_id=" + username;
            responseString = responseString + "&role=" + newRole;
            responseString = responseString + "&team_id=" + newTeam;
            var tmpElementName = "";
            var tmpElementNameL = "L";
            if (newRole == "Manager") {
                tmpElementName = "M" + username + newTeam;
            }
            if (newRole == "Sales") {
                tmpElementName = "S" + username + newTeam;
            }
            if (newRole == "Dispatcher") {
                tmpElementName = "D" + username + newTeam;
            }
            tmpElementNameL = tmpElementNameL + tmpElementName;
            document.getElementById(tmpElementNameL).style.backgroundColor = "Orange";
            responseString = responseString + "&check_status=" + document.getElementById(tmpElementName).checked;
            xmlhttp.open("GET", "manage_teams.state.jsp" + responseString, true);
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
<%if (request.getParameter("team_name") != null && !request.getParameter("team_name").equals("")) {%>
<%
    try {

        Class.forName("com.mysql.jdbc.Driver");
        String url = "jdbc:mysql://localhost/test?zeroDateTimeBehavior=convertToNull";
        Connection connection = DriverManager.getConnection(url, "<USERNAME>", "<PASSWORD>");

        PreparedStatement ps = connection.prepareStatement("INSERT INTO test.TRUCKING_USER_teams(team_id, ts, name, company_id, created_by) VALUES (?,?,?,?,?)");
        ps.setString(1, UUID.randomUUID() + "");
        java.sql.Timestamp ts = new java.sql.Timestamp((new java.util.Date()).getTime());
        ps.setTimestamp(2, ts);
        ps.setString(3, request.getParameter("team_name"));
        ps.setString(4, uuid);
        ps.setString(5, (String) session.getAttribute("login_id"));
        ps.executeUpdate();


        connection.close();
    } catch (Exception ex) {
        errorMsg = "" + ex.getMessage();
        System.out.println("" + ex);
    }
%>
<%}%>
<%if (request.getParameter("removeTeam_id") != null) {%>
<%
    try {
//			Class.forName("com.sap.dbtech.jdbc.DriverSapDB");
//			String url = "jdbc:sapdb://localhost/BIGDB?sqlmode=ORACLE";
        Class.forName("com.mysql.jdbc.Driver");
        String url = "jdbc:mysql://localhost/test?zeroDateTimeBehavior=convertToNull";

        Connection connection = DriverManager.getConnection(url, "<USERNAME>", "<PASSWORD>");
        PreparedStatement ps = connection.prepareStatement("delete from test.TRUCKING_USER_teams where company_id = ? and  team_id = ?");
        ps.setString(1, uuid);
        ps.setString(2, request.getParameter("removeTeam_id"));
        ps.executeUpdate();

        ps = connection.prepareStatement("delete from test.TRUCKING_USER_teams_User where team_id = ? and company_id = ?");
        ps.setString(1, request.getParameter("removeTeam_id"));
        ps.setString(2, uuid);
        ps.executeUpdate();

        connection.close();
    } catch (Exception ex) {
        errorMsg = "" + ex.getMessage();
        System.out.println("" + ex);
    }
%>
<%}%>
<%if (request.getParameter("removeFromTeam") != null) {%>
<%
    try {

        Class.forName("com.mysql.jdbc.Driver");
        String url = "jdbc:mysql://localhost/test?zeroDateTimeBehavior=convertToNull";
        Connection connection = DriverManager.getConnection(url, "<USERNAME>", "<PASSWORD>");

        PreparedStatement ps = connection.prepareStatement("delete from test.TRUCKING_USER_teams_User where team_id = ? and user_id = ? and company_id = ?");
        ps.setString(1, request.getParameter("team_id"));
        ps.setString(2, request.getParameter("user_id"));
        ps.setString(3, uuid);
        ps.executeUpdate();

        connection.close();
    } catch (Exception ex) {
        errorMsg = "" + ex.getMessage();
        System.out.println("" + ex);
    }
%>
<%}%>
<%if (request.getParameter("addTeam") != null) {%>
<%
    try {

        Class.forName("com.mysql.jdbc.Driver");
        String url = "jdbc:mysql://localhost/test?zeroDateTimeBehavior=convertToNull";
        Connection connection = DriverManager.getConnection(url, "<USERNAME>", "<PASSWORD>");

        PreparedStatement ps = connection.prepareStatement("INSERT INTO test.TRUCKING_USER_teams_User(u_t_u_id, team_id, user_id, ts, company_id, created_by) VALUES (?,?,?,?,?,?)");
        ps.setString(1, UUID.randomUUID() + "");
        ps.setString(2, request.getParameter("team_id"));
        ps.setString(3, request.getParameter("user_id"));
        java.sql.Timestamp ts = new java.sql.Timestamp((new java.util.Date()).getTime());
        ps.setTimestamp(4, ts);
        ps.setString(5, uuid);
        ps.setString(6, (String) session.getAttribute("login_id"));
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
<body>


<!-- Fixed navbar -->

<%@include file="nav_menu.jsp"%>
<br><br><br>
<!-- Main page: -->


<div class="container">
    <div class="row">


        <div class="col-md-12">
            <div class="row">


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


                <a href="manage_users.jsp">
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
                </a>

         </div>
    </div>

        <div class="col-lg-12 col-sx-12">
            <div class="row">

                <form action="manage_teams.jsp" id="addtruckform" name="addtruckform" method="post"
                      class="form-horizontal" role="form" data-toggle="validator">


                    <div class="form-group">
                        <label class="col-lg-2 control-label">Team Name:</label>
                        <div class="col-lg-2">
                            <input class="form-control" type="text" name="team_name" placeholder="New York Eagles">
                            <div class="help-block with-errors"></div>
                        </div>
                        <div class="col-lg-2">
                            <input type="submit" class="btn btn-primary btn-block" style="background-color: #8B4513; border-color:#8B4513;" value="Add Team" name="submit1">
                        </div>
                    </div>
                </form>

            </div>
         </div>




        <div class="col-lg-12 col-sx-12">
            <div class="row">
                <!-- table starts -->

                <%if (true) {%>
                <%
                    try {
                        Class.forName("com.mysql.jdbc.Driver");
                        String url = "jdbc:mysql://localhost/test?zeroDateTimeBehavior=convertToNull";
                        Connection connection = DriverManager.getConnection(url, "<USERNAME>", "<PASSWORD>");

                        PreparedStatement psMain = null;
                        psMain = connection.prepareStatement("select * from test.TRUCKING_USER_teams_User WHERE COMPANY_ID = ?");
                        psMain.setString(1, uuid);
                        ResultSet resultSet = psMain.executeQuery();
                        HashMap user_teams = new HashMap();
                        HashMap user_teams_users = new HashMap();
                        HashMap user_teams_users_state = new HashMap();
                        while (resultSet.next()) {
                            user_teams.put(resultSet.getString("team_id") + resultSet.getString("user_id"), resultSet.getString("user_id"));
                            user_teams_users.put(resultSet.getString("user_id"), resultSet.getString("user_id"));
                        }
                        Vector userList = new Vector();
                        psMain = connection.prepareStatement("select * from test.TRUCKING_USERS WHERE COMPANY_ID = ? order by ts desc");
                        psMain.setString(1, uuid);
                        resultSet = psMain.executeQuery();
                        while (resultSet.next()) {
                            String[] userItem = new String[5];
                            userItem[0] = resultSet.getString("email");
                            userItem[1] = resultSet.getString("f_name");
                            userItem[2] = resultSet.getString("l_name");
                            userItem[3] = resultSet.getString("IS_ONLINE");
                            userList.add(userItem);
                        }
                        psMain = connection.prepareStatement("select * from test.TRUCKING_USER_teams_User_state WHERE COMPANY_ID = ?");
                        psMain.setString(1, uuid);
                        resultSet = psMain.executeQuery();
                        while (resultSet.next()) {
                            user_teams_users_state.put(resultSet.getString("user_state") + resultSet.getString("user_id") + resultSet.getString("team_id"), resultSet.getString("user_state") + resultSet.getString("user_id") + resultSet.getString("team_id"));
                        }
                        psMain = connection.prepareStatement("select * from test.TRUCKING_USER_teams WHERE COMPANY_ID = ?");
                        psMain.setString(1, uuid);
                        resultSet = psMain.executeQuery();

                        while (resultSet.next()) {
                %>




                <div class="portlet box blue">
                    <div class="portlet-title">
                        <div class="caption">
                            <i class="fa fa-group" style="margin-top: 2px;"></i><%=NullCheck.check(resultSet.getString("name"))%> </div>

                        <div class="caption" style="font-size: .8em; padding-left: 10px; color: lightgray">
                            Team Created:
                            <%

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
                            <%=timeDurration%>

                             | Team Created By: <%=NullCheck.check(resultSet.getString("created_by"))%>


                        </div>
                        <div class="tools">

                            <button class="btn btn-danger btn-xs"  role="button" onclick="location='manage_teams.jsp?removeTeam_id=<%=resultSet.getString("team_id")%>'" name="btn_save" id="btn_delete_team" ><span class="glyphicon glyphicon-trash" aria-hidden="true"></span>&nbsp;Delete Team</button>


                        </div>
                    </div>
                    <div class="portlet-body">
                        <div class="table-scrollable">
                            <table class="table table-striped table-hover">
                                <thead>
                                <tr>

                                    <th> Name </th>
                                    <th> Username </th>
                                    <th> Role </th>
                                    <th> Status </th>
                                    <th> Action </th>
                                </tr>
                                </thead>
                                <tbody>


                                <% int teamCount = 0;%>
                                <%for (int j = 0; j < userList.size(); j++) {%>
                                <%if (user_teams.containsKey(resultSet.getString("team_id") + ((String[]) userList.get(j))[0])) {%>

                                <tr>
                                    <td> <%=((String[])userList.get(j))[1]%> <%=((String[])userList.get(j))[2]%> </td>
                                    <td> <a href="user_profile_edit.jsp?user_id=<%=((String[])userList.get(j))[0]%>"
                                            >
                                        <%=((String[]) userList.get(j))[0]%>
                                        <%teamCount += 1;%>
                                    </td>
                                    <td>


                                        <label id="LM<%=((String[])userList.get(j))[0]%><%=resultSet.getString("team_id")%>">
                                            <input type="checkbox" style="color:black;"
                                                   name="M<%=((String[])userList.get(j))[0]%>"
                                                   id="M<%=((String[])userList.get(j))[0]%><%=resultSet.getString("team_id")%>"
                                                   onchange="updateStatus('<%=((String[])userList.get(j))[0]%>','Manager', '<%=resultSet.getString("team_id")%>')"
                                                   value="Yes"
                                                   <%if(user_teams_users_state.containsKey("Manager"+((String[])userList.get(j))[0]+ resultSet.getString("team_id"))){%>checked<%}%> >
                                            Manager
                                        </label>
                                        <label id="LS<%=((String[])userList.get(j))[0]%><%=resultSet.getString("team_id")%>">
                                            <input type="checkbox" name="S<%=((String[])userList.get(j))[0]%>"
                                                   id="S<%=((String[])userList.get(j))[0]%><%=resultSet.getString("team_id")%>"
                                                   onchange="updateStatus('<%=((String[])userList.get(j))[0]%>','Sales', '<%=resultSet.getString("team_id")%>')"
                                                   value="Yes"
                                                   <%if(user_teams_users_state.containsKey("Sales"+((String[])userList.get(j))[0]+ resultSet.getString("team_id"))){%>checked<%}%>>
                                            Sales
                                        </label>
                                        <label id="LD<%=((String[])userList.get(j))[0]%><%=resultSet.getString("team_id")%>">
                                            <input type="checkbox" name="D<%=((String[])userList.get(j))[0]%>"
                                                   id="D<%=((String[])userList.get(j))[0]%><%=resultSet.getString("team_id")%>"
                                                   onchange="updateStatus('<%=((String[])userList.get(j))[0]%>','Dispatcher', '<%=resultSet.getString("team_id")%>')"
                                                   value="Yes"
                                                   <%if(user_teams_users_state.containsKey("Dispatcher"+((String[])userList.get(j))[0]+ resultSet.getString("team_id"))){%>checked<%}%>>
                                            Dispatcher
                                        </label>
                                    </td>

                                    <td>

                                        <span class="label label-sm label-success"> Member </span><BR>


                                    </td>

                                    <td>

                                        <button class="btn btn-warning btn-xs"  role="button" onclick="location='manage_teams.jsp?removeFromTeam=Yes&team_id=<%=resultSet.getString("team_id")%>&user_id=<%=((String[])userList.get(j))[0]%>'" name="btn_save" id="btn_remove" ><span class="glyphicon glyphicon-remove" aria-hidden="true"></span>&nbsp;Remove</button>

                                    </td>

                                </tr>
                                    <%} else {%>
                                    <%}%>
                                    <%}%>




                                </tbody>
                            </table>
                        </div>

                        ** Add Users: ( click on username to add to the group )<br/>
                        <%for (int j = 0; j < userList.size(); j++) {%>
                        <%if (user_teams.containsKey(resultSet.getString("team_id") + ((String[]) userList.get(j))[0])) {%>
                        <%} else {%>
                        <a href="manage_teams.jsp?addTeam=Yes&team_id=<%=resultSet.getString("team_id")%>&user_id=<%=((String[])userList.get(j))[0]%>&tempId=Whatever"
                                <%if (user_teams_users.containsKey(((String[]) userList.get(j))[0])) {%>
                           style="color:orange"
                                <%} else {%>
                           style="color:green"
                                <%}%>

                        >
                            <%=((String[]) userList.get(j))[0]%>
                        </a>&nbsp;
                        <%}%>
                        <%}%>
                    </div>
                </div>


            <%}%>





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
