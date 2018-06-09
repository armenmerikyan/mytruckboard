<%@ page import="com.big.util.*,java.text.*,java.util.*,java.io.*,javax.xml.parsers.*,org.w3c.dom.*,java.sql.*,java.text.DateFormat" %>
<!DOCTYPE html>
<html lang="en">

<%	String[] driver_state = {"OFFLINE", "SLEEPING", "RESTING", "DRIVING", "ONLINE"};%>
<%	String[] current_truck_type = {"DRY VAN TRUCK", "FLATBED TRUCK", "REEFER TRUCK", "BOX TRUCK", "CAR CARRIER TRUCK"};%>
<head>

    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="Lorry Board is the market for shipping over the road. Search for empty lorry, backhauling lorry, tractor-trailer, services online, GPS tracking">
    <meta name="keywords" content="Lorry load, load board, 3sixty, DAT, trucking freight, LTL, broker freight, Freight Transportation, lorry Flatbed Trucking, general loads, general freight" />
    <meta name="author" content="Liteworks2 Inc Armen Merikyan">

    <title>Lorry Board - Home</title>

    <!-- Bootstrap Core CSS -->
    <link href="css/bootstrap.min.css" rel="stylesheet">

    <!-- Custom CSS -->
    <link href="css/landing-page.css" rel="stylesheet">
    <link rel="shortcut icon" href="oneepmfavicon.ico" type="image/x-icon">
    <link rel="icon" href="oneepmfavicon.ico" type="image/x-icon">
    <!-- Custom Fonts -->
    <link href="font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css">
    <link href="https://fonts.googleapis.com/css?family=Lato:300,400,700,300italic,400italic,700italic" rel="stylesheet" type="text/css">

    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
        <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->

</head>

<body>

    <!-- Navigation -->
    <nav class="navbar navbar-default navbar-fixed-top topnav" role="navigation">
        <div class="container topnav">
            <!-- Brand and toggle get grouped for better mobile display -->
            <div class="navbar-header">
                <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1">
                    <span class="sr-only">Toggle navigation</span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </button>
                <a class="navbar-brand topnav" href="#">Lorry Board</a>
            </div>
            <!-- Collect the nav links, forms, and other content for toggling -->
            <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
                <ul class="nav navbar-nav navbar-right">
<!--
                    <li>
                        <a href="api-list.html">API</a>
                    </li>

                    <li>
                        <a href="blog-list.html">Blog</a>
                    </li>
                    <li>
                        <a href="#about">About</a>
                    </li>
                    <li>
                        <a href="#services">Services</a>
                    </li>
                    <li>
                        <a href="#contact">Contact</a>
                    </li>
-->
                </ul>
            </div>
            <!-- /.navbar-collapse -->
        </div>
        <!-- /.container -->
    </nav>


<BR><BR><BR>
<BR><BR><BR>
	<a  name="about"></a>
    <div class="content-section-a">

        <div class="container">
            <div class="row">
<table class="table table-hover table-striped">
<thead>
<tr>
<th><span class="glyphicon glyphicon-user" aria-hidden="true" ></span> Name</th>
<th><span class="glyphicon glyphicon-phone" aria-hidden="true" ></span> Want's To Go To'</th>
<th><span class="glyphicon glyphicon-envelope" aria-hidden="true" ></span> Company Name</th>
<th><span class="glyphicon glyphicon-globe" aria-hidden="true" ></span> Last Location</th>
<th><span class="glyphicon glyphicon-globe" aria-hidden="true" ></span> State</th>
<th><span class="glyphicon glyphicon-road" aria-hidden="true" ></span> Status</th>
<th><span class="glyphicon glyphicon-road" aria-hidden="true" ></span> Truck Type</th>
<th><span class="glyphicon glyphicon-dashboard" aria-hidden="true" ></span>  Speed</th>
<th><span class="glyphicon glyphicon-calendar" aria-hidden="true" ></span> Date Modified</th>
</tr>
</thead>
<tbody>


<%
try{
String searchSql = "";
Class.forName("com.mysql.jdbc.Driver");
String urldb = "jdbc:mysql://localhost/maids_oltp?user=<USER>&password=<PASSWORD>";
Connection connection = DriverManager.getConnection(urldb);


HashMap mainTruckMap = new HashMap();
DateFormat formatter = new SimpleDateFormat("MM/dd/yyyy.HH.mm.ss");
String pickCity_lng = "33";
String pickCity_lat = "-118";

PreparedStatement psMain = connection.prepareStatement("select current_State, currentTruckType, company_name, wtg, producttype, email, ts_last_update, speedcurrent, ts, key_public, phone, f_name, city, zip, state, email, X(location) as city_lat, Y(location) as city_lng , (GLength(LineStringFromWKB(LineString(location, GeomFromText('POINT(" + pickCity_lat + " " + pickCity_lng + ")'))))) AS distanceFromPickCity from maids_oltp.maids_customers where maids_customers.is_Not_Test_account is null and producttype is null order by distanceFromPickCity ");
if(request.getParameter("searchKey")!=null && !request.getParameter("searchKey").equals("")){
psMain = connection.prepareStatement("select producttype, email, ts_last_update, speedcurrent, ts, key_public, phone, f_name, city, zip, state, email, X(location) as city_lat, Y(location) as city_lng, (GLength(LineStringFromWKB(LineString(location, GeomFromText('POINT(" + pickCity_lat + " " + pickCity_lng + ")'))))) AS distanceFromPickCity from maids_oltp.maids_customers where maids_customers.f_name like ? and maids_customers.is_Not_Test_account is null and producttype is null order by distanceFromPickCity ");
psMain.setString(1,"%" + request.getParameter("searchKey") + "%");
}

ResultSet resultSet = psMain.executeQuery();
int j = 1;
while (resultSet.next()) {
if(resultSet.getString("distanceFromPickCity")!=null ){
j +=1;
//city_lat city_lng

String latLongString = resultSet.getFloat("city_lat") + " " + resultSet.getFloat("city_lng");
String[] dataSet = new String[10];
dataSet[0]=resultSet.getString("key_public");
dataSet[1]="";
dataSet[2]=resultSet.getString("f_name");
dataSet[3]="";
dataSet[4]=resultSet.getFloat("city_lat")+"";
dataSet[5]=resultSet.getFloat("city_lng")+"";
dataSet[6]=resultSet.getString("CITY")+"";
dataSet[7]=resultSet.getString("STATE")+"";
dataSet[8]=resultSet.getString("speedcurrent")+"";
dataSet[9]=resultSet.getString("email")+"";

System.out.println("EXECUTED DETAIL" + resultSet.getString("CITY"));
%>



<tr>
<td><a href="http://mytruckboard.com" >
<%if(NullCheck.check(resultSet.getString("f_name")).equals("")){%>[No Name]<%}else{%><%=resultSet.getString("f_name")%><%}%></a>
</td>
<td><%if(resultSet.getString("wtg")!=null && !resultSet.getString("wtg").equals("")){%><%=resultSet.getString("wtg")%><%}else{%>-<%}%></td>
<td><%if(resultSet.getString("company_name")!=null && !resultSet.getString("company_name").equals("")){%><%=resultSet.getString("company_name")%><%}else{%>-<%}%></td>
<!--
<td><%if(!resultSet.getString("phone").equals("") && resultSet.getString("phone").length()<15){%><%=resultSet.getString("phone")%><%}else{%>-<%}%>

</td>
<td><%if(resultSet.getString("email").length()>3){%><%=resultSet.getString("email")%><%}else{%>none<%}%>
</td>
-->
<td><%=NullCheck.check(resultSet.getString("CITY"))%></td>
<td><%=NullCheck.check(resultSet.getString("STATE"))%></td>
<% DecimalFormat format=new DecimalFormat("####.0");%>

<%
int currentState = 0;
int currentTruckType = 0;
if(resultSet.getString("current_State")!=null){
currentState = Integer.parseInt(resultSet.getString("current_State"));
}
if(resultSet.getString("currentTruckType")!=null){
currentTruckType = Integer.parseInt(resultSet.getString("currentTruckType"));
}
%>
<td align="right">
<B>[<%=driver_state[currentState]%>]</B></td>
<td align="right"><%=current_truck_type[currentTruckType]%>
</td>

<td align="right">
<%if(resultSet.getString("speedcurrent")!=null && resultSet.getFloat("speedcurrent")>0){%>
<%=format.format(resultSet.getFloat("speedcurrent"))%>
<small>mph.</small>
<%}else{%>
-
<%}%>
</td>
<td align="right">

<%if(resultSet.getTimestamp("ts_last_update")!=null){%>
<%
Calendar cal = Calendar.getInstance();
java.util.Date expireDate = cal.getTime();
java.util.Date jDate = new java.util.Date(resultSet.getTimestamp("ts_last_update").getTime());
Calendar jcal=Calendar.getInstance();
jcal.setTime(jDate);
jcal.add(Calendar.DAY_OF_MONTH, 2);
%>
<%if(cal.before(jcal)) {%>
<font color="blue"> <%=new SimpleDateFormat("MM-dd HH:mm").format(resultSet.getTimestamp("ts_last_update").getTime())%></font>
<%}else{%>
<font color="orange"> <%=new SimpleDateFormat("MM-dd HH:mm").format(resultSet.getTimestamp("ts_last_update").getTime())%></font>
<%}%>

<%}else{%>
<%=new SimpleDateFormat("MM-dd").format(resultSet.getDate("ts"))%>
<%}%>
</td>
<!--
<td width="50px"><img src="../AAA/getImageService.byCustomer.pub.id.jsp?client_id=<%=resultSet.getString("key_public")%>" width="100%" /></td>
-->
</tr>

<%
}
}


connection.close();
}catch (Exception ex){
%><%="Error Posting " + ex%><%
System.out.println(""+ ex);}
%>



</tbody>
</table>
            </div>

        </div>
        <!-- /.container -->

    </div>



    <!-- Footer -->
    <footer>
        <div class="container">
            <div class="row">
                <div class="col-lg-12">
                    <ul class="list-inline">
                        <li>
                            <a href="#">Powered by "My Truck Board"</a>
                        </li>
                    </ul>
                    <p class="copyright text-muted small">Copyright &copy; Lorry Board Enterprise Management Software 2017. All Rights Reserved</p>
                </div>
            </div>
        </div>
    </footer>

    <!-- jQuery -->
    <script src="js/jquery.js"></script>

    <!-- Bootstrap Core JavaScript -->
    <script src="js/bootstrap.min.js"></script>
<script>
(function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
(i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
})(window,document,'script','https://www.google-analytics.com/analytics.js','ga');

ga('create', 'UA-28886039-1', 'auto');
ga('send', 'pageview');

</script>
</body>

</html>
