<%@ page import="org.apache.http.client.fluent.Form,org.apache.http.client.fluent.Request,org.apache.http.client.methods.HttpGet,org.apache.http.Header,org.apache.http.HttpResponse,org.apache.http.NameValuePair,org.apache.http.client.entity.UrlEncodedFormEntity,org.apache.http.message.BasicNameValuePair,org.apache.http.client.methods.HttpPost,org.apache.http.impl.client.DefaultHttpClient,org.apache.http.client.HttpClient,com.big.util.*,java.text.*,java.util.*,java.io.*,javax.xml.parsers.*,org.w3c.dom.*,java.sql.*,java.text.DateFormat" %>
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


        <script>
        function addcomment() {

        document.getElementById('addcommentform').submit();

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


     <body>



<%if(request.getParameter("addcomm")!=null && request.getParameter("addcomm").equals("addcomm") && ( request.getParameter("isCovered")==null || request.getParameter("isCovered")=="")) {%>
    <script>
    $.notify(" You have successfully added a comment! ", "success"
    );
    </script>
        <%}%>



        <%
String uuid = (String)session.getAttribute("uuid");
boolean needStatusUpdate = false;
if(uuid !=null){
%>
        <%if(request.getParameter("addcomm")!=null && request.getParameter("addcomm").equals("addcomm")){%>
        <%
		 try{
			Class.forName("com.mysql.jdbc.Driver");
			String url = "jdbc:mysql://localhost/test?zeroDateTimeBehavior=convertToNull";

//			Class.forName("com.sap.dbtech.jdbc.DriverSapDB");
//			String url = "jdbc:sapdb://localhost/BIGDB?sqlmode=ORACLE";
			Connection connection = DriverManager.getConnection(url,"<USERNAME>", "<PASSWORD>");



			if(request.getParameter("isCovered")!=null){
				if(request.getParameter("coveredBY")!=null && request.getParameter("coveredBY").equals("")){
					PreparedStatement ps = connection.prepareStatement("Update test.TRUCKING_EQUIPMENT Set COMMENTS = ?, COVERED_BY = ? , DATE_COVERED = ? where ID = ?");
					ps.setString(1, request.getParameter("comments"));
					ps.setString(2, (String)session.getAttribute("login_id"));
					ps.setTimestamp(3, new java.sql.Timestamp((new java.util.Date()).getTime()));
					ps.setString(4, request.getParameter("id"));
					ps.executeUpdate();

					ps = connection.prepareStatement("INSERT INTO test.TRUCKING_EQUIPMENT_update(id, ts, equipment_id, company_id, type) VALUES (?,?,?,?,?)");
					ps.setString(1, UUID.randomUUID() + "");
					ps.setTimestamp(2, new java.sql.Timestamp((new java.util.Date()).getTime()));
					ps.setString(3, request.getParameter("id"));
					ps.setString(4, uuid);
					ps.setString(5, "Covered Change");
					ps.executeUpdate();

				}else{
					%>

    <script>
    $.notify(" This Truck is covered by <%=request.getParameter("coveredBY")%> ", "error"
    );
    </script>
    <%
				}
			}else{
				PreparedStatement ps = connection.prepareStatement("Update test.TRUCKING_EQUIPMENT Set COMMENTS = ?, COVERED_BY = ?, DATE_COVERED = ? where ID = ?");
				ps.setString(1, request.getParameter("comments"));
				ps.setTimestamp(2, null);
				ps.setTimestamp(3, null);
				ps.setString(4, request.getParameter("id"));
				ps.executeUpdate();

				ps = connection.prepareStatement("INSERT INTO test.TRUCKING_EQUIPMENT_update(id, ts, equipment_id, company_id, type) VALUES (?,?,?,?,?)");
				ps.setString(1, UUID.randomUUID() + "");
				ps.setTimestamp(2, new java.sql.Timestamp((new java.util.Date()).getTime()));
				ps.setString(3, request.getParameter("id"));
				ps.setString(4, uuid);
				ps.setString(5, "Comment Change");
				ps.executeUpdate();
			}
			if(request.getParameter("isStatusChange")!=null){
				PreparedStatement ps = connection.prepareStatement("Update test.TRUCKING_EQUIPMENT Set DATE_STATUS_CHANGE = ? where ID = ?");
				ps.setTimestamp(1, new java.sql.Timestamp((new java.util.Date()).getTime()));
				ps.setString(2, request.getParameter("id"));
				ps.executeUpdate();

				ps = connection.prepareStatement("INSERT INTO test.TRUCKING_EQUIPMENT_update(id, ts, equipment_id, company_id, type) VALUES (?,?,?,?,?)");
				ps.setString(1, UUID.randomUUID() + "");
				ps.setTimestamp(2, new java.sql.Timestamp((new java.util.Date()).getTime()));
				ps.setString(3, request.getParameter("id"));
				ps.setString(4, uuid);
				ps.setString(5, "Status Change");
				ps.executeUpdate();

			}
			if(true){
				PreparedStatement ps = connection.prepareStatement("INSERT INTO test.Trucking_Comment_history(comment_id, equipment_id, company_id, created_by, ts, comment) VALUES (?,?,?,?,?,?)");
				ps.setString(1, UUID.randomUUID() + "");
				ps.setString(2, request.getParameter("id"));
				ps.setString(3, uuid);
				ps.setString(4, (String)session.getAttribute("login_id"));
				ps.setTimestamp(5, new java.sql.Timestamp((new java.util.Date()).getTime()));
				ps.setString(6, request.getParameter("comments"));
				ps.executeUpdate();

				ps = connection.prepareStatement("Update test.TRUCKING_EQUIPMENT Set LAST_MODIFIED_BY = ?, LAST_MODIFIED_DATE = ? where ID = ?");
				ps.setString(1, (String)session.getAttribute("login_id"));
				ps.setTimestamp(2, new java.sql.Timestamp((new java.util.Date()).getTime()));
				ps.setString(3, request.getParameter("id"));
				ps.executeUpdate();
			}
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

        <h1>Edit / Add Comment</h1>
        <hr>
        <div class="row">

        <!-- edit form column -->
        <div class="col-md-12 personal-info">

        <form action="add_comment.jsp" id="addcommentform" name="addcommentform" method="post" class="form-horizontal" role="form">
    <input type="hidden" name="addcomm" value="addcomm">
    <input type="hidden" name="cmd" value="saveComment">
        <%
					   Enumeration keys = request.getParameterNames();
					   while (keys.hasMoreElements() )
					   {

					   	String key = (String)keys.nextElement();
					   	String value = request.getParameter(key);
					   if(!key.equals("cmd") && !key.equals("truckInfo") && !key.equals("comments")){
                                       %>
                    <input type="hidden" name="<%=key%>" value="<%=value%>">
                        <%}%>
                        <%}%>

                        <input type="hidden" name="id" id="id" value="<%=request.getParameter("id")%>">
                         <%
						 try{

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

						if(resultSet.getTimestamp("DATE_COVERED")!=null){

						Calendar cal = Calendar.getInstance();
						java.util.Date expireDate = cal.getTime();
						java.util.Date jDate = new java.util.Date(resultSet.getTimestamp("DATE_COVERED").getTime());
						Calendar jcal=Calendar.getInstance();
						jcal.setTime(jDate);
						jcal.add(Calendar.MINUTE, 60);
						%>

                        <%if(cal.before(jcal)) {%>
                    <input type="hidden" name="coveredBY" value="<%=NullCheck.check(resultSet.getString("COVERED_BY"))%>">
                        <%}else{%>
                    <input type="hidden" name="coveredBY" value="">
                        <%}%>
                        <% }else{ %>
                    <input type="hidden" name="coveredBY" value="<%=NullCheck.check(resultSet.getString("COVERED_BY"))%>">
                        <% } %>

        <%if(resultSet.getTimestamp("DATE_STATUS_CHANGE")==null){%>
    <div class="form-group">
        <label class="col-md-3 control-label">Comments:</label>
        <div class="col-md-8">
        <textarea rows="10" class="form-control" type="text" name="comments"><%=NullCheck.check(resultSet.getString("COMMENTS"))%></textarea>
        </div>
        </div>
        <%}else{
        	needStatusUpdate = true;
			%>

    <div class="form-group">
    <label class="col-md-3 control-label">Comments:</label>
    <div class="col-md-8">
    <textarea rows="10" class="form-control" type="text" disabled><%=NullCheck.check(resultSet.getString("COMMENTS"))%></textarea>
    </div>
    </div>

        <%}%>

        <%if(resultSet.getTimestamp("DATE_STATUS_CHANGE")==null){%>
    <div class="form-group">
    <label class="col-md-3 control-label">Cover this truck:</label>
    <div class="col-md-3">

    <input class="form-control" type="checkbox" name="isCovered" value="isCovered">

    </div>
    </div>

    <div class="form-group">
    <label class="col-md-3 control-label">Need Status Changed:</label>
    <div class="col-md-3">

    <input class="form-control" type="checkbox" name="isStatusChange" value="isStatusChange">

    </div>
    </div>
        <%}%>

    <div class="form-group">
    <label class="col-md-3 control-label">Truck Availability:</label>
    <div class="col-md-3">

        <%if(resultSet.getBoolean("ISONLINE")){%><label style="color:green">Available</label>
        <%}else{%>
    <label style="color:red">Not Available</label>
        <%}%>

    </div>
    </div>


    <div class="form-group">
    <label class="col-md-3 control-label">Covered By:</label>
    <div class="col-md-6">
    <input class="form-control" type="text" name="coveredby" disabled value="<%=NullCheck.check(resultSet.getString("COVERED_BY"))%>">
    </div>
    </div>


    <div class="form-group">
    <label class="col-md-3 control-label">Available Date:</label>
    <div class="col-md-3">
    <input class="form-control" type="text" name="available_date" disabled value="<%=formatter.format(resultSet.getDate("DATE_MODIFIED"))%>">
    </div>
    </div>



            <div class="form-group">
            <label class="col-lg-3 control-label">Contact Name:</label>
            <div class="col-md-6">
            <input class="form-control" disabled type="text" name="contactPerson" value="<%=NullCheck.check(resultSet.getString("CONTACT_PERSON"))%>">
            </div>
            </div>
            <div class="form-group">
            <label class="col-lg-3 control-label">Email:</label>
            <div class="col-md-6">
            <input class="form-control" disabled type="text" name="driver_email" value="<%=NullCheck.check(resultSet.getString("driver_email"))%>">
            </div>
            </div>

            <div class="form-group">
            <label class="col-lg-3 control-label">Equipment:</label>
            <div class="col-md-6">
            <input class="form-control" disabled type="text" name="equipment" value="<%=NullCheck.check(resultSet.getString("NAME"))%>">
            </div>
            </div>
            <div class="form-group">
            <label class="col-lg-3 control-label">Trailer:</label>
            <div class="col-md-6">
            <select select class="form-control" disabled type="text" name="trailer">
            <option value="53' Dry Van"<%if(resultSet.getString("TRAILER").equals("53' Dry Van")){%>selected<%}%> >53' Dry Van</option>
            <option value="48' Dry Van"<%if(resultSet.getString("TRAILER").equals("48' Dry Van")){%>selected<%}%> >48' Dry Van</option>
            <option value="45' Dry Van"<%if(resultSet.getString("TRAILER").equals("45' Dry Van")){%>selected<%}%> >45' Dry Van</option>
            <option value="32' Dry Van"<%if(resultSet.getString("TRAILER").equals("32' Dry Van")){%>selected<%}%> >32' Dry Van</option>
            <option value="28' Dry Van"<%if(resultSet.getString("TRAILER").equals("28' Dry Van")){%>selected<%}%> >28' Dry Van</option>
            <option value="Reefer Van Trailers"<%if(resultSet.getString("TRAILER").equals("Reefer Van Trailers")){%>selected<%}%> >Reefer Van Trailers</option>
            <option value="Flatbed Trailers"<%if(resultSet.getString("TRAILER").equals("Flatbed Trailers")){%>selected<%}%> >Flatbed Trailers</option>
            <option value="ATV Trailers"<%if(resultSet.getString("TRAILER").equals("ATV Trailers")){%>selected<%}%> >ATV Trailers</option>
            <option value="Belt Trailers"<%if(resultSet.getString("TRAILER").equals("Belt Trailers")){%>selected<%}%> >Belt Trailers</option>
            <option value="Beverage Trailers"<%if(resultSet.getString("TRAILER").equals("Beverage Trailers")){%>selected<%}%> >Beverage Trailers</option>
            <option value="Bottom Dump Trailers"<%if(resultSet.getString("TRAILER").equals("Bottom Dump Trailers")){%>selected<%}%> >Bottom Dump Trailers</option>
            <option value="Box Truck - Straight Truck Trailers"<%if(resultSet.getString("TRAILER").equals("Box Truck - Straight Truck Trailers")){%>selected<%}%> >Box Truck - Straight Truck Trailers</option>
            <option value="Cable Reel Trailer"<%if(resultSet.getString("TRAILER").equals("Cable Reel Trailer")){%>selected<%}%> >Cable Reel Trailer</option>
            <option value="Car Carrier Trailers"<%if(resultSet.getString("TRAILER").equals("Car Carrier Trailers")){%>selected<%}%> >Car Carrier Trailers</option>
            <option value="Car Hauler Trailers"<%if(resultSet.getString("TRAILER").equals("Car Hauler Trailers")){%>selected<%}%> >Car Hauler Trailers</option>
            <option value="Cargo Trailers"<%if(resultSet.getString("TRAILER").equals("Cargo Trailers")){%>selected<%}%> >Cargo Trailers</option>
            <option value="Chemical Trailers"<%if(resultSet.getString("TRAILER").equals("Chemical Trailers")){%>selected<%}%> >Chemical Trailers</option>
            <option value="Chipper Trailers"<%if(resultSet.getString("TRAILER").equals("Chipper Trailers")){%>selected<%}%> >Chipper Trailers</option>
            <option value="Chipper Truck Trailers"<%if(resultSet.getString("TRAILER").equals("Chipper Truck Trailers")){%>selected<%}%> >Chipper Truck Trailers</option>
            <option value="Concession Trailers"<%if(resultSet.getString("TRAILER").equals("Concession Trailers")){%>selected<%}%> >Concession Trailers</option>
            <option value="Container Trailers"<%if(resultSet.getString("TRAILER").equals("Container Trailers")){%>selected<%}%> >Container Trailers</option>
            <option value="Conventional - Day Cab Trailers"<%if(resultSet.getString("TRAILER").equals("Conventional - Day Cab Trailers")){%>selected<%}%> >Conventional - Day Cab Trailers</option>
            <option value="Curtain Side Van Trailers"<%if(resultSet.getString("TRAILER").equals("Curtain Side Van Trailers")){%>selected<%}%> >Curtain Side Van Trailers</option>
            <option value="Curtain Side Trailers"<%if(resultSet.getString("TRAILER").equals("Curtain Side Trailers")){%>selected<%}%> >Curtain Side Trailers</option>
            <option value="Deckover Trailers"<%if(resultSet.getString("TRAILER").equals("Deckover Trailers")){%>selected<%}%> >Deckover Trailers</option>
            <option value="Dolly Trailers"<%if(resultSet.getString("TRAILER").equals("Dolly Trailers")){%>selected<%}%> >Dolly Trailers</option>
            <option value="Double Drop Trailers"<%if(resultSet.getString("TRAILER").equals("Double Drop Trailers")){%>selected<%}%> >Double Drop Trailers</option>
            <option value="Drop Deck Trailers"<%if(resultSet.getString("TRAILER").equals("Drop Deck Trailers")){%>selected<%}%> >Drop Deck Trailers</option>
            <option value="Drop Frame Trailers"<%if(resultSet.getString("TRAILER").equals("Drop Frame Trailers")){%>selected<%}%> >Drop Frame Trailers</option>
            <option value="Dry Van Trailers"<%if(resultSet.getString("TRAILER").equals("Dry Van Trailers")){%>selected<%}%> >Dry Van Trailers</option>
            <option value="Dry Van Trailers"<%if(resultSet.getString("TRAILER").equals("Dry Van Trailers")){%>selected<%}%> >Dry Van Trailers</option>
            <option value="Dump Trailers"<%if(resultSet.getString("TRAILER").equals("Dump Trailers")){%>selected<%}%> >Dump Trailers</option>
            <option value="Enclosed Trailers"<%if(resultSet.getString("TRAILER").equals("Enclosed Trailers")){%>selected<%}%> >Enclosed Trailers</option>
            <option value="End Dump Trailers"<%if(resultSet.getString("TRAILER").equals("End Dump Trailers")){%>selected<%}%> >End Dump Trailers</option>
            <option value="Equipment Trailers"<%if(resultSet.getString("TRAILER").equals("Equipment Trailers")){%>selected<%}%> >Equipment Trailers</option>
            <option value="Flat Deck Trailers"<%if(resultSet.getString("TRAILER").equals("Flat Deck Trailers")){%>selected<%}%> >Flat Deck Trailers</option>
            <option value="Flat Dovetail Trailers"<%if(resultSet.getString("TRAILER").equals("Flat Dovetail Trailers")){%>selected<%}%> >Flat Dovetail Trailers</option>
            <option value="Flatbed Trailers"<%if(resultSet.getString("TRAILER").equals("Flatbed Trailers")){%>selected<%}%> >Flatbed Trailers</option>
            <option value="Flatbed Truck Trailers"<%if(resultSet.getString("TRAILER").equals("Flatbed Truck Trailers")){%>selected<%}%> >Flatbed Truck Trailers</option>
            <option value="Frac Tank Trailers"<%if(resultSet.getString("TRAILER").equals("Frac Tank Trailers")){%>selected<%}%> >Frac Tank Trailers</option>
            <option value="Fuel Tank Trailers"<%if(resultSet.getString("TRAILER").equals("Fuel Tank Trailers")){%>selected<%}%> >Fuel Tank Trailers</option>
            <option value="Gooseneck Trailers"<%if(resultSet.getString("TRAILER").equals("Gooseneck Trailers")){%>selected<%}%> >Gooseneck Trailers</option>
            <option value="Grain Trailers"<%if(resultSet.getString("TRAILER").equals("Grain Trailers")){%>selected<%}%> >Grain Trailers</option>
            <option value="Heavy Equipment Trailers"<%if(resultSet.getString("TRAILER").equals("Heavy Equipment Trailers")){%>selected<%}%> >Heavy Equipment Trailers</option>
            <option value="Hopper Trailers"<%if(resultSet.getString("TRAILER").equals("Hopper Trailers")){%>selected<%}%> >Hopper Trailers</option>
            <option value="Horse Trailers"<%if(resultSet.getString("TRAILER").equals("Horse Trailers")){%>selected<%}%> >Horse Trailers</option>
            <option value="Hot Oil Trailers"<%if(resultSet.getString("TRAILER").equals("Hot Oil Trailers")){%>selected<%}%> >Hot Oil Trailers</option>
            <option value="Hotshot Trailers"<%if(resultSet.getString("TRAILER").equals("Hotshot Trailers")){%>selected<%}%> >Hotshot Trailers</option>
            <option value="Hotshot Trailers"<%if(resultSet.getString("TRAILER").equals("Hotshot Trailers")){%>selected<%}%> >Hotshot Trailers</option>
            <option value="Landscape Trailers"<%if(resultSet.getString("TRAILER").equals("Landscape Trailers")){%>selected<%}%> >Landscape Trailers</option>
            <option value="Live Floor Trailers"<%if(resultSet.getString("TRAILER").equals("Live Floor Trailers")){%>selected<%}%> >Live Floor Trailers</option>
            <option value="Livestock Trailers"<%if(resultSet.getString("TRAILER").equals("Livestock Trailers")){%>selected<%}%> >Livestock Trailers</option>
            <option value="Logger Trailers"<%if(resultSet.getString("TRAILER").equals("Logger Trailers")){%>selected<%}%> >Logger Trailers</option>
            <option value="Lowboy Trailers"<%if(resultSet.getString("TRAILER").equals("Lowboy Trailers")){%>selected<%}%> >Lowboy Trailers</option>
            <option value="Motorcycle Trailers"<%if(resultSet.getString("TRAILER").equals("Motorcycle Trailers")){%>selected<%}%> >Motorcycle Trailers</option>
            <option value="Moving Trailers"<%if(resultSet.getString("TRAILER").equals("Moving Trailers")){%>selected<%}%> >Moving Trailers</option>
            <option value="Moving Van Trailers"<%if(resultSet.getString("TRAILER").equals("Moving Van Trailers")){%>selected<%}%> >Moving Van Trailers</option>
            <option value="Oil Field Trailers"<%if(resultSet.getString("TRAILER").equals("Oil Field Trailers")){%>selected<%}%> >Oil Field Trailers</option>
            <option value="Oil Field Trailers"<%if(resultSet.getString("TRAILER").equals("Oil Field Trailers")){%>selected<%}%> >Oil Field Trailers</option>
            <option value="Open Top Trailers"<%if(resultSet.getString("TRAILER").equals("Open Top Trailers")){%>selected<%}%> >Open Top Trailers</option>
            <option value="Other Trailers"<%if(resultSet.getString("TRAILER").equals("Other Trailers")){%>selected<%}%> >Other Trailers</option>
            <option value="Other Truck Trailers"<%if(resultSet.getString("TRAILER").equals("Other Truck Trailers")){%>selected<%}%> >Other Truck Trailers</option>
            <option value="Pole Trailers"<%if(resultSet.getString("TRAILER").equals("Pole Trailers")){%>selected<%}%> >Pole Trailers</option>
            <option value="Pup Trailers"<%if(resultSet.getString("TRAILER").equals("Pup Trailers")){%>selected<%}%> >Pup Trailers</option>
            <option value="Race Car Hauler Trailers"<%if(resultSet.getString("TRAILER").equals("Race Car Hauler Trailers")){%>selected<%}%> >Race Car Hauler Trailers</option>
            <option value="Ramp Trailers"<%if(resultSet.getString("TRAILER").equals("Ramp Trailers")){%>selected<%}%> >Ramp Trailers</option>
            <option value="Reefer Body Only Trailers"<%if(resultSet.getString("TRAILER").equals("Reefer Body Only Trailers")){%>selected<%}%> >Reefer Body Only Trailers</option>
            <option value="Reefer Van Trailers"<%if(resultSet.getString("TRAILER").equals("Reefer Van Trailers")){%>selected<%}%> >Reefer Van Trailers</option>
            <option value="Refrigerated Truck Trailers"<%if(resultSet.getString("TRAILER").equals("Refrigerated Truck Trailers")){%>selected<%}%> >Refrigerated Truck Trailers</option>
            <option value="Refuse Trailers"<%if(resultSet.getString("TRAILER").equals("Refuse Trailers")){%>selected<%}%> >Refuse Trailers</option>
            <option value="Roll Off Trailers"<%if(resultSet.getString("TRAILER").equals("Roll Off Trailers")){%>selected<%}%> >Roll Off Trailers</option>
            <option value="Skid Steer Equipment Trailers"<%if(resultSet.getString("TRAILER").equals("Skid Steer Equipment Trailers")){%>selected<%}%> >Skid Steer Equipment Trailers</option>
            <option value="Storage Trailers"<%if(resultSet.getString("TRAILER").equals("Storage Trailers")){%>selected<%}%> >Storage Trailers</option>
            <option value="Storage-Buildings Trailers"<%if(resultSet.getString("TRAILER").equals("Storage-Buildings Trailers")){%>selected<%}%> >Storage-Buildings Trailers</option>
            <option value="Tag-A-Long Trailers"<%if(resultSet.getString("TRAILER").equals("Tag-A-Long Trailers")){%>selected<%}%> >Tag-A-Long Trailers</option>
            <option value="Tandem Axle Trailers"<%if(resultSet.getString("TRAILER").equals("Tandem Axle Trailers")){%>selected<%}%> >Tandem Axle Trailers</option>
            <option value="Tanker Trailers"<%if(resultSet.getString("TRAILER").equals("Tanker Trailers")){%>selected<%}%> >Tanker Trailers</option>
            <option value="Tilt Trailers"<%if(resultSet.getString("TRAILER").equals("Tilt Trailers")){%>selected<%}%> >Tilt Trailers</option>
            <option value="Trailers"<%if(resultSet.getString("TRAILER").equals("Trailers")){%>selected<%}%> >Trailers</option>
            <option value="Transfer Trailers"<%if(resultSet.getString("TRAILER").equals("Transfer Trailers")){%>selected<%}%> >Transfer Trailers</option>
            <option value="Traveling Axle Trailers"<%if(resultSet.getString("TRAILER").equals("Traveling Axle Trailers")){%>selected<%}%> >Traveling Axle Trailers</option>
            <option value="Utility Trailers"<%if(resultSet.getString("TRAILER").equals("Utility Trailers")){%>selected<%}%> >Utility Trailers</option>
            <option value="Vacuum Trailers"<%if(resultSet.getString("TRAILER").equals("Vacuum Trailers")){%>selected<%}%> >Vacuum Trailers</option>
            <option value="Van Trailers"<%if(resultSet.getString("TRAILER").equals("Van Trailers")){%>selected<%}%> >Van Trailers</option>
            <option value="Van Trailers"<%if(resultSet.getString("TRAILER").equals("Van Trailers")){%>selected<%}%> >Van Trailers</option>
            <option value="Walking Floor Trailers"<%if(resultSet.getString("TRAILER").equals("Walking Floor Trailers")){%>selected<%}%> >Walking Floor Trailers</option>
            <option value="Water Trailers"<%if(resultSet.getString("TRAILER").equals("Water Trailers")){%>selected<%}%> >Water Trailers</option>
            <option value="Wood Floor Trailers"<%if(resultSet.getString("TRAILER").equals("Wood Floor Trailers")){%>selected<%}%> >Wood Floor Trailers</option>
            <option value="Reefer" <%if(resultSet.getString("TRAILER").equals("Reefer")){%>selected<%}%> >Reefer</option>
            <option value="Van" <%if(resultSet.getString("TRAILER").equals("Van")){%>selected<%}%> >Van</option>
            <option value="Flatbed" <%if(resultSet.getString("TRAILER").equals("Flatbed")){%>selected<%}%> >Flatbed</option>
            </select>

            </div>
            </div>

            <div class="form-group">
            <label class="col-lg-3 control-label">Load Type:</label>
            <div class="col-md-6">
            <select class="form-control" disabled name="loadType" >
            <option value="Regular" <%if(resultSet.getString("LOAD_TYPE") != null && resultSet.getString("LOAD_TYPE").equals("Regular")){%>selected<%}%>>Regular</option>
            <option value="Rush" <%if(resultSet.getString("LOAD_TYPE") != null && resultSet.getString("LOAD_TYPE").equals("Rush")){%>selected<%}%> >Rush</option>
            <option value="Partial" <%if(resultSet.getString("LOAD_TYPE") != null && resultSet.getString("LOAD_TYPE").equals("Partial")){%>selected<%}%> >Partial</option>
            <option value="In Transit" <%if(resultSet.getString("LOAD_TYPE") != null && resultSet.getString("LOAD_TYPE").equals("In Transit")){%>selected<%}%> >In Transit W/ Other Co.</option>
            </select>
            </div>
            </div>

            <div class="form-group">
            <label class="col-md-3 control-label">Current Location:</label>
            <div class="col-md-6">
            <INPUT type="text" disabled class="form-control" name="city" value="<%=NullCheck.check(resultSet.getString("CITY"))%>">

            </div>
            </div>


        <%

							}
							connection.close();
						 }catch (Exception ex){
						     %><%="Error Posting " + ex%><%
						     System.out.println(""+ ex);
						 }

						%>

        <div class="form-group">
        <label class="col-md-3 control-label"></label>
        <div class="col-md-6">

        <input type="submit" class="btn btn-primary" value="Save" name="submit1" onclick="addcomment();">
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
    <button type="button" class="btn btn-primary" data-dismiss="modal" onclick="location.href='../index4.jsp'">Dismiss/button>
    
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