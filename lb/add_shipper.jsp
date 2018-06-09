    <%@ page import="com.big.util.*,java.text.*,java.util.*,java.io.*,javax.xml.parsers.*,org.w3c.dom.*,java.sql.*,java.text.DateFormat" %>
        <!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">
    <title>Add Truck - MYTRUCKBOARD 2.0 - freight dispatch and management software</title>
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
        function addtrucksubmit() {

        if (isDefaultPrevented()) {
        alert('missing required fields')
        } else {
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


            String cityall = request.getParameter("city");
            String[] parts = cityall.split(",");
            String cityv = parts[0]; // get the city from the submitted form
            String statev = parts[1]; // get the state from the submitted form


            String wtgv = request.getParameter("wtg");

            if(request.getParameter("wtg")!=null){
            String wtgall = request.getParameter("wtg");
            String[] parts2 = wtgall.split(",");
            wtgv = parts2[0]; // get the city from the submitted form
            String wtgstatev = parts2[1]; // get the state from the submitted form
            }else{

            wtgv = request.getParameter("wtg");
            }


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
			PreparedStatement ps = connection.prepareStatement("INSERT INTO test.TRUCKING_shipping(ID, NAME, TRAILER, CITY, STATE, CONTACT_PERSON, DATE_MODIFIED, COMMENTS, ISONLINE, COMPANY_ID, TRUCKINFO, PHONE, FAX, OWNER_NAME, COMPANY_NAME, HOME_CITY, LANGUAGE, LOAD_TYPE, CITY_POINT, HOME_POINT, external_id, DRIVER_EMAIL) VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?, ?,GeomFromText(?),GeomFromText(?), ?, ?)");
			ps.setString(1, UUID.randomUUID() + "");
			ps.setString(2, request.getParameter("equipment"));
			ps.setString(3, request.getParameter("trailer"));
			ps.setString(4, cityv);
			ps.setString(5, statev);
			ps.setString(6, request.getParameter("contactPerson"));
			ps.setDate(7, date_mod);
			ps.setString(8, request.getParameter("comments"));
			ps.setBoolean(9, false);
			ps.setString(10, uuid);
			ps.setString(11, request.getParameter("truckInfo"));
			ps.setString(12, request.getParameter("phone"));
			ps.setString(13, request.getParameter("fax"));
			ps.setString(14, request.getParameter("owner_name"));
			ps.setString(15, request.getParameter("company_name"));
			ps.setString(16, request.getParameter("home_city"));
			ps.setString(17, request.getParameter("language"));
			ps.setString(18, request.getParameter("loadType"));

			String latLong = "POINT(1 2)";
			if(request.getParameter("city_lat")!=null && request.getParameter("city_lng")!=null){
				latLong = "POINT(" + request.getParameter("city_lat") + " " + request.getParameter("city_lng") + ")";
			}
			ps.setString(19, latLong);
			latLong = "POINT(1 2)";
			if(request.getParameter("home_city_lat")!=null && request.getParameter("home_city_lng")!=null){
				latLong = "POINT(" + request.getParameter("home_city_lat") + " " + request.getParameter("home_city_lng") + ")";
			}
			ps.setString(20, latLong);
			ps.setString(21, request.getParameter("external_id"));
			ps.setString(22, request.getParameter("driver_email"));

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
            $.notify(" You have added a new truck to your fleet! ", "success"
            );
            </script>
            <%}%>

    <!-- Fixed navbar -->
    <nav class="navbar navbar-default navbar-fixed-top">
      <div class="container">
        <div class="navbar-header">
          <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar">
            <span class="sr-only">Toggle navigation</span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
          </button>
                <a href="new_features.jsp"><span class="image" class="navbar-brand"  style="height: 35px; margin-left: 0px; padding: 10px 0px 0px; border-right-width: 0px;"><img src="images/mytryckboard_logo_v2i_small.png"></span></a>
                </div>
                <div id="navbar" class="navbar-collapse collapse">
                <ul class="nav navbar-nav">
                <li><a href="standard-truckboard.jsp">Truck Board</a></li>
                <li><a href="truckboard.jsp">Truck Board 2.0 <small><strong>(new)</strong></small></a></li>
                <li><a href="new_features.jsp">What's New</a></li>

        <li class="dropdown">

            <%if(session.getAttribute("msg_count")!=null && !session.getAttribute("msg_count").equals("")){%>

        <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">Messages <span class="badge" style="background:orangered;"><%=session.getAttribute("msg_count")%></span><span class="caret"></span></a>

            <%}else{%>

        <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">Messages <span class="caret"></span></a>
            <%}%>

        <ul class="dropdown-menu" role="menu">
                    <%if(session.getAttribute("isAdmin").equals("true")){%>
                <li><a href="add_message.jsp">Send Message</a></li><%}%>
                <li><a href="message_center.jsp">Message Center</a></li>

                </ul>
                </li>
                <li><a href="#" data-toggle="modal" data-target="#support">Support</a></li>

                </ul>

                <ul class="nav navbar-nav navbar-right">

                <li class="dropdown active">
                <a href="#" class="dropdown-toggle active" data-toggle="dropdown" role="button" aria-expanded="false">Hello <b><%=NullCheck.check((String)session.getAttribute("f_name"))%></b><span class="caret"></span></a>
                <ul class="dropdown-menu" role="menu">
                <li><a href="company_profile_view.jsp">My Account</a></li>
                    <%if(session.getAttribute("isAdmin").equals("true")){%>
                <li><a href="manage_users.jsp">My Users</a></li>
                <li><a href="add_user.jsp">Add User</a></li>
                <li><a href="add_truck.jsp">Add Truck</a></li>
                <li><a href="standard-truckboard.shippers.jsp">Shipper Board</a></li>
                    <%}%>

                <li><a href="javascript:void(0)" onclick="logoutuser('<%=session.getAttribute("uuid")%>')" data-toggle="modal" data-target="#logoutconfirm">Log Out</a></li>

                </ul>
                </ul>
                </div><!--/.nav-collapse -->
      </div>
    </nav>



            <br><br><br>
<!-- Main page: -->


        <div class="container">
        <div class="row">


        <div class="col-md-offset-2 col-md-10 col-lg-offset-3 col-lg-10">


        <div class="col-xs-12 col-sm-8">

        <h1>Add Shipper</h1>
        <hr>
        <div class="row">

        <!-- edit form column -->
        <div class="col-md-12 personal-info">

        <form action="add_shipper.jsp" id="addtruckform" name="addtruckform" method="post" class="form-horizontal" role="form" data-toggle="validator">
        <input type="hidden" name="cmd" value="saveComment">
        <input type="hidden" name="id" value="<%=uuid%>">
        <div class="form-group">
        <label class="col-sm-3 control-label">Shipper Name/ID:</label>
        <div class="col-lg-8">
        <input class="form-control form-control" type="text" required name="equipment" placeholder="Shipper Name">
        <div class="help-block with-errors"></div>
        </div>
        </div>
        <div class="form-group">
        <label class="col-sm-3 control-label">Trailer:</label>
        <div class="col-lg-8">
        <select class="form-control" type="text" name="trailer" >
                <option value="53' Dry Van" >53' Dry Van</option>
                <option value="48' Dry Van" >48' Dry Van</option>
                <option value="45' Dry Van" >45' Dry Van</option>
                <option value="32' Dry Van" >32' Dry Van</option>
                <option value="28' Dry Van" >28' Dry Van</option>
                <option value="Reefer Van Trailers" >Reefer Van Trailers</option>
                <option value="Flatbed Trailers" >Flatbed Trailers</option>
                <option value="ATV Trailers" >ATV Trailers</option>
                <option value="Belt Trailers" >Belt Trailers</option>
                <option value="Beverage Trailers" >Beverage Trailers</option>
                <option value="Bottom Dump Trailers" >Bottom Dump Trailers</option>
                <option value="Box Truck Straight Truck Trailers" >Box Truck Straight Truck Trailers</option>
                <option value="Cable Reel Trailer" >Cable Reel Trailer</option>
                <option value="Car Carrier Trailers" >Car Carrier Trailers</option>
                <option value="Car Hauler Trailers " >Car Hauler Trailers</option>
                <option value="Cargo Trailers" >Cargo Trailers</option>
                <option value="Chemical Trailers" >Chemical Trailers</option>
                <option value="Chipper Trailers" >Chipper Trailers</option>
                <option value="Chipper Truck Trailers" >Chipper Truck Trailers</option>
                <option value="Concession Trailers" >Concession Trailers</option>
                <option value="Container Trailers" >Container Trailers</option>
                <option value="Conventional - Day Cab Trailers" >Conventional - Day Cab Trailers</option>
                <option value="Curtain Side Van Trailers" >Curtain Side Van Trailers</option>
                <option value="Curtain Side Trailers" >Curtain Side Trailers</option>
                <option value="Deckover Trailers" >Deckover Trailers</option>
                <option value="Dolly Trailers" >Dolly Trailers</option>
                <option value="Double Drop Trailers" >Double Drop Trailers</option>
                <option value="Drop Deck Trailers" >Drop Deck Trailers</option>
                <option value="Drop Frame Trailers" >Drop Frame Trailers</option>
                <option value="Dry Van Trailers" >Dry Van Trailers</option>
                <option value="Dry Van Trailers" >Dry Van Trailers</option>
                <option value="Dump Trailers" >Dump Trailers</option>
                <option value="Enclosed Trailers" >Enclosed Trailers</option>
                <option value="End Dump Trailers" >End Dump Trailers</option>
                <option value="Equipment Trailers" >Equipment Trailers</option>
                <option value="Flat Deck Trailers" >Flat Deck Trailers</option>
                <option value="Flat Dovetail Trailers" >Flat Dovetail Trailers</option>
                <option value="Flatbed Truck Trailers" >Flatbed Truck Trailers</option>
                <option value="Frac Tank Trailers" >Frac Tank Trailers</option>
                <option value="Fuel Tank Trailers" >Fuel Tank Trailers</option>
                <option value="Gooseneck Trailers" >Gooseneck Trailers</option>
                <option value="Grain Trailers" >Grain Trailers</option>
                <option value="Heavy Equipment Trailers" >Heavy Equipment Trailers</option>
                <option value="Hopper Trailers" >Hopper Trailers</option>
                <option value="Horse Trailers" >Horse Trailers</option>
                <option value="Hot Oil Trailers" >Hot Oil Trailers</option>
                <option value="Hotshot Trailers" >Hotshot Trailers</option>
                <option value="Hotshot Trailers" >Hotshot Trailers</option>
                <option value="Landscape Trailers" >Landscape Trailers</option>
                <option value="Live Floor Trailers" >Live Floor Trailers</option>
                <option value="Livestock Trailers" >Livestock Trailers</option>
                <option value="Logger Trailers" >Logger Trailers</option>
                <option value="Lowboy Trailers" >Lowboy Trailers</option>
                <option value="Motorcycle Trailers" >Motorcycle Trailers</option>
                <option value="Moving Trailers" >Moving Trailers</option>
                <option value="Moving Van Trailers" >Moving Van Trailers</option>
                <option value="Oil Field Trailers" >Oil Field Trailers</option>
                <option value="Oil Field Trailers" >Oil Field Trailers</option>
                <option value="Open Top Trailers" >Open Top Trailers</option>
                <option value="Other Trailers" >Other Trailers</option>
                <option value="Other Truck Trailers" >Other Truck Trailers</option>
                <option value="Pole Trailers" >Pole Trailers</option>
                <option value="Pup Trailers" >Pup Trailers</option>
                <option value="Race Car Hauler Trailers" >Race Car Hauler Trailers</option>
                <option value="Ramp Trailers" >Ramp Trailers</option>
                <option value="Reefer Body Only Trailers" >Reefer Body Only Trailers</option>
                <option value="Refrigerated Truck Trailers" >Refrigerated Truck Trailers</option>
                <option value="Refuse Trailers" >Refuse Trailers</option>
                <option value="Roll Off Trailers" >Roll Off Trailers</option>
                <option value="Skid Steer Equipment Trailers" >Skid Steer Equipment Trailers</option>
                <option value="Storage Trailers" >Storage Trailers</option>
                <option value="Storage-Buildings Trailers" >Storage-Buildings Trailers</option>
                <option value="Tag-A-Long Trailers" >Tag-A-Long Trailers</option>
                <option value="Tandem Axle Trailers" >Tandem Axle Trailers</option>
                <option value="Tanker Trailers" >Tanker Trailers</option>
                <option value="Tilt Trailers" >Tilt Trailers</option>
                <option value="Trailers" >Trailers</option>
                <option value="Transfer Trailers" >Transfer Trailers</option>
                <option value="Traveling Axle Trailers" >Traveling Axle Trailers</option>
                <option value="Utility Trailers" >Utility Trailers</option>
                <option value="Vacuum Trailers" >Vacuum Trailers</option>
                <option value="Van Trailers" >Van Trailers</option>
                <option value="Van Trailers" >Van Trailers</option>
                <option value="Walking Floor Trailers" >Walking Floor Trailers</option>
                <option value="Water Trailers" >Water Trailers</option>
                <option value="Wood Floor Trailers" >Wood Floor Trailers</option>
        </select>

        </div>
        </div>

        <div class="form-group">
        <label class="col-sm-3 control-label">Load Type:</label>
        <div class="col-lg-8">
        <select class="form-control" name="loadType" >
        <option value="Regular" >Regular</option>
        <option value="Rush" >Rush</option>
        <option value="Partial" >Partial</option>
        <option value="In Transit" >In Transit W/ Other Co.</option>
        </select>
        </div>
        </div>

        <div class="form-group">
        <label class="col-sm-3 control-label">Current Location:</label>
        <div class="col-md-8">
        <INPUT type="text" class="form-control" id="pac-input"  required name="city" placeholder="City">
        <div class="help-block with-errors"></div>
        <input type="hidden" name="city_lat" id="city_lat" value="test value city lat">
        <input type="hidden" name="city_lng" id="city_lng">

        </div>
        </div>


        <div class="form-group">
        <label class="col-sm-3 control-label">Contact Name:</label>
        <div class="col-lg-8">
        <input class="form-control" type="text" required name="contactPerson" placeholder="Name">
        <div class="help-block with-errors"></div>
        </div>
        </div>
        <div class="form-group">
        <label class="col-sm-3 control-label">Email:</label>
        <div class="col-lg-8">
        <input class="form-control" type="email" required name="driver_email" placeholder="Email">
        <div class="help-block with-errors"></div>
        </div>
        </div>

        <div class="form-group">
        <label class="col-sm-3 control-label">Language:</label>
        <div class="col-md-8">
        <input class="form-control" type="text" name="language" placeholder="English">
        </div>
        </div>





        <div class="form-group">
        <label class="col-sm-3 control-label">Call Back Date:</label>


        <div class="col-md-8" >

        <div class='input-group date' id='datetimepicker1'>
        <input type='text' name="date" id="date" class="form-control">
        <span class="input-group-addon">
        <span class="glyphicon glyphicon-calendar"></span>
        </span>

        </div>

        </div>
        </div>





    <div class="form-group">
        <label class="col-sm-3 control-label">Company:</label>
        <div class="col-lg-8">
        <input class="form-control" type="text" name="company_name" placeholder="Company">
        </div>
        </div>

        <div class="form-group">
        <label class="col-sm-3 control-label">Phone:</label>
        <div class="col-md-8">
        <input type="phone" class="form-control" name="phone" required placeholder="Phone Number">
        <div class="help-block with-errors"></div>
        </div>
        </div>

        <div class="form-group">
        <label class="col-sm-3 control-label">Fax:</label>
        <div class="col-md-8">
        <input class="form-control" type="text" name="fax" placeholder="Fax Number">
        </div>
        </div>


        <div class="form-group">
        <label class="col-sm-3 control-label">Home City:</label>
        <div class="col-lg-8">
        <INPUT class="form-control" type="text" name="home_city" id="pac-input2" placeholder="Home City">

        <input type="hidden" name="home_cityState" id="home_cityState" value="">
        <input type="hidden" name="home_city_lat" id="home_city_lat">
        <input type="hidden" name="home_city_lng" id="home_city_lng">
        </div>
        </div>


        <div class="form-group">
        <label class="col-sm-3 control-label">Owner Name:</label>
        <div class="col-md-8">
        <input class="form-control" type="text" name="owner_name" placeholder="Name">
        </div>
        </div>


        <div class="form-group">
        <label class="col-sm-3 control-label">Info:</label>
        <div class="col-md-8">
        <textarea rows="4" class="form-control" type="text" name="truckInfo" placeholder=""></textarea>
        </div>
        </div>

        <div class="form-group">
        <label class="col-sm-3 control-label">Comments:</label>
        <div class="col-md-8">
        <textarea rows="4" class="form-control" type="text" name="comments" placeholder=""></textarea>
        </div>
        </div>


        <div class="form-group">
        <label class="col-sm-3 control-label"></label>
        <div class="col-md-8">

        <input type="submit" class="btn btn-primary" value="Add Shipper" name="submit1" onclick="addtrucksubmit();">
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