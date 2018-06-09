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





        <div class="col-lg-12 col-sx-12">
            <div class="row">
            <h3>Use the following link to refer new customers</h3>
            Refferal Link:              
            https://www.mytruckboard.com/trucking-new/onboard.jsp?discount_code=<%=(String)session.getAttribute("login_id")%><BR>
            <BR>
            HTML CODE <BR>
            <textarea style="width:100%;">
            <a href="https://www.mytruckboard.com/trucking-new/onboard.jsp?discount_code=<%=(String)session.getAttribute("login_id")%>" >
            My Truck Board</a>
            </textarea>
            <hr>
                <!-- table starts -->

                <%if (true) {%>
                <%
                    try {
                        Class.forName("com.mysql.jdbc.Driver");
                        String url = "jdbc:mysql://localhost/test?zeroDateTimeBehavior=convertToNull";
                        Connection connection = DriverManager.getConnection(url, "<USERNAME>", "<PASSWORD>");

                        PreparedStatement psMain = connection.prepareStatement("select * from test.TRUCKING_COMPANY WHERE discount_code = ?");
                        psMain.setString(1, (String)session.getAttribute("login_id"));
                        ResultSet resultSet = psMain.executeQuery();

                        while (resultSet.next()) {
                %>




                <div class="portlet box blue">
                    <div class="portlet-title" style="padding:10px;">
                            <h4><%=NullCheck.check(resultSet.getString("name"))%></h4>
                            Registered On: <%=NullCheck.check(resultSet.getString("ts"))%>                           
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
