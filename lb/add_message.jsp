    <%@ page import="com.big.util.*,java.text.*,java.util.*,java.io.*,javax.xml.parsers.*,org.w3c.dom.*,java.sql.*,java.text.DateFormat" %>
        <!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">
    <title>Send Message - MYTRUCKBOARD 2.0 - freight dispatch and management software</title>
        <link rel="shortcut icon" href="http://www.mytruckboard.com/trucking-new/images/mtb-favicon.ico">
        <meta http-equiv="content-type" content="text/html; charset=utf-8" />
        <meta name="description" content="The complete freight management software. Win shipping deals and manage your fleet of trucks effortlessly." />
        <meta name="keywords" content="freight, transportation, dispatch management, load optimization, truck broker, transportation management, truck, truck fleet management, shippers, truck brokers, shipping made easy, trucking industry, trucking software, trucking, dispatch for freight brokder, carrier management, load board, load, board" />

      <!-- Bootstrap core CSS -->
    <link href="css/bootstrap2.min.css" rel="stylesheet">

    <!-- Custom styles for this template -->
    <link href="css/navbar-fixed-top.css" rel="stylesheet">

    <!-- custom styles -->
        <link href="css/style-ultimate.css" rel="stylesheet">

        <link rel="stylesheet" href="css/bootstrap-datepicker3.min.css" />

        <!-- datepicker related -->


        <script type="text/javascript" src="js/jquery-2.1.3.min.js"></script>
        <script type="text/javascript" src="js/jquery-ui.min.js"></script>

        <script type="text/javascript" src="js/moment.js"></script>
        <script type="text/javascript" src="js/transition.js"></script>
        <script type="text/javascript" src="js/collapse.js"></script>


        <script type="text/javascript" src="js/notify.min.js"></script>



        <script type="text/javascript" src="js/bootstrap-datetimepicker.min.js"></script>

        <!-- form validation -->
        <script type="text/javascript" src="js/validator.js"></script>



        <!-- Bootstrap core JavaScript
        ================================================== -->

        <script src="js/bootstrap2.min.js"></script>


        <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
    <!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
      <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->


        <!-- Google api:-->
        <script src="https://maps.googleapis.com/maps/api/js?v=3.exp&signed_in=true&libraries=places"></script>
        <!-- end of google api -->





        <script language="JavaScript" type="text/javascript">

        function initialize() {

        var options = {
        types: ['(cities)'],
        componentRestrictions: {country: "us"}
        };

        var input = /** @type {HTMLInputElement} */(
        document.getElementById('pac-input'));

        var input2 = /** @type {HTMLInputElement} */(
        document.getElementById('pac-input2'));

        var input3 = /** @type {HTMLInputElement} */(
        document.getElementById('pac-input3'));

        var autocomplete = new google.maps.places.Autocomplete(input);

        google.maps.event.addListener(autocomplete, 'place_changed', function() {


        var place = autocomplete.getPlace();

        if (!place.geometry) {
        return;
        }


        document.getElementById('city_lat').value = place.geometry.location.lat();
        document.getElementById('city_lng').value = place.geometry.location.lng();

        // alert('city lat =');
        //alert(document.getElementById('city_lat').value);

        });


        var autocomplete2 = new google.maps.places.Autocomplete(input2);

        google.maps.event.addListener(autocomplete2, 'place_changed', function() {

        var place2 = autocomplete2.getPlace();

        if (!place2.geometry) {
        return;
        }


        document.getElementById('home_city_lat').value = place2.geometry.location.lat();
        document.getElementById('home_city_lng').value = place2.geometry.location.lng();

        //alert('home city lat =');
        //alert(document.getElementById('home_city_lat').value);

        });


        var autocomplete3 = new google.maps.places.Autocomplete(input3);

        google.maps.event.addListener(autocomplete3, 'place_changed', function() {

        var place3 = autocomplete3.getPlace();

        if (!place3.geometry) {
        return;
        }

        document.getElementById('wtg_lat').value = place3.geometry.location.lat();
        document.getElementById('wtg_lng').value = place3.geometry.location.lng();

        });

        }

        </script>

        <script type="text/javascript">
        $(function () {
        $('#datetimepicker1').datetimepicker({
        format: 'MM-DD-YYYY',
        showClear: true

        });
        });

        </script>

        <!-- this is notification   -->
        <script>
        function addMessage() {

        if (isDefaultPrevented()) {


        alert('missing required fields')
              } else {

        alert('submitting the form')

        document.getElementById('addtruckform').submit();



                    }
        }
        </script>



        </head>

            <%
String uuid = (String)session.getAttribute("uuid");
boolean needStatusUpdate = false;
if(uuid !=null){
%>
            <%if(session.getAttribute("isAdmin").equals("true") && request.getParameter("cmd")!=null && request.getParameter("cmd").equals("saveComment")){%>
            <%
		 try{

			Class.forName("com.mysql.jdbc.Driver");
			String url = "jdbc:mysql://localhost/test?user=<PASSWORD>&password=<PASSWORD>";
			Connection connection = DriverManager.getConnection(url,"<USERNAME>", "<PASSWORD>");
			DateFormat formatter = new SimpleDateFormat("MM-dd-yyyy.HH.mm.ss");
			DateFormat formatterDate = new SimpleDateFormat("MM-dd-yyyy");
			Calendar cal = Calendar.getInstance();
			java.sql.Date date_mod = null;
			if(request.getParameter("date")==null || request.getParameter("date").equals("")){
				date_mod = new java.sql.Date(((java.util.Date)formatter.parse(formatterDate.format(cal.getTime()) + ".00.00.00" )).getTime());
			}else{
				date_mod = new java.sql.Date(((java.util.Date)formatter.parse(request.getParameter("date") + ".00.00.00" )).getTime());
			}
			PreparedStatement ps = connection.prepareStatement("INSERT INTO test.maids_msg_board(ID, CITY, STATE, DATE_MODIFIED, COMMENTS, SEARCH_KEYS, COMPANY_ID, TRUCKINFO, HOME_CITY, CITY_POINT, HOME_POINT, external_id) VALUES (?,?,?,?,?,?,?,?,?,GeomFromText(?),GeomFromText(?), ?)");
			ps.setString(1, UUID.randomUUID() + "");
			ps.setString(2, "");
			ps.setString(3, "");
			ps.setDate(4, date_mod);
			ps.setString(5, request.getParameter("comments"));
			ps.setString(6, (request.getParameter("equipment") + "<TAB>" + request.getParameter("trailer") + "<TAB>*"  + request.getParameter("city") + "<TAB>*" + request.getParameter("state") + "<TAB>"  + request.getParameter("wtg") + "<TAB>" + request.getParameter("contactPerson") + "<TAB>" + request.getParameter("comments") + "<TAB>" + request.getParameter("zone") + "<TAB>"+ request.getParameter("coveredBy") + "<TAB>" + request.getParameter("truckInfo") + "<TAB>").toUpperCase());
			ps.setString(7, uuid);
			ps.setString(8, request.getParameter("truckInfo"));
			ps.setString(9, request.getParameter("home_city"));
			String latLong = "POINT(1 2)";
			if(request.getParameter("city_lat")!=null && request.getParameter("city_lng")!=null){
				latLong = "POINT(" + request.getParameter("city_lat") + " " + request.getParameter("city_lng") + ")";
			}
			ps.setString(10, latLong);
			latLong = "POINT(1 2)";
			if(request.getParameter("home_city_lat")!=null && request.getParameter("home_city_lng")!=null){
				latLong = "POINT(" + request.getParameter("home_city_lat") + " " + request.getParameter("home_city_lng") + ")";
			}
			ps.setString(11, latLong);
			ps.setString(12, request.getParameter("external_id"));

			ps.executeUpdate();

				ps = connection.prepareStatement("INSERT INTO test.trucking_msg_board_update(id, ts, user_id, company_id, type) VALUES (?,?,?,?,?)");
				ps.setString(1, UUID.randomUUID() + "");
				ps.setTimestamp(2, new java.sql.Timestamp((new java.util.Date()).getTime()));
				ps.setString(3, (String)session.getAttribute("login_id"));
				ps.setString(4, uuid);
				ps.setString(5, "Status Reset");
				ps.executeUpdate();
			
			connection.close();
		 }catch (Exception ex){
		     %><%="Error Posting " + ex%><%
		     System.out.println(""+ ex);
		 }
				%>

        <%}%>


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
                                            //alert(imgicon);

                        // ajax_loader_blue_512
                        xmlhttp.send();

                        //window.location.href =  "../index4.jsp";

      }


        </script>


     <body onload="initialize()">


            <%if(session.getAttribute("isAdmin").equals("true") && request.getParameter("cmd")!=null && request.getParameter("cmd").equals("saveComment")){%>
            <script>
            $.notify(" Your mesage has been sent! ", "success"
            );
            </script>
            <%}%>


<%@include file="nav_menu.jsp" %>


            <br><br><br>
<!-- Main page: -->


        <div class="container">
        <div class="row">


        <div class="col-lg-offset-2 col-lg-10">


        <div class="col-sm-10">


        <h1>Send Message</h1>
        <hr>
        <div class="row">

        <!-- edit form column -->
        <div class="col-md-12 personal-info">

        <form action="add_message.jsp" id="addtruckform" name="addtruckform" method="post" class="form-horizontal" role="form" data-toggle="validator">
        <input type="hidden" name="cmd" value="saveComment">
        <input type="hidden" name="id" value="<%=uuid%>">

        <div class="form-group">
        <label class="col-md-3 control-label">Message Effective Date:</label>


        <div class="col-md-6" >

        <div class='input-group date' id='datetimepicker1'>
        <input type='text' name="date" id="date" class="form-control">
        <span class="input-group-addon">
        <span class="glyphicon glyphicon-calendar"></span>
        </span>

        </div>

        </div>
        </div>
        <!--
        <div class="form-group">
        	<label class="col-md-3 control-label">Message From City:</label>
        	<div class="col-md-6">
        		<INPUT class="form-control" type="text" name="home_city" id="pac-input2" placeholder="City">

        		<input type="hidden" name="home_cityState" id="home_cityState" value="">
        		<input type="hidden" name="home_city_lat" id="home_city_lat">
        		<input type="hidden" name="home_city_lng" id="home_city_lng">
        	</div>
        </div>
        
        <div class="form-group">
        	<label class="col-md-3 control-label">Message To City:</label>
        	<div class="col-md-6">
        		<INPUT type="text" class="form-control" id="pac-input"  required name="city" placeholder="City">
        		<div class="help-block with-errors"></div>
        		<input type="hidden" name="city_lat" id="city_lat" value="test value city lat">
        		<input type="hidden" name="city_lng" id="city_lng">
        	</div>
        </div>
	-->


        <div class="form-group">
        <label class="col-md-3 control-label">Message to Users</label>
        <div class="col-md-6">
        <textarea rows="4" class="form-control" type="text" name="comments" placeholder=""></textarea>
        </div>
        </div>

        <div class="form-group">
        <label class="col-md-3 control-label">Admin Notes <br/><small>(viwed only by admins)</small></label>
        <div class="col-md-6">
        <textarea rows="4" class="form-control" type="text" name="truckInfo" placeholder=""></textarea>
        </div>
        </div>


        <div class="form-group">
        <label class="col-md-3 control-label"></label>
        <div class="col-md-6">

        <input type="submit" class="btn btn-primary" value="Send Message" name="submit1" onclick="addMessage();">
        <span></span>
        <input type="reset" class="btn btn-default" value="Reset Info" >
        </div>
        </div>
        </form>
        </div>
        </div>

        <hr>






        </ul>
        </div>
        </div>
        </div>

        </div>
        </div>
        </div>
       <br />

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
    <button type="button" class="btn btn-primary" data-dismiss="modal" onclick="location.href='../index4.jsp'">Dismiss</button>
    
    </div>
    </div>
    </div>
    </div>


    <!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
    <script src="assets/js/ie10-viewport-bug-workaround.js"></script>

    <!---- gooogle analytics -->

    <script type="text/javascript">

    var _gaq = _gaq || [];
    _gaq.push(['_setAccount', 'UA-28886039-1']);
    _gaq.push(['_trackPageview']);

    (function() {
    var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
    ga.src = ('https:' == document.location.protocol ? 'https://' : 'http://') + 'stats.g.doubleclick.net/dc.js';
    var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
    })();

    </script>
  </body>
</html>
 <%}else{%>

<body>

<!-- if user's session expired - open the modal box: and upon clicking relogin - send them to the login page -->


        <script type="text/javascript">
        $(window).load(function(){


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
        <button type="button" class="btn btn-primary" onclick="location.href='https://www.mytruckboard.com'">Login</button>

        </div>
        </div>
        </div>
        </div>

        </body>
        </html>



<%}%>