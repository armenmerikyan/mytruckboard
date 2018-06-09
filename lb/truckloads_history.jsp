<%@ page import="com.big.util.*,java.text.*,java.util.*,java.io.*,javax.xml.parsers.*,org.w3c.dom.*,java.sql.*,java.text.DateFormat" %>			
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
    <meta name="description" content="">
    <meta name="author" content="">
    <link rel="icon" href="../../favicon.ico">

    <title>LiteWorks2</title>
              <!-- Bootstrap core CSS -->
            <link href="css/bootstrap2.min.css" rel="stylesheet">

            <!-- Custom styles for this template -->
            <link href="css/navbar-fixed-top.css" rel="stylesheet">

            <!-- custom styles -->
            <link href="css/style-ultimate.css" rel="stylesheet">


    <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
    <!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
      <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->


    <link rel="stylesheet" href="css/bootstrap-datepicker3.min.css" />

    <!-- datepicker related -->

    <script type="text/javascript" src="js/jquery-2.1.3.min.js"></script>
    <script type="text/javascript" src="js/jquery-ui.min.js"></script>

    <script type="text/javascript" src="js/moment.js"></script>
    <!--<script type="text/javascript" src="js/transition.js"></script>
    <script type="text/javascript" src="js/collapse.js"></script>
    -->

    <script type="text/javascript" src="js/bootstrap-datetimepicker.min.js"></script>


    <!-- datepicker related -->


    <!-- Bootstrap core JavaScript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster -->
    <script src="js/bootstrap2.min.js"></script>


      

    <!-- custom maps markers -->
    <!--<script src="css/fontawesome-markers.min.js"></script>-->
<%
     final String ACCOUNT_SID = "ACbc6b5f29c1627c6aa7e51f5ad340fa2d";
     final String AUTH_TOKEN = "767154b209800bd1be13e38d8a01fc1b";
			
    String FROM = "info@mytruckboard.com";   // Replace with your "From" address. This address must be verified.
    String SMTP_USERNAME = "AKIAINFCRKGVZNSB7DHQ";  // Replace with your SMTP username.
    String SMTP_PASSWORD = "Ar/mcRQJkM9i7Vl45r+CzSrgx/QGb+vuJIuIDfJp/mj8";  // Replace with your SMTP password.
    String HOST = "email-smtp.us-east-1.amazonaws.com";    
    int PORT = 25;
			
				if(request.getParameter("pickCity")!=null)session.setAttribute("pickCity", request.getParameter("pickCity"));
				if(request.getParameter("pickCity_lat")!=null)session.setAttribute("pickCity_lat", request.getParameter("pickCity_lat"));
				if(request.getParameter("pickCity_lng")!=null)session.setAttribute("pickCity_lng", request.getParameter("pickCity_lng"));
				if(request.getParameter("pickState")!=null)session.setAttribute("pickState", request.getParameter("pickState"));
				if(request.getParameter("destCity")!=null)session.setAttribute("destCity", request.getParameter("destCity"));
				if(request.getParameter("destCity_lat")!=null)session.setAttribute("destCity_lat", request.getParameter("destCity_lat"));
				if(request.getParameter("destCity_lng")!=null)session.setAttribute("destCity_lng", request.getParameter("destCity_lng"));
				if(request.getParameter("destState")!=null)session.setAttribute("destState", request.getParameter("destState"));
				if(request.getParameter("distance")!=null)session.setAttribute("distance", request.getParameter("distance"));
				if(request.getParameter("duration")!=null)session.setAttribute("duration", request.getParameter("duration"));
				if(request.getParameter("searchKeyCity")!=null)session.setAttribute("searchKeyCity", request.getParameter("searchKeyCity"));
				if(request.getParameter("searchKeyState")!=null)session.setAttribute("searchKeyState", request.getParameter("searchKeyState"));
				if(request.getParameter("searchKeyCity_lat")!=null)session.setAttribute("searchKeyCity_lat", request.getParameter("searchKeyCity_lat"));
				if(request.getParameter("searchKeyCity_lng")!=null)session.setAttribute("searchKeyCity_lng", request.getParameter("searchKeyCity_lng"));
				if(request.getParameter("pac-input2")!=null)session.setAttribute("pac-input2", request.getParameter("pac-input2"));
				if(request.getParameter("pac-input")!=null)session.setAttribute("pac-input", request.getParameter("pac-input"));
				
			%>	  </head>
<!-- NAVBAR
================================================== -->
  <body onload="initialize()" >


<%@include file="nav_menu.jsp" %>


    <div class="container">
    <div class="row">


    <p>&nbsp;</p>
    <p>&nbsp;</p>


        <%
							DateFormat formatter = new SimpleDateFormat("MM-dd-yyyy");

							Class.forName("com.mysql.jdbc.Driver");
							String url = "jdbc:mysql://localhost/test?zeroDateTimeBehavior=convertToNull";

