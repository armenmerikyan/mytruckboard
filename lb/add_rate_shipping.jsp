	<%@ page import="com.big.util.*,java.text.*,java.util.*,java.io.*,javax.xml.parsers.*,org.w3c.dom.*,java.sql.*,java.text.DateFormat" %>


		<html>

		<head>
		<meta charset="utf-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<meta name="description" content="">
		<meta name="author" content="">
		<title>MYTRUCKBOARD 2.0 - Send Truckloads.</title>
		<link rel="shortcut icon" href="http://www.mytruckboard.com/trucking-new/images/mtb-favicon.ico">
		<meta http-equiv="content-type" content="text/html; charset=utf-8" />
		<meta name="description" content="The complete freight management software. Win shipping deals and manage your fleet of trucks effortlessly." />
		<meta name="keywords" content="freight, transportation, dispatch management, load optimization, truck broker, transportation management, truck, truck fleet management, shippers, truck brokers, shipping made easy, trucking industry, trucking software, trucking, dispatch for freight brokder, carrier management, load board, load, board" />

		<%
				if(request.getParameter("pac-input")!=null)session.setAttribute("pickCity", request.getParameter("pac-input"));
				if(request.getParameter("pickCity_lat")!=null)session.setAttribute("pickCity_lat", request.getParameter("pickCity_lat"));
				if(request.getParameter("pickCity_lng")!=null)session.setAttribute("pickCity_lng", request.getParameter("pickCity_lng"));
				if(request.getParameter("pickState")!=null)session.setAttribute("pickState", request.getParameter("pickState"));
				if(request.getParameter("pac-input2")!=null)session.setAttribute("destCity", request.getParameter("pac-input2"));
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

%>

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



    <!-- <script>
        $i.noConflict();
        jQuery(document).ready(function(){
        $i( "#pickup_date" ).datepicker();
        });
        </script>
        <script>
        $i.noConflict();
        jQuery(document).ready(function(){
        $i( "#drop_date" ).datepicker();
        });
        </script>
        -->

    <!-- Custom styles for this template -->
        <script type="text/javascript">
        	var queryStringStart = "";
        	var queryStringPrev = "";
var howOften = 12;
var doneSetup = 0;
            function autocompleteAddressLookUp(refID, fillCity){
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
            					//alert('Alert 4');
            					var lat = fillCity + "_lat";
            					var lng = fillCity + "_lng";
            					var addressSPN = fillCity + "SPN";
            					document.getElementById(fillCity).style.color = "#78b361";
						document.getElementById(fillCity).value = xmlhttp.responseText.split('|')[0] + " " + xmlhttp.responseText.split('|')[1] + ", " + xmlhttp.responseText.split('|')[2];
						document.getElementById(lat).value = xmlhttp.responseText.split('|')[5];
						document.getElementById(lng).value = xmlhttp.responseText.split('|')[6];
//						document.getElementById(addressSPN).innerHTML = "YOUR SERVICE PROVIDER or DELIVERY IS " + xmlhttp.responseText.split('|')[7] + " Away";
						document.getElementById(addressSPN).innerHTML = "We Got It ";
					    }
					  }
					xmlhttp.open("GET", "autoFillAddress.yawadi.jsp?location=" + refID ,true);
					xmlhttp.send();
	    }
	
            function autocompleteLocationName(searchKey, fillTextBoxName, fillTextBoxNameRadius){
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
			var addressSPN = fillTextBoxName + "SPN";
			var addressList = xmlhttp.responseText.split("<ROW>");
			var addressListHtml="";
			for(k=0;k < addressList.length; k++){
				var removeLinkText = "<p><a href=\"\" onclick=\"javascript:autocompleteAddressLookUp('" + addressList[k].split(":")[3] + " ','" + fillTextBoxName + "');return false ;\">" ;
			    	addressListHtml = addressListHtml + removeLinkText  + addressList[k].split(":")[0] + ", " +addressList[k].split(":")[1] + "<BR>";			
				addressListHtml = addressListHtml + "</a></p>";
			}
			document.getElementById(addressSPN).innerHTML = addressListHtml;
		    }
		  }
		var lat = fillTextBoxName + "_lat";
		var lng = fillTextBoxName + "_lng";	
		var latRadius = fillTextBoxNameRadius + "_lat";
		var lngRadius = fillTextBoxNameRadius + "_lng";		  
		document.getElementById(lat).value = '';
		document.getElementById(lng).value = '';
            	document.getElementById(fillTextBoxName).style.color = "gray";
		var radiusString = "&radius_lat=" + encodeURIComponent(document.getElementById(latRadius).value);
		radiusString = radiusString + "&radius_lng=" + encodeURIComponent(document.getElementById(lngRadius).value);
		//alert(radiusString);
		if(searchKey.length>1){
			xmlhttp.open("GET", "autoComplete.mtb.rate.jsp?location=" + encodeURIComponent(searchKey) + radiusString ,true);
			xmlhttp.send();
		}
            }            	
            function initialize() {
            	rotater();
            }

		function rotater() {
        		setTimeout("rotater()",howOften*1000);
			autoSaveItem();
		}            
            function autoSaveItem(){
		var queryString = "avg_diesel=" + encodeURIComponent(document.getElementsByName("avg_diesel")[0].value) + "&";
		queryString += "driver_pay=" + encodeURIComponent(document.getElementsByName("driver_pay")[0].value) + "&";
		queryString += "miscel_pay=" + encodeURIComponent(document.getElementsByName("miscel_pay")[0].value) + "&";
		queryString += "truckmpg=" + encodeURIComponent(document.getElementsByName("truckmpg")[0].value) + "&";
		queryString += "gallons=" + encodeURIComponent(document.getElementsByName("gallons")[0].value) + "&";
		queryString += "carrier_pay=" + encodeURIComponent(document.getElementsByName("carrier_pay")[0].value) + "&";
		queryString += "rate=" + encodeURIComponent(document.getElementsByName("rate")[0].value) + "&";
		queryString += "rate_miles=" + encodeURIComponent(document.getElementsByName("rate_miles")[0].value) + "&";
		queryString += "rate_qp=" + encodeURIComponent(document.getElementsByName("rate_qp")[0].value) + "&";
		queryString += "miles=" + encodeURIComponent(document.getElementsByName("miles")[0].value) + "&";
		queryString += "profit=" + encodeURIComponent(document.getElementsByName("profit")[0].value) + "&";
		queryString += "profit_per=" + encodeURIComponent(document.getElementsByName("profit_per")[0].value) + "&";
		queryString += "pickCity=" + encodeURIComponent(document.getElementsByName("pickCity")[0].value) + "&";
		queryString += "pickup_date=" + encodeURIComponent(document.getElementsByName("pickup_date")[0].value) + "&";
		queryString += "pickup_time=" + encodeURIComponent(document.getElementsByName("pickup_time")[0].value) + "&";
		queryString += "destCity=" + encodeURIComponent(document.getElementsByName("destCity")[0].value) + "&";
		queryString += "drop_date=" + encodeURIComponent(document.getElementsByName("drop_date")[0].value) + "&";
		queryString += "drop_time=" + encodeURIComponent(document.getElementsByName("drop_time")[0].value) + "&";
            	queryString += "quote_id=" + encodeURIComponent(document.getElementsByName("quote_id")[0].value) + "&";
            	queryString += "pickState=" + encodeURIComponent(document.getElementsByName("pickState")[0].value) + "&";
            	queryString += "pickCity_lat=" + encodeURIComponent(document.getElementsByName("pickCity_lat")[0].value) + "&";
            	queryString += "pickCity_lng=" + encodeURIComponent(document.getElementsByName("pickCity_lng")[0].value) + "&";
            	queryString += "destState=" + encodeURIComponent(document.getElementsByName("destState")[0].value) + "&";
            	queryString += "destCity_lat=" + encodeURIComponent(document.getElementsByName("destCity_lat")[0].value) + "&";
            	queryString += "destCity_lng=" + encodeURIComponent(document.getElementsByName("destCity_lng")[0].value) + "&";
		queryString += "equipment_id=" + encodeURIComponent(document.getElementsByName("equipment_id")[0].value) + "&";
		queryString += "pickup_address=" + encodeURIComponent(document.getElementsByName("pickup_address")[0].value) + "&";
		queryString += "drop_address=" + encodeURIComponent(document.getElementsByName("drop_address")[0].value) + "&";
		queryString += "pickup_notes=" + encodeURIComponent(document.getElementsByName("pickup_notes")[0].value) + "&";
            	queryString += "drop_notes=" + encodeURIComponent(document.getElementsByName("drop_notes")[0].value) + "&";
            	queryString += "pickup_contact=" + encodeURIComponent(document.getElementsByName("pickup_contact")[0].value) + "&";
            	queryString += "drop_contact=" + encodeURIComponent(document.getElementsByName("drop_contact")[0].value) + "&";
            	queryString += "pickup_contact_phone=" + encodeURIComponent(document.getElementsByName("pickup_contact_phone")[0].value) + "&";
            	queryString += "drop_contact_phone=" + encodeURIComponent(document.getElementsByName("drop_contact_phone")[0].value) + "&";
            	
		
            	if(queryStringStart == "" && queryStringPrev == "" ){
					queryStringStart = queryString;
					queryStringPrev = queryString;
		}
		if(queryStringStart != queryString && queryString != queryStringPrev){
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
				//alert(xmlhttp.responseText);
				//document.getElementById("line_item_detail").innerHTML =  xmlhttp.responseText;
			    }
			  }		
			queryStringPrev = queryString;
			xmlhttp.open("GET", "saveQuoteAutoSave_shipping.jsp?" + queryString ,true);
			xmlhttp.send();  
		}
		
            	
            }
            function addLineItem(actionType){
            	addLineItem(actionType, "Empty");
            }
            function addLineItem(actionType, line_item_id){
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
						document.getElementById("line_item_detail").innerHTML =  xmlhttp.responseText;
					    }
					  }
            				//alert('coming soon');
            				var queryString = "external_id=" + encodeURIComponent(document.getElementsByName("external_id")[0].value) + "&";
            				queryString += "description=" + encodeURIComponent(document.getElementsByName("descriptionItem")[0].value) + "&";
            				queryString += "type=" + encodeURIComponent(document.getElementsByName("typeItem")[0].value) + "&";
            				queryString += "qt=" + encodeURIComponent(document.getElementsByName("qt")[0].value) + "&";
            				queryString += "length=" + encodeURIComponent(document.getElementsByName("lengthLIMTB")[0].value) + "&";
            				queryString += "width=" + encodeURIComponent(document.getElementsByName("widthLIMTB")[0].value) + "&";
            				queryString += "height=" + encodeURIComponent(document.getElementsByName("heightLIMTB")[0].value) + "&";
            				queryString += "weight=" + encodeURIComponent(document.getElementsByName("weightLIMTB")[0].value) + "&";
            				queryString += "quote_id=" + encodeURIComponent(document.getElementsByName("quote_id")[0].value) + "&";
            				queryString += "line_item_id=" + encodeURIComponent(line_item_id) + "&";
            				queryString += "actionType=" + encodeURIComponent(actionType);
					xmlhttp.open("GET", "saveLineItemForQuote.shipping.jsp?" + queryString ,true);
            				//alert(imgicon);
					//document.getElementById(imgicon).src = "images/ajax_loader_blue_512.gif";
					// ajax_loader_blue_512
					xmlhttp.send();     
            				//alert('coming soon 2' + queryString);       	
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

    $('#datetimepicker3').datetimepicker({
    format: 'hh:mm',
    showClear: true

    });

    $('#datetimepicker4').datetimepicker({
    format: 'hh:mm',
    showClear: true

    });
    });
    </script>

  </head>
<!-- NAVBAR
================================================== -->




  <body onload="initialize()" >


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
		<li><a href="truckloads_history_shipping.jsp?id=<%=request.getParameter("id")%>">Truckload History</a></li>


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

		<div class="container">
		<div class="row">


    <p>&nbsp;</p>
    <p>&nbsp;</p>
<%
						 try{

							DateFormat formatter = new SimpleDateFormat("MM-dd-yyyy");

							Class.forName("com.mysql.jdbc.Driver");
							String url = "jdbc:mysql://localhost/test?zeroDateTimeBehavior=convertToNull";

//							Class.forName("com.sap.dbtech.jdbc.DriverSapDB");
//							String url = "jdbc:sapdb://localhost/BIGDB?sqlmode=ORACLE";
							Connection connection = DriverManager.getConnection(url,"<USERNAME>", "<PASSWORD>");

							PreparedStatement ps = connection.prepareStatement("select * from test.TRUCKING_SHIPPING where ID = ? ");
							ps.setString(1, request.getParameter("id"));
							ResultSet resultSet = ps.executeQuery();
							while (resultSet.next()) {
						%>
 	 <p></P>
 	 <p></P>


		<div class="col-md-offset-2 col-md-12 col-lg-offset-2 col-lg-8">
		<div class="col-sm-12">
		<div class="col-xs-12 col-sm-8">
		<H3><%=NullCheck.check(resultSet.getString("CONTACT_PERSON"))%> <small> ( <a href="truckloads_history_shipping.jsp?id=<%=request.getParameter("id")%>">Truckload History</a> )</small> </H3>
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
		</div>

		</div>
		</div>




			<%if(request.getParameter("quote_id")!=null && !request.getParameter("quote_id").equals("")){%>
		<input type="hidden" value="<%=request.getParameter("quote_id") %>" name="quote_id" id="quote_id" >
			<%}else{%>
		<input type="hidden" value="<%=UUID.randomUUID() + "" %>" name="quote_id" id="quote_id" >
			<%}%>
		<input type="hidden" value="<%=request.getParameter("id") %>" name="equipment_id" id="equipment_id" >




		<div class="navbar-wrapper">
		<div class="container">
		<div class="container marketing">

<%}%>	
    <%
       String pickCity = "";
       String destCity = ""; 
       String pickState = "";
       String destState = ""; 
       String pickAddress = "";
       String destAddress = "";
       String pickNotes = "";
       String destNotes = ""; 
       String pickContact = "";
       String destContact = ""; 
       String pickPhone = "";
       String destPhone = ""; 
       String pickDate = ""; 
       String destDate = ""; 
       String my_lat = ""; 
       String my_long = ""; 
       String dest_my_lat = ""; 
       String dest_my_long = ""; 
       int rate = 0;
       int carrier_pay = 0;
				
				ps = connection.prepareStatement("select rate, miscel_pay, pickState, destState, pickCity, destCity, pickup_address,drop_address, pickup_notes,drop_notes,pickup_contact,drop_contact,pickup_phone,drop_phone,pickup_date,drop_date, X(pickcitylocation) as my_lat, Y(pickcitylocation) as my_long, X(destcitylocation) as dest_my_lat, Y(destcitylocation) as dest_my_long  from test.trucking_quote_shipping where quote_id = ? order by ts desc ");
				ps.setString(1, request.getParameter("quote_id"));
				resultSet = ps.executeQuery();
				while (resultSet.next()) {       
					pickCity = NullCheck.check(resultSet.getString("pickCity"));
					destCity = NullCheck.check(resultSet.getString("destCity"));
					pickAddress = NullCheck.check(resultSet.getString("pickup_address"));
					destAddress = NullCheck.check(resultSet.getString("drop_address")); 
					pickNotes = NullCheck.check(resultSet.getString("pickup_notes"));
					destNotes = NullCheck.check(resultSet.getString("drop_notes")); 
					pickContact = NullCheck.check(resultSet.getString("pickup_contact"));
					destContact = NullCheck.check(resultSet.getString("drop_contact")); 
					pickPhone = NullCheck.check(resultSet.getString("pickup_phone"));
					destPhone = NullCheck.check(resultSet.getString("drop_phone")); 
					my_lat = NullCheck.check(resultSet.getString("my_lat")); 
					my_long = NullCheck.check(resultSet.getString("my_long")); 
					dest_my_lat = NullCheck.check(resultSet.getString("dest_my_lat")); 
					dest_my_long = NullCheck.check(resultSet.getString("dest_my_long")); 
					pickState = NullCheck.check(resultSet.getString("pickState"));
					destState = NullCheck.check(resultSet.getString("destState")); 
					rate = resultSet.getInt("rate");
					carrier_pay = resultSet.getInt("miscel_pay");
					if(resultSet.getTimestamp("pickup_date")!=null){
					pickDate = new SimpleDateFormat("MM-dd-yyyy").format(resultSet.getTimestamp("pickup_date"));
					}
					if(resultSet.getTimestamp("drop_date")!=null){
					destDate = new SimpleDateFormat("MM-dd-yyyy").format(resultSet.getTimestamp("drop_date"));
					}
				}
    %>
      <div class="panel panel-primary" >	
      <div class="panel-heading">
      <div class="input-group"><a class="btn btn-primary" href="javascript:void(0)" role="button" onclick="autoSaveItem();"><span class="glyphicon glyphicon-save" aria-hidden="true"></span> SAVE DETAILS</a>
	</div>
      </div>
      <div class="panel-body"> 
 <table class="table">   
    <tbody>
      <tr>
        <td colspan="3">
        <h3>Budget</h3>
<div class="input-group">
  <span class="input-group-addon" id="basic-addon1"><span class="glyphicon glyphicon-usd" aria-hidden="true"></span></span>
  <input type="text" class="form-control"  aria-describedby="basic-addon1" name="miscel_pay" id="miscel_pay"  <%if(request.getParameter("quote_id")!=null){%>value="<%=carrier_pay%>"<%}%> >
</div> 
  <input type="hidden" class="form-control"  aria-describedby="basic-addon1" name="truckmpg" id="truckmpg" value="">
  <input type="hidden" aria-describedby="basic-addon1" name="gallons" id="gallons" value="">
  <input type="hidden" class="form-control"  aria-describedby="basic-addon1" name="avg_diesel" id="avg_diesel">
  <input type="hidden" class="form-control"  aria-describedby="basic-addon1" name="driver_pay" id="driver_pay">
  <input type="hidden" class="form-control"  aria-describedby="basic-addon1" name="carrier_pay" id="carrier_pay" >
        </td>
        <td colspan="4">
        <h3>Rate</h3>
<div class="input-group">
  <span class="input-group-addon" id="basic-addon1"><span class="glyphicon glyphicon-usd" aria-hidden="true"></span></span>
  <input type="text" class="form-control"  aria-describedby="basic-addon1"  name="rate" id="rate" <%if(request.getParameter("quote_id")!=null){%>value="<%=rate%>"<%}%> >
</div>     
  <input type="hidden" class="form-control"  aria-describedby="basic-addon1"  name="rate_miles" id="rate_miles" value="">
  <input type="hidden" class="form-control"  aria-describedby="basic-addon1" name="rate_qp" id="rate_qp" value="">
  <input type="hidden" class="form-control"  aria-describedby="basic-addon1" name="miles" id="miles"  value="">
  <input type="hidden" class="form-control"  aria-describedby="basic-addon1" name="profit" id="profit"   value="">
  <input type="hidden" class="form-control"  aria-describedby="basic-addon1" name="profit_per" id="profit_per"   value="">
        </td>
      </tr>  
    </tbody>
  </table>  
      
  <table class="table">   
    <tbody>

    <thead>
      <tr>
        <th>Pick From City</th>
        <th>Date</th>
        <th>Time</th>
        <th>Delivery To City</th>
        <th>Date</th>
        <th>Time</th>
        <th>Distance</th>
      </tr>
    </thead>  
      <tr>
        <td>
<div class="input-group">
						<input type="hidden" id="pickState" name="pickState" <%if(request.getParameter("quote_id")!=null){%>value="<%=pickState%>" <%}else{%>value="<%=NullCheck.check((String)session.getAttribute("pickState"))%>"<%}%> >	
						<input type="hidden" id="pickCity_lat" name="pickCity_lat" <%if(request.getParameter("quote_id")!=null){%>value="<%=my_lat%>" <%}else{%>value="<%=NullCheck.check((String)session.getAttribute("pickCity_lat"))%>"<%}%> >	
						<input type="hidden" id="pickCity_lng" name="pickCity_lng" <%if(request.getParameter("quote_id")!=null){%>value="<%=my_long%>" <%}else{%>value="<%=NullCheck.check((String)session.getAttribute("pickCity_lng"))%>"<%}%> >	
						<input type="hidden" id="destState" name="destState" <%if(request.getParameter("quote_id")!=null){%>value="<%=destState%>" <%}else{%>value="<%=NullCheck.check((String)session.getAttribute("destState"))%>"<%}%> >	
						<input type="hidden" id="destCity_lat" name="destCity_lat" <%if(request.getParameter("quote_id")!=null){%>value="<%=dest_my_lat%>" <%}else{%>value="<%=NullCheck.check((String)session.getAttribute("destCity_lat"))%>"<%}%> >	
						<input type="hidden" id="destCity_lng" name="destCity_lng" <%if(request.getParameter("quote_id")!=null){%>value="<%=dest_my_long%>" <%}else{%>value="<%=NullCheck.check((String)session.getAttribute("destCity_lng"))%>"<%}%> >

  <span class="input-group-addon" id="basic-addon1"><span class="glyphicon glyphicon-globe" aria-hidden="true"></span></span>
  <input type="text" class="form-control"  aria-describedby="basic-addon1" id="pickCity" name="pickCity"   <%if(request.getParameter("quote_id")!=null){%>value="<%=pickCity%>" <%}else{%>value="<%=NullCheck.check((String)session.getAttribute("pickCity"))%>"<%}%> >
</div>  </td>
        <td>
            <div class="input-group input-group-md">
            <div class='input-group date' id='datetimepicker1'>
            <input type='text' style="font-size: 14px; padding-left: 5px; padding-right: 2px; width: 90px;" class="form-control" id="pickup_date" name="pickup_date" <%if(request.getParameter("startDate")!=null){%> value="<%=request.getParameter("startDate")%>"<%}%> <%if(request.getParameter("quote_id")!=null){%>value="<%=pickDate%>"<%}%> placeholder="Date">
            <span class="input-group-addon">
            <span class="glyphicon glyphicon-calendar"></span>
            </span>
            </div></div>
</td>
        <td>
<div class="input-group input-group-md">
    <div class='input-group date' id='datetimepicker3'>
  <span class="input-group-addon"><span class="glyphicon glyphicon-time" aria-hidden="true"></span></span>
  <input type="text" class="form-control"  aria-describedby="basic-addon1" id="pickup_time" name="pickup_time" value="08:00" style="font-size: 14px; padding-left: 5px; padding-right: 2px; width: 55px;">
</div></div>  </td>

        <td>
<div class="input-group">
  <span class="input-group-addon" id="basic-addon1"><span class="glyphicon glyphicon-globe" aria-hidden="true"></span></span>
  <input type="text" class="form-control"  aria-describedby="basic-addon1" id="destCity" name="destCity"  <%if(request.getParameter("quote_id")!=null){%>value="<%=destCity%>"<%}else{%>value="<%=NullCheck.check((String)session.getAttribute("destCity"))%>" <%}%> >
</div></td>


    <td>
    <div class="input-group input-group-md">
    <div class='input-group date' id='datetimepicker2'>
    <input type='text' style="font-size: 14px; padding-left: 5px; padding-right: 5px; width: 90px;" class="form-control" id="drop_date" name="drop_date" <%if(request.getParameter("quote_id")!=null && request.getParameter("endDate")!=null){%> value="<%=request.getParameter("endDate")%>"<%}%> <%if(request.getParameter("quote_id")!=null){%>value="<%=destDate%>"<%}%>  placeholder="Date">
    <span class="input-group-addon">
    <span class="glyphicon glyphicon-calendar"></span>
    </span>
    </div></div>
    </td>

  <!--
    <td>
<div class="input-group">
  <span class="input-group-addon date" id="datetimepicker2"><span class="glyphicon glyphicon-calendar" aria-hidden="true"></span></span>
  <input type="text" class="form-control"  aria-describedby="basic-addon1" id="drop_date" name="drop_date" <%if(request.getParameter("quote_id")!=null){%>value="<%=destDate%>"<%}%> >
</div>  </td>

-->


        <td>
<div class="input-group">
    <div class='input-group date' id='datetimepicker4'>
  <span class="input-group-addon" id="basic-addon1"><span class="glyphicon glyphicon-time" aria-hidden="true"></span></span>
  <input type="text" class="form-control"  aria-describedby="basic-addon1" id="drop_time" name="drop_time"  value="08:00" style="font-size: 14px; padding-left: 5px; padding-right: 2px; width: 55px;">
</div></div>  </td>
<td ><%=NullCheck.check((String)session.getAttribute("duration"))%></td>
      </tr>    
      <tr>
        <td colspan="3">
						<div class="input-group">
						    <span class="input-group-addon" id="basic-addon1"><span class="glyphicon glyphicon-flag" ></span></span>
						    <input type="text" class="form-control" placeholder="Address" id="pickup_address" name="pickup_address" value="<%=pickAddress%>" aria-describedby="basic-addon1" onkeypress="autocompleteLocationName(document.getElementById('pickup_address').value, document.getElementById('pickup_address').name, 'pickCity')" autocomplete="off" >
						</div>
						<div class="text-center">
						<span id="pickup_addressSPN" name="pickup_addressSPN" style="border-color:#262626;border-width: 1px;line-height:1.4em;font-size:1.0em;width:80%;">&nbsp;</span>
						<input type="hidden" name="pickup_address_lat" id="pickup_address_lat" value="" />
						<input type="hidden" name="pickup_address_lng" id="pickup_address_lng" value="" />
						</div>	
        </td >
        <td colspan="3">

						<div class="input-group">
						    <span class="input-group-addon" id="basic-addon1"><span class="glyphicon glyphicon-flag" ></span></span>
						    <input type="text" class="form-control" placeholder="Address" id="drop_address" name="drop_address" value="<%=destAddress%>" aria-describedby="basic-addon1" onkeypress="autocompleteLocationName(document.getElementById('drop_address').value, document.getElementById('drop_address').name, 'destCity')" autocomplete="off" >
						</div>
						<div class="text-center">
						<span id="drop_addressSPN" name="drop_addressSPN" style="border-color:#262626;border-width: 1px;line-height:1.4em;font-size:1.0em;width:80%;">&nbsp;</span>
						<input type="hidden" name="drop_address_lat" id="drop_address_lat" value="" />
						<input type="hidden" name="drop_address_lng" id="drop_address_lng" value="" />
						</div>
        </td>
      </tr>      
      <tr>
        <td colspan="3">
<div class="input-group input-group-md">
    <div class='input-group date' >
  <span class="input-group-addon"><span class="glyphicon glyphicon-comment" aria-hidden="true"> Notes</span></span>
  <input type="text" class="form-control"  aria-describedby="basic-addon1" id="pickup_notes" name="pickup_notes"  value="<%=pickNotes%>" style="font-size: 14px; padding-left: 5px; padding-right: 2px; width:100%;">
</div></div>        
        </td >
        <td colspan="3">
<div class="input-group input-group-md">
    <div class='input-group date' >
  <span class="input-group-addon"><span class="glyphicon glyphicon-comment" aria-hidden="true"> Notes</span></span>
  <input type="text" class="form-control"  aria-describedby="basic-addon1" id="drop_notes" name="drop_notes" value="<%=destNotes%>"  style="font-size: 14px; padding-left: 5px; padding-right: 2px; width:100%;">
</div></div>        
        </td>        
      </tr>
      <tr>
        <td colspan="3">
<div class="input-group input-group-md">
    <div class='input-group date' >
  <span class="input-group-addon"><span class="glyphicon glyphicon-user" aria-hidden="true"> Contact</span></span>
  <input type="text" class="form-control"  aria-describedby="basic-addon1" id="pickup_contact" name="pickup_contact"  value="<%=pickContact%>"  style="font-size: 14px; padding-left: 5px; padding-right: 2px; width:100%;">
</div></div>        
        </td >
        <td colspan="3">
<div class="input-group input-group-md">
    <div class='input-group date' >
  <span class="input-group-addon"><span class="glyphicon glyphicon-user" aria-hidden="true"> Contact</span></span>
  <input type="text" class="form-control"  aria-describedby="basic-addon1" id="drop_contact" name="drop_contact"  value="<%=destContact%>" style="font-size: 14px; padding-left: 5px; padding-right: 2px; width:100%;">
</div></div>        
        </td>      
      </tr>      

      <tr>
        <td colspan="3">
<div class="input-group input-group-md">
    <div class='input-group date' >
  <span class="input-group-addon"><span class="glyphicon glyphicon-phone" aria-hidden="true">Phone</span></span>
  <input type="text" class="form-control"  aria-describedby="basic-addon1" id="pickup_contact_phone" name="pickup_contact_phone" value="<%=pickPhone%>"  style="font-size: 14px; padding-left: 5px; padding-right: 2px; width:100%;">
</div></div>        
        </td >
        <td colspan="3">
<div class="input-group input-group-md">
    <div class='input-group date' >
  <span class="input-group-addon"><span class="glyphicon glyphicon-phone" aria-hidden="true">Phone</span></span>
  <input type="text" class="form-control"  aria-describedby="basic-addon1" id="drop_contact_phone" name="drop_contact_phone" value="<%=destPhone%>"  style="font-size: 14px; padding-left: 5px; padding-right: 2px; width:100%;">
</div></div>        
        </td>      
      </tr>   
      
            <tr>
        <td colspan="7">
<div class="panel panel-success" id="line_item_detail" name="line_item_detail" >
  <table class="table">   
    <thead>
      <tr>
        <th>External ID</th>
        <th>Desciption</th>
        <th>Type</th>
        <th>Qt.</th>
        <th>Length</th>
        <th>Width</th>
        <th>Height</th>
        <th>Weight</th>
        <th>&nbsp;</th>
      </tr>
    </thead>  
    <tbody>
      <tr>
        <td>
<div class="input-group">
  <span class="input-group-addon" id="basic-addon1"></span>
  <input type="hidden" value="<%=UUID.randomUUID() + "" %>" name="quote_id" id="quote_id" >
  <input type="text" class="form-control"  aria-describedby="basic-addon1"  name="external_id" id="external_id" value="">
</div> </td>
        <td>
<div class="input-group">
  <span class="input-group-addon" id="basic-addon1"></span>
  <input type="text" class="form-control"  aria-describedby="basic-addon1"  name="descriptionItem" id="description" value="">
</div> </td>
        <td>
<div class="input-group">
  <span class="input-group-addon" id="basic-addon1"></span>
  <input type="text" class="form-control"  aria-describedby="basic-addon1"  name="typeItem" id="type" value="">
</div> </td>
        <td>
<div class="input-group">
  <span class="input-group-addon" id="basic-addon1"></span>
  <input type="text" class="form-control"  aria-describedby="basic-addon1"  name="qt" id="qt" value="1">
</div> </td>
        <td>
<div class="input-group">
  <span class="input-group-addon" id="basic-addon1"></span>
  <input type="text" class="form-control"  aria-describedby="basic-addon1"  name="lengthLIMTB" id="lengthLIMTB" value="">
</div> </td>
        <td>
<div class="input-group">
  <span class="input-group-addon" id="basic-addon1"></span>
  <input type="text" class="form-control"  aria-describedby="basic-addon1"  name="widthLIMTB" id="widthLIMTB" value="">
</div> </td>
        <td>
<div class="input-group">
  <span class="input-group-addon" id="basic-addon1"></span>
  <input type="text" class="form-control"  aria-describedby="basic-addon1"  name="heightLIMTB" id="heightLIMTB" value="">
</div> </td>
        <td>
<div class="input-group">
  <span class="input-group-addon" id="basic-addon1"></span>
  <input type="text" class="form-control"  aria-describedby="basic-addon1"  name="weightLIMTB" id="weightLIMTB" value="">
</div> </td>

        <td>        
<div class="input-group"><a class="btn btn-primary" href="javascript:void(0)" role="button" onclick="addLineItem('addItem');"><span class="glyphicon glyphicon-plus" aria-hidden="true"></span></a>
</div> </td>
      </tr>
      
      <%
				ps = connection.prepareStatement("select * from test.trucking_quote_lineitem_shipping where quote_id = ? order by ts desc ");
				ps.setString(1, request.getParameter("quote_id"));
				 resultSet = ps.executeQuery();
				String stringResponseAll =  new String();				
				while (resultSet.next()) {				
					//stringResponseAll = stringResponseAll + "Start<FIELD>" + resultSet.getString("type") + "<FIELD>" + resultSet.getString("description") + "<FIELD>Done<ROW>" ;
					%>	
      <tr>
        <td>
<div class="input-group">
  <span class="input-group-addon" id="basic-addon1"></span>
  <input type="text" class="form-control"  aria-describedby="basic-addon1"  name="external_id" id="external_id" value="<%=resultSet.getString("external_id")%>">
</div> </td>
        <td>
<div class="input-group">
  <span class="input-group-addon" id="basic-addon1"></span>
  <input type="text" class="form-control"  aria-describedby="basic-addon1"  name="descriptionItem" id="description" value="<%=resultSet.getString("description")%>">
</div> </td>
        <td>
<div class="input-group">
  <span class="input-group-addon" id="basic-addon1"></span>
  <input type="text" class="form-control"  aria-describedby="basic-addon1"  name="typeItem" id="type" value="<%=resultSet.getString("type")%>">
</div> </td>
        <td>
<div class="input-group">
  <span class="input-group-addon" id="basic-addon1"></span>
  <input type="text" class="form-control"  aria-describedby="basic-addon1"  name="qt" id="qt" value="<%=resultSet.getString("qt")%>">
</div> </td>
        <td>
<div class="input-group">
  <span class="input-group-addon" id="basic-addon1"></span>
  <input type="text" class="form-control"  aria-describedby="basic-addon1"  name="lengthLIMTB" id="lengthLIMTB" value="<%=resultSet.getString("length")%>">
</div> </td>
        <td>
<div class="input-group">
  <span class="input-group-addon" id="basic-addon1"></span>
  <input type="text" class="form-control"  aria-describedby="basic-addon1"  name="widthLIMTB" id="widthLIMTB" value="<%=resultSet.getString("width")%>">
</div> </td>
        <td>
<div class="input-group">
  <span class="input-group-addon" id="basic-addon1"></span>
  <input type="text" class="form-control"  aria-describedby="basic-addon1"  name="heightLIMTB" id="heightLIMTB" value="<%=resultSet.getString("height")%>">
</div> </td>
        <td>
<div class="input-group">
  <span class="input-group-addon" id="basic-addon1"></span>
  <input type="text" class="form-control"  aria-describedby="basic-addon1"  name="weightLIMTB" id="weightLIMTB" value="<%=resultSet.getString("weight")%>">
</div> </td>

        <td>        
<div class="input-group"><a class="btn btn-primary" href="javascript:void(0)" role="button" onclick="addLineItem('removeItem','<%=resultSet.getString("line_item_id")%>');"><span class="glyphicon glyphicon-minus" aria-hidden="true"></span></a>
</div> </td>
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
</div    
	  </div>  
	  </div> 
      </div>  
           			
      </div>
      						<%
      						
      						 }catch (Exception ex){	         
						     %><%="Error Posting " + ex%><%  
						     System.out.println(""+ ex);
						 }
	         
						%>



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
