<%@ page import="java.security.SecureRandom,com.big.util.*,java.text.*,java.util.*,java.io.*,javax.xml.parsers.*,org.w3c.dom.*,java.sql.*,java.text.DateFormat" %>
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

	<link rel="stylesheet" href="css/navstyle2.css" />
      
    <script src="https://maps.googleapis.com/maps/api/js?v=3.exp&signed_in=true&libraries=places&?key=AIzaSyBpeQ3zGuTunYzxmiNMUltHL352e4beac4"></script>


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


    <!-- datepicker related -->

	<link rel="stylesheet" href="//ajax.googleapis.com/ajax/libs/jqueryui/1.10.4/themes/smoothness/jquery-ui.css" />
	<script src="//ajax.googleapis.com/ajax/libs/jqueryui/1.10.4/jquery-ui.min.js"></script>


	<!-- css styles -->
	<link rel="stylesheet" type="text/css" href="css/newstyle2.css">
	<!-- ./css styles -->

		<%if(session.getAttribute("issubscribed")!=null && session.getAttribute("issubscribed").equals("true")){%>
		<%
			String uuid = (String)session.getAttribute("uuid");

			if(uuid !=null){
%>



	<script type="text/javascript">
		var itemListLabel ;
		var itemListMain ;	
	function addBillToInfo(){  
        		document.getElementById("bill_to_info").style.display = "inline";   
        		document.getElementById("load_info").style.display = "none";    
	}	
	function addBillToCancel(){
        		document.getElementById("load_info").style.display = "inline";    
        		document.getElementById("bill_to_info").style.display = "none"; 
	}	
	function addShipperInfo(){
        		document.getElementById("ship_panel").style.display = "none";    
        		document.getElementById("ship_panel_add").style.display = "inline"; 
        		document.getElementById("location_type").value = "Shipping";         			
	}
	function addCustomsInfo(){
        		document.getElementById("ship_panel").style.display = "none";    
        		document.getElementById("ship_panel_add").style.display = "inline"; 
        		document.getElementById("location_type").value = "Customs";         			
	}
	function addConsigneeInfo(){
        		document.getElementById("consignee_panel").style.display = "none";    
        		document.getElementById("consignee_panel_add").style.display = "inline"; 		
	}	
	function addConsigneeInfoCancel(){
        		document.getElementById("consignee_panel").style.display = "inline";    
        		document.getElementById("consignee_panel_add").style.display = "none"; 		
	}
	function addShipperInfoCancel(){
        		document.getElementById("ship_panel").style.display = "inline";    
        		document.getElementById("ship_panel_add").style.display = "none"; 
	
	}	
        
        function showLoadInfo(){
        		document.getElementById("sales_info").style.display = "none";    
        		document.getElementById("load_info").style.display = "inline"; 
        		document.getElementById("dispatcher_info").style.display = "none";    
        		
        }
        function showSalesInfo(){
        		document.getElementById("sales_info").style.display = "inline";    
        		document.getElementById("load_info").style.display = "none";   
        		document.getElementById("bill_to_info").style.display = "none";   
        		document.getElementById("dispatcher_info").style.display = "none";  
        }  
        function showDispatcherInfo(){
        		document.getElementById("sales_info").style.display = "none";    
        		document.getElementById("load_info").style.display = "none";    
        		document.getElementById("bill_to_info").style.display = "none";  
        		document.getElementById("dispatcher_info").style.display = "inline";   
        } 
        	
        function removeShipper(){
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
			document.getElementById("shipper_nav").innerHTML = addressList[0];
			document.getElementById("ship_22").value = addressList[11];
			document.getElementById("ship_22_address").value = addressList[12];
			document.getElementById("current_ship_22_id").value = addressList[10];			
			document.getElementById("customs_broker").value = addressList[14];
			document.getElementById("current_customs_broker_id").value = addressList[13];
			document.getElementById("pickup_date").value = addressList[8];
			document.getElementById("pickup_time").value = addressList[9];
			document.getElementById("ship_description").value = addressList[2];
			document.getElementById("ship_type").value = addressList[3];
			document.getElementById("ship_units").value = addressList[4];
			document.getElementById("ship_weight").value = addressList[5];
			document.getElementById("ship_note").value = addressList[6];
			document.getElementById("ship_po").value = addressList[7];
			document.getElementById("btn_shipper_save").className = 'btn btn-success';  
		}
		}
		var responseString = "?shipper_count=" + encodeURIComponent(document.getElementById("shipper_count").value);
		responseString = responseString + "&load_id=" + document.getElementById("load_id").value;
		responseString = responseString + "&current_line_id_remove=" + document.getElementById("current_line_id").value;
		xmlhttp.open("GET", "new_load_add_shipper.jsp" + responseString,true);
		xmlhttp.send();
        	document.getElementById("btn_shipper_save").className = 'btn btn-warning';   
            }
            function removeConsignee(){
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
			var addressList = xmlhttp.responseText.split("<ITEM>");
			document.getElementById("consignee_nav").innerHTML = addressList[0];
			document.getElementById("consignee_22").value = addressList[11];
			document.getElementById("consignee_22_address").value = addressList[12];
			document.getElementById("current_consignee_22_id").value = addressList[10];		
			document.getElementById("consigneepickup_date").value = addressList[8];
			document.getElementById("consigneepickup_time").value = addressList[9];
			document.getElementById("consignee_description").value = addressList[2];
			document.getElementById("consignee_type").value = addressList[3];
			document.getElementById("consignee_units").value = addressList[4];
			document.getElementById("consignee_weight").value = addressList[5];
			document.getElementById("consignee_note").value = addressList[6];
			document.getElementById("consignee_po").value = addressList[7];
			document.getElementById("btn_shipper_save").className = 'btn btn-success';  
		}
		}
		var responseString = "?consignee_count=" + encodeURIComponent(document.getElementById("consignee_count").value);		
		responseString = responseString + "&load_id=" + document.getElementById("load_id").value;
		responseString = responseString + "&current_line_id_remove=" + document.getElementById("current_consignee_line_id").value;

		xmlhttp.open("GET", "new_load_add_consignee.jsp" + responseString,true);
		xmlhttp.send();
        	document.getElementById("btn_shipper_save").className = 'btn btn-warning';   
            }
            function getLocationByName(searchKey, fillTextBoxName){
		    	for(var j =0;j<itemListMain.length;j++){
		    		var itemListSet = itemListMain[j].split("<ITEM>");
		    		var itemString = itemListSet[2] + " " +itemListSet[4];
		    		var itemNameString = fillTextBoxName + "_address";
		    		var itemIDString = "current_" + fillTextBoxName + "_id";
				if(searchKey == itemString){
					document.getElementById(fillTextBoxName).value = itemListSet[2];
					document.getElementById(itemNameString).value = itemListSet[4];
					document.getElementById(itemIDString).value = itemListSet[3];
					itemListLabel = null;
					itemListMain = null;
					return;
				}
		    	}      
		    	if(itemListMain.length>0){
		    		var itemListSet = itemListMain[0].split("<ITEM>");
				document.getElementById(fillTextBoxName).value = itemListSet[2];
				document.getElementById(itemNameString).value = itemListSet[4];
				document.getElementById(itemIDString).value = itemListSet[3];
		    	
		    	}
            }
            
            function searchLocationByName(searchKey, fillTextBoxName, location_type){
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
		    	itemListLabel = xmlhttp.responseText.split('<ROW>');
		    	itemListMain = xmlhttp.responseText.split('<ROW>');
		    	for(var j =0;j<itemListMain.length;j++){
		    		var itemListSet = itemListMain[j].split("<ITEM>");
		    		itemListLabel[j] = itemListSet[2] + " " +itemListSet[4];
		    	}
		    	fillTextBoxName = "#" + fillTextBoxName;
			$(fillTextBoxName).autocomplete({ source: itemListLabel });  						
			//alert(xmlhttp.responseText);
		    }
		  }
		var responseString = "?search_key=" + encodeURIComponent(searchKey);
		responseString = responseString + "&location_type=" + location_type;

		//if(searchKey.length>1){
			xmlhttp.open("GET", "search_location.jsp" + responseString ,true);
			xmlhttp.send();
		//}
            }     
            
        function saveNewBillTo(){
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
			//document.getElementById("shipper_nav").innerHTML = xmlhttp.responseText;
			var addressList = xmlhttp.responseText.split("<ITEM>");
			if(addressList.length>1){
				document.getElementById("current_bill_22_id").value = addressList[2];
				document.getElementById("bill_22").value = addressList[3];
				document.getElementById("bill_22_address").value = addressList[4];
				
				document.getElementById("bill_name_add").value = "";
				document.getElementById("bill_phone_add").value = "";
				document.getElementById("bill_email_add").value = "";
				document.getElementById("bill_contact_name_add").value = "";
				document.getElementById("bill_contact_phone_add").value = "";
				document.getElementById("bill_contact_email_add").value = "";
				document.getElementById("bill_pickCity_lat").value = "";
				document.getElementById("bill_pickCity_lng").value = "";
				document.getElementById("bill_pac-input").value = "";
				document.getElementById("bill_pickup_address_add_lat").value = "";
				document.getElementById("bill_pickup_address_add_lng").value = "";
				document.getElementById("bill_pickup_address_add").value = "";
				document.getElementById("bill_address2_add").value = "";
				document.getElementById("bill_notes_add").value = "";
        			addBillToCancel();
			}else{
				alert("Error Trying Save Info");
			}
		}
		}
		
		var responseString = "?shipper_count=" + encodeURIComponent(document.getElementById("shipper_count").value);
		responseString = responseString + "&load_id=" + document.getElementById("load_id").value;
		responseString = responseString + "&ship_name_add=" + document.getElementById("bill_name_add").value;
		responseString = responseString + "&ship_phone_add=" + document.getElementById("bill_phone_add").value;
		responseString = responseString + "&ship_email_add=" + document.getElementById("bill_email_add").value;
		responseString = responseString + "&ship_contact_name_add=" + document.getElementById("bill_contact_name_add").value;
		responseString = responseString + "&ship_contact_phone_add=" + document.getElementById("bill_contact_phone_add").value;
		responseString = responseString + "&ship_contact_email_add=" + document.getElementById("bill_contact_email_add").value;
		responseString = responseString + "&pickCity_lat=" + document.getElementById("bill_pickCity_lat").value;
		responseString = responseString + "&pickCity_lng=" + document.getElementById("bill_pickCity_lng").value;
		responseString = responseString + "&pickState=" + document.getElementById("bill_pickState").value;
		responseString = responseString + "&pickCity=" + document.getElementById("bill_pac-input").value;
		responseString = responseString + "&pickup_address_add_lat=" + document.getElementById("bill_pickup_address_add_lat").value;
		responseString = responseString + "&pickup_address_add_lng=" + document.getElementById("bill_pickup_address_add_lng").value;
		responseString = responseString + "&pickup_address_add=" + document.getElementById("bill_pickup_address_add").value;
		responseString = responseString + "&ship_address2_add=" + document.getElementById("bill_address2_add").value;
		responseString = responseString + "&ship_notes_add=" + document.getElementById("bill_notes_add").value;
		responseString = responseString + "&location_type=Billing";
		xmlhttp.open("GET", "add_shipper_new_shipper.jsp" + responseString,true);
		xmlhttp.send();  
        }
        function saveNewShipper(){
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
			//document.getElementById("shipper_nav").innerHTML = xmlhttp.responseText;
			var addressList = xmlhttp.responseText.split("<ITEM>");
			if(addressList.length>1){
				if(document.getElementById("location_type").value == "Shipping"){
					document.getElementById("current_ship_22_id").value = addressList[2];
					document.getElementById("ship_22").value = addressList[3];
					document.getElementById("ship_22_address").value = addressList[4];
				}else{
					document.getElementById("customs_broker").value = addressList[3];
					document.getElementById("current_customs_broker_id").value = addressList[2];				
				}
				
				document.getElementById("ship_name_add").value = "";
				document.getElementById("ship_phone_add").value = "";
				document.getElementById("ship_email_add").value = "";
				document.getElementById("ship_contact_name_add").value = "";
				document.getElementById("ship_contact_phone_add").value = "";
				document.getElementById("ship_contact_email_add").value = "";
				document.getElementById("pickCity_lat").value = "";
				document.getElementById("pickCity_lng").value = "";
				document.getElementById("pac-input").value = "";
				document.getElementById("pickup_address_add_lat").value = "";
				document.getElementById("pickup_address_add_lng").value = "";
				document.getElementById("pickup_address_add").value = "";
				document.getElementById("ship_address2_add").value = "";
				document.getElementById("ship_notes_add").value = "";
        			addShipperInfoCancel();
			}else{
				alert("Error Trying Save Info");
			}
		}
		}
		
		var responseString = "?shipper_count=" + encodeURIComponent(document.getElementById("shipper_count").value);
		responseString = responseString + "&load_id=" + document.getElementById("load_id").value;
		responseString = responseString + "&ship_name_add=" + document.getElementById("ship_name_add").value;
		responseString = responseString + "&ship_phone_add=" + document.getElementById("ship_phone_add").value;
		responseString = responseString + "&ship_email_add=" + document.getElementById("ship_email_add").value;
		responseString = responseString + "&ship_contact_name_add=" + document.getElementById("ship_contact_name_add").value;
		responseString = responseString + "&ship_contact_phone_add=" + document.getElementById("ship_contact_phone_add").value;
		responseString = responseString + "&ship_contact_email_add=" + document.getElementById("ship_contact_email_add").value;
		responseString = responseString + "&pickCity_lat=" + document.getElementById("pickCity_lat").value;
		responseString = responseString + "&pickCity_lng=" + document.getElementById("pickCity_lng").value;
		responseString = responseString + "&pickState=" + document.getElementById("pickState").value;
		responseString = responseString + "&pickCity=" + document.getElementById("pac-input").value;
		responseString = responseString + "&pickup_address_add_lat=" + document.getElementById("pickup_address_add_lat").value;
		responseString = responseString + "&pickup_address_add_lng=" + document.getElementById("pickup_address_add_lng").value;
		responseString = responseString + "&pickup_address_add=" + document.getElementById("pickup_address_add").value;
		responseString = responseString + "&ship_address2_add=" + document.getElementById("ship_address2_add").value;
		responseString = responseString + "&ship_notes_add=" + document.getElementById("ship_notes_add").value;
		responseString = responseString + "&location_type=" + document.getElementById("location_type").value;
		xmlhttp.open("GET", "add_shipper_new_shipper.jsp" + responseString,true);
		xmlhttp.send();     
        }
        function saveNewConsignee(){
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
			//document.getElementById("shipper_nav").innerHTML = xmlhttp.responseText;
			var addressList = xmlhttp.responseText.split("<ITEM>");
			if(addressList.length>1){
					document.getElementById("current_consignee_22_id").value = addressList[2];
					document.getElementById("consignee_22").value = addressList[3];
					document.getElementById("consignee_22_address").value = addressList[4];
				
				document.getElementById("consignee_name_add").value = "";
				document.getElementById("consignee_phone_add").value = "";
				document.getElementById("consignee_email_add").value = "";
				document.getElementById("consignee_contact_name_add").value = "";
				document.getElementById("consignee_contact_phone_add").value = "";
				document.getElementById("consignee_contact_email_add").value = "";
				document.getElementById("consigneepickCity_lat").value = "";
				document.getElementById("consigneepickCity_lng").value = "";
				document.getElementById("pac-input6").value = "";
				document.getElementById("consigneepickup_address_add_lat").value = "";
				document.getElementById("consigneepickup_address_add_lng").value = "";
				document.getElementById("consigneepickup_address_add").value = "";
				document.getElementById("consignee_address2_add").value = "";
				document.getElementById("consignee_notes_add").value = "";
        			addConsigneeInfoCancel();
			}else{
				alert("Error Trying Save Info");
			}
		}
		}
		
		var responseString = "?consignee_count=" + encodeURIComponent(document.getElementById("consignee_count").value);
		responseString = responseString + "&load_id=" + document.getElementById("load_id").value;
		responseString = responseString + "&ship_name_add=" + document.getElementById("consignee_name_add").value;
		responseString = responseString + "&ship_phone_add=" + document.getElementById("consignee_phone_add").value;
		responseString = responseString + "&ship_email_add=" + document.getElementById("consignee_email_add").value;
		responseString = responseString + "&ship_contact_name_add=" + document.getElementById("consignee_contact_name_add").value;
		responseString = responseString + "&ship_contact_phone_add=" + document.getElementById("consignee_contact_phone_add").value;
		responseString = responseString + "&ship_contact_email_add=" + document.getElementById("consignee_contact_email_add").value;
		responseString = responseString + "&pickCity_lat=" + document.getElementById("consigneepickCity_lat").value;
		responseString = responseString + "&pickCity_lng=" + document.getElementById("consigneepickCity_lng").value;
		responseString = responseString + "&pickState=" + document.getElementById("consigneepickState").value;
		responseString = responseString + "&pickCity=" + document.getElementById("pac-input6").value;
		responseString = responseString + "&pickup_address_add_lat=" + document.getElementById("consigneepickup_address_add_lat").value;
		responseString = responseString + "&pickup_address_add_lng=" + document.getElementById("consigneepickup_address_add_lng").value;
		responseString = responseString + "&pickup_address_add=" + document.getElementById("consigneepickup_address_add").value;
		responseString = responseString + "&ship_address2_add=" + document.getElementById("consignee_address2_add").value;
		responseString = responseString + "&ship_notes_add=" + document.getElementById("consignee_notes_add").value;
		responseString = responseString + "&location_type=Consignee";
		xmlhttp.open("GET", "add_shipper_new_shipper.jsp" + responseString,true);
		xmlhttp.send();     
        }        
        function autoSaveItem(){	
        
        	saveLoadDetailFun();
        }
        function saveLoadDetailFun(){
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
			//alert(xmlhttp.responseText);
			//document.getElementById("shipper_nav").innerHTML = addressList[0];
			document.getElementById("btn_shipper_save").className = 'btn btn-success'; 
			var itemListTmp = xmlhttp.responseText.split("<ITEM>");
			//if(itemList.length>2){
				document.getElementById("load_number").style.color = "green";
				document.getElementById("load_number").style.fontWeight = "bold";
				document.getElementById("load_number").value = xmlhttp.responseText.split("<ITEM>")[3];
				document.getElementById("printPDFEmailButton").style.display = "inline";
				document.getElementById("printPDFSMSButton").style.display = "inline";
				document.getElementById("printPDFButton").style.display = "inline";
				
			//}
			
			if(document.getElementById("current_line_id")){
				viewShipper(document.getElementById("current_line_id").value);
			}else{
				saveShipperLineDetail();
			}
			if(document.getElementById("current_consignee_line_id")){
				viewConsignee(document.getElementById("current_consignee_line_id").value);
			}else{
				saveConsigneeLineDetail();
			}
			calculateRate();
        	
		}
		}
		
		var responseString = "?load_id=" + encodeURIComponent(document.getElementById("load_id").value);
		responseString = responseString + "&current_bill_22_id=" + encodeURIComponent(document.getElementById("current_bill_22_id").value);	
		responseString = responseString + "&current_carrier_22_id=" + encodeURIComponent(document.getElementById("current_carrier_22_id").value);			
		responseString = responseString + "&load_number=" + encodeURIComponent(document.getElementById("load_number").value);
		responseString = responseString + "&load_wo=" + encodeURIComponent(document.getElementById("load_wo").value);
		responseString = responseString + "&load_rate=" + encodeURIComponent(document.getElementById("load_rate").value);
		responseString = responseString + "&load_units=" + encodeURIComponent(document.getElementById("load_units").value);
		responseString = responseString + "&load_pd=" + encodeURIComponent(document.getElementById("load_pd").value);
		responseString = responseString + "&load_fsc=" + encodeURIComponent(document.getElementById("load_fsc").value);
		responseString = responseString + "&load_carrier_fee=" + encodeURIComponent(document.getElementById("load_carrier_fee").value);
		responseString = responseString + "&carrier_rate=" + encodeURIComponent(document.getElementById("carrier_rate").value);		
		responseString = responseString + "&load_other_charge=" + encodeURIComponent(document.getElementById("load_other_charge").value);		
		responseString = responseString + "&load_rate_all=" + encodeURIComponent(document.getElementById("load_rate_all").value);
		responseString = responseString + "&load_status=" + encodeURIComponent(document.getElementById("load_status").value);	
		responseString = responseString + "&load_type=" + encodeURIComponent(document.getElementById("load_type").value);	
		responseString = responseString + "&load_carrier_advance=" + encodeURIComponent(document.getElementById("load_carrier_advance").value);	
		responseString = responseString + "&bill_to_advances=" + encodeURIComponent(document.getElementById("bill_to_advances").value);	
		responseString = responseString + "&load_equipment_type=" + encodeURIComponent(document.getElementById("load_equipment_type").value);	
		responseString = responseString + "&managerID=" + encodeURIComponent(document.getElementById("managerID").value);	
		
		var disCount = parseInt(document.getElementById("disCount").value);
		var disString = "" 
		for(var j=0;j<disCount;j++){
			var disId = "DISID" + j;
			var disIdV = "DISIDV" + j;
			if(document.getElementById(disId).checked){
				disString = disString + document.getElementById(disIdV).value + ":";
			}
		}
		var salesCount = parseInt(document.getElementById("salesCount").value);
		var salString = "" 
		for(var K=0;K<salesCount;K++){
			var disId = "SALID" + K;
			var disIdV = "SALIDV" + K;
			if(document.getElementById(disId).checked){
				salString = salString + document.getElementById(disIdV).value + ":";
			}
		}		
		responseString = responseString + "&salString=" + salString;	
		responseString = responseString + "&disString=" + disString;	
		xmlhttp.open("GET", "add_shipper_new_load_detail.jsp" + responseString,true);
		xmlhttp.send();
		document.getElementById("btn_shipper_save").className = 'btn btn-warning';   
        	
        }
        function saveShipperLineDetail(){
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
			document.getElementById("shipper_nav").innerHTML = addressList[0];
			document.getElementById("btn_shipper_save").className = 'btn btn-success';   
		}
		}
		
		var responseString = "?shipper_count=" + encodeURIComponent(document.getElementById("shipper_count").value);
		responseString = responseString + "&load_id=" + document.getElementById("load_id").value;
		if(document.getElementById("ship_line_id")){
			responseString = responseString + "&ship_line_id=" + document.getElementById("ship_line_id").value;
		}else{
			responseString = responseString + "&ship_line_id_new=True";		
		}
		if(document.getElementById("current_line_id")){
			responseString = responseString + "&current_line_id=" + document.getElementById("current_line_id").value;		
		}
		responseString = responseString + "&ship_name=" + document.getElementById("ship_22").value;
		responseString = responseString + "&current_ship_22_id=" + document.getElementById("current_ship_22_id").value;		
		responseString = responseString + "&ship_location_name=" + document.getElementById("ship_22_address").value;
		responseString = responseString + "&pickup_date=" + document.getElementById("pickup_date").value;
		responseString = responseString + "&pickup_time=" + document.getElementById("pickup_time").value;
		responseString = responseString + "&ship_description=" + document.getElementById("ship_description").value;
		responseString = responseString + "&ship_type=" + document.getElementById("ship_type").value;
		responseString = responseString + "&ship_units=" + document.getElementById("ship_units").value;
		responseString = responseString + "&ship_weight=" + document.getElementById("ship_weight").value;
		responseString = responseString + "&ship_note=" + document.getElementById("ship_note").value;
		responseString = responseString + "&ship_po=" + document.getElementById("ship_po").value;
		responseString = responseString + "&customs_broker=" + document.getElementById("customs_broker").value;
		responseString = responseString + "&current_customs_broker_id=" + document.getElementById("current_customs_broker_id").value;
		
		xmlhttp.open("GET", "new_load_add_shipper.jsp" + responseString,true);
		xmlhttp.send();
		document.getElementById("btn_shipper_save").className = 'btn btn-warning';   
        
        }
        function viewShipper(ship_line_id){
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
			var addressList = xmlhttp.responseText.split("<ITEM>");
			document.getElementById("shipper_nav").innerHTML = addressList[0];
			document.getElementById("ship_22").value = addressList[11];
			document.getElementById("ship_22_address").value = addressList[12];
			document.getElementById("current_ship_22_id").value = addressList[10];			
			document.getElementById("customs_broker").value = addressList[14];
			document.getElementById("current_customs_broker_id").value = addressList[13];
			document.getElementById("pickup_date").value = addressList[8];
			document.getElementById("pickup_time").value = addressList[9];
			document.getElementById("ship_description").value = addressList[2];
			document.getElementById("ship_type").value = addressList[3];
			document.getElementById("ship_units").value = addressList[4];
			document.getElementById("ship_weight").value = addressList[5];
			document.getElementById("ship_note").value = addressList[6];
			document.getElementById("ship_po").value = addressList[7];
			document.getElementById("btn_shipper_save").className = 'btn btn-success';  
		}
		}
		var responseString = "?shipper_count=" + encodeURIComponent(document.getElementById("shipper_count").value);
		responseString = responseString + "&load_id=" + document.getElementById("load_id").value;
		responseString = responseString + "&ship_line_id=" + ship_line_id;
		
		responseString = responseString + "&ship_name=" + document.getElementById("ship_22").value;
		responseString = responseString + "&current_ship_22_id=" + document.getElementById("current_ship_22_id").value;		
		responseString = responseString + "&ship_location_name=" + document.getElementById("ship_22_address").value;
		responseString = responseString + "&pickup_date=" + document.getElementById("pickup_date").value;
		responseString = responseString + "&pickup_time=" + document.getElementById("pickup_time").value;
		responseString = responseString + "&ship_description=" + document.getElementById("ship_description").value;
		responseString = responseString + "&ship_type=" + document.getElementById("ship_type").value;
		responseString = responseString + "&ship_units=" + document.getElementById("ship_units").value;
		responseString = responseString + "&ship_weight=" + document.getElementById("ship_weight").value;
		responseString = responseString + "&ship_note=" + document.getElementById("ship_note").value;
		responseString = responseString + "&ship_po=" + document.getElementById("ship_po").value;
		responseString = responseString + "&customs_broker=" + document.getElementById("customs_broker").value;
		responseString = responseString + "&current_customs_broker_id=" + document.getElementById("current_customs_broker_id").value;

		responseString = responseString + "&current_line_id=" + document.getElementById("current_line_id").value;
		xmlhttp.open("GET", "new_load_add_shipper.jsp" + responseString,true);
		xmlhttp.send();
        	document.getElementById("btn_shipper_save").className = 'btn btn-warning';   
		
        }
        function addShipper(){
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
			var addressList = xmlhttp.responseText.split("<ITEM>");
			document.getElementById("shipper_nav").innerHTML = addressList[0];
			document.getElementById("ship_22").value = "";
			document.getElementById("current_ship_22_id").value = "";
			document.getElementById("ship_22_address").value = "";
			document.getElementById("pickup_date").value = "";
			document.getElementById("pickup_time").value = "";
			document.getElementById("ship_description").value = "";
			document.getElementById("ship_type").value = "";
			document.getElementById("ship_units").value = "";
			document.getElementById("ship_weight").value = "";
			document.getElementById("ship_note").value = "";
			document.getElementById("ship_po").value = "";
			document.getElementById("customs_broker").value = "";
			document.getElementById("current_customs_broker_id").value = "";
			document.getElementById("customs_broker_address").value = "";
			
			document.getElementById("btn_shipper_save").className = 'btn btn-success'; 
		}
		}
		
		var responseString = "?shipper_count=" + encodeURIComponent(document.getElementById("shipper_count").value);
		responseString = responseString + "&load_id=" + document.getElementById("load_id").value;
		responseString = responseString + "&ship_name=" + document.getElementById("ship_22").value;
		responseString = responseString + "&current_ship_22_id=" + document.getElementById("current_ship_22_id").value;	
		responseString = responseString + "&ship_location_name=" + document.getElementById("ship_22_address").value;
		responseString = responseString + "&pickup_date=" + document.getElementById("pickup_date").value;
		responseString = responseString + "&pickup_time=" + document.getElementById("pickup_time").value;
		responseString = responseString + "&ship_description=" + document.getElementById("ship_description").value;
		responseString = responseString + "&ship_type=" + document.getElementById("ship_type").value;
		responseString = responseString + "&ship_units=" + document.getElementById("ship_units").value;
		responseString = responseString + "&ship_weight=" + document.getElementById("ship_weight").value;
		responseString = responseString + "&ship_note=" + document.getElementById("ship_note").value;
		responseString = responseString + "&ship_po=" + document.getElementById("ship_po").value;
		responseString = responseString + "&customs_broker=" + document.getElementById("customs_broker").value;
		responseString = responseString + "&current_customs_broker_id=" + document.getElementById("current_customs_broker_id").value;
		
		if(document.getElementById("current_line_id")){
			responseString = responseString + "&current_line_id=" + document.getElementById("current_line_id").value;		
		}
		
		
		//responseString = responseString + "&email=" + encodeURIComponent(document.getElementById("email").value);
		xmlhttp.open("GET", "new_load_add_shipper.jsp" + responseString,true);
		xmlhttp.send();
        	document.getElementById("btn_shipper_save").className = 'btn btn-warning'; 
        }    
        function saveConsigneeLineDetail(){
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
			document.getElementById("consignee_nav").innerHTML = addressList[0];
			document.getElementById("btn_shipper_save").className = 'btn btn-success';   
		}
		}
		
		var responseString = "?consignee_count=" + encodeURIComponent(document.getElementById("consignee_count").value);
		responseString = responseString + "&load_id=" + document.getElementById("load_id").value;
		if(document.getElementById("consignee_line_id")){
			responseString = responseString + "&consignee_line_id=" + document.getElementById("consignee_line_id").value;
		}else{
			responseString = responseString + "&consignee_line_id_new=True";		
		}
		if(document.getElementById("current_consignee_line_id")){
			responseString = responseString + "&current_consignee_line_id=" + document.getElementById("current_consignee_line_id").value;		
		}
		responseString = responseString + "&ship_name=" + document.getElementById("consignee_22").value;
		responseString = responseString + "&current_consignee_22_id=" + document.getElementById("current_consignee_22_id").value;		
		responseString = responseString + "&ship_location_name=" + document.getElementById("consignee_22_address").value;
		responseString = responseString + "&pickup_date=" + document.getElementById("consigneepickup_date").value;
		responseString = responseString + "&pickup_time=" + document.getElementById("consigneepickup_time").value;
		responseString = responseString + "&ship_description=" + document.getElementById("consignee_description").value;
		responseString = responseString + "&ship_type=" + document.getElementById("consignee_type").value;
		responseString = responseString + "&ship_units=" + document.getElementById("consignee_units").value;
		responseString = responseString + "&ship_weight=" + document.getElementById("consignee_weight").value;
		responseString = responseString + "&ship_note=" + document.getElementById("consignee_note").value;
		responseString = responseString + "&ship_po=" + document.getElementById("consignee_po").value;
		
		xmlhttp.open("GET", "new_load_add_consignee.jsp" + responseString,true);
		xmlhttp.send();
		document.getElementById("btn_shipper_save").className = 'btn btn-warning';   
        
        }
        function viewConsignee(ship_line_id){
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
			var addressList = xmlhttp.responseText.split("<ITEM>");
			document.getElementById("consignee_nav").innerHTML = addressList[0];
			document.getElementById("consignee_22").value = addressList[11];
			document.getElementById("consignee_22_address").value = addressList[12];
			document.getElementById("current_consignee_22_id").value = addressList[10];		
			document.getElementById("consigneepickup_date").value = addressList[8];
			document.getElementById("consigneepickup_time").value = addressList[9];
			document.getElementById("consignee_description").value = addressList[2];
			document.getElementById("consignee_type").value = addressList[3];
			document.getElementById("consignee_units").value = addressList[4];
			document.getElementById("consignee_weight").value = addressList[5];
			document.getElementById("consignee_note").value = addressList[6];
			document.getElementById("consignee_po").value = addressList[7];
			document.getElementById("btn_shipper_save").className = 'btn btn-success';  
		}
		}
		var responseString = "?consignee_count=" + encodeURIComponent(document.getElementById("consignee_count").value);
		responseString = responseString + "&load_id=" + document.getElementById("load_id").value;
		responseString = responseString + "&consignee_line_id=" + ship_line_id;
		
		responseString = responseString + "&ship_name=" + document.getElementById("consignee_22").value;
		responseString = responseString + "&current_consignee_22_id=" + document.getElementById("current_consignee_22_id").value;		
		responseString = responseString + "&ship_location_name=" + document.getElementById("consignee_22_address").value;
		responseString = responseString + "&pickup_date=" + document.getElementById("consigneepickup_date").value;
		responseString = responseString + "&pickup_time=" + document.getElementById("consigneepickup_time").value;
		responseString = responseString + "&ship_description=" + document.getElementById("consignee_description").value;
		responseString = responseString + "&ship_type=" + document.getElementById("consignee_type").value;
		responseString = responseString + "&ship_units=" + document.getElementById("consignee_units").value;
		responseString = responseString + "&ship_weight=" + document.getElementById("consignee_weight").value;
		responseString = responseString + "&ship_note=" + document.getElementById("consignee_note").value;
		responseString = responseString + "&ship_po=" + document.getElementById("consignee_po").value;

		responseString = responseString + "&current_consignee_line_id=" + document.getElementById("current_consignee_line_id").value;
		xmlhttp.open("GET", "new_load_add_consignee.jsp" + responseString,true);
		xmlhttp.send();
        	document.getElementById("btn_shipper_save").className = 'btn btn-warning';   
		
        }        
        function addConsignee(){
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
			var addressList = xmlhttp.responseText.split("<ITEM>");
			document.getElementById("consignee_nav").innerHTML = addressList[0];
			document.getElementById("consignee_22").value = "";
			document.getElementById("current_consignee_22_id").value = "";
			document.getElementById("consignee_22_address").value = "";
			document.getElementById("consigneepickup_date").value = "";
			document.getElementById("consigneepickup_time").value = "";
			document.getElementById("consignee_description").value = "";
			document.getElementById("consignee_type").value = "";
			document.getElementById("consignee_units").value = "";
			document.getElementById("consignee_weight").value = "";
			document.getElementById("consignee_note").value = "";
			document.getElementById("consignee_po").value = "";
			
			document.getElementById("btn_shipper_save").className = 'btn btn-success'; 
		}
		}
		
		var responseString = "?consignee_count=" + encodeURIComponent(document.getElementById("consignee_count").value);
		responseString = responseString + "&load_id=" + document.getElementById("load_id").value;
		responseString = responseString + "&ship_name=" + document.getElementById("consignee_22").value;
		responseString = responseString + "&current_consignee_22_id=" + document.getElementById("current_consignee_22_id").value;	
		responseString = responseString + "&ship_location_name=" + document.getElementById("consignee_22_address").value;
		responseString = responseString + "&pickup_date=" + document.getElementById("consigneepickup_date").value;
		responseString = responseString + "&pickup_time=" + document.getElementById("consigneepickup_time").value;
		responseString = responseString + "&ship_description=" + document.getElementById("consignee_description").value;
		responseString = responseString + "&ship_type=" + document.getElementById("consignee_type").value;
		responseString = responseString + "&ship_units=" + document.getElementById("consignee_units").value;
		responseString = responseString + "&ship_weight=" + document.getElementById("consignee_weight").value;
		responseString = responseString + "&ship_note=" + document.getElementById("consignee_note").value;
		responseString = responseString + "&ship_po=" + document.getElementById("consignee_po").value;
		
		if(document.getElementById("current_consignee_line_id")){
			responseString = responseString + "&current_consignee_line_id=" + document.getElementById("current_consignee_line_id").value;		
		}
		
		
		//responseString = responseString + "&email=" + encodeURIComponent(document.getElementById("email").value);
		xmlhttp.open("GET", "new_load_add_consignee.jsp" + responseString,true);
		xmlhttp.send();
        	document.getElementById("btn_shipper_save").className = 'btn btn-warning'; 
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
		//alert(fillTextBoxNameRadius + radiusString);
		if(searchKey.length>1){
			xmlhttp.open("GET", "autoComplete.mtb.rate.jsp?location=" + encodeURIComponent(searchKey) + radiusString ,true);
			xmlhttp.send();
		}
            }      
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
						document.getElementById(addressSPN).innerHTML = "";
					    }
					  }
					xmlhttp.open("GET", "autoFillAddress.yawadi.jsp?location=" + refID ,true);
					xmlhttp.send();
	    }  
	    
        function selectItemOfType(itemValue, itemName) {
        	var itemLabel = itemName + "_label";
        	document.getElementById(itemName).value = itemValue;
        	document.getElementById(itemLabel).innerHTML = itemValue;
			document.getElementById(itemLabel).value = itemValue;

        	gotItMessageHide();
        }
        function calculateRate(){
		var rate = 0;
		var rate_other = 0;
		var units = 1;
		var bill_advance = 0;
		var pds = 0;
		var load_pd = 0;
		var fsc_rate = 0;
		rate = Number(document.getElementById("load_rate").value);
		rate_other = Number(document.getElementById("load_other_charge").value);
		units = Number(document.getElementById("load_units").value);
		bill_advance = Number(document.getElementById("bill_to_advances").value);
		load_pd = Number(document.getElementById("load_pd").value);
		fsc_rate = Number(document.getElementById("load_fsc").value);
		
		
		if(units <1){
			units = 1;
			document.getElementById("load_units").value = units;
		}
		document.getElementById("load_rate_all").value = (fsc_rate + rate_other + load_pd + (rate*units)) -bill_advance;
        
        }
        function showSelectLoadStatus() {
        		document.getElementById("load_status_select_div").style.display = "inline";    
        		document.getElementById("load_type_select_div").style.display = "none";    
        		document.getElementById("load_other_charge_div").style.display = "none";  
        		document.getElementById("load_fees_div").style.display = "none";     
        		document.getElementById("show_carrier_select_div").style.display = "none"; 
        		document.getElementById("show_currency_select_div").style.display = "none";  
        		document.getElementById("bill_to_info").style.display = "none"; 
        		document.getElementById("load_advances_div").style.display = "none"; 
        		document.getElementById("load_bill_advances_div").style.display = "none"; 
        	gotItMessageShow();
        }   
        function showSelectLoadType() {
        		document.getElementById("load_status_select_div").style.display = "none";    
        		document.getElementById("load_type_select_div").style.display = "inline"; 
        		document.getElementById("load_other_charge_div").style.display = "none"; 
        		document.getElementById("load_fees_div").style.display = "none"; 
        		document.getElementById("show_carrier_select_div").style.display = "none"; 
        		document.getElementById("show_currency_select_div").style.display = "none"; 
        		document.getElementById("bill_to_info").style.display = "none"; 
        		document.getElementById("load_advances_div").style.display = "none"; 
        		document.getElementById("load_bill_advances_div").style.display = "none"; 
        
        	gotItMessageShow();
        } 
        
        function showBillToAdvancesCharge() {
        		document.getElementById("load_status_select_div").style.display = "none";    
        		document.getElementById("load_type_select_div").style.display = "none";   
        		document.getElementById("load_other_charge_div").style.display = "none"; 
        		document.getElementById("load_fees_div").style.display = "none"; 
        		document.getElementById("show_carrier_select_div").style.display = "none"; 
        		document.getElementById("show_currency_select_div").style.display = "none"; 
        		document.getElementById("bill_to_info").style.display = "none"; 
        		document.getElementById("load_advances_div").style.display = "none"; 
        		document.getElementById("load_bill_advances_div").style.display = "inline"; 
        		
        
        	gotItMessageShow();        
        }
        function showSelectOtherCharge() {
        		document.getElementById("load_status_select_div").style.display = "none";    
        		document.getElementById("load_type_select_div").style.display = "none";   
        		document.getElementById("load_other_charge_div").style.display = "inline"; 
        		document.getElementById("load_fees_div").style.display = "none"; 
        		document.getElementById("show_carrier_select_div").style.display = "none"; 
        		document.getElementById("show_currency_select_div").style.display = "none"; 
        		document.getElementById("bill_to_info").style.display = "none"; 
        		document.getElementById("load_advances_div").style.display = "none"; 
         		document.getElementById("load_bill_advances_div").style.display = "none"; 
       
        	gotItMessageShow();
        }
        function showSelectFees() {
        		document.getElementById("load_status_select_div").style.display = "none";    
        		document.getElementById("load_type_select_div").style.display = "none";   
        		document.getElementById("load_other_charge_div").style.display = "none"; 
        		document.getElementById("load_fees_div").style.display = "inline"; 
        		document.getElementById("show_carrier_select_div").style.display = "none"; 
        		document.getElementById("show_currency_select_div").style.display = "none"; 
        		document.getElementById("load_advances_div").style.display = "none"; 
         		document.getElementById("load_bill_advances_div").style.display = "none"; 
       		
        
        	gotItMessageShow();
        }
        function showAdvances() {
        		document.getElementById("load_status_select_div").style.display = "none";    
        		document.getElementById("load_type_select_div").style.display = "none";   
        		document.getElementById("load_other_charge_div").style.display = "none"; 
        		document.getElementById("load_fees_div").style.display = "none"; 
        		document.getElementById("show_carrier_select_div").style.display = "none"; 
        		document.getElementById("show_currency_select_div").style.display = "none"; 
        		document.getElementById("load_advances_div").style.display = "inline"; 
          		document.getElementById("load_bill_advances_div").style.display = "none"; 
      		
        		
        
        	gotItMessageShow();
        }
        function showCarrierType() {
        		document.getElementById("load_status_select_div").style.display = "none";    
        		document.getElementById("load_type_select_div").style.display = "none";   
        		document.getElementById("load_other_charge_div").style.display = "none"; 
        		document.getElementById("load_fees_div").style.display = "none"; 
        		document.getElementById("show_carrier_select_div").style.display = "inline"; 
        		document.getElementById("show_currency_select_div").style.display = "none"; 
        		document.getElementById("bill_to_info").style.display = "none"; 
        		document.getElementById("load_advances_div").style.display = "none"; 
          		document.getElementById("load_bill_advances_div").style.display = "none"; 
      		
        
        	gotItMessageShow();
        }
        function showCurrencyType() {
        		document.getElementById("load_status_select_div").style.display = "none";    
        		document.getElementById("load_type_select_div").style.display = "none";   
        		document.getElementById("load_other_charge_div").style.display = "none"; 
        		document.getElementById("load_fees_div").style.display = "none"; 
        		document.getElementById("show_carrier_select_div").style.display = "none"; 
        		document.getElementById("show_currency_select_div").style.display = "inline"; 
        		document.getElementById("bill_to_info").style.display = "none"; 
        		document.getElementById("load_advances_div").style.display = "none"; 
          		document.getElementById("load_bill_advances_div").style.display = "none"; 
      		
        
        	gotItMessageShow();
        }
        
        
        function gotItMessageHide() {
	    $('#myModal').modal('hide');
        
        }        
        function gotItMessageShow() {
        	//alert('Test');
	    $('#myModal').modal({
		show: 'false'
	    });         
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
						if(addressList[6]=="Advance"){
							document.getElementById("load_advances_div_response").innerHTML = addressList[0];
							document.getElementById("load_carrier_advance").value = addressList[2];								
						}else if(addressList[6]=="PayAdvance"){
							document.getElementById("load_bill_advances_div_response").innerHTML = addressList[0];
							document.getElementById("bill_to_advances").value = addressList[2];
						}else if(addressList[6]=="Fee"){
							document.getElementById("load_fees_div_response").innerHTML = addressList[0];
							document.getElementById("load_carrier_fee").value = addressList[2];
						}else{
							document.getElementById("load_charge_div_response").innerHTML = addressList[0];
							document.getElementById("load_other_charge").value = addressList[2];
						}						
						autoSaveItem();
					    }
					  }
		
					var responseString = "?shipper_count=" + encodeURIComponent(document.getElementById("shipper_count").value);
					responseString = responseString + "&load_id=" + document.getElementById("load_id").value;
					responseString = responseString + "&new_fin_type=" + fin_type;
					responseString = responseString + "&fin_id=" + fin_id;
					responseString = responseString + "&fin_remove=True";
						
					xmlhttp.open("GET", "add_shipper_new_charge.jsp" + responseString ,true);
					xmlhttp.send();        
        }
        function addNewOtherCharge() {
        
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
						document.getElementById("load_charge_div_response").innerHTML = addressList[0];
						document.getElementById("load_other_charge").value = addressList[2];				
						autoSaveItem();
					    }
					  }
		
					var responseString = "?shipper_count=" + encodeURIComponent(document.getElementById("shipper_count").value);
					responseString = responseString + "&load_id=" + document.getElementById("load_id").value;
					responseString = responseString + "&new_fin_type=Charge";
					responseString = responseString + "&new_fin_name=" + document.getElementById("new_other_charge_name").value;
					responseString = responseString + "&new_fin_date=" + document.getElementById("new_other_charge_date").value;
					responseString = responseString + "&new_fin_amount=" + document.getElementById("new_other_charge_amount").value;
		
					xmlhttp.open("GET", "add_shipper_new_charge.jsp" + responseString ,true);
					xmlhttp.send();
        
        }
        
        function addNewBillAdvances(){
        
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
						document.getElementById("load_bill_advances_div_response").innerHTML = addressList[0];
						document.getElementById("bill_to_advances").value = addressList[2];				
						autoSaveItem();
						
					    }
					  }
		
					var responseString = "?shipper_count=" + encodeURIComponent(document.getElementById("shipper_count").value);
					responseString = responseString + "&load_id=" + document.getElementById("load_id").value;
					responseString = responseString + "&new_fin_type=PayAdvance";
					responseString = responseString + "&new_fin_name=" + document.getElementById("new_bill_advances_name").value;
					responseString = responseString + "&new_fin_date=" + document.getElementById("new_bill_advances_date").value;
					responseString = responseString + "&new_fin_amount=" + document.getElementById("new_bill_advances_amount").value;
		
					xmlhttp.open("GET", "add_shipper_new_charge.jsp" + responseString ,true);
					xmlhttp.send();
        
        }        
        function addNewAdvances(){
        
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
						document.getElementById("load_advances_div_response").innerHTML = addressList[0];
						document.getElementById("load_carrier_advance").value = addressList[2];				
						autoSaveItem();
						
					    }
					  }
		
					var responseString = "?shipper_count=" + encodeURIComponent(document.getElementById("shipper_count").value);
					responseString = responseString + "&load_id=" + document.getElementById("load_id").value;
					responseString = responseString + "&new_fin_type=Advance";
					responseString = responseString + "&new_fin_name=" + document.getElementById("new_advances_name").value;
					responseString = responseString + "&new_fin_date=" + document.getElementById("new_advances_date").value;
					responseString = responseString + "&new_fin_amount=" + document.getElementById("new_advances_amount").value;
					responseString = responseString + "&new_fin_name_note=" + document.getElementById("new_advances_name_note").value;
					responseString = responseString + "&new_fin_name_notesms=" + document.getElementById("new_advances_name_notesms").value;
		
					xmlhttp.open("GET", "add_shipper_new_charge.jsp" + responseString ,true);
					xmlhttp.send();
        
        }
        function addNewFee() {
        
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
						document.getElementById("load_fees_div_response").innerHTML = addressList[0];
						document.getElementById("load_carrier_fee").value = addressList[2];				
						autoSaveItem();
						
					    }
					  }
		
					var responseString = "?shipper_count=" + encodeURIComponent(document.getElementById("shipper_count").value);
					responseString = responseString + "&load_id=" + document.getElementById("load_id").value;
					responseString = responseString + "&new_fin_type=Fee";
					responseString = responseString + "&new_fin_name=" + document.getElementById("new_fee_name").value;
					responseString = responseString + "&new_fin_date=" + document.getElementById("new_fee_date").value;
					responseString = responseString + "&new_fin_amount=" + document.getElementById("new_fee_amount").value;
		
					xmlhttp.open("GET", "add_shipper_new_charge.jsp" + responseString ,true);
					xmlhttp.send();
	    } 
            function loadPdfConfirmation(load_id){
            	window.open("new_load.pdf.jsp?load_id="+ load_id, load_id);
            }
            function loadPdfConfirmationInvoice(load_id){
            	window.open("new_load.invoice.pdf.jsp?load_id="+ load_id, load_id);
            }
            function loadPdfConfirmationBOL(load_id){
            	window.open("new_load.bol.pdf.jsp?load_id="+ load_id, load_id);
            }
            function copyLoadToNewLoad(load_id){
            	window.open("dispatch_board.jsp?copyload=Yes&load_number="+ load_id, load_id);
            }
            function publishTOWebLoadToNewLoad(load_id){
            	window.open("dispatch_board.jsp?copyload=Yes&load_number="+ load_id, load_id);
            }
            function loadPdfConfirmationSMS(load_id){
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
					    	
						alert(xmlhttp.responseText);
						
					    }
					  }
		
					var responseString = "?load_id=" + encodeURIComponent(load_id);
					xmlhttp.open("GET", "new_load.pdf.sms.jsp" + responseString ,true);
					xmlhttp.send();            	
            }
            function loadPdfConfirmationEmail(load_id){
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
					    	
						alert(xmlhttp.responseText);
						
					    }
					  }
		
					var responseString = "?load_id=" + encodeURIComponent(load_id);
					xmlhttp.open("GET", "new_load.pdf.email.jsp" + responseString ,true);
					xmlhttp.send();            	
            }
        </script>	
    <script language="JavaScript" type="text/javascript">

    function initialize() {

	calculateRate();

		var options = {
    types: ['(cities)'],
    componentRestrictions: {country: ['us', 'ca','mx'] }
    };



    var input = /** @type {HTMLInputElement} */(
    document.getElementById('pac-input'));
    
        var input2 = /** @type {HTMLInputElement} */(
        document.getElementById('bill_pac-input'));
        
        var input3 = /** @type {HTMLInputElement} */(
        document.getElementById('pac-input6'));





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
		}
    });
    
         var autocomplete2 = new google.maps.places.Autocomplete(input2);

        google.maps.event.addListener(autocomplete2, 'place_changed', function() {

        var place2 = autocomplete2.getPlace();

        if (!place2.geometry) {
        return;
        }
    		document.getElementById('bill_pickCity_lat').value = place2.geometry.location.lat();
    		document.getElementById('bill_pickCity_lng').value = place2.geometry.location.lng();
        });
        
         var autocomplete3 = new google.maps.places.Autocomplete(input3);

        google.maps.event.addListener(autocomplete3, 'place_changed', function() {

        var place3 = autocomplete3.getPlace();

        if (!place3.geometry) {
        return;
        }
    		document.getElementById('consigneepickCity_lat').value = place3.geometry.location.lat();
    		document.getElementById('consigneepickCity_lng').value = place3.geometry.location.lng();
        });
        
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

    $('#datetimepicker99').datetimepicker({
    format: 'MM-DD-YYYY',
    showClear: true

    });
    
    $('#datetimepicker2').datetimepicker({
    format: 'MM-DD-YYYY',
    showClear: true

    });
    $('#datetimepicker6').datetimepicker({
    format: 'MM-DD-YYYY',
    showClear: true

    });
    $('#datetimepicker7').datetimepicker({
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
    <!-- custom maps markers -->
    <!--<script src="css/fontawesome-markers.min.js"></script>-->



    

  </head>


	<body onload="initialize()" >


			<%@include file="nav_menu.jsp"%>  




	<br><br><br>

<!-- end of nav bar -->

		<div class="container">
		<div class="row">

<form > 
      <div class="panel panel-default" >	
      <div class="panel-heading" style="padding:10px;">
      <div class="input-group">
      <a class="btn btn-primary" href="javascript:void(0)" role="button" onclick="autoSaveItem();" name="btn_shipper_save" id="btn_shipper_save" ><span class="glyphicon glyphicon-save" aria-hidden="true"></span>&nbsp;SAVE</a>
      &nbsp;&nbsp;
	
            <a class="btn btn-primary" href="javascript:void(0)" id="printPDFButton" role="button" <%if(request.getParameter("load_id")==null){%>style="display:none;"<%}%> onclick="loadPdfConfirmation('<%=request.getParameter("load_id")%>')" ><span style="color:white;" ><span class="glyphicon glyphicon-print" aria-hidden="true"></span>&nbsp;PRINT&nbsp;LOAD</span></a>
      &nbsp;&nbsp;        
            <a class="btn btn-primary" href="javascript:void(0)" id="printPDFEmailButton" role="button" <%if(request.getParameter("load_id")==null){%>style="display:none;"<%}%> onclick="loadPdfConfirmationEmail('<%=request.getParameter("load_id")%>')" ><span style="color:white;" ><span class="glyphicon glyphicon-envelope" aria-hidden="true"></span>&nbsp;EMAIL</span></a>
      &nbsp;&nbsp;
            <a class="btn btn-primary" href="javascript:void(0)" id="printPDFSMSButton" role="button" <%if(request.getParameter("load_id")==null){%>style="display:none;"<%}%> onclick="loadPdfConfirmationSMS('<%=request.getParameter("load_id")%>')" ><span style="color:white;" ><span class="glyphicon glyphicon-phone" aria-hidden="true"></span>&nbsp;SMS</span></a>
      &nbsp;&nbsp;
            <a class="btn btn-primary" href="javascript:void(0)" id="printPDFSMSButton" role="button" <%if(request.getParameter("load_id")==null){%>style="display:none;"<%}%> onclick="loadPdfConfirmationInvoice('<%=request.getParameter("load_id")%>')" ><span style="color:white;" ><span class="glyphicon glyphicon-print" aria-hidden="true"></span>&nbsp;PRINT&nbsp;INVOICE</span></a>
     &nbsp;&nbsp;
            <a class="btn btn-primary" href="javascript:void(0)" id="printPDFSMSButton" role="button" <%if(request.getParameter("load_id")==null){%>style="display:none;"<%}%> onclick="loadPdfConfirmationBOL('<%=request.getParameter("load_id")%>')" ><span style="color:white;" ><span class="glyphicon glyphicon-print" aria-hidden="true"></span>&nbsp;PRINT&nbsp;BOL</span></a>

     &nbsp;&nbsp;
            <a class="btn btn-primary" href="javascript:void(0)" id="printPDFSMSButton" role="button" <%if(request.getParameter("load_id")==null){%>style="display:none;"<%}%> onclick="copyLoadToNewLoad('<%=request.getParameter("load_id")%>')" ><span style="color:white;" ><span class="glyphicon glyphicon-copy" aria-hidden="true"></span>&nbsp;COPY</span></a>
      &nbsp;&nbsp;
      
            
      </div>	
      </div>
      <div class="panel-body">

	 <ul class="nav nav-tabs">
	  <li class="active"><a data-toggle="tab" href="#home" onclick="showLoadInfo()" >Load Info</a></li>
	  <li><a data-toggle="tab" href="#menu1" onclick="showSalesInfo()">Sales Info</a></li>
	  <li><a data-toggle="tab" href="#menu1" onclick="showDispatcherInfo()">Dispatcher Info</a></li>
	 </ul>

	<%
		String bill_to_old = "";
		String bill_to_old_id = "";
		String bill_to_old_address = "";
		String ln_number = "";
		String ln_status = "";
		String wo_number = "";
		String type = "";
		String rate = "";
		String units = "";
		String pds = "";
		String fsc_rate = "";
		String other_charges = "";
		String rate_all = "";
		String carrier_id = "";
		String carrier_name = "";
		String carrier_address = "";
		String carrier_type = "";
		String carrier_fee = "";
		String carrier_rate = "";
		String carrier_advances = "";
		String carrier_currency = "";
		String disList = "";
		String slList = "";
		String bill_to_advances = "";
		if(request.getParameter("cmd")!=null && request.getParameter("cmd").equals("newLoad") ){
			ln_status = request.getParameter("statusLD");
		}
		if(request.getParameter("load_id")!=null){
	        try{
			Class.forName("com.mysql.jdbc.Driver");
			String url = "jdbc:mysql://localhost/test?zeroDateTimeBehavior=convertToNull";
			Connection connection = DriverManager.getConnection(url,"<USERNAME>", "<PASSWORD>");
			PreparedStatement psMain = null;		
			psMain = connection.prepareStatement("select * from test.load_board left join test.TRUCKING_EQUIPMENT on load_board.load_equipment_id=TRUCKING_EQUIPMENT.id left join test.locations on load_board.bill_to_id = locations.location_id WHERE load_board.COMPANY_ID = ? and load_board.load_board_id = ? order by load_board.ts asc");			
			psMain.setString(1, uuid);
			psMain.setString(2, request.getParameter("load_id"));
			ResultSet resultSet = psMain.executeQuery();
			while (resultSet.next()) {
				wo_number = resultSet.getString("load_wo");
				ln_status = resultSet.getString("load_status");
				ln_number = resultSet.getString("load_number_float");
				type = resultSet.getString("load_type");
				bill_to_old = NullCheck.check(resultSet.getString("locations.org_name"));
				bill_to_old_id = NullCheck.check(resultSet.getString("bill_to_id"));
				bill_to_old_address = NullCheck.check(resultSet.getString("locations.address"));
				
				carrier_advances = resultSet.getString("advances_total");
				carrier_fee = resultSet.getString("load_carrier_fee");
				carrier_rate = resultSet.getString("carrier_rate");
				other_charges = resultSet.getString("load_other");
				rate = resultSet.getString("load_rate");
				units = resultSet.getString("load_units");
				fsc_rate = resultSet.getString("load_fsc");
				rate_all = resultSet.getString("load_rate_all");
				carrier_name = NullCheck.check(resultSet.getString("TRUCKING_EQUIPMENT.name"));
				carrier_id = NullCheck.check(resultSet.getString("TRUCKING_EQUIPMENT.id"));
				carrier_address = NullCheck.check(resultSet.getString("TRUCKING_EQUIPMENT.city"));
				disList = resultSet.getString("disDetail");
				carrier_type = NullCheck.check(resultSet.getString("carrier_type"));
				slList = resultSet.getString("salDetail");
				bill_to_advances = resultSet.getString("bill_to_advances");
				pds = resultSet.getString("load_pd");
			}
			connection.close();
	         }catch (Exception ex){
	             %><%="Error Posting " + ex%><%
	             System.out.println(""+ ex);
	         }	
	         }
		
	%>


		<div id="load_info" name="load_info" style="display:inline;" >
	<div class="form-wrapper">
		<div class="input-group" style="padding:5px;">
			  <input type="hidden" value="<%=carrier_id%>" id="current_carrier_22_id" name="current_carrier_22_id" />
			  <input type="hidden" value="<%=carrier_address%>" id="carrier_22_address" name="carrier_22_address" />
			  <input type="hidden" value="<%=bill_to_old_id%>" id="current_bill_22_id" name="current_bill_22_id" />
			  <input type="hidden" value="<%=bill_to_old_address%>" id="bill_22_address" name="bill_22_address" />
			  <input type="hidden" <%if(type.equals("")){%>value="LTL"<%}else{%>value="<%=type%>"<%}%> id="load_type" name="load_type" />
			  <input type="hidden" <%if(ln_status.equals("")){%>value="Open"<%}else{%>value="<%=ln_status%>"<%}%> id="load_status" name="load_status" />
			  <input type="hidden" <%if(carrier_type.equals("")){%>value="Dry Van"<%}else{%>value="<%=carrier_type%>"<%}%> id="load_equipment_type" name="load_equipment_type" />
			  <input type="hidden" value="USD" id="currency_type" name="currency_type" />




			<div class="row">
			<div class="col-md-3">
			<div class="form-group">
			<label>Bill to <a data-toggle="tab" href="#menu1" onclick="addBillToInfo()" ><span class="glyphicon glyphicon-plus-sign" ></span></a></label>
			<input type="text" class="form-control" name="bill_22" id="bill_22" value="<%=bill_to_old%>" placeholder="James Franco Trucking, Inc." onblur="getLocationByName(document.getElementById('bill_22').value, document.getElementById('bill_22').name)" onkeypress="searchLocationByName(document.getElementById('bill_22').value, document.getElementById('bill_22').name, 'Billing')" />
			</div>
			</div>

			<div class="col-md-3">
			<div class="form-group">
			<label>Load Number</label>
			<input type="text" class="form-control" value="<%="LN" + ln_number%>" name="load_number" id="load_number" placeholder="Auto" <%if(!ln_number.equals("")){%>style="color:green;"<%}%>readonly />
			</div>
			</div>

			<div class="col-md-3">
			<div class="form-group">
			<label>Status</label>
			<input type="text" class="form-control" value="<%=ln_status%>" placeholder="Open" onfocus="showSelectLoadStatus()" onclick="showSelectLoadStatus()" name="load_status_label" id="load_status_label"/>
			</div>
			</div>

			<div class="col-md-2">
			<div class="form-group">
			<label>W/O</label>
			<input type="text" class="form-control" value="<%=wo_number%>" name="load_wo" id="load_wo" placeholder="WO98999"/>
			</div>
			</div>

			</div>


			<div class="row">
			<div class="col-md-2">
			<div class="form-group">
			<label>Type</label>
			<input type="text" class="form-control" value="<%=type%>" placeholder="Pallets" onfocus="showSelectLoadType()" onclick="showSelectLoadType()" name="load_type_label" id="load_type_label"/>
			</div>
			</div>

			<div class="col-md-1">
			<div class="form-group">
			<label>Rate</label>
			<input type="text" class="form-control"  name="load_rate" id="load_rate" value="<%=rate%>" onchange="calculateRate()" placeholder="1200.00"/>
			</div>
			</div>

			<div class="col-md-1">
			<div class="form-group">
			<label>Units</label>
			<input type="text" class="form-control" value="<%=units%>" name="load_units" id="load_units" onchange="calculateRate()" placeholder="1"/>
			</div>
			</div>

			<div class="col-md-1">
			<div class="form-group">
			<label>P/Ds</label>
			<input type="text" class="form-control" value="<%=pds%>" name="load_pd" id="load_pd" onchange="calculateRate()" placeholder="1200.00"/>
			</div>
			</div>

			<div class="col-md-1">
			<div class="form-group">
			<label>F.S.C %</label>
			<input type="checkbox" class="btn btn-sm" name="load_fsc_check" id="load_fsc_check">
			</div>
			</div>

			<div class="col-md-1">
			<div class="form-group">
			<label>Rate</label>
			<input type="text" class="form-control" value="<%=fsc_rate%>" name="load_fsc" id="load_fsc" placeholder="1200.00"/>
			</div>
			</div>

			<div class="col-md-2">
			<div class="form-group">
			<label>Other <span>Charges </span></label>
			<input type="text" class="form-control" value="<%=other_charges%>" name="load_other_charge" onchange="calculateRate()" id="load_other_charge" placeholder="1200.00" onfocus="showSelectOtherCharge()" onclick="showSelectOtherCharge()"/>
			</div>
			</div>

			<div class="col-md-1">
			<div class="form-group">
			<label>Advances</label>
			<input type="text" class="form-control" name="bill_to_advances" id="bill_to_advances" onchange="calculateRate()" value="<%=bill_to_advances%>" placeholder="1200.00" onfocus="showBillToAdvancesCharge()" onclick="showBillToAdvancesCharge()"/>
			</div>
			</div>
			<div class="col-md-1">
			<div class="form-group">
			<label>Rate</label>
			<input type="text" class="form-control" name="load_rate_all" id="load_rate_all" value="<%=rate_all%>" readonly style="color:green;" placeholder="1200.00"/>
			</div>
			</div>

			</div>



			<div class="row">
			<div class="col-md-3">
			<div class="form-group">
			<label>Carrier</label>
			<input type="text" class="form-control" name="carrier_22" id="carrier_22" value="<%=carrier_name%>" placeholder="Joe's Trucking Inc" onblur="getLocationByName(document.getElementById('carrier_22').value, document.getElementById('carrier_22').name)" onkeypress="searchLocationByName(document.getElementById('carrier_22').value, document.getElementById('carrier_22').name, 'Carrier')" >

			</div>
			</div>

			<div class="col-md-1">
			<div class="form-group">
			<label>Rate</label>
			<input type="text" class="form-control" name="carrier_rate" id="carrier_rate" value="<%=carrier_rate%>" placeholder="1200.00" />
			</div>
			</div>

			<div class="col-md-2">
			<div class="form-group">
			<label>Fees</label>
			<input type="text" class="form-control" name="load_carrier_fee" id="load_carrier_fee" value="<%=carrier_fee%>" placeholder="1200.00" onfocus="showSelectFees()" onclick="showSelectFees()"/>
			</div>
			</div>

			<div class="col-md-3">
			<div class="form-group">
			<label>Carrier Type</label>
			<input type="text" class="form-control" value="<%=carrier_type%>" placeholder="Auto Carrier" onfocus="showCarrierType()" onclick="showCarrierType()" name="load_equipment_type_label" id="load_equipment_type_label" />
			</div>
			</div>
			
			<div class="col-md-1">
			<div class="form-group">
			<label>Advances</label>
			<input type="text" class="form-control" name="load_carrier_advance" id="load_carrier_advance" value="<%=carrier_advances%>" placeholder="1200.00" onfocus="showAdvances()" onclick="showAdvances()"/>
			</div>
			</div>

			<div class="col-md-1">
			<div class="form-group">
			<label>Currency</label>
			<input type="text" class="form-control" value="" placeholder="USD" onclick="showCurrencyType()" name="currency_type_label" id="currency_type_label" />
			</div>
			</div>


			</div>


			</div>
		<!-- end of form-wrapper-->
		</div>

	</div>

           <%
			Vector teamList = new Vector();
			Vector userList = new Vector();
			HashMap user_teams = new HashMap();
			HashMap user_teams_users = new HashMap();
			HashMap user_teams_users_roles = new HashMap();
	        try{
			Class.forName("com.mysql.jdbc.Driver");
			String url = "jdbc:mysql://localhost/test?zeroDateTimeBehavior=convertToNull";
			Connection connection = DriverManager.getConnection(url,"<USERNAME>", "<PASSWORD>");

			PreparedStatement psMain = null;
			psMain = connection.prepareStatement("select * from test.TRUCKING_USER_teams_User WHERE COMPANY_ID = ?");
			psMain.setString(1, uuid);
			ResultSet resultSet = psMain.executeQuery();
			while (resultSet.next()) {
				user_teams.put(resultSet.getString("team_id")+ resultSet.getString("user_id"),resultSet.getString("user_id"));
				user_teams_users.put(resultSet.getString("user_id"),resultSet.getString("user_id"));
			}
			psMain = connection.prepareStatement("select * from test.TRUCKING_USERS WHERE COMPANY_ID = ?");
			psMain.setString(1, uuid);
			resultSet = psMain.executeQuery();
			while (resultSet.next()) {
				String[] userItem = new String[4];
				userItem[0] = resultSet.getString("email");
				userItem[1] = resultSet.getString("f_name");
				userItem[2] = resultSet.getString("l_name");
				userItem[3] = resultSet.getString("phone");
				userList.add(userItem);
			}
			psMain = connection.prepareStatement("select * from test.TRUCKING_USER_teams WHERE COMPANY_ID = ?");
			psMain.setString(1, uuid);
			resultSet = psMain.executeQuery();
			while (resultSet.next()) {
				String[] userItem = new String[3];
				userItem[0] = resultSet.getString("team_id");
				userItem[1] = resultSet.getString("name");
				teamList.add(userItem);
				
			}
			psMain = connection.prepareStatement("select * from test.TRUCKING_USER_teams_User_state WHERE COMPANY_ID = ?");
			psMain.setString(1, uuid);
			resultSet = psMain.executeQuery();
			while (resultSet.next()) {
				String[] userItem = new String[3];
				userItem[0] = resultSet.getString("team_id");
				userItem[1] = resultSet.getString("user_id");
				userItem[1] = resultSet.getString("user_state");
				user_teams_users_roles.put(resultSet.getString("team_id") + resultSet.getString("user_id")+ resultSet.getString("user_state"), userItem);				
			}
					
      
			connection.close();
	         }catch (Exception ex){
	             %><%="Error Posting " + ex%><%
	             System.out.println(""+ ex);
	         }
	         		%>

		<div id="sales_info" name="sales_info" style="display:none;" >
	<div class="form-wrapper">
		<% String login_id = (String)session.getAttribute("login_id"); %>
		<% int countSales = 0; %>
		<%for(int j=0;j<teamList.size();j++){%>
			<%if(user_teams.containsKey(((String[])teamList.get(j))[0] + login_id)){%>
				
				<%=((String[])teamList.get(j))[1]%><BR>
				<%for(int k=0;k<userList.size();k++){%>
					<%if(user_teams.containsKey(((String[])teamList.get(j))[0] + ((String[])userList.get(k))[0])){%>
					<%if(user_teams_users_roles.containsKey(((String[])teamList.get(j))[0] + ((String[])userList.get(k))[0]+ "Sales")){%>
					<div class="row" >
						<div class="col-md-2" >
						<input type="hidden" name="<%="SALIDV"+countSales%>" id="<%="SALIDV"+countSales%>"  value="<%=((String[])userList.get(k))[0]%>"/>
						<input type="checkbox" name="<%="SALID"+countSales%>" id="<%="SALID"+countSales%>"
						<%for(int jk =0;jk<slList.split(":").length;jk++){%>
							<%if(((String[])userList.get(k))[0].equals(slList.split(":")[jk])){%>
								checked
							<%}%>
						<%}%>
						
						<%if(request.getParameter("load_id")==null){%>
								checked
						<%}%>
						/>
						<% countSales += 1;%>
						<%=NullCheck.check(((String[])userList.get(k))[1])%>
						</div>
						<div class="col-md-4" >
						<%=NullCheck.check(((String[])userList.get(k))[2])%>
						</div>
						<div class="col-md-4" >
						<%=((String[])userList.get(k))[0]%>
						</div>
						<div class="col-md-2" >
						<%=NullCheck.check(((String[])userList.get(k))[3])%>
						</div>
					</div>
					<%}%>
					<%}%>
				<%}%>
			<%}%>
		<%}%>
		<input type="hidden" id="salesCount" name="salesCount" value="<%=countSales%>" > 
		</div>
	</div>

		<div id="dispatcher_info" name="load_info" style="display:none;" >
	<div class="form-wrapper">
		<% int countDis = 0; %>
		<%for(int j=0;j<teamList.size();j++){%>
			<%if(user_teams.containsKey(((String[])teamList.get(j))[0] + login_id)){%>
				<% String managerID = new String();%>
				<%=((String[])teamList.get(j))[1]%>				
				<%for(int k=0;k<userList.size();k++){%>
				<%if(user_teams.containsKey(((String[])teamList.get(j))[0] + ((String[])userList.get(k))[0])){%>
				<%if(user_teams_users_roles.containsKey(((String[])teamList.get(j))[0] + ((String[])userList.get(k))[0]+ "Manager")){%><BR>
							Manager <%=NullCheck.check(((String[])userList.get(k))[1])%> <%=NullCheck.check(((String[])userList.get(k))[2])%> <%=NullCheck.check(((String[])userList.get(k))[0])%> <%=NullCheck.check(((String[])userList.get(k))[3])%>
							<% managerID = NullCheck.check(((String[])userList.get(k))[0]);%>
				<%}%>
				<%}%>
				<%}%>
				
				<input type="hidden" id="managerID" name="managerID" value="<%=managerID%>" > 
				<BR>
				<%for(int k=0;k<userList.size();k++){%>
					<%if(user_teams.containsKey(((String[])teamList.get(j))[0] + ((String[])userList.get(k))[0])){%>
					<%if(user_teams_users_roles.containsKey(((String[])teamList.get(j))[0] + ((String[])userList.get(k))[0]+ "Dispatcher")){%>
					<%
						boolean isManagerForGroup = false;
						isManagerForGroup = user_teams_users_roles.containsKey(((String[])teamList.get(j))[0] + (String)session.getAttribute("login_id") + "Manager");
					%>
						<div class="row" >
							<div class="col-md-2" >
							<input type="hidden" name="<%="DISIDV"+countDis%>" id="<%="DISIDV"+countDis%>"  value="<%=((String[])userList.get(k))[0]%>"/>
							<input type="checkbox" name="<%="DISID"+countDis%>" id="<%="DISID"+countDis%>" 
						<%for(int jk =0;jk<disList.split(":").length;jk++){%>
							<%if(((String[])userList.get(k))[0].equals(disList.split(":")[jk])){%>
								checked
							<%}%>
						<%}%>
						<%if(request.getParameter("load_id")==null){%>
							<%if(!isManagerForGroup){%>
								disabled
							<%}%>
							<%if((!isManagerForGroup && user_teams_users_roles.containsKey(((String[])teamList.get(j))[0] + (String)session.getAttribute("login_id") + "Dispatcher")) && ((String)session.getAttribute("login_id")).equals(((String[])userList.get(k))[0])){%>
								checked
							<%}%>
						<%}%>
							
							
							/>
							<%=NullCheck.check(((String[])userList.get(k))[1])%>
							<% countDis += 1;%>
							</div>
							<div class="col-md-4" >
							<%=NullCheck.check(((String[])userList.get(k))[2])%>
							</div>
							<div class="col-md-4" >
							<%=((String[])userList.get(k))[0]%>
							</div>
							<div class="col-md-2" >
							<%=NullCheck.check(((String[])userList.get(k))[3])%>
							</div>
						</div>
					<%}%>
					<%}%>
				<%}%>
			<%}%>
		<%}%>
				<input type="hidden" id="disCount" name="disCount" value="<%=countDis%>" > 
		</div>
		</div>
		<div id="bill_to_info" name="bill_to_info" style="display:none;" >

 	<div class="col-md-6" style="padding:5px;">
<div class="input-group input-group-sm">

  <span class="input-group-addon" id="basic-addon1"><span class="glyphicon glyphicon-pencil" ></span></span>
	<input type="text" class="form-control" id="bill_name_add" name="bill_name_add" placeholder="Business\Organization Name" value="" />	
</div>   
	</div>     
	<div class="col-md-2" style="padding:5px;">
<div class="input-group input-group-sm">
  <span class="input-group-addon" id="basic-addon1"><span class="glyphicon glyphicon-phone" ></span></span>
	<input type="text" class="form-control" id="bill_phone_add" name="bill_phone_add" placeholder="Phone" value="" />	
</div>   
	</div>     
	<div class="col-md-4" style="padding:5px;">
<div class="input-group input-group-sm">
  <span class="input-group-addon" id="basic-addon1"><span class="glyphicon glyphicon-envelope" ></span></span>
	<input type="text" class="form-control" id="bill_email_add" name="bill_email_add" placeholder="Email" value="" />	
</div>   
	</div>  
	
	<div class="col-md-6" style="padding:5px;">
<div class="input-group input-group-sm">
  <span class="input-group-addon" id="basic-addon1"><span class="glyphicon glyphicon-pencil" ></span></span>
	<input type="text" class="form-control" id="bill_contact_name_add" name="bill_contact_name_add" placeholder="Contact Name" value="" />	
</div>   
	</div>     
	<div class="col-md-2" style="padding:5px;">
<div class="input-group input-group-sm">
  <span class="input-group-addon" id="basic-addon1"><span class="glyphicon glyphicon-phone" ></span></span>
	<input type="text" class="form-control" id="bill_contact_phone_add" name="bill_contact_phone_add" placeholder="Phone" value="" />	
</div>   
	</div>     
	<div class="col-md-4" style="padding:5px;">
<div class="input-group input-group-sm">
  <span class="input-group-addon" id="basic-addon1"><span class="glyphicon glyphicon-envelope" ></span></span>
	<input type="text" class="form-control" id="bill_contact_email_add" name="bill_contact_email_add" placeholder="Email" value="" />	
</div>   
	</div>     
 	
	<div class="col-md-12" style="padding:5px;">
<div class="input-group input-group-sm">
  <span class="input-group-addon" id="basic-addon1"><span class="glyphicon glyphicon-globe" ></span>
  </span>
    <input type="hidden" name="bill_pickCity_lat" id="bill_pickCity_lat" value="" />
    <input type="hidden" name="bill_pickCity_lng" id="bill_pickCity_lng" value="" />
    <input type="hidden" name="bill_pickCity" id="bill_pickCity" value="">
    <input type="hidden" name="bill_pickState" id="bill_pickState" value="">
	<input type="text" class="form-control" id="bill_pac-input" name="bill_pac-input" placeholder="City" value="" />
		

</div>   
	</div>



	<div class="col-md-12" style="padding:5px;">
<div class="input-group input-group-sm">
    <span class="input-group-addon" id="basic-addon1"><span class="glyphicon glyphicon-flag" ></span></span>
    <input type="text" class="form-control" placeholder="Address" id="bill_pickup_address_add" name="bill_pickup_address_add" aria-describedby="basic-addon1" onkeypress="autocompleteLocationName(document.getElementById('bill_pickup_address_add').value, document.getElementById('bill_pickup_address_add').name, 'bill_pickCity')" autocomplete="off" >

	<span id="bill_pickup_address_addSPN" name="bill_pickup_address_addSPN" style="border-color:#262626;border-width: 1px;font-size:1.0em;width:80%;"></span>
</div>
	<input type="hidden" name="bill_pickup_address_add_lat" id="bill_pickup_address_add_lat" value="" />
	<input type="hidden" name="bill_pickup_address_add_lng" id="bill_pickup_address_add_lng" value="" />
	</div>
	
	<div class="col-md-12" style="padding:5px;">
<div class="input-group input-group-sm">
  <span class="input-group-addon" id="basic-addon1"><span class="glyphicon glyphicon-flag" ></span>
  </span>
	<input type="text" class="form-control" id="bill_address2_add" name="bill_address2_add" placeholder="Address Line 2" value="" />	

</div>   
	</div>
	<div class="col-md-12" style="padding:5px;">
<div class="input-group input-group-sm">
  <span class="input-group-addon" id="basic-addon1"><span class="glyphicon glyphicon-pencil" ></span>
  </span>
	<input type="text" class="form-control" id="bill_notes_add" name="bill_notes_add" placeholder="Notes" value="" />	

</div>   
	</div>	
		<div class="col-md-12" style="padding:5px;">
      <button type="button" class="btn btn-success" onclick="saveNewBillTo();" ><span class="glyphicon glyphicon-save" aria-hidden="true"></span>SAVE</button>
	
  <a data-toggle="tab" href="#menu1" onclick="addBillToCancel()" ><span class="glyphicon glyphicon-trash pull-right" ></span></a>
	</div>
		</div>    
<!-- Modal -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
  
        <div id="show_currency_select_div" name="show_currency_select_div" >
        	<h2 class="modal-title" id="myModalLabel">Set Currency Type</h2>
        	<a href="#home" onclick="selectItemOfType('USD','currency_type')" >USD</a><BR>
        	<a href="#home" onclick="selectItemOfType('CUSD','currency_type')" >CUSD</a><BR>
        </div>
        <div id="show_carrier_select_div" name="show_carrier_select_div" >
        	<h2 class="modal-title" id="myModalLabel">Set Carrier Type</h2>
        	<a href="#home" onclick="selectItemOfType('Auto Carrier','load_equipment_type')" >Auto Carrier</a><BR>
        	<a href="#home" onclick="selectItemOfType('Dry Van','load_equipment_type')" >Dry Van</a><BR>
        	<a href="#home" onclick="selectItemOfType('Reefer','load_equipment_type')" >Reefer</a><BR>
        </div>
      
        <div id="load_status_select_div" name="load_status_select_div" >
        <h2 class="modal-title" id="myModalLabel">Set Load Status</h2>
        <a href="#home" onclick="selectItemOfType('Pending','load_status')" value="Pending" name="load_status_label" id="load_status_label">Pending</a><BR>
        <a href="#home" onclick="selectItemOfType('Open','load_status')" name="load_status_label" id="load_status_label">Open</a><BR>
        <a href="#home" onclick="selectItemOfType('Refused','load_status')" name="load_status_label" id="load_status_label">Refused</a><BR>
        <a href="#home" onclick="selectItemOfType('Covered','load_status')" name="load_status_label" id="load_status_label">Covered</a><BR>
        <a href="#home" onclick="selectItemOfType('Dispatched','load_status')" name="load_status_label" id="load_status_label">Dispatched</a><BR>
        <a href="#home" onclick="selectItemOfType('On Route','load_status')" name="load_status_label" id="load_status_label">On Route</a><BR>
        <a href="#home" onclick="selectItemOfType('Unloading','load_status')" name="load_status_label" id="load_status_label">Unloading</a><BR>
        <a href="#home" onclick="selectItemOfType('In Yard','load_status')" name="load_status_label" id="load_status_label">In Yard</a><BR>
        <a href="#home" onclick="selectItemOfType('Complete','load_status')" name="load_status_label" id="load_status_label">Complete</a><BR>
        </div>
        <div id="load_type_select_div" name="load_type_select_div" >
        <h2 class="modal-title" id="myModalLabel">Select Load Type</h2>
        <a href="#home" onclick="selectItemOfType('25Lb Sacks','load_type')" name="load_type_label" id="load_type_label" >25Lb Sacks</a><BR>
        <a href="#home" onclick="selectItemOfType('45Lb Cartons','load_type')" name="load_type_label" id="load_type_label" >25Lb Cartons</a><BR>
        <a href="#home" onclick="selectItemOfType('50Lb Sacks','load_type')" name="load_type_label" id="load_type_label" >50Lb Sacks</a><BR>
        <a href="#home" onclick="selectItemOfType('Air Freight','load_type')" name="load_type_label" id="load_type_label" >Air Freight</a><BR>
        <a href="#home" onclick="selectItemOfType('Barrels','load_type')" name="load_type_label" id="load_type_label" >Barrels</a><BR>
        <a href="#home" onclick="selectItemOfType('Bushelst','load_type')" name="load_type_label" id="load_type_label" >Bushelst</a><BR>
        <a href="#home" onclick="selectItemOfType('Cubic Yard','load_type')" name="load_type_label" id="load_type_label" >Cubic Yard</a><BR>
        <a href="#home" onclick="selectItemOfType('CWT 100Lb','load_type')" name="load_type_label" id="load_type_label" >CWT 100Lb</a><BR>
        <a href="#home" onclick="selectItemOfType('CWT 1Lb','load_type')" name="load_type_label" id="load_type_label" >CWT 1Lb</a><BR>
        <a href="#home" onclick="selectItemOfType('CWT Ton','load_type')" name="load_type_label" id="load_type_label" >CWT Ton</a><BR>
        <a href="#home" onclick="selectItemOfType('Delivery','load_type')" name="load_type_label" id="load_type_label" >Delivery</a><BR>
        <a href="#home" onclick="selectItemOfType('Direct','load_type')" name="load_type_label" id="load_type_label" >Direct</a><BR>
        <a href="#home" onclick="selectItemOfType('Drop','load_type')" name="load_type_label" id="load_type_label" >Drop</a><BR>
        <a href="#home" onclick="selectItemOfType('Equipment Rental Daily','load_type')" name="load_type_label" id="load_type_label" >Equipment Rental Daily</a><BR>
        <a href="#home" onclick="selectItemOfType('Equipment Rental Monthly','load_type')" name="load_type_label" id="load_type_label" >Equipment Rental Monthly</a><BR>
        <a href="#home" onclick="selectItemOfType('Equipment Rental Weekly','load_type')" name="load_type_label" id="load_type_label" >Equipment Rental Weekly</a><BR>
        <a href="#home" onclick="selectItemOfType('Fleet','load_type')" name="load_type_label" id="load_type_label" >Fleet</a><BR>
        <a href="#home" onclick="selectItemOfType('Flatbed','load_type')" name="load_type_label" id="load_type_label" >Flatbed</a><BR>
        <a href="#home" onclick="selectItemOfType('Full Truckload','load_type')" name="load_type_label" id="load_type_label" >Full Truckload</a><BR>
        <a href="#home" onclick="selectItemOfType('Hot Shot','load_type')" name="load_type_label" id="load_type_label" >Hot Shot</a><BR>
        <a href="#home" onclick="selectItemOfType('Hourly','load_type')" name="load_type_label" id="load_type_label" >Hourly</a><BR>
        <a href="#home" onclick="selectItemOfType('Labour','load_type')" name="load_type_label" id="load_type_label" >Labour</a><BR>
        <a href="#home" onclick="selectItemOfType('LBS','load_type')" name="load_type_label" id="load_type_label" >LBS</a><BR>
        <a href="#home" onclick="selectItemOfType('Line Haul','load_type')" name="load_type_label" id="load_type_label" >Line Haul</a><BR>
        <a href="#home" onclick="selectItemOfType('LTL','load_type')" name="load_type_label" id="load_type_label" >LTL</a><BR>
        <a href="#home" onclick="selectItemOfType('Metric Ton','load_type')" name="load_type_label" id="load_type_label" >Metric Ton</a><BR>
        <a href="#home" onclick="selectItemOfType('Ocean','load_type')" name="load_type_label" id="load_type_label" >Ocean</a><BR>
        <a href="#home" onclick="selectItemOfType('Other','load_type')" name="load_type_label" id="load_type_label" >Other</a><BR>
        <a href="#home" onclick="selectItemOfType('Pallets','load_type')" name="load_type_label" id="load_type_label" >Pallets</a><BR>
        <a href="#home" onclick="selectItemOfType('Pick up','load_type')" name="load_type_label" id="load_type_label" >Pick up</a><BR>
        <a href="#home" onclick="selectItemOfType('Piece','load_type')" name="load_type_label" id="load_type_label" >Piece</a><BR>
        <a href="#home" onclick="selectItemOfType('Profit Share','load_type')" name="load_type_label" id="load_type_label" >Profit Share</a><BR>
        <a href="#home" onclick="selectItemOfType('Rail','load_type')" name="load_type_label" id="load_type_label" >Rail</a><BR>
        <a href="#home" onclick="selectItemOfType('RPM','load_type')" name="load_type_label" id="load_type_label" >RPM</a><BR>
        <a href="#home" onclick="selectItemOfType('RMP-fsc','load_type')" name="load_type_label" id="load_type_label" >RMP-fsc</a><BR>
        <a href="#home" onclick="selectItemOfType('Tons','load_type')" name="load_type_label" id="load_type_label" >Tons</a><BR>
        <a href="#home" onclick="selectItemOfType('Not Used','load_type')" name="load_type_label" id="load_type_label" >Not Used</a><BR>
	</div>
        <div id="load_other_charge_div" name="load_other_charge_div" >
        <h2 class="modal-title" id="myModalLabel">Other Charges</h2>    
  		<div class="row">
	<div class="col-md-3" style="padding:5px;">	
            <div class='input-group date' id='datetimepicker6'>
            <span class="input-group-addon">
            <span class="glyphicon glyphicon-calendar"></span>
            </span>
            <input type='text' style="font-size: 14px; padding-left: 5px; padding-right: 2px;" class="form-control" id="new_other_charge_date" name="new_other_charge_date"  placeholder="Date">
            </div>      
        </div> 
	<div class="col-md-5" style="padding:5px;">  
		<div class="input-group">
	  <span class="input-group-addon" id="basic-addon1">Name</span>
	  <input type="text" class="form-control"  aria-describedby="basic-addon1"  name="new_other_charge_name" id="new_other_charge_name" value="" placeholder="Name">    
		</div>
        </div> 
	<div class="col-md-4" style="padding:5px;">
		<div class="input-group">
	  <span class="input-group-addon" id="basic-addon1">Amount</span>
	  <input type="text" class="form-control"  aria-describedby="basic-addon1"  name="new_other_charge_amount" id="new_other_charge_amount" value="" placeholder="">
		<span class="input-group-addon" id="basic-addon1"><span class="glyphicon glyphicon-plus" aria-hidden="true" onclick="addNewOtherCharge();" ></span></span>
		</div>
         </div>
        	</div> 
        
        <div id="load_charge_div_response" name="load_charge_div_response" >
            <%
            	if(request.getParameter("load_id")!=null){
		 try{

			Class.forName("com.mysql.jdbc.Driver");
			String url = "jdbc:mysql://localhost/test?user=<PASSWORD>&password=<PASSWORD>";


			Connection connection = DriverManager.getConnection(url,"<USERNAME>", "<PASSWORD>");

			PreparedStatement ps = connection.prepareStatement("select * from test.load_board_finance WHERE load_board_finance.COMPANY_ID = ? and load_id = ? and fin_type = ? order by ts desc");
			ps.setString(1, uuid);
			ps.setString(2, request.getParameter("load_id"));
			ps.setString(3, "Charge");
			ResultSet resultSet = ps.executeQuery();
			
			float total_fin = 0.0f;
			while (resultSet.next()) {
				String tmp_fin_date = "";
				if(resultSet.getTimestamp("fin_date")!=null){
				tmp_fin_date = new SimpleDateFormat("MM-dd-yyyy").format(resultSet.getTimestamp("fin_date"));
				}	
				total_fin = total_fin + resultSet.getFloat("fin_amount");
				%>  
				
  		<div class="row">
			<div class="col-md-3" style="padding:5px;">
			    <div class='input-group date' id='datetimepicker9900'>
			    <span class="input-group-addon">
			    <span class="glyphicon glyphicon-calendar"></span>
			    </span>
			    <input type='text' style="font-size: 14px; padding-left: 5px; padding-right: 2px;" class="form-control" id="new_advances_date<%=resultSet.getString("fin_id")%>" name="new_advances_date<%=resultSet.getString("fin_id")%>" value="<%=tmp_fin_date%>" placeholder="Date">
			    </div>  
			</div>
			<div class="col-md-5" style="padding:5px;">
            
				<div class="input-group">
			  <span class="input-group-addon" id="basic-addon1">Name</span>
		  <input type="text" class="form-control"  aria-describedby="basic-addon1"  name="new_advances_name<%=resultSet.getString("fin_id")%>" id="new_advances_name<%=resultSet.getString("fin_id")%>" value="<%=resultSet.getString("fin_name")%>" placeholder="Name">
				</div>
        		</div> 
			<div class="col-md-4" style="padding:5px;">  
				<div class="input-group">
  <span class="input-group-addon" id="basic-addon1">Amount</span>
  <input type="text" class="form-control"  aria-describedby="basic-addon1"  name="new_advances_amount<%=resultSet.getString("fin_id")%>" id="new_advances_amount<%=resultSet.getString("fin_id")%>" value="<%=resultSet.getString("fin_amount")%>" placeholder="" >
      	<span onclick="removeFin('<%=resultSet.getString("fin_id")%>','Charge')" class="input-group-addon" id="basic-addon1"><span class="glyphicon glyphicon-trash" aria-hidden="true"></span></span>
				</div>
			 </div>
        	</div>				
				<%
			}
			%>  		
			<div class="row">
			<div class="col-md-3" style="padding:5px;"></div>
			<div class="col-md-5" style="padding:5px;"><h3 class="pull-right">Total</h3></div>
			<div class="col-md-4" style="padding:5px;">
			<h3 class="pull-right"><%=total_fin%>&nbsp;</h3></div></div>
			<%
			connection.close();
		 }catch (Exception ex){
		     %><%="Error Posting " + ex%><%
		     System.out.println(""+ ex);
		 }
		 }
				%>            
        </div> 
        
        </div>
        <div id="load_bill_advances_div" name="load_bill_advances_div" >
        <h2 class="modal-title" id="myModalLabel">Customer Advances</h2>
  		<div class="row">
			<div class="col-md-3" style="padding:5px;">
			    <div class='input-group date' id='datetimepicker100'>
			    <span class="input-group-addon">
			    <span class="glyphicon glyphicon-calendar"></span>
			    </span>
			    <input type='text' style="font-size: 14px; padding-left: 5px; padding-right: 2px;" class="form-control" id="new_bill_advances_date" name="new_bill_advances_date"  placeholder="Date">
			    </div>  
			</div>
			<div class="col-md-5" style="padding:5px;">
            
				<div class="input-group">
			  <span class="input-group-addon" id="basic-addon1">Name</span>
		  <input type="text" class="form-control"  aria-describedby="basic-addon1"  name="new_bill_advances_name" id="new_bill_advances_name" value="" placeholder="Name">
				</div>
        		</div> 
			<div class="col-md-4" style="padding:5px;">  
				<div class="input-group">
  <span class="input-group-addon" id="basic-addon1">Amount</span>
  <input type="text" class="form-control"  aria-describedby="basic-addon1"  name="new_bill_advances_amount" id="new_bill_advances_amount" value="" placeholder="">
      	<span class="input-group-addon" id="basic-addon1"><span class="glyphicon glyphicon-plus" aria-hidden="true" onclick="addNewBillAdvances();" ></span></span>
				</div>
			 </div>
        	</div>
        
        <div id="load_bill_advances_div_response" name="load_bill_advances_div_response" >
<%
            	if(request.getParameter("load_id")!=null){
		 try{

			Class.forName("com.mysql.jdbc.Driver");
			String url = "jdbc:mysql://localhost/test?user=<PASSWORD>&password=<PASSWORD>";


			Connection connection = DriverManager.getConnection(url,"<USERNAME>", "<PASSWORD>");

			PreparedStatement ps = connection.prepareStatement("select * from test.load_board_finance WHERE load_board_finance.COMPANY_ID = ? and load_id = ? and fin_type = ? order by ts desc");
			ps.setString(1, uuid);
			ps.setString(2, request.getParameter("load_id"));
			ps.setString(3, "PayAdvance");
			ResultSet resultSet = ps.executeQuery();
			
			float total_fin = 0.0f;
			while (resultSet.next()) {
				String tmp_fin_date = "";
				if(resultSet.getTimestamp("fin_date")!=null){
				tmp_fin_date = new SimpleDateFormat("MM-dd-yyyy").format(resultSet.getTimestamp("fin_date"));
				}	
				total_fin = total_fin + resultSet.getFloat("fin_amount");
				%>  
				
  		<div class="row">
			<div class="col-md-3" style="padding:5px;">
			    <div class='input-group date' id='datetimepicker9900'>
			    <span class="input-group-addon">
			    <span class="glyphicon glyphicon-calendar"></span>
			    </span>
			    <input type='text' style="font-size: 14px; padding-left: 5px; padding-right: 2px;" class="form-control" id="new_advances_date<%=resultSet.getString("fin_id")%>" name="new_advances_date<%=resultSet.getString("fin_id")%>" value="<%=tmp_fin_date%>" placeholder="Date">
			    </div>  
			</div>
			<div class="col-md-5" style="padding:5px;">
            
				<div class="input-group">
			  <span class="input-group-addon" id="basic-addon1">Name</span>
		  <input type="text" class="form-control"  aria-describedby="basic-addon1"  name="new_advances_name<%=resultSet.getString("fin_id")%>" id="new_advances_name<%=resultSet.getString("fin_id")%>" value="<%=resultSet.getString("fin_name")%>" placeholder="Name">
				</div>
        		</div> 
			<div class="col-md-4" style="padding:5px;">  
				<div class="input-group">
  <span class="input-group-addon" id="basic-addon1">Amount</span>
  <input type="text" class="form-control"  aria-describedby="basic-addon1"  name="new_advances_amount<%=resultSet.getString("fin_id")%>" id="new_advances_amount<%=resultSet.getString("fin_id")%>" value="<%=resultSet.getString("fin_amount")%>" placeholder="" >
      	<span onclick="removeFin('<%=resultSet.getString("fin_id")%>','PayAdvance')" class="input-group-addon" id="basic-addon1"><span class="glyphicon glyphicon-trash" aria-hidden="true"></span></span>
				</div>
			 </div>
        	</div>				
				<%
			}
			%>  		
			<div class="row">
			<div class="col-md-3" style="padding:5px;"></div>
			<div class="col-md-5" style="padding:5px;"><h3 class="pull-right">Total</h3></div>
			<div class="col-md-4" style="padding:5px;">
			<h3 class="pull-right"><%=total_fin%>&nbsp;</h3></div></div>
			<%
			connection.close();
		 }catch (Exception ex){
		     %><%="Error Posting " + ex%><%
		     System.out.println(""+ ex);
		 }
		 }
				%>            
        </div>              
	</div>          
        <div id="load_advances_div" name="load_advances_div" >
        <h2 class="modal-title" id="myModalLabel">Fuel and Other Advances</h2>
  		<div class="row">
			<div class="col-md-3" style="padding:5px;">
			    <div class='input-group date' id='datetimepicker99'>
			    <span class="input-group-addon">
			    <span class="glyphicon glyphicon-calendar"></span>
			    </span>
			    <input type='text' style="font-size: 14px; padding-left: 5px; padding-right: 2px;" class="form-control" id="new_advances_date" name="new_advances_date"  placeholder="Date">
			    </div>  
			</div>
			<div class="col-md-5" style="padding:5px;">
            
				<div class="input-group">
			  <span class="input-group-addon" id="basic-addon1">Name</span>
		  <input type="text" class="form-control"  aria-describedby="basic-addon1"  name="new_advances_name" id="new_advances_name" value="" placeholder="Name">
				</div>
        		</div> 
			<div class="col-md-4" style="padding:5px;">  
				<div class="input-group">
  <span class="input-group-addon" id="basic-addon1">Amount</span>
  <input type="text" class="form-control"  aria-describedby="basic-addon1"  name="new_advances_amount" id="new_advances_amount" value="" placeholder="">
      	<span class="input-group-addon" id="basic-addon1"><span class="glyphicon glyphicon-plus" aria-hidden="true" onclick="addNewAdvances();" ></span></span>
				</div>
			 </div>
        	</div>
  		<div class="row">
			<div class="col-md-12" style="padding:5px;">
				<div class="input-group">
			  <span class="input-group-addon" id="basic-addon1">Note</span>
		  <input type="text" class="form-control"  aria-describedby="basic-addon1"  name="new_advances_name_note" id="new_advances_name_note" value="" placeholder="Notes">
				</div>
  			</div>
  		</div>
  		<div class="row">
			<div class="col-md-12" style="padding:5px;">
				<div class="input-group">
			  <span class="input-group-addon" id="basic-addon1">Code</span>
		  <input type="text" class="form-control"  aria-describedby="basic-addon1"  name="new_advances_name_notesms" id="new_advances_name_notesms" value="" placeholder="Sms Code">
				</div>
  			</div>
  		</div>
        
        <div id="load_advances_div_response" name="load_advances_div_response" >
            <%
            	if(request.getParameter("load_id")!=null){
		 try{

			Class.forName("com.mysql.jdbc.Driver");
			String url = "jdbc:mysql://localhost/test?user=<PASSWORD>&password=<PASSWORD>";


			Connection connection = DriverManager.getConnection(url,"<USERNAME>", "<PASSWORD>");

			PreparedStatement ps = connection.prepareStatement("select * from test.load_board_finance WHERE load_board_finance.COMPANY_ID = ? and load_id = ? and fin_type = ? order by ts desc");
			ps.setString(1, uuid);
			ps.setString(2, request.getParameter("load_id"));
			ps.setString(3, "Advance");
			ResultSet resultSet = ps.executeQuery();
			
			float total_fin = 0.0f;
			while (resultSet.next()) {
				String tmp_fin_date = "";
				if(resultSet.getTimestamp("fin_date")!=null){
				tmp_fin_date = new SimpleDateFormat("MM-dd-yyyy").format(resultSet.getTimestamp("fin_date"));
				}	
				total_fin = total_fin + resultSet.getFloat("fin_amount");
				%>  
				
  		<div class="row">
			<div class="col-md-3" style="padding:5px;">
			    <div class='input-group date' id='datetimepicker9900'>
			    <span class="input-group-addon">
			    <span class="glyphicon glyphicon-calendar"></span>
			    </span>
			    <input type='text' style="font-size: 14px; padding-left: 5px; padding-right: 2px;" class="form-control" id="new_advances_date<%=resultSet.getString("fin_id")%>" name="new_advances_date<%=resultSet.getString("fin_id")%>" value="<%=tmp_fin_date%>" placeholder="Date">
			    </div>  
			</div>
			<div class="col-md-5" style="padding:5px;">
            
				<div class="input-group">
			  <span class="input-group-addon" id="basic-addon1">Name</span>
		  <input type="text" class="form-control"  aria-describedby="basic-addon1"  name="new_advances_name<%=resultSet.getString("fin_id")%>" id="new_advances_name<%=resultSet.getString("fin_id")%>" value="<%=resultSet.getString("fin_name")%>" placeholder="Name">
				</div>
        		</div> 
			<div class="col-md-4" style="padding:5px;">  
				<div class="input-group">
  <span class="input-group-addon" id="basic-addon1">Amount</span>
  <input type="text" class="form-control"  aria-describedby="basic-addon1"  name="new_advances_amount<%=resultSet.getString("fin_id")%>" id="new_advances_amount<%=resultSet.getString("fin_id")%>" value="<%=resultSet.getString("fin_amount")%>" placeholder="" >
      	<span onclick="removeFin('<%=resultSet.getString("fin_id")%>','Advance')" class="input-group-addon" id="basic-addon1"><span class="glyphicon glyphicon-trash" aria-hidden="true"></span></span>
				</div>
			 </div>
        	</div>
        	<%if(resultSet.getString("fin_name_note") !=null && !resultSet.getString("fin_name_note").equals("")){%>
  		<div class="row">
			<div class="col-md-12" style="padding:5px;"> 
			<input type="text" class="form-control"  aria-describedby="basic-addon1"  name="new_advances_name_note<%=resultSet.getString("fin_id")%>" id="new_advances_name_note<%=resultSet.getString("fin_id")%>" value="<%=resultSet.getString("fin_name_note")%>" placeholder="Note">			
			 </div>
        	</div>		
        	<%}%>
        	<%if(resultSet.getString("fin_name_notesms") !=null && !resultSet.getString("fin_name_notesms").equals("")){%>
  		<div class="row">
			<div class="col-md-12" style="padding:5px;">
			<input type="text" class="form-control"  aria-describedby="basic-addon1"  name="new_advances_name_notesms<%=resultSet.getString("fin_id")%>" id="new_advances_name_notesms<%=resultSet.getString("fin_id")%>" value="<%=resultSet.getString("fin_name_notesms")%>" placeholder="SMS Code">			
			
			 </div>
        	</div>		
        	<%}%>        	
				<%
			}
			%>  		
			<div class="row">
			<div class="col-md-3" style="padding:5px;"></div>
			<div class="col-md-5" style="padding:5px;"><h3 class="pull-right">Total</h3></div>
			<div class="col-md-4" style="padding:5px;">
			<h3 class="pull-right"><%=total_fin%>&nbsp;</h3></div></div>
			<%
			connection.close();
		 }catch (Exception ex){
		     %><%="Error Posting " + ex%><%
		     System.out.println(""+ ex);
		 }
		 }
				%>        
        </div>          
	</div>        
        <div id="load_fees_div" name="load_fees_div" >
        <h2 class="modal-title" id="myModalLabel">Other Fees</h2>
  		<div class="row">
			<div class="col-md-3" style="padding:5px;">
			    <div class='input-group date' id='datetimepicker2'>
			    <span class="input-group-addon">
			    <span class="glyphicon glyphicon-calendar"></span>
			    </span>
			    <input type='text' style="font-size: 14px; padding-left: 5px; padding-right: 2px;" class="form-control" id="new_fee_date" name="new_fee_date"  placeholder="Date">
			    </div>  
			</div>
			<div class="col-md-5" style="padding:5px;">
            
				<div class="input-group">
			  <span class="input-group-addon" id="basic-addon1">Name</span>
		  <input type="text" class="form-control"  aria-describedby="basic-addon1"  name="new_fee_name" id="new_fee_name" value="" placeholder="Name">
				</div>
        		</div> 
			<div class="col-md-4" style="padding:5px;">  
				<div class="input-group">
  <span class="input-group-addon" id="basic-addon1">Amount</span>
  <input type="text" class="form-control"  aria-describedby="basic-addon1"  name="new_fee_amount" id="new_fee_amount" value="" placeholder="">
      	<span class="input-group-addon" id="basic-addon1"><span class="glyphicon glyphicon-plus" aria-hidden="true" onclick="addNewFee();" ></span></span>
				</div>
			 </div>
        	</div>
        
        <div id="load_fees_div_response" name="load_fees_div_response" >
            <%
            	if(request.getParameter("load_id")!=null){
		 try{

			Class.forName("com.mysql.jdbc.Driver");
			String url = "jdbc:mysql://localhost/test?user=<PASSWORD>&password=<PASSWORD>";


			Connection connection = DriverManager.getConnection(url,"<USERNAME>", "<PASSWORD>");

			PreparedStatement ps = connection.prepareStatement("select * from test.load_board_finance WHERE load_board_finance.COMPANY_ID = ? and load_id = ? and fin_type = ? order by ts desc");
			ps.setString(1, uuid);
			ps.setString(2, request.getParameter("load_id"));
			ps.setString(3, "Fee");
			ResultSet resultSet = ps.executeQuery();
			
			float total_fin = 0.0f;
			while (resultSet.next()) {
				String tmp_fin_date = "";
				if(resultSet.getTimestamp("fin_date")!=null){
				tmp_fin_date = new SimpleDateFormat("MM-dd-yyyy").format(resultSet.getTimestamp("fin_date"));
				}	
				total_fin = total_fin + resultSet.getFloat("fin_amount");
				%>  
				
  		<div class="row">
			<div class="col-md-3" style="padding:5px;">
			    <div class='input-group date' id='datetimepicker9900'>
			    <span class="input-group-addon">
			    <span class="glyphicon glyphicon-calendar"></span>
			    </span>
			    <input type='text' style="font-size: 14px; padding-left: 5px; padding-right: 2px;" class="form-control" id="new_advances_date<%=resultSet.getString("fin_id")%>" name="new_advances_date<%=resultSet.getString("fin_id")%>" value="<%=tmp_fin_date%>" placeholder="Date">
			    </div>  
			</div>
			<div class="col-md-5" style="padding:5px;">
            
				<div class="input-group">
			  <span class="input-group-addon" id="basic-addon1">Name</span>
		  <input type="text" class="form-control"  aria-describedby="basic-addon1"  name="new_advances_name<%=resultSet.getString("fin_id")%>" id="new_advances_name<%=resultSet.getString("fin_id")%>" value="<%=resultSet.getString("fin_name")%>" placeholder="Name">
				</div>
        		</div> 
			<div class="col-md-4" style="padding:5px;">  
				<div class="input-group">
  <span class="input-group-addon" id="basic-addon1">Amount</span>
  <input type="text" class="form-control"  aria-describedby="basic-addon1"  name="new_advances_amount<%=resultSet.getString("fin_id")%>" id="new_advances_amount<%=resultSet.getString("fin_id")%>" value="<%=resultSet.getString("fin_amount")%>" placeholder="" >
      	<span onclick="removeFin('<%=resultSet.getString("fin_id")%>','Fee')" class="input-group-addon" id="basic-addon1"><span class="glyphicon glyphicon-trash" aria-hidden="true"></span></span>
				</div>
			 </div>
        	</div>				
				<%
			}
			%>  		
			<div class="row">
			<div class="col-md-3" style="padding:5px;"></div>
			<div class="col-md-5" style="padding:5px;"><h3 class="pull-right">Total</h3></div>
			<div class="col-md-4" style="padding:5px;">
			<h3 class="pull-right"><%=total_fin%>&nbsp;</h3></div></div>
			<%
			connection.close();
		 }catch (Exception ex){
		     %><%="Error Posting " + ex%><%
		     System.out.println(""+ ex);
		 }
		 }
				%>            
        </div>      
        </div>      
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
      </div>
    </div>
  </div>
</div>		

	<BR>

	 <%if(request.getParameter("load_id")!=null){%>
		  <input type="hidden" id="load_id" name="load_id" value="<%=request.getParameter("load_id")%>" />
	 <%}else{%>
		  <input type="hidden" id="load_id" name="load_id" value="<%=UUID.randomUUID() +""%>" />
	 <%}%>
	 	   <ul class="nav nav-tabs" id="shipper_nav" name="shipper_nav" >	
		<%
			String ship_to_old = "";
			String ship_to_old_id = "";
			String ship_to_old_address = "";
			String customes_to_old = "";
			String customes_to_old_id = "";
			String customes_to_old_address = "";
			String ship_date_old = "";
			String ship_time_old = "8:00";
			String ship_des = "";
			String ship_type = "";
			String ship_qt = "";
			String ship_wt = "";
			String ship_note = "";
			String ship_po = "";
			String ship_current_line_id = "";
			
	 	
		if(request.getParameter("load_id")!=null){
			try{
				String responseText = "";
				Class.forName("com.mysql.jdbc.Driver");
				String url = "jdbc:mysql://localhost/test?zeroDateTimeBehavior=convertToNull";
				Connection connection = DriverManager.getConnection(url,"<USERNAME>", "<PASSWORD>");
				PreparedStatement psMain = connection.prepareStatement("select * from test.locations right join test.load_board_line on locations.location_id=load_board_line.shipper_id left join test.locations as customs on load_board_line.customs_id=customs.location_id WHERE load_board_line.COMPANY_ID = ? and load_id = ? order by load_board_line.ts asc");
				psMain.setString(1, uuid);
				psMain.setString(2, request.getParameter("load_id"));
				ResultSet resultSet = psMain.executeQuery();
				int shipCount = 0;
				while (resultSet.next()) {
					String tab_label = "New";
					shipCount += 1;
					if(resultSet.getString("shipper_id")!=null && !resultSet.getString("shipper_id").equals("")){
						tab_label = resultSet.getString("org_name");
					}	
						if(shipCount==1){
							ship_to_old_id = NullCheck.check(resultSet.getString("location_id"));
							ship_to_old = NullCheck.check(resultSet.getString("org_name"));
							ship_to_old_address = NullCheck.check(resultSet.getString("address"));
							customes_to_old_id = NullCheck.check(resultSet.getString("customs.location_id"));
							customes_to_old = NullCheck.check(resultSet.getString("customs.org_name"));
							customes_to_old_address = NullCheck.check(resultSet.getString("customs.address"));
							ship_type = resultSet.getString("type");
							ship_current_line_id = resultSet.getString("load_line_id");
							//ship_date_old ;
							//ship_time_old;
							if(resultSet.getTimestamp("pickup_date")!=null){
								ship_date_old = new SimpleDateFormat("MM-dd-yyyy").format(resultSet.getTimestamp("pickup_date"));
								ship_time_old = new SimpleDateFormat("HH:mm").format(resultSet.getTimestamp("pickup_date"));
							}												
							ship_qt = resultSet.getString("units");
							ship_wt = resultSet.getString("weight");
							ship_note = NullCheck.check(resultSet.getString("load_board_line.notes"));
							ship_po = resultSet.getString("po_numbers");
							ship_des = resultSet.getString("description");
						}
					if(shipCount==1){					
						responseText = responseText + "<li class=\"active\" ><a href=\"#home\" onclick=\"viewShipper('" + resultSet.getString("load_line_id")+ "')\">" +tab_label + "</a></li>"; 
					}else{
						responseText = responseText + "<li ><a href=\"#home\" onclick=\"viewShipper('" + resultSet.getString("load_line_id")+ "')\">" +tab_label + "</a></li>"; 
					}
				}
				%><%=responseText%><%
				if(shipCount==0){
				   %><li class="active"><a data-toggle="tab" href="#home">New</a></li><%
				}
				%>
				<li><a data-toggle="tab" href="#menu1" onclick="addShipper()"><span class="glyphicon glyphicon-plus" ></span></a></li>
				  <input type="hidden" value="<%=shipCount%>" id="shipper_count" name="shipper_count" />
				<%
				connection.close();
			 }catch (Exception ex){
			     %><%="Error Posting " + ex%><%
			     System.out.println(""+ ex);
			 }
	         }else{%>
			  <input type="hidden" value="0" id="shipper_count" name="shipper_count" />	
			  <li class="active"><a data-toggle="tab" href="#home">New</a></li>
			  <li><a data-toggle="tab" href="#menu1" onclick="addShipper()" ><span class="glyphicon glyphicon-plus" ></span></a></li>         
	         <%}%>
	         	</ul>	
	
	<div id="ship_panel" name="ship_panel" style="display:inline;" >
	<div class="form-wrapper">
 	  <%if(!ship_current_line_id.equals("")){%>
		  <input type="hidden" value="<%=ship_current_line_id%>" id="current_line_id" name="current_line_id" />
		  <input type="hidden" value="<%=ship_current_line_id%>" id="ship_line_id" name="ship_line_id" />
 	  <%}%>
	
	  <input type="hidden" <%if(ship_to_old_id != null && !ship_to_old_id.equals("")){%>value="<%=ship_to_old_id%>"<%}%> id="current_ship_22_id" name="current_ship_22_id"  autocomplete="off"  />
	  <input type="hidden" value="<%=customes_to_old_id%>" id="current_customs_broker_id" name="current_customs_broker_id" />
	  <input type="hidden" value="<%=customes_to_old_address%>" id="customs_broker_address" name="customs_broker_address" />




	<div class="row">
		<div class="col-md-3">
		<div class="form-group">
		<label>Shipper <a data-toggle="tab" href="#menu1" onclick="addShipperInfo()" ><span class="glyphicon glyphicon-plus-sign" ></span></a></label>
		<input type="text" class="form-control" name="ship_22" id="ship_22" value="<%=ship_to_old%>" placeholder="James Franco Shipping, Inc." autocomplete="off"  onblur="getLocationByName(document.getElementById('ship_22').value, document.getElementById('ship_22').name)" onkeypress="searchLocationByName(document.getElementById('ship_22').value, document.getElementById('ship_22').name, 'Shipping')"  >
		</div>
		</div>

		<div class="col-md-3">
		<div class="form-group">
		<label>Location</label>
		<input type="text" class="form-control" name="ship_22_address" id="ship_22_address" value="<%=ship_to_old_address%>" placeholder="123 Vanport St.">
		</div>
		</div>

		<div class="col-md-2">
		<div class="form-group">
		<label>Date</label>
		<div class='input-group date' id='datetimepicker1'>
		<span class="input-group-addon">
		<span class="glyphicon glyphicon-calendar"></span>
		</span>
		<input type='text' value="<%=ship_date_old%>" style="font-size: 14px; padding-left: 5px; padding-right: 2px;" class="form-control" id="pickup_date" name="pickup_date"  placeholder="Date">
		</div>
		</div>
		</div>

		<div class="col-md-2">
		<div class="form-group">
		<label>Show Time</label>

		<div class='input-group date' id='datetimepicker3'>
		<span class="input-group-addon"><span class="glyphicon glyphicon-time" aria-hidden="true"></span></span>
		<input type="text" value="<%=ship_time_old%>" class="form-control"  aria-describedby="basic-addon1" id="pickup_time" name="pickup_time" value="08:00" style="font-size: 14px; padding-left: 5px; padding-right: 2px;">
		</div>

		</div>
		</div>
	</div>




	<div class="row">
	<div class="col-md-3">
	<div class="form-group">
	<label>Description </label>
	<input type="text" class="form-control" name="ship_description" id="ship_description" value="<%=ship_des%>" placeholder="" >
	</div>
	</div>

	<div class="col-md-3">
	<div class="form-group">
	<label>Type</label>
	<input type="text" class="form-control" name="ship_type" id="ship_type" value="<%=ship_type%>" placeholder="TL,LTL, Pallets, etc.">
	</div>
	</div>

	<div class="col-md-2">
	<div class="form-group">
	<label>Quantity</label>
	<input type="text" class="form-control" name="ship_units" id="ship_units" value="<%=ship_qt%>" placeholder="">
	</div>
	</div>

	<div class="col-md-2">
	<div class="form-group">
	<label>Weight (lb)</label>
	<input type="text" class="form-control" name="ship_weight" id="ship_weight"  value="<%=ship_wt%>" placeholder="" >
	</div>
	</div>

	</div>


	<div class="row">
	<div class="col-md-3">
	<div class="form-group">
	<label>Notes </label>
	<input type="text" class="form-control" name="ship_note" id="ship_note" value="<%=ship_note%>" placeholder="" >
	</div>
	</div>

	<div class="col-md-3">
	<div class="form-group">
	<label>P.O. Numbers</label>
	<input type="text" class="form-control" name="ship_po" id="ship_po" value="<%=ship_po%>" placeholder="P.O. 123">
	</div>
	</div>
	<div class="col-md-2">
	<div class="form-group">
	<label>Customes Broker <a data-toggle="tab" href="#menu1" onclick="addCustomsInfo()" ><span class="glyphicon glyphicon-plus-sign" ></span></a></label>
	
	<input type="text" class="form-control" value="<%=customes_to_old%>" name="customs_broker" id="customs_broker" autocomplete="off"  
	onblur="getLocationByName(document.getElementById('customs_broker').value, document.getElementById('customs_broker').name)" 
	onkeypress="searchLocationByName(document.getElementById('customs_broker').value, document.getElementById('customs_broker').name , 'Customs')"  >
	</div>
	</div>

	</div>

	<div class="row">
	<div class="col-md-12" style="padding:15px;"><a href="#" onclick="removeShipper();"><span class="glyphicon glyphicon-trash pull-right" ></span></a></div>

		</div>
		<!-- end of form-wrapper-->
		</div>
	</div>

	<div id="ship_panel_add" name="ship_panel_add" style="display:none;" >
	<input type="hidden"  id="location_type" name="location_type" value="Shipping" />	
 	<div class="col-md-6" style="padding:5px;">
<div class="input-group">
  <span class="input-group-addon" id="basic-addon1"><span class="glyphicon glyphicon-pencil" ></span></span>
	<input type="text" class="form-control" id="ship_name_add" name="ship_name_add" placeholder="Business\Organization Name" value="" />	
</div>   
	</div>     
	<div class="col-md-2" style="padding:5px;">
<div class="input-group">
  <span class="input-group-addon" id="basic-addon1"><span class="glyphicon glyphicon-phone" ></span></span>
	<input type="text" class="form-control" id="ship_phone_add" name="ship_phone_add" placeholder="Phone" value="" />	
</div>   
	</div>     
	<div class="col-md-4" style="padding:5px;">
<div class="input-group">
  <span class="input-group-addon" id="basic-addon1"><span class="glyphicon glyphicon-envelope" ></span></span>
	<input type="text" class="form-control" id="ship_email_add" name="ship_email_add" placeholder="Email" value="" />	
</div>   
	</div>  
	
	<div class="col-md-6" style="padding:5px;">
<div class="input-group">
  <span class="input-group-addon" id="basic-addon1"><span class="glyphicon glyphicon-pencil" ></span></span>
	<input type="text" class="form-control" id="ship_contact_name_add" name="ship_contact_name_add" placeholder="Contact Name" value="" />	
</div>   
	</div>     
	<div class="col-md-2" style="padding:5px;">
<div class="input-group">
  <span class="input-group-addon" id="basic-addon1"><span class="glyphicon glyphicon-phone" ></span></span>
	<input type="text" class="form-control" id="ship_contact_phone_add" name="ship_contact_phone_add" placeholder="Phone" value="" />	
</div>   
	</div>     
	<div class="col-md-4" style="padding:5px;">
<div class="input-group">
  <span class="input-group-addon" id="basic-addon1"><span class="glyphicon glyphicon-envelope" ></span></span>
	<input type="text" class="form-control" id="ship_contact_email_add" name="ship_contact_email_add" placeholder="Email" value="" />	
</div>   
	</div>     
 	
	<div class="col-md-12" style="padding:5px;">
<div class="input-group">
  <span class="input-group-addon" id="basic-addon1"><span class="glyphicon glyphicon-globe" ></span>
  </span>
    <input type="hidden" name="pickCity_lat" id="pickCity_lat" value="" />
    <input type="hidden" name="pickCity_lng" id="pickCity_lng" value="" />
    <input type="hidden" name="pickCity" id="pickCity" value="">
    <input type="hidden" name="pickState" id="pickState" value="">
	<input type="text" class="form-control" id="pac-input" name="pac-input" placeholder="City" value="" />
		

</div>   
	</div>     

	<div class="col-md-12" style="padding:5px;">
<div class="input-group">
    <span class="input-group-addon" id="basic-addon1"><span class="glyphicon glyphicon-flag" ></span></span>
    <input type="text" class="form-control" placeholder="Address" id="pickup_address_add" name="pickup_address_add" aria-describedby="basic-addon1" onkeypress="autocompleteLocationName(document.getElementById('pickup_address_add').value, document.getElementById('pickup_address_add').name, 'pickCity')" autocomplete="off" >

	<span id="pickup_address_addSPN" name="pickup_address_addSPN" style="border-color:#262626;border-width: 1px;font-size:1.0em;width:80%;"></span>
</div>
	<input type="hidden" name="pickup_address_add_lat" id="pickup_address_add_lat" value="" />
	<input type="hidden" name="pickup_address_add_lng" id="pickup_address_add_lng" value="" />
	</div>
	
	<div class="col-md-12" style="padding:5px;">
<div class="input-group">
  <span class="input-group-addon" id="basic-addon1"><span class="glyphicon glyphicon-flag" ></span>
  </span>
	<input type="text" class="form-control" id="ship_address2_add" name="ship_address2_add" placeholder="Address Line 2" value="" />	

</div>   
	</div>
	<div class="col-md-12" style="padding:5px;">
<div class="input-group">
  <span class="input-group-addon" id="basic-addon1"><span class="glyphicon glyphicon-pencil" ></span>
  </span>
	<input type="text" class="form-control" id="ship_notes_add" name="ship_notes_add" placeholder="Notes" value="" />	

</div>   
	</div>



	<div class="row">
	<div class="col-md-12" style="padding:15px;">
	<button type="button" class="btn btn-success" onclick="saveNewShipper();" ><span class="glyphicon glyphicon-save" aria-hidden="true"></span>SAVE</button>

	<a href="#"  onclick="addShipperInfoCancel();"><span class="glyphicon glyphicon-trash pull-right" ></span></a></div>

	</div>

	</div>


	<ul class="nav nav-tabs" id="consignee_nav" name="consignee_nav">
		<%
			String consignee_to_old = "";
			String consignee_to_old_id = "";
			String consignee_id = "";
			String consignee_to_old_address = "";
			String consignee_date_old = "";
			String consignee_time_old = "8:00";
			String consignee_des = "";
			String consignee_type = "";
			String consignee_qt = "";
			String consignee_wt = "";
			String consignee_note = "";
			String consignee_po = "";
			
	 	
		if(request.getParameter("load_id")!=null){
			try{
				String responseText = "";
				Class.forName("com.mysql.jdbc.Driver");
				String url = "jdbc:mysql://localhost/test?zeroDateTimeBehavior=convertToNull";
				Connection connection = DriverManager.getConnection(url,"<USERNAME>", "<PASSWORD>");
				PreparedStatement psMain = connection.prepareStatement("select * from test.locations right join test.load_board_line_consignee on locations.location_id=load_board_line_consignee.consignee_id WHERE load_board_line_consignee.COMPANY_ID = ? and load_id = ? order by load_board_line_consignee.ts asc");
				psMain.setString(1, uuid);
				psMain.setString(2, request.getParameter("load_id"));
				ResultSet resultSet = psMain.executeQuery();
				int shipCount = 0;
				while (resultSet.next()) {
					String tab_label = "New";
					shipCount += 1;
					if(resultSet.getString("consignee_id")!=null && !resultSet.getString("consignee_id").equals("")){
						tab_label = resultSet.getString("org_name");
					}
					if(shipCount==1){
							consignee_id = resultSet.getString("load_line_id");
							consignee_to_old_id = NullCheck.check(resultSet.getString("location_id"));
							consignee_to_old = NullCheck.check(resultSet.getString("org_name"));
							consignee_to_old_address = NullCheck.check(resultSet.getString("address"));
							consignee_type = resultSet.getString("type");
							//ship_date_old ;
							//ship_time_old;
							if(resultSet.getTimestamp("pickup_date")!=null){
								consignee_date_old = new SimpleDateFormat("MM-dd-yyyy").format(resultSet.getTimestamp("pickup_date"));
								consignee_time_old = new SimpleDateFormat("HH:mm").format(resultSet.getTimestamp("pickup_date"));
							}												
							consignee_qt = resultSet.getString("units");
							consignee_wt = resultSet.getString("weight");
							consignee_note = NullCheck.check(resultSet.getString("load_board_line_consignee.notes"));
							consignee_po = resultSet.getString("po_numbers");
							consignee_des = resultSet.getString("description");
					}	
					
					if(shipCount==1){
						responseText = responseText + "<li class=\"active\" ><a href=\"#home\" onclick=\"viewConsignee('" + resultSet.getString("load_line_id")+ "')\">" +tab_label + "</a></li>"; 
					}else{
						responseText = responseText + "<li ><a href=\"#home\" onclick=\"viewConsignee('" + resultSet.getString("load_line_id")+ "')\">" +tab_label + "</a></li>"; 
					}
				}
				%><%=responseText%><%
				if(shipCount==0){
				   %><li class="active"><a data-toggle="tab" href="#home">New</a></li><%
				}
				%>
				  <input type="hidden" value="<%=shipCount%>" id="consignee_count" name="consignee_count" />				
				  <li><a data-toggle="tab" href="#menu1" onclick="addConsignee()" ><span class="glyphicon glyphicon-plus" ></span></a></li>
				<%
				connection.close();
			 }catch (Exception ex){
			     %><%="Error Posting " + ex%><%
			     System.out.println(""+ ex);
			 }
	         }else{%>
			  <input type="hidden" value="0" id="consignee_count" name="consignee_count" />
			  <li class="active"><a data-toggle="tab" href="#home">New</a></li>
			  <li><a data-toggle="tab" href="#menu1" onclick="addConsignee()" ><span class="glyphicon glyphicon-plus" ></span></a></li>
	         <%}%>
	         	</ul>			
 	<div id="consignee_panel" name="consignee_panel" style="display:inline;" >
		<div class="form-wrapper">
			  <%if(!consignee_id.equals("")){%>
			<input type="hidden" <%if(!consignee_id.equals("")){%>value="<%=consignee_id%>"<%}%> id="current_consignee_line_id" name="current_consignee_line_id" />
			<input type="hidden" <%if(!consignee_id.equals("")){%>value="<%=consignee_id%>"<%}%> id="consignee_line_id" name="consignee_line_id" />
			  <%}%>
			  <input type="hidden" <%if(consignee_to_old_id != null && !consignee_to_old_id.equals("")){%>value="<%=consignee_to_old_id%>"<%}%> id="current_consignee_22_id" name="current_consignee_22_id" />
			  <input type="hidden" <%if(consignee_to_old_id != null && !consignee_to_old_id.equals("")){%>value="<%=consignee_to_old_id%>""<%}%> id="consignee_22_id" name="consignee_22_id" />

			<div class="row">
			<div class="col-md-3">
			<div class="form-group">
			<label>Consignee <a data-toggle="tab" href="#menu1" onclick="addConsigneeInfo()" ><span class="glyphicon glyphicon-plus-sign" ></span></a></label>
			<input type="text" class="form-control" name="consignee_22" id="consignee_22" value="<%=consignee_to_old%>" placeholder="James Franco Consignee, Inc." autocomplete="off"  onblur="getLocationByName(document.getElementById('consignee_22').value, document.getElementById('consignee_22').name)" onkeypress="searchLocationByName(document.getElementById('consignee_22').value, document.getElementById('consignee_22').name, 'Consignee')"  >
			</div>
			</div>

			<div class="col-md-3">
			<div class="form-group">
			<label>Location</label>
			<input type="text" class="form-control" name="consignee_22_address" id="consignee_22_address" value="<%=consignee_to_old_address%>" placeholder="123 Vanport St.">
			</div>
			</div>

			<div class="col-md-2">
			<div class="form-group">
			<label>Date</label>
			<div class='input-group date' id='datetimepicker7'>
			<span class="input-group-addon">
			<span class="glyphicon glyphicon-calendar"></span>
			</span>
			<input type='text' style="font-size: 14px; padding-left: 5px; padding-right: 2px;" class="form-control" id="consigneepickup_date" name="consigneepickup_date" value="<%=consignee_date_old%>"  placeholder="Date">
			</div>
			</div>
			</div>

			<div class="col-md-2">
			<div class="form-group">
			<label>Show Time</label>

			<div class='input-group date' id='datetimepicker4'>
			<span class="input-group-addon"><span class="glyphicon glyphicon-time" aria-hidden="true"></span></span>
			<input type="text" class="form-control"  aria-describedby="basic-addon1" id="consigneepickup_time" name="consigneepickup_time" value="<%=consignee_time_old%>" style="font-size: 14px; padding-left: 5px; padding-right: 2px;">
			</div>

			</div>
			</div>

			</div>



			<div class="row">
			<div class="col-md-3">
			<div class="form-group">
			<label>Description </label>
			<input type="text" class="form-control" name="consignee_description" id="consignee_description" value="<%=consignee_des%>" placeholder="" >
			</div>
			</div>

			<div class="col-md-3">
			<div class="form-group">
			<label>Type</label>
			<input type="text" class="form-control" name="consignee_type" id="consignee_type" value="<%=consignee_type%>" placeholder="TL,LTL, Pallets, etc.">
			</div>
			</div>

			<div class="col-md-2">
			<div class="form-group">
			<label>Quantity</label>
			<input type="text" class="form-control" name="consignee_units" id="consignee_units" value="<%=consignee_qt%>" placeholder="">
			</div>
			</div>

			<div class="col-md-2">
			<div class="form-group">
			<label>Weight (lb)</label>
			<input type="text" class="form-control" name="consignee_weight" id="consignee_weight" value="<%=consignee_wt%>" placeholder="" >
			</div>
			</div>

			</div>


			<div class="row">
			<div class="col-md-3">
			<div class="form-group">
			<label>Delivery Notes </label>
			<input type="text" class="form-control" name="consignee_note" id="consignee_note" value="<%=consignee_note%>" placeholder="" >
			</div>
			</div>

			<div class="col-md-3">
			<div class="form-group">
			<label>P.O. Numbers</label>
			<input type="text" class="form-control" name="consignee_po" id="consignee_po" value="<%=consignee_po%>" placeholder="PO123">
			</div>
			</div>

			</div>



			<div class="row">
			<div class="col-md-12" style="padding:15px;"><a href="#"  onclick="removeConsignee();"><span class="glyphicon glyphicon-trash pull-right" ></span></a></div>

			</div>

		 </div>
	</div>

 	<div id="consignee_panel_add" name="consignee_panel_add" style="display:none;" >
 	<div class="col-md-6" style="padding:5px;">
<div class="input-group">
  <span class="input-group-addon" id="basic-addon1"><span class="glyphicon glyphicon-pencil" ></span></span>
	<input type="text" class="form-control" id="consignee_name_add" name="consignee_name_add" placeholder="Business\Organization Name" value="" />	
</div>   
	</div>     
	<div class="col-md-2" style="padding:5px;">
<div class="input-group">
  <span class="input-group-addon" id="basic-addon1"><span class="glyphicon glyphicon-phone" ></span></span>
	<input type="text" class="form-control" id="consignee_phone_add" name="consignee_phone_add" placeholder="Phone" value="" />	
</div>   
	</div>     
	<div class="col-md-4" style="padding:5px;">
<div class="input-group">
  <span class="input-group-addon" id="basic-addon1"><span class="glyphicon glyphicon-envelope" ></span></span>
	<input type="text" class="form-control" id="consignee_email_add" name="consignee_email_add" placeholder="Email" value="" />	
</div>   
	</div>  
	
	<div class="col-md-6" style="padding:5px;">
<div class="input-group">
  <span class="input-group-addon" id="basic-addon1"><span class="glyphicon glyphicon-pencil" ></span></span>
	<input type="text" class="form-control" id="consignee_contact_name_add" name="consignee_contact_name_add" placeholder="Contact Name" value="" />	
</div>   
	</div>     
	<div class="col-md-2" style="padding:5px;">
<div class="input-group">
  <span class="input-group-addon" id="basic-addon1"><span class="glyphicon glyphicon-phone" ></span></span>
	<input type="text" class="form-control" id="consignee_contact_phone_add" name="consignee_contact_phone_add" placeholder="Phone" value="" />	
</div>   
	</div>     
	<div class="col-md-4" style="padding:5px;">
<div class="input-group">
  <span class="input-group-addon" id="basic-addon1"><span class="glyphicon glyphicon-envelope" ></span></span>
	<input type="text" class="form-control" id="consignee_contact_email_add" name="consignee_contact_email_add" placeholder="Email" value="" />	
</div>   
	</div>     
 	
	<div class="col-md-12" style="padding:5px;">
<div class="input-group">
  <span class="input-group-addon" id="basic-addon1"><span class="glyphicon glyphicon-globe" ></span>
  </span>
    <input type="hidden" name="consigneepickCity_lat" id="consigneepickCity_lat" value="" />
    <input type="hidden" name="consigneepickCity_lng" id="consigneepickCity_lng" value="" />
    <input type="hidden" name="consigneepickCity" id="consigneepickCity" value="">
    <input type="hidden" name="consigneepickState" id="consigneepickState" value="">
	<input type="text" class="form-control" id="pac-input6" name="pac-input6" placeholder="City" value="" />
		

</div>   
	</div>     

	<div class="col-md-12" style="padding:5px;">
<div class="input-group">
    <span class="input-group-addon" id="basic-addon1"><span class="glyphicon glyphicon-flag" ></span></span>
    <input type="text" class="form-control" placeholder="Address" id="consigneepickup_address_add" name="consigneepickup_address_add" aria-describedby="basic-addon1" onkeypress="autocompleteLocationName(document.getElementById('consigneepickup_address_add').value, document.getElementById('consigneepickup_address_add').name, 'consigneepickCity')" autocomplete="off" >

	<span id="consigneepickup_address_addSPN" name="pickup_address_addSPN" style="border-color:#262626;border-width: 1px;font-size:1.0em;width:80%;"></span>
</div>
	<input type="hidden" name="consigneepickup_address_add_lat" id="consigneepickup_address_add_lat" value="" />
	<input type="hidden" name="consigneepickup_address_add_lng" id="consigneepickup_address_add_lng" value="" />
	</div>
	
	<div class="col-md-12" style="padding:5px;">
<div class="input-group">
  <span class="input-group-addon" id="basic-addon1"><span class="glyphicon glyphicon-flag" ></span>
  </span>
	<input type="text" class="form-control" id="consignee_address2_add" name="consignee_address2_add" placeholder="Address Line 2" value="" />	

</div>   
	</div>
	<div class="col-md-12" style="padding:5px;">
<div class="input-group">
  <span class="input-group-addon" id="basic-addon1"><span class="glyphicon glyphicon-pencil" ></span>
  </span>
	<input type="text" class="form-control" id="consignee_notes_add" name="consignee_notes_add" placeholder="Notes" value="" />	

</div>   
	</div>
	
	<div class="col-md-12" style="padding:5px;">
      <button type="button" class="btn btn-success" onclick="saveNewConsignee();" ><span class="glyphicon glyphicon-save" aria-hidden="true"></span>SAVE</button>
	
  <a data-toggle="tab" href="#menu1" onclick="addConsigneeInfoCancel()" ><span class="glyphicon glyphicon-trash pull-right" ></span></a>
	</div> 	
	</div>
	
	</div>
	

  </div><!-- /.col-lg-6 -->
</div>    


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