//							Class.forName("com.sap.dbtech.jdbc.DriverSapDB");
//							String url = "jdbc:sapdb://localhost/BIGDB?sqlmode=ORACLE";
							Connection connection = DriverManager.getConnection(url,"<USERNAME>", "<PASSWORD>");

							PreparedStatement ps = connection.prepareStatement("select * from test.TRUCKING_EQUIPMENT where ID = ? ");
							ps.setString(1, request.getParameter("id"));
							ResultSet resultSet = ps.executeQuery();
							while (resultSet.next()) {

%>

    <p></P>
    <p></P>




    <div class="col-md-offset-2 col-md-8 col-lg-offset-3 col-lg-6">
    <h2 style="text-align: center">Driver Details</h2>
    <hr>
    <div class="col-sm-12">
    <div class="col-xs-12 col-sm-8">
    <h2><%=NullCheck.check(resultSet.getString("CONTACT_PERSON"))%></h2>
    <p>Truck Trailer Type: <strong><%=NullCheck.check(resultSet.getString("NAME"))%></strong></p>
    <p>Email: <strong><%=NullCheck.check(resultSet.getString("driver_email"))%></strong></p>
    <p>Phone: <strong><%=NullCheck.check(resultSet.getString("PHONE"))%></strong></p>

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
    </div>

    <div class="col-xs-12 col-sm-4 emphasis">
    </div>

    </ul>
    </div><p>&nbsp</p>
    </div>

<br/><br/>
    <div class="col-md-offset-2 col-md-8 col-lg-offset-3 col-lg-6">
    <h2 style="text-align: center">Truckload History</h2>

    </div>


    </div>
    </div>

    <div class="navbar-wrapper">
    <div class="container">
    <div class="container marketing">

        <%}%>




    <div class="panel panel-success" id="line_item_detail" name="line_item_detail" >
  <table class="table table-hover">
    <thead>
      <tr>
        <th>Pickup</th>
        <th>Date</th>
        <th>Drop Off</th>
        <th>Date</th>
        <th>Status</th>
        <th>Cost</th>
        <th>Sale</th>
        <th>Date</th>
      </tr>
    </thead>
    <tbody>
    <%


							PreparedStatement psQ = connection.prepareStatement("select reject_status, completed_status, accept_status, pickup_date, drop_date, trucking_quote.quote_id, image_load_id, trucking_quote.ts, user_id, miscel_pay, miles, rate, truck_mpg, driver_pay_mpg, avg_diesel, status, pickCity, pickState, destCity, destState, (GLength(LineStringFromWKB(LineString(pickCityLocation, GeomFromText('POINT(" + request.getParameter("pickCity_lat") + " " + request.getParameter("pickCity_lng") + ")'))))) AS distanceFromPickCity, (GLength(LineStringFromWKB(LineString(pickCityLocation, GeomFromText('POINT(" + request.getParameter("destCity_lat") + " " + request.getParameter("destCity_lng") + ")'))))) AS distanceFromDestCity, (GLength(LineStringFromWKB(LineString(destCityLocation, GeomFromText('POINT(" + request.getParameter("pickCity_lat") + " " + request.getParameter("pickCity_lng") + ")'))))) AS ddistanceFromPickCity, (GLength(LineStringFromWKB(LineString(destCityLocation, GeomFromText('POINT(" + request.getParameter("destCity_lat") + " " + request.getParameter("destCity_lng") + ")'))))) AS ddistanceFromDestCity from test.trucking_quote LEFT JOIN maids_image_load ON trucking_quote.quote_id = maids_image_load.quote_id where equipment_id = ? order by ts desc  LIMIT 2400");
							psQ.setString(1, request.getParameter("id"));
							ResultSet resultSetQ = psQ.executeQuery();
							while (resultSetQ.next()) {

%>
 <tr>
	<td><a href="add_rate.jsp?id=<%=request.getParameter("id")%>&quote_id=<%=resultSetQ.getString("quote_id")%>" ><%if(resultSetQ.getString("pickCity")==null || resultSetQ.getString("pickCity").equals("")){%>No City<%}else{%><%=resultSetQ.getString("pickCity")%><%}%></a></td>
        <TD><%if(resultSetQ.getTimestamp("pickup_date")!=null){%><%=new SimpleDateFormat("MM-dd-yyyy hh:mm").format(resultSetQ.getTimestamp("pickup_date"))%><%}%></TD>
        <td><%=resultSetQ.getString("destCity")%></td>
        <TD><%if(resultSetQ.getTimestamp("drop_date")!=null){%><%=new SimpleDateFormat("MM-dd-yyyy hh:mm").format(resultSetQ.getTimestamp("drop_date"))%><%}%></TD>
        <td><%=NullCheck.check(resultSetQ.getString("accept_status"))%> <%=NullCheck.check(resultSetQ.getString("completed_status"))%> <%=NullCheck.check(resultSetQ.getString("reject_status"))%></td>
        <td><%=NullCheck.check(resultSetQ.getString("miscel_pay"))%></td>
        <td><%=resultSetQ.getString("rate")%></td>
        <TD><%=new SimpleDateFormat("MM-dd-yyyy hh:mm").format(resultSetQ.getTimestamp("TS"))%></TD>
      </tr>
      							<%}%>
    </tbody>
  </table>  
</div>
        </td>
      </tr>
      </tbody>
  </table>  
  </div><!-- /.col-lg-6 -->
</div>
      </div>		
      </div>



    <!-- /Main page -->
    <!-- .subfooter start -->
    <!-- ================ -->
    <section id="footer">
    <div class="copyright">
    <ul class="menu">
    <li>Copyright &copy; 2015 Litewsorks2 Inc. All rights reserved.</li>
    </ul>
    <ul class="menu">
    <li>&copy;<a href="http://liteworks2.com">Litewsorks2 Inc </a> </li>
    <li>599 Fairchild Dr, Mountain View, CA 94043 United States</li>
    <li>email: LW2@liteworks2.com </li>
    <li>twitter: @liteworks2</li>
    <li>voice: (650) 567-4439</li>
    </ul>
    </div>
    <!-- .subfooter end -->
    </section>

    
        </div><!-- /.container -->
    
    
    
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