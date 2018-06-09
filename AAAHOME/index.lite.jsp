<%@ page import="com.big.util.*,java.text.*,java.util.*,java.io.*,javax.xml.parsers.*,org.w3c.dom.*,java.sql.*,java.text.DateFormat" %>			
<%
			String uuidBrand = (String)session.getAttribute("uuidBrand");
			String isShowMoreCol = (String)session.getAttribute("isShowMoreCol");
			//if(uuidBrand !=null){
			
			Class.forName("com.mysql.jdbc.Driver");
					String urldb = "jdbc:mysql://localhost/maids_oltp?user=<USER>&password=<PASSWORD>";		
					Connection connection = DriverManager.getConnection(urldb);
			PreparedStatement psMain = null;

			%><!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" "http://www.w3.org/TR/REC-html40/loose.dtd">
			<html>
			<head>
    <link rel="stylesheet" href="calendarview-1.2/stylesheets/calendarview.css">
    <script>
      function setupCalendars() {
        // Embedded Calendar
        Calendar.setup(
          {
            dateField: 'embeddedDateField',
            parentElement: 'embeddedCalendar'
          }
        )

        // Popup Calendar
        Calendar.setup(
          {
            dateField: 'embeddedDateFieldFrom',
            parentElement: 'embeddedCalendarFrom'
          }
        )
      }

    </script>			
	<script src="//ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>        

	<link rel="stylesheet" href="//ajax.googleapis.com/ajax/libs/jqueryui/1.10.4/themes/smoothness/jquery-ui.css" />
	<link rel="stylesheet" href="css/ipubsubnewflow.css" />
	<script src="//ajax.googleapis.com/ajax/libs/jqueryui/1.10.4/jquery-ui.min.js"></script>
	<script type="text/javascript">
		var itemListLabel ;
		var itemListMain ;
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
						document.getElementById(gps).innerHTML = "<img src=\"images/notification_done.png\" width=\"14px\" />";
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
//		    	alert('Test 2');
			$(fillTextBoxName).autocomplete({ source: itemListLabel });                
		    }
		  }
		var lat = fillTextBoxName + "_lat";
		var lng = fillTextBoxName + "_lng";
		var gps = fillTextBoxName + "_GPS";		  
		document.getElementById(lat).value = '';
		document.getElementById(lng).value = '';
		document.getElementById(gps).innerHTML = "<img src=\"images/notification_error.png\" width=\"14px\" />";
		if(searchKey.length>1){
			xmlhttp.open("GET", "autoComplete.jsp?location=" + encodeURIComponent(searchKey) ,true);
			xmlhttp.send();
		}
            }

		$( ".selector" ).bind( "autocompleteselect", function(event, ui) {
		  //access ui.item for anything that was selected you want.
		  alert("HELLO 2");
		});

            
        </script>  
  <script>
var howOften = 12;
var doneSetup = 0;
function rotater() {
        setTimeout("rotater()",howOften*200);
	partialSearch();
//        alert(document.getElementById("embeddedDateField").value);
//	alert('Hello Tick');
}
//window.onload=rotater;
</script>

  <script type="text/javascript">  
  	var urlStringPrev = "";
  	var urlPingStatus = 0;
  	function updateStatsOff(user_id){
            				//alert("Ran agains 1");
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
					    	urlStringPrev = "NEW SEARCH";
            					//document.getElementById("location").value = locationName;
						//document.getElementById(gps).innerHTML = "<img src=\"images/notification_done.png\" width=\"14px\" />";
					    }
					  }
					xmlhttp.open("GET", "updateProviderStatusOff.jsp?user_id=" + user_id.value ,true);
					xmlhttp.send();  	
  	}
  	function updateStats(user_id){
            				//alert("Ran agains 2");
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
					    	urlStringPrev = "NEW SEARCH";
            					//document.getElementById("location").value = locationName;
						//document.getElementById(gps).innerHTML = "<img src=\"images/notification_done.png\" width=\"14px\" />";
					    }
					  }
					xmlhttp.open("GET", "updateProviderStatus.jsp?user_id=" + user_id.value ,true);
					xmlhttp.send();  	
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
	  				document.getElementById("pubFormResultsDiv").innerHTML = xmlhttp.responseText;
	  			}	
  			    }
  			  }
  				var urlString = "?";
  				var formF = document.getElementsByTagName("input");
  				for(var j = 0; j<formF.length;j++){  	
//  					alert(formF.type);
//  					var checkedSts = getRadioCheckedValue(formF[j].name);

  					if(formF[j].type=="checkbox"){
  					
  					}else if(formF[j].type=="radio"){
  						if(formF[j].checked){
 	 						urlString = urlString + "&" + formF[j].name + "=" + encodeURIComponent(formF[j].value);  					
  						}
  					}else{
  						if(formF[j].name!="timestamp"){
  							urlString = urlString + "&" + formF[j].name + "=" + encodeURIComponent(formF[j].value);
  						}
  					}
  				}
  				if(urlString!= urlStringPrev){
	  				xmlhttp.open("GET", "index.lite.search.jsp" + urlString + "&searchSortBy=location" ,true);
	  				xmlhttp.send();		
	  				urlStringPrev = urlString;
  				}else{
  					if(urlPingStatus==0 && document.getElementById("timestamp")!=null){
	  					urlPingStatus = urlPingStatus + 1;
  						urlString = urlString + "&timestamp=" + document.getElementById("timestamp").value;
	  					xmlhttp.open("GET", "index.lite.update.jsp" + urlString ,true);
	  					xmlhttp.send();		
	  				}else{
	  					urlPingStatus = urlPingStatus + 1;
	  				} 
  				}
			}
</script>			
      <link href="http://netdna.bootstrapcdn.com/bootstrap/3.0.0/css/bootstrap.min.css" rel="stylesheet">
      <link href="http://netdna.bootstrapcdn.com/font-awesome/4.0.3/css/font-awesome.min.css" rel="stylesheet">
      <link rel="stylesheet" type="text/css" media="all" href="daterangepicker-bs3.css" />
      <script type="text/javascript" src="http://netdna.bootstrapcdn.com/bootstrap/3.1.1/js/bootstrap.min.js"></script>
      <script type="text/javascript" src="moment.js"></script>
      <script type="text/javascript" src="daterangepicker.js"></script>
<script language="JavaScript" type="text/javascript">

  var _gaq = _gaq || [];
  _gaq.push(['_setAccount', 'UA-28886039-1']);
  _gaq.push(['_trackPageview']);

  (function() {
    var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
    ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
    var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
  })();

</script>      
  </head>
  <body onload="rotater()">
  
	<FORM name="searchForm" id="searchForm" action="index.jsp" method="post"  >

            <div class="well">

               <form class="form-horizontal">
                 <fieldset>
                  <div class="control-group">
                    <div class="controls">
                     <div class="input-prepend input-group">
                       <span class="add-on input-group-addon"><i class="glyphicon glyphicon-calendar fa fa-calendar"></i></span>
                       <input type="text" style="width: 400px" name="reservation" id="reservationtime" class="form-control" value=""  class="span4"/>
                     </div>
                    </div>
                  </div>
                 </fieldset>
               </form>

               <script type="text/javascript">
               $(document).ready(function() {
                  $('#reservationtime').daterangepicker({
              //      timePicker: true,
              //      timePickerIncrement: 30,
                    format: 'MM/DD/YYYY'
                  }, function(start, end, label) {
                    console.log(start.toISOString(), end.toISOString(), label);
                  });
               });
               </script>

            </div>  	
    <div style="float: right; width: 50%;">
      <div style="height: 250px; background-color: #efefef; padding: 10px; -webkit-border-radius: 12px; -moz-border-radius: 12px; margin-left: 10px">
        <div id="embeddedExample" style="">
				<span name="pickCity_GPS" id="pickCity_GPS" ><img src="images/notification_warning.png" style="width: 14px;"/></span>							
				City <input class="textBoxStyle" tabindex="1" value="<%=NullCheck.check((String)session.getAttribute("pickCity"))%>" name="pickCity"  id="pickCity" type="text" size="20" onblur="autocompleteAddress(document.getElementById('pickCity').name, document.getElementById('pickState').name)" autocomplete="off" onkeypress="autocompleteLocationName(document.getElementById('pickCity').value, document.getElementById('pickCity').name)" placeholder="Los Angeles" />
				State <input class="textBoxStyle" value="<%=NullCheck.check((String)session.getAttribute("pickState"))%>" name="pickState"  id="pickState" type="text" size="2" placeholder="CA"/>
				<input type="hidden" name="pickCity_lat" id="pickCity_lat" value="<%=NullCheck.check((String)session.getAttribute("pickCity_lat"))%>" />
				<input type="hidden" name="pickCity_lng" id="pickCity_lng" value="<%=NullCheck.check((String)session.getAttribute("pickCity_lng"))%>" />
				<BR>  <BR>        
        			Key Word <input tabindex="3" name="searchKey"  id="searchKey" type="text" size="20" placeholder="Mark" /><BR><BR>  
        			First Name <input tabindex="3" name="searchKeyFirstName"  id="searchKeyFirstName" type="text" size="20" placeholder="Mark" /><BR><BR>  
				<!--
				All <input type="radio" name="haulFilter" value="All" <%if(request.getParameter("haulFilter")==null || request.getParameter("haulFilter").equals("All")){%>checked<%}%> />
				Head <input type="radio" name="haulFilter" value="Headhaul" <%if(request.getParameter("haulFilter")!=null && request.getParameter("haulFilter").equals("Headhaul")){%>checked<%}%> />
				Back <input type="radio" name="haulFilter" value="Backhaul" <%if(request.getParameter("haulFilter")!=null && request.getParameter("haulFilter").equals("Backhaul")){%>checked<%}%> />
				<BR><BR>  
				All <input type="radio" name="eqTypeFilter" value="All" <%if(request.getParameter("eqTypeFilter")==null || request.getParameter("eqTypeFilter").equals("All")){%>checked<%}%> />
				Van <input type="radio" name="eqTypeFilter" value="Van" <%if(request.getParameter("eqTypeFilter")!=null && request.getParameter("eqTypeFilter").equals("Van")){%>checked<%}%> />
				Reefer <input type="radio" name="eqTypeFilter" value="Reefer" <%if(request.getParameter("eqTypeFilter")!=null && request.getParameter("eqTypeFilter").equals("Reefer")){%>checked<%}%> />			
				<BR><BR>
				-->
				All <input type="radio" name="isOnlineFilter" value="All" <%if(request.getParameter("isOnlineFilter")==null || request.getParameter("isOnlineFilter").equals("All")){%>checked<%}%> />
				Online <input type="radio" name="isOnlineFilter" value="Online" <%if(request.getParameter("isOnlineFilter")!=null && request.getParameter("isOnlineFilter").equals("Online")){%>checked<%}%> />
				Offline <input type="radio" name="isOnlineFilter" value="Offline" <%if(request.getParameter("isOnlineFilter")!=null && request.getParameter("isOnlineFilter").equals("Offline")){%>checked<%}%> />			
				
        </div>
      </div>
    </div>
    	</form>
	<span class="pubFormResultsDiv" id="pubFormResultsDiv" name="pubFormResultsDiv"></span>
  </body>
</html>

	        	