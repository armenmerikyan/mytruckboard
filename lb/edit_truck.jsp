<%@ page import="com.big.mtb.business.Driver,org.apache.http.client.fluent.Form,org.apache.http.client.fluent.Request,org.apache.http.client.methods.HttpGet,org.apache.http.Header,org.apache.http.HttpResponse,org.apache.http.NameValuePair,org.apache.http.client.entity.UrlEncodedFormEntity,org.apache.http.message.BasicNameValuePair,org.apache.http.client.methods.HttpPost,org.apache.http.impl.client.DefaultHttpClient,org.apache.http.client.HttpClient,com.big.util.*,java.text.*,java.util.*,java.io.*,javax.xml.parsers.*,org.w3c.dom.*,java.sql.*,java.text.DateFormat" %>
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


    <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
    <!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
      <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->

    <!-- Bootstrap core JavaScript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster -->

    <script src="js/bootstrap2.min.js"></script>


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
        
        var input4 = /** @type {HTMLInputElement} */(
        document.getElementById('cityCurrent'));
        
        var autocomplete = new google.maps.places.Autocomplete(input);
        google.maps.event.addListener(autocomplete, 'place_changed', function() {
        var place = autocomplete.getPlace();
        if (!place.geometry) {
        return;
        }
        document.getElementById('city_lat').value = place.geometry.location.lat();
        document.getElementById('city_lng').value = place.geometry.location.lng();
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

        });
        
        var autocomplete4 = new google.maps.places.Autocomplete(input4);

        google.maps.event.addListener(autocomplete4, 'place_changed', function() {

        var place4 = autocomplete4.getPlace();

        if (!place4.geometry) {
        return;
        }
        document.getElementById('cityCurrent_lat').value = place4.geometry.location.lat();
        document.getElementById('cityCurrent_lng').value = place4.geometry.location.lng();

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

        <script type="text/javascript">
        $(function () {
        $('#datetimepicker3').datetimepicker({
        format: 'MM-DD-YYYY',
        showClear: true

        });
        });

        </script>

        <script>
        function addtrucksubmit() {

        document.getElementById('edittruckform').submit();
        }
        </script>



        <%
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
			%>


</head>


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
                        
                        xmlhttp.open("post", "logout.jsp?id=" + userID2 +"&GO" + gov ,true);
                                            //alert(imgicon);

                        // ajax_loader_blue_512
                        xmlhttp.send();

                        //window.location.href =  "../index4.html";

      }


        </script>


        <%
String uuid = (String)session.getAttribute("uuid");

boolean needStatusUpdate = false;
if(uuid !=null){
%>


    <body onload="initialize()">

<%if(session.getAttribute("isAdmin").equals("true") && request.getParameter("editform")!=null && request.getParameter("editform").equals("editform")){%>
    <script>
    $.notify(" You have successfully updded the truck info! ", "success"
    );
    </script>
        <%}%>

        <%if(session.getAttribute("isAdmin").equals("true") && request.getParameter("cmd")!=null && request.getParameter("cmd").equals("saveComment")){%>
        <%
		 try{
			DateFormat formatter = new SimpleDateFormat("MM-dd-yyyy.HH.mm.ss");
			java.sql.Date date_mod = null;
			java.sql.Date date_mod_ck = new java.sql.Date(Calendar.getInstance().getTime().getTime());
			date_mod = new java.sql.Date(((java.util.Date)formatter.parse(request.getParameter("date") + ".00.00.00" )).getTime());
			if(request.getParameter("dateCheckIn")!=null && !request.getParameter("dateCheckIn").equals(""))date_mod_ck = new java.sql.Date(((java.util.Date)formatter.parse(request.getParameter("dateCheckIn") + ".00.00.00" )).getTime());

			Class.forName("com.mysql.jdbc.Driver");
			String url = "jdbc:mysql://localhost/test?zeroDateTimeBehavior=convertToNull";

			String latLong = "POINT(1 2)";



	    String cityall = request.getParameter("city");
            String[] parts = cityall.split(",");
            String cityv = request.getParameter("city"); // get the city from the submitted form
            String statev = ""; // get the state from the submitted form
		if(parts.length>1){
             		cityv = parts[0]; // get the city from the submitted form
            		statev = parts[1]; // get the state from the submitted form
		}
            String cityvcr = request.getParameter("cityCurrent"); // get the city from the submitted form
            String statevcr = ""; // get the state from the submitted form
            cityall = request.getParameter("cityCurrent");
            parts = cityall.split(",");
		if(parts.length>1){
             		cityvcr = parts[0]; // get the city from the submitted form
            		statevcr = parts[1]; // get the state from the submitted form
		}
            String wtgall = request.getParameter("wtg");
            String[] parts2 = wtgall.split(",");
            String wtgv = request.getParameter("wtg"); // get the city from the submitted form
            String wtgstatev = ""; // get the state from the submitted form
		if(parts2.length>1){            
            wtgv = parts2[0]; // get the city from the submitted form
            wtgstatev = parts2[1]; // get the state from the submitted form
            	}


//			Class.forName("com.sap.dbtech.jdbc.DriverSapDB");
//			String url = "jdbc:sapdb://localhost/BIGDB?sqlmode=ORACLE";
			Connection connection = DriverManager.getConnection(url,"<USERNAME>", "<PASSWORD>");
			

			if(request.getParameter("isStatusChangeReset")!=null){
				System.out.println("Status Change " + request.getParameter("isStatusChangeReset"));
				PreparedStatement ps = connection.prepareStatement("Update test.TRUCKING_EQUIPMENT Set DATE_STATUS_CHANGE = ?, DATE_COVERED = ?, COVERED_BY = ?  where ID = ?");
				ps.setTimestamp(1, null);
				ps.setTimestamp(2, null);
				ps.setString(3, "");
				ps.setString(4, request.getParameter("id"));
				ps.executeUpdate();

				ps = connection.prepareStatement("INSERT INTO test.TRUCKING_EQUIPMENT_update(id, ts, equipment_id, company_id, type) VALUES (?,?,?,?,?)");
				ps.setString(1, UUID.randomUUID() + "");
				ps.setTimestamp(2, new java.sql.Timestamp((new java.util.Date()).getTime()));
				ps.setString(3, request.getParameter("id"));
				ps.setString(4, uuid);
				ps.setString(5, "Status Reset");
				ps.executeUpdate();
			}
			PreparedStatement ps = connection.prepareStatement("Update test.TRUCKING_EQUIPMENT Set NAME = ?, TRAILER = ?, CITY = ?, STATE = ?, WTG = ?, CONTACT_PERSON = ?, COVERED_BY = ?, COMMENTS = ?, ZONE = ?, DATE_MODIFIED = ? , SEARCH_KEYS = ?, ISONLINE = ?, HAUL = ? , TRUCKINFO = ?, PHONE = ?, FAX = ?, OWNER_NAME = ?, COMPANY_NAME = ?, MC_NO = ?, HOME_CITY = ?, LANGUAGE = ?, LOAD_TYPE = ?, LAST_MODIFIED_BY = ?, LAST_MODIFIED_DATE = ?, CITY_POINT = GeomFromText(?), WTG_POINT = GeomFromText(?), HOME_POINT = GeomFromText(?), DRIVER_EMAIL = ?, external_id = ?, dot_no = ?, currentCheckIndate = ?, currentcity_POINT = GeomFromText(?), currentcity = ? , currentstate = ?, password = ?  where ID = ? and company_id = ?");
			ps.setString(1, request.getParameter("equipment"));
			ps.setString(2, request.getParameter("trailer"));
			ps.setString(3, cityv);
			ps.setString(4, statev);
			ps.setString(5, wtgv);
			ps.setString(6, request.getParameter("contactPerson"));
			if(request.getParameter("isStatusChangeReset")!=null){
				ps.setString(7, "");
			}else{
				ps.setString(7, request.getParameter("coveredBy"));
			}
			ps.setString(8, request.getParameter("comments"));
			ps.setString(9, request.getParameter("zone"));
			ps.setDate(10, date_mod);
			ps.setString(11, (request.getParameter("equipment") + "<TAB>" + request.getParameter("trailer") + "<TAB>*"  + request.getParameter("city") + "<TAB>*" + request.getParameter("state") + "<TAB>"  + request.getParameter("wtg") + "<TAB>" + request.getParameter("contactPerson") + "<TAB>" + request.getParameter("comments") + "<TAB>" + request.getParameter("zone") + "<TAB>" + request.getParameter("coveredBy") + "<TAB>" + request.getParameter("truckInfo") + "<TAB>" +  request.getParameter("company_name") + "<TAB>").toUpperCase());
			if(request.getParameter("isOnlineradio").equals("isOnline")){
				ps.setBoolean(12, true);
			}else if(request.getParameter("isOnlineradio").equals("isOffline")){
				ps.setBoolean(12, false);
			}else{
				ps.setInt(12, 2);
			}
			ps.setString(13, request.getParameter("haul"));
			ps.setString(14, request.getParameter("truckInfo"));
			ps.setString(15, request.getParameter("phone"));
			ps.setString(16, request.getParameter("fax"));
			ps.setString(17, request.getParameter("owner_name"));
			ps.setString(18, request.getParameter("company_name"));
			ps.setString(19, request.getParameter("mc_no"));
			ps.setString(20, request.getParameter("home_city"));
			ps.setString(21, request.getParameter("language"));
			ps.setString(22, request.getParameter("loadType"));
			ps.setString(23, (String)session.getAttribute("login_id"));
			ps.setTimestamp(24, new java.sql.Timestamp((new java.util.Date()).getTime()));
			if(request.getParameter("city_lat")!=null && request.getParameter("city_lng")!=null){
				latLong = "POINT(" + request.getParameter("city_lat") + " " + request.getParameter("city_lng") + ")";
			}
			ps.setString(25, latLong);

			latLong = "POINT(1 2)";
			if(request.getParameter("city_lat")!=null && request.getParameter("city_lng")!=null){
				latLong = "POINT(" + request.getParameter("wtg_lat") + " " + request.getParameter("wtg_lng") + ")";
			}
			ps.setString(26, latLong);

			latLong = "POINT(1 2)";
			if(request.getParameter("city_lat")!=null && request.getParameter("city_lng")!=null){
				latLong = "POINT(" + request.getParameter("home_city_lat") + " " + request.getParameter("home_city_lng") + ")";
			}
			ps.setString(27, latLong);

			ps.setString(28, request.getParameter("driver_email"));
			ps.setString(29, request.getParameter("external_id"));
			ps.setString(30, request.getParameter("dot_no"));
			ps.setDate(31, date_mod_ck);
			latLong = "POINT(1 2)";
			if(request.getParameter("cityCurrent_lat")!=null && request.getParameter("cityCurrent_lng")!=null){
				latLong = "POINT(" + request.getParameter("cityCurrent_lat") + " " + request.getParameter("cityCurrent_lng") + ")";
			}			
			ps.setString(32, latLong);
			ps.setString(33, cityvcr);
			ps.setString(34, statevcr);
			ps.setString(35, request.getParameter("userp"));
			ps.setString(36, request.getParameter("id"));
			ps.setString(37, uuid);
			ps.executeUpdate();

			ps = connection.prepareStatement("INSERT INTO test.TRUCKING_EQUIPMENT_update(id, ts, equipment_id, company_id, type) VALUES (?,?,?,?,?)");
			ps.setString(1, UUID.randomUUID() + "");
			ps.setTimestamp(2, new java.sql.Timestamp((new java.util.Date()).getTime()));
			ps.setString(3, request.getParameter("id"));
			ps.setString(4, uuid);
			ps.setString(5, "Saved");
			ps.executeUpdate();
			
			if(request.getParameter("isStatusUpdateDriverBank")!=null){
				com.big.mtb.business.Driver newDriver = new com.big.mtb.business.Driver();
				newDriver.publishDriverToDriverBank(request.getParameter("id"), uuid);
			}
			connection.close();
		 }catch (Exception ex){
		     System.out.println(""+ ex);
		 }
				%>

        <%}%>

<!-- Fixed navbar -->

<%@include file="nav_menu.jsp"%>

<br><br><br>
<!-- Main page: -->


        <div class="container">
        <div class="row">


        <div class="col-lg-offset-2 col-lg-10">


        <div class="col-md-12">

        <%
						 try{

							DateFormat formatter = new SimpleDateFormat("MM-dd-yyyy");
							Class.forName("com.mysql.jdbc.Driver");
							String url = "jdbc:mysql://localhost/test?zeroDateTimeBehavior=convertToNull";

//							Class.forName("com.sap.dbtech.jdbc.DriverSapDB");
//							String url = "jdbc:sapdb://localhost/BIGDB?sqlmode=ORACLE";
							Connection connection = DriverManager.getConnection(url,"<USERNAME>", "<PASSWORD>");

							PreparedStatement ps = connection.prepareStatement("select password, X(currentcity_point) as currentcity_lat, Y(currentcity_point) as currentcity_lng, currentcheckindate, currentcity, currentstate, dot_no, external_id, id, driver_email, NAME, TRAILER, LOAD_TYPE, CITY, STATE, PHONE, ZONE, WTG, FAX, CONTACT_PERSON, LANGUAGE, HOME_CITY, COVERED_BY, DATE_MODIFIED, MC_NO, OWNER_NAME, COMPANY_NAME, ISONLINE, HAUL, TRUCKINFO, COMMENTS, X(city_point) as city_lat, Y(city_point) as city_lng, X(wtg_point) as wtg_lat, Y(wtg_point) as wtg_lng, X(home_point) as home_lat, Y(home_point) as home_lng from test.TRUCKING_EQUIPMENT where ID = ? ");
							ps.setString(1, request.getParameter("id"));
							ResultSet resultSet = ps.executeQuery();
							while (resultSet.next()) {

							%>

        <form action="edit_truck.jsp" id="edittruckform" name="edittruckform" method="post" class="form-horizontal" role="form">
        <div class="col-sm-8">
        <h3 style=" padding-left: 10px;">Edit Truck: <span style="color:grey"><%=NullCheck.check(resultSet.getString("CONTACT_PERSON"))%></span></h3>
         </div>
        <div class="col-sm-4">

        <input type="submit" class="btn btn-primary" value="Save" name="submit1" onclick="addtrucksubmit();">
        <span></span>
        </div>

        <hr style="margin-top: 10px; margin-bottom: 10px;">
        
        <div class="row">

        <!-- edit form column -->
        <div class="col-md-12 personal-info">

    <input type="hidden" name="editform" value="editform">
    <input type="hidden" name="cmd" value="saveComment">
    <input type="hidden" name="id" id="id" value="<%=request.getParameter("id")%>">


    <div class="form-group">
        <label class="col-sm-3 control-label">&nbsp;</label>
        <div class="col-sm-1">
        <label control-label">Reset Status</label>
         </div>
        <div class="col-sm-1">
        <input class="form-control" type="checkbox" style="width: 18px; height: 18px;" name="isStatusChangeReset">
        </div>

        <div class="col-sm-1">
        <label control-label">Update Bank</label>
        </div>
        <div class="col-sm-1">
        <input class="form-control" type="checkbox" style="width: 18px; height: 18px;" name="isStatusUpdateDriverBank">
        </div>        
        
        </div>

        <div class="form-group" style="margin-bottom: 8px;">
        <label class="col-sm-3 control-label">Truck Availability:</label>
        <div class="col-sm-4">

        <label style="color:green" ><input class="form-control" type="radio" name="isOnlineradio" value="isOnline" style="width: 18px; height: 18px;" <%if(resultSet.getInt("ISONLINE")==1){%>checked<%}%>> Available&nbsp;&nbsp;</label>
        <label style="color:red"><input class="form-control" type="radio" name="isOnlineradio" value="isOffline" style="width: 18px; height: 18px;" <%if(resultSet.getInt("ISONLINE")==0){%>checked<%}%>> Not Available</label>

        </div>
        </div>

    <div class="form-group" style="margin-bottom: 8px;">
    <label class="col-sm-3 control-label">Haul:</label>
    <div class="col-sm-6">
    <input type="hidden" name="isOnline" value="checked">
    <label style="color:green"><input class="form-control" type="radio" name="haul" value="Headhaul" id="Headhaul" style="width: 18px; height: 18px;"<%if(NullCheck.check(resultSet.getString("HAUL")).equals("Headhaul")){%>checked<%}%>>Headhaul&nbsp;&nbsp;</label>
    <label style="color:red"><input class="form-control" type="radio" name="haul" value="Backhaul" id="Backhaul"style="width: 18px; height: 18px;" <%if(NullCheck.check(resultSet.getString("HAUL")).equals("Backhaul")){%>checked<%}%>>Backhaul</label>

    </div>
    </div>




    <div class="form-group">
    <label class="col-sm-3 control-label">Comments:</label>
    <div class="col-sm-6">
    <textarea rows="3" class="form-control" type="text" name="comments"><%=NullCheck.check(resultSet.getString("COMMENTS"))%></textarea>
    </div>
    </div>

    <div class="form-group">
    <label class="col-sm-3 control-label">Truck Info:</label>
    <div class="col-sm-6">
    <textarea rows="3" class="form-control" type="text" name="truckInfo"><%=NullCheck.check(resultSet.getString("TRUCKINFO"))%></textarea>
    </div>
    </div>



    <div class="form-group">
    <label class="col-sm-3 control-label">Check-In Date:</label>


    <div class="col-sm-6" >

    <div class='input-group date' id='datetimepicker3'>
    <input type='text' name="dateCheckIn" id="dateCheckIn" class="form-control" <%if(resultSet.getDate("currentcheckindate")!=null){%>value="<%=formatter.format(resultSet.getDate("currentcheckindate"))%>"<%}%> >
    <span class="input-group-addon">
    <span class="glyphicon glyphicon-calendar"></span>
    </span>

    </div>

    </div>
    </div>
    
        <div class="form-group">
        <label class="col-sm-3 control-label">Current Location:</label>
        <div class="col-sm-6">
        <INPUT type="text" class="form-control" id="cityCurrent"  name="cityCurrent" <%if(resultSet.getString("currentCITY")!=null){%> value="<%=NullCheck.check(resultSet.getString("currentCITY"))%>,<%=NullCheck.check(resultSet.getString("currentSTATE"))%>" <%}%> >
             <input type="hidden" name="cityCurrent_lat" id="cityCurrent_lat" value="<%=NullCheck.check(resultSet.getString("currentCITY_LAT"))%>" >
             <input type="hidden" name="cityCurrent_lng" id="cityCurrent_lng" value="<%=NullCheck.check(resultSet.getString("currentCITY_LNG"))%>" >
        </div>
        </div>
        
    <div class="form-group">
    <label class="col-sm-3 control-label">Available Date:</label>


    <div class="col-sm-6" >

    <div class='input-group date' id='datetimepicker1'>
    <input type='text' name="date" id="date" class="form-control" value="<%=formatter.format(resultSet.getDate("DATE_MODIFIED"))%>" >
    <span class="input-group-addon">
    <span class="glyphicon glyphicon-calendar"></span>
    </span>

    </div>

    </div>
    </div>
        
        <div class="form-group">
        <label class="col-sm-3 control-label">Available Location:</label>
        <div class="col-sm-6">
        <INPUT type="text" class="form-control" id="pac-input"  name="city" value="<%=NullCheck.check(resultSet.getString("CITY"))%>,<%=NullCheck.check(resultSet.getString("STATE"))%>">
             <input type="hidden" name="city_lat" id="city_lat" value="<%=NullCheck.check(resultSet.getString("CITY_LAT"))%>">
             <input type="hidden" name="city_lng" id="city_lng" value="<%=NullCheck.check(resultSet.getString("CITY_LNG"))%>">

        </div>
        </div>

    <div class="form-group">
    <label class="col-sm-3 control-label">Wants to Go:</label>
    <div class="col-sm-6">
    <input class="form-control" type="text" name="wtg" id="pac-input3" value="<%=NullCheck.check(resultSet.getString("WTG"))%>">
    </div>
    </div>

    <div class="form-group">
    <label class="col-sm-3 control-label">Home City:</label>
    <div class="col-sm-6">
    <INPUT class="form-control" type="text" name="home_city" id="pac-input2" value="<%=NullCheck.check(resultSet.getString("HOME_CITY"))%>">

    <input type="hidden" name="home_cityState" id="home_cityState" value="">
    <input type="hidden" name="home_city_lat" id="home_city_lat" value="<%=NullCheck.check(resultSet.getString("HOME_LAT"))%>">
    <input type="hidden" name="home_city_lng" id="home_city_lng" value="<%=NullCheck.check(resultSet.getString("HOME_LNG"))%>">

    </div>
    </div>

        <div class="form-group">
        <label class="col-sm-3 control-label">Contact Name:</label>
        <div class="col-sm-6">
        <input class="form-control" type="text" name="contactPerson" value="<%=NullCheck.check(resultSet.getString("CONTACT_PERSON"))%>">
        </div>
        </div>
        <div class="form-group">
        <label class="col-sm-3 control-label">Email: [click to edit]</label>
        <div class="col-sm-6">
        <input readonly onfocus="this.removeAttribute('readonly');" class="form-control" type="text" name="driver_email" value="<%=NullCheck.check(resultSet.getString("driver_email"))%>">
        </div>
        </div>
        <div class="form-group">
        <label class="col-sm-3 control-label">Login Password: [click to edit]</label>
        <div class="col-sm-6">
        <input readonly onfocus="this.removeAttribute('readonly');" class="form-control" type="text" name="userp" value="<%=NullCheck.check(resultSet.getString("password"))%>">
        </div>
        </div>


    <div class="form-group">
    <label class="col-sm-3 control-label">Phone:</label>
    <div class="col-sm-6">
    <input class="form-control" type="text" name="phone" value="<%=NullCheck.check(resultSet.getString("PHONE"))%>">
    <input type="hidden" name="wtgState" id="wtgState" value="">
    <input type="hidden" name="wtg_lat" id="wtg_lat" value="<%=NullCheck.check(resultSet.getString("WTG_LAT"))%>">
    <input type="hidden" name="wtg_lng" id="wtg_lng" value="<%=NullCheck.check(resultSet.getString("WTG_LNG"))%>">
    </div>
    </div>



    <div class="form-group">
    <label class="col-sm-3 control-label">Equipment:</label>
    <div class="col-sm-6">
    <input class="form-control" type="text" name="equipment" value="<%=NullCheck.check(resultSet.getString("NAME"))%>">
    </div>
    </div>
    <div class="form-group">
    <label class="col-sm-3 control-label">Trailer:</label>
    <div class="col-sm-6">
    <select select class="form-control" type="text" name="trailer">
    <option value="53' Dry Van"<%if(resultSet.getString("TRAILER").equals("53' Dry Van")){%>selected<%}%> >53' Dry Van</option>
    <option value="45' Dry Van"<%if(resultSet.getString("TRAILER").equals("45' Dry Van")){%>selected<%}%> >45' Dry Van</option>
    <option value="Reefer" <%if(resultSet.getString("TRAILER").equals("Reefer")){%>selected<%}%> >Reefer</option>
    <option value="Van" <%if(resultSet.getString("TRAILER").equals("Van")){%>selected<%}%> >Van</option>
    <option value="Flatbed" <%if(resultSet.getString("TRAILER").equals("Flatbed")){%>selected<%}%> >Flatbed</option>
    <option value="Reefer Van Trailers"<%if(resultSet.getString("TRAILER").equals("Reefer Van Trailers")){%>selected<%}%> >Reefer Van Trailers</option>
    <option value="Flatbed Trailers"<%if(resultSet.getString("TRAILER").equals("Flatbed Trailers")){%>selected<%}%> >Flatbed Trailers</option>
    </select>

    </div>
    </div>

    <div class="form-group">
    <label class="col-sm-3 control-label">Load Type:</label>
    <div class="col-sm-6">
    <select class="form-control" name="loadType" >
    <option value="Regular" <%if(resultSet.getString("LOAD_TYPE") != null && resultSet.getString("LOAD_TYPE").equals("Regular")){%>selected<%}%>>Regular</option>
    <option value="Rush" <%if(resultSet.getString("LOAD_TYPE") != null && resultSet.getString("LOAD_TYPE").equals("Rush")){%>selected<%}%> >Rush</option>
    <option value="Partial" <%if(resultSet.getString("LOAD_TYPE") != null && resultSet.getString("LOAD_TYPE").equals("Partial")){%>selected<%}%> >Partial</option>
    <option value="In Transit" <%if(resultSet.getString("LOAD_TYPE") != null && resultSet.getString("LOAD_TYPE").equals("In Transit")){%>selected<%}%> >In Transit W/ Other Co.</option>
    </select>
    </div>
    </div>

    <div class="form-group">
    <label class="col-sm-3 control-label">Owner Name:</label>
    <div class="col-sm-6">
    <input class="form-control" type="text" name="owner_name" value="<%=NullCheck.check(resultSet.getString("OWNER_NAME"))%>">
    </div>
    </div>

    <div class="form-group">
    <label class="col-sm-3 control-label">Company Name:</label>
    <div class="col-sm-6">
    <input class="form-control" type="text" name="company_name" value="<%=NullCheck.check(resultSet.getString("COMPANY_NAME"))%>">
    </div>
    </div>



    <div class="form-group">
    <label class="col-sm-3 control-label">Language:</label>
    <div class="col-sm-6">
    <input class="form-control" type="text" name="language" value="<%=NullCheck.check(resultSet.getString("LANGUAGE"))%>">
    </div>
    </div>
        <div class="form-group">
        <label class="col-sm-3 control-label">MC NO:</label>
        <div class="col-sm-6">
        <input class="form-control" type="text" name="mc_no" value="<%=NullCheck.check(resultSet.getString("MC_NO"))%>">


        </div>
        </div>

        <div class="form-group">
        <label class="col-sm-3 control-label">DOT NO:</label>
        <div class="col-sm-6">
        <input class="form-control" type="text" name="dot_no" value="<%=NullCheck.check(resultSet.getString("dot_no"))%>">
        </div>
        </div>

    <div class="form-group">
    <label class="col-sm-3 control-label">Fax:</label>
    <div class="col-sm-6">
    <input class="form-control" type="text" name="fax" value="<%=NullCheck.check(resultSet.getString("FAX"))%>">
    </div>
    </div>


        <div class="form-group">
        <label class="col-sm-3 control-label"></label>
        <div class="col-sm-6">

        <input type="submit" class="btn btn-primary" value="Save" name="submit1" onclick="addtrucksubmit();">
        <span></span>
        <input type="reset" class="btn btn-default" value="Reset Info" >
        </div>
        </div>

                <%
                               Enumeration keys = request.getParameterNames();
                               while (keys.hasMoreElements() )
                               {
                                String key = (String)keys.nextElement();
                                String value = request.getParameter(key);
                                if(!key.equals("isStatusChangeReset") && !key.equals("cmd") && !key.equals("truckInfo") && !key.equals("comments")){
                               %>
            <input type="hidden" name="<%=key%>" value="<%=value%>">
                <%}%>
                <%}%>

                <%

                                    }
                                    connection.close();
                                 }catch (Exception ex){
                                     %><%="Error Posting " + ex%><%
                                     System.out.println(""+ ex);
                                 }

                                %>


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





    <div class="modal fade" id="logoutconfirm" role="dialog" aria-labelledby="logoutconfirm" aria-hidden="true">
    <div class="modal-dialog">
    <div class="modal-content">
    <div class="modal-header">
    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
    <h4 class="modal-title" id="myModalLabel" style="color:red">Logout Confirmation</h4>
    </div>
    <div class="modal-body">
    <h3>You have successfully logged out.</h3>
    </div>
    <div class="modal-footer">
    <button type="button" class="btn btn-primary" data-dismiss="modal" onclick="location.href='https://www.mytruckboard.com'">Dismiss</button>
    
    </div>
    </div>
    </div>
    </div>



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