<%@ page import="com.big.util.*,java.text.*,java.util.*,java.io.*,javax.xml.parsers.*,org.w3c.dom.*,java.sql.*,java.text.DateFormat" %>
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
        <script type="text/javascript">

	function partialSearch(){
	//alert('Hello Tick');
	    var myImageElement = document.getElementById('myImage');
	    myImageElement.src = '../io/image.jsp?imageType=1024&imageTypeFormat=landscape&userid=b2d4402b-4f95-4cdb-bb0b-ac4440aac2b9&rand=' + Math.random();

	}
	function rotater() {
		setTimeout("rotater()",10000);
		partialSearch();
	//        alert(document.getElementById("embeddedDateField").value);
	//	alert('Hello Tick');
	}	       



 	function initialize() {
 		rotater();
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
<body onload="initialize()">
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
    <!--
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
        <h4 class="modal-title" id="myModalLabel" >"My Truck Board" Driver Detail</h4>
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
  				<%if(request.getParameter("searchKey")==null || request.getParameter("searchKey").equals("")){%>
  				<BR><BR><BR><BR><BR><BR>
  				<%}%>
<h2 style="padding:5px;text-align:center;">"MY TRUCK BOARD"</h2>
<h4 style="padding:5px;text-align:center;">FREIGHT CARRIER LISTINGS</h4>
<p style="padding:5px;text-align:center;">WE HELP SHIPPERS FIND CARRIERS, SAVE MONEY AND SCALE ON-DEMAND.</p>
<div class="panel panel-default" style="border-color:white;">
  				<%if(request.getParameter("searchKey")==null || request.getParameter("searchKey").equals("")){%>
  <div class="panel-head" style="padding:20px;border-color:white;">
    <form onsubmit="javascript:;" action="javascript:;" method="post" id="searchForm">
	<div class="input-group input-group-lg">
	  <span class="input-group-addon" id="basic-addon1"><span class="glyphicon glyphicon-search" aria-hidden="true"></span></span>
	  <input type="text" class="form-control" tabindex="4" placeholder="Chicago, IL, United States" aria-describedby="basic-addon1" id="searchKey" name="searchKey" value="<%=NullCheck.check(request.getParameter("searchKey"))%>"  onblur="setFocusToSearch();">
     <input type="hidden" name="pickCity_lat" id="pickCity_lat" value="" />
     <input type="hidden" name="pickCity_lng" id="pickCity_lng" value="" />
      <span class="input-group-addon">
      <div class="btn-group btn-group-xs" role="group" aria-label="...">
	  <button type="button" class="btn btn-default" tabindex="5" onclick="submitForm()" id="searchButton" >SEARCH</button></div></span>
	</div>
	</form>	
</div>
				<%}%>
  <div class="panel-body" style="padding:20px;border-color:white;">

<ul class="nav nav-tabs">
  <li role="presentation" ><a href="truck_board_public.jsp">DESKTOP</a></li>
  <li role="presentation" class="active"><a href="truck_board_public_list.jsp">MOBILE</a></li>
</ul>
  				<%if(request.getParameter("searchKey")==null || request.getParameter("searchKey").equals("")){%>
  				<TABLE class="table table-hover table-bordered tablesorter" id="boardtable" style="padding:5px;border-width:0px;">    
  				<thead>
    <tr>
  				<TH style="padding:5px;border-width:0px;">Welcome to "My Truck Board"</TH>
    </tr>
   				</thead>
   				<tr>
 				<td><img id="myImage" width="100%" src="http://nuculeus.io/io/image.jsp?imageTypeFormat=landscape&imageType=1024&userid=b2d4402b-4f95-4cdb-bb0b-ac4440aac2b9" /></td>
  				</tr>
   
  				</table>
<BR><BR><BR>
    <section id="first" class="main">
        <header>
            <div >
            <h2>ABOUT US</h2><BR>
		<div class="embed-responsive embed-responsive-16by9">
		  <iframe class="embed-responsive-item" src="https://www.youtube.com/embed/SleVtLqACxE" frameborder="0" allowfullscreen></iframe>
		</div>
		<hr>
            </div>
        </header>
    </section>  				
  				<%}%>
			<%
			HashMap equipmentMap = new HashMap();
			
			try{
			String searchSql = "";
		Class.forName("com.mysql.jdbc.Driver");
		String urldb = "jdbc:mysql://localhost/maids_oltp?user=<USER>&password=<PASSWORD>";			
		Connection connection = DriverManager.getConnection(urldb);


				HashMap mainTruckMap = new HashMap();
				DateFormat formatter = new SimpleDateFormat("MM/dd/yyyy.HH.mm.ss");			
			String pickCity_lng = "1";
			String pickCity_lat = "1";
			
			PreparedStatement psMain = connection.prepareStatement("select l_name, currentTruckType, current_state, price_per_mile, wtg, owner_name, company_name, directionCurrent, producttype, email, ts_last_update, speedcurrent, ts, key_public, phone, f_name, city, zip, state, email, X(location) as city_lat, Y(location) as city_lng , (GLength(LineStringFromWKB(LineString(location, GeomFromText('POINT(" + pickCity_lat + " " + pickCity_lng + ")'))))) AS distanceFromPickCity from maids_oltp.maids_customers where maids_customers.is_Not_Test_account is null and producttype is null and f_name is not null and f_name != '' order by distanceFromPickCity limit 1");
            		if(request.getParameter("searchKey")!=null && !request.getParameter("searchKey").equals("")){
				pickCity_lng = request.getParameter("pickCity_lng");
				pickCity_lat = request.getParameter("pickCity_lat");
				psMain = connection.prepareStatement("select l_name, currentTruckType, current_state, price_per_mile, wtg, owner_name, company_name, directionCurrent, producttype, email, ts_last_update, speedcurrent, ts, key_public, phone, f_name, city, zip, state, email, X(location) as city_lat, Y(location) as city_lng, (GLength(LineStringFromWKB(LineString(location, GeomFromText('POINT(" + pickCity_lat + " " + pickCity_lng + ")'))))) AS distanceFromPickCity from maids_oltp.maids_customers where maids_customers.is_Not_Test_account is null and producttype is null order by distanceFromPickCity");
            			//psMain.setString(1,"%" + request.getParameter("searchKey") + "%");
            			//psMain.setString(2,"%" + request.getParameter("searchKey") + "%");
            			//psMain.setString(3,"%" + request.getParameter("searchKey") + "%");
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
      <%
      int imgInt = 1 + (int)(Math.random() * ((88 - 1) + 1));
     // imgInt = 1;
      %>
<div class="jumbotron" style="padding:50px;background-image: url('http://nuculeus.io/io/image.jsp?imageTypeFormat=landscape&imageType=1024&userid=b2d4402b-4f95-4cdb-bb0b-ac4440aac2b9&img=<%=imgInt%>.main.jpg');background-size: cover;" >
  <h4 style="opacity: 0.9;background-color: #ffffff;padding:5px;" >
				<a href="javascript:;" onclick="getDetail('<%=NullCheck.check(resultSet.getString("key_public"))%>')">					
				<%if(NullCheck.check(resultSet.getString("f_name")).equals("")){%>[No Name]<%}else{%><%=resultSet.getString("f_name")%>, <%=resultSet.getString("l_name")%><%}%>
				</a>
  <a class="btn btn-primary btn-xs pull-right" href="javascript:;" onclick="getDetail('<%=NullCheck.check(resultSet.getString("key_public"))%>')" role="button">Learn more</a></h4></p>
  <ul class="list-group" style="opacity: 1.0;">
  <li class="list-group-item">
				<span class="glyphicon glyphicon-star" aria-hidden="true" ></span> Company Name: 
				<%if(NullCheck.check(resultSet.getString("company_name")).equals("")){%>[No Name]<%}else{%><%=resultSet.getString("company_name")%><%}%>
				
</li>
  <li class="list-group-item"><span class="glyphicon glyphicon-globe" aria-hidden="true" ></span> Location:
				<%if(NullCheck.check(resultSet.getString("CITY")).equals("")){%>
				-
				<%}else{%>
				<%=NullCheck.check(resultSet.getString("CITY"))%>, <%=NullCheck.check(resultSet.getString("STATE"))%>
				<%}%>
</li>
<!--
  <li class="list-group-item">
				<%if(NullCheck.check(resultSet.getString("wtg")).equals("") || NullCheck.check(resultSet.getString("wtg")).contains("null") ){%>-<%}else{%><%=NullCheck.check(resultSet.getString("wtg"))%><%}%>				


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
</li>
-->
  <li class="list-group-item">
	DRIVING <%=current_truck_type[currentTruckType]%>
</li>
  <li class="list-group-item">
	STATUS <%=driver_state[currentState]%>
	</li>
	<!--
  <li class="list-group-item">
				<%if(resultSet.getFloat("price_per_mile")>0){%>
				$<%=resultSet.getFloat("price_per_mile")%>
				<%}else{%>
				-<%}%>
					
				<%
				float driver_direction = -0.01f ;
				driver_direction = resultSet.getFloat("directionCurrent");

				String directions[] = {"NORTH", "NORTHEAST", "EAST", "SOUTHEAST", "SOUTH", "SOUTHWEST", "WEST", "NORTHWEST", "NORTH"};
				String dierctionText  =  directions[ (int)Math.round((  ((double)driver_direction % 360) / 45)) ];
				%>

	</li>
	-->
  <li class="list-group-item">HEADING 
  				<%=dierctionText%>	</li>	
  				<%if(request.getParameter("searchKey")!=null && !request.getParameter("searchKey").equals("")){%>
  <li class="list-group-item"><% DecimalFormat format=new DecimalFormat("####.0");%>
						<%if(resultSet.getString("distanceFromPickCity")!=null && Float.parseFloat(resultSet.getString("distanceFromPickCity"))* 62.1371>.1){%>
						<%=format.format(Float.parseFloat(resultSet.getString("distanceFromPickCity")) * 62.1371)%>
						<small>miles away</small>
						<%}else{%>
						-
						<%}%>
</li>						
				<%}%>
  <li class="list-group-item">				
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
								<font color="blue"> <%=new SimpleDateFormat("YY-MM-dd HH:mm").format(resultSet.getTimestamp("ts_last_update").getTime())%></font>
								<%}else{%>
								<font color="orange"> <%=new SimpleDateFormat("YY-MM-dd HH:mm").format(resultSet.getTimestamp("ts_last_update").getTime())%></font>
								<%}%>
								
					<%}else{%>
						<%=new SimpleDateFormat("YY-MM-dd HH:mm").format(resultSet.getDate("ts"))%>
					<%}%>
					</li>
					

</ul>					</p>
</div>

				<%
						}
	  		}


	  				connection.close();
		 			}catch (Exception ex){
		     		%><%="Error Posting " + ex%><%
		     		System.out.println(""+ ex);}
				%>


			<section id="footer">
				<ul class="icons">
					<li><a href="https://twitter.com/MyTruckBoard" class="fa fa-twitter solo"><span>Twitter</span></a></li>
					<li><a href="https://www.facebook.com/myTruckBoard" class="fa fa-facebook solo"><span>Facebook</span></a></li>

				</ul>
				<div class="copyright">
					<ul class="menu">
                        <li>Copyright &copy; 2015 Litewsorks2 Inc. All rights reserved.</li>

					</ul>
					<ul class="menu">
						<li><a href="http://liteworks2.com">Litewsorks2 Inc</a> </li>
					</ul>
				</div>
			</section>
  </div>
</div>
    <script>
        (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
                    (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
                m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
        })(window,document,'script','//www.google-analytics.com/analytics.js','ga');

        ga('create', 'UA-28886039-1', 'auto');
        ga('send', 'pageview');

    </script>
	</body>
</html>