<%@ page import="com.big.util.*,java.text.*,java.util.*,java.io.*,javax.xml.parsers.*,org.w3c.dom.*,java.sql.*,java.text.DateFormat" %>			
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
    <meta name="description" content="">
    <meta name="author" content="">
    <link rel="icon" href="../../favicon.ico">

    <title>LiteWorks2</title>
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
	
            function autocompleteLocationName(searchKey, fillTextBoxName){
            	//alert('Execute Fine');
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
		document.getElementById(lat).value = '';
		document.getElementById(lng).value = '';
            	document.getElementById(fillTextBoxName).style.color = "gray";
		if(searchKey.length>1){
			xmlhttp.open("GET", "autoComplete.ca.jsp?location=" + encodeURIComponent(searchKey) ,true);
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
            	//alert('hello');
		var queryString = "avg_diesel=" + encodeURIComponent(document.getElementsByName("avg_diesel")[0].value) + "&";
		queryString += "driver_pay=" + encodeURIComponent(document.getElementsByName("driver_pay")[0].value) + "&";
		queryString += "miscel_pay=" + encodeURIComponent(document.getElementsByName("miscel_pay")[0].value) + "&";
		queryString += "truckmpg=" + encodeURIComponent(document.getElementsByName("truckmpg")[0].value) + "&";
		queryString += "gallons=" + encodeURIComponent(document.getElementsByName("gallons")[0].value) + "&";
		queryString += "avg_diesel=" + encodeURIComponent(document.getElementsByName("avg_diesel")[0].value) + "&";
		queryString += "driver_pay=" + encodeURIComponent(document.getElementsByName("driver_pay")[0].value) + "&";
		queryString += "miscel_pay=" + encodeURIComponent(document.getElementsByName("miscel_pay")[0].value) + "&";
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
			xmlhttp.open("GET", "saveQuoteAutoSave.jsp?" + queryString ,true);
			xmlhttp.send();  
			//alert(queryString)
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
					xmlhttp.open("GET", "saveLineItemForQuote.jsp?" + queryString ,true);
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



 	 <input type="hidden" value="<%=UUID.randomUUID() + "" %>" name="quote_id" id="quote_id" >
 	 <input type="hidden" value="<%=request.getParameter("id") %>" name="equipment_id" id="equipment_id" >
 	 
    <div class="navbar-wrapper">
      <div class="container">
    <div class="container marketing">
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
						%>  		
      <div class="panel panel-info" >	
      <div class="panel-heading">Truck, Driver and Trailer Details</div>
      <div class="panel-body">
      <p> 
<div class="row">
  <div class="col-lg-6">     
<div class="input-group">
  <span class="input-group-addon" id="basic-addon1">Trailer</span>
  <input type="text" class="form-control"  aria-describedby="basic-addon1" value="<%=NullCheck.check(resultSet.getString("NAME"))%>">
</div>    
<div class="input-group">
  <span class="input-group-addon" id="basic-addon1">Name</span>
  <input type="text" class="form-control"  aria-describedby="basic-addon1" value="<%=NullCheck.check(resultSet.getString("CONTACT_PERSON"))%>">
</div>
<div class="input-group">
  <span class="input-group-addon" id="basic-addon1">Phone</span>
  <input type="text" class="form-control"  aria-describedby="basic-addon1" value="<%=NullCheck.check(resultSet.getString("PHONE"))%>" >
</div>
<div class="input-group">
  <span class="input-group-addon" id="basic-addon1">Email</span>
  <input type="text" class="form-control"  aria-describedby="basic-addon1"  value="<%=NullCheck.check(resultSet.getString("driver_email"))%>">
</div>
<div class="input-group">
  <span class="input-group-addon" id="basic-addon1">Fax</span>
  <input type="text" class="form-control"  aria-describedby="basic-addon1"  value="<%=NullCheck.check(resultSet.getString("FAX"))%>">
</div>
  </div><!-- /.col-lg-6 -->
  <div class="col-lg-6">
<div class="input-group">
  <span class="input-group-addon" id="basic-addon1">Language</span>
  <input type="text" class="form-control"  aria-describedby="basic-addon1"  value="<%=NullCheck.check(resultSet.getString("language"))%>">
</div>
<div class="input-group">
  <span class="input-group-addon" id="basic-addon1">Company Name</span>
  <input type="text" class="form-control"  aria-describedby="basic-addon1"  value="<%=NullCheck.check(resultSet.getString("company_name"))%>">
</div>
<div class="input-group">
  <span class="input-group-addon" id="basic-addon1">Owner Name</span>
  <input type="text" class="form-control"  aria-describedby="basic-addon1"  value="<%=NullCheck.check(resultSet.getString("owner_name"))%>">
</div>
<div class="input-group">
  <span class="input-group-addon" id="basic-addon1">MC Number</span>
  <input type="text" class="form-control"  aria-describedby="basic-addon1"  value="<%=NullCheck.check(resultSet.getString("mc_no"))%>">
</div>
<div class="input-group">
  <span class="input-group-addon" id="basic-addon1">Home City</span>
  <input type="text" class="form-control"  aria-describedby="basic-addon1"  value="<%=NullCheck.check(resultSet.getString("home_city"))%>">
</div>
  </div><!-- /.col-lg-6 -->
</div
          </p>
	  </div> 
      </div>
		
      <div class="panel panel-primary" >	
      <div class="panel-heading">Route Details</div>
      <div class="panel-body"> 
 <table class="table">   
    <tbody>
      <tr>
        <td colspan="3">
        <h2>Cost</h2>
<div class="input-group">
  <span class="input-group-addon" id="basic-addon1">Truck MPG</span>
  <input type="text" class="form-control"  aria-describedby="basic-addon1" name="truckmpg" id="truckmpg" value="">
</div>   
<div class="input-group">
  <span class="input-group-addon" id="basic-addon1">Diesel Gallons</span>
  <input type="text" aria-describedby="basic-addon1" name="gallons" id="gallons" value="">
</div>   
<div class="input-group">
  <span class="input-group-addon" id="basic-addon1">Diesel Price</span>
  <input type="text" class="form-control"  aria-describedby="basic-addon1" name="avg_diesel" id="avg_diesel">
</div> 
<div class="input-group">
  <span class="input-group-addon" id="basic-addon1">Driver Pay</span>
  <input type="text" class="form-control"  aria-describedby="basic-addon1" name="driver_pay" id="driver_pay">
</div>  
<div class="input-group">
  <span class="input-group-addon" id="basic-addon1">Other Costs</span>
  <input type="text" class="form-control"  aria-describedby="basic-addon1" name="miscel_pay" id="miscel_pay" >
</div>  
<div class="input-group">
  <span class="input-group-addon" id="basic-addon1">Carrier Pay</span>
  <input type="text" class="form-control"  aria-describedby="basic-addon1" name="carrier_pay" id="carrier_pay">
</div>           
        </td>
        <td colspan="4">
        <h2>Revenue</h2>
<div class="input-group">
  <span class="input-group-addon" id="basic-addon1">Rate</span>
  <input type="text" class="form-control"  aria-describedby="basic-addon1"  name="rate" id="rate" value="">
</div>     
<div class="input-group">
  <span class="input-group-addon" id="basic-addon1">Rate Per Mile</span>
  <input type="text" class="form-control"  aria-describedby="basic-addon1"  name="rate_miles" id="rate_miles" value="">
</div> 
<div class="input-group">
  <span class="input-group-addon" id="basic-addon1">QP 3% Amount</span>
  <input type="text" class="form-control"  aria-describedby="basic-addon1" name="rate_qp" id="rate_qp" value="">
</div>   
<div class="input-group">
  <span class="input-group-addon" id="basic-addon1">Miles</span>
  <input type="text" class="form-control"  aria-describedby="basic-addon1" name="miles" id="miles"  value="">
</div>     
<div class="input-group">
  <span class="input-group-addon" id="basic-addon1">Profit</span>
  <input type="text" class="form-control"  aria-describedby="basic-addon1" name="profit" id="profit"   value="">
</div>   
<div class="input-group">
  <span class="input-group-addon" id="basic-addon1">Profit %</span>
  <input type="text" class="form-control"  aria-describedby="basic-addon1" name="profit_per" id="profit_per"   value="">
</div> 
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
						<input type="hidden" name="pickState" value="<%=NullCheck.check((String)session.getAttribute("pickState"))%>">	
						<input type="hidden" name="pickCity_lat" value="<%=NullCheck.check((String)session.getAttribute("pickCity_lat"))%>">	
						<input type="hidden" name="pickCity_lng" value="<%=NullCheck.check((String)session.getAttribute("pickCity_lng"))%>">	
						<input type="hidden" name="destState" value="<%=NullCheck.check((String)session.getAttribute("destState"))%>">	
						<input type="hidden" name="destCity_lat" value="<%=NullCheck.check((String)session.getAttribute("destCity_lat"))%>">	
						<input type="hidden" name="destCity_lng" value="<%=NullCheck.check((String)session.getAttribute("destCity_lng"))%>">

  <span class="input-group-addon" id="basic-addon1"><span class="glyphicon glyphicon-globe" aria-hidden="true"></span></span>
  <input type="text" class="form-control"  aria-describedby="basic-addon1" id="pickCity" name="pickCity"  value="<%=NullCheck.check((String)session.getAttribute("pickCity"))%>">
</div>  </td>
        <td>
            <div class="input-group input-group-md">
            <div class='input-group date' id='datetimepicker1'>
            <input type='text' style="font-size: 14px; padding-left: 5px; padding-right: 2px; width: 90px;" class="form-control" id="pickup_date" name="pickup_date" <%if(request.getParameter("startDate")!=null){%> value="<%=request.getParameter("startDate")%>"<%}%> placeholder="Date">
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
  <input type="text" class="form-control"  aria-describedby="basic-addon1" id="destCity" name="destCity"  value="<%=NullCheck.check((String)session.getAttribute("destCity"))%>">
</div></td>


    <td>
    <div class="input-group input-group-md">
    <div class='input-group date' id='datetimepicker2'>
    <input type='text' style="font-size: 14px; padding-left: 5px; padding-right: 5px; width: 90px;" class="form-control" id="drop_date" name="drop_date" placeholder="Date">
    <span class="input-group-addon">
    <span class="glyphicon glyphicon-calendar"></span>
    </span>
    </div></div>
    </td>

  <!--
    <td>
<div class="input-group">
  <span class="input-group-addon date" id="datetimepicker2"><span class="glyphicon glyphicon-calendar" aria-hidden="true"></span></span>
  <input type="text" class="form-control"  aria-describedby="basic-addon1" id="drop_date" name="drop_date" value="" >
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
						    <input type="text" class="form-control" placeholder="Address" id="pickup_address" name="pickup_address" aria-describedby="basic-addon1" onkeypress="autocompleteLocationName(document.getElementById('pickup_address').value, document.getElementById('pickup_address').name)" autocomplete="off" >
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
						    <input type="text" class="form-control" placeholder="Address" id="drop_address" name="drop_address" aria-describedby="basic-addon1" onkeypress="autocompleteLocationName(document.getElementById('drop_address').value, document.getElementById('drop_address').name)" autocomplete="off" >
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
  <input type="text" class="form-control"  aria-describedby="basic-addon1" id="pickup_notes" name="pickup_notes"  style="font-size: 14px; padding-left: 5px; padding-right: 2px; width:100%;">
</div></div>        
        </td >
        <td colspan="3">
<div class="input-group input-group-md">
    <div class='input-group date' >
  <span class="input-group-addon"><span class="glyphicon glyphicon-comment" aria-hidden="true"> Notes</span></span>
  <input type="text" class="form-control"  aria-describedby="basic-addon1" id="drop_notes" name="drop_notes"  style="font-size: 14px; padding-left: 5px; padding-right: 2px; width:100%;">
</div></div>        
        </td>        
      </tr>
      <tr>
        <td colspan="3">
<div class="input-group input-group-md">
    <div class='input-group date' >
  <span class="input-group-addon"><span class="glyphicon glyphicon-user" aria-hidden="true"> Contact</span></span>
  <input type="text" class="form-control"  aria-describedby="basic-addon1" id="pickup_contact" name="pickup_contact"  style="font-size: 14px; padding-left: 5px; padding-right: 2px; width:100%;">
</div></div>        
        </td >
        <td colspan="3">
<div class="input-group input-group-md">
    <div class='input-group date' >
  <span class="input-group-addon"><span class="glyphicon glyphicon-user" aria-hidden="true"> Contact</span></span>
  <input type="text" class="form-control"  aria-describedby="basic-addon1" id="drop_contact" name="drop_contact"  style="font-size: 14px; padding-left: 5px; padding-right: 2px; width:100%;">
</div></div>        
        </td>      
      </tr>      

      <tr>
        <td colspan="3">
<div class="input-group input-group-md">
    <div class='input-group date' >
  <span class="input-group-addon"><span class="glyphicon glyphicon-phone" aria-hidden="true">Phone</span></span>
  <input type="text" class="form-control"  aria-describedby="basic-addon1" id="pickup_contact_phone" name="pickup_contact_phone"  style="font-size: 14px; padding-left: 5px; padding-right: 2px; width:100%;">
</div></div>        
        </td >
        <td colspan="3">
<div class="input-group input-group-md">
    <div class='input-group date' >
  <span class="input-group-addon"><span class="glyphicon glyphicon-phone" aria-hidden="true">Phone</span></span>
  <input type="text" class="form-control"  aria-describedby="basic-addon1" id="drop_contact_phone" name="drop_contact_phone"  style="font-size: 14px; padding-left: 5px; padding-right: 2px; width:100%;">
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
      <tr >
        <td></td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
      </tr>
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
      						<%} 
      						
      						 }catch (Exception ex){	         
						     %><%="Error Posting " + ex%><%  
						     System.out.println(""+ ex);
						 }
	         
						%>
      


      <!-- FOOTER -->
      <footer>
        <p class="pull-right"><a href="#">Back to top</a></p>
        <p>&copy; 2015 LiteWorks2, Inc. &middot; <a href="privacy_policy.html">Privacy Policy</a> &middot; <a href="terms_of_service.only.html">Terms of Service</a></p>
      </footer>

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
