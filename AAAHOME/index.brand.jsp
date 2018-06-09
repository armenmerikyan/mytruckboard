<%@ page import="com.big.util.*,java.text.*,java.util.*,java.io.*,javax.xml.parsers.*,org.w3c.dom.*,java.sql.*,java.text.DateFormat" %>
<!DOCTYPE HTML>
<html>
	<head>
<%
					String uuidBrand = "";
					String errorMsg = "";
try{

					Class.forName("com.mysql.jdbc.Driver");
					String url = "jdbc:mysql://localhost/test?user=<PASSWORD>&password=<PASSWORD>";		

					String urldb = "jdbc:mysql://localhost/maids_oltp?user=<USER>&password=<PASSWORD>";		
					Connection connection = DriverManager.getConnection(urldb);
					
					uuidBrand = UUID.randomUUID() + "";
					java.sql.Timestamp ts = new java.sql.Timestamp((new java.util.Date()).getTime());
					if(request.getParameter("email")!=null && !request.getParameter("email").equals("") && request.getParameter("password")!=null && !request.getParameter("password").equals("") && request.getParameter("company_name")!=null && !request.getParameter("company_name").equals("") && request.getParameter("ReEnterPassword")!=null && !request.getParameter("ReEnterPassword").equals("")){
						if(request.getParameter("term_of_service") == null || !request.getParameter("term_of_service").equals("Yes")){
							errorMsg = "In order to use our services, you must agree to Belmont�s Terms of Service.<BR>";
							System.out.println(errorMsg);				
						}else if(request.getParameter("password").equals(request.getParameter("ReEnterPassword"))){
							PreparedStatement ps = connection.prepareStatement("INSERT INTO maids_oltp.maids_users_brand(EMAIL, PASSWORD, provider_id, IS_ADMIN, LAST_LOGIN_TS, TS, IS_OWNER, email_CODE, SMS_CODE, start_ip, last_ip, user_id, first_name, last_name, mobile_phone, dl_number, dob_string, ssn, about_me, user_channel_type, isONLINE) VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
							ps.setString(1, request.getParameter("email").toLowerCase());
							ps.setString(2, request.getParameter("password"));
							ps.setString(3, uuidBrand);
							ps.setBoolean(4, true);
							ps.setTimestamp(5, ts);
							ps.setTimestamp(6, ts);
							ps.setBoolean(7, true);
							ps.setString(8, (UUID.randomUUID() +"").substring(0,4));
							ps.setString(9, (UUID.randomUUID() +"").substring(0,4));
							ps.setString(10, request.getRemoteAddr());
							ps.setString(11, request.getRemoteAddr());							
							ps.setString(12, UUID.randomUUID() + "");
							ps.setString(13, request.getParameter("f_name"));
							ps.setString(14, request.getParameter("l_name"));
							ps.setString(15, request.getParameter("phone"));
							ps.setString(16, request.getParameter("idnumber"));
							ps.setString(17, request.getParameter("dob"));
							ps.setString(18, request.getParameter("ssn"));
							ps.setString(19, request.getParameter("about_me"));
							ps.setString(20, "maidsapp");
							ps.setBoolean(21, false);
							ps.executeUpdate();

							ps = connection.prepareStatement("INSERT INTO maids_oltp.maids_providers_brand(provider_id, provider_NAME, TS, status) VALUES (?,?,?,?)");
							ps.setString(1, uuidBrand);
							ps.setString(2, request.getParameter("company_name"));
							ps.setTimestamp(3, ts);
							ps.setString(4, "New Accounts");
							ps.executeUpdate();
							errorMsg = "Your Account Was Created, We Will Contact You With Updates.";

						}else{
							errorMsg = "Re-entered password is not matching. Make sure to type same password in both fields?<BR>";
							System.out.println(errorMsg);
						}
					}else{
						errorMsg = "All fields are required to create a new account <BR>";
						 System.out.println(errorMsg);
					}
					connection.close();
	
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
		<title>LiteWorks2 App</title>
		<meta http-equiv="content-type" content="text/html; charset=utf-8" />
		<meta name="keywords" content="maid, Ondemand, on demand, on-demand, cleaning, service" />
		<link href="http://fonts.googleapis.com/css?family=Roboto:100,100italic,300,300italic,400,400italic" rel="stylesheet" type="text/css" />
		<!--[if lte IE 8]><script src="css/ie/html5shiv.js"></script><![endif]-->
	    <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.8.2/jquery.min.js"></script>
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
  	function addToPlaceBid(company_id, equipment_id){
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
			//document.getElementById(xmlhttp.responseText.split("<NEXT>")[0]).value = 'Added for quote';
			document.getElementById(xmlhttp.responseText.split("<NEXT>")[0]).style.backgroundColor = 'grey';
			document.getElementById("drop_city_span").innerHTML = xmlhttp.responseText.split("<NEXT>")[1];			
		    }
		  }
		var x = document.getElementById("country_code").selectedIndex;
		var y = document.getElementById("country_code").options;
		var search_query_detail = "?equipment_id=" + equipment_id;
		var search_query_detail = search_query_detail + "&company_id=" + company_id;
		search_query_detail = search_query_detail + "&pickCity=" + encodeURIComponent(document.getElementById("pickCity").value);
		search_query_detail = search_query_detail + "&pickState=" + encodeURIComponent(document.getElementById("pickState").value);
		search_query_detail = search_query_detail + "&pickCity_lat=" + encodeURIComponent(document.getElementById("pickCity_lat").value);
		search_query_detail = search_query_detail + "&pickCity_lng=" + encodeURIComponent(document.getElementById("pickCity_lng").value);
		xmlhttp.open("GET", "addToBidCart.jsp" + search_query_detail + "&country_code=" + y[x].value ,true);
		xmlhttp.send();	  		
  	}
</script>        
		<!--[if lte IE 8]><link rel="stylesheet" href="css/ie/v8.css" /><![endif]-->
		<!--[if lte IE 9]><link rel="stylesheet" href="css/ie/v9.css" /><![endif]-->
	</head>
	<body onload="rotater()">
		<!-- Second -->

		<!-- Fifth -->
			<section id="fifth" class="main">
			
				<header>
					<div >
						<section>
						<BR><BR>
						<p>&nbsp;LiteWorks2 Inc is glad to see you back.</p>
						</section>
					</div>
				</header>
				<div class="content style4 featured">
					<div class="container small">
						<form method="post" action="https://www.liteworks2.com/AAAHOME/index_login_brand.jsp" >
							<div class="row half">
								<div class="6u"><input type="text" class="text" name="login_id" placeholder="email" /></div>
								<div class="6u"><input type="password" class="text" name="password" placeholder="password" /></div>
							</div>
							<div class="row half">
								<div class="6u"><input type="submit" class="button" value="Click To Log In" /></div>
							</div>
						</form>
					</div>
				</div>

			
			</section>


		<!-- Footer -->
			<section id="footer" >
				<div class="copyright">						
					<ul class="menu">
						<li><span >&copy;Liteworks2 Inc All rights reserved.</span></li>
					</ul>
					<ul class="menu">
						<li><span >599 Fairchild Drive, Mountain View, California 94043 United States</span></li>
					</ul>
					<ul class="menu">
						<li><a href="terms_of_service.only.html" >Terms of Service</a> & <a href="privacy_policy.html" >Privacy Policy</a></li>
					</ul>
				</div>
			</section>

<script>
  (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
  (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
  m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
  })(window,document,'script','//www.google-analytics.com/analytics.js','ga');

  ga('create', 'UA-56270693-1', 'auto');
  ga('send', 'pageview');

</script>
	</body>
</html>