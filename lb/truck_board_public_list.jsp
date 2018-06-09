<%@ page import="java.util.Locale,java.math.BigDecimal,com.big.util.*,java.text.*,java.util.*,java.io.*,javax.xml.parsers.*,org.w3c.dom.*,java.sql.*,java.text.DateFormat" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <meta name="google-site-verification" content="1QihUOuRwEWAj8QtNgUtpFsrC2CI7cY100legePbzWQ" />
    <meta http-equiv="cache-control" content="max-age=0" />
    <meta http-equiv="cache-control" content="no-cache" />
    <meta http-equiv="expires" content="0" />
    <meta http-equiv="expires" content="Tue, 01 Jan 1980 1:00:00 GMT" />
    <meta http-equiv="pragma" content="no-cache" />
	<link rel="shortcut icon" href="https://www.mytruckboard.com/trucking-new/images/mtb-favicon.ico">
    <link href="https://fonts.googleapis.com/css?family=Roboto:100,100italic,300,300italic,400,400italic" rel="stylesheet" type="text/css" />
    <!--[if lte IE 8]><script src="css/ie/html5shiv.js"></script><![endif]-->

    <title>MYTRUCKBOARD 2.0 - Freight management and GPS based dispatch system.</title>
    <meta name="description" content="We help shippers connect with local and regional
trucking companies. Manage independent truck drivers and un-utilized capacity with GPS based dispatch system designed to drive more profit to your brokerage." />
    <meta name="keywords" content="electronics buy impresoras turbon instagram electronica shipping argentina shopforchange catelli haulage inclusive cartridges lowest mentalhealth ciencia driver trucker science pallets plantronics crazy quot cartuchos insumos sustainable production freight save logistics custserv video india smart into undp sdg12 sdg11 car hgv austin globalmed toner responsible pasta canal free organic living remanufactured cool facebook sell ink mobile starterkit revenues worldwide buy moves healthy cordoba polycom pushed fashion communities diesel electronics sustainable buy freight logistics smart shipping toner hgv free haulage cartridges sell ink jobs transport transportation driver infrastructure trucker trucking job fashion stlouis freight, transportation, dispatch management, load optimization, truck broker, transportation management, truck, truck fleet management, shippers, truck brokers, shipping made easy, trucking industry, trucking software, trucking, dispatch for freight brokder, carrier management, load board, load, board" />
    
    <script type="text/javascript" src="js/jquery.min.js"></script>
    <script src="js/skel.min.js"></script>
    <script src="js/init.js"></script>

	<link rel="shortcut icon" href="https://www.mytruckboard.com/trucking-new/images/mtb-favicon.ico">

    <noscript>
        <link rel="stylesheet" href="css/skel-noscript.css" />
        <link rel="stylesheet" href="css/style-wide.css" />
     </noscript>


    <!-- Bootstrap core CSS -->
    <link href="css/bootstrap.min.css" rel="stylesheet">
    <script src="js/bootstrap2.min.js"></script>
	<script type="text/javascript" src="js/jquery.tablesorter.js"></script>



    <!-- Custom styles for this template -->
    <link href="css/navbar-fixed-top.css" rel="stylesheet">



        <!--<script type="text/javascript"
        src="https://maps.googleapis.com/maps/api/js?key=AIzaSyBpeQ3zGuTunYzxmiNMUltHL352e4beac4">
        </script>
            -->
       <!-- Google api:-->
        <script src="https://maps.googleapis.com/maps/api/js?v=3.exp&signed_in=true&libraries=places&?key=AIzaSyBpeQ3zGuTunYzxmiNMUltHL352e4beac4"></script>
    <!--[if lte IE 8]><link rel="stylesheet" href="trucking-new/css/ie/v8.css" /><![endif]-->
    <!--[if lte IE 9]><link rel="stylesheet" href="trucking-new/css/ie/v9.css" /><![endif]-->

    <style>
        .dark .button
        {
            background: #F45906;
            box-shadow: inset 0 0 0 1px #fff;
            color: #fff;
        }

        .button
        {
            background: #F45906;
         }

    </style>
        <script>
	function partialSearch(){
	//alert('Hello Tick');
	    submitFormLive();
	}
	function rotater() {
		setTimeout("partialSearch()",59000);
		//partialSearch();
	//        alert(document.getElementById("embeddedDateField").value);
	//	alert('Hello Tick');
	}
 	function initialize() {
 		<%if(request.getParameter("live")!=null && !request.getParameter("live").equals("")){%>
 		rotater();
 		<%}%>
        	var input = /** @type {HTMLInputElement} */(
	        document.getElementById('searchKey'));
	        var autocomplete = new google.maps.places.Autocomplete(input);
	        google.maps.event.addListener(autocomplete, 'place_changed', function() {
	        var place = autocomplete.getPlace();
	

	        if (!place.geometry) {
	        return;
	        }

	        document.getElementById('pickCity_lat').value = place.geometry.location.lat();
	        document.getElementById('pickCity_lng').value = place.geometry.location.lng();

	        });


 	
        }
        function submitFormLive(){
        	document.getElementById("searchForm").action = "truck_board_public_list.jsp?live=Yes";
    		document.getElementById("searchForm").submit();
        }
        function submitForm(){
        	//alert("hello");
        	//document.getElementById("searchButton").focus();
        	document.getElementById("searchForm").action = "truck_board_public_list.jsp";
    		document.getElementById("searchForm").submit();
        }
        function setFocusToSearch(){
        	document.getElementById("searchButton").focus();
        }
        function getDetail(fillCity){        	
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
                        
        		document.getElementById("SMSBoard").innerHTML = xmlhttp.responseText;
                        gotItMessageShow();



                        }
                        }
                        xmlhttp.open("GET", "truck_board_public_detail.jsp?equipmentID=" + fillCity ,true);
                        xmlhttp.send();
        }   
        </script> 
        <script>      
        function gotItMessageShow() {
	    $('#myModal').modal({
		show: 'false'
	    });         
    	}
        </script> 

	<script>
	$(document).ready(function(){

	$("#boardtable").tablesorter();

	});
	</script>        
</head>
<body  onload="initialize()">
    <!-- Fixed navbar -->
    <nav class="navbar navbar-default">
    <div class="container">
    <div class="navbar-header">
    <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar">
    <span class="sr-only">Toggle navigation</span>
    <span class="icon-bar"></span>
    <span class="icon-bar"></span>
    <span class="icon-bar"></span>
    </button>
	<a href="https://www.mytruckboard.com"><span class="image navbar-brand"  style="height: 35px; margin-left: 10px; padding: 10px 0px 0px; border-right-width: 0px;"><img src="/trucking-new/images/mtb_app_logo.png" style="width:35px;height:35px;" ></span></a>
    </div>
    <div id="navbar" class="navbar-collapse collapse">
    <ul class="nav navbar-nav">
    <li ><a href="https://itunes.apple.com/us/app/mytruckboard-driver/id1044398785?mt=8">MAPS FOR DRIVERS</a></li>
    <li ><a href="../mytruckboard-pricing-plans.html">TMS FOR SHIPPERS</a></li>
    <li ><a href="https://www.mytruckboard.com/articles/loadboard.news.jsp">TRUCKING NEWS</a></li>
    <li ><a href="truck_board_public_links.jsp">TMS LINKS</a></li>
    </ul>
    </div><!--/.nav-collapse -->
    </div>
    </nav>

<!-- Modal -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">"My Truck Board" Driver Detail</h4>
      </div>
      <div class="modal-body">
        <div id="SMSBoard" name="SMSBoard" >Coming Soon</div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
      </div>
    </div>
  </div>
</div> 

      <div style="padding:10px 20px 10px 20px;background-size: cover;background-color: orange;"> 
      <%if(request.getParameter("searchKey")!=null && !request.getParameter("searchKey").equals("")){%>
      <button type="button"
 		<%if(request.getParameter("live")!=null && !request.getParameter("live").equals("")){%>
 		class="btn btn-default" style="float:right;color:green;" onclick="submitForm()"
 		<%}else{%>
 		class="btn btn-default" style="float:right;" onclick="submitFormLive()"
 		<%}%>
         id="searchButtonLive"  ><span class="glyphicon glyphicon-repeat" aria-hidden="true"></span> AUTO</button>
      <%}%>

<h1 style="color:white;padding:5px;text-align:center;opacity: 0.9;">My Truck Board</h1>
<h2 style="color:white;padding:5px;text-align:center;opacity: 0.9;background-color: orange;" >
We help shippers connect with local and regional
trucking companies</h2> 
  <div class="panel-head" style="border-radius: 10px;padding:10px;border-color:white;opacity: 1;background-color: white;">
    <form onsubmit="javascript:;" action="javascript:;" method="post" id="searchForm">
	<div class="input-group input-group-lg">
	  <span class="input-group-addon" id="basic-addon1"><span style="color:black;" class="glyphicon glyphicon-search" aria-hidden="true"></span></span>
	  <input type="text" class="form-control" tabindex="4" placeholder="Chicago, IL, United States" aria-describedby="basic-addon1" id="searchKey" name="searchKey" value="<%=NullCheck.check(request.getParameter("searchKey"))%>" onblur="setFocusToSearch();">
     <input type="hidden" name="pickCity_lat" id="pickCity_lat" value="<%=NullCheck.check(request.getParameter("pickCity_lat"))%>" />
     <input type="hidden" name="pickCity_lng" id="pickCity_lng" value="<%=NullCheck.check(request.getParameter("pickCity_lng"))%>" />
      <span class="input-group-addon">
      <div class="btn-group btn-group-xs" role="group" aria-label="...">
	  <button type="button" class="btn btn-default" tabindex="5" id="searchButton" onclick="submitForm()">FIND</button></div></span>
	</div>
	</form>	
  </div>
</div>


<div style="padding:10px">
<ul class="nav nav-tabs">
  <li role="presentation"><a href="truck_board_public.jsp">DESKTOP</a></li>
  <li role="presentation" class="active"><a href="truck_board_public_list.jsp">MOBILE</a></li>
</ul>

<c:choose> 
  <c:when test="${empty param.searchKey}">
	<sql:query var="rs" dataSource="jdbc/TestDB">
	select l_name, currentTruckType, current_state, price_per_mile, wtg, owner_name, company_name, directionCurrent, producttype, email, ts_last_update, speedcurrent, ts, key_public, phone, f_name, city, zip, state, email, X(location) as city_lat, Y(location) as city_lng , (GLength(LineStringFromWKB(LineString(location, GeomFromText('POINT(1 1)'))))) AS distanceFromPickCity from maids_oltp.maids_customers where maids_customers.is_Not_Test_account is null and producttype is null and f_name is not null and f_name != '' order by distanceFromPickCity
	</sql:query>
  </c:when>
  <c:otherwise>
	<sql:query var="rs" dataSource="jdbc/TestDB">
	select l_name, currentTruckType, current_state, price_per_mile, wtg, owner_name, company_name, directionCurrent, producttype, email, ts_last_update, speedcurrent, ts, key_public, phone, f_name, city, zip, state, email, X(location) as city_lat, Y(location) as city_lng , (GLength(LineStringFromWKB(LineString(location, GeomFromText('POINT(${param.pickCity_lat} ${param.pickCity_lng})'))))) AS distanceFromPickCity from maids_oltp.maids_customers where maids_customers.is_Not_Test_account is null and producttype is null and f_name is not null and f_name != '' order by distanceFromPickCity
	</sql:query>
  </c:otherwise>
</c:choose>  
<% 
      int imgInt = 0 ;%>
<c:forEach var="row" items="${rs.rows}">
				<c:set var="distanceFromPickCity" scope="request" value="${row.distanceFromPickCity}"/>
				
				<%if(request.getAttribute("distanceFromPickCity")!=null ){%>
      <%
      if(imgInt==4)imgInt=0;
      imgInt += 1;
      %>				
<div class="jumbotron" style="padding:50px;background-image: url('http://nuculeus.io/io/image.jsp?imageTypeFormat=landscape&imageType=1024&userid=b2d4402b-4f95-4cdb-bb0b-ac4440aac2b9&img=<%=imgInt%>.main.jpg');background-size: cover;" >
  <h4 style="opacity: 0.9;background-color: #ffffff;padding:5px;" >
				<a href="javascript:;" onclick="getDetail('${row.key_public}')">	${row.f_name}, ${row.l_name}
				</a>
  <a class="btn btn-primary btn-xs pull-right" href="javascript:;" onclick="getDetail('${row.key_public}')" role="button">Learn more</a></h4></p>

  <ul class="list-group" style="opacity: 1.0;">
  <li class="list-group-item">
				${row.company_name}
				</li>  
				<li class="list-group-item">
				${row.city}
				  
				
				${row.state}
				</li>    
				<li class="list-group-item">
					<c:set var="wtg" value="${row.wtg}"/>
					<%if(NullCheck.check((String)pageContext.getAttribute("wtg")).equals("") || NullCheck.check((String)pageContext.getAttribute("wtg")).contains("null") ){%>-<%}else{%><%=NullCheck.check((String)pageContext.getAttribute("wtg"))%><%}%>				
				
				</li>   
					<c:set var="currentTruckType" value="${row.currentTruckType}"/>
					<c:set var="current_state" value="${row.current_state}"/>
	<%	String[] driver_state = {"OFFLINE", "SLEEPING", "RESTING", "DRIVING", "ONLINE"};%>		 		
	<%	String[] current_truck_type = {"DRY VAN TRUCK", "FLATBED TRUCK", "REEFER TRUCK", "BOX TRUCK", "CAR CARRIER TRUCK"};%>
	<%

	int currentState = 0;
	int currentTruckType = 0;
								if(pageContext.getAttribute("current_state")!=null){
									currentState = Integer.parseInt((String)pageContext.getAttribute("current_state"));
								}
								if(pageContext.getAttribute("currentTruckType")!=null){
									currentTruckType = Integer.parseInt((String)pageContext.getAttribute("currentTruckType"));
								}	
	%> 				
				<li class="list-group-item"><%=current_truck_type[currentTruckType]%></li> 				
				<li class="list-group-item"><%=driver_state[currentState]%></li>    
				
  				<%if(request.getParameter("searchKey")!=null && !request.getParameter("searchKey").equals("")){%>	
  				<% DecimalFormat format=new DecimalFormat("####.0");%>		
				<c:set var="distanceFromPickCity" scope="request"  value="${row.distanceFromPickCity}"/>	
				<li class="list-group-item">
						<%if(request.getAttribute("distanceFromPickCity")!=null){%>
						<%=format.format((double)request.getAttribute("distanceFromPickCity") * 62.1371)%>
						<small>miles away</small>	
						<%}%>
				</li>    
  				<%}%>
				<li class="list-group-item">
				<fmt:formatNumber type="currency" maxFractionDigits="2" value="${row.price_per_mile}"/></li>   
				<li class="list-group-item">
				<c:set var="directionCurrent" value="${row.directionCurrent}"/>
				<%
				float driver_direction = -0.01f ;
				if(pageContext.getAttribute("directionCurrent")!=null){
					driver_direction = (Float)pageContext.getAttribute("directionCurrent");
				}
				String directions[] = {"NORTH", "NORTHEAST", "EAST", "SOUTHEAST", "SOUTH", "SOUTHWEST", "WEST", "NORTHWEST", "NORTH"};
				String dierctionText  =  directions[ (int)Math.round((  ((double)driver_direction % 360) / 45)) ];
				%>				
				<%=dierctionText%>
				</li>   
				<li class="list-group-item">	
					<c:set var="ts" value="${row.ts}"/>
					<%if(pageContext.getAttribute("ts")!=null){%>
								<%
												Calendar cal = Calendar.getInstance();
												java.util.Date expireDate = cal.getTime();
												java.util.Date jDate = new java.util.Date(((java.sql.Timestamp)pageContext.getAttribute("ts")).getTime());
												Calendar jcal=Calendar.getInstance();
												jcal.setTime(jDate);
												jcal.add(Calendar.DAY_OF_MONTH, 2);
												%>
								<%if(cal.before(jcal)) {%>
								<font > <%=new SimpleDateFormat("YY-MM-dd HH:mm").format(((java.sql.Timestamp)pageContext.getAttribute("ts")).getTime())%></font>
								<%}else{%>
								<font > <%=new SimpleDateFormat("YY-MM-dd HH:mm").format(((java.sql.Timestamp)pageContext.getAttribute("ts")).getTime())%></font>
								<%}%>	
					<%}else{%>
						<%=new SimpleDateFormat("YY-MM-dd HH:mm").format(((java.sql.Timestamp)pageContext.getAttribute("ts")))%>
					<%}%>					
					
				</li>
				</ul>
    			</div>   		
    			<%}%>
</c:forEach> 
    <p style="padding:25px;">IMPORTANT: Quick notes before you start using this FREE "truck board" service called "My Truck Board". First, this is live data you are looking at so when a driver indicates he\she is sleeping please respect the data and don’t call the driver at that time. Second, this is live data you are looking at, if the driver has not been active in the system it’s a good indicator that they are not active in the community so don’t call the driver. Third, this is live data so respect all members of the community when you communicate.
<h1 style="padding:25px;text-align:center;opacity: 0.9;">CALL US (866) 418-1148</h1>
<h4 style="color:gray;padding:5px;text-align:center;opacity: 0.9;background-color: white;">Start building your ideal solution right now.</h4>
</p>
</div>


    <script>
        (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
                    (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
                m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
        })(window,document,'script','//www.google-analytics.com/analytics.js','ga');

        ga('create', 'UA-28886039-1', 'auto');
        ga('send', 'pageview');

    </script>

    <footer class="footer" style="padding:20px;background-size: cover;background-color: orange;">
      <div class="container">
      
        <p class="text-muted">LiteWorks2 Inc, Mountain View, California</p>

				<div class="copyright">
					<ul class="menu">
                        <li>Copyright &copy; 2015 Litewsorks2 Inc. All rights reserved.</li>

					</ul>
					<ul class="menu">
						<li><a href="http://liteworks2.com">Litewsorks2 Inc</a> </li>
					</ul>
				</div>
	</div>
    </footer>    
	</body>
</html>