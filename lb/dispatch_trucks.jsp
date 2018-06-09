<%@ page import="com.big.util.*,java.text.*,java.util.*,java.io.*,javax.xml.parsers.*,org.w3c.dom.*,java.sql.*,java.text.DateFormat" %>


	<html>

	<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<meta name="description" content="">
	<meta name="author" content="">
	<title>MYTRUCKBOARD 2.0 - dispatch tucks list</title>
	<link rel="shortcut icon" href="http://www.mytruckboard.com/trucking-new/images/mtb-favicon.ico">
	<meta http-equiv="content-type" content="text/html; charset=utf-8" />
	<meta name="description" content="The complete freight management software. Win shipping deals and manage your fleet of trucks effortlessly." />
	<meta name="keywords" content="freight, transportation, dispatch management, load optimization, truck broker, transportation management, truck, truck fleet management, shippers, truck brokers, shipping made easy, trucking industry, trucking software, trucking, dispatch for freight brokder, carrier management, load board, load, board" />

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
    <!-- datepicker related
    <script type="text/javascript" src="js/transition.js"></script>
    <script type="text/javascript" src="js/collapse.js"></script>-->


    <script type="text/javascript" src="js/bootstrap-datetimepicker.min.js"></script>

	<!-- datepicker related -->

    <script type="text/javascript" src="js/notify.min.js"></script>

	<!--<script type="text/javascript"
	src="https://maps.googleapis.com/maps/api/js?key=AIzaSyBpeQ3zGuTunYzxmiNMUltHL352e4beac4">
	</script>
	-->

    <!-- table sorter -->

	<script type="text/javascript" src="js/jquery.tablesorter.js"></script>
	<!-- end -->

	<!-- =============== APP STYLES ===============-->
	<!--<link rel="stylesheet" href="css/table-app.css" id="maincss">

	<!-- Bootstrap core JavaScript
	================================================== -->
	<script src="js/bootstrap2.min.js"></script>


	<link rel="stylesheet" href="css/navstyle2.css" />



	<%if(session.getAttribute("issubscribed")!=null && session.getAttribute("issubscribed").equals("true")){%>
		<%
			String uuid = (String)session.getAttribute("uuid");

			if(uuid !=null){
%>


		</head>


	<body onload="initialize()">

	<!-- Fixed navbar -->
	<nav class="navbar navbar-default navbar-fixed-top">
	<div class="container">
	<div class="navbar-header">
	<button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar">
	<span class="sr-only">Toggle navigation</span>
	<span class="icon-bar"></span>
	<span class="icon-bar"></span>
	<span class="icon-bar"></span>
	</button>
	<a href="new_features.jsp"><span class="image" class="navbar-brand" alt="Home" style="height: 35px; margin-left: 0px; padding: 10px 0px 0px; border-right-width: 0px;"><img src="images/mytryckboard_logo_v2i_small.png"></span></a>
	</div>
	<div id="navbar" class="navbar-collapse collapse">
	<ul class="nav navbar-nav">

	<!--
	<li><a href="new_features.jsp">Home</a></li>
	-->
	<li class="dropdown">
	<a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">Truck Board <span class="caret"></span></a>

	<ul class="dropdown-menu" role="menu">
	<li><a href="standard-truckboard.jsp">Truck Board </a></li>
	<li><a href="truckboard.jsp">Truck Board 2.0</a></li>
	</ul>
	</li>


	<li class="dropdown">

		<%if(session.getAttribute("msg_count")!=null && !session.getAttribute("msg_count").equals("")){%>

	<a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">Messages <span class="badge" style="background:orangered;"><%=session.getAttribute("msg_count")%></span><span class="caret"></span></a>

		<%}else{%>

	<a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">Messages <span class="caret"></span></a>
		<%}%>

	<ul class="dropdown-menu" role="menu">
		<%if(session.getAttribute("isAdmin").equals("true")){%>
	<li><a href="add_message.jsp">Send Message</a></li><%}%>
	<li><a href="message_center.jsp">Message Center</a></li>

	</ul>
	</li>

	<li class="dropdown">
	<a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">Dispatch<span class="caret"></span></a>

	<ul class="dropdown-menu" role="menu">

	<li ><a href="dispatch_board.jsp">Dispatch Board</a></li>
	<li ><a href="dispatch_board.jsp">IFTA</a></li>
	<li ><a href="dispatch_board.jsp">Dashboard</a></li>
	<li ><a href="dispatch_board.jsp">Reports</a></li>
	<li ><a href="dispatch_board.jsp">Financing</a></li>


	</ul>
	</li>

	<li class="dropdown active">
	<a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">Admin<span class="caret"></span></a>

	<ul class="dropdown-menu" role="menu">
	<li><a href="dispatch_customers.jsp?isActive=true&searchKey=">Customers</a></li>
	<li><a href="dispatch_shippers.jsp?isActive=true&searchKey=">Shippers</a></li>
	<li><a href="dispatch_carriers.jsp?isActive=true&searchKey=">Carriers</a></li>
	<li><a href="dispatch_consignees.jsp?isActive=true&searchKey=">Consignees</a></li>
	<li><a href="dispatch_customsbrokers.jsp?isActive=true&searchKey=">Customs Brokers</a></li>

	</ul>
	</li>


	<li class="dropdown">
	<a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">Accounting<span class="caret"></span></a>

	<ul class="dropdown-menu" role="menu">

	<li ><a href="dispatch_board.jsp">Accounting Manager</a></li>
	<li ><a href="dispatch_board.jsp">Driver Pay</a></li>
	<li ><a href="dispatch_board.jsp">Carrier Pay</a></li>
	<li ><a href="dispatch_board.jsp">Sales Rep Commission</a></li>
	<li ><a href="dispatch_board.jsp">Accounting Summary</a></li>


	</ul>
	</li>


	<li class="dropdown ">
	<a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">Add <span class="caret"></span></a>

	<ul class="dropdown-menu" role="menu">
	<li><a href="new_load.jsp">New Load</a></li>
	<li><a href="new_load.jsp?cmd=newLoad&statusLD=Open">New Active Load</a></li>
	<li><a href="new_load.jsp?cmd=newLoad&statusLD=Pending">New Pending Load</a></li>
	<li role="separator" class="divider"></li>
	<li><a href="dispatch_edit_customers.jsp">Add Customer</a></li>
	<li><a href="dispatch_edit_shipper.jsp">Add Shipper</a></li>
	<li><a href="dispatch_shippers.jsp">Add Consignee</a></li>
	<li><a href="dispatch_consignees.jsp">Add Customs Broker</a></li>
	<li><a href="add_truck.jsp">Add Truck</a></li>

	</ul>
	</li>

	</ul>

	<ul class="nav navbar-nav navbar-right">

	<li class="dropdown">
	<a href="#" class="dropdown-toggle active" data-toggle="dropdown" role="button" aria-expanded="false">Hello <b><%=NullCheck.check((String)session.getAttribute("f_name"))%></b> <span class="glyphicon glyphicon-option-vertical"></span></a>
	<ul class="dropdown-menu" role="menu">
	<li><a href="company_profile_view.jsp">My Account</a></li>
		<%if(session.getAttribute("isAdmin").equals("true")){%>
	<li><a href="manage_users.jsp">My Users</a></li>
	<li><a href="manage_teams.jsp">My Teams</a></li>
	<li><a href="add_user.jsp">Add User</a></li>
	<li role="separator" class="divider"></li>
	<li><a href="dispatch_training.html">Training</a></li>
	<li><a href="dispatch_help.html">Help</a></li>

		<%}%>
	<li role="separator" class="divider"></li>
	<li><a href="javascript:void(0)" onclick="logoutuser('<%=session.getAttribute("uuid")%>')" data-toggle="modal" data-target="#logoutconfirm">Log Out</a></li>

	</ul>
	</ul>
	</div><!--/.nav-collapse -->

<HR style="margin-bottom: 5px;margin-top: 5px;">

    <!-- main select row -->
<div class="row">
	<div class="col-sm-12" align="center">

	<form class="form-inline" name="searchForm" id="searchForm" action="dispatch_board.jsp" method="post">


	<label class="radio-inline" style="color:#777; padding: 7px;">
	<input type="radio" name="inlineRadioOptions" id="inlineRadio1" value="option1"> Active
	</label>
	<label class="radio-inline" style="color:#777; padding: 7px;">
	<input type="radio" name="inlineRadioOptions" id="inlineRadio2" value="option2"> Inactive
	</label>



	<div class="form-group form-group-sm">
	<label class="sr-only">SelectForm</label>
	<div class="input-group input-group-sm">
	<div class="input-group-addon" >Find:</div>

	<input type="text" class="form-control" id="searchKey" name="searchKey" placeholder="Search key" value="<%=NullCheck.check(request.getParameter("searchKey"))%>" />

	</div>


	<button class="btn btn-default btn-sm" type="submit" >Go</button>

	</form>
	<!-- end search form -->
	</div>
	</div>


	</div>
	</nav> <!-- end of nav -->


	<!-- Main page: -->

	<div class="container-fluid">
	<div class="row">
	<div class="col-md-12">
	<br/><br/><br/><br/><br/><br/>
	</div>



	<div class="col-md-12">
	<div class="table-responsive">
	<table class="table table-hover table-bordered tablesorter" id="boardtable">
	<thead style="font-size:14px;" >
	<tr style="background:#F8F8F8;">

	<th>Equipment / Trailer </th>
	<th>Last Updated By</th>
	<th>Contact</th>
	<th>Location</th>
	<th>Available</th>
	<th>Wants&nbsp;To&nbsp;Go</th>
	<th>Comments</th>
	<th>Trucker Info</th>
	<th>Insurance Exp. Date</th>
	<th>Covered&nbsp;On</th>
	<th>Covered&nbsp;By</th>
	<th>Reserved Date</th>

	</tr>
	</thead>

	<tbody style="font-size:14px;">

			<tr>
			<td> Truck1</td>
			<td>dispatch1</td>
			<td>Daniel</td>
	<td> Monitowac, WI</td>
	<td>10/12/14</td>
	<td>New York</td>
	<td>None</td>
	<td>xx</td>
	<td>xxx</td>
	<td>x</td>
	<td>xxxx</td>
	<td>10/12/16</td>

			</tr>				

	
	</tbody>
	</table>

	</div>
	</div>
	<!-- END table-responsive-->

	</div>



	<!-- .subfooter start -->
	<!-- ================ -->
	<section id="footer">
	<div class="copyright">
	<ul class="menu">
	<li>Copyright &copy; 2015 Litewsorks2 Inc. All rights reserved.</li>
	</ul>
	<ul class="menu">
	<li>&copy;<a href="http://liteworks2.com">Litewsorks2 Inc</a> </li>
	<li>599 Fairchild Dr, Mountain View, CA 94043 United States</li>
	<li>email: LW2@liteworks2.com </li>
	<li>twitter: @liteworks2</li>
	<li>voice: 1.310.903.6014</li>
	</ul>
	</div>
	<!-- .subfooter end -->
	</section>


	<div class="modal fade" id="delconfirm" role="dialog" aria-labelledby="delconfirm" aria-hidden="true">
	<div class="modal-dialog">
	<div class="modal-content">
	<div class="modal-header">
	<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
	<h4 class="modal-title" id="myModalLabel" style="color:red">Delete Confirmation</h4>
	</div>
	<div class="modal-body">
	<h3>You are about to delete truck from your records.</h3>
	</div>
	<div class="modal-footer">
	<button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
	<button type="button" class="btn btn-primary" id="deleteonclick" >Delete</button>
    <input type="hidden" id="trucktodelete" />

	</div>
	</div>
	</div>
	</div>


	</div> <!--  container end -->


	<!-- this modal kicks in when users click on the logout function, the logout function calls logout.jsp that will clear session attributes, while user gets the modal and is able to go back to the login page -->

	<div class="modal fade" id="logoutconfirm" role="dialog" aria-labelledby="logoutconfirm" aria-hidden="true">
	<div class="modal-dialog">
	<div class="modal-content">
	<div class="modal-header">
	<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
	<h4 class="modal-title" id="myModalLabel" style="color:red">Logout Confirmation</h4>
	</div>
	<div class="modal-body">
	<h4>You have successfully logged out.</h4>
	</div>
	<div class="modal-footer">
	<button type="button" class="btn btn-primary" data-dismiss="modal" onclick="location.href='https://www.mytruckboard.com'">Dismiss</button>

	</div>
	</div>
	</div>
	</div>


	<!------- support modal ---->

	<div class="modal fade" id="support" role="dialog" aria-labelledby="support" aria-hidden="true">
	<div class="modal-dialog">
	<div class="modal-content">
	<div class="modal-header">
	<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
	<h4 class="modal-title" id="myModalLabel" style="color:red">Support Information</h4>
	</div>
	<div class="modal-body">
	<div class="box-sm3a">
	<h2>Support is free.</h2>
	<p>We will get back to you within 24 hours</p>
	<p>Email: <b>lw2@liteworks2.com</b></p>
	<p>Voice: <b>1.310.903.6014</b></p>
	</div>


	</div>
	<div class="modal-footer">
	<button type="button" class="btn btn-primary" data-dismiss="modal">Dismiss</button>

	</div>
	</div>
	</div>
	</div>

	<!-- end of support modal -->

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





		<%}else{%>
	<a href="http://www.myTruckBoard.com">Please Login</a>
		<%}%>



		<%}else{%>


	</head>

	<body>

	<!-- if user's session expired - open the modal box: and upon clicking relogin - send them to the login page -->


	<script type="text/javascript">
	$(window).load(function(){
	$('#relogin').modal('show');
	});
	</script>


	<div class="modal fade" id="relogin" role="dialog" aria-hidden="false" aria-labelledby="relogin">
	<div class="modal-dialog">
	<div class="modal-content">
	<div class="modal-header">
	<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
	<h4 class="modal-title" id="myModalLabel" style="color:red">Session Expired</h4>
	</div>
	<div class="modal-body">
	<h3>Your session has expired. Please login.</h3>
	</div>
	<div class="modal-footer">
	<button type="button" class="btn btn-primary" onclick="location.href='https://www.mytruckboard.com'">Login</button>

	</div>
	</div>
	</div>
	</div>

	</body>
	</html>



		<%}%>
	        	