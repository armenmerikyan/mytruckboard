<%@ page import="java.util.Locale,java.math.BigDecimal,com.big.util.*,java.text.*,java.util.*,java.io.*,javax.xml.parsers.*,org.w3c.dom.*,java.sql.*,java.text.DateFormat" %>
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
        	document.getElementById("searchForm").action = "truck_board_public.jsp?live=Yes";
    		document.getElementById("searchForm").submit();
        }
        function submitForm(){
        	//alert("hello");
        	//document.getElementById("searchButton").focus();
        	document.getElementById("searchForm").action = "truck_board_public.jsp";
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
       <!--         <li class="dropdown">
                    <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">Language<span
                            class="caret"></span></a>

                    <ul class="dropdown-menu" role="menu">
                        <li>
                            <a href="truck_board_public.jsp?language=en">English</a>
                        </li>
                        <li>
                            <a href="truck_board_public.jsp?language=sp">Espa�ol</a>
                        </li>
                        <li>
                            <a href="truck_board_public.jsp?language=fr">Fran�ais</a>
                        </li>
                    </ul>
                </li>    
    
    <li ><a href="truck_board_public_list.jsp">MOBILE</a></li>
    <li ><a href="https://www.mytruckboard.com/articles/loadboard.news.jsp">NEWS</a></li>
    <li ><a href="truck_board_public_links.jsp">LINKS</a></li>
    <li ><a href="mtbnlp.html">WHAT'S NLP</a></li>
    <li ><a href="AAAHOME/loadboard.jsp">NLP BOARD</a></li>
    <li ><a href="mtbapi.html">TMS APIs</a></li>
    <li ><a href="http://news.mytruckboard.com">NEWS BOARD</a></li>
    -->



    </ul>
   <!--
    <form class="navbar-form navbar-right" action="trucking-new/new_features.jsp" method="post">
    <div class="form-group">
    <input type="email" placeholder="Email" name="login_id" class="form-control">
    </div>
    <div class="form-group">
    <input type="password" placeholder="Password" name="password" class="form-control">
    </div>
    <button type="submit" class="btn btn-success">Sign in</button>
    </form>
    -->
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
      <%
      int imgInt = 1 + (int)(Math.random() * ((22 - 1) + 1));
     // imgInt = 1;
      %>
      <div style="padding:10px 20px 10px 20px;background-size: cover;background-color: orange;"> 
      <button type="button"
 		<%if(request.getParameter("live")!=null && !request.getParameter("live").equals("")){%>
 		class="btn btn-default" style="float:right;color:green;" onclick="submitForm()"
 		<%}else{%>
 		class="btn btn-danger" style="float:right;" onclick="submitFormLive()"
 		<%}%>
         id="searchButtonLive"  ><span class="glyphicon glyphicon-repeat" aria-hidden="true"></span> LIVE</button>

<h1 style="color:white;padding:5px;text-align:center;opacity: 0.9;">"My Truck Board"</h1>
<h2 style="color:white;padding:5px;text-align:center;opacity: 0.9;background-color: orange;" >
We help shippers connect with local and regional
trucking companies</h2> 
  <div class="panel-head" style="border-radius: 10px;padding:10px;border-color:white;opacity: 1;background-color: white;">
    <form onsubmit="javascript:;" action="javascript:;" method="post" id="searchForm">
	<div class="input-group input-group-lg">
	  <span class="input-group-addon" id="basic-addon1"><span style="color:green;" class="glyphicon glyphicon-search" aria-hidden="true"></span></span>
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
<%
			HashMap equipmentMap = new HashMap();
			
			try{
			String searchSql = "";
		Class.forName("com.mysql.jdbc.Driver");
		String urldb = "jdbc:mysql://localhost/maids_oltp?user=<USER>&password=<PASSWORD>";			
		Connection connection = DriverManager.getConnection(urldb);

			PreparedStatement ps = connection.prepareStatement("select count(distinct(email)) as itemCount from maids_customers where maids_customers.is_Not_Test_account is null and producttype is null and f_name is not null and f_name != ''");	
			ResultSet resultSetCount = ps.executeQuery();
			int totalCount = 0;
			while (resultSetCount.next()) {
				totalCount = resultSetCount.getInt("itemCount");
			}
			ps = connection.prepareStatement("select count(distinct(email)) as itemCount from maids_customers where maids_customers.is_Not_Test_account is null and producttype is null and f_name is not null and f_name != '' and current_State = '0'");	
			resultSetCount = ps.executeQuery();
			int totalCountOffline = 0;
			while (resultSetCount.next()) {
				totalCountOffline = resultSetCount.getInt("itemCount");
			}
			
				HashMap mainTruckMap = new HashMap();
				DateFormat formatter = new SimpleDateFormat("MM/dd/yyyy.HH.mm.ss");			
			String pickCity_lng = "1";
			String pickCity_lat = "1";
%>
<div style="padding:10px">
<!--
<div class="progress" >
  <div class="progress-bar progress-bar-success progress-bar-striped active" role="progressbar" aria-valuenow="30" aria-valuemin="0" aria-valuemax="100" style="width: <%=100 - ((totalCountOffline*100)/totalCount)%>%">
   TRUCKS ONLINE  <%=100 - ((totalCountOffline*100)/totalCount)%>%
  </div>
</div>
-->
<ul class="nav nav-tabs">
  <li role="presentation" class="active"><a href="#">DESKTOP</a></li>
  <li role="presentation"><a href="truck_board_public_list.jsp">MOBILE</a></li>
</ul>
    <table class="table table-hover table-bordered tablesorter" id="boardtable" style="padding:5px;border-width:0px;">
    <thead>
    <tr>
    <th style="padding:5px;border-width:0px;">Driver Name</th>
    <th style="padding:5px;border-width:0px;"><span class="glyphicon glyphicon-star" aria-hidden="true" ></span> Carrier Name</th>
    <th style="padding:5px;border-width:0px;">City</th>
    <th style="padding:5px;border-width:0px;">State</th>
    <th style="padding:5px;border-width:0px;"><span class="glyphicon glyphicon-pencil" aria-hidden="true" ></span> Wants to go?</th>
    <th style="padding:5px;border-width:0px;">Type</th>
    <th style="padding:5px;border-width:0px;">Status</th>
    <%if(request.getParameter("searchKey")!=null && !request.getParameter("searchKey").equals("")){%>
    <th style="padding:5px;border-width:0px;">Distance From</th>
    <%}%>
    <th style="padding:5px;border-width:0px;" ><span class="glyphicon glyphicon-usd" aria-hidden="true" ></span> Rate</th>
    <th style="padding:5px;border-width:0px;text-align:right;" ><span class="glyphicon glyphicon-road" aria-hidden="true" ></span>  Heading</th>
    <th style="padding:5px;border-width:0px;text-align:right;" ><span class="glyphicon glyphicon-calendar" aria-hidden="true" ></span> Modified</th>
    </tr>
    </thead>
    <tbody>


			<%

			
			PreparedStatement psMain = connection.prepareStatement("select currentTruckType, current_state, price_per_mile, wtg, owner_name, company_name, directionCurrent, producttype, email, ts_last_update, speedcurrent, ts, key_public, phone, f_name, city, zip, state, email, X(location) as city_lat, Y(location) as city_lng , (GLength(LineStringFromWKB(LineString(location, GeomFromText('POINT(" + pickCity_lat + " " + pickCity_lng + ")'))))) AS distanceFromPickCity from maids_oltp.maids_customers where maids_customers.is_Not_Test_account is null and producttype is null and f_name is not null and f_name != '' order by distanceFromPickCity ");
            		if(request.getParameter("searchKey")!=null && !request.getParameter("searchKey").equals("")){
				pickCity_lng = request.getParameter("pickCity_lng");
				pickCity_lat = request.getParameter("pickCity_lat");            		
				psMain = connection.prepareStatement("select currentTruckType, current_state, price_per_mile, wtg, owner_name, company_name, directionCurrent, producttype, email, ts_last_update, speedcurrent, ts, key_public, phone, f_name, city, zip, state, email, X(location) as city_lat, Y(location) as city_lng, (GLength(LineStringFromWKB(LineString(location, GeomFromText('POINT(" + pickCity_lat + " " + pickCity_lng + ")'))))) AS distanceFromPickCity from maids_oltp.maids_customers where maids_customers.is_Not_Test_account is null and producttype is null order by distanceFromPickCity");
//            			psMain.setString(1,"%" + request.getParameter("searchKey") + "%");
			}
			
			ResultSet resultSet = psMain.executeQuery();
			int j = 1;
			while (resultSet.next()) {
						if(resultSet.getString("distanceFromPickCity")!=null ){
						j +=1;
			//city_lat city_lng
			
				String latLongString = resultSet.getFloat("city_lat") + " " + resultSet.getFloat("city_lng");
				String[] dataSet = new String[10];
				dataSet[0]=resultSet.getString("key_public");
				dataSet[1]="";
				dataSet[2]=resultSet.getString("f_name");
				dataSet[3]="";		
				dataSet[4]=resultSet.getFloat("city_lat")+"";		
				dataSet[5]=resultSet.getFloat("city_lng")+"";	
				dataSet[6]=resultSet.getString("CITY")+"";		
				dataSet[7]=resultSet.getString("STATE")+"";		
				dataSet[8]=resultSet.getString("speedcurrent")+"";
				dataSet[9]=resultSet.getString("email")+"";		
				
				System.out.println("EXECUTED DETAIL" + resultSet.getString("CITY"));
				%>



				<tr style="padding:5px;">
				<td style="padding:5px;border-width:1px 0px 1px 0px;">
				<a href="javascript:;" onclick="getDetail('<%=NullCheck.check(resultSet.getString("key_public"))%>')" onmouseover="getDetail('<%=NullCheck.check(resultSet.getString("key_public"))%>')">					
				<%if(NullCheck.check(resultSet.getString("f_name")).equals("")){%>name: n\a<%}else{%><%=resultSet.getString("f_name")%><%}%>
				</a>
				</td>
				<td style="padding:5px;border-width:1px 0px 1px 0px;">				
				<%if(NullCheck.check(resultSet.getString("company_name")).equals("")){%>[No Name]<%}else{%><%=resultSet.getString("company_name")%><%}%>
				</td>
				<td style="padding:5px;border-width:1px 0px 1px 0px;">
				<%if(NullCheck.check(resultSet.getString("CITY")).equals("")){%>
				-
				<%}else{%>
				<%=NullCheck.check(resultSet.getString("CITY"))%>
				<%}%>
				</td>
				<td style="padding:5px;border-width:1px 0px 1px 0px;">
				<%if(NullCheck.check(resultSet.getString("STATE")).equals("")){%>
				-
				<%}else{%> <%=NullCheck.check(resultSet.getString("STATE"))%>
				<%}%>
				</td>
				<td style="padding:5px;border-width:1px 0px 1px 0px;">
				<%if(NullCheck.check(resultSet.getString("wtg")).equals("") || NullCheck.check(resultSet.getString("wtg")).contains("null") ){%>-<%}else{%><%=NullCheck.check(resultSet.getString("wtg"))%><%}%>				
				</td>

	<%	String[] driver_state = {"OFFLINE", "SLEEPING", "RESTING", "DRIVING", "ONLINE"};%>		 		
	<%	String[] current_truck_type = {"DRY VAN TRUCK", "FLATBED TRUCK", "REEFER TRUCK", "BOX TRUCK", "CAR CARRIER TRUCK"};%>
	<%

	int currentState = 0;
	int currentTruckType = 0;
								if(resultSet.getString("current_State")!=null){
									currentState = Integer.parseInt(resultSet.getString("current_State"));
								}
								if(resultSet.getString("currentTruckType")!=null){
									currentTruckType = Integer.parseInt(resultSet.getString("currentTruckType"));
								}	
	%>
				<td style="padding:5px;border-width:1px 0px 1px 0px;">
	<%=current_truck_type[currentTruckType]%></td>
				<td style="padding:5px;border-width:1px 0px 1px 0px;">	
	<%=driver_state[currentState]%></td>	
  				<%if(request.getParameter("searchKey")!=null && !request.getParameter("searchKey").equals("")){%>
  <td style="padding:5px;border-width:1px 0px 1px 0px;"><% DecimalFormat format=new DecimalFormat("####.0");%>
						<%if(resultSet.getString("distanceFromPickCity")!=null && Float.parseFloat(resultSet.getString("distanceFromPickCity"))* 62.1371>.1){%>
						<%=format.format(Float.parseFloat(resultSet.getString("distanceFromPickCity")) * 62.1371)%>
						<small>miles</small>
						<%}else{%>
						-
						<%}%>
</td>						
				<%}%>	
				<td style="padding:5px;border-width:1px 0px 1px 0px;text-align:right;">	
<%
Locale locale = new Locale("en", "US");      
NumberFormat currencyFormatter = NumberFormat.getCurrencyInstance(locale);

BigDecimal valueAsBD = BigDecimal.valueOf(resultSet.getFloat("price_per_mile"));
    valueAsBD.setScale(2, BigDecimal.ROUND_HALF_UP); // add digits to match .00 pattern

%>				
				<%if(resultSet.getFloat("price_per_mile")>0){%>
				<%=currencyFormatter.format(resultSet.getFloat("price_per_mile"))%>
				<%}else{%>
				-<%}%>
				</td>
					
				<%
				float driver_direction = -0.01f ;
				driver_direction = resultSet.getFloat("directionCurrent");

				String directions[] = {"NORTH", "NORTHEAST", "EAST", "SOUTHEAST", "SOUTH", "SOUTHWEST", "WEST", "NORTHWEST", "NORTH"};
				String dierctionText  =  directions[ (int)Math.round((  ((double)driver_direction % 360) / 45)) ];
				%>
				<td style="padding:5px;border-width:1px 0px 1px 0px;" align="right" >
				<%=dierctionText%>				
				</td>
				<td style="padding:5px;border-width:1px 0px 1px 0px;" align="right" nowrap>			
				
					<%if(resultSet.getTimestamp("ts_last_update")!=null){%>
								<%
												Calendar cal = Calendar.getInstance();
												java.util.Date expireDate = cal.getTime();
												java.util.Date jDate = new java.util.Date(resultSet.getTimestamp("ts_last_update").getTime());
												Calendar jcal=Calendar.getInstance();
												jcal.setTime(jDate);
												jcal.add(Calendar.DAY_OF_MONTH, 2);
												%>
								<%if(cal.before(jcal)) {%>
								<font > <%=new SimpleDateFormat("YY-MM-dd HH:mm").format(resultSet.getTimestamp("ts_last_update").getTime())%></font>
								<%}else{%>
								<font > <%=new SimpleDateFormat("YY-MM-dd HH:mm").format(resultSet.getTimestamp("ts_last_update").getTime())%></font>
								<%}%>
								
					<%}else{%>
						<%=new SimpleDateFormat("YY-MM-dd HH:mm").format(resultSet.getDate("ts"))%>
					<%}%>
				</td>
				<!--
				<td width="50px"><img src="../AAA/getImageService.byCustomer.pub.id.jsp?client_id=<%=resultSet.getString("key_public")%>" width="100%" /></td>
				-->
				</tr>

				<%
						}
	  		}


	  				connection.close();
		 			}catch (Exception ex){
		     		%><%="Error Posting " + ex%><%
		     		System.out.println(""+ ex);}
				%>



    </tbody>
    </table>  
    <p style="padding:25px;">IMPORTANT: Quick notes before you start using this FREE "truck board" service called "My Truck Board". First, this is live data you are looking at so when a driver indicates he\she is sleeping please respect the data and don�t call the driver at that time. Second, this is live data you are looking at, if the driver has not been active in the system it�s a good indicator that they are not active in the community so don�t call the driver. Third, this is live data so respect all members of the community when you communicate.
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