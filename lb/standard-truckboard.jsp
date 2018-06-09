<%@ page import="com.big.util.*,java.text.*,java.util.*,java.io.*,javax.xml.parsers.*,org.w3c.dom.*,java.sql.*,java.text.DateFormat" %>


	<html>

	<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<meta name="description" content="">
	<meta name="author" content="">
	<title>MYTRUCKBOARD 2.0 - standard truckboard - freight management made simple</title>
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

			%>


    <script language="JavaScript" type="text/javascript">

    function initialize() {
	    rotater();


	loadTrucks();

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
	var pickCity_latv = (document.getElementById('pickCity_lat').value);
	var pickCity_lngv = (document.getElementById('pickCity_lng').value);



	var pickCityall = (document.getElementById('pac-input').value);

	var parts = pickCityall.split(",");

	var pickCityv = (document.getElementById('pac-input').value); // get the city from the submitted form in case it's already split

	var pickStatev = ""; //

		if(parts.length>1){

			pickCityv = parts[0]; // get the city from the submitted form
			pickStatev = parts[1]; // get the state from the submitted form

		document.getElementById('pickCity').value = pickCityv;
		document.getElementById('pickState').value = pickStatev;

		//alert(pickStatev);

		}


//	alert('ready to submit the form again');


	loadTrucks(pickCityv, pickCity_latv, pickCity_lngv);
	//document.searchForm.submit();

    });


	var autocomplete2 = new google.maps.places.Autocomplete(input2);

    google.maps.event.addListener(autocomplete2, 'place_changed', function() {

    var place2 = autocomplete2.getPlace();

    if (!place2.geometry) {
    return;
    }


	document.getElementById('destCity_lat').value = place2.geometry.location.lat();
	document.getElementById('destCity_lng').value = place2.geometry.location.lng();

		//alert(document.getElementById('destCity_lng').value);


		var destCityall = (document.getElementById('pac-input2').value);
		var parts2 = destCityall.split(",");

		var destCityv = (document.getElementById('pac-input2').value); // get the city from the submitted form in case it's already split

		var destStatev = ""; //

		if(parts2.length>1){

		destCityv = parts2[0]; // get the city from the submitted form
		destStatev = parts2[1]; // get the state from the submitted form

		document.getElementById('destCity').value = destCityv;
		document.getElementById('destState').value = destStatev;


		if(document.getElementById("pac-input").value != null && document.getElementById("pac-input2").value != null){

		getDistance(document.getElementById("pickCity_lat").value + ',' + document.getElementById("pickCity_lng").value,document.getElementById("destCity_lat").value + ',' + document.getElementById("destCity_lng").value);

		}


		loadTrucks();
		//alert(document.getElementById('distance').value);


		//		alert(document.getElementById('duration').value);

		//document.searchForm.submit();




		}




    });


    }

    </script>


	<script>

	function clearSearchKeys(){
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
						//CLEAN THE VALUES ON THE HTML PAGE 

						document.getElementById("pac-input").value = null;
						document.getElementById("pac-input2").value = null;
						document.getElementById("destCity").value = null;
						document.getElementById("destCity_lat").value = null;
						document.getElementById("destCity_lng").value = null;


						document.getElementById("duration").value = null;
						document.getElementById("distance").value = null;

						document.getElementById("pickCity").value = null;
						document.getElementById("pickState").value = null
						document.getElementById("pickCity_lng").value = null;
						document.getElementById("pickCity_lat").value = null;
						document.getElementById("searchKey").value = null;
						document.getElementById("startDate").value = null;
						document.getElementById("endDate").value = null;

						//reload the page with cleared search keys
						loadTrucks();

						//alert(document.getElementById("duration").value);
						//document.getElementById("img_Distance").innerHTML = "<img src=\"images/notification_done.png\" width=\"14px\" />";
						//document.getElementById("img_Duration").innerHTML = "<img src=\"images/notification_done.png\" width=\"14px\" />";


					    }
					  }
					//document.getElementById("img_Distance").innerHTML = "<img src=\"images/notification_error.png\" width=\"14px\" />";
					//document.getElementById("img_Duration").innerHTML = "<img src=\"images/notification_error.png\" width=\"14px\" />";
					xmlhttp.open("GET", "clearSearchKeys.jsp" ,true);
					xmlhttp.send();




	}




	</script>



		<script>


		function loadTrucks(startLoc, lat, long){


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
		//document.getElementById("location").value = locationName;
		document.getElementById("trucklist").innerHTML = xmlhttp.responseText;
		}
		}

		var urlString = "";
		var formF = document.getElementsByTagName("input");
		for(var j = 0; j<formF.length;j++){

				if(formF[j].type=="radio"){
						if(formF[j].checked){
						urlString = urlString + "&" + formF[j].name + "=" + encodeURIComponent(formF[j].value);
						}
				}
				else if(formF[j].name!='IS_SHOW_MORE_COL'){

		urlString = urlString + "&" + formF[j].name + "=" + encodeURIComponent(formF[j].value);

		}

		}


		var isshowmore = document.getElementsByName('IS_SHOW_MORE_COL');
		var isshowmore_value;
		for(var i = 0; i < isshowmore.length; i++){
		if(isshowmore[i].checked){
		isshowmore_value = isshowmore[i].value;
		urlString = urlString + "&IS_SHOW_MORE_COL=" +isshowmore_value;

		//alert('setting the session value of is_show_more_col to true ');

		<% session.setAttribute("IS_SHOW_MORE_COL", "true"); %>


						} else {
		//alert('setting the session value of is_show_more_col to false');
		<% session.setAttribute("IS_SHOW_MORE_COL", "false"); %>

								}

		}




		//document.getElementById(startLoc).style.backgroundColor="white";
		//alert(urlString);
		xmlhttp.open("GET", "standard-truckboard-trucklist.jsp?origin=" + encodeURIComponent(startLoc) + urlString,true);
		xmlhttp.send();
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
						//alert(document.getElementById("distance").value);
						document.getElementById("duration").value = xmlhttp.responseText.split('|')[1];
						//alert(document.getElementById("duration").value);
						//document.getElementById("img_Distance").innerHTML = "<img src=\"images/notification_done.png\" width=\"14px\" />";
						//document.getElementById("img_Duration").innerHTML = "<img src=\"images/notification_done.png\" width=\"14px\" />";


					    }
					  }
					//document.getElementById("img_Distance").innerHTML = "<img src=\"images/notification_error.png\" width=\"14px\" />";
					//document.getElementById("img_Duration").innerHTML = "<img src=\"images/notification_error.png\" width=\"14px\" />";
					xmlhttp.open("GET", "getDirections.jsp?origin=" + encodeURIComponent(startLoc) + "&destination=" + encodeURIComponent(endLoc) ,true);
					xmlhttp.send();
	    }

	
        function sendSMStoDriverCustom(fillCity){        	
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

                        //var containsItems = xmlhttp.responseText.split("<ITEM>");
                        //var equipmentID = containsItems[0];
                        //var imgicon = "IMG" + equipmentID.trim();
                        
        		document.getElementById("SMSBoard").innerHTML = xmlhttp.responseText;
                        //alert(imgicon);
                                	gotItSMSMessageShow();



                        }
                        }
                        //alert('coming soon');


                        var btid = "BT" + fillCity;

                        xmlhttp.open("GET", "/trucking/smsDriverLog.jsp?equipmentID=" + fillCity ,true);
                        xmlhttp.send();
        }
        
        function sendSMStoDriverOffer(){
        	if(document.getElementById("commentSMSOfferButton").innerHTML == "Make Offer"){
        		document.getElementById("commentSMSOfferButton").innerHTML = "Text Only";
        		document.getElementById("commentSMS_fg").style.display = "none";    
        		document.getElementById("load_no_fg").style.display = "inline";    
        	}else if(document.getElementById("commentSMSOfferButton").innerHTML == "Text Only"){
        		document.getElementById("commentSMSOfferButton").innerHTML = "Make Offer";
        		document.getElementById("commentSMS_fg").style.display = "inline";    
        		document.getElementById("load_no_fg").style.display = "none";    	
        	}
        	
        }
        function sendSMStoDriverCustomNew(fillCity){
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
			document.getElementById("commentSMSButton").className = 'btn btn-success';
			sendSMStoDriverCustom(equipmentID);
                        //alert(imgicon);


                        }
                        }
                        //alert('coming soon');


                        var btid = "BT" + fillCity;
			
			document.getElementById("commentSMSButton").className = 'btn btn-warning';
                        xmlhttp.open("GET", "/trucking/smsDriverCustomNew.jsp?equipmentID=" + fillCity + "&comment=" + document.getElementById("commentSMS").value ,true);
                                            //alert(imgicon);

                        $('#'+btid).notify(
                        "Text was sent",
                        { position:'right', className:'success' }

                        );

                        // ajax_loader_blue_512
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
        <script>
        function gotItSMSMessageShow() {
        	//alert('Test');
	    $('#myModalSMS').modal({
		show: 'false'
	    });         
    	}
        function gotItMessageShow() {
        	//alert('Test');
	    $('#myModal').modal({
		show: 'false'
	    });         
    	}
        </script>
  <script type="text/javascript">  
  	var urlStringPrev = "";
  	var urlPingStatus = 0;
  	function partialSearch()
  			{
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
  			    	var containsUpdate = xmlhttp.responseText.split("<UPDATELIST>");
  			    	if(containsUpdate.length>1){
  			    		gotItMessageShow();
  			    	}else{
//	  				document.getElementById("pubFormResultsDiv").innerHTML = xmlhttp.responseText;
	  			}	
  			    		urlPingStatus = 0;
  			    }
  			  }
  				var urlString = "?";


  					if(urlPingStatus==5 && document.getElementById("timestamp")!=null){
	  					urlPingStatus = urlPingStatus + 1;
  						urlString = urlString + "&timestamp=" + document.getElementById("timestamp").value;
	  					xmlhttp.open("GET", "index.lite.update.jsp" + urlString ,true);
	  					xmlhttp.send();		
	  				}else{
	  					urlPingStatus = urlPingStatus + 1;
	  				} 
			}
</script>    
<script>
var howOften = 12;
var doneSetup = 0;
function rotater() {
        setTimeout("rotater()",howOften*100);
	partialSearch();
//        alert(document.getElementById("embeddedDateField").value);
//	alert('Hello Tick');
}
//window.onload=rotater;
</script>          
</head>
	<body onload="initialize()">
<!-- Modal -->
<div class="modal fade" id="myModalSMS" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">SMS Message Center</h4>
      </div>
      <div class="modal-body">
        <h1>SMS Directly From Here</h1>
        <div id="SMSBoard" name="SMSBoard" >Coming Soon</div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
      </div>
    </div>
  </div>
</div>
<!-- Modal -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Message Center</h4>
      </div>
      <div class="modal-body">
        <h1>YOU HAVE A NEW MESSAGE</h1>
        <h2><a href="message_center.jsp">Message Center</a></h2>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
      </div>
    </div>
  </div>
</div>
 <%@include file="nav_menu.jsp" %>
 <BR><BR><BR>
<HR style="margin-bottom: 5px;margin-top: 5px;">

    <!-- main select row -->

    <form class="form-inline" name="searchForm" id="searchForm" action="standard-truckboard-new.jsp" method="post">
    <div class="form-group form-group-sm">
    <label class="sr-only">SelectForm</label>
    <div class="input-group input-group-md">
    <div class="input-group-addon" >Location:</div>

    <input type="hidden" name="pickCity_lat" id="pickCity_lat" value="<%=NullCheck.check((String)session.getAttribute("pickCity_lat"))%>" />
    <input type="hidden" name="pickCity_lng" id="pickCity_lng" value="<%=NullCheck.check((String)session.getAttribute("pickCity_lng"))%>" />
    <input type="hidden" name="pickCity" id="pickCity" value="<%=NullCheck.check((String)session.getAttribute("pickCity"))%>">
	<input type="hidden" name="pickState" id="pickState" value="<%=NullCheck.check((String)session.getAttribute("pickState"))%>">



		<input type="text" class="form-control" id="pac-input" name="pac-input" placeholder="Pickup City" value="<%=NullCheck.check((String)session.getAttribute("pac-input"))%>" />

    <div class="input-group-addon">Destination:</div>
    
    <input type="text" class="form-control" id="pac-input2" name="pac-input2" placeholder="Destination City" value="<%=NullCheck.check((String)session.getAttribute("pac-input2"))%>" />
		<input type="hidden" name="destCity" id="destCity" value="<%=NullCheck.check((String)session.getAttribute("destCity"))%>">
		<input type="hidden" name="destState" id="destState" value="<%=NullCheck.check((String)session.getAttribute("destState"))%>">

	<input type="hidden" name="destCity_lat" id="destCity_lat" value="<%=NullCheck.check((String)session.getAttribute("destCity_lat"))%>" />
	<input type="hidden" name="destCity_lng" id="destCity_lng" value="<%=NullCheck.check((String)session.getAttribute("destCity_lng"))%>" />


		<input type="hidden" name="distance" id="distance" value="<%=NullCheck.check((String)session.getAttribute("distance"))%>" />
		<input type="hidden" name="duration" id="duration" value="<%=NullCheck.check((String)session.getAttribute("duration"))%>" />


		</div>
    </div>




    <div class="form-group form-group-sm">

	<div class='input-group'>
	<input type='text' id='searchKey' name='searchKey' style="font-size: 14px; padding-left: 5px; width: 110px;" class="form-control" placeholder="Search Key">

	</div>

    <div class="input-group input-group-md">





    <div class='input-group-addon'>From:</div>
    <div class='input-group date' id='datetimepicker1'>
    <input type='text' style="font-size: 14px; padding-left: 5px; padding-right: 5px; width: 90px;" class="form-control"  <%if(request.getParameter("startDate")!=null){%> value="<%=request.getParameter("startDate")%>"<%}%> name="startDate" id="startDate" placeholder="Date">
    <span class="input-group-addon">
    <span class="glyphicon glyphicon-calendar"></span>
    </span>

    </div>

    <div class='input-group-addon'>To:</div>
    <div class='input-group date' id='datetimepicker2'>
    <input type='text' style="font-size: 14px; padding-left: 5px; padding-right: 5px; width: 90px;" class="form-control" <%if(request.getParameter("endDate")!=null){%> value="<%=request.getParameter("endDate")%>"<%}%> name="endDate" id="endDate" placeholder="Date">

    <span class="input-group-addon">
    <span class="glyphicon glyphicon-calendar"></span>
    </span>

    </div>


    </div>
    <button class="btn btn-default btn-sm" type="button" onclick="loadTrucks();" >Filter</button>
	<button class="btn btn-default btn-sm" type="button" onclick="clearSearchKeys();" >Reset</button>

	</div>
    <HR style="margin-bottom: 8px;margin-top: 5px;">
<!--
    <div class="form-group form-group-sm">

    <strong>Haul:</strong> &nbsp;&nbsp;All <input type="radio" onchange="loadTrucks();" name="haulFilter" value="All" <%if(request.getParameter("haulFilter")==null || request.getParameter("haulFilter").equals("All")){%>checked<%}%> />
    Head <input type="radio" onchange="loadTrucks();" name="haulFilter" value="Headhaul" <%if(request.getParameter("haulFilter")!=null && request.getParameter("haulFilter").equals("Headhaul")){%>checked<%}%> />
    Back <input type="radio" onchange="loadTrucks();" name="haulFilter" value="Backhaul" <%if(request.getParameter("haulFilter")!=null && request.getParameter("haulFilter").equals("Backhaul")){%>checked<%}%> />

</div>
-->
    <!--<button type="submit" class="btn btn-default">Filter</button>-->
<!--
    &nbsp;&nbsp;&nbsp;<strong>Trailer:&nbsp;&nbsp;</strong>
    <div class="form-group form-group-sm">

    All <input type="radio" onchange="loadTrucks();" name="eqTypeFilter" value="All" <%if(request.getParameter("eqTypeFilter")==null || request.getParameter("eqTypeFilter").equals("All")){%>checked<%}%> />
    Van <input type="radio" onchange="loadTrucks();" name="eqTypeFilter" value="Van" <%if(request.getParameter("eqTypeFilter")!=null && request.getParameter("eqTypeFilter").equals("Van")){%>checked<%}%> />
    Reefer <input type="radio" onchange="loadTrucks();" name="eqTypeFilter" value="Reefer" <%if(request.getParameter("eqTypeFilter")!=null && request.getParameter("eqTypeFilter").equals("Reefer")){%>checked<%}%> />

    </div>
-->
    <div class="form-group form-group-sm">
    &nbsp;&nbsp;&nbsp; <strong>Load:&nbsp;&nbsp;</strong>


    All <input type="radio" onchange="loadTrucks();" name="loadTypeFilter" value="All" <%if(request.getParameter("loadTypeFilter")==null || request.getParameter("loadTypeFilter").equals("All")){%>checked<%}%> />
    Rush <input type="radio" onchange="loadTrucks();" name="loadTypeFilter" value="Rush" <%if(request.getParameter("loadTypeFilter")!=null && request.getParameter("loadTypeFilter").equals("Rush")){%>checked<%}%> />
    Partial <input type="radio" onchange="loadTrucks();" name="loadTypeFilter" value="Partial" <%if(request.getParameter("loadTypeFilter")!=null && request.getParameter("loadTypeFilter").equals("Partial")){%>checked<%}%> />
    In Transit <input type="radio" onchange="loadTrucks();" name="loadTypeFilter" value="In Transit" <%if(request.getParameter("loadTypeFilter")!=null && request.getParameter("loadTypeFilter").equals("In Transit")){%>checked<%}%> />




    &nbsp;&nbsp;&nbsp;<strong>Availability:&nbsp;&nbsp;</strong>
    

        <%if(session.getAttribute("isAdmin").equals("true")){%>
    All <input type="radio" onchange="loadTrucks();" name="isOnlineFilter" value="All" <%if(request.getParameter("isOnlineFilter")!=null && request.getParameter("isOnlineFilter").equals("All")){%>checked<%}%> />
    Available<input type="radio" onchange="loadTrucks();" name="isOnlineFilter" value="Online" <%if(request.getParameter("isOnlineFilter")==null || request.getParameter("isOnlineFilter").equals("Online")){%>checked<%}%> />
    Not Available<input type="radio" onchange="loadTrucks();" name="isOnlineFilter" value="Offline" <%if(request.getParameter("isOnlineFilter")!=null && request.getParameter("isOnlineFilter").equals("Offline")){%>checked<%}%> />
        <%}else{%>
    Available<input type="radio" name="isOnlineFilter" value="Online" checked />
        <%}%>


    &nbsp;&nbsp;&nbsp;<strong>Show More:&nbsp;</strong>

    <input type="checkbox" onchange="loadTrucks();" name="IS_SHOW_MORE_COL" id="IS_SHOW_MORE_COL" value="IS_SHOW_MORE_COL" <%if(session.getAttribute("IS_SHOW_MORE_COL").equals("true")){%>checked<%}%> />
    <input type="hidden" value="Filter Board" name="Go" />

    </div>

    </form>
    <!-- end search form -->
    </div>
	</nav> <!-- end of nav -->
	<!-- Main page: -->

	<div class="container-fluid">

	<div class="row">
			<%
			String dateString = new java.text.SimpleDateFormat("MM/dd/yyyy.HH.mm.ss").format(new java.util.Date());
			%>
			<input type="hidden" name="timestamp" id="timestamp" value="<%if(request.getParameter("dateString")!=null){%><%=request.getParameter("dateString")%><%}else{%><%=dateString%><%}%>" >
	<div id="trucklist" style="float:none;width:100%; overflow-y:auto;"></div>


	</div>



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
	<li>voice: 1.310.903.6014</li>
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
	<button type="button" class="btn btn-primary" data-dismiss="modal" onclick="location.href='https://www.mytruckboard.com'">Dismiss</button>

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
	        	