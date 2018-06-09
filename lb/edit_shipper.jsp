<%@ page import="org.apache.http.client.fluent.Form,org.apache.http.client.fluent.Request,org.apache.http.client.methods.HttpGet,org.apache.http.Header,org.apache.http.HttpResponse,org.apache.http.NameValuePair,org.apache.http.client.entity.UrlEncodedFormEntity,org.apache.http.message.BasicNameValuePair,org.apache.http.client.methods.HttpPost,org.apache.http.impl.client.DefaultHttpClient,org.apache.http.client.HttpClient,com.big.util.*,java.text.*,java.util.*,java.io.*,javax.xml.parsers.*,org.w3c.dom.*,java.sql.*,java.text.DateFormat" %>
        <!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">
    <title>Add Shipper - MYTRUCKBOARD 2.0 - freight dispatch and management software</title>
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
			date_mod = new java.sql.Date(((java.util.Date)formatter.parse(request.getParameter("date") + ".00.00.00" )).getTime());

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


			

//			Class.forName("com.sap.dbtech.jdbc.DriverSapDB");
//			String url = "jdbc:sapdb://localhost/BIGDB?sqlmode=ORACLE";
			Connection connection = DriverManager.getConnection(url,"<USERNAME>", "<PASSWORD>");
			
			PreparedStatement ps = connection.prepareStatement("Update test.TRUCKING_shipping Set NAME = ?, TRAILER = ?, CITY = ?, STATE = ?, CONTACT_PERSON = ?, COMMENTS = ?, DATE_MODIFIED = ? , ISONLINE = ?, TRUCKINFO = ?, PHONE = ?, FAX = ?, OWNER_NAME = ?, COMPANY_NAME = ?, HOME_CITY = ?, LANGUAGE = ?, LOAD_TYPE = ?, LAST_MODIFIED_BY = ?, LAST_MODIFIED_DATE = ?, CITY_POINT = GeomFromText(?), HOME_POINT = GeomFromText(?), DRIVER_EMAIL = ?, external_id = ? where ID = ?");
			ps.setString(1, request.getParameter("equipment"));
			ps.setString(2, request.getParameter("trailer"));
			ps.setString(3, cityv);
			ps.setString(4, statev);
			ps.setString(5, request.getParameter("contactPerson"));
			ps.setString(6, request.getParameter("comments"));
			ps.setDate(7, date_mod);
			if(request.getParameter("isOnlineradio").equals("isOnline")){
				ps.setBoolean(8, true);
			}else if(request.getParameter("isOnlineradio").equals("isOffline")){
				ps.setBoolean(8, false);
			}else{
				ps.setInt(8, 2);
			}
			ps.setString(9, request.getParameter("truckInfo"));
			ps.setString(10, request.getParameter("phone"));
			ps.setString(11, request.getParameter("fax"));
			ps.setString(12, request.getParameter("owner_name"));
			ps.setString(13, request.getParameter("company_name"));
			ps.setString(14, request.getParameter("home_city"));
			ps.setString(15, request.getParameter("language"));
			ps.setString(16, request.getParameter("loadType"));
			ps.setString(17, (String)session.getAttribute("login_id"));
			ps.setTimestamp(18, new java.sql.Timestamp((new java.util.Date()).getTime()));
			if(request.getParameter("city_lat")!=null && request.getParameter("city_lng")!=null){
				latLong = "POINT(" + request.getParameter("city_lat") + " " + request.getParameter("city_lng") + ")";
			}
			ps.setString(19, latLong);
			latLong = "POINT(1 2)";
			if(request.getParameter("city_lat")!=null && request.getParameter("city_lng")!=null){
				latLong = "POINT(" + request.getParameter("home_city_lat") + " " + request.getParameter("home_city_lng") + ")";
			}
			ps.setString(20, latLong);

			ps.setString(21, request.getParameter("driver_email"));
			ps.setString(22, request.getParameter("external_id"));
			ps.setString(23, request.getParameter("id"));
			ps.executeUpdate();
			

			ps = connection.prepareStatement("INSERT INTO test.TRUCKING_shipper_update(id, ts, equipment_id, company_id, type) VALUES (?,?,?,?,?)");
			ps.setString(1, UUID.randomUUID() + "");
			ps.setTimestamp(2, new java.sql.Timestamp((new java.util.Date()).getTime()));
			ps.setString(3, request.getParameter("id"));
			ps.setString(4, uuid);
			ps.setString(5, "Saved");
			ps.executeUpdate();
			connection.close();

		 }catch (Exception ex){
		     %><%="Error Posting " + ex%><%
		     System.out.println(""+ ex);
		 }
		 
				%>

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
                <li><a href="standard-truckboard.shippers.jsp">Shipping Board</a></li>
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


        <div class="col-lg-offset-2 col-lg-10">


        <div class="col-sm-10">

        <%
						 try{

							DateFormat formatter = new SimpleDateFormat("MM-dd-yyyy");
							Class.forName("com.mysql.jdbc.Driver");
							String url = "jdbc:mysql://localhost/test?zeroDateTimeBehavior=convertToNull";

//							Class.forName("com.sap.dbtech.jdbc.DriverSapDB");
//							String url = "jdbc:sapdb://localhost/BIGDB?sqlmode=ORACLE";
							Connection connection = DriverManager.getConnection(url,"<USERNAME>", "<PASSWORD>");

							PreparedStatement ps = connection.prepareStatement("select external_id, id, driver_email, NAME, TRAILER, LOAD_TYPE, CITY, STATE, PHONE, ZONE, FAX, CONTACT_PERSON, LANGUAGE, HOME_CITY, COVERED_BY, DATE_MODIFIED,  OWNER_NAME, COMPANY_NAME, ISONLINE, TRUCKINFO, COMMENTS, X(city_point) as city_lat, Y(city_point) as city_lng, X(home_point) as home_lat, Y(home_point) as home_lng from test.TRUCKING_Shipping where ID = ? ");
							ps.setString(1, request.getParameter("id"));
							ResultSet resultSet = ps.executeQuery();
							while (resultSet.next()) {

							%>

        <h3 style=" padding-left: 10px;">Edit Shipper: <span style="color:grey"><%=NullCheck.check(resultSet.getString("CONTACT_PERSON"))%></span></h3>
        <hr style="margin-top: 10px; margin-bottom: 10px;">
        <div class="row">

        <!-- edit form column -->
        <div class="col-md-12 personal-info">

        <form action="edit_shipper.jsp" id="edittruckform" name="edittruckform" method="post" class="form-horizontal" role="form">
    <input type="hidden" name="editform" value="editform">
    <input type="hidden" name="cmd" value="saveComment">
    <input type="hidden" name="id" id="id" value="<%=request.getParameter("id")%>">



        <div class="form-group" style="margin-bottom: 8px;">
        <label class="col-sm-3 control-label">Shipper Online:</label>
        <div class="col-sm-4">

        <label style="color:green" ><input class="form-control" type="radio" name="isOnlineradio" value="isOnline" style="width: 18px; height: 18px;" <%if(resultSet.getInt("ISONLINE")==1){%>checked<%}%>> Online&nbsp;&nbsp;</label>
        <label style="color:red"><input class="form-control" type="radio" name="isOnlineradio" value="isOffline" style="width: 18px; height: 18px;" <%if(resultSet.getInt("ISONLINE")==0){%>checked<%}%>> Offline</label>

        </div>
        </div>

    <div class="form-group">
    <label class="col-sm-3 control-label">Comments:</label>
    <div class="col-sm-8">
    <textarea rows="5" class="form-control" type="text" name="comments"><%=NullCheck.check(resultSet.getString("COMMENTS"))%></textarea>
    </div>
    </div>

    <div class="form-group">
    <label class="col-sm-3 control-label">Info:</label>
    <div class="col-sm-8">
    <textarea rows="5" class="form-control" type="text" name="truckInfo"><%=NullCheck.check(resultSet.getString("TRUCKINFO"))%></textarea>
    </div>
    </div>


        <div class="form-group">
        <label class="col-sm-3 control-label">Current Location:</label>
        <div class="col-sm-6">
        <INPUT type="text" class="form-control" id="pac-input"  name="city" value="<%=NullCheck.check(resultSet.getString("CITY"))%>,<%=NullCheck.check(resultSet.getString("STATE"))%>">
             <input type="hidden" name="city_lat" id="city_lat" value="<%=NullCheck.check(resultSet.getString("CITY_LAT"))%>">
             <input type="hidden" name="city_lng" id="city_lng" value="<%=NullCheck.check(resultSet.getString("CITY_LNG"))%>">

        </div>
        </div>


        <div class="form-group">
        <label class="col-sm-3 control-label">Contact Name:</label>
        <div class="col-sm-6">
        <input class="form-control" type="text" name="contactPerson" value="<%=NullCheck.check(resultSet.getString("CONTACT_PERSON"))%>">
        </div>
        </div>
        <div class="form-group">
        <label class="col-sm-3 control-label">Email:</label>
        <div class="col-sm-6">
        <input class="form-control" type="text" name="driver_email" value="<%=NullCheck.check(resultSet.getString("driver_email"))%>">
        </div>
        </div>


    <div class="form-group">
    <label class="col-sm-3 control-label">Available Date:</label>


    <div class="col-sm-6" >

    <div class='input-group date' id='datetimepicker1'>
    <input type='text' name="date" id="date" class="form-control" value="<%=formatter.format(resultSet.getDate("DATE_MODIFIED"))%>">
    <span class="input-group-addon">
    <span class="glyphicon glyphicon-calendar"></span>
    </span>

    </div>

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