<%@ page import="com.big.util.*,java.text.*,java.util.*,java.io.*,javax.xml.parsers.*,org.w3c.dom.*,java.sql.*,java.text.DateFormat" %>


	<html>

	<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<meta name="description" content="">
	<meta name="author" content="">
	<title>MYTRUCKBOARD 2.0 - dispatch board</title>
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

	<!-- =============== APP STYLES ===============-->
	<!--<link rel="stylesheet" href="css/table-app.css" id="maincss">

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


    <script language="JavaScript" type="text/javascript">

    function updateLoadStatus(loadID, newStatus) {
	var selectBox = "select" + loadID;
	document.getElementById(selectBox).style.backgroundColor = "orange";
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
		     
			var addressList = xmlhttp.responseText.split("<ITEM>");
			var updatedSelectBox = "select"+addressList[2];
			var updatedSpanBox = "spanWOLink"+addressList[2];
			if(addressList[4] =="1"){
				document.getElementById(updatedSelectBox).style.backgroundColor = "green";
				if(addressList[3] =="Open"){
					document.getElementById(updatedSpanBox).style.color = "red";
				}else if(addressList[3] =="Open"){
					document.getElementById(updatedSpanBox).style.color = "red";
				}else if(addressList[3] =="Refused"){
					document.getElementById(updatedSpanBox).style.color = "purple";
				}else if(addressList[3] =="Covered"){
					document.getElementById(updatedSpanBox).style.color = "blue";
				}else if(addressList[3] =="Dispatched"){
					document.getElementById(updatedSpanBox).style.color = "brown";
				}else if(addressList[3] =="On Route"){
					document.getElementById(updatedSpanBox).style.color = "green";
				}else if(addressList[3] =="Unloading"){
					document.getElementById(updatedSpanBox).style.color = "darkgray";
				}else if(addressList[3] =="In Yard"){
					document.getElementById(updatedSpanBox).style.color = "lightCoral";
				}else if(addressList[3] =="Pending"){
					document.getElementById(updatedSpanBox).style.color = "orange";
				}else{
					document.getElementById(updatedSpanBox).style.color = "black";			
				}
			}else{
				document.getElementById(updatedSelectBox).style.backgroundColor = "red";
			}
		}
		}
		
		var responseString = "?consignee_count=0";
		responseString = responseString + "&load_id=" + loadID;
		responseString = responseString + "&load_status=" + newStatus;
		xmlhttp.open("GET", "add_shipper_new_load_detail.changeStatus.jsp" + responseString,true);
		xmlhttp.send();	
    }
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

		function searchBoard(){
		
		}

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

				<li class="dropdown active">
					<a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">Dispatch <span class="caret"></span></a>

						<ul class="dropdown-menu" role="menu">
						<li><a href="new_load.jsp">New Load</a></li>
						<li><a href="dispatch_board.jsp">Dispatch Board</a></li>
						<li><a href="dispatch_customers.jsp">Customers</a></li>
						<li><a href="dispatch_shippers.jsp">Shippers</a></li>
						<li><a href="dispatch_consigneers.jsp">Consignees</a></li>
						<li><a href="dispatch_carriers.jsp">Carriers</a></li>
						<li><a href="dispatch_trucks.jsp">Trucks</a></li>
						<li><a href="dispatch_customsbrokers.jsp">Customs Brokers</a></li>

						</ul>
				</li>


				</ul>

				<ul class="nav navbar-nav navbar-right">

				<li class="dropdown">
				<a href="#" class="dropdown-toggle active" data-toggle="dropdown" role="button" aria-expanded="false">Hello <b><%=NullCheck.check((String)session.getAttribute("f_name"))%></b><span class="caret"></span></a>
				<ul class="dropdown-menu" role="menu">
				<li><a href="company_profile_view.jsp">My Account</a></li>
					<%if(session.getAttribute("isAdmin").equals("true")){%>
				<li><a href="manage_users.jsp">My Users</a></li>
				<li><a href="manage_teams.jsp">My Teams</a></li>
				<li><a href="add_user.jsp">Add User</a></li>
				<li><a href="add_truck.jsp">Add Truck</a></li>
					<%}%>

				<li><a href="javascript:void(0)" onclick="logoutuser('<%=session.getAttribute("uuid")%>')" data-toggle="modal" data-target="#logoutconfirm">Log Out</a></li>

				</ul>
				</ul>
				</div><!--/.nav-collapse -->

<HR style="margin-bottom: 5px;margin-top: 5px;">

    <!-- main select row -->
<div class="row">
	<div class="col-sm-12" align="center">

	<form class="form-inline" name="searchForm" id="searchForm" action="dispatch_board.jsp" method="post">

	<div class="form-group form-group-sm">
	<label class="sr-only">SelectForm</label>
	<div class="input-group input-group-sm">


			<select class="form-control" name="searchType" onChange="window.location.href=this.value">
			<option value="dispatch_board.jsp">Filter for:</option>
			<option value="dispatch_board.jsp?searchType=LoadStatus&searchKey=Pending">Pending</option>
			<option value="dispatch_board.jsp?searchType=LoadStatus&searchKey=Open">Open</option>
			<option value="dispatch_board.jsp?searchType=LoadStatus&searchKey=Refused">Refused</option>
			<option value="dispatch_board.jsp?searchType=LoadStatus&searchKey=Covered">Covered</option>
			<option value="dispatch_board.jsp?searchType=LoadStatus&searchKey=Dispatched">Dispatched</option>
			<option value="dispatch_board.jsp?searchType=LoadStatus&searchKey=On Route&close=true" >On Route</option>
			<option value="dispatch_board.jsp?searchType=LoadStatus&searchKey=unloading">Unloading</option>
			<option value="dispatch_board.jsp?searchType=LoadStatus&searchKey=In Yard&close=true">In Yard</option>
			<option value="dispatch_board.jsp">*Clear Filter*</option>
			</select>


			</div>
	</div>

 or


	<div class="form-group form-group-sm">
	<label class="sr-only">SelectForm</label>
	<div class="input-group input-group-sm">
	<div class="input-group-addon" >Find:</div>

	<input type="text" class="form-control" id="searchKey" name="searchKey" placeholder="Search key" value="<%=NullCheck.check(request.getParameter("searchKey"))%>" />

	<div class="input-group-addon">Search For:</div>
			<select class="form-control" name="searchType" >
			<option value="all" <%if(request.getParameter("searchType")!=null && request.getParameter("searchType").equals("all")){%>selected<%}%> >Search All</option>
			<option value="LoadStatus" <%if(request.getParameter("searchType")!=null && request.getParameter("searchType").equals("LoadStatus")){%>selected<%}%> >Load Status</option>
			<option value="load_number" <%if(request.getParameter("searchType")!=null && request.getParameter("searchType").equals("load_number")){%>selected<%}%> >Load Number</option>
			<option value="wo_number" <%if(request.getParameter("searchType")!=null && request.getParameter("searchType").equals("wo_number")){%>selected<%}%> >W/O</option>
			<option value="customer" <%if(request.getParameter("searchType")!=null && request.getParameter("searchType").equals("customer")){%>selected<%}%> >Customer</option>
			<option value="dispatcher" <%if(request.getParameter("searchType")!=null && request.getParameter("searchType").equals("dispatcher")){%>selected<%}%> >Dispatcher</option>
			<option value="carrier" <%if(request.getParameter("searchType")!=null && request.getParameter("searchType").equals("carrier")){%>selected<%}%> >Carrier</option>
			<option value="consignee" <%if(request.getParameter("searchType")!=null && request.getParameter("searchType").equals("consignee")){%>selected<%}%> >Consignee</option>
			<option value="shipper" <%if(request.getParameter("searchType")!=null && request.getParameter("searchType").equals("shipper")){%>selected<%}%> >Shipper</option>
			</select>


	</div>
	</div>

	<div class="form-group form-group-sm">

	<div class="input-group input-group-sm">

	<div class='input-group-addon'>From:</div>
	<div class='input-group date' id='datetimepicker1'>
	<input type='text' style="width: 95px;" class="form-control"  <%if(request.getParameter("startDate")!=null){%> value="<%=request.getParameter("startDate")%>"<%}%> name="startDate" id="startDate" placeholder="Date">
	<span class="input-group-addon">
	<span class="glyphicon glyphicon-calendar"></span>
	</span>

	</div>

	<div class='input-group-addon'>To:</div>
	<div class='input-group date' id='datetimepicker2'>
	<input type='text'  style="width: 95px;" class="form-control" <%if(request.getParameter("endDate")!=null){%> value="<%=request.getParameter("endDate")%>"<%}%> name="endDate" id="endDate" placeholder="Date">

	<span class="input-group-addon">
	<span class="glyphicon glyphicon-calendar"></span>
	</span>

	</div>


	</div>
	<button class="btn btn-default btn-sm" type="submit" >Go</button>

	</div>

	</form>
	<!-- end search form -->
	</div>
	</div>


	</nav> <!-- end of nav -->


	<!-- Main page: -->

	<div class="container-fluid">
	<div class="row">
	<div class="col-md-12">
	<br/><br/><br/><br/><br/><br/>
	</div>
	<div class="col-md-1">
        <a href="dispatch_board.jsp?searchType=LoadStatus&searchKey=Pending" ><span style="color:orange;" >Pending</span></a>
	</div>
	<div class="col-md-1">
        <a href="dispatch_board.jsp?searchType=LoadStatus&searchKey=Open" ><span style="color:red;" >Open</span></a>
	</div>
	<div class="col-md-1">
        <a href="dispatch_board.jsp?searchType=LoadStatus&searchKey=Refused" ><span style="color:purple;" >Refused</span></a>
	</div>
	<div class="col-md-1">
        <a href="dispatch_board.jsp?searchType=LoadStatus&searchKey=Covered" ><span style="color:blue;" >Covered</span></a>
	</div>
	<div class="col-md-1">
        <a href="dispatch_board.jsp?searchType=LoadStatus&searchKey=Dispatched" ><span style="color:brown;" >Dispatched</span></a>
	</div>
	<div class="col-md-1">
        <a href="dispatch_board.jsp?searchType=LoadStatus&searchKey=On Route&close=true" ><span style="color:green;" >On Route</span></a>
	</div>
	<div class="col-md-1">
        <a href="dispatch_board.jsp?searchType=LoadStatus&searchKey=Unloading" ><span style="color:darkgrey;" >Unloading</span></a>
	</div>
	<div class="col-md-1">
        <a href="dispatch_board.jsp?searchType=LoadStatus&searchKey=In Yard&close=true" ><span style="color:lightCoral;" >In Yard</span></a>
	</div>
	<div class="col-md-4">&nbsp;
	</div>
	<div class="col-md-12">
	<div class="table-responsive">
	<table class="table table-hover table-bordered tablesorter" id="boardtable">
	<thead style="font-size:13px;" >
	<tr style="background:#F8F8F8;">
	<th>Load #</th>
	<th>W/O</th>
	<th>Dispatch</th>
	<th>Broker Rate</th>
	<th>Carrier Fee</th>
	<th>Fuel Advance</th>
	<th>FAT</th>
	<th>Driver/Carrier</th>
	<th>Ship Date</th>
	<th>Del Date</th>
	<th>Customer</th>
	<th>Origin</th>
	<th>Destination</th>
	<th>Load Status</th>
	</tr>
	</thead>
	<tbody style="font-size:13px;">
		<%if(true){%>
		<%
	         try{
			Vector userList = new Vector();
			HashMap user_map = new HashMap();
			Vector resultSetVector = new Vector();
			HashMap resultSetMap = new HashMap();

			Class.forName("com.mysql.jdbc.Driver");
			String url = "jdbc:mysql://localhost/test?zeroDateTimeBehavior=convertToNull";
			Connection connection = DriverManager.getConnection(url,"<USERNAME>", "<PASSWORD>");			

			PreparedStatement ps = connection.prepareStatement("select * from test.TRUCKING_USERS WHERE COMPANY_ID = ?");
			ps.setString(1, uuid);
			ResultSet resultSet = ps.executeQuery();
			while (resultSet.next()) {
				String[] userItem = new String[4];
				userItem[0] = resultSet.getString("email");
				userItem[1] = resultSet.getString("f_name");
				userItem[2] = resultSet.getString("l_name");
				userItem[3] = resultSet.getString("phone");
				user_map.put(resultSet.getString("email") , userItem);
			}
			
				PreparedStatement psMain = connection.prepareStatement("select * from test.load_board left join test.load_board_line_consignee on load_board.load_board_id=load_board_line_consignee.load_id left join test.locations as con on load_board_line_consignee.consignee_id=con.location_id left join test.load_board_line on load_board.load_board_id=load_board_line.load_id left join test.locations as shp on load_board_line.shipper_id=shp.location_id left join test.trucking_equipment on load_board.load_equipment_id=trucking_equipment.id left join test.locations on load_board.bill_to_id = locations.location_id WHERE load_board.COMPANY_ID = ? order by load_board.ts asc");
				psMain.setString(1, uuid);
				if(request.getParameter("searchType")!=null){
					if(request.getParameter("searchType").equals("LoadStatus")){
						if(request.getParameter("startDate")!=null && !request.getParameter("startDate").equals("") && request.getParameter("endDate")!=null && !request.getParameter("endDate").equals("")){
								java.sql.Date start = null;
								java.sql.Date end = null;
								DateFormat formatter = new SimpleDateFormat("MM-dd-yyyy.HH.mm.ss");
								start = new java.sql.Date(((java.util.Date)formatter.parse(request.getParameter("startDate") + ".00.00.00" )).getTime());
								end = new java.sql.Date(((java.util.Date)formatter.parse(request.getParameter("endDate") + ".23.59.59" )).getTime());						
								psMain = connection.prepareStatement("select * from test.load_board left join test.load_board_line_consignee on load_board.load_board_id=load_board_line_consignee.load_id left join test.locations as con on load_board_line_consignee.consignee_id=con.location_id left join test.load_board_line on load_board.load_board_id=load_board_line.load_id left join test.locations as shp on load_board_line.shipper_id=shp.location_id left join test.trucking_equipment on load_board.load_equipment_id=trucking_equipment.id left join test.locations on load_board.bill_to_id = locations.location_id WHERE load_board.COMPANY_ID = ? and (load_board.load_number = ? or load_board.load_wo = ? or trucking_equipment.name like ? or locations.org_name like ?  or  con.org_name like ? or shp.org_name like ?  or load_board.disDetail like ?) and (load_board_line.pickup_Date BETWEEN ? AND ? or load_board_line_consignee.pickup_Date BETWEEN ? AND ?) order by load_board.ts asc");			
								psMain.setString(1, uuid);
								psMain.setString(2, request.getParameter("searchKey"));
								psMain.setString(3, request.getParameter("searchKey"));
								psMain.setString(4, "%" + request.getParameter("searchKey") + "%");
								psMain.setString(5, "%" + request.getParameter("searchKey") + "%");
								psMain.setString(6, "%" + request.getParameter("searchKey") + "%");
								psMain.setString(7, "%" + request.getParameter("searchKey") + "%");
								psMain.setString(8, "%" + request.getParameter("searchKey") + "%");
								psMain.setDate(9, start);
								psMain.setTimestamp(10, new java.sql.Timestamp(end.getTime()));
								psMain.setDate(11, start);
								psMain.setTimestamp(12, new java.sql.Timestamp(end.getTime()));								
						}else{
								psMain = connection.prepareStatement("select * from test.load_board left join test.load_board_line_consignee on load_board.load_board_id=load_board_line_consignee.load_id left join test.locations as con on load_board_line_consignee.consignee_id=con.location_id left join test.load_board_line on load_board.load_board_id=load_board_line.load_id left join test.locations as shp on load_board_line.shipper_id=shp.location_id left join test.trucking_equipment on load_board.load_equipment_id=trucking_equipment.id left join test.locations on load_board.bill_to_id = locations.location_id WHERE load_board.COMPANY_ID = ? and load_board.load_status = ? order by load_board.ts asc");			
								psMain.setString(1, uuid);
								psMain.setString(2, request.getParameter("searchKey"));
						}					
					}else if(request.getParameter("searchType").equals("all")){
						if(request.getParameter("startDate")!=null && !request.getParameter("startDate").equals("") && request.getParameter("endDate")!=null && !request.getParameter("endDate").equals("")){
								java.sql.Date start = null;
								java.sql.Date end = null;
								DateFormat formatter = new SimpleDateFormat("MM-dd-yyyy.HH.mm.ss");
								start = new java.sql.Date(((java.util.Date)formatter.parse(request.getParameter("startDate") + ".00.00.00" )).getTime());
								end = new java.sql.Date(((java.util.Date)formatter.parse(request.getParameter("endDate") + ".23.59.59" )).getTime());						
								psMain = connection.prepareStatement("select * from test.load_board left join test.load_board_line_consignee on load_board.load_board_id=load_board_line_consignee.load_id left join test.locations as con on load_board_line_consignee.consignee_id=con.location_id left join test.load_board_line on load_board.load_board_id=load_board_line.load_id left join test.locations as shp on load_board_line.shipper_id=shp.location_id left join test.trucking_equipment on load_board.load_equipment_id=trucking_equipment.id left join test.locations on load_board.bill_to_id = locations.location_id WHERE load_board.COMPANY_ID = ? and (load_board.load_number = ? or load_board.load_wo = ? or trucking_equipment.name like ? or locations.org_name like ?  or  con.org_name like ? or shp.org_name like ?  or load_board.disDetail like ?) and (load_board_line.pickup_Date BETWEEN ? AND ? or load_board_line_consignee.pickup_Date BETWEEN ? AND ?) order by load_board.ts asc");			
								psMain.setString(1, uuid);
								psMain.setString(2, request.getParameter("searchKey"));
								psMain.setString(3, request.getParameter("searchKey"));
								psMain.setString(4, "%" + request.getParameter("searchKey") + "%");
								psMain.setString(5, "%" + request.getParameter("searchKey") + "%");
								psMain.setString(6, "%" + request.getParameter("searchKey") + "%");
								psMain.setString(7, "%" + request.getParameter("searchKey") + "%");
								psMain.setString(8, "%" + request.getParameter("searchKey") + "%");
								psMain.setDate(9, start);
								psMain.setTimestamp(10, new java.sql.Timestamp(end.getTime()));
								psMain.setDate(11, start);
								psMain.setTimestamp(12, new java.sql.Timestamp(end.getTime()));								
						}else{
								psMain = connection.prepareStatement("select * from test.load_board left join test.load_board_line_consignee on load_board.load_board_id=load_board_line_consignee.load_id left join test.locations as con on load_board_line_consignee.consignee_id=con.location_id left join test.load_board_line on load_board.load_board_id=load_board_line.load_id left join test.locations as shp on load_board_line.shipper_id=shp.location_id left join test.trucking_equipment on load_board.load_equipment_id=trucking_equipment.id left join test.locations on load_board.bill_to_id = locations.location_id WHERE load_board.COMPANY_ID = ? and (load_board.load_number = ? or load_board.load_wo = ? or trucking_equipment.name like ? or locations.org_name like ?  or  con.org_name like ? or shp.org_name like ?  or load_board.disDetail like ?) order by load_board.ts asc");			
								psMain.setString(1, uuid);
								psMain.setString(2, request.getParameter("searchKey"));
								psMain.setString(3, request.getParameter("searchKey"));
								psMain.setString(4, "%" + request.getParameter("searchKey") + "%");
								psMain.setString(5, "%" + request.getParameter("searchKey") + "%");
								psMain.setString(6, "%" + request.getParameter("searchKey") + "%");
								psMain.setString(7, "%" + request.getParameter("searchKey") + "%");
								psMain.setString(8, "%" + request.getParameter("searchKey") + "%");
						}
					}
					if(request.getParameter("searchType").equals("load_number")){
						if(request.getParameter("startDate")!=null && !request.getParameter("startDate").equals("") && request.getParameter("endDate")!=null && !request.getParameter("endDate").equals("")){
							java.sql.Date start = null;
							java.sql.Date end = null;
							DateFormat formatter = new SimpleDateFormat("MM-dd-yyyy.HH.mm.ss");
							start = new java.sql.Date(((java.util.Date)formatter.parse(request.getParameter("startDate") + ".00.00.00" )).getTime());
							end = new java.sql.Date(((java.util.Date)formatter.parse(request.getParameter("endDate") + ".23.59.59" )).getTime());						
							psMain = connection.prepareStatement("select * from test.load_board left join test.load_board_line_consignee on load_board.load_board_id=load_board_line_consignee.load_id left join test.locations as con on load_board_line_consignee.consignee_id=con.location_id left join test.load_board_line on load_board.load_board_id=load_board_line.load_id left join test.locations as shp on load_board_line.shipper_id=shp.location_id left join test.trucking_equipment on load_board.load_equipment_id=trucking_equipment.id left join test.locations on load_board.bill_to_id = locations.location_id WHERE load_board.COMPANY_ID = ? and load_board.load_number = ? and (load_board_line.pickup_Date BETWEEN ? AND ? or load_board_line_consignee.pickup_Date BETWEEN ? AND ?) order by load_board.ts asc");			
							psMain.setString(1, uuid);
							psMain.setString(2, request.getParameter("searchKey"));
							psMain.setDate(3, start);
							psMain.setTimestamp(4, new java.sql.Timestamp(end.getTime()));
							psMain.setDate(5, start);
							psMain.setTimestamp(6, new java.sql.Timestamp(end.getTime()));								
						}else{
							psMain = connection.prepareStatement("select * from test.load_board left join test.load_board_line_consignee on load_board.load_board_id=load_board_line_consignee.load_id left join test.locations as con on load_board_line_consignee.consignee_id=con.location_id left join test.load_board_line on load_board.load_board_id=load_board_line.load_id left join test.locations as shp on load_board_line.shipper_id=shp.location_id left join test.trucking_equipment on load_board.load_equipment_id=trucking_equipment.id left join test.locations on load_board.bill_to_id = locations.location_id WHERE load_board.COMPANY_ID = ? and load_board.load_number = ? order by load_board.ts asc");			
							psMain.setString(1, uuid);
							psMain.setString(2, request.getParameter("searchKey"));
						}	
					}
					if(request.getParameter("searchType").equals("wo_number")){
						if(request.getParameter("startDate")!=null && !request.getParameter("startDate").equals("") && request.getParameter("endDate")!=null && !request.getParameter("endDate").equals("")){
							java.sql.Date start = null;
							java.sql.Date end = null;
							DateFormat formatter = new SimpleDateFormat("MM-dd-yyyy.HH.mm.ss");
							start = new java.sql.Date(((java.util.Date)formatter.parse(request.getParameter("startDate") + ".00.00.00" )).getTime());
							end = new java.sql.Date(((java.util.Date)formatter.parse(request.getParameter("endDate") + ".23.59.59" )).getTime());						
							psMain = connection.prepareStatement("select * from test.load_board left join test.load_board_line_consignee on load_board.load_board_id=load_board_line_consignee.load_id left join test.locations as con on load_board_line_consignee.consignee_id=con.location_id left join test.load_board_line on load_board.load_board_id=load_board_line.load_id left join test.locations as shp on load_board_line.shipper_id=shp.location_id left join test.trucking_equipment on load_board.load_equipment_id=trucking_equipment.id left join test.locations on load_board.bill_to_id = locations.location_id WHERE load_board.COMPANY_ID = ? and load_board.load_wo = ? and (load_board_line.pickup_Date BETWEEN ? AND ? or load_board_line_consignee.pickup_Date BETWEEN ? AND ?) order by load_board.ts asc");			
							psMain.setString(1, uuid);
							psMain.setString(2, request.getParameter("searchKey"));
							psMain.setDate(3, start);
							psMain.setTimestamp(4, new java.sql.Timestamp(end.getTime()));
							psMain.setDate(5, start);
							psMain.setTimestamp(6, new java.sql.Timestamp(end.getTime()));								
						}else{
							psMain = connection.prepareStatement("select * from test.load_board left join test.load_board_line_consignee on load_board.load_board_id=load_board_line_consignee.load_id left join test.locations as con on load_board_line_consignee.consignee_id=con.location_id left join test.load_board_line on load_board.load_board_id=load_board_line.load_id left join test.locations as shp on load_board_line.shipper_id=shp.location_id left join test.trucking_equipment on load_board.load_equipment_id=trucking_equipment.id left join test.locations on load_board.bill_to_id = locations.location_id WHERE load_board.COMPANY_ID = ? and load_board.load_wo = ? order by load_board.ts asc");			
							psMain.setString(1, uuid);
							psMain.setString(2, request.getParameter("searchKey"));
						}
					}
					if(request.getParameter("searchType").equals("carrier")){
						if(request.getParameter("startDate")!=null && !request.getParameter("startDate").equals("") && request.getParameter("endDate")!=null && !request.getParameter("endDate").equals("")){
							java.sql.Date start = null;
							java.sql.Date end = null;
							DateFormat formatter = new SimpleDateFormat("MM-dd-yyyy.HH.mm.ss");
							start = new java.sql.Date(((java.util.Date)formatter.parse(request.getParameter("startDate") + ".00.00.00" )).getTime());
							end = new java.sql.Date(((java.util.Date)formatter.parse(request.getParameter("endDate") + ".23.59.59" )).getTime());						
							psMain = connection.prepareStatement("select * from test.load_board left join test.load_board_line_consignee on load_board.load_board_id=load_board_line_consignee.load_id left join test.locations as con on load_board_line_consignee.consignee_id=con.location_id left join test.load_board_line on load_board.load_board_id=load_board_line.load_id left join test.locations as shp on load_board_line.shipper_id=shp.location_id left join test.trucking_equipment on load_board.load_equipment_id=trucking_equipment.id left join test.locations on load_board.bill_to_id = locations.location_id WHERE load_board.COMPANY_ID = ? and trucking_equipment.name like ? and (load_board_line.pickup_Date BETWEEN ? AND ? or load_board_line_consignee.pickup_Date BETWEEN ? AND ?) order by load_board.ts asc");			
							psMain.setString(1, uuid);
							psMain.setString(2, "%" + request.getParameter("searchKey") + "%");
							psMain.setDate(3, start);
							psMain.setTimestamp(4, new java.sql.Timestamp(end.getTime()));
							psMain.setDate(5, start);
							psMain.setTimestamp(6, new java.sql.Timestamp(end.getTime()));								
						}else{
							psMain = connection.prepareStatement("select * from test.load_board left join test.load_board_line_consignee on load_board.load_board_id=load_board_line_consignee.load_id left join test.locations as con on load_board_line_consignee.consignee_id=con.location_id left join test.load_board_line on load_board.load_board_id=load_board_line.load_id left join test.locations as shp on load_board_line.shipper_id=shp.location_id left join test.trucking_equipment on load_board.load_equipment_id=trucking_equipment.id left join test.locations on load_board.bill_to_id = locations.location_id WHERE load_board.COMPANY_ID = ? and trucking_equipment.name like ? order by load_board.ts asc");			
							psMain.setString(1, uuid);
							psMain.setString(2, "%" + request.getParameter("searchKey") + "%");
						}
					}
					if(request.getParameter("searchType").equals("customer")){
						if(request.getParameter("startDate")!=null && !request.getParameter("startDate").equals("") && request.getParameter("endDate")!=null && !request.getParameter("endDate").equals("")){
							java.sql.Date start = null;
							java.sql.Date end = null;
							DateFormat formatter = new SimpleDateFormat("MM-dd-yyyy.HH.mm.ss");
							start = new java.sql.Date(((java.util.Date)formatter.parse(request.getParameter("startDate") + ".00.00.00" )).getTime());
							end = new java.sql.Date(((java.util.Date)formatter.parse(request.getParameter("endDate") + ".23.59.59" )).getTime());						
							psMain = connection.prepareStatement("select * from test.load_board left join test.load_board_line_consignee on load_board.load_board_id=load_board_line_consignee.load_id left join test.locations as con on load_board_line_consignee.consignee_id=con.location_id left join test.load_board_line on load_board.load_board_id=load_board_line.load_id left join test.locations as shp on load_board_line.shipper_id=shp.location_id left join test.trucking_equipment on load_board.load_equipment_id=trucking_equipment.id left join test.locations on load_board.bill_to_id = locations.location_id WHERE load_board.COMPANY_ID = ? and locations.org_name like ? and (load_board_line.pickup_Date BETWEEN ? AND ? or load_board_line_consignee.pickup_Date BETWEEN ? AND ?) order by load_board.ts asc");			
							psMain.setString(1, uuid);
							psMain.setString(2, "%" + request.getParameter("searchKey") + "%");
							psMain.setDate(3, start);
							psMain.setTimestamp(4, new java.sql.Timestamp(end.getTime()));
							psMain.setDate(5, start);
							psMain.setTimestamp(6, new java.sql.Timestamp(end.getTime()));								
						}else{
							psMain = connection.prepareStatement("select * from test.load_board left join test.load_board_line_consignee on load_board.load_board_id=load_board_line_consignee.load_id left join test.locations as con on load_board_line_consignee.consignee_id=con.location_id left join test.load_board_line on load_board.load_board_id=load_board_line.load_id left join test.locations as shp on load_board_line.shipper_id=shp.location_id left join test.trucking_equipment on load_board.load_equipment_id=trucking_equipment.id left join test.locations on load_board.bill_to_id = locations.location_id WHERE load_board.COMPANY_ID = ? and locations.org_name like ? order by load_board.ts asc");			
							psMain.setString(1, uuid);
							psMain.setString(2, "%" + request.getParameter("searchKey") + "%");
						}
					}
					if(request.getParameter("searchType").equals("consignee")){
						if(request.getParameter("startDate")!=null && !request.getParameter("startDate").equals("") && request.getParameter("endDate")!=null && !request.getParameter("endDate").equals("")){
							java.sql.Date start = null;
							java.sql.Date end = null;
							DateFormat formatter = new SimpleDateFormat("MM-dd-yyyy.HH.mm.ss");
							start = new java.sql.Date(((java.util.Date)formatter.parse(request.getParameter("startDate") + ".00.00.00" )).getTime());
							end = new java.sql.Date(((java.util.Date)formatter.parse(request.getParameter("endDate") + ".23.59.59" )).getTime());						
							psMain = connection.prepareStatement("select * from test.load_board left join test.load_board_line_consignee on load_board.load_board_id=load_board_line_consignee.load_id left join test.locations as con on load_board_line_consignee.consignee_id=con.location_id left join test.load_board_line on load_board.load_board_id=load_board_line.load_id left join test.locations as shp on load_board_line.shipper_id=shp.location_id left join test.trucking_equipment on load_board.load_equipment_id=trucking_equipment.id left join test.locations on load_board.bill_to_id = locations.location_id WHERE load_board.COMPANY_ID = ? and con.org_name like ?  and (load_board_line_consignee.pickup_Date BETWEEN ? AND ?)order by load_board.ts asc");			
							psMain.setString(1, uuid);
							psMain.setString(2, "%" + request.getParameter("searchKey") + "%");
							psMain.setDate(3, start);
							psMain.setTimestamp(4, new java.sql.Timestamp(end.getTime()));
						}else{
							psMain = connection.prepareStatement("select * from test.load_board left join test.load_board_line_consignee on load_board.load_board_id=load_board_line_consignee.load_id left join test.locations as con on load_board_line_consignee.consignee_id=con.location_id left join test.load_board_line on load_board.load_board_id=load_board_line.load_id left join test.locations as shp on load_board_line.shipper_id=shp.location_id left join test.trucking_equipment on load_board.load_equipment_id=trucking_equipment.id left join test.locations on load_board.bill_to_id = locations.location_id WHERE load_board.COMPANY_ID = ? and con.org_name like ? order by load_board.ts asc");			
							psMain.setString(1, uuid);
							psMain.setString(2, "%" + request.getParameter("searchKey") + "%");
						}
					}
					if(request.getParameter("searchType").equals("shipper")){
						if(request.getParameter("startDate")!=null && !request.getParameter("startDate").equals("") && request.getParameter("endDate")!=null && !request.getParameter("endDate").equals("")){
							java.sql.Date start = null;
							java.sql.Date end = null;
							DateFormat formatter = new SimpleDateFormat("MM-dd-yyyy.HH.mm.ss");
							start = new java.sql.Date(((java.util.Date)formatter.parse(request.getParameter("startDate") + ".00.00.00" )).getTime());
							end = new java.sql.Date(((java.util.Date)formatter.parse(request.getParameter("endDate") + ".23.59.59" )).getTime());						
							psMain = connection.prepareStatement("select * from test.load_board left join test.load_board_line_consignee on load_board.load_board_id=load_board_line_consignee.load_id left join test.locations as con on load_board_line_consignee.consignee_id=con.location_id left join test.load_board_line on load_board.load_board_id=load_board_line.load_id left join test.locations as shp on load_board_line.shipper_id=shp.location_id left join test.trucking_equipment on load_board.load_equipment_id=trucking_equipment.id left join test.locations on load_board.bill_to_id = locations.location_id WHERE load_board.COMPANY_ID = ? and shp.org_name like ?  and (load_board_line.pickup_Date BETWEEN ? AND ?) order by load_board.ts asc");			
							psMain.setString(1, uuid);
							psMain.setString(2, "%" + request.getParameter("searchKey") + "%");
							psMain.setDate(3, start);
							psMain.setTimestamp(4, new java.sql.Timestamp(end.getTime()));
						}else{
							psMain = connection.prepareStatement("select * from test.load_board left join test.load_board_line_consignee on load_board.load_board_id=load_board_line_consignee.load_id left join test.locations as con on load_board_line_consignee.consignee_id=con.location_id left join test.load_board_line on load_board.load_board_id=load_board_line.load_id left join test.locations as shp on load_board_line.shipper_id=shp.location_id left join test.trucking_equipment on load_board.load_equipment_id=trucking_equipment.id left join test.locations on load_board.bill_to_id = locations.location_id WHERE load_board.COMPANY_ID = ? and shp.org_name like ? order by load_board.ts asc");			
							psMain.setString(1, uuid);
							psMain.setString(2, "%" + request.getParameter("searchKey") + "%");
						}
					}
					if(request.getParameter("searchType").equals("dispatcher")){
						if(request.getParameter("startDate")!=null && !request.getParameter("startDate").equals("") && request.getParameter("endDate")!=null && !request.getParameter("endDate").equals("")){
							java.sql.Date start = null;
							java.sql.Date end = null;
							DateFormat formatter = new SimpleDateFormat("MM-dd-yyyy.HH.mm.ss");
							start = new java.sql.Date(((java.util.Date)formatter.parse(request.getParameter("startDate") + ".00.00.00" )).getTime());
							end = new java.sql.Date(((java.util.Date)formatter.parse(request.getParameter("endDate") + ".23.59.59" )).getTime());						
							psMain = connection.prepareStatement("select * from test.load_board left join test.load_board_line_consignee on load_board.load_board_id=load_board_line_consignee.load_id left join test.locations as con on load_board_line_consignee.consignee_id=con.location_id left join test.load_board_line on load_board.load_board_id=load_board_line.load_id left join test.locations as shp on load_board_line.shipper_id=shp.location_id left join test.trucking_equipment on load_board.load_equipment_id=trucking_equipment.id left join test.locations on load_board.bill_to_id = locations.location_id WHERE load_board.COMPANY_ID = ? and load_board.disDetail like ? and (load_board_line.pickup_Date BETWEEN ? AND ? or load_board_line_consignee.pickup_Date BETWEEN ? AND ?) order by load_board.ts asc");			
							psMain.setString(1, uuid);
							psMain.setString(2, "%" + request.getParameter("searchKey") + "%");
							psMain.setDate(3, start);
							psMain.setTimestamp(4, new java.sql.Timestamp(end.getTime()));
							psMain.setDate(5, start);
							psMain.setTimestamp(6, new java.sql.Timestamp(end.getTime()));								
						
						}else{
							psMain = connection.prepareStatement("select * from test.load_board left join test.load_board_line_consignee on load_board.load_board_id=load_board_line_consignee.load_id left join test.locations as con on load_board_line_consignee.consignee_id=con.location_id left join test.load_board_line on load_board.load_board_id=load_board_line.load_id left join test.locations as shp on load_board_line.shipper_id=shp.location_id left join test.trucking_equipment on load_board.load_equipment_id=trucking_equipment.id left join test.locations on load_board.bill_to_id = locations.location_id WHERE load_board.COMPANY_ID = ? and load_board.disDetail like ? order by load_board.ts asc");			
							psMain.setString(1, uuid);
							psMain.setString(2, "%" + request.getParameter("searchKey") + "%");
						}
					}

				}
//			PreparedStatement psMain = connection.prepareStatement("select * from test.load_board left join test. left join test.trucking_equipment on load_board.load_equipment_id=trucking_equipment.id left join test.locations on load_board.bill_to_id = locations.location_id WHERE load_board.COMPANY_ID = ? order by load_board.ts asc");
//			PreparedStatement psMain = connection.prepareStatement("select * from test.trucking_equipment right join test.load_board on trucking_equipment.id=load_board.load_equipment_id WHERE trucking_equipment.COMPANY_ID = ? order by load_board.ts asc");
//			PreparedStatement psMain = connection.prepareStatement("select * from test.load_board left join test.trucking_equipment on load_board.load_equipment_id=trucking_equipment.id WHERE load_board.COMPANY_ID = ? order by load_board.ts asc");
//			PreparedStatement psMain = connection.prepareStatement("select * from test.load_board left join trucking_equipment on trucking_equipment.id=load_board.load_equipment_id WHERE load_board.COMPANY_ID = ?");
//			PreparedStatement psMain = connection.prepareStatement("select * from test.load_board right join test.trucking_equipment on trucking_equipment.id=load_board.load_equipment_id and right join test.locations on load_board.bill_to_id=locations.location_id WHERE load_board.COMPANY_ID = ? order by load_board.ts desc");
			resultSet = psMain.executeQuery();
			while (resultSet.next()) {
	String pickDate = "";
	String pickTime = "";
	if(resultSet.getTimestamp("load_board_line.pickup_date")!=null){
		pickDate = new SimpleDateFormat("MM-dd-yyyy").format(resultSet.getTimestamp("load_board_line.pickup_date"));
		pickTime = new SimpleDateFormat("HH:mm").format(resultSet.getTimestamp("load_board_line.pickup_date"));
	}
	
	String dropDate = "";
	String dropTime = "";
	if(resultSet.getTimestamp("load_board_line_consignee.pickup_date")!=null){
		dropDate = new SimpleDateFormat("MM-dd-yyyy").format(resultSet.getTimestamp("load_board_line_consignee.pickup_date"));
		dropTime = new SimpleDateFormat("HH:mm").format(resultSet.getTimestamp("load_board_line_consignee.pickup_date"));
	}			
				if(!resultSetMap.containsKey(resultSet.getString("load_board_id"))){
					resultSetVector.add(resultSet.getString("load_board_id"));
					String[] rowArray = new String[15];
					rowArray[0] = resultSet.getString("load_board_id");
					rowArray[1] = resultSet.getString("load_number");
					rowArray[2] = resultSet.getString("load_wo");
					rowArray[3] = resultSet.getString("disdetail");
					rowArray[4] = resultSet.getString("load_rate_all");
					rowArray[5] = resultSet.getString("load_carrier_fee");
					rowArray[6] = resultSet.getString("trucking_equipment.name");
					rowArray[7] = resultSet.getString("trucking_equipment.trailer");
					rowArray[8] = pickDate + " " + pickTime;
					rowArray[9] = dropDate + " " + dropTime;
					rowArray[10] = resultSet.getString("locations.org_name");
					rowArray[11] = resultSet.getString("shp.org_name");
					rowArray[12] = resultSet.getString("con.org_name");
					rowArray[13] = resultSet.getString("load_status");	
					rowArray[14] = resultSet.getString("advances_total");											
					resultSetMap.put(rowArray[0] , rowArray);
				}else{
					String[] rowArray = (String[])resultSetMap.get(resultSet.getString("load_board_id"));					
					DateFormat formatter = new SimpleDateFormat("MM-dd-yyyy HH:mm");		
					java.sql.Timestamp pickup_date_sql = null;
					if(rowArray[8]!=null && !rowArray[8].equals("") && !rowArray[8].equals(" ")){
						pickup_date_sql = new java.sql.Timestamp((formatter.parse(rowArray[8])).getTime());
						if(resultSet.getTimestamp("load_board_line.pickup_date")!=null && !pickup_date_sql.before(resultSet.getTimestamp("load_board_line.pickup_date"))){
							rowArray[8] = pickDate + " " + pickTime;					
							rowArray[11] = resultSet.getString("shp.org_name");
						}
					}else{
						rowArray[8] = pickDate + " " + pickTime;					
					}
					if(rowArray[9]!=null && !rowArray[9].equals("") && !rowArray[9].equals(" ")){
						pickup_date_sql = new java.sql.Timestamp((formatter.parse(rowArray[9])).getTime());
						if(resultSet.getTimestamp("load_board_line_consignee.pickup_date")!=null && !pickup_date_sql.after(resultSet.getTimestamp("load_board_line_consignee.pickup_date"))){
							rowArray[9] = dropDate + " " + dropTime;					
							rowArray[12] = resultSet.getString("con.org_name");
						}
					}else{
						rowArray[9] = dropDate + " " + dropTime;					
					}
					resultSetMap.put(rowArray[0] , rowArray);
				}
				%>
				<!--
	
	<tr>
	<td><%=resultSet.getString("load_number")%></td>
	<td>
	<%=resultSet.getString("load_wo")%>
	</td>
	<td>
	<%if(resultSet.getString("disdetail")!=null && !resultSet.getString("disdetail").equals("")){%>
	<%for(int jk =0;jk<resultSet.getString("disdetail").split(":").length;jk++){%>
		<p><%if(user_map.containsKey((resultSet.getString("disdetail").split(":")[jk]))){%>
	<%=NullCheck.check(((String[])user_map.get((resultSet.getString("disdetail").split(":")[jk])))[1])%>
	<%=NullCheck.check(((String[])user_map.get((resultSet.getString("disdetail").split(":")[jk])))[2])%>
	<%=NullCheck.check(((String[])user_map.get((resultSet.getString("disdetail").split(":")[jk])))[0])%></p>
		<%}%>
	<%}%>
	<%}%>
	</td>
	<td><%=resultSet.getFloat("load_rate_all")%></td>
	<td><%=resultSet.getFloat("load_carrier_fee")%></td>
	<td>&nbsp;</td>
	<td class="text-center">
	<div data-label="25%" class="radial-bar radial-bar-25 radial-bar-xs"></div>
	</td>
	<td>
	<%=NullCheck.check(resultSet.getString("trucking_equipment.name"))%> 
	<%=NullCheck.check(resultSet.getString("trucking_equipment.trailer"))%></td>
	
	<td><%=NullCheck.check(pickDate + " " + pickTime)%></td>
	<td><%=NullCheck.check(dropDate + " " + dropTime)%></td>
	<td><%=NullCheck.check(resultSet.getString("locations.org_name"))%></td>
	<td><%=NullCheck.check(resultSet.getString("shp.org_name"))%></td>
	<td><%=NullCheck.check(resultSet.getString("con.org_name"))%></td>
	<td><%=NullCheck.check(resultSet.getString("load_status"))%></td>
	</tr>	
				-->
				<%
			}
			connection.close();
			%>
			<%for(int l=0;l<resultSetVector.size();l++){%>
			<TR style="padding:5px;">
			<td style="padding:5px;">
			<% String colorTmp = "black"; %>
			<%if(NullCheck.check(((String[])resultSetMap.get((String)resultSetVector.get(l)))[13]).equals("Pending")){%>
				<% colorTmp = "orange"; %>
			<%}%>
			<%if(NullCheck.check(((String[])resultSetMap.get((String)resultSetVector.get(l)))[13]).equals("Open")){%>
				<% colorTmp = "red"; %>
			<%}%>
			<%if(NullCheck.check(((String[])resultSetMap.get((String)resultSetVector.get(l)))[13]).equals("Refused")){%>
				<% colorTmp = "purple"; %>
			<%}%>
			<%if(NullCheck.check(((String[])resultSetMap.get((String)resultSetVector.get(l)))[13]).equals("Covered")){%>
				<% colorTmp = "blue"; %>
			<%}%>
			<%if(NullCheck.check(((String[])resultSetMap.get((String)resultSetVector.get(l)))[13]).equals("Dispatched")){%>
				<% colorTmp = "brown"; %>
			<%}%>
			<%if(NullCheck.check(((String[])resultSetMap.get((String)resultSetVector.get(l)))[13]).equals("On Route")){%>
				<% colorTmp = "green"; %>
			<%}%>
			<%if(NullCheck.check(((String[])resultSetMap.get((String)resultSetVector.get(l)))[13]).equals("Unloading")){%>
				<% colorTmp = "darkgrey"; %>
			<%}%>
			<%if(NullCheck.check(((String[])resultSetMap.get((String)resultSetVector.get(l)))[13]).equals("In Yard")){%>
				<% colorTmp = "lightCoral"; %>
			<%}%>
			<a href="new_load.jsp?load_id=<%=((String[])resultSetMap.get((String)resultSetVector.get(l)))[0]%>" >
			<span style="color:<%=colorTmp%>;" name="spanWOLink<%=((String[])resultSetMap.get((String)resultSetVector.get(l)))[0]%>" id="spanWOLink<%=((String[])resultSetMap.get((String)resultSetVector.get(l)))[0]%>" >
			<%if(((String[])resultSetMap.get((String)resultSetVector.get(l)))[1]!=null && !((String[])resultSetMap.get((String)resultSetVector.get(l)))[1].equals("")){%>
			<%=NullCheck.check(((String[])resultSetMap.get((String)resultSetVector.get(l)))[1])%>
			<%}else{%>
			[none]
			<%}%>
			</span>
			</a>
			</td>	
			<td style="padding:5px;"><%=NullCheck.check(((String[])resultSetMap.get((String)resultSetVector.get(l)))[2])%></td>
			<td style="padding:5px;">

	<%if(((String[])resultSetMap.get((String)resultSetVector.get(l)))[3]!=null && !((String[])resultSetMap.get((String)resultSetVector.get(l)))[3].equals("")){%>
	<%for(int jk =0;jk<((String[])resultSetMap.get((String)resultSetVector.get(l)))[3].split(":").length;jk++){%>
		<p><%if(user_map.containsKey((((String[])resultSetMap.get((String)resultSetVector.get(l)))[3].split(":")[jk]))){%>
		<!--<%=NullCheck.check(((String[])user_map.get((((String[])resultSetMap.get((String)resultSetVector.get(l)))[3].split(":")[jk])))[0])%>-->
		<%=NullCheck.check(((String[])user_map.get((((String[])resultSetMap.get((String)resultSetVector.get(l)))[3].split(":")[jk])))[1])%>
		<!--<%=NullCheck.check(((String[])user_map.get((((String[])resultSetMap.get((String)resultSetVector.get(l)))[3].split(":")[jk])))[2])%>-->
		<%}%></p>				
	<%}%>				
	<%}%>				
			</td>	
			<td style="padding:5px;"><%=NullCheck.check(((String[])resultSetMap.get((String)resultSetVector.get(l)))[4])%></td>
			<td style="padding:5px;"><%=NullCheck.check(((String[])resultSetMap.get((String)resultSetVector.get(l)))[5])%></td>
			<td style="padding:5px;"><%=NullCheck.check(((String[])resultSetMap.get((String)resultSetVector.get(l)))[14])%></td>
			<td style="padding:5px;">&nbsp;</td>
			<td style="padding:5px;"><%=NullCheck.check(((String[])resultSetMap.get((String)resultSetVector.get(l)))[6])%>
			<%=NullCheck.check(((String[])resultSetMap.get((String)resultSetVector.get(l)))[7])%></td>	
			<td style="padding:5px;"><%=NullCheck.check(((String[])resultSetMap.get((String)resultSetVector.get(l)))[8])%></td>
			<td style="padding:5px;"><%=NullCheck.check(((String[])resultSetMap.get((String)resultSetVector.get(l)))[9])%></td>
			<td style="padding:5px;"><%=NullCheck.check(((String[])resultSetMap.get((String)resultSetVector.get(l)))[10])%></td>
			<td style="padding:5px;"><%=NullCheck.check(((String[])resultSetMap.get((String)resultSetVector.get(l)))[11])%></td>
			<td style="padding:5px;"><%=NullCheck.check(((String[])resultSetMap.get((String)resultSetVector.get(l)))[12])%></td>
			<td style="padding:5px;">
	<select name="select<%=((String[])resultSetMap.get((String)resultSetVector.get(l)))[0]%>" id="select<%=((String[])resultSetMap.get((String)resultSetVector.get(l)))[0]%>" onchange="updateLoadStatus('<%=((String[])resultSetMap.get((String)resultSetVector.get(l)))[0]%>',this.value)" >
        <option <%if(NullCheck.check(((String[])resultSetMap.get((String)resultSetVector.get(l)))[13]).equals("Pending") ){%>selected<%}%> value="Pending" name="load_status_label" id="load_status_label">Pending</a></option>
        <option <%if(NullCheck.check(((String[])resultSetMap.get((String)resultSetVector.get(l)))[13]).equals("Open")){%>selected<%}%> value="Open" name="load_status_label" id="load_status_label">Open</option>
        <option <%if(NullCheck.check(((String[])resultSetMap.get((String)resultSetVector.get(l)))[13]).equals("Refused")){%>selected<%}%> value="Refused" name="load_status_label" id="load_status_label">Refused</option>
        <option <%if(NullCheck.check(((String[])resultSetMap.get((String)resultSetVector.get(l)))[13]).equals("Covered")){%>selected<%}%> value="Covered" name="load_status_label" id="load_status_label">Covered</option>
        <option <%if(NullCheck.check(((String[])resultSetMap.get((String)resultSetVector.get(l)))[13]).equals("Dispatched")){%>selected<%}%> value="Dispatched" name="load_status_label" id="load_status_label">Dispatched</option>
        <option <%if(NullCheck.check(((String[])resultSetMap.get((String)resultSetVector.get(l)))[13]).equals("On Route")){%>selected<%}%> value="On Route" name="load_status_label" id="load_status_label">On Route</option>
        <option <%if(NullCheck.check(((String[])resultSetMap.get((String)resultSetVector.get(l)))[13]).equals("Unloading")){%>selected <%}%> value="Unloading" name="load_status_label" id="load_status_label">Unloading</option>
        <option <%if(NullCheck.check(((String[])resultSetMap.get((String)resultSetVector.get(l)))[13]).equals("In Yard")){%>selected<%}%> value="In Yard" name="load_status_label" id="load_status_label">In Yard</option>			
	</select>		
			</td>
			</tr>				
				
			<%}%>
			<%
			
	         }catch (Exception ex){
	             %><%=" " + ex %><%
	         }		
			%>
		<%}%>

	
	</tbody>
	</table>

	</div>
	</div>
	<!-- END table-responsive-->

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
	        	