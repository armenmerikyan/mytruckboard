<%@ page import="com.big.util.*,java.text.*,java.util.*,java.io.*,javax.xml.parsers.*,org.w3c.dom.*,java.sql.*,java.text.DateFormat" %>


	<html>

	<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<meta name="description" content="">
	<meta name="author" content="">
	<title>MYTRUCKBOARD 2.0 - dead simple freight dispatch</title>
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
    <!-- datepicker related
    <script type="text/javascript" src="js/transition.js"></script>
    <script type="text/javascript" src="js/collapse.js"></script>-->


    <script type="text/javascript" src="js/bootstrap-datetimepicker.min.js"></script>

	<!-- datepicker related -->

    <script type="text/javascript" src="js/notify.min.js"></script>

	<!--<script type="text/javascript"
	src="https://maps.googleapis.com/maps/api/js?key=AIzaSyBpeQ3zGuTunYzxmiNMUltHL352e4beac4">
	</script>
	-->

    <!-- table sorter -->

	<script type="text/javascript" src="js/jquery.tablesorter.js"></script>
	<!-- end -->

	<!-- Bootstrap core JavaScript
	================================================== -->
	<script src="js/bootstrap2.min.js"></script>


		<%if(session.getAttribute("issubscribed")!=null && session.getAttribute("issubscribed").equals("true")){%>
		<%
			String uuid = (String)session.getAttribute("uuid");
			String isShowMoreCol = (String)session.getAttribute("isShowMoreCol");
			if(uuid !=null){
%>



	<!-- Google api:-->
    <script src="https://maps.googleapis.com/maps/api/js?v=3.exp&signed_in=true&libraries=places&?key=AIzaSyBpeQ3zGuTunYzxmiNMUltHL352e4beac4"></script>
    <!-- end of google api -->





		<%
			Class.forName("com.mysql.jdbc.Driver");
			String url = "jdbc:mysql://localhost/test?zeroDateTimeBehavior=convertToNull";
			Connection connection = DriverManager.getConnection(url,"<USERNAME>", "<PASSWORD>");
			PreparedStatement psMain = null;
			if(session.getAttribute("IS_SHOW_MORE_COL").equals("true") && request.getParameter("IS_SHOW_MORE_COL")==null && request.getParameter("Go")!=null){
				psMain = connection.prepareStatement("Update test.trucking_users SET IS_SHOW_MORE_COL = ? WHERE EMAIL = ?");
				psMain.setBoolean(1, false);
				psMain.setString(2, (String)session.getAttribute("login_id"));
				psMain.executeUpdate();
				session.setAttribute("IS_SHOW_MORE_COL", "false");
			}
			if(!session.getAttribute("IS_SHOW_MORE_COL").equals("true") && request.getParameter("IS_SHOW_MORE_COL")!=null && request.getParameter("Go")!=null){
				psMain = connection.prepareStatement("Update test.trucking_users SET IS_SHOW_MORE_COL = ? WHERE EMAIL = ?");
				psMain.setBoolean(1, true);
				psMain.setString(2, (String)session.getAttribute("login_id"));
				psMain.executeUpdate();
				session.setAttribute("IS_SHOW_MORE_COL", "true");
			}
			%>
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


    var autocomplete = new google.maps.places.Autocomplete(input);

    google.maps.event.addListener(autocomplete, 'place_changed', function() {


    var place = autocomplete.getPlace();

    if (!place.geometry) {
    return;
    }


    document.getElementById('pickCity_lat').value = place.geometry.location.lat();
    document.getElementById('pickCity_lng').value = place.geometry.location.lng();


    });


    var autocomplete2 = new google.maps.places.Autocomplete(input2);

    google.maps.event.addListener(autocomplete2, 'place_changed', function() {

    var place2 = autocomplete2.getPlace();

    if (!place2.geometry) {
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

    $('#datetimepicker2').datetimepicker({
    format: 'MM-DD-YYYY',
    showClear: true

    });
    });

    </script>






    <script type="text/javascript">

    function deleteTruck(link_file_name, truck_id){
    var urlString = link_file_name + "?id=" + truck_id;

    window.location.href =  urlString;
    };
    </script>

    <script>


    function setTruckId(trucktodel_id){

    var truck_id = '';
    truck_id = trucktodel_id;

    document.getElementById('trucktodelete').value = truck_id;
    //alert(truck_id);

    }

    $(document).ready(function() {

    $('#deleteonclick').click(function () {


    var truck_id ='';

    truck_id = document.getElementById('trucktodelete').value;
    //alert(truck_id);

    deleteTruck('removetruck.jsp', truck_id);

    })
    });

    </script>

	<script>
	$(document).ready(function(){

	$("#boardtable").tablesorter();

	});
	</script>


	<script type="text/javascript">
		var itemListLabel ;
		var itemListMain ;
	    function getLinkwithForm(link_file_name, equipmentID){
		var urlString = link_file_name + "&id=" + equipmentID;		
		var formF = document.getElementsByTagName("input");
		for(var j = 0; j<formF.length;j++){
			urlString = urlString + "&" + formF[j].name + "=" + encodeURIComponent(formF[j].value);
		}
	    	window.location.href =  urlString; 
	    }
            function getDistance(startLoc, endLoc){
            				//alert("Ran agains");
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
            					//document.getElementById("location").value = locationName;
						
						document.getElementById("distance").value = xmlhttp.responseText.split('|')[0];
						document.getElementById("duration").value = xmlhttp.responseText.split('|')[1];
						document.getElementById("img_Distance").innerHTML = "<img src=\"images/notification_done.png\" width=\"14px\" />";
						document.getElementById("img_Duration").innerHTML = "<img src=\"images/notification_done.png\" width=\"14px\" />";
						
						initialize();
					    }
					  }
					document.getElementById("img_Distance").innerHTML = "<img src=\"images/notification_error.png\" width=\"14px\" />";
					document.getElementById("img_Duration").innerHTML = "<img src=\"images/notification_error.png\" width=\"14px\" />";
					xmlhttp.open("GET", "getDirections.jsp?origin=" + encodeURIComponent(startLoc) + "&destination=" + encodeURIComponent(endLoc) ,true);
					xmlhttp.send();
	    }


        function sendSMStoDriver(fillCity){
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
                        //document.getElementById("location").value = locationName;

                        var containsItems = xmlhttp.responseText.split("<ITEM>");
                        var equipmentID = containsItems[0];
                        var imgicon = "IMG" + equipmentID.trim();
                        //alert(imgicon);


                        }
                        }
                        //alert('coming soon');


                        var btid = "BT" + fillCity;

                        xmlhttp.open("GET", "/trucking/smsDriver.jsp?equipmentID=" + fillCity ,true);
                                            //alert(imgicon);

                        $('#'+btid).notify(
                        "Text was sent",
                        { position:'right', className:'success' }

                        );

                        // ajax_loader_blue_512
                        xmlhttp.send();

                }



        function clearFieldsNow() {
        document.getElementById("startDate").value = '';
        document.getElementById("endDate").value = '';
        document.getElementById("searchKeyCity").value = '';
        document.getElementById("searchKeyState").value = '';
      }
      function clearFieldsNowCity() {
        document.getElementById("startDate").value = '';
        document.getElementById("endDate").value = '';
        document.getElementById("searchKeyCity").value = '';
        document.getElementById("searchKeyState").value = '';
      }



            
        </script>			



			<%
			String searchSql = "";
			String isOnlineSql = "";
			if(request.getParameter("searchKey")!=null && !request.getParameter("searchKey").equals("")){
				if(searchSql.contains("WHERE")) searchSql = searchSql + " and SEARCH_KEYS LIKE '%" + request.getParameter("searchKey").toUpperCase() + "%'";
				else searchSql =  searchSql + " WHERE SEARCH_KEYS LIKE '%" + request.getParameter("searchKey").toUpperCase() + "%'";					
			}
			/*
			////STATE FILTER REMOVE BECAUSE GPS SEARCH IS ENABLED//////////////
			if(request.getParameter("searchKeyState")!=null && !request.getParameter("searchKeyState").equals("")){
				if(searchSql.contains("WHERE")) searchSql = searchSql + " and STATE LIKE '%" + request.getParameter("searchKeyState").toUpperCase() + "%'";
				else searchSql =  " WHERE STATE LIKE '%" + request.getParameter("searchKeyState").toUpperCase() + "%'";					
			}
			*/
			if(request.getParameter("isOnlineFilter")!=null){
				if(request.getParameter("isOnlineFilter").equals("All")){
					//if(searchSql.contains("WHERE")) searchSql = searchSql + " and ISONLINE = 1 ";
					//else searchSql =  searchSql + " WHERE ISONLINE = 1 ";					
				}else if(request.getParameter("isOnlineFilter").equals("Online")){
					if(searchSql.contains("WHERE")) searchSql = searchSql + " and ISONLINE = 1 ";
					else searchSql =  searchSql + " WHERE ISONLINE = 1 ";
				}else if(request.getParameter("isOnlineFilter").equals("Offline")){
					if(searchSql.contains("WHERE")) searchSql = searchSql + " and ISONLINE = 0 ";
					else searchSql =  searchSql + " WHERE ISONLINE = 0 ";
				} 
			}else{
					if(searchSql.contains("WHERE")) searchSql = searchSql + " and ISONLINE = 1 ";
					else searchSql =  searchSql + " WHERE ISONLINE = 1 ";
			}			
			if(!searchSql.equals(""))searchSql = searchSql + " AND COMPANY_ID = '" + uuid + "'";
			else searchSql = searchSql + " WHERE COMPANY_ID = '" + uuid + "'";
			
			if(request.getParameter("haulFilter")!=null){
				if(request.getParameter("haulFilter").equals("Headhaul")){
					if(searchSql.contains("WHERE")) searchSql = searchSql + " AND HAUL = 'Headhaul'";
					else searchSql =  searchSql + " WHERE HAUL = 'Headhaul'";
				}else if(request.getParameter("haulFilter").equals("Backhaul")){
					if(searchSql.contains("WHERE")) searchSql =  searchSql + " AND HAUL = 'Backhaul'";
					else searchSql =  searchSql + " WHERE HAUL = 'Backhaul'";
				}			
			}
			
			if(request.getParameter("eqTypeFilter")!=null){
				if(request.getParameter("eqTypeFilter").equals("Van")){
					if(searchSql.contains("WHERE")) searchSql = searchSql + " AND TRAILER = 'Van'";
					else searchSql =  searchSql + " WHERE TRAILER = 'Van'";
				}else if(request.getParameter("eqTypeFilter").equals("Reefer")){
					if(searchSql.contains("WHERE")) searchSql =  searchSql + " AND TRAILER = 'Reefer'";
					else searchSql =  searchSql + " WHERE TRAILER = 'Reefer'";
				}			
			}
			if(request.getParameter("loadTypeFilter")!=null){
				if(request.getParameter("loadTypeFilter").equals("Rush")){
					if(searchSql.contains("WHERE")) searchSql = searchSql + " AND LOAD_TYPE = 'Rush'";
					else searchSql =  searchSql + " WHERE LOAD_TYPE = 'Rush'";
				}else if(request.getParameter("loadTypeFilter").equals("Partial")){
					if(searchSql.contains("WHERE")) searchSql =  searchSql + " AND LOAD_TYPE = 'Partial'";
					else searchSql =  searchSql + " WHERE LOAD_TYPE = 'Partial'";
				}else if(request.getParameter("loadTypeFilter").equals("In Transit")){
					if(searchSql.contains("WHERE")) searchSql =  searchSql + " AND LOAD_TYPE = 'In Transit'";
					else searchSql =  searchSql + " WHERE LOAD_TYPE = 'In Transit'";
				}			
			}			
			//searchSql = searchSql + " ORDER BY DATE_MODIFIED ASC";
			System.out.println(searchSql);
			%>


			

    <script type="text/javascript">

    var map = null;
    var geocoder = null;


            		<%
	         try{

			DateFormat formatter = new SimpleDateFormat("MM-dd-yyyy.HH.mm.ss");
			 String pickCity_lat = "0.0";
			 String pickCity_lng = "0.0";

			if(request.getParameter("startDate")!=null && !request.getParameter("startDate").equals("") && request.getParameter("endDate")!=null && !request.getParameter("endDate").equals("")){
				java.sql.Date start = null;
				java.sql.Date end = null;
				start = new java.sql.Date(((java.util.Date)formatter.parse(request.getParameter("startDate") + ".00.00.00" )).getTime());
				end = new java.sql.Date(((java.util.Date)formatter.parse(request.getParameter("endDate") + ".23.59.59" )).getTime());
				if(request.getParameter("searchKeyCity_lng")!=null && !request.getParameter("searchKeyCity_lng").equals("") && request.getParameter("searchKeyCity_lat")!=null && !request.getParameter("searchKeyCity_lat").equals("")&& request.getParameter("searchKeyCity")!=null && !request.getParameter("searchKeyCity").equals("")&& request.getParameter("searchKeyState")!=null && !request.getParameter("searchKeyState").equals("")){
				 	pickCity_lng=request.getParameter("searchKeyCity_lng");
					pickCity_lat=request.getParameter("searchKeyCity_lat");
					

					psMain = connection.prepareStatement("select  X(city_point) as city_lat, Y(city_point) as city_lng,  (GLength(LineStringFromWKB(LineString(city_point, GeomFromText('POINT(" + pickCity_lat + " " + pickCity_lng + ")'))))) AS distanceFromPickCity, CITY, STATE, NAME, ID, DATE_MODIFIED, TRAILER, COVERED_BY, WTG, CONTACT_PERSON, DATE_STATUS_CHANGE, DATE_COVERED, LAST_MODIFIED_BY, LAST_MODIFIED_DATE, LOAD_TYPE, PHONE, COMMENTS, TRUCKINFO, INSURANCE_EXP_DATE, ISONLINE, X(city_point) as city_lat, Y(city_point) as city_lng from test.TRUCKING_EQUIPMENT"  + searchSql +  " AND DATE_MODIFIED BETWEEN ? AND ? " + " order by distanceFromPickCity");
					psMain.setDate(1, start);
					psMain.setTimestamp(2, new java.sql.Timestamp(end.getTime()));
				}else{
					psMain = connection.prepareStatement("select CITY, STATE, NAME, ID, DATE_MODIFIED, TRAILER, COVERED_BY, WTG, CONTACT_PERSON, DATE_STATUS_CHANGE, DATE_COVERED, LAST_MODIFIED_BY, LAST_MODIFIED_DATE, LOAD_TYPE, PHONE, COMMENTS, TRUCKINFO, INSURANCE_EXP_DATE, ISONLINE, X(city_point) as city_lat, Y(city_point) as city_lng from test.TRUCKING_EQUIPMENT"  + searchSql +  " AND DATE_MODIFIED BETWEEN ? AND ? ");
					psMain.setDate(1, start);
					psMain.setTimestamp(2, new java.sql.Timestamp(end.getTime()));
				}
			}else{
				//System.out.println(searchSql);
				if(request.getParameter("searchKeyCity_lng")!=null && !request.getParameter("searchKeyCity_lng").equals("") && request.getParameter("searchKeyCity_lat")!=null && !request.getParameter("searchKeyCity_lat").equals("")&& request.getParameter("searchKeyCity")!=null && !request.getParameter("searchKeyCity").equals("")&& request.getParameter("searchKeyState")!=null && !request.getParameter("searchKeyState").equals("")){
					
					pickCity_lng=request.getParameter("searchKeyCity_lng");
					pickCity_lat=request.getParameter("searchKeyCity_lat");
					psMain = connection.prepareStatement("select X(city_point) as city_lat, Y(city_point) as city_lng,  (GLength(LineStringFromWKB(LineString(city_point, GeomFromText('POINT(" + pickCity_lat + " " + pickCity_lng + ")'))))) AS distanceFromPickCity, CITY, STATE, NAME, ID, DATE_MODIFIED, TRAILER, COVERED_BY, WTG, CONTACT_PERSON, DATE_STATUS_CHANGE, DATE_COVERED, LAST_MODIFIED_BY, LAST_MODIFIED_DATE, LOAD_TYPE, PHONE, COMMENTS, TRUCKINFO, INSURANCE_EXP_DATE, ISONLINE, X(city_point) as city_lat, Y(city_point) as city_lng from test.TRUCKING_EQUIPMENT" + searchSql + " order by distanceFromPickCity");
				}else{
					psMain = connection.prepareStatement("select CITY, STATE, NAME, ID, DATE_MODIFIED, TRAILER, COVERED_BY, WTG, CONTACT_PERSON, DATE_STATUS_CHANGE, DATE_COVERED, LAST_MODIFIED_BY, LAST_MODIFIED_DATE, LOAD_TYPE, PHONE, COMMENTS, TRUCKINFO, INSURANCE_EXP_DATE, ISONLINE, X(city_point) as city_lat, Y(city_point) as city_lng from test.TRUCKING_EQUIPMENT" + searchSql);
				}

			}
		


	         }catch (Exception ex){
	             %><font color="#FF0000"><%="Error Posting " + ex%></font><%
	             System.out.println(""+ ex + searchSql);
	         }
	         		%>

    </script>

    <!-- To fix modal layering over the city search boxes -->

    <STYLE type="text/css">
    div.pac-container {
    z-index: 1050 !important;
    }
    </style>

    <!-- end -->

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
	xmlhttp.send();

	}
	</script>

</head>

	<body onload="initialize()">

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
				<a href="../index4.html"><span class="image" class="navbar-brand"  style="height: 35px; margin-left: 0px; padding: 10px 0px 0px; border-right-width: 0px;"><img src="images/mytryckboard_logo_v2i_small.png"></span></a>
				</div>
                <div id="navbar" class="navbar-collapse collapse">
                <ul class="nav navbar-nav">

                <li class="active"><a href="standard-truckboard.jsp">Truck Board</a></li>
                <li><a href="truckboard.jsp">Truck Board 2.0 <small><strong>(new)</strong></small></a></li>
                <li><a href="/trucking/index.lite.jsp">Live Board</a></li>
                <li><a href="new_features.jsp">What's New</a></li>
                <li class="dropdown">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">Account Administration<span class="caret"></span></a>
                        <ul class="dropdown-menu" role="menu">
                        <li><a href="company_profile_view.jsp">My Account</a></li>
                            <%if(session.getAttribute("isAdmin").equals("true")){%>
                        <li><a href="manage_users.jsp">Manage Users</a></li>
                        <li><a href="add_user.jsp">Add User</a></li>
                        <li><a href="add_truck.jsp">Add Truck</a></li>
                            <%}%>

                        </ul>
                        </li>

                </ul>

				<ul class="nav navbar-nav navbar-right">

				<li class="dropdown active">
				<a href="#" class="dropdown-toggle active" data-toggle="dropdown" role="button" aria-expanded="false">Hello <b><%=NullCheck.check((String)session.getAttribute("f_name"))%></b><span class="caret"></span></a>
				<ul class="dropdown-menu" role="menu">
				<li><a href="javascript:void(0)" onclick="logoutuser('<%=session.getAttribute("uuid")%>')" data-toggle="modal" data-target="#logoutconfirm">Log Out</a></li></ul>
				</ul>

                </div><!--/.nav-collapse -->

<HR style="margin-bottom: 5px;margin-top: 5px;">

    <!-- main select row -->

    <form class="form-inline" name="searchForm" id="searchForm" action="standard-truckboard.jsp" method="post">
    <div class="form-group form-group-sm">
    <label class="sr-only">SelectForm</label>
    <div class="input-group input-group-md">
    <div class="input-group-addon" >Pickup:</div>

    <input type="hidden" name="pickCity_lat" id="pickCity_lat" value="<%=NullCheck.check((String)session.getAttribute("pickCity_lat"))%>" />
    <input type="hidden" name="pickCity_lng" id="pickCity_lng" value="<%=NullCheck.check((String)session.getAttribute("pickCity_lng"))%>" />

    <input type="text" class="form-control" id="pac-input"  placeholder="Pickup City" />

    <div class="input-group-addon">Destination:</div>
    <input type="text" class="form-control" id="pac-input2" placeholder="Destination City" />

    </div>
    </div>

    <div class="form-group form-group-sm">

    <div class="input-group input-group-md">


    <div class='input-group-addon'>From:</div>
    <div class='input-group date' id='datetimepicker1'>
    <input type='text' style="font-size: 14px; padding-left: 5px; padding-right: 5px; width: 130px;" class="form-control"  <%if(request.getParameter("startDate")!=null){%> value="<%=request.getParameter("startDate")%>"<%}%> name="startDate" id="startDate" placeholder="Date">
    <span class="input-group-addon">
    <span class="glyphicon glyphicon-calendar"></span>
    </span>

    </div>

    <div class='input-group-addon'>To:</div>
    <div class='input-group date' id='datetimepicker2'>
    <input type='text' style="font-size: 14px; padding-left: 5px; padding-right: 5px; width: 130px;" class="form-control" <%if(request.getParameter("endDate")!=null){%> value="<%=request.getParameter("endDate")%>"<%}%> name="endDate" id="endDate" placeholder="Date">

    <span class="input-group-addon">
    <span class="glyphicon glyphicon-calendar"></span>
    </span>

    </div>

    </div>
    <button class="btn btn-default btn-sm" type="button" onclick="this.form.submit()" >Filter on Date</button>

    </div>
    <HR style="margin-bottom: 8px;margin-top: 5px;">

    <div class="form-group form-group-sm">

    <strong>Haul:</strong> &nbsp;&nbsp;All <input type="radio" onchange="this.form.submit()" name="haulFilter" value="All" <%if(request.getParameter("haulFilter")==null || request.getParameter("haulFilter").equals("All")){%>checked<%}%> />
    Head <input type="radio" onchange="this.form.submit()" name="haulFilter" value="Headhaul" <%if(request.getParameter("haulFilter")!=null && request.getParameter("haulFilter").equals("Headhaul")){%>checked<%}%> />
    Back <input type="radio" onchange="this.form.submit()" name="haulFilter" value="Backhaul" <%if(request.getParameter("haulFilter")!=null && request.getParameter("haulFilter").equals("Backhaul")){%>checked<%}%> />

</div>

    <!--<button type="submit" class="btn btn-default">Filter</button>-->

    &nbsp;&nbsp;&nbsp;<strong>Trailer:&nbsp;&nbsp;</strong>
    <div class="form-group form-group-sm">

    All <input type="radio" onchange="this.form.submit()" name="eqTypeFilter" value="All" <%if(request.getParameter("eqTypeFilter")==null || request.getParameter("eqTypeFilter").equals("All")){%>checked<%}%> />
    Van <input type="radio" onchange="this.form.submit()" name="eqTypeFilter" value="Van" <%if(request.getParameter("eqTypeFilter")!=null && request.getParameter("eqTypeFilter").equals("Van")){%>checked<%}%> />
    Reefer <input type="radio" onchange="this.form.submit()" name="eqTypeFilter" value="Reefer" <%if(request.getParameter("eqTypeFilter")!=null && request.getParameter("eqTypeFilter").equals("Reefer")){%>checked<%}%> />

    </div>

    &nbsp;&nbsp;&nbsp; <strong>Load:&nbsp;&nbsp;</strong>

    <div class="form-group form-group-sm">

    All <input type="radio" onchange="this.form.submit()" name="loadTypeFilter" value="All" <%if(request.getParameter("loadTypeFilter")==null || request.getParameter("loadTypeFilter").equals("All")){%>checked<%}%> />
    Rush <input type="radio" onchange="this.form.submit()" name="loadTypeFilter" value="Rush" <%if(request.getParameter("loadTypeFilter")!=null && request.getParameter("loadTypeFilter").equals("Rush")){%>checked<%}%> />
    Partial <input type="radio" onchange="this.form.submit()" name="loadTypeFilter" value="Partial" <%if(request.getParameter("loadTypeFilter")!=null && request.getParameter("loadTypeFilter").equals("Partial")){%>checked<%}%> />
    In Transit <input type="radio" onchange="this.form.submit()" name="loadTypeFilter" value="In Transit" <%if(request.getParameter("loadTypeFilter")!=null && request.getParameter("loadTypeFilter").equals("In Transit")){%>checked<%}%> />


    </div>


    &nbsp;&nbsp;&nbsp;<strong>Availability:&nbsp;&nbsp;</strong>
    <div class="form-group form-group-sm">

        <%if(session.getAttribute("isAdmin").equals("true")){%>
    All <input type="radio" onchange="this.form.submit()" name="isOnlineFilter" value="All" <%if(request.getParameter("isOnlineFilter")!=null && request.getParameter("isOnlineFilter").equals("All")){%>checked<%}%> />
    Available<input type="radio" onchange="this.form.submit()" name="isOnlineFilter" value="Online" <%if(request.getParameter("isOnlineFilter")==null || request.getParameter("isOnlineFilter").equals("Online")){%>checked<%}%> />
    Not Available<input type="radio" onchange="this.form.submit()" name="isOnlineFilter" value="Offline" <%if(request.getParameter("isOnlineFilter")!=null && request.getParameter("isOnlineFilter").equals("Offline")){%>checked<%}%> />
        <%}else{%>
    Available<input type="radio" name="isOnlineFilter" value="Online" checked />
        <%}%>

    </div>

    &nbsp;&nbsp;&nbsp;<strong>Show More:&nbsp;</strong>
    <div class="form-group form-group-sm">

    <input type="checkbox" onchange="this.form.submit()" name="IS_SHOW_MORE_COL" id="IS_SHOW_MORE_COL" value="IS_SHOW_MORE_COL" <%if(session.getAttribute("IS_SHOW_MORE_COL").equals("true")){%>checked<%}%> />
    <input type="hidden" value="Filter Board" name="Go" />

    </div>

    </form>
    <!-- end search form -->
    </div>
	</nav> <!-- end of nav -->
    <br/>
	<!-- Main page: -->

	<div class="container-fluid">
	<div class="row">
    <br/><br/><br/><br/><br/><br/><br/>


	</div>

	<div class="row">

	<div class="col-sm-12">

	        	<%if(request.getParameter("cmd")==null || (!request.getParameter("cmd").equals("AddEquipment") && !request.getParameter("cmd").equals("EditEquipment"))){%>

	        	

				<table class="table table-hover table-striped table-bordered tablesorter" id="boardtable">
				<thead style="font-size:14px">

				<TR>

	        	<th>Actions</th>


	        	<th>Equipment&nbsp;Trailer Load Type</th>
	        	<th>Last Updated By</th>
	        	<!--
	        	<th>Phone</th>
	        	-->
	        	<th>Contact</th>
	        	<th>Location</th>

	        	<th>Availability</th>
			<%if(request.getParameter("searchKeyCity_lng")!=null && !request.getParameter("searchKeyCity_lng").equals("") && request.getParameter("searchKeyCity_lat")!=null && !request.getParameter("searchKeyCity_lat").equals("")&& request.getParameter("searchKeyCity")!=null && !request.getParameter("searchKeyCity").equals("")&& request.getParameter("searchKeyState")!=null && !request.getParameter("searchKeyState").equals("")){%>
	        	<th>Distance</th>
			<%}%>
	        	<th>Wants&nbsp;To&nbsp;Go</th>
	        	<th>Comments</th>
	        	<th>Trucker Info</th>
                <%if(session.getAttribute("IS_SHOW_MORE_COL").equals("true")){%>
				<th>Insurance Exp. Date</th>

	        	<th>Covered&nbsp;On</th>
                <th>Covered&nbsp;By</th>
	        	<th>Reserved Date</th>
                 <%}%>
	        	</TR></thead><tbody style="font-size:14px">
	        	
	        	




	<%
	 try{
			DateFormat formatter = new SimpleDateFormat("MM-dd-yyyy.HH.mm.ss");
			ResultSet resultSet = psMain.executeQuery();
			while (resultSet.next()) {
				
					//System.out.println(resultSet.getString("ID"));
					%>
					<%
					if(resultSet.getTimestamp("DATE_STATUS_CHANGE")!=null){
						%><TR bgcolor="#CCCCCC"><%
					}else if(resultSet.getTimestamp("DATE_COVERED")!=null){

						Calendar cal = Calendar.getInstance();
						java.util.Date expireDate = cal.getTime();
						java.util.Date jDate = new java.util.Date(resultSet.getTimestamp("DATE_COVERED").getTime());
						Calendar jcal=Calendar.getInstance();
						jcal.setTime(jDate);
						jcal.add(Calendar.MINUTE, 60);
						%>
						<TR 
						<%if(cal.before(jcal)) {%>
							bgcolor="#FFCCCC"
						<%}%>
						>
					<%}else{%>
						<TR >
					<%}%>
					<TD><div style="max-width:90px;width:100%">




						<a href="javascript:void(0)"><button type="button"  id="BT<%=resultSet.getString("ID")%>" class="btn btn-default btn-sm"
    onclick="sendSMStoDriver('<%=resultSet.getString("ID")%>')" alt="SMS Driver to call you back, update your call back info using the My Info page" title="TO : <%=NullCheck.check(resultSet.getString("PHONE"))%> SMS : myTruckBoard.com message from <%=(String)session.getAttribute("f_name")%> call back <%=(String)session.getAttribute("phone")%>">
	<span class="glyphicon glyphicon-share-alt" aria-hidden="true"></span> SMS&nbsp;&nbsp;&nbsp;</button></a>

		<%if(session.getAttribute("isAdmin").equals("true")){%>
	<a href="/trucking-new/edit_truck.jsp?id=<%=resultSet.getString("ID")%>"><button type="button" class="btn btn-default btn-sm" >
	<span class="glyphicon glyphicon-edit" aria-hidden="true"></span> EDIT&nbsp;&nbsp;&nbsp;</button></a>
	<a href="#" class="btn btn-default btn-sm" style="color:red"
    onclick="setTruckId('<%=resultSet.getString("ID")%>')" data-toggle="modal" data-target="#delconfirm">
	<span class="glyphicon glyphicon-trash" aria-hidden="true"></span> DEL.&nbsp;&nbsp;&nbsp;</a>
					<%}else{%>
	<a href="/trucking-new/add_comment.jsp?id=<%=resultSet.getString("ID")%>"><button type="button" class="btn btn-default btn-sm" >
	<span class="glyphicon glyphicon-edit" aria-hidden="true"></span> EDIT&nbsp;&nbsp;&nbsp;</button></a>
		<%}%>
	<a href="javascript:void(0)" onclick="getLinkwithForm('add_rate.jsp?cmd=EditEquipment','<%=resultSet.getString("ID")%>')" ><button type="button" class="btn btn-default btn-sm">
	<span class="glyphicon glyphicon-dashboard" aria-hidden="true"></span> BOOK</button></a>

	</div></TD>

					<TD><div style="min-width:75px;width:100%">
					<%=NullCheck.check(resultSet.getString("NAME"))%><BR>
					<%=NullCheck.check(resultSet.getString("TRAILER"))%>
                    <hr><font
        <%if(NullCheck.check(resultSet.getString("LOAD_TYPE")).equals("Rush")){%>color="red"<%}%>
        <%if(NullCheck.check(resultSet.getString("LOAD_TYPE")).equals("Partial")){%>color="#9acd32"<%}%>
        <%if(NullCheck.check(resultSet.getString("LOAD_TYPE")).equals("In Transit")){%>color="blue"<%}%>
                    />
                    <%=NullCheck.check(resultSet.getString("LOAD_TYPE"))%>

                    </div>
					</TD>
					<TD>


						
						<%=NullCheck.check(resultSet.getString("LAST_MODIFIED_BY"))%><BR>
						<%if(resultSet.getTimestamp("LAST_MODIFIED_DATE")!=null){%>
							<%=new SimpleDateFormat("MM-dd-yy hh:mm:ss").format(resultSet.getTimestamp("LAST_MODIFIED_DATE"))%>
						<%}%>



					</TD>
					<!--
					<TD nowrap>
						<span style="color:#000000;font-size: 1.5em; line-height: 1.5em;">
					<%=NullCheck.check(resultSet.getString("PHONE"))%>
						</span>
					&nbsp;
					</TD>
					-->
					<TD >
					<div style="min-width:100px;width:100%;overflow:auto;">
					<%=NullCheck.check(resultSet.getString("CONTACT_PERSON"))%>&nbsp;<BR>
					<%=NullCheck.check(resultSet.getString("PHONE"))%>
					</div></TD>
					<TD><div style="min-width:100px;width:100%;overflow:auto;">

						<%=NullCheck.check(resultSet.getString("CITY"))%>,&nbsp;<%=NullCheck.check(resultSet.getString("STATE"))%>
					</div>
					</TD>

					<TD>
					<%if(resultSet.getTimestamp("DATE_MODIFIED")!=null){%>
						<%
						Calendar cal = Calendar.getInstance();
						java.util.Date expireDate = cal.getTime();
						java.util.Date jDate = new java.util.Date(resultSet.getTimestamp("DATE_MODIFIED").getTime());
						Calendar jcal=Calendar.getInstance();
						jcal.setTime(jDate);
						jcal.add(Calendar.DAY_OF_MONTH, 2);
						%>
						<%if(cal.before(jcal)) {%>
							<%=new SimpleDateFormat("MM-dd-YY").format(resultSet.getDate("DATE_MODIFIED"))%>
						<%}else{%>						
						<%=new SimpleDateFormat("MM-dd-YY").format(resultSet.getDate("DATE_MODIFIED"))%>
						<%}%>						
					<%}else{%>
						<%=new SimpleDateFormat("MM-dd-YY").format(resultSet.getDate("DATE_MODIFIED"))%>
					<%}%>
					</TD>
			<%if(request.getParameter("searchKeyCity_lng")!=null && !request.getParameter("searchKeyCity_lng").equals("") && request.getParameter("searchKeyCity_lat")!=null && !request.getParameter("searchKeyCity_lat").equals("")&& request.getParameter("searchKeyCity")!=null && !request.getParameter("searchKeyCity").equals("")&& request.getParameter("searchKeyState")!=null && !request.getParameter("searchKeyState").equals("")){%>
					<TD >

						<% DecimalFormat format=new DecimalFormat("####.0");%>
						
						<%if(resultSet.getString("distanceFromPickCity")!=null){%>
					<%=format.format(Float.parseFloat(resultSet.getString("distanceFromPickCity")) * 62.1371)%>
						<%}%>
							<small>
						 mls away
						</small>

					</TD>
			<%}%>			
					
					<TD>
						<%=NullCheck.check(resultSet.getString("WTG"))%>&nbsp;</TD>
					<TD><div style="min-width:200px;width:100%;height:130px;overflow:auto;">

					<%=NullCheck.check(resultSet.getString("COMMENTS"))%></div>
					</TD>
					<TD><div style="min-width:200px;width:100%;height:130px;overflow:auto;">
					<%=NullCheck.check(resultSet.getString("TRUCKINFO"))%>&nbsp;
					</div>
					</TD>
                     <%if(session.getAttribute("IS_SHOW_MORE_COL").equals("true")){%>
					<TD><div style="min-width:76px;width:100%;">
					<%if(resultSet.getTimestamp("INSURANCE_EXP_DATE")!=null){%>
						<%
						Calendar cal = Calendar.getInstance();
						java.util.Date expireDate = cal.getTime();
						java.util.Date jDate = new java.util.Date(resultSet.getTimestamp("INSURANCE_EXP_DATE").getTime());
						Calendar jcal=Calendar.getInstance();
						jcal.setTime(jDate);
						jcal.add(Calendar.DAY_OF_MONTH, 30);
						%>
						<%if(cal.before(jcal)) {%>
							<%=new SimpleDateFormat("MM-dd-YY").format(resultSet.getDate("INSURANCE_EXP_DATE"))%>
						<%}else{%>
							<%=new SimpleDateFormat("MM-dd-YY").format(resultSet.getDate("INSURANCE_EXP_DATE"))%>
						<%}%>							
					<%}else{%>
						&nbsp;
					<%}%>					</div>
					</TD>					

					<TD><div style="min-width:76px;width:100%;">
					<%if(resultSet.getTimestamp("DATE_COVERED")!=null){%>
						<%=new SimpleDateFormat("MM-dd-YY").format(resultSet.getTimestamp("DATE_COVERED"))%>
					<%}else{%>
					&nbsp;
					<%}%></div>
					</TD>
                    <td><%=NullCheck.check(resultSet.getString("COVERED_BY"))%></td>
					<TD>
					<%if(resultSet.getTimestamp("DATE_STATUS_CHANGE")!=null){%>
					<%=new SimpleDateFormat("MM-dd-YY").format(resultSet.getTimestamp("DATE_STATUS_CHANGE"))%>
					<%}else{%>
						&nbsp;
					<%}%>
					</TD>
                <%}%>

					</TR>
		

		
				<%}%>

			<%
	         }catch (Exception ex){
	             %><font color="#FF0000"><%="Error Posting " + ex%></font><%
	             System.out.println(""+ ex + searchSql);
	         }
	        	%>
		
	</tbody> </table>
	</div>
	</div>

	<% connection.close();
	        	}%>


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


	<div class="modal fade" id="delconfirm" role="dialog" aria-labelledby="delconfirm" aria-hidden="true">
	<div class="modal-dialog">
	<div class="modal-content">
	<div class="modal-header">
	<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
	<h4 class="modal-title" id="myModalLabel" style="color:red">Delete Confirmation</h4>
	</div>
	<div class="modal-body">
	<h3>You are about to delete truck from your records.</h3>
	</div>
	<div class="modal-footer">
	<button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
	<button type="button" class="btn btn-primary" id="deleteonclick" >Delete</button>
    <input type="hidden" id="trucktodelete" />

	</div>
	</div>
	</div>
	</div>


	</div> <!--  container end -->


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
	<a href="http://www.myTruckBoard.com">Please Login</a>
		<%}%>



		<%}else{%>


	</head>

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
	        	