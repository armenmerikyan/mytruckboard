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

        <a href="https://www.mytruckboard.com"><span class="image navbar-brand"  style="height: 35px; margin-left: 10px; padding: 10px 0px 0px; border-right-width: 0px;"><img src="/trucking-new/images/mtb_app_logo.png" style="width:35px;height:35px;" ></span></a>

    </div>
    <div id="navbar" class="navbar-collapse collapse">
    <ul class="nav navbar-nav">
    <li ><a href="https://itunes.apple.com/us/app/mytruckboard-driver/id1044398785?mt=8">MAPS FOR DRIVERS</a></li>
    <li ><a href="../mytruckboard-pricing-plans.html">TMS FOR SHIPPERS</a></li>
    <li ><a href="https://www.mytruckboard.com/articles/loadboard.news.jsp">TRUCKING NEWS</a></li>
    <li class="active"><a href="truck_board_public_links.jsp">TMS LINKS</a></li>
    <!--
    <li ><a href="truck_board_public.jsp">DESKTOP</a></li>
    <li ><a href="truck_board_public_list.jsp">MOBILE</a></li>
    <li ><a href="https://itunes.apple.com/us/app/mytruckboard-driver/id1044398785?mt=8">iOS APP</a></li>
    <li ><a href="https://www.mytruckboard.com/articles/loadboard.news.jsp">NEWS</a></li>
    <li ><a href="truck_board_public_links.jsp">LINKS</a></li>
    <li ><a href="../mytruckboard-pricing-plans.html">MTB-MEMBERS</a></li>
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

<h3 style="padding:20px;">"MY TRUCK BOARD" Links Search</h3> 
<div class="panel panel-default" style="border-color:white;">
  <div class="panel-head" style="padding:20px;border-color:white;">
    <form action="truck_board_public_links.jsp" method="post" id="searchForm">
	<div class="input-group input-group-lg">
	  <span class="input-group-addon" id="basic-addon1"><span class="glyphicon glyphicon-search" aria-hidden="true"></span></span>
	  <input type="text" class="form-control" placeholder="Trucks" aria-describedby="basic-addon1" id="searchKey" name="searchKey" value="<%=NullCheck.check(request.getParameter("searchKey"))%>" >
      <span class="input-group-addon">
      <div class="btn-group btn-group-xs" role="group" aria-label="...">
	  <button type="button" class="btn btn-default" onclick="document.getElementById('searchForm').submit();" >SEARCH</button></div></span>
	</div>
	</form>	
</div>
  <div class="panel-body" style="padding:20px;border-color:white;">

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
			
			PreparedStatement psMain = connection.prepareStatement("select * from maids_oltp.links");
            		if(request.getParameter("searchKey")!=null && !request.getParameter("searchKey").equals("")){
				psMain = connection.prepareStatement("select * from maids_oltp.links where url_title like ? or url_keywords like ? ");
            			psMain.setString(1,"%" + request.getParameter("searchKey") + "%");
            			psMain.setString(2,"%" + request.getParameter("searchKey") + "%");
			}
			
			ResultSet resultSet = psMain.executeQuery();
			int j = 1;
			while (resultSet.next()) {		
				
				%>

<div class="jumbotron" style="padding:20px;">
  <h2>				
  <%
  String displayURL = resultSet.getString("url");
  if(resultSet.getString("url").contains("/")){
  	displayURL = resultSet.getString("url").substring(0, resultSet.getString("url").indexOf("/"));
  }
  %>
  <a target="_blank"  href="http://<%=resultSet.getString("url")%>" ><%=displayURL%></a>
				
  <p>
  <ul class="list-group">
  <li class="list-group-item">
				<small><span class="glyphicon glyphicon-link" aria-hidden="true" ></span> info:</small> 
				<%if(NullCheck.check(resultSet.getString("url_title")).equals("")){%>[No Name]<%}else{%><%=resultSet.getString("url_title")%><%}%>
				<small><small> <%if(NullCheck.check(resultSet.getString("url_keywords")).equals("")){%>[No tags]<%}else{%><%=resultSet.getString("url_keywords")%><%}%></small> </small> 
</li>		

</ul>					</p>
</div>

				<%
						
	  		}


	  				connection.close();
		 			}catch (Exception ex){
		     		%><%="Error Posting " + ex%><%
		     		System.out.println(""+ ex);}
				%>


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