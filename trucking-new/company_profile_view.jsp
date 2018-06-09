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
    <title>Company Profile Edit - MYTRUCKBOARD 2.0 - dead simple freight dispatch</title>
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
    <link href="css/style-ultimate.css" rel="stylesheet">


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

</head>


<%
    String uuid = (String) session.getAttribute("uuid");
    String truck_count = "0";
    String team_name = "";
    boolean needStatusUpdate = false;
    if (uuid != null) {
%>
<%if (session.getAttribute("isAdmin").equals("true") && request.getParameter("cmd") != null && request.getParameter("cmd").equals("saveComment")) {%>
<%
    try {
        Class.forName("com.mysql.jdbc.Driver");
        String url = "jdbc:mysql://localhost/test?zeroDateTimeBehavior=convertToNull";
        Connection connection = DriverManager.getConnection(url, "<USERNAME>", "<PASSWORD>");
        PreparedStatement ps = connection.prepareStatement("Update test.TRUCKING_COMPANY Set NAME = ?, phone = ?, email = ?, address = ?, contact_name = ?, cover_time = ? where COMPANY_ID = ?");
        ps.setString(1, request.getParameter("name"));
        ps.setString(2, request.getParameter("phone"));
        ps.setString(3, request.getParameter("email"));
        ps.setString(4, request.getParameter("address"));
        ps.setString(5, request.getParameter("contact_name"));
        ps.setString(6, request.getParameter("cover_time"));
        ps.setString(7, uuid);

        ps.executeUpdate();

        if (request.getParameter("cover_time") != null)
            session.setAttribute("cover_time", request.getParameter("cover_time"));

        connection.close();


    } catch (Exception ex) {
%><%="Error Posting " + ex%><%
            System.out.println("" + ex);
        }
    }%>

<%if (request.getParameter("cmd") != null && request.getParameter("cmd").equals("saveprofileinfo")) {%>


<%
    try {
        Class.forName("com.mysql.jdbc.Driver");
        String url = "jdbc:mysql://localhost/test?zeroDateTimeBehavior=convertToNull";
        Connection connection = DriverManager.getConnection(url, "<USERNAME>", "<PASSWORD>");
        PreparedStatement ps2 = connection.prepareStatement("Update test.TRUCKING_USERS Set Phone = ?, l_name = ?, f_name = ? where email = ?");
        ps2.setString(1, request.getParameter("phone"));
        ps2.setString(2, request.getParameter("l_name"));
        ps2.setString(3, request.getParameter("f_name"));
        ps2.setString(4, (String) session.getAttribute("login_id"));
        ps2.executeUpdate();

        if (request.getParameter("f_name") != null) session.setAttribute("f_name", request.getParameter("f_name"));


        connection.close();

    } catch (Exception ex) {
%><%="Error Posting " + ex%><%
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

<%
    try {

        Class.forName("com.mysql.jdbc.Driver");
        String url = "jdbc:mysql://localhost/test?zeroDateTimeBehavior=convertToNull";
        Connection connection = DriverManager.getConnection(url, "<USERNAME>", "<PASSWORD>");


        PreparedStatement ps3 = connection.prepareStatement("select count(ID) as TruckCount from test.TRUCKING_EQUIPMENT where COMPANY_ID = ?");

        ps3.setString(1, uuid);
        ResultSet resultSetCount = ps3.executeQuery();
        while (resultSetCount.next()) {
            truck_count = resultSetCount.getString("TruckCount");
        }

        PreparedStatement psMain;

        HashMap userMap = new HashMap();
        psMain = connection.prepareStatement("select * from test.TRUCKING_USERS WHERE COMPANY_ID = ?");
        psMain.setString(1, uuid);
        ResultSet resultSet2 = psMain.executeQuery();
        while (resultSet2.next()) {
            String[] userItem = new String[4];
            userItem[0] = NullCheck.check(resultSet2.getString("email"));
            userItem[1] = NullCheck.check(resultSet2.getString("f_name"));
            userItem[2] = NullCheck.check(resultSet2.getString("l_name"));
            userItem[3] = NullCheck.check(resultSet2.getString("phone"));
            userMap.put(resultSet2.getString("email"), userItem);
        }

        psMain = connection.prepareStatement("select * from test.TRUCKING_USER_teams_User WHERE user_id = ? and company_id = ?");
        psMain.setString(1, (String) session.getAttribute("login_id"));
        psMain.setString(2, uuid);
        resultSet2 = psMain.executeQuery();
        HashMap user_teams = new HashMap();
        HashMap user_teams_users = new HashMap();
        while (resultSet2.next()) {
            psMain = connection.prepareStatement("select * from test.TRUCKING_USER_teams WHERE team_id = ?");
            psMain.setString(1, resultSet2.getString("team_id"));
            ResultSet resultTeamSet = psMain.executeQuery();
            while (resultTeamSet.next()) {

                team_name = resultTeamSet.getString("name");
            }
        }

        PreparedStatement ps = connection.prepareStatement("select * from test.TRUCKING_USERS where email = ? and company_id = ? ");
        ps.setString(1, (String) session.getAttribute("login_id"));
	ps.setString(2, uuid);
        ResultSet resultSet = ps.executeQuery();
        while (resultSet.next()) {


%>


<div class="container">
    <div class="row">

        <div class="col-md-offset-2 col-md-8 col-lg-offset-3 col-lg-6">
            <h2 style="text-align: center">My Profile</h2>
            <hr>
            <div class="col-sm-12">
                <div class="col-xs-12 col-sm-8">
                    <h2><%=NullCheck.check(resultSet.getString("f_name"))%> <%=NullCheck.check(resultSet.getString("l_name"))%>
                    </h2>
                    <p>Email: <strong><%=session.getAttribute("login_id")%>
                    </strong></p>
                    <p>Phone: <strong><%=NullCheck.check(resultSet.getString("phone"))%>
                    </strong></p>

                    <p>Team: <strong><%=team_name%>
                    </strong></p>

                    </p>
                </div>
                <div class="col-xs-12 col-sm-4 text-center">
                    <figure>
                        <img src="images/default-user-icon-profile.png" alt="" class="img-circle img-responsive">

                    </figure>
                </div>
            </div>
            <div class="col-xs-12 divider text-center">
                <div class="col-xs-12 col-sm-4 emphasis">

                    <button class="btn btn-success btn-block" onclick="window.location.href='manage_users.jsp'">
                        <span class="fa fa-user"></span> My Users
                    </button>
                </div>
                <div class="col-xs-12 col-sm-4 emphasis">


                    <button class="btn btn-info btn-block" onclick="window.location.href='company_profile_edit.jsp'">
                        <span class="fa fa-edit"></span> Edit My Profile
                    </button>

                </div>

                <div class="col-xs-12 col-sm-4 emphasis">
                    <button class="btn btn-success btn-block" onclick="window.location.href='manage_teams.jsp'">
                        <span class="fa fa-group"></span> My Teams
                    </button>
                </div>


                <%

                    }
                    connection.close();
                } catch (Exception ex) {
                %><%="Error Posting " + ex%><%
                    System.out.println("" + ex);
                }

            %>
                </ul>
            </div>
            <p>&nbsp</p>
        </div>



        <%
            try {

                Class.forName("com.mysql.jdbc.Driver");
                String url = "jdbc:mysql://localhost/test?zeroDateTimeBehavior=convertToNull";
                Connection connection = DriverManager.getConnection(url, "<USERNAME>", "<PASSWORD>");
                PreparedStatement ps = connection.prepareStatement("select * from test.TRUCKING_COMPANY where COMPANY_ID = ? ");
                ps.setString(1, uuid);
                ResultSet resultSet = ps.executeQuery();
                while (resultSet.next()) {
        %>


        <div class="col-md-offset-2 col-md-8 col-lg-offset-3 col-lg-6">
            <h2 style="text-align: center">Company Profile</h2>
            <hr>
            <div class="col-sm-12">
                <div class="col-xs-12 col-sm-8">
                    <h2><%=NullCheck.check(resultSet.getString("NAME"))%>
                    </h2>
                    <p>Account Owner: <strong><%=NullCheck.check(resultSet.getString("contact_name"))%>
                    </strong></p>
                    <p>Email: <strong><%=NullCheck.check(resultSet.getString("email"))%>
                    </strong></p>
                    <p>Phone: <strong><%=NullCheck.check(resultSet.getString("phone"))%>
                    </strong></p>
                    <p>Address: <strong><%=NullCheck.check(resultSet.getString("address"))%>
                    </strong></p>

                    </p>
                </div>
                <div class="col-xs-12 col-sm-4 text-center">
                    <figure>
                        <img src="images/default-company-icon-profile.png" alt="" class="img-circle img-responsive">

                    </figure>
                </div>
            </div>

            <div class="col-xs-12 divider text-center">
                <div class="col-xs-12 col-sm-4 emphasis">
                    <%if (session.getAttribute("isAd_account_only").equals("false")) {%>
                    <h2><strong><%=truck_count%>
                    </strong></h2>
                    <p>
                        <small>Trucks</small>
                    </p>
                    <%if (session.getAttribute("isAdmin").equals("true")) {%>
                    <button class="btn btn-success btn-block" onclick="window.location.href='add_truck.jsp'"><span
                            class="fa fa-truck"></span> Add Truck
                    </button>
                    <%}%>
                    <%}%>
                </div>
                <div class="col-xs-12 col-sm-4 emphasis">

                    <h2><strong>Company</strong></h2>
                    <p>
                        <small>Profile</small>
                    </p>
                    <%if (session.getAttribute("isAdmin").equals("true")) {%>
                    <button class="btn btn-info btn-block"
                            onclick="window.location.href='company_profile_edit.jsp#company'"><span
                            class="fa fa-building"></span> Edit Company
                    </button>
                    <%}%></div>

                <div class="col-xs-12 col-sm-4 emphasis">
                    <%if (session.getAttribute("isAd_account_only").equals("false")) {%>
                    <h2><strong> Active </strong></h2>
                    <p>
                        <small>Credit Card</small>
                    </p>
                    <%if (session.getAttribute("isAdmin").equals("true")) {%>
                    <button class="btn btn-success btn-primary"
                    onclick="window.location.href='subscription_manager.jsp'"><span class="fa fa-credit-card"></span> Update Billing
                    </button>
                    <%}%>
                    <%}%>
                </div>


                <%

                    }
                    connection.close();
                } catch (Exception ex) {
                %><%="Error Posting " + ex%><%
                    System.out.println("" + ex);
                }

            %>
                </ul>
            </div>
        </div>
    </div>

</div>
</div>
</div>
<br/>


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

<!---- end of gooogle analytics -->


</body>
</html>
<%} else {%>

<body>

<!-- if user's session expired - open the modal box: and upon clicking relogin - send them to the login page -->


<script type="text/javascript">
    $(window).load(function () {
        $('#relogin').modal('show');
    });
</script>


<div class="modal fade" id="relogin" role="dialog" aria-hidden="false" aria-labelledby="relogin">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title" id="myModalLabel" style="color:red">Session Expired</h4>
            </div>
            <div class="modal-body">
                <h3>Your session has expired. Please login.</h3>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-primary" onclick="location.href='https://www.mytruckboard.com'">
                    Login
                </button>

            </div>
        </div>
    </div>
</div>

</body>
</html>


<%}%>