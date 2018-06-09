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
    <link href="css/bootstrap.min.css" rel="stylesheet">

    <!-- Just for debugging purposes. Don't actually copy these 2 lines! -->
    <!--[if lt IE 9]><script src="js/ie8-responsive-file-warning.js"></script><![endif]-->
    <script src="js/ie-emulation-modes-warning.js"></script>

    <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
    <!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
      <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->

    <!-- Custom styles for this template -->
    <link href="carousel.css" rel="stylesheet">
        <script type="text/javascript">
	
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
						document.getElementById(addressSPN).innerHTML = "YOUR SERVICE PROVIDER or DELIVERY IS " + xmlhttp.responseText.split('|')[7] + " Away";
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
	    function calculateTotal(productID, rowIndex, changeType){
		//alert(rowIndex + " Added a product" + productID);
		var gTotalNow = 0;
		var itemElementID = "itemIDQTYSPN" + rowIndex;
		var itemElementIDT = "itemIDTOTALF" + rowIndex;
		var itemElementIDTSPN = "itemIDTOTALSPN" + rowIndex;
		var totalProductCount = parseInt(document.getElementById("totalProductCount").value);
		var newTotalQTY = parseInt(document.getElementById(itemElementID).innerHTML)+1;
		if(changeType =='ClearQTY'){
			newTotalQTY = 0 ;
		}
		if(changeType =='ClickePrice'){
			newTotalQTY = newTotalQTY - 1; ;
		}
		if(changeType =='MinusOne'){
			if(parseInt(document.getElementById(itemElementID).innerHTML)>0){
				newTotalQTY = newTotalQTY-2;
			}else{
				newTotalQTY = newTotalQTY-1;
			}	
		}
		//alert(rowIndex + " Added a product" + productID);
		var newTotalTOTAL = Math.round(parseFloat(document.getElementById(itemElementIDT).value) * 100);
		//alert('YO WHAT UP 1');
		document.getElementById(itemElementID).innerHTML = newTotalQTY ;
		document.getElementById(itemElementIDTSPN).innerHTML = parseFloat((newTotalTOTAL * newTotalQTY)*.01).toFixed(2);
		var removeLinkText = "<a class=\"btn btn-xs btn-danger\" href=\"\" role=\"button\" onclick=\"javascript:calculateTotal('" + productID + " ','" + rowIndex + "','ClearQTY');return false ;\">" ;
		removeLinkText = "$" + document.getElementById(itemElementIDTSPN).innerHTML;// + "</a>";
		if(changeType =='ClearQTY'){
			removeLinkText = '0.00';
		}
		document.getElementById(itemElementIDTSPN).innerHTML = removeLinkText;
		for(k=0;k < totalProductCount; k++){		
			var itemElementIDLine = "itemIDQTYSPN" + k;
			var itemElementIDTLine = "itemIDTOTALF" + k;
			var itemElementIDTLine = "itemIDTOTALF" + k;		
			var newTotalQTYLine = parseInt(document.getElementById(itemElementIDLine).innerHTML);
			var newTotalTOTALLine = Math.round(parseFloat(document.getElementById(itemElementIDTLine).value) * 100);		
			gTotalNow = gTotalNow +(newTotalQTYLine *newTotalTOTALLine);
		}
		if(gTotalNow>0){
			//<a class="btn btn-success" href="" role="button"
			document.getElementById("orderNowSPN").innerHTML = "<a href=\"#PaymentAnchor\" onclick=\"javascript:startOrder();return false\" style=\"font-size:1em;color:white;\" >CHECKOUT</a>";
		}else{
			document.getElementById("orderNowSPN").innerHTML = "LiteWorks2 Inc"		
		}
		document.getElementById("Gtotal").innerHTML = parseFloat(gTotalNow*.01).toFixed(2) ;
			
	    }		
            function startOrder(){
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
						document.getElementById("orderNowSPN").innerHTML = "ORDER: "+ xmlhttp.responseText.split('<ITEM>')[1].substring(0, 4);
						
						var ccHtmlForm = "";
						ccHtmlForm = ccHtmlForm + "<div class=\"12u\">";
						ccHtmlForm = ccHtmlForm + "<input name=\"web_order_id\" id=\"web_order_id\" type=\"hidden\" value=\""+ xmlhttp.responseText.split('<ITEM>')[1] +"\" />";
						ccHtmlForm = ccHtmlForm + "<input class=\"text\" name=\"ccName\" id=\"ccName\" type=\"text\" style=\"font-size:1em;width:100%;\" value=\"\" placeholder=\"Name\" /><BR>";
						ccHtmlForm = ccHtmlForm + "</div>";
						ccHtmlForm = ccHtmlForm + "<div class=\"12u\">";
						ccHtmlForm = ccHtmlForm + "<input class=\"text\" name=\"ccPhone\" id=\"ccPhone\" type=\"text\" style=\"font-size:1em;width:50%;\" value=\"\" placeholder=\"Phone\" /> ";
						ccHtmlForm = ccHtmlForm + "<input class=\"text\" name=\"promoCode\" id=\"promoCode\" type=\"text\" style=\"font-size:1em;width:48%;\" value=\"\" placeholder=\"PROMO CODE\" /><BR>";
						ccHtmlForm = ccHtmlForm + "</div>";
						ccHtmlForm = ccHtmlForm + "<div class=\"12u\">";
						ccHtmlForm = ccHtmlForm + "<input class=\"text\" name=\"ccEmail\" id=\"ccEmail\" type=\"text\" style=\"font-size:1em;width:100%;\" value=\"\" placeholder=\"Email\" /><BR>";
						ccHtmlForm = ccHtmlForm + "</div>";
//						ccHtmlForm = ccHtmlForm + "<div class=\"12u\">";
//						ccHtmlForm = ccHtmlForm + "<input class=\"text\" name=\"ccAddress\" id=\"ccAddress\" type=\"text\" style=\"font-size:1em;width:100%;\" value=\"\" placeholder=\"Delivery Address\" onkeypress=\"autocompleteLocationName(document.getElementById('ccAddress').value, document.getElementById('ccAddress').name)\" autocomplete=\"off\" ><BR>";
//						ccHtmlForm = ccHtmlForm + "<span id=\"ccAddressSPN\" name=\"ccAddressSPN\" style=\"line-height:1.4em;font-size:1.0em;\"></span>";
//						ccHtmlForm = ccHtmlForm + "<input type=\"hidden\" name=\"ccAddress_lat\" id=\"ccAddress_lat\" value=\"\" />";
//						ccHtmlForm = ccHtmlForm + "<input type=\"hidden\" name=\"ccAddress_lng\" id=\"ccAddress_lng\" value=\"\" />";
//						ccHtmlForm = ccHtmlForm + "</div>";
//						ccHtmlForm = ccHtmlForm + "<div class=\"12u\">";
						ccHtmlForm = ccHtmlForm + "<input class=\"text\" name=\"ccNO\" id=\"ccNO\" type=\"text\" style=\"font-size:1em;width:100%;\" value=\"\" placeholder=\"Credit Card Number\" /><BR>";
						ccHtmlForm = ccHtmlForm + "</div>";
						ccHtmlForm = ccHtmlForm + "<div class=\"12u\">";
						ccHtmlForm = ccHtmlForm + "<input class=\"text\" name=\"ccMM\" id=\"ccMM\" type=\"text\" style=\"font-size:1em;width:20%;\" value=\"\" placeholder=\"MM\" /> ";
						ccHtmlForm = ccHtmlForm + "<input class=\"text\" name=\"ccYY\" id=\"ccYY\" type=\"text\" style=\"font-size:1em;width:20%;\" value=\"\" placeholder=\"YY\" /> ";
						ccHtmlForm = ccHtmlForm + "<input class=\"text\" name=\"ccCVV\" id=\"ccCVV\" type=\"text\" style=\"font-size:1em;width:25%;\" value=\"\" placeholder=\"CVV\" /> ";
						ccHtmlForm = ccHtmlForm + "<input class=\"text\" name=\"ccZip\" id=\"ccZip\" type=\"text\" style=\"font-size:1em;width:31%;\" value=\"\" placeholder=\"ZIP\" /><BR><BR>";
						ccHtmlForm = ccHtmlForm + "</div>";
						ccHtmlForm = ccHtmlForm + "<div class=\"12u\">";
						ccHtmlForm = ccHtmlForm + "<input value=\"START DELIVERY\" onclick=\"javascript:confirmOrderANDPay();return false\"  id=\"submit\" type=\"submit\" style=\"width:100%;font-size:1.2em;\" style=\"height:1.9em;color: white;border-radius:1px;width:60%;padding:5px;font-weight: bold;font-size:1.9em;background-color:black;\" \>";
						ccHtmlForm = ccHtmlForm + "</div>";
						document.getElementById("web_order_id").value = xmlhttp.responseText.split('<ITEM>')[1];

						document.getElementById("orderNowDetailSPN").innerHTML =  document.getElementById("orderNowDetailSPNPayment").innerHTML;
						document.getElementById("orderNowDetailSPNPayment").innerHTML = ""; 
						document.getElementById("ccPhone").value = document.getElementById("ccPhoneLogin").value;
						document.getElementById("ccEmail").value = document.getElementById("ccEmailLogin").value;
						
						if((document.getElementById("ccMaskLogin").value !=null && document.getElementById("ccMaskLogin").value != '') || document.getElementById("ccMaskLogin").value.lenght >2 ){
							document.getElementById("ccMaskOnFile").innerHTML = "<INPUT type=\"checkbox\" id=\"useCardOnFile\" name=\"useCardOnFile\" value=\"Yes\"> Use This Card " + document.getElementById("ccMaskLogin").value;
					    	}else{
					    		document.getElementById("ccMaskOnFile").innerHTML = '';
					    	}
					    }
					  }
					var totalProductCount = parseInt(document.getElementById("totalProductCount").value);
					var orderDetailString = "";

		for(k=0;k < totalProductCount; k++){		
			var itemElementID = "itemID" + k;
			var itemElementIDLine = "itemIDQTYSPN" + k;
			var itemElementIDTLine = "itemIDTOTALF" + k;					
			var newTotalQTYLine = parseInt(document.getElementById(itemElementIDLine).innerHTML);
			orderDetailString = orderDetailString + document.getElementById(itemElementID).value + "<ITEM>" + newTotalQTYLine + "<ITEM>";
			var newTotalTOTALLine = Math.round(parseFloat(document.getElementById(itemElementIDTLine).value) * 100);		
			orderDetailString = orderDetailString + newTotalTOTALLine + "<ROW>";
			//gTotalNow = orderDetailString +(newTotalQTYLine *newTotalTOTALLine);
		}
					xmlhttp.open("GET", "startOrder.jsp?orderDetail=" + orderDetailString,true);
					xmlhttp.send();
	    }
            function confirmOrderANDPay(){
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
//						document.getElementById("orderNowSPN").innerHTML = xmlhttp.responseText;
						var ccHtmlForm = "<span style=\"font-size:1em;\" >" + xmlhttp.responseText + " Your Are Done</span><BR>";
						document.getElementById("orderNowDetailSPN").innerHTML = ccHtmlForm;
						
					    }
					  }
					var orderDetailStringCC = "";		
					
					orderDetailStringCC = orderDetailStringCC + "web_order_id="+ encodeURI(document.getElementById("web_order_id").value);					
					if(document.getElementById("useCardOnFile").checked == true){
						orderDetailStringCC = orderDetailStringCC + "&useCardOnFile=true";
					}
					orderDetailStringCC = orderDetailStringCC + "&ccName="+ encodeURI(document.getElementById("ccName").value);
					orderDetailStringCC = orderDetailStringCC + "&ccIDLogin="+ encodeURI(document.getElementById("ccIDLogin").value);
					orderDetailStringCC = orderDetailStringCC + "&ccPhone="+ encodeURI(document.getElementById("ccPhone").value);
					orderDetailStringCC = orderDetailStringCC + "&ccEmail="+ encodeURI(document.getElementById("ccEmail").value);
					orderDetailStringCC = orderDetailStringCC + "&ccAddress="+ encodeURI(document.getElementById("ccAddress").value);
					orderDetailStringCC = orderDetailStringCC + "&ccAddress_lat="+ encodeURI(document.getElementById("ccAddress_lat").value);
					orderDetailStringCC = orderDetailStringCC + "&ccAddress_lng="+ encodeURI(document.getElementById("ccAddress_lng").value);
					orderDetailStringCC = orderDetailStringCC + "&ccAddress="+ encodeURI(document.getElementById("ccAddress").value);
					orderDetailStringCC = orderDetailStringCC + "&ccZip="+ encodeURI(document.getElementById("ccZip").value);
					orderDetailStringCC = orderDetailStringCC + "&ccNO="+ encodeURI(document.getElementById("ccNO").value);
					orderDetailStringCC = orderDetailStringCC + "&ccMM="+ encodeURI(document.getElementById("ccMM").value);
					orderDetailStringCC = orderDetailStringCC + "&ccYY="+ encodeURI(document.getElementById("ccYY").value);
					orderDetailStringCC = orderDetailStringCC + "&promoCode="+ encodeURI(document.getElementById("promoCode").value);
					orderDetailStringCC = orderDetailStringCC + "&ccCVV="+ encodeURI(document.getElementById("ccCVV").value);

					xmlhttp.open("GET", "confirmOrder.jsp?" + orderDetailStringCC ,true);					
					xmlhttp.send();
	    }
            function viewProductDetail(productDetail){
            	alert("CALL OR SMS TO ORDER NOW : (650) 384-3247 " + productDetail);
            }
            
            function showLoginForm(actionType){
             if(actionType == 'Register'){
            	document.getElementById("basic-addon2").innerHTML = "<span class=\"glyphicon glyphicon-envelope\" id=\"emailInputglyphicon\" name=\"emailInputglyphicon\" ></span>";   
            	document.getElementById("email").placeholder = "Email";   
            	document.getElementById("phoneInputGROUP").style.display = "block";   
            	document.getElementById("term_of_serviceInputGROUP").style.display = "block";              	
            	document.getElementById("loginBox").style.display = "inline";	
            	document.getElementById("registerInputGROUP").style.display = "block";      
            	document.getElementById("signinInputGROUP").style.display = "none";      
             }else{                          
            	document.getElementById("basic-addon2").innerHTML = "<span class=\"glyphicon glyphicon-user\" id=\"emailInputglyphicon\" name=\"emailInputglyphicon\" ></span>";   
            	document.getElementById("email").placeholder = "Email or Phone";   
            	document.getElementById("phoneInputGROUP").style.display = "none";  
            	document.getElementById("term_of_serviceInputGROUP").style.display = "none";      
            	document.getElementById("registerInputGROUP").style.display = "none";      
            	document.getElementById("signinInputGROUP").style.display = "block";                  	
            	document.getElementById("loginBox").style.display = "inline";	             
             }	
            }
            function showLoginFormLogin(actionType){
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
						var isLoginTrue = xmlhttp.responseText.split('<ITEM>')[1];
						//alert('YO HO WHAT UP' + xmlhttp.responseText);
						if(isLoginTrue == 'true'){
							document.getElementById("navSignInLink").style.color = "#fdee21";
							document.getElementById("ccPhone").value = xmlhttp.responseText.split('<ITEM>')[9];
							document.getElementById("ccPhoneLogin").value = xmlhttp.responseText.split('<ITEM>')[9];
							document.getElementById("ccEmail").value = xmlhttp.responseText.split('<ITEM>')[8];
							document.getElementById("ccEmailLogin").value = xmlhttp.responseText.split('<ITEM>')[8];
							document.getElementById("ccIDLogin").value = xmlhttp.responseText.split('<ITEM>')[5];
							document.getElementById("ccMaskLogin").value = xmlhttp.responseText.split('<ITEM>')[6];
						}else{
							document.getElementById("navSignInLink").style.color = "#ec1c24";
						}
						var ccHtmlForm = "<span style=\"font-size:1em;\" >" + xmlhttp.responseText + " Your Are Done</span><BR>";
						//document.getElementById("orderNowDetailSPN").innerHTML = ccHtmlForm;
						
					    }
					  }
					if((document.getElementById("password").value == '' || document.getElementById("email").value == '' || document.getElementById("phone").value == '') && actionType == 'Register'){
						alert('Email and Phone Must Not Be Blank to Register');					
					}else if(document.getElementById("term_of_service").checked == true || actionType == 'Login'){
						var orderDetailStringCC = "";	
						orderDetailStringCC = orderDetailStringCC + "&emailPin=";
						orderDetailStringCC = orderDetailStringCC + "&phonePin=";
						orderDetailStringCC = orderDetailStringCC + "&email="+ encodeURI(document.getElementById("email").value);
						if(actionType == 'Register'){
							orderDetailStringCC = orderDetailStringCC + "&phone="+ encodeURI(document.getElementById("phone").value);
						}else{
							orderDetailStringCC = orderDetailStringCC + "&phone="+ encodeURI(document.getElementById("email").value);
						}
						orderDetailStringCC = orderDetailStringCC + "&password="+ encodeURI(document.getElementById("password").value);					
					       	xmlhttp.open("POST", "registerCustomer.jsp" ,true);	
					       	xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
					       	xmlhttp.send("&action=" + actionType + orderDetailStringCC);
					     	document.getElementById("loginBox").style.display = "none";	
					}else{
						alert('You must read and accept the User Agreement and Privacy Policy to use this service');
					}
            }
            function showLoginFormHidden(){
            	document.getElementById("loginBox").style.display = "none";	
            }
            function showMenuItem(){
            	document.getElementById("menuBox").style.display = "inline";	
            }
            function showMenuItemHidden(filterType){
//            	document.getElementById("menuBox").style.display = "none";
            	
		var totalProductCount = parseInt(document.getElementById("totalProductCount").value);
		for(k=0;k < totalProductCount; k++){		
			var itemElementID = "itemIDDIV" + k;				
			var newTotalQTYLine = document.getElementById(itemElementID).innerHTML;	
			//alert(newTotalQTYLine);
			if(newTotalQTYLine.indexOf(filterType)!=-1){
				document.getElementById(itemElementID).style.display = "block";
			}else{
				document.getElementById(itemElementID).style.display = "none";
			}
			if(filterType=="ALL"){
				document.getElementById(itemElementID).style.display = "block";
			}
		}		
		//alert(filterType);
            }

	    function showProductDetail(productID, rowIndex){
		var itemDetailSPN = "itemDetailSPN" + rowIndex;
		var itemDetailSPNBTN = "itemDetailSPNBTN" + rowIndex;
		if(document.getElementById(itemDetailSPN).style.display != 'none'){
			document.getElementById(itemDetailSPN).style.display = "none";
			document.getElementById(itemDetailSPNBTN).innerHTML = "View detail";
		}else{
			document.getElementById(itemDetailSPN).style.display = "inline";
			document.getElementById(itemDetailSPNBTN).innerHTML = "Hide detail";
		}
	    }
</script>  
  </head>
<!-- NAVBAR
================================================== -->
  <body>
    <div class="navbar-wrapper">
      <div class="container">

        <nav class="navbar navbar-inverse navbar-fixed-top">
          <div class="container">
            <div class="navbar-header">
              <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar">
                <span class="sr-only">Toggle navigation</span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
              </button>
              <a id="orderNowSPN" class="navbar-brand" href="#" >LiteWorks2 Inc</a>
            </div>
            <div id="navbar" class="navbar-collapse collapse">
              <ul class="nav navbar-nav">
		<li><a href="#" ><span class="glyphicon glyphicon-usd" ></span> <span id="Gtotal" name="Gtotal" >0.00</span>&nbsp;<span class="glyphicon glyphicon-shopping-cart" ></span></a> 
                <li><a href="#" data-toggle="collapse" data-target=".navbar-collapse" onclick="javascript:showLoginForm('Register');return false ;">Register</a></li>
                <li><a href="#" data-toggle="collapse" data-target=".navbar-collapse" onclick="javascript:showLoginForm('Sign In');return true ;" id="navSignInLink" name="navSignInLink" >Sign In</a></li>
                <li><a href="photos.jsp" data-toggle="collapse" data-target=".navbar-collapse" >Images</a></li>
		</li>
		<!--
                <li class="dropdown">
                  <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">Filter<span class="caret"></span></a>
                  <ul class="dropdown-menu">
                    <li class="dropdown-header">PRODUCTS</li>
                    <li><a href="" onclick="javascript:showMenuItemHidden('BABY9');return false ;" >BABY STUFF</a></li>
                    <li><a href="" onclick="javascript:showMenuItemHidden('PERSONAL9');return false ;">PERSONAL</a></li>
                    <li><a href="" onclick="javascript:showMenuItemHidden('HOME9');return false ;">HOME</a></li>
                    <li><a href="" onclick="javascript:showMenuItemHidden('FOOD9');return false ;">FOOD</a></li>
                    <li><a href="" onclick="javascript:showMenuItemHidden('DRINK9');return false ;">DRINKS</a></li>
                    <li role="separator" class="divider"></li>
                    <li class="dropdown-header">SERVICES</li>
                    <li><a href="" onclick="javascript:showMenuItemHidden('DELIVERY9');return false ;">DELIVERY SERVICE</a></li>
                    <li><a href="" onclick="javascript:showMenuItemHidden('PHOTO9');return false ;">SITE VERIFICATION</a></li>
                  </ul>
                </li>
                -->
              </ul>
            </div>
          </div>
        </nav>

      </div>
    </div>
						<input class="text" name="ccMaskLogin" id="ccMaskLogin" type="hidden" />
						<input class="text" name="ccIDLogin" id="ccIDLogin" type="hidden" />
						<input class="text" name="ccPhoneLogin" id="ccPhoneLogin" type="hidden" />
						<input class="text" name="ccEmailLogin" id="ccEmailLogin" type="hidden" />				
				<div class="panel panel-default" id="orderNowDetailSPNPayment" name="orderNowDetailSPNPayment" style="display:none;">
<div class="container">
						<div class="text-center">
						<input name="web_order_id" id="web_order_id" type="hidden" value="" />
						<div class="input-group input-group-lg">
						  <span class="input-group-addon" id="basic-addon2"><span class="glyphicon glyphicon-pencil" id="emailInputglyphicon" name="emailInputglyphicon" ></span></span>
						  <input type="text" class="form-control" placeholder="Full Name" id="ccName" name="ccName" aria-describedby="basic-addon1">
						</div>
						</div>
						<div class="text-center">
						<div class="input-group input-group-lg">
						  <span class="input-group-addon" id="basic-addon2"><span class="glyphicon glyphicon-phone-alt" id="emailInputglyphicon" name="emailInputglyphicon" ></span></span>
						  <input type="text" class="form-control" placeholder="Phone" id="ccPhone" name="ccPhone" aria-describedby="basic-addon1">
						  <span class="input-group-addon" id="basic-addon2"><span class="glyphicon glyphicon-tag" id="emailInputglyphicon" name="emailInputglyphicon" ></span></span>
						  <input type="text" class="form-control" placeholder="PROMO CODE" id="promoCode" name="promoCode" aria-describedby="basic-addon1">
						</div>
						</div>
						<div class="text-center">
						<div class="input-group input-group-lg">
						  <span class="input-group-addon" id="basic-addon2"><span class="glyphicon glyphicon-envelope" id="emailInputglyphicon" name="emailInputglyphicon" ></span></span>
						  <input type="text" class="form-control" placeholder="Email" id="ccEmail" name="ccEmail" aria-describedby="basic-addon1">
						</div>
						</div>
						<div class="text-center">
						<div name="ccMaskOnFile" id="ccMaskOnFile" type="text" /></div>
						</div>
						<div class="text-center">
						<div class="input-group input-group-lg">
						  <span class="input-group-addon" id="basic-addon2"><span class="glyphicon glyphicon-credit-card" id="emailInputglyphicon" name="emailInputglyphicon" ></span></span>
						  <input type="text" class="form-control" placeholder="Credit Card Number" id="ccNO" name="ccNO" aria-describedby="basic-addon1">
						</div>
						</div>
						<div class="text-center">
						<div class="input-group input-group-lg">
						  <span class="input-group-addon" id="basic-addon2"><span class="glyphicon glyphicon-credit-card" id="emailInputglyphicon" name="emailInputglyphicon" ></span></span>
						  <input type="text" class="form-control" placeholder="MM" id="ccMM" name="ccMM" aria-describedby="basic-addon1">
						  <span class="input-group-addon" id="basic-addon2"><span class="glyphicon glyphicon-credit-card" id="emailInputglyphicon" name="emailInputglyphicon" ></span></span>
						  <input type="text" class="form-control" placeholder="YY" id="ccYY" name="ccYY" aria-describedby="basic-addon1">
						</div>
						</div>
						<div class="text-center">
						<div class="input-group input-group-lg">
						  <span class="input-group-addon" id="basic-addon2"><span class="glyphicon glyphicon-credit-card" id="emailInputglyphicon" name="emailInputglyphicon" ></span></span>
						  <input type="text" class="form-control" placeholder="CVV" id="ccCVV" name="ccCVV" aria-describedby="basic-addon1">
						  <span class="input-group-addon" id="basic-addon2"><span class="glyphicon glyphicon-credit-card" id="emailInputglyphicon" name="emailInputglyphicon" ></span></span>
						  <input type="text" class="form-control" placeholder="Zip" id="ccZip" name="ccZip" aria-describedby="basic-addon1">
						</div>
						</div>
						<div class="text-center">
<div class="btn-group-vertical" role="group" aria-label="...">
      <span class="input-group-addon">
  <button type="button" class="btn btn-default btn-lg" onclick="javascript:confirmOrderANDPay();return false" >CONFIRM ORDER</button>
  	</span>
</div>						
						</div>				
</div>	
				</div>					
					<div id="loginBox" name="loginBox" style="display:none;text-align:center;">
<div class="container">
<div class="input-group input-group-lg">
<h1>&nbsp;</h1>
</div>
</div>
<div class="container">
<div class="input-group input-group-lg">
<span class="input-group-addon" id="basic-addon1">
					<h1 >
					Register or Sign In
					</h1></span>
</div>
</div>
<div class="container">
<div class="input-group input-group-lg">
  <span class="input-group-addon" id="basic-addon2"><span class="glyphicon glyphicon-envelope" id="emailInputglyphicon" name="emailInputglyphicon" ></span></span>
  <input type="text" class="form-control" placeholder="Email" id="email" name="email" aria-describedby="basic-addon1">
</div>
</div>
<div class="container" id="phoneInputGROUP" name="phoneInputGROUP" >
<div class="input-group input-group-lg" aria-hidden="true">
  <span class="input-group-addon" id="basic-addon1"><span class="glyphicon glyphicon-phone-alt" ></span></span>
  <input type="text" class="form-control" placeholder="Phone" id="phone" name="phone" aria-describedby="basic-addon1">
</div>	   
</div>	   
<div class="container">
<div class="input-group input-group-lg">
    <span class="input-group-addon" id="basic-addon1"><span class="glyphicon glyphicon-lock" ></span></span>
    <input type="password" class="form-control" placeholder="Password" id="password" name="password" aria-describedby="basic-addon1">
</div>
</div>	
<div class="container" id="term_of_serviceInputGROUP" name="term_of_serviceInputGROUP">   
<div class="input-group">
      <span class="input-group-addon">
        <input type="checkbox" aria-label="..." id="term_of_service" name="term_of_service" value="Yes">
      I agree to <a href="/AAAHOME/terms_of_service.only.html" >Terms of Service</a> & <a href="/AAAHOME/privacy_policy.html" >Privacy Policy</a></span>
</div>
</div>
<div class="container" id="signinInputGROUP" name="signinInputGROUP">   
<div class="btn-group-vertical" role="group" aria-label="...">
      <span class="input-group-addon">
  <button type="button" class="btn btn-default btn-lg" onclick="javascript:showLoginFormLogin('Login');return false ;">Sign In</button>
  <button type="button" class="btn btn-default btn-lg" onclick="javascript:showLoginFormHidden();return false ;">Cancel</button>
  	</span>
</div>
</div>
<div class="container" id="registerInputGROUP" name="registerInputGROUP">   
<div class="btn-group-vertical" role="group" aria-label="...">
      <span class="input-group-addon">
  <button type="button" class="btn btn-default btn-lg" onclick="javascript:showLoginFormLogin('Register');return false ;" >Create Account</button>
  <button type="button" class="btn btn-default btn-lg" onclick="javascript:showLoginFormHidden();return false ;">Cancel</button>
  	</span>
</div>
</div>

                                	
					</div>

						<div class="container">
						<div class="text-center">
						<p>&nbsp;</p>
						<p>&nbsp;</p>
						<h1>Enter Photo Location Address</h1>
						</div> 
						</div>	
						<div class="container">
						<div class="input-group input-group-lg">
						    <span class="input-group-addon" id="basic-addon1"><span class="glyphicon glyphicon-globe" ></span></span>
						    <input type="text" class="form-control" placeholder="Address" id="ccAddress" name="ccAddress" aria-describedby="basic-addon1" onkeypress="autocompleteLocationName(document.getElementById('ccAddress').value, document.getElementById('ccAddress').name)" autocomplete="off" >
						</div>
						</div>	
						<div class="container">
						<div class="text-center">
						<span id="ccAddressSPN" name="ccAddressSPN" style="border-color:#262626;border-width: 1px;line-height:1.4em;font-size:1.0em;width:80%;">&nbsp;</span>
						<input type="hidden" name="ccAddress_lat" id="ccAddress_lat" value="" />
						<input type="hidden" name="ccAddress_lng" id="ccAddress_lng" value="" />
						</div>				
						</div>	
				<span id="orderNowDetailSPN" name="orderNowDetailSPN" >



    <!-- Marketing messaging and featurettes
    ================================================== -->
    <!-- Wrap the rest of the page in another container to center all the content. -->
					


    <div class="container marketing">

 <%
			String uuidBrand = (String)session.getAttribute("uuidBrand");
			String isShowMoreCol = (String)session.getAttribute("isShowMoreCol");
			String itemID[] = {"A1","B2","C3","D4","E4","F5","G6","H7","I8","J9","K0","L1","M2","N3","O4","P5","Q6","R7","S8","T9","U0","V1","W2","X3","Y4","Z5","AA","BB","CC","DD","EE","FF","GG","HH", "II","JJ","KK","LL","MM","NN","OO","PP","QQ","RR","SS","TT","XX","X1","X3","X6","X8","X9","XB"};			
			// SELECT * FROM maids_oltp.maids_quotes left join maids_customers on maids_customers.client_id = maids_quotes.client_id  left join maids_oltp.maids_users on maids_users.user_id = maids_quotes.assnproviderid order by maids_quotes.ts desc limit 100 
			Class.forName("com.mysql.jdbc.Driver");
					String urldb = "jdbc:mysql://localhost/maids_oltp?user=<USER>&password=<PASSWORD>";		
					Connection connection = DriverManager.getConnection(urldb);
			PreparedStatement psMain = connection.prepareStatement("select * from maids_oltp.product_catalog where isonline = 1 order by product_catalog.sortOrder asc");
			ResultSet resultSet = psMain.executeQuery();
			int j = 0;			
			DecimalFormat df = new DecimalFormat("#.00");
			NumberFormat formatter = NumberFormat.getCurrencyInstance();
			
				while (resultSet.next()) {
%>      		
      <div class="panel panel-success" id="itemIDDIV<%=j%>" name="itemIDDIV<%=j%>">	
      <div class="panel-heading"><%=resultSet.getString("name")%></div>
      <div class="panel-body">
      <p>
          <img class="img-circle" src="images_prd/<%=resultSet.getString("product_id")%>.jpg" alt="Generic placeholder image" width="140" height="140">
      </p>    
          <p name="itemDetailSPN<%=j%>" id="itemDetailSPN<%=j%>" style="display:none;" ><%=resultSet.getString("description")%></p>
          <p><a class="btn btn-info" href="" role="button" onclick="javascript:showProductDetail('<%=resultSet.getString("product_id")%>','<%=j%>');return false" name="itemDetailSPNBTN<%=j%>" id="itemDetailSPNBTN<%=j%>" >View details &raquo;</a></p>
	  <p>
					<div style="width:30%;display:inline;">
					PRICE: <span class="label label-default"><%=formatter.format(resultSet.getFloat("price"))%></span> 
					</div>
					<div style="display:inline;">
					COUNT: <span name="itemIDQTYSPN<%=j%>" id="itemIDQTYSPN<%=j%>"  class="label label-default" >0</span>
					</div>
					<div style="width:30%;display:inline;">
					TOTAL
					<span name="itemIDTOTALSPN<%=j%>" id="itemIDTOTALSPN<%=j%>"  class="label label-default">
					0.00
					</span>	  
					</div>
	  </p>
          </div>
	  <div class="panel-footer">
					
					<span style="width:100%;padding:0px;font-size:1em;">
					<a class="btn btn-success" href="" role="button" onclick="javascript:calculateTotal('<%=resultSet.getString("product_id")%>','<%=j%>','Add');return false ;" >+ 1 TO MY CART</a>
					</span>
					<span style="width:100%;padding:0px;font-size:1em;">
					<a class="btn btn-danger" href="" role="button" onclick="javascript:calculateTotal('<%=resultSet.getString("product_id")%>','<%=j%>','MinusOne');return false ;" >- 1 FROM CART</a>
					<input type="hidden" name="itemIDTOTALF<%=j%>" id="itemIDTOTALF<%=j%>" value="<%=resultSet.getFloat("price")%>" />
					<input type="hidden" name="itemID<%=j%>" id="itemID<%=j%>" value="<%=resultSet.getString("product_id")%>" />
					<input type="hidden" name="itemIDFilterKeys<%=j%>" id ="itemIDFilterKeys<%=j%>" value="<%=resultSet.getString("filterKey")%>" />
					</span>	  
	  </div> 
      </div>
        			<%
        			j=j+1;
        			}%>
           			
 </div>
	        	<input type="hidden" name="totalProductCount" id="totalProductCount" value="<%=j%>" />
      


      <!-- FOOTER -->
      <footer>
        <p class="pull-right"><a href="#">Back to top</a></p>
        <p>&copy; 2015 LiteWorks2, Inc. &middot; <a href="privacy_policy.html">Privacy Policy</a> &middot; <a href="terms_of_service.only.html">Terms of Service</a></p>
      </footer>

    </div><!-- /.container -->


    <!-- Bootstrap core JavaScript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <!-- Just to make our placeholder images work. Don't actually copy the next line! -->
    <script src="js/vendor/holder.min.js"></script>
    <!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
    <script src="js/ie10-viewport-bug-workaround.js"></script>
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
