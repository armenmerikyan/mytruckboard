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

	<link rel="stylesheet" href="css/navstyle2.css" />


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
				document.getElementById(updatedSelectBox).style.backgroundColor = "";
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
				updateLoadCounts();
			}else{
				document.getElementById(updatedSelectBox).style.backgroundColor = "red";
			}
		}
		}
		
		var responseString = "?consignee_count=0";
		responseString = responseString + "&load_id=" + loadID;
		responseString = responseString + "&load_status=" + newStatus;
		xmlhttp.open("GET", "add_shipper_new_load_detail.changeStatus.carrier.jsp" + responseString,true);
		xmlhttp.send();	
    }

    function updateLoadCounts() {
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
			document.getElementById("divCountDelivered").innerHTML = addressList[13];
			document.getElementById("divCountCompleted").innerHTML = addressList[14];
			document.getElementById("divCountInvoiced").innerHTML = addressList[15];
			document.getElementById("divCountPaid").innerHTML = addressList[16];
		}
		}
		xmlhttp.open("GET", "dispatch_board_counts.jsp" ,true);
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

    $('#datetimepicker100').datetimepicker({
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


        function showInvoicePayments(load_id, load_number, charge_type) {  	        	        
	        document.getElementById("inv_load_number").innerHTML = load_number;
	        document.getElementById("inv_load_number_detail").innerHTML = "";
	        document.getElementById("new_invoice_payment_name").value = "";
	        document.getElementById("new_invoice_payment_date").value = "";
	        document.getElementById("new_invoice_payment_amount").value = "";
	        
	        viewInvoicePayments(load_id);
        	gotItInvMessageShow();
        }
        function showInvoicePrint(load_id, load_number, charge_type) {  
            	window.open("new_load.invoice.pdf.jsp?load_id="+ load_id, load_id);	        	        
	     
        }
        function viewInvoicePayments(load_id) {
        
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
						var addressList = xmlhttp.responseText.split("<ITEM>");
	        				document.getElementById("inv_load_number_detail").innerHTML = addressList[0];
					    }
					  }
		
					var responseString = "?load_id=" + load_id;
					document.getElementById("invoice_load_id").value = load_id;
					responseString = responseString + "&new_fin_type=" + encodeURIComponent("Agent Bonus Payment");		
					xmlhttp.open("GET", "add_shipper_charges.jsp" + responseString ,true);
					xmlhttp.send();
        
        }
        function addNewInvoicePaymentQuick(load_id) {
        
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
						var addressList = xmlhttp.responseText.split("<ITEM>");
						document.getElementById("inv_load_number_detail").innerHTML = addressList[0];
						var invPaymentBoxName = "IPT" + addressList[7];
						var invPaymentBoxNameAmount = "IPTAM" + addressList[7];
						var invPaymentBoxNameTotal = "IPTAMT" + addressList[7];
						//var invPaymentBoxNameCom = "IPTAMTCOM" + addressList[7];
						//var amtDue= parseFloat(document.getElementById(invPaymentBoxNameCom).value) - parseFloat(addressList[2]);
						document.getElementById(invPaymentBoxName).value = addressList[2];
						document.getElementById(invPaymentBoxNameAmount).value = "0";
						//document.getElementById(invPaymentBoxNameTotal).value = amtDue;	
						document.getElementById(invPaymentBoxNameAmount).style.color = "";
						document.getElementById(invPaymentBoxName).style.color = "";	
						document.getElementById(invPaymentBoxNameTotal).style.color = "green";		
					    }
					  }
					var responseString = "?load_id=" + load_id;
					var invPaymentBoxNameAM = "IPTAM" + load_id
					var invPaymentBoxNameIPT = "IPT" + load_id;
					var invPaymentBoxNameT = "IPTAMT" + load_id;
					
					if(document.getElementById(invPaymentBoxNameAM).value == "")return ;
					if(document.getElementById(invPaymentBoxNameAM).value == "0"){
						document.getElementById(invPaymentBoxNameAM).value = "";	
						return ;
					}
					document.getElementById(invPaymentBoxNameAM).style.color = "orange";	
					document.getElementById(invPaymentBoxNameIPT).style.color = "orange";	
					document.getElementById(invPaymentBoxNameT).style.color = "orange";
					responseString = responseString + "&new_fin_type=" + encodeURIComponent("Agent Bonus Payment");
					responseString = responseString + "&new_fin_name=" + encodeURIComponent("List Item");
					responseString = responseString + "&new_fin_amount=" + document.getElementById(invPaymentBoxNameAM).value;
					//alert(load_id);
					xmlhttp.open("GET", "add_shipper_new_charge.jsp" + responseString ,true);
					xmlhttp.send();
        
        }
        function addNewInvoicePayment() {
        
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
						var addressList = xmlhttp.responseText.split("<ITEM>");
						document.getElementById("inv_load_number_detail").innerHTML = addressList[0];
						var invPaymentBoxName = "IPT" + addressList[7];
						var invPaymentBoxNameTotal = "IPTAMT" + addressList[7];
						//var invPaymentBoxNameCom = "IPTAMTCOM" + addressList[7];
						//var amtDue= parseFloat(document.getElementById(invPaymentBoxNameCom).value) - parseFloat(addressList[2]);
						document.getElementById(invPaymentBoxName).value = addressList[2];
						//document.getElementById(invPaymentBoxNameTotal).value = amtDue;
						document.getElementById(invPaymentBoxNameTotal).style.color = "green";	
						document.getElementById(invPaymentBoxName).style.color = "";	
					    }
					  }
					
					var invPaymentBoxNameT = "IPTAMT" + document.getElementById("invoice_load_id").value;	
					var invPaymentBoxNameIPT = "IPT" + document.getElementById("invoice_load_id").value;
					document.getElementById(invPaymentBoxNameT).style.color = "orange";
					document.getElementById(invPaymentBoxNameIPT).style.color = "orange";		
					var responseString = "?load_id=" + document.getElementById("invoice_load_id").value;
					responseString = responseString + "&new_fin_type=" + encodeURIComponent("Agent Bonus Payment");
					responseString = responseString + "&new_fin_name=" + document.getElementById("new_invoice_payment_name").value;
					responseString = responseString + "&new_fin_date=" + document.getElementById("new_invoice_payment_date").value;
					responseString = responseString + "&new_fin_amount=" + document.getElementById("new_invoice_payment_amount").value;		
					xmlhttp.open("GET", "add_shipper_new_charge.jsp" + responseString ,true);
					xmlhttp.send();
        
        }
        function removeFin(fin_id, fin_type) {
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
					    	
						var addressList = xmlhttp.responseText.split("<ITEM>");
						document.getElementById("inv_load_number_detail").innerHTML = addressList[0];
						var invPaymentBoxName = "IPT" + addressList[7]
						var invPaymentBoxNameTotal = "IPTAMT" + addressList[7];
						//var invPaymentBoxNameCom = "IPTAMTCOM" + addressList[7];
						document.getElementById(invPaymentBoxName).value = addressList[2];
						document.getElementById(invPaymentBoxNameTotal).value = addressList[9];	
						document.getElementById(invPaymentBoxNameTotal).style.color = "green";	
					    	//var amtDue= parseFloat(document.getElementById(invPaymentBoxNameCom).value) - parseFloat(addressList[2]);
						//document.getElementById(invPaymentBoxNameTotal).value = amtDue;	
					   }
					  }
		
					var responseString = "?load_id=" + document.getElementById("invoice_load_id").value;
					responseString = responseString + "&new_fin_type=" + fin_type;
					responseString = responseString + "&fin_id=" + fin_id;
					responseString = responseString + "&fin_remove=True";						
					xmlhttp.open("GET", "add_shipper_new_charge.jsp" + responseString ,true);
					xmlhttp.send();        
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
        function gotItInvMessageShow() {
        	//alert('Test');
	    $('#myModalInv').modal({
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
<!-- Modal -->
<div class="modal fade" id="myModalInv" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <div id="load_fees_div_response" name="load_fees_div_response" >           
           <h1><span id="inv_load_number" name="inv_load_number" ></span></h1>
        </div>       
      </div>
      <div class="modal-body">
        <h3>Payment Details</h3>
  		<div class="row">
		  <input type="hidden" id="invoice_load_id" name="invoice_load_id" value="" />
			<div class="col-md-3" style="padding:5px;">
			    <div class='input-group date' id='datetimepicker100'>
			    <span class="input-group-addon">
			    <span class="glyphicon glyphicon-calendar"></span>
			    </span>
			    <input type='text' style="font-size: 14px; padding-left: 5px; padding-right: 2px;" class="form-control" id="new_invoice_payment_date" name="new_invoice_payment_date"  placeholder="Date">
			    </div>  
			</div>
			<div class="col-md-5" style="padding:5px;">            
				<div class="input-group">
			  <span class="input-group-addon" id="basic-addon1">Name</span>
		  <input type="text" class="form-control"  aria-describedby="basic-addon1"  name="new_invoice_payment_name" id="new_invoice_payment_name" value="" placeholder="Name">
				</div>
        		</div> 
			<div class="col-md-4" style="padding:5px;">  
				<div class="input-group">
  <span class="input-group-addon" id="basic-addon1">Amount</span>
  <input type="text" class="form-control"  aria-describedby="basic-addon1"  name="new_invoice_payment_amount" id="new_invoice_payment_amount" value="" placeholder="">
      	<span class="input-group-addon" id="basic-addon1"><span class="glyphicon glyphicon-plus" aria-hidden="true" onclick="addNewInvoicePayment()" ></span></span>
				</div>
			 </div>
        	</div>   
    
        <span id="inv_load_number_detail" name="inv_load_number_detail" >      
        </span>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
      </div>
    </div>
  </div>
</div>	

			<%@include file="nav_menu.jsp"%>   



	<!-- Main page: -->

	<div class="container-fluid">
	<div class="row">
	<div class="col-md-12">
	<br/><br/><br/><br/><br/>
	</div>
	<div class="container-fluid">
			<div class="row" align="center">
		<%

				int totalCountDelivered = 0;	
				int totalCountCompleted = 0;
				int totalCountInvoiced = 0;
				int totalCountPaid = 0;	
		%>
		<%if(true){%>
		<%
	         try{
				Class.forName("com.mysql.jdbc.Driver");
				String url = "jdbc:mysql://localhost/test?zeroDateTimeBehavior=convertToNull";
				Connection connection = DriverManager.getConnection(url,"<USERNAME>", "<PASSWORD>");						
				PreparedStatement psMain = connection.prepareStatement("select count(load_board_id) as itemCount from test.load_board WHERE load_board.COMPANY_ID = ? and (load_status_manager= 'Open' or load_status_manager is null)");
				psMain.setString(1, uuid);
				ResultSet resultSet = psMain.executeQuery();
				while (resultSet.next()) {
					totalCountDelivered = resultSet.getInt("itemCount");
				}
				psMain = connection.prepareStatement("select count(load_board_id) as itemCount from test.load_board WHERE load_board.COMPANY_ID = ? and load_status_manager= 'Processing'");
				psMain.setString(1, uuid);
				resultSet = psMain.executeQuery();
				while (resultSet.next()) {
					totalCountCompleted = resultSet.getInt("itemCount");
				}
				psMain = connection.prepareStatement("select count(load_board_id) as itemCount from test.load_board WHERE load_board.COMPANY_ID = ? and load_status_manager= 'Closed'");
				psMain.setString(1, uuid);
				resultSet = psMain.executeQuery();
				while (resultSet.next()) {
					totalCountInvoiced = resultSet.getInt("itemCount");
				}
				psMain = connection.prepareStatement("select count(load_board_id) as itemCount from test.load_board WHERE load_board.COMPANY_ID = ? and load_status_manager= 'Archived'");
				psMain.setString(1, uuid);
				resultSet = psMain.executeQuery();
				while (resultSet.next()) {
					totalCountPaid = resultSet.getInt("itemCount");
				}
			
	         }catch (Exception ex){
	             %><%=" " + ex %><%
	         }	
	         }
			%>



			</div>
	</div>

	<div class="col-md-12">
	<div class="table-responsive">
	<table class="table table-hover table-bordered tablesorter" id="boardtable">
	<thead style="font-size:13px;" >
	<tr style="background:#F8F8F8;">
	<th>Load #</th>
	<th>W/O</th>
	<th>Agent</th>
	<th>Customer</th>
	<th>Carrier</th>
	<th>All</th>
	<th>Add</th>
	<th>Detail</th>
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
			HashMap resultSetMapPayments = new HashMap();

			Class.forName("com.mysql.jdbc.Driver");
			String url = "jdbc:mysql://localhost/test?zeroDateTimeBehavior=convertToNull";
			Connection connection = DriverManager.getConnection(url,"<USERNAME>", "<PASSWORD>");			

			PreparedStatement ps = connection.prepareStatement("select * from test.TRUCKING_USERS WHERE COMPANY_ID = ?");
			ps.setString(1, uuid);
			ResultSet resultSet = ps.executeQuery();
			while (resultSet.next()) {
				String[] userItem = new String[6];
				userItem[0] = resultSet.getString("email");
				userItem[1] = resultSet.getString("f_name");
				userItem[2] = resultSet.getString("l_name");
				userItem[3] = resultSet.getString("phone");
				userItem[4] = resultSet.getString("pay_type");
				userItem[5] = resultSet.getString("gross_rate");
				user_map.put(resultSet.getString("email") , userItem);
			}
			
				
				//;

				PreparedStatement psMain = connection.prepareStatement("select load_board.load_board_id, SUM(load_board_finance.fin_amount) as all_total_paid from test.load_board left join test.load_board_finance on load_board.load_board_id = load_board_finance.load_id left join test.locations on load_board.bill_to_id = locations.location_id where load_board.company_id = ? and load_board_finance.fin_type = 'Agent Bonus Payment' group by  load_board.load_board_id order by load_board.ts asc");
				psMain.setString(1, uuid);
				if(request.getParameter("searchType")!=null){
					if(request.getParameter("searchType").equals("wo_number")){
							psMain = connection.prepareStatement("select load_board.load_board_id, SUM(load_board_finance.fin_amount) as all_total_paid from test.load_board left join test.load_board_finance on load_board.load_board_id = load_board_finance.load_id left join test.locations on load_board.bill_to_id = locations.location_id where load_board.company_id = ? and load_board_finance.fin_type = 'Agent Bonus Payment' and load_board.load_wo = ? group by  load_board.load_board_id order by load_board.ts asc");			
							psMain.setString(1, uuid);
							psMain.setString(2, request.getParameter("searchKey"));
						
					}
					if(request.getParameter("searchType").equals("load_number")){
							psMain = connection.prepareStatement("select load_board.load_board_id, SUM(load_board_finance.fin_amount) as all_total_paid from test.load_board left join test.load_board_finance on load_board.load_board_id = load_board_finance.load_id left join test.locations on load_board.bill_to_id = locations.location_id where load_board.company_id = ? and load_board_finance.fin_type = 'Agent Bonus Payment' and load_board.load_number = ? group by  load_board.load_board_id order by load_board.ts asc");			
							psMain.setString(1, uuid);
							psMain.setString(2, request.getParameter("searchKey"));
						
					}
					if(request.getParameter("searchType").equals("LoadStatus")){
							psMain = connection.prepareStatement("select load_board.load_board_id, SUM(load_board_finance.fin_amount) as all_total_paid from test.load_board left join test.load_board_finance on load_board.load_board_id = load_board_finance.load_id left join test.locations on load_board.bill_to_id = locations.location_id where load_board.company_id = ? and load_board_finance.fin_type = 'Agent Bonus Payment' and load_board.load_status = ? group by  load_board.load_board_id order by load_board.ts asc");			
							psMain.setString(1, uuid);
							psMain.setString(2, request.getParameter("searchKey"));
						
					}
					if(request.getParameter("searchType").equals("customer")){
							psMain = connection.prepareStatement("select TRUCKING_EQUIPMENT.name, load_board.load_board_id, SUM(load_board_finance.fin_amount) as all_total_paid from test.load_board left join test.TRUCKING_EQUIPMENT on load_board.load_equipment_id=TRUCKING_EQUIPMENT.id left join test.load_board_finance on load_board.load_board_id = load_board_finance.load_id where load_board.company_id = ? and load_board_finance.fin_type = 'Agent Bonus Payment' and TRUCKING_EQUIPMENT.name like ?  group by  load_board.load_board_id order by load_board.ts asc");			
							psMain.setString(1, uuid);
							psMain.setString(2, "%" + request.getParameter("searchKey") + "%");						
					}
					if(request.getParameter("searchType").equals("mc_number")){
							psMain = connection.prepareStatement("select TRUCKING_EQUIPMENT.mc_no, TRUCKING_EQUIPMENT.name, load_board.load_board_id, SUM(load_board_finance.fin_amount) as all_total_paid from test.load_board left join test.TRUCKING_EQUIPMENT on load_board.load_equipment_id=TRUCKING_EQUIPMENT.id left join test.load_board_finance on load_board.load_board_id = load_board_finance.load_id where load_board.company_id = ? and load_board_finance.fin_type = 'Agent Bonus Payment' and TRUCKING_EQUIPMENT.mc_no like ?  group by  load_board.load_board_id order by load_board.ts asc");			
							psMain.setString(1, uuid);
							psMain.setString(2, request.getParameter("searchKey"));					
					}
				}	
				resultSet = psMain.executeQuery();
				while (resultSet.next()) {
					resultSetMapPayments.put(resultSet.getString("load_board_id"), String.format("%.02f", resultSet.getFloat("all_total_paid")));
				}

				psMain = connection.prepareStatement("select * from test.load_board left join test.locations on load_board.bill_to_id = locations.location_id left join test.TRUCKING_EQUIPMENT on load_board.load_equipment_id=TRUCKING_EQUIPMENT.id where load_board.company_id = ? order by load_board.ts asc");
				psMain.setString(1, uuid);
				if(request.getParameter("searchType")!=null){
					if(request.getParameter("searchType").equals("wo_number")){						
							psMain = connection.prepareStatement("select * from test.load_board left join test.locations on load_board.bill_to_id = locations.location_id left join test.TRUCKING_EQUIPMENT on load_board.load_equipment_id=TRUCKING_EQUIPMENT.id where load_board.company_id = ? and load_board.load_wo = ? group by  load_board.load_board_id order by load_board.ts asc");			
							psMain.setString(1, uuid);
							psMain.setString(2, request.getParameter("searchKey"));						
					}
					if(request.getParameter("searchType").equals("load_number")){						
							psMain = connection.prepareStatement("select * from test.load_board left join test.locations on load_board.bill_to_id = locations.location_id left join test.TRUCKING_EQUIPMENT on load_board.load_equipment_id=TRUCKING_EQUIPMENT.id where load_board.company_id = ? and load_board.load_number = ? group by  load_board.load_board_id order by load_board.ts asc");			
							psMain.setString(1, uuid);
							psMain.setString(2, request.getParameter("searchKey"));						
					}
					if(request.getParameter("searchType").equals("LoadStatus")){						
							psMain = connection.prepareStatement("select * from test.load_board left join test.locations on load_board.bill_to_id = locations.location_id left join test.TRUCKING_EQUIPMENT on load_board.load_equipment_id=TRUCKING_EQUIPMENT.id where load_board.company_id = ? and load_board.load_status = ? group by  load_board.load_board_id order by load_board.ts asc");			
							psMain.setString(1, uuid);
							psMain.setString(2, request.getParameter("searchKey"));						
					}
					if(request.getParameter("searchType").equals("customer")){		
							psMain = connection.prepareStatement("select * from test.load_board left join test.locations on load_board.bill_to_id = locations.location_id left join test.TRUCKING_EQUIPMENT on load_board.load_equipment_id=TRUCKING_EQUIPMENT.id WHERE load_board.COMPANY_ID = ? and TRUCKING_EQUIPMENT.name like ? order by load_board.ts asc");			
							psMain.setString(1, uuid);
							psMain.setString(2, "%" + request.getParameter("searchKey") + "%");					
					}
					if(request.getParameter("searchType").equals("mc_number")){		
							psMain = connection.prepareStatement("select * from test.load_board left join test.locations on load_board.bill_to_id = locations.location_id left join test.TRUCKING_EQUIPMENT on load_board.load_equipment_id=TRUCKING_EQUIPMENT.id WHERE load_board.COMPANY_ID = ? and TRUCKING_EQUIPMENT.mc_no like ? order by load_board.ts asc");			
							psMain.setString(1, uuid);
							psMain.setString(2, request.getParameter("searchKey"));						
					}		
				}
			resultSet = psMain.executeQuery();
			while (resultSet.next()) {
				String pickDate = "";
				String pickTime = "";

				String dropDate = "";
				String dropTime = "";	
				if(!resultSetMap.containsKey(resultSet.getString("load_board_id"))){
					if((resultSet.getString("disdetail")!=null && resultSet.getString("disdetail").contains((String)session.getAttribute("login_id")))
					){
						resultSetVector.add(resultSet.getString("load_board_id"));
					}				
					String[] rowArray = new String[20];
					rowArray[0] = resultSet.getString("load_board_id");
					rowArray[1] = resultSet.getString("load_number");
					rowArray[2] = resultSet.getString("load_wo");
					rowArray[3] = resultSet.getString("salDetail");
					rowArray[4] = resultSet.getString("carrier_rate");
					rowArray[5] = resultSet.getString("load_carrier_fee");
					rowArray[6] = resultSet.getString("disDetail");
					rowArray[8] = pickDate + " " + pickTime;
					rowArray[9] = dropDate + " " + dropTime;
					rowArray[10] = resultSet.getString("TRUCKING_EQUIPMENT.name");
					rowArray[11] = resultSet.getString("locations.org_name");;
					rowArray[13] = resultSet.getString("load_status");	
					rowArray[14] = resultSet.getString("advances_total");
					rowArray[15] = resultSet.getString("load_other");
					rowArray[16] = resultSet.getString("advances_total");	
					float tmpTotalRev = ((resultSet.getFloat("load_rate") * resultSet.getFloat("load_units")) + resultSet.getFloat("load_other"));	
					
					float tmpPaid = 0.0f;
					float tmpTotal = resultSet.getFloat("carrier_rate") + resultSet.getFloat("load_carrier_fee");	
					float tmpGross = tmpTotalRev - tmpTotal;
					rowArray[7] = String.format("%.02f", tmpGross);
					rowArray[12] = String.format("%.02f", tmpTotalRev);
					rowArray[17] = String.format("%.02f", tmpTotal);
					rowArray[18] = resultSet.getString("load_units");
					if(resultSetMapPayments.containsKey(resultSet.getString("load_board_id"))){
						rowArray[19] = (String)resultSetMapPayments.get(resultSet.getString("load_board_id"));	
					}else{
						rowArray[19] = "0.00";	
					}
					resultSetMap.put(rowArray[0] , rowArray);
				}
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
			<%if(NullCheck.check(((String[])resultSetMap.get((String)resultSetVector.get(l)))[13]).equals("Complete")){%>
				<% colorTmp = "gray"; %>
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
	<%if(((String[])resultSetMap.get((String)resultSetVector.get(l)))[6]!=null && !((String[])resultSetMap.get((String)resultSetVector.get(l)))[6].equals("")){%>
	<%for(int jk =0;jk<((String[])resultSetMap.get((String)resultSetVector.get(l)))[6].split(":").length;jk++){%>
		<p><%if(user_map.containsKey((((String[])resultSetMap.get((String)resultSetVector.get(l)))[6].split(":")[jk]))){%>
		<%=NullCheck.check(((String[])user_map.get((((String[])resultSetMap.get((String)resultSetVector.get(l)))[6].split(":")[jk])))[1])%>
		<%=NullCheck.check(((String[])user_map.get((((String[])resultSetMap.get((String)resultSetVector.get(l)))[6].split(":")[jk])))[2])%><BR>
		<%=NullCheck.check(((String[])user_map.get((((String[])resultSetMap.get((String)resultSetVector.get(l)))[6].split(":")[jk])))[0])%>
		<%}%></p>				
	<%}%>				
	<%}%>				
			</td>				
			
			<td style="padding:5px;"><%=NullCheck.check(((String[])resultSetMap.get((String)resultSetVector.get(l)))[12])%></td>
			<td style="padding:5px;"><%=NullCheck.check(((String[])resultSetMap.get((String)resultSetVector.get(l)))[17])%></td>
			<td style="padding:5px;width:100px;"><div class="form-group" ><input type="text" class="form-control"  name="IPT<%=NullCheck.check(((String[])resultSetMap.get((String)resultSetVector.get(l)))[0])%>" id="IPT<%=NullCheck.check(((String[])resultSetMap.get((String)resultSetVector.get(l)))[0])%>" value="<%=NullCheck.check(((String[])resultSetMap.get((String)resultSetVector.get(l)))[19])%>" onchange="calculateRate()" placeholder="0.00" readonly /></div></td>
			<td style="padding:5px;width:100px;"><div class="form-group" ><input type="text" class="form-control"  name="IPTAM<%=NullCheck.check(((String[])resultSetMap.get((String)resultSetVector.get(l)))[0])%>" id="IPTAM<%=NullCheck.check(((String[])resultSetMap.get((String)resultSetVector.get(l)))[0])%>" value="" onblur="addNewInvoicePaymentQuick('<%=NullCheck.check(((String[])resultSetMap.get((String)resultSetVector.get(l)))[0])%>')" placeholder="1200.00"/></div></td>
			<input type="hidden" name="IPTAMT<%=NullCheck.check(((String[])resultSetMap.get((String)resultSetVector.get(l)))[0])%>" id="IPTAMT<%=NullCheck.check(((String[])resultSetMap.get((String)resultSetVector.get(l)))[0])%>" value="<%=NullCheck.check(((String[])resultSetMap.get((String)resultSetVector.get(l)))[17])%>" />
			<td  style="padding:5px;width:100px;"><span onclick="showInvoicePayments('<%=((String[])resultSetMap.get((String)resultSetVector.get(l)))[0]%>', '<%=((String[])resultSetMap.get((String)resultSetVector.get(l)))[1]%>','Invoice Payments')" class="input-group-addon" id="basic-addon1"><span class="glyphicon glyphicon-list" aria-hidden="true"></span></span></td>
						
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
	        	