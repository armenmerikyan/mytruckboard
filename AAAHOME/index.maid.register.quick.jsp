<%@ page import="java.sql.SQLException,com.big.util.*,java.text.*,java.util.*,java.io.*,javax.xml.parsers.*,org.w3c.dom.*,java.sql.*,java.text.DateFormat" %>
<!DOCTYPE HTML>
<html>
	<head>
<%
					String uuid = "";
					String errorMsg = "";
try{
System.out.println("TEST LINE MADE IT ");

					if(request.getParameter("fT").equals("AC")){
					if(request.getParameter("addAccount")!=null && !request.getParameter("addAccount").equals("")){
					if(request.getParameter("email")!=null && !request.getParameter("email").equals("") && request.getParameter("password")!=null && !request.getParameter("password").equals("") && request.getParameter("ReEnterPassword")!=null && !request.getParameter("ReEnterPassword").equals("")&& request.getParameter("phone")!=null && !request.getParameter("phone").equals("") && request.getParameter("company_name")!=null && !request.getParameter("company_name").equals("")){
						if(request.getParameter("term_of_service") == null || !request.getParameter("term_of_service").equals("Yes")){
							System.out.println("TEST LINE MADE IT ");
							errorMsg = "In order to use our services, you must agree to LiteWorks2 Inc�s Terms of Service.<BR>";
							System.out.println(errorMsg);	
						}else if(request.getParameter("password").equals(request.getParameter("ReEnterPassword"))){
							System.out.println("TEST LINE MADE IT--------------------------------- ");
							Class.forName("com.mysql.jdbc.Driver");
							String url = "jdbc:mysql://localhost/test?user=<PASSWORD>&password=<PASSWORD>";		
							String urldb = "jdbc:mysql://localhost/maids_oltp?user=<USER>&password=<PASSWORD>";		
							Connection connection = DriverManager.getConnection(urldb);					
							uuid = UUID.randomUUID() + "";
							String user_id = UUID.randomUUID() + "";
							java.sql.Timestamp ts = new java.sql.Timestamp((new java.util.Date()).getTime());
							PreparedStatement ps = connection.prepareStatement("INSERT INTO maids_oltp.maids_users(EMAIL, PASSWORD, provider_id, IS_ADMIN, LAST_LOGIN_TS, TS, IS_OWNER, email_CODE, SMS_CODE, start_ip, last_ip, user_id, first_name, last_name, mobile_phone, dl_number, dob_string, ssn, about_me, user_channel_type, isONLINE, m_name, aptno, home_address1, home_city, home_state, home_zip, home_country, f_language, s_language, dob_place, user_quote_type, quote_status, og_client_id, client_id, workAray, surveyAray, quizAray, user_public_id) VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
							ps.setString(1, request.getParameter("email").toLowerCase());
							ps.setString(2, request.getParameter("password"));
							ps.setString(3, uuid);
							ps.setBoolean(4, true);
							ps.setTimestamp(5, ts);
							ps.setTimestamp(6, ts);
							ps.setBoolean(7, true);
							ps.setString(8, (UUID.randomUUID() +"").substring(0,4));
							ps.setString(9, (UUID.randomUUID() +"").substring(0,4));
							ps.setString(10, request.getRemoteAddr());
							ps.setString(11, request.getRemoteAddr());							
							ps.setString(12, user_id);
							ps.setString(13, request.getParameter("f_name"));
							ps.setString(14, request.getParameter("l_name"));
							ps.setString(15, request.getParameter("phone"));
							ps.setString(16, request.getParameter("idnumber"));
							ps.setString(17, request.getParameter("dob"));
							ps.setString(18, request.getParameter("ssn"));
							ps.setString(19, request.getParameter("about_me"));
							ps.setString(20, "uberflowers");
							ps.setBoolean(21, false);
							
							ps.setString(22, request.getParameter("m_name"));
							ps.setString(23, request.getParameter("aptno"));
							ps.setString(24, request.getParameter("address"));
							ps.setString(25, request.getParameter("city"));
							ps.setString(26, request.getParameter("state"));
							ps.setString(27, request.getParameter("zip"));
							ps.setString(28, request.getParameter("country"));
							ps.setString(29, request.getParameter("f_language"));
							ps.setString(30, request.getParameter("s_language"));
							ps.setString(31, request.getParameter("dobplace"));
							ps.setString(32, request.getParameter("accountType"));
							ps.setString(33, "Offline");
							ps.setString(34, "Web Site");
							ps.setString(35, user_id);
							ps.setString(36, request.getParameter("currentJob") + "<B>" + request.getParameter("lastJob") + "<B>" +  request.getParameter("f_language")+ "<B>" + request.getParameter("s_language"));
							ps.setString(37, request.getParameter("hearAbout") + "<B>" + request.getParameter("yearsMaid"));
							ps.setString(38, request.getParameter("cleanFirst") + "<B>" + request.getParameter("cleanSecond"));
							ps.setString(39, UUID.randomUUID() + "");	
							ps.executeUpdate();

							ps = connection.prepareStatement("INSERT INTO maids_oltp.maids_providers(provider_id, provider_NAME, TS, status, discount_code) VALUES (?,?,?,?,?)");
							ps.setString(1, uuid);
							ps.setString(2, request.getParameter("company_name"));
							ps.setTimestamp(3, ts);
							ps.setString(4, "New Accounts");
							ps.setString(5, request.getParameter("discount_code"));
							ps.executeUpdate();
							errorMsg = "Your Account Was Created<BR>Use <a href=\"index.jsp\" class=\"scrolly\">mytruckboard.com</a> Login Form To Access Your Account.";					
							connection.close();
							System.out.println("Request TYPE ACCOUNT : " + request.getParameter("accountType"));

						}else{
							errorMsg = "Re-entered password is not matching. Make sure to type same password in both fields?<BR>";
							System.out.println(errorMsg);
						}
					}else{
						errorMsg = "The following fields are required and can't be left empty for new account create a <BR>";
						if(request.getParameter("email")!=null || !request.getParameter("email").equals("")) errorMsg = errorMsg + " Email";
						if(request.getParameter("password")!=null || !request.getParameter("password").equals("")) errorMsg = errorMsg + " Password";
						if(request.getParameter("ReEnterPassword")!=null || !request.getParameter("ReEnterPassword").equals("")) errorMsg = errorMsg + " Re EnterPassword";
						if(request.getParameter("phone")!=null || !request.getParameter("phone").equals("")) errorMsg = errorMsg + " Phone";
						if(request.getParameter("company_name")!=null || !request.getParameter("company_name").equals("")) errorMsg = errorMsg + " Company Name (please use your name as company name if you don't own a cleaning business)";												
						errorMsg = errorMsg + "<BR>";	
					}
					}
					}
		 }catch (SQLException ex) {
		     if(ex.getMessage().contains("Duplicate")){
	             	errorMsg = "Email or Phone number is already registered to a user.";
		     }else if(ex.getMessage().contains("Data too long for column")){
	             	errorMsg = "One of the provided fields has more Characters than it should have. Click back button, correct your form and resubmit<BR>";
	             }else{
	             	errorMsg = "All fields are required to create a new account click back button check your form<BR>";
	             }
	             System.out.println(""+ ex);					
	         }catch (Exception ex){	         
	             errorMsg = "" + ex.getMessage();
	             System.out.println(""+ ex);
	         }		
%>

<meta http-equiv="cache-control" content="max-age=0" />
<meta http-equiv="cache-control" content="no-cache" />
<meta http-equiv="expires" content="0" />
<meta http-equiv="expires" content="Tue, 01 Jan 1980 1:00:00 GMT" />
<meta http-equiv="pragma" content="no-cache" />

	
 <script type="text/javascript">
 var RecaptchaOptions = {
    theme : 'white'
 };
 </script>
 <%
 		HashMap truckList = (HashMap)session.getAttribute("truckList");
 		truckList = new HashMap();
 		session.setAttribute("truckList", new HashMap());
 %>
		<title>Yawadi.com</title>
		<meta http-equiv="content-type" content="text/html; charset=utf-8" />
		<meta name="description" content="On Demand Residential and Commercial Flower Delivery Service, Monitoring and Payment Application Services" />
		<meta name="keywords" content="Flower, Ondemand, on demand, on-demand, cleaning, service" />
		<link href="https://fonts.googleapis.com/css?family=Roboto:100,100italic,300,300italic,400,400italic" rel="stylesheet" type="text/css" />
		<!--[if lte IE 8]><script src="css/ie/html5shiv.js"></script><![endif]-->
	    <script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.8.2/jquery.min.js"></script>
		<script src="js/skel.min.js"></script>
		<script src="js/init.js"></script>
		<noscript>
			<link rel="stylesheet" href="css/skel-noscript.css" />
			<link rel="stylesheet" href="css/style.css" />
			<link rel="stylesheet" href="css/style-wide.css" />
		</noscript>
        <script src="//ajax.googleapis.com/ajax/libs/jqueryui/1.8.23/jquery-ui.min.js"></script>
        <script type="text/javascript">

			var guid = createGuid();

	    function postMessage(){
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
			    	document.getElementById("messageDiv").value = xmlhttp.responseText;
			    }
			  }
			var uuid = createGuid();
			var url = encodeURIComponent(document.getElementById("message").value) + "&name=" + encodeURIComponent(document.getElementById("messageName").value) + "&email=" + encodeURIComponent(document.getElementById("messageEmail").value) + "&id=" + uuid + "&guid=" + guid;

			xmlhttp.open("GET", "\.\./postMessage.jsp?message=" +  url,true);
			xmlhttp.send();
//			alert('Message Send');
	    }
	    function createGuid()
		{
		    return 'xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx'.replace(/[xy]/g, function(c) {
		        var r = Math.random()*16|0, v = c === 'x' ? r : (r&0x3|0x8);
		        return v.toString(16);
		    });
		}
</script>

	<script type="text/javascript">
		var itemListLabel ;
		var itemListMain ;
            
		var howOften = 12;
		var doneSetup = 0;
		var foundGps = 0;
  	var urlStringPrev = "";
  	var urlPingStatus = 0;
  	var resultRows = 10;
  	
            function autocompleteAddressLookUp(locationName, refID, fillCity, fillState){
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
            					var lat = fillCity + "_lat";
            					var lng = fillCity + "_lng";
						var gps = fillCity + "_GPS";
						document.getElementById(fillCity).value = xmlhttp.responseText.split('|')[2];
						document.getElementById(fillState).value = xmlhttp.responseText.split('|')[3];
						document.getElementById(lat).value = xmlhttp.responseText.split('|')[5];
						document.getElementById(lng).value = xmlhttp.responseText.split('|')[6];
						//document.getElementById(gps).innerHTML = "<img src=\"images/notification_done.png\" width=\"14px\" />";					    	
					    }
					  }
					xmlhttp.open("GET", "autoFillAddress.jsp?location=" + refID ,true);
					xmlhttp.send();
	    }
            function autocompleteAddress(fillCity, fillState){
            			
		    		var locationNameCurrent= document.getElementById(fillCity).value;
		    	for(var j =0;j<itemListLabel.length;j++){
				if(itemListLabel[j] == locationNameCurrent){
					autocompleteAddressLookUp(locationNameCurrent.split(',')[0], itemListMain[j].split(':')[1], fillCity, fillState);
					break;
				}
		    	}
            }
	
            function autocompleteLocationName(searchKey, fillTextBoxName){
 //           	alert('Execute Fine');
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
		    	
		    	itemListLabel = xmlhttp.responseText.split('|');
		    	itemListMain = xmlhttp.responseText.split('|');
		    	for(var j =0;j<itemListMain.length;j++){
		    		var itemListSet = itemListMain[j].split(":");
		    		itemListLabel[j] = itemListSet[0];
		    	}
		    	fillTextBoxName = "#" + fillTextBoxName;
			$(fillTextBoxName).autocomplete({ source: itemListLabel });                
		    }
		  }
		var lat = fillTextBoxName + "_lat";
		var lng = fillTextBoxName + "_lng";
		var gps = fillTextBoxName + "_GPS";		  
		document.getElementById(lat).value = '';
		document.getElementById(lng).value = '';
		document.getElementById("pickState").value = '';
		var x = document.getElementById("country_code").selectedIndex;
		var y = document.getElementById("country_code").options;		
//		alert("Index: " + y[x].index + " is " + y[x].value);
		//document.getElementById(gps).innerHTML = "<img src=\"images/notification_error.png\" width=\"14px\" />";
		if(searchKey.length>1){
			document.getElementById("home_footer").innerHTML = "<span style=\"font-size: 1.3em;line-height:1.1em;\"><BR><BR><BR><BR>"  + document.getElementById("truckText").value + "</span><BR>my truck board has available brokers, trucks, trailers and drivers every day. Select any city and locate the nearest available truck, trailer and driver.";
//			document.getElementById("home_footer_b").innerHTML = "";
			xmlhttp.open("GET", "autoComplete.int.jsp?location=" + encodeURIComponent(searchKey)  + "&country_code=" + y[x].value ,true);
			xmlhttp.send();
		}
            }

		$( ".selector" ).bind( "autocompleteselect", function(event, ui) {
		  //access ui.item for anything that was selected you want.
		  alert("HELLO 2");
		});

function rotater() {
        setTimeout("rotater()",howOften*100);
	partialSearch();
//        alert(document.getElementById("embeddedDateField").value);
//	alert('Hello Tick');
}
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
  			    		if(containsUpdate.length>2){
  			    			urlStringPrev = "";
  			    		}
  			    		urlPingStatus = 0;
  			    	}else{
  			    		var containsItems = xmlhttp.responseText.split("<LISTITEM/>");
  			    		if(containsItems.length>1){
						document.getElementById("home_footer").innerHTML = xmlhttp.responseText;
						partialSearchDetail();
	//	  				alert(document.getElementById("MTBBoard").style.height);
	//	  				alert(document.getElementById("homeboard").clientHeight);
						var heightNow = parseInt(document.getElementById("homeboard").clientHeight) + 20

						document.getElementById("MTBBoard").style.height = heightNow + "px";
	//	  				alert(document.getElementById("MTBBoard").style.height);
					}else{
						document.getElementById("home_footer").innerHTML = "<span style=\"font-size: 1.3em;line-height:1.1em;\"><BR><BR><BR><BR>"  + document.getElementById("truckText").value + "</span><BR>my truck board has available brokers, trucks, trailers and drivers every day. Select any city and locate the nearest available truck, trailer and driver.";					
					}
				}	
  			    }
  			  }
  				var urlString = "?";
  				var formF = document.getElementsByTagName("input");
  				for(var j = 0; j<formF.length;j++){  	
//  					alert(formF.type);
//  					var checkedSts = getRadioCheckedValue(formF[j].name);
  					if(formF[j].type=="radio"){
  						if(formF[j].checked){
 	 						urlString = urlString + "&" + formF[j].name + "=" + encodeURIComponent(formF[j].value);  					
  						}
  					}else if(formF[j].type=="submit"){
  					
  					}else{
  						if(formF[j].name!="timestamp"){
  							urlString = urlString + "&" + formF[j].name + "=" + encodeURIComponent(formF[j].value);
  						}
  					}
  				}
  				if(urlString!= urlStringPrev){
  					if(document.getElementById("nextQuestion")==null){
						xmlhttp.open("GET", "index.lite.search.jsp" + urlString ,true);
						xmlhttp.send();		
						urlStringPrev = urlString;
						urlPingStatus = 0;
  					}
  				}
			}
  	function partialSearchDetail()
  			{
  			var xmlhttp;
//  			alert('test');
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
  			    	var containsUpdate = xmlhttp.responseText.split("|");
  			  	var search_countB = 0;
				for(search_countB = 0;search_countB<40;search_countB++){
					var ecid = "ECID" + search_countB;	
					var ccid = "CCID" + search_countB;
					document.getElementById(ccid).innerHTML = containsUpdate[search_countB].split("-")[0];
					document.getElementById(ecid).innerHTML = containsUpdate[search_countB].split("-")[1];
				}
  			    }
  			  }
  			  	var search_count = 0;
  			  	var search_query_detail = "?query=";
				for(search_count = 0;search_count<resultRows;search_count++){
					var eid = "EID" + search_count;	
					var cid = "CID" + search_count;	
					var ecid = "ECID" + search_count;	
					var ccid = "CCID" + search_count;
					search_query_detail = search_query_detail + "&eid" + search_count + "=" + document.getElementById(eid).value;
					search_query_detail = search_query_detail + "&cid" + search_count + "=" + document.getElementById(cid).value;
					//document.getElementById(ecid).innerHTML = "-";
					//document.getElementById(ccid).innerHTML = "-";
				}
				search_query_detail = search_query_detail + "&resultRows=" + resultRows;
				xmlhttp.open("GET", "rateCount.jsp" + search_query_detail ,true);
				xmlhttp.send();		
  		}
  	function showMoreTrucks(){  
  		if(resultRows<80){
	  		resultRows = resultRows + 10;
			document.getElementById("resultCount").value = resultRows;
		}
  		//alert('More Trucks' + resultRows);  	
  	}
  	function submitFormTypeTo(form_name_to){
  		document.getElementById("fT").value = form_name_to;
		document.getElementById('formMain').submit();  	
	}
</script>        
		<!--[if lte IE 8]><link rel="stylesheet" href="css/ie/v8.css" /><![endif]-->
		<!--[if lte IE 9]><link rel="stylesheet" href="css/ie/v9.css" /><![endif]-->
	</head>
	<body onload="rotater()">
		<!-- Header -->
			

		<!-- First -->


			<section id="first" class="main">

				<header>
                    <div class="content style4 featured">
                        <div class="container small">
                            <FORM id="formMain" name="formMain" action="https://www.yawadi.com/AAAHOME/index.maid.register.jsp" method="post">
                             <INPUT type="hidden" name="addAccount" value="true">
                             <INPUT type="hidden" name="fT" id="fT" value="AC">
                    <div class="row half">
                                    <div class="12u">
                    	<%if(errorMsg!=null && !errorMsg.equals("")){%>
                    		<%if(errorMsg.contains("Your Account Was Created")){%>
	                        	<h2>Thank You - For Giving MyTruckBoard.com the opportunity to represent you as a qualified service provider</h2>                    			
                    		<%}%>
                    		<h2>User Interaction Response</h2>
                       	 	<h3><span style="color:#ff0000;" ><%=errorMsg%></span></h3>
                            <br>
                        <%}else{%>
                        <h2>LiteWorks2 Inc</h2>Partner Program Quick Start Application
                            <br>
                            <span style="font-size:.6em;">
                            LiteWorks2 Inc, 599 Fairchild Dr, Mountain View, CA 94043</span><BR>
                         <%}%>   
                    </div>     
                    </div>                             
                                <div class="row half">
                                    <div class="12u">
                                    Once your application is submitted we will contact you directly for phone screen and review next steps.  
                                    </div>
                                </div>
                                <div class="row half">
                                    <div class="5u"><input type="<%if(request.getParameter("fT").equals("NA")){%>text<%}else{%>hidden<%}%>" class="text" name="f_name" placeholder="First Name" value="<%=NullCheck.check(request.getParameter("f_name"))%>" /></div>
                                    <div class="2u"><input type="<%if(request.getParameter("fT").equals("NA")){%>text<%}else{%>hidden<%}%>" class="text" name="m_name" placeholder="M" value="<%=NullCheck.check(request.getParameter("m_name"))%>" /></div>
                                    <div class="5u"><input type="<%if(request.getParameter("fT").equals("NA")){%>text<%}else{%>hidden<%}%>" class="text" name="l_name" placeholder="Last Name" value="<%=NullCheck.check(request.getParameter("l_name"))%>" /></div>
                                </div>
                                <div class="row half">
                                    <div class="12u">
                                    	<select name="accountType" >
<option value="Condoms" >Photo Verification</option> 
                                    		<option value="Blownup" >Blow-dry-only Hair Stylist</option>
                                    		<option value="Drivers" >Driver</option>
                                    		<option value="Flowers" >Flower Store</option>
                                    		<option value="Fitness.Trainers" >Fitness Trainer</option>
<option value="Tutoring" >Tutoring</option> 
<option value="Dog.Sitting" >Dog Sitting</option>
<option value="Cat.Sitting" >Cat Sitting</option>
<option value="Baby.Sitting" >Baby Sitting</option> 
<option value="Dog.Walking" >Dog Walking</option> 
<option value="Local.Delivery" >Local Delivery</option> 
<option value="Long.Haul.Delivery" >Long Haul Delivery</option>
<option value="Yoga" >Yoga</option>
<option value="Car.Wash" >Car Wash</option>
<option value="Pool.Cleaning" >Pool Cleaning</option>
<option value="Lawn" >Lawn</option> 
<option value="Drycleaning" >Drycleaning</option>
<option value="Lunch.Truck" >Lunch Truck</option>
<option value="Ice.Cream.Trucks" >Ice Cream Trucks</option>
<option value="Elderly.Care" >Elderly Care</option> 
<option value="Theraphist" >Theraphist</option> 
<option value="Cook.or.Chef" >Cook or Chef</option>
<option value="Handy.Man" >Handy Man</option>
<option value="Ditch.Digger" >Ditch Digger</option> 
<option value="Make.Up.Face" >Make Up Face</option>
<option value="Message.Body" >Message Body</option>
<option value="Plant.Sitting Service" >Plant Sitting Service</option>                                   		
                                    	</select>
                                    </div>
                                </div>
                                <div class="row half">
                                    <div class="2u"><input type="<%if(request.getParameter("fT").equals("NA")){%>text<%}else{%>hidden<%}%>" class="text" name="aptno" placeholder="Apt. No" value="<%=NullCheck.check(request.getParameter("aptno"))%>" /></div>
                                    <div class="10u"><input type="<%if(request.getParameter("fT").equals("NA")){%>text<%}else{%>hidden<%}%>" class="text" name="address" placeholder="Address" value="<%=NullCheck.check(request.getParameter("address"))%>" /></div>
                                </div>
                                <div class="row half">
                                    <div class="6u"><input type="<%if(request.getParameter("fT").equals("NA")){%>text<%}else{%>hidden<%}%>" class="text" name="city" placeholder="City" value="<%=NullCheck.check(request.getParameter("city"))%>" /></div>                                
                                    <div class="6u"><input type="<%if(request.getParameter("fT").equals("NA")){%>text<%}else{%>hidden<%}%>" class="text" name="state" placeholder="State" value="<%=NullCheck.check(request.getParameter("state"))%>" /></div>
                                </div>
                                <div class="row half">
                                    <div class="6u"><input type="<%if(request.getParameter("fT").equals("NA")){%>text<%}else{%>hidden<%}%>" class="text" name="zip" placeholder="Zip Code" value="<%=NullCheck.check(request.getParameter("zip"))%>" /></div>
                                    <div class="6u"><input type="<%if(request.getParameter("fT").equals("NA")){%>text<%}else{%>hidden<%}%>" class="text" name="country" placeholder="Country" value="<%=NullCheck.check(request.getParameter("country"))%>" /></div>
                                </div>
                                <div class="row half">
                                    <div class="6u"><input type="text" class="text" name="phone" placeholder="Phone" value="<%=NullCheck.check(request.getParameter("phone"))%>" /></div>
				    <div class="6u"><input type="text" class="text" name="email" placeholder="Email" value="<%=NullCheck.check(request.getParameter("email"))%>" /></div>
                                </div> 
                                <div class="row half">
                                    <div class="12u">
                                    <input type="text" class="text" name="hearAbout" placeholder="How did you hear about us, only 140 characters." value="<%=NullCheck.check(request.getParameter("hearAbout"))%>" />
                                    </div>
                                </div>
                                <div class="row half">
                                    <div class="12u">
                                    <input type="text" class="text" name="yearsMaid" placeholder="How many more years will you work with us?" value="<%=NullCheck.check(request.getParameter("yearsMaid"))%>" />
                                    </div>
                                </div>
                                <div class="row half">
                                    <div class="12u">
                                    <input type="text" class="text" name="about_me" placeholder="About you, only 140 characters." value="<%=NullCheck.check(request.getParameter("about_me"))%>" />
                                    </div>
                                </div>
                                <div class="row half">
                                    <div class="6u"><input type="password" class="text" name="password" placeholder="Password" value="<%=NullCheck.check(request.getParameter("password"))%>" /></div>
                                    <div class="6u"><input type="password" class="text" name="ReEnterPassword" placeholder="Confirm password" value="<%=NullCheck.check(request.getParameter("ReEnterPassword"))%>" /></div>
                                </div>
                                <div class="row half">
                                    <div class="6u"><input type="text" class="text" name="company_name" placeholder="Company Name" value="<%=NullCheck.check(request.getParameter("company_name"))%>" /></div>
                                    <div class="6u"><input type="text" class="text" name="discount_code" placeholder="Referred By (optional)" value="<%=NullCheck.check(request.getParameter("discount_code"))%>" /></div>
                                </div>  
                                <div class="row half">
                                    <div class="12u"><INPUT type="checkbox" name="term_of_service" value="Yes"> I agree to <a href="terms_of_service.only.html" >Terms of Service</a> & <a href="privacy_policy.html" >Privacy Policy</a>.
									</div>
                                </div>                                
                                <div class="row">
                                    <div class="12u">
                                        <ul class="actions">
                                            <li><input type="submit" class="button" value="Create Partner Account" /></li>
                                        </ul>
                             
                                    </div>
                                </div>
                            </form>

			         



				</header>

			</section>

		<!-- Second -->
		<!-- Footer -->
			<section id="footer" >
				<ul class="icons">
					<li><a href="https://twitter.com/liteworks2" class="fa fa-twitter solo"><span >Twitter</span></a></li>
					<!--
					<li><a href="https://www.facebook.com/mytruckboard" class="fa fa-facebook solo"><span>Facebook</span></a></li>
					<li><a href="#" class="fa fa-google-plus solo"><span>Google+</span></a></li>
					<li><a href="#" class="fa fa-dribbble solo"><span>Dribbble</span></a></li>
					<li><a href="#" class="fa fa-github solo"><span>GitHub</span></a></li>
					-->
				</ul>
				<div class="copyright">
					<ul class="menu">
						<li><span >&copy;LiteWorks2 Inc All rights reserved.</span></li>
						<li><span >Design by <a href="http://www.34beats.com/">34Beats.com</a></span></li>
					</ul>
					<ul class="menu">
						<li><span >&copy;LiteWorks2 Inc, CA, United States</span></li>
					</ul>
				</div>
			</section>

<script>
  (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
  (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
  m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
  })(window,document,'script','//www.google-analytics.com/analytics.js','ga');

  ga('create', 'UA-63529886-1', 'auto');
  ga('send', 'pageview');

</script>
	</body>
</html>