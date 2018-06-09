<%@ page import="org.apache.http.client.fluent.Form,org.apache.http.client.fluent.Request,org.apache.http.client.methods.HttpGet,org.apache.http.Header,org.apache.http.HttpResponse,org.apache.http.NameValuePair,org.apache.http.client.entity.UrlEncodedFormEntity,org.apache.http.message.BasicNameValuePair,org.apache.http.client.methods.HttpPost,org.apache.http.impl.client.DefaultHttpClient,org.apache.http.client.HttpClient,com.big.util.*,java.text.*,java.util.*,java.io.*,javax.xml.parsers.*,org.w3c.dom.*,java.sql.*,java.text.DateFormat" %>
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
<body>
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

        <a href="https://www.mytruckboard.com"><span class="image navbar-brand"  style="height: 35px; margin-left: 10px; padding: 10px 0px 0px; border-right-width: 0px;"><img src="/trucking-new/images/mtb_app_logo.png" style="width:35px;height:35px;"></span></a>

    </div>
    <div id="navbar" class="navbar-collapse collapse">
    <ul class="nav navbar-nav">
    <li ><a href="https://itunes.apple.com/us/app/mytruckboard-driver/id1044398785?mt=8">MAPS FOR DRIVERS</a></li>
    <li ><a href="../mytruckboard-pricing-plans.html">TMS FOR SHIPPERS</a></li>
    <!--
    <li ><a href="truck_board_public_links.jsp">LINKS</a></li>
    <li ><a href="truck_board_public.jsp">DESKTOP</a></li>
    <li ><a href="truck_board_public_list.jsp">MOBILE</a></li>
    <li ><a href="https://www.mytruckboard.com/articles/loadboard.news.jsp">NEWS</a></li>
    <li ><a href="mtbnlp.html">WHAT'S NLP</a></li>
    <li ><a href="AAAHOME/loadboard.jsp">NLP BOARD</a></li>
    <li ><a href="mtbapi.html">TMS APIs</a></li>
    <li ><a href="http://news.mytruckboard.com">NEWS BOARD</a></li>
    -->



    </ul>
    </div><!--/.nav-collapse -->
    </div>
    </nav>

	<div class="well" style="padding:20px;">

				<%
						String equipment_id = request.getParameter("id");
	String phone_no = "" ;
	String driver_email = "" ;
	String client_id = "" ;
	String driver_name = "" ;
	String company_name = "" ;
	float driver_direction = -0.01f ;
	String wtg = "";
	String basicNotes = "";
	String specialNotes = "";
	String ratePerMile = "";
	int currentState = 0;
	int currentTruckType = 0;
	int averageSpeed = 0;
	int maxSpeed = 0;
	int totalCountDelivered = 0;
	String createdDate = "";
							
						try{
							Class.forName("com.mysql.jdbc.Driver");
							String urldb = "jdbc:mysql://localhost/maids_oltp?user=<USER>&password=<PASSWORD>";			
							Connection connection = DriverManager.getConnection(urldb);			
							PreparedStatement psMain = connection.prepareStatement("select * from maids_oltp.maids_customers where key_public = ? ");
							psMain.setString(1, request.getParameter("equipmentID"));
							ResultSet resultSet = psMain.executeQuery();
							while (resultSet.next()) {
								client_id = resultSet.getString("client_id");
							}
							connection.close();		
						 }catch (Exception ex){	         
						     %><%="Error Posting " + ex%><%  
						     System.out.println(""+ ex);
						 }						 
						try{
							Class.forName("com.mysql.jdbc.Driver");
							String urldb = "jdbc:mysql://localhost/maids_oltp?user=<USER>&password=<PASSWORD>";			
							Connection connection = DriverManager.getConnection(urldb);			
							PreparedStatement psMain = connection.prepareStatement("select count(archive_id) as itemCount  from maids_oltp.customer_location_archive where client_id = ? ");
							psMain.setString(1, client_id);
							ResultSet resultSet = psMain.executeQuery();
							while (resultSet.next()) {
								totalCountDelivered = resultSet.getInt("itemCount");							
							}
							psMain = connection.prepareStatement("select  SUM(speedCurrent)/count(speedCurrent) AS itemCount from maids_oltp.customer_location_archive where client_id = ? and speedCurrent > 1");
							psMain.setString(1, client_id);
							resultSet = psMain.executeQuery();
							while (resultSet.next()) {
								averageSpeed = resultSet.getInt("itemCount");							
							}
							psMain = connection.prepareStatement("select  max(speedCurrent) AS itemCount from maids_oltp.customer_location_archive where client_id = ? and speedCurrent > 1");
							psMain.setString(1, client_id);
							resultSet = psMain.executeQuery();
							while (resultSet.next()) {
								maxSpeed = resultSet.getInt("itemCount");							
							}
							
							psMain = connection.prepareStatement("select * from maids_oltp.maids_customers where key_public = ? ");
							psMain.setString(1, request.getParameter("equipmentID"));
							resultSet = psMain.executeQuery();
							while (resultSet.next()) {
								phone_no = resultSet.getString("phone");
								driver_email =  resultSet.getString("email");
								client_id = resultSet.getString("client_id");
								driver_name= NullCheck.check(resultSet.getString("f_name")) + " " + NullCheck.check(resultSet.getString("l_name"));
								company_name =NullCheck.check(resultSet.getString("company_name"));
								driver_direction = resultSet.getFloat("directionCurrent");
								wtg = NullCheck.check(resultSet.getString("wtg"));
								basicNotes = NullCheck.check(resultSet.getString("basicNotes"));
								specialNotes= NullCheck.check(resultSet.getString("specialNotes"));
								ratePerMile = (new DecimalFormat("#.00")).format(resultSet.getFloat("price_per_mile"));
								if(resultSet.getString("current_State")!=null){
									currentState = Integer.parseInt(resultSet.getString("current_State"));
								}
								if(resultSet.getString("currentTruckType")!=null){
									currentTruckType = Integer.parseInt(resultSet.getString("currentTruckType"));
								}
								createdDate = new SimpleDateFormat("YY-MM-dd HH:mm").format(resultSet.getDate("ts"));
								
							}
							connection.close();		
						 }catch (Exception ex){	         
						     %><%="Error Posting " + ex%><%  
						     System.out.println(""+ ex);
						 }
						 					
						
						%>

	
	
	<li class="list-group-item" style="background-image: url('http://nuculeus.io/io/image.jsp?imageTypeFormat=landscape&imageType=1024&userid=b2d4402b-4f95-4cdb-bb0b-ac4440aac2b9');background-size: cover;">
	<div class="text-center" >
						 <a href="truck_board_public_driver.jsp?equipmentID=<%=request.getParameter("equipmentID")%>"><img src="../AAA/getImageService.byCustomer.pub.id.jsp?client_id=<%=request.getParameter("equipmentID")%>"   style="opacity: 0.9;border-bottom: thick solid green;width:100%;max-width:250px;" /></a>
	</div>	
	
</li>
	<li class="list-group-item list-group-item-success">	
	<h4 class="text-center" >
	 <%if(!driver_name.trim().equals("")){%><%=driver_name%><%
	 }else{%>[No Name]<%}%></h4>
	 		</li> 
		<li class="list-group-item" style="background-color:gray;color:white;">	
				&nbsp;
	 <%if(!company_name.equals("")){%><%=company_name%><%}else{%>[No Company Name]<%}%>
		</li> 	
	
	<li class="list-group-item">
	<%	String[] driver_state = {"OFFLINE", "SLEEPING", "RESTING", "DRIVING", "ONLINE"};%>
	
	 		
	<%	String[] current_truck_type = {"DRY VAN TRUCK", "FLATBED TRUCK", "REEFER TRUCK", "BOX TRUCK", "CAR CARRIER TRUCK"};%>
	<div class="text-center">
	<%=current_truck_type[currentTruckType]%>
	
	  <B>DRIVER IS</B> <%=driver_state[currentState]%>
	</div>
	<div class="float:left">
	<a href="../mytruckboard-pricing-plans.html">Connect</a>
	</div>
	 		</li>		
		<li class="list-group-item">	&nbsp;
						<%if(phone_no.length()<15){%><%=phone_no%><%}else{%>none<%}%>
		
    <span class="badge pull-left"><span class="glyphicon glyphicon-phone" aria-hidden="true" ></span></span></li> 	
		<li class="list-group-item">	&nbsp;
			<%=driver_email%>
          
    <span class="badge pull-left"><span class="glyphicon glyphicon-envelope" aria-hidden="true" ></span></span>                      
</li> 	 	 

		<%if(basicNotes!=null || !basicNotes.equals("")){%>
	<li class="list-group-item">
	<span class="badge pull-left"><span class="glyphicon glyphicon-pencil" aria-hidden="true" > </span></span>
	<span class="pull-left"> &nbsp;Notes?</span>&nbsp;
	<span class="pull-right" style="background-color:white;color:black;"> <%=NullCheck.check(basicNotes)%></span></li>
	</li>
		<%}%>	
		<%if(specialNotes!=null || !specialNotes.equals("")){%>
	<li class="list-group-item">
	<span class="badge pull-left"><span class="glyphicon glyphicon-pencil" aria-hidden="true" > </span></span>
	<span class="pull-left"> &nbsp;Special Notes?</span>&nbsp;
	<span class="pull-right" style="background-color:white;color:black;"> <%=NullCheck.check(specialNotes)%></span></li>
	</li>
		<%}%>	
		<%if(wtg!=null || !wtg.equals("")){%>
	<li class="list-group-item">
	<span class="badge pull-left"><span class="glyphicon glyphicon-flag" aria-hidden="true" > </span></span>
	<span class="pull-left"> &nbsp;WANTS TO GO TO?</span>&nbsp;
	<span class="pull-right" style="background-color:white;color:black;"> <%=NullCheck.check(wtg)%></span></li>
	</li>
		<%}%>	

		<%if(averageSpeed>0){%>
	<li class="list-group-item">
	<span class="badge pull-left"><span class="glyphicon glyphicon-dashboard" aria-hidden="true" > </span></span>
	<span class="pull-left"> &nbsp;AVERAGE SPEED</span>&nbsp;
	<span class="badge pull-right" style="background-color:white;color:black;"><%=averageSpeed%><small> mph.</small></span>
	</li>
	<%}
							if(maxSpeed>0){%> 
							
	<li class="list-group-item">
	<span class="badge pull-left"><span class="glyphicon glyphicon-dashboard" aria-hidden="true" > </span></span>
	<span class="pull-left"> &nbsp;MAXIMUM SPEED</span>&nbsp;
	<span class="badge pull-right" style="background-color:white;color:black;"><%=maxSpeed%><small> mph.</small></span></li><%}%>			

							<%
							if(totalCountDelivered>0){%>
							
	<li class="list-group-item">
	<span class="badge pull-left"><span class="glyphicon glyphicon-flag" aria-hidden="true" > </span></span>
	<span class="pull-left"> &nbsp;LOCATION HISTORY</span>&nbsp;
	<span class="badge pull-right" style="background-color:white;color:black;"><%=totalCountDelivered%></span></li>
	<%}%>
	<%
String directions[] = {"NORTH", "NORTHEAST", "EAST", "SOUTHEAST", "SOUTH", "SOUTHWEST", "WEST", "NORTHWEST", "NORTH"};
String dierctionText  =  directions[ (int)Math.round((  ((double)driver_direction % 360) / 45)) ];
if(driver_direction>0.0f){
%>
	<li class="list-group-item">
	<span class="badge pull-left" ><span class="glyphicon glyphicon-road" aria-hidden="true" > </span></span>
	<span class="pull-left" > &nbsp;Heading</span>&nbsp;
	<span class="badge pull-right" style="background-color:white;color:black;"><%=dierctionText%></span></li><%}%>
	</ul>

	<%if(ratePerMile!=null && !ratePerMile.equals("")){%>
	<li class="list-group-item">
	<span class="badge pull-left"><span class="glyphicon glyphicon-usd" aria-hidden="true" > </span></span>
	<span class="pull-left"> &nbsp;Rate </span>&nbsp;
	<span class="badge pull-right" style="background-color:white;color:black;">$<%=ratePerMile%></span></li>
	</li>
		<%}%>	
	<li class="list-group-item">
	<div class="text-center"><%=createdDate%></div>
	</li>
		
		<HR>
		<div  style="width:100%;text-align:center;">
<div id="fb-root" style="width:100%;"></div>
<script>(function(d, s, id) {
  var js, fjs = d.getElementsByTagName(s)[0];
  if (d.getElementById(id)) return;
  js = d.createElement(s); js.id = id;
  js.src = "//connect.facebook.net/en_US/sdk.js#xfbml=1&version=v2.7&appId=429570967243595";
  fjs.parentNode.insertBefore(js, fjs);
}(document, 'script', 'facebook-jssdk'));</script>

	<div class="fb-share-button" 
		data-href="https://mytruckboard.com/trucking-new/truck_board_public_driver.jsp?equipmentID=<%=request.getParameter("equipmentID")%>" 
		data-layout="button_count">
	</div>	
<div class="fb-like" data-href="https://mytruckboard.com/<%=request.getParameter("equipmentID")%>" data-layout="button_count" data-action="like" data-size="small" data-show-faces="true" data-share="true"></div>	
  <div class="fb-save" 
    data-uri="https://mytruckboard.com/trucking-new/truck_board_public_driver.jsp?equipmentID=<%=request.getParameter("equipmentID")%>">
  </div>
	<div class="fb-send" 
		data-href="https://mytruckboard.com/trucking-new/truck_board_public_driver.jsp?equipmentID=<%=request.getParameter("equipmentID")%>" 
		data-layout="button_count">
	</div>  	
<div class="fb-comments" style="width:100%;" data-href="https://myTruckBoard.com#<%=request.getParameter("equipmentID")%>" data-numposts="5"></div>		
	
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