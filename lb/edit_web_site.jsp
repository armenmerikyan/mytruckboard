<%@ page import="com.big.util.*,java.text.*,java.util.*,java.io.*,javax.xml.parsers.*,org.w3c.dom.*,java.sql.*,java.text.DateFormat" %>
        <!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">

        <title>Web Profile Edit - MYTRUCKBOARD 2.0 - dead simple freight dispatch</title>
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

        <script type="text/javascript" src="js/jquery-2.1.3.min.js"></script>
        <script type="text/javascript" src="js/jquery-ui.min.js"></script>


    <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
    <!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
      <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->

        <!-- Bootstrap core JavaScript
        ================================================== -->
        <!-- Placed at the end of the document so the pages load faster -->
        <script src="js/bootstrap2.min.js"></script>



        </head>



<%
String uuid = (String)session.getAttribute("uuid");
String truck_count = "0";
boolean needStatusUpdate = false;
if(uuid !=null){
%>
            <%if(session.getAttribute("isAdmin").equals("true") && request.getParameter("cmd")!=null && request.getParameter("cmd").equals("saveComment")){%>
            <%
		 try{
			Class.forName("com.mysql.jdbc.Driver");
			String url = "jdbc:mysql://localhost/test?zeroDateTimeBehavior=convertToNull";
			Connection connection = DriverManager.getConnection(url,"<USERNAME>", "<PASSWORD>");
			PreparedStatement ps = connection.prepareStatement("Update test.trucking_company Set contact_info_web = ?, value_add_web = ?, introduction_web = ?, static_info_web = ?, fax_web = ?, phone_web = ?, email_web = ?, isOnlineRegistrationOnDriver = ?, isOnlineRegistrationOnShipper = ?, isOnlineRegistrationOnAgent = ?, isOnlineRegistrationOnDriverLogin = ?, isOnlineRegistrationOnShipperLogin = ?, isOnlineRegistrationOnAgentLogin = ?, linkedin_url = ?,  twitter_url = ?, facebook_url = ?, youtube_url = ?, yelp_url = ?, skype_url = ?, whatsapp_url = ?, instagram_url = ?, vimeo_url = ?, vine_url = ?, amazon_url = ?, angellist_url = ?, isOnlineRegistrationOnAgentShip = ?, isOnlineRegistrationOnAgentTruck = ?, isLockInactive = ?, isOnlineRegistrationOnCarrierLogin = ?, isOnlineRegistrationOnCarrier = ? where COMPANY_ID = ?");
			ps.setString(1, request.getParameter("contact_info_web"));
			ps.setString(2, request.getParameter("value_add_web"));
			ps.setString(3, request.getParameter("introduction_web"));
			ps.setString(4, request.getParameter("static_info_web"));
			ps.setString(5, request.getParameter("fax_web"));
			ps.setString(6, request.getParameter("phone_web"));
			ps.setString(7, request.getParameter("email_web"));
			if(request.getParameter("isOnlineRegistrationOnDriver").equals("isOnline")){
				ps.setBoolean(8, true);
			}else if(request.getParameter("isOnlineRegistrationOnDriver").equals("isOffline")){
				ps.setBoolean(8, false);
			}else{
				ps.setInt(8, 2);
			}
			if(request.getParameter("isOnlineRegistrationOnShipper").equals("isOnline")){
				ps.setBoolean(9, true);
			}else if(request.getParameter("isOnlineRegistrationOnShipper").equals("isOffline")){
				ps.setBoolean(9, false);
			}else{
				ps.setInt(9, 2);
			}
			if(request.getParameter("isOnlineRegistrationOnAgent").equals("isOnline")){
				ps.setBoolean(10, true);
			}else if(request.getParameter("isOnlineRegistrationOnAgent").equals("isOffline")){
				ps.setBoolean(10, false);
			}else{
				ps.setInt(10, 2);
			}
			if(request.getParameter("isOnlineRegistrationOnDriverLogin").equals("isOnline")){
				ps.setBoolean(11, true);
			}else if(request.getParameter("isOnlineRegistrationOnDriverLogin").equals("isOffline")){
				ps.setBoolean(11, false);
			}else{
				ps.setInt(11, 2);
			}
			if(request.getParameter("isOnlineRegistrationOnShipperLogin").equals("isOnline")){
				ps.setBoolean(12, true);
			}else if(request.getParameter("isOnlineRegistrationOnShipperLogin").equals("isOffline")){
				ps.setBoolean(12, false);
			}else{
				ps.setInt(12, 2);
			}
			if(request.getParameter("isOnlineRegistrationOnAgentLogin").equals("isOnline")){
				ps.setBoolean(13, true);
			}else if(request.getParameter("isOnlineRegistrationOnAgentLogin").equals("isOffline")){
				ps.setBoolean(13, false);
			}else{
				ps.setInt(13, 2);
			}			
			
			ps.setString(14, request.getParameter("linkedin_url"));
			ps.setString(15, request.getParameter("twitter_url"));
			ps.setString(16, request.getParameter("facebook_url"));
			ps.setString(17, request.getParameter("youtube_url"));
			ps.setString(18, request.getParameter("yelp_url"));
			ps.setString(19, request.getParameter("skype_url"));
			ps.setString(20, request.getParameter("whatsapp_url"));
			ps.setString(21, request.getParameter("instagram_url"));
			ps.setString(22, request.getParameter("vimeo_url"));
			ps.setString(23, request.getParameter("vine_url"));
			ps.setString(24, request.getParameter("amazon_url"));
			ps.setString(25, request.getParameter("angellist_url"));
			if(request.getParameter("isOnlineRegistrationOnAgentShip").equals("isOnline")){
				ps.setBoolean(26, true);
			}else if(request.getParameter("isOnlineRegistrationOnAgentShip").equals("isOffline")){
				ps.setBoolean(26, false);
			}else{
				ps.setInt(26, 2);
			}
			if(request.getParameter("isOnlineRegistrationOnAgentTruck").equals("isOnline")){
				ps.setBoolean(27, true);
			}else if(request.getParameter("isOnlineRegistrationOnAgentTruck").equals("isOffline")){
				ps.setBoolean(27, false);
			}else{
				ps.setInt(27, 2);
			}
			if(request.getParameter("isOnlineRegistrationOnCarrier").equals("isOnline")){
				ps.setBoolean(28, true);
			}else if(request.getParameter("isOnlineRegistrationOnCarrier").equals("isOffline")){
				ps.setBoolean(28, false);
			}else{
				ps.setInt(28, 2);
			}
			if(request.getParameter("isOnlineRegistrationOnCarrierLogin").equals("isOnline")){
				ps.setBoolean(29, true);
			}else if(request.getParameter("isOnlineRegistrationOnCarrierLogin").equals("isOffline")){
				ps.setBoolean(29, false);
			}else{
				ps.setInt(29, 2);
			}
			if(request.getParameter("isOnlineRegistrationOnDriverLogin").equals("isOnline")){
				ps.setBoolean(30, true);
			}else if(request.getParameter("isOnlineRegistrationOnDriverLogin").equals("isOffline")){
				ps.setBoolean(30, false);
			}else{
				ps.setInt(30, 2);
			}			
			ps.setString(31, uuid);
			ps.executeUpdate();
			connection.close();
		 }catch (Exception ex){
		     %><%="Error Posting " + ex%><%
		     System.out.println(""+ ex);
		 }
				%>



            <%}%>

        <!-- logout function  -->
        <script>
        function logoutuser(userID) {
        var xmlhttp;
        if (window.XMLHttpRequest)
        {// code for IE7+, Firefox, Chrome, Opera, Safari
        xmlhttp=new XMLHttpRequest();
        }
        else
        {// code for IE6, IE5
        xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
        }
        var userID2 = userID;
        var gov ="true"
        xmlhttp.open("get", "logout.jsp?id=" + userID2 +"&GO=" + gov ,true);
        xmlhttp.send();

        }
        </script>
        <body>
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
                <a href="new_features.jsp"><span class="image" class="navbar-brand"  style="height: 35px; margin-left: 0px; padding: 10px 0px 0px; border-right-width: 0px;"><img src="images/mytryckboard_logo_v2i_small.png"></span></a>
                </div>
                <div id="navbar" class="navbar-collapse collapse">
                <ul class="nav navbar-nav">
                <li><a href="standard-truckboard.jsp">Truck Board</a></li>
                <li><a href="truckboard.jsp">Truck Board 2.0 <small><strong>(new)</strong></small></a></li>
                <li><a href="new_features.jsp">What's New</a></li>

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
        <li><a href="#" data-toggle="modal" data-target="#support">Support</a></li>

        </ul>

        <ul class="nav navbar-nav navbar-right">

        <li class="dropdown active">
        <a href="#" class="dropdown-toggle active" data-toggle="dropdown" role="button" aria-expanded="false">Hello <b><%=NullCheck.check((String)session.getAttribute("f_name"))%></b><span class="caret"></span></a>
        <ul class="dropdown-menu" role="menu">
        <li><a href="company_profile_view.jsp">My Account</a></li>
            <%if(session.getAttribute("isAdmin").equals("true")){%>
        <li><a href="manage_users.jsp">My Users</a></li>
        <li><a href="add_user.jsp">Add User</a></li>
        <li><a href="add_truck.jsp">Add Truck</a></li>
            <%}%>

        <li><a href="javascript:void(0)" onclick="logoutuser('<%=session.getAttribute("uuid")%>')" data-toggle="modal" data-target="#logoutconfirm">Log Out</a></li>

        </ul>
        </ul>
        </div><!--/.nav-collapse -->


      </div>
    </nav>

            <%
            try{
		if(session.getAttribute("isAdmin").equals("true")){
		
			Class.forName("com.mysql.jdbc.Driver");
			String url = "jdbc:mysql://localhost/test?zeroDateTimeBehavior=convertToNull";
			Connection connection = DriverManager.getConnection(url,"<USERNAME>", "<PASSWORD>");

			PreparedStatement ps = connection.prepareStatement("select * from test.trucking_company where COMPANY_ID = ? ");
			ps.setString(1, uuid);
			ResultSet resultSet = ps.executeQuery();
			while (resultSet.next()) {
			%>

        <section id="company"></section><br/><br/><br/><br/>
<div class="panel panel-default">
  <div class="panel-body">        
        <p>
        <h1>Edit Web Content</h1>
        <hr>
        <div class="row">
        <!-- edit form column -->
        <div class="col-md-9 personal-info">

        <form action="edit_web_site.jsp" method="post" class="form-horizontal" role="form">
        <input type="hidden" name="cmd" value="saveComment">
        <input type="hidden" name="id" value="<%=uuid%>">
        
        <div class="form-group">
        <label class="col-lg-3 control-label">Web Phone:</label>
        <div class="col-lg-8">
        <input class="form-control" type="text" name="phone_web"  value="<%=NullCheck.check(resultSet.getString("phone_web"))%>">
        </div>
        </div>
        
        <div class="form-group">
        <label class="col-lg-3 control-label">Web Email:</label>
        <div class="col-lg-8">
        <input class="form-control" type="text" name="email_web"  value="<%=NullCheck.check(resultSet.getString("email_web"))%>">
        </div>
        </div>
        
        <div class="form-group">
        <label class="col-lg-3 control-label">Web Fax:</label>
        <div class="col-lg-8">
        <input class="form-control" type="text" name="fax_web"  value="<%=NullCheck.check(resultSet.getString("fax_web"))%>">
        </div>
        </div>
        
        <div class="form-group">
        <label class="col-lg-3 control-label">Introduction:</label>
        <div class="col-lg-8"><textarea  class="form-control" name="introduction_web"> <%=NullCheck.check(resultSet.getString("introduction_web"))%></textarea>
        </div>
        </div>
        
        <div class="form-group">
        <label class="col-lg-3 control-label">Value Added:</label>
        <div class="col-lg-8">
        <textarea class="form-control" type="text" name="value_add_web" ><%=NullCheck.check(resultSet.getString("value_add_web"))%></textarea>
        </div>
        </div>
        
        <div class="form-group">
        <label class="col-lg-3 control-label">Contact Info:</label>
        <div class="col-lg-8">
        <textarea class="form-control" type="text" name="contact_info_web" ><%=NullCheck.check(resultSet.getString("contact_info_web"))%></textarea>
        </div>
        </div>
        
        <div class="form-group">
        <label class="col-md-3 control-label">Static Info:</label>
        <div class="col-md-8">
        <textarea class="form-control" type="text" name="static_info_web" ><%=NullCheck.check(resultSet.getString("static_info_web"))%></textarea>
        </div>
        </div>        
        
        <div class="form-group">
        <label class="col-lg-3 control-label">LinkedIn URL:</label>
        <div class="col-lg-8">
        <input class="form-control" type="text" name="linkedin_url" value="<%=NullCheck.check(resultSet.getString("linkedin_url"))%>">
        </div>
        </div>
        <div class="form-group">
        <label class="col-lg-3 control-label">Twitter URL:</label>
        <div class="col-lg-8">
        <input class="form-control" type="text" name="twitter_url" value="<%=NullCheck.check(resultSet.getString("twitter_url"))%>">
        </div>
        </div>
        <div class="form-group">
        <label class="col-lg-3 control-label">Facebook URL:</label>
        <div class="col-lg-8">
        <input class="form-control" type="text" name="facebook_url" value="<%=NullCheck.check(resultSet.getString("facebook_url"))%>">
        </div>
        </div>
        <div class="form-group">
        <label class="col-lg-3 control-label">YouTube URL:</label>
        <div class="col-lg-8">
        <input class="form-control" type="text" name="youtube_url" value="<%=NullCheck.check(resultSet.getString("youtube_url"))%>">
        </div>
        </div>
        <div class="form-group">
        <label class="col-lg-3 control-label">Yelp URL:</label>
        <div class="col-lg-8">
        <input class="form-control" type="text" name="yelp_url" value="<%=NullCheck.check(resultSet.getString("yelp_url"))%>">
        </div>
        </div>
        <div class="form-group">
        <label class="col-lg-3 control-label">Skype URL:</label>
        <div class="col-lg-8">
        <input class="form-control" type="text" name="skype_url" value="<%=NullCheck.check(resultSet.getString("skype_url"))%>">
        </div>
        </div>
        <div class="form-group">
        <label class="col-lg-3 control-label">Whatsapp URL:</label>
        <div class="col-lg-8">
        <input class="form-control" type="text" name="whatsapp_url" value="<%=NullCheck.check(resultSet.getString("whatsapp_url"))%>">
        </div>
        </div>
        <div class="form-group">
        <label class="col-lg-3 control-label">Instagram URL:</label>
        <div class="col-lg-8">
        <input class="form-control" type="text" name="instagram_url" value="<%=NullCheck.check(resultSet.getString("instagram_url"))%>">
        </div>
        </div>
        <div class="form-group">
        <label class="col-lg-3 control-label">Vimeo URL:</label>
        <div class="col-lg-8">
        <input class="form-control" type="text" name="vimeo_url" value="<%=NullCheck.check(resultSet.getString("vimeo_url"))%>">
        </div>
        </div>
        <div class="form-group">
        <label class="col-lg-3 control-label">Vine URL:</label>
        <div class="col-lg-8">
        <input class="form-control" type="text" name="vine_url" value="<%=NullCheck.check(resultSet.getString("vine_url"))%>">
        </div>
        </div>
        <div class="form-group">
        <label class="col-lg-3 control-label">Amazon URL:</label>
        <div class="col-lg-8">
        <input class="form-control" type="text" name="amazon_url" value="<%=NullCheck.check(resultSet.getString("amazon_url"))%>">
        </div>
        </div>
        <div class="form-group">
        <label class="col-lg-3 control-label">Angel List URL:</label>
        <div class="col-lg-8">
        <input class="form-control" type="text" name="angellist_url" value="<%=NullCheck.check(resultSet.getString("angellist_url"))%>">
        </div>
        </div>
        
	    	<div class="form-group">
	        <label class="col-sm-3 control-label"></label>
	        <label class="col-sm-3 control-label">CARRIER Online Registration</label>
	        <div class="col-sm-1">
	        <label style="color:green" ><input class="form-control" type="radio" name="isOnlineRegistrationOnCarrier" value="isOnline" style="width: 18px; height: 18px;" <%if(resultSet.getInt("isOnlineRegistrationOnCarrier")==1){%>checked<%}%> > On&nbsp;&nbsp;</label>
	        <label style="color:red"><input class="form-control" type="radio" name="isOnlineRegistrationOnCarrier" value="isOffline" style="width: 18px; height: 18px;" <%if(resultSet.getInt("isOnlineRegistrationOnCarrier")==0){%>checked<%}%> > Off </label>
	        </div>
	        <label class="col-sm-3 control-label">CARRIER Online Login</label>
	        <div class="col-sm-1">
	        <label style="color:green" ><input class="form-control" type="radio" name="isOnlineRegistrationOnCarrierLogin" value="isOnline" style="width: 18px; height: 18px;" <%if(resultSet.getInt("isOnlineRegistrationOnCarrierLogin")==1){%>checked<%}%> > On&nbsp;&nbsp;</label>
	        <label style="color:red"><input class="form-control" type="radio" name="isOnlineRegistrationOnCarrierLogin" value="isOffline" style="width: 18px; height: 18px;" <%if(resultSet.getInt("isOnlineRegistrationOnCarrierLogin")==0){%>checked<%}%> > Off </label>
	        </div>
        </div>
    	<div class="form-group">
        <label class="col-sm-3 control-label"></label>
        <label class="col-sm-3 control-label">DRIVERS Online Registration</label>
        <div class="col-sm-1">
        <label style="color:green" ><input class="form-control" type="radio" name="isOnlineRegistrationOnDriver" value="isOnline" style="width: 18px; height: 18px;" <%if(resultSet.getInt("isOnlineRegistrationOnDriver")==1){%>checked<%}%> > On&nbsp;&nbsp;</label>
        <label style="color:red"><input class="form-control" type="radio" name="isOnlineRegistrationOnDriver" value="isOffline" style="width: 18px; height: 18px;" <%if(resultSet.getInt("isOnlineRegistrationOnDriver")==0){%>checked<%}%> > Off </label>
        </div>
        <label class="col-sm-3 control-label">DRIVERS Online Login</label>
        <div class="col-sm-1">
        <label style="color:green" ><input class="form-control" type="radio" name="isOnlineRegistrationOnDriverLogin" value="isOnline" style="width: 18px; height: 18px;" <%if(resultSet.getInt("isOnlineRegistrationOnDriverLogin")==1){%>checked<%}%> > On&nbsp;&nbsp;</label>
        <label style="color:red"><input class="form-control" type="radio" name="isOnlineRegistrationOnDriverLogin" value="isOffline" style="width: 18px; height: 18px;" <%if(resultSet.getInt("isOnlineRegistrationOnDriverLogin")==0){%>checked<%}%> > Off </label>
        </div>
        </div>
    <div class="form-group">
        <label class="col-sm-3 control-label"></label>
        <label class="col-sm-3 control-label">SHIPPERS Online Registration</label>
        <div class="col-sm-1">
        <label style="color:green" ><input class="form-control" type="radio" name="isOnlineRegistrationOnShipper" value="isOnline" style="width: 18px; height: 18px;" <%if(resultSet.getInt("isOnlineRegistrationOnShipper")==1){%>checked<%}%>> On&nbsp;&nbsp;</label>
        <label style="color:red"><input class="form-control" type="radio" name="isOnlineRegistrationOnShipper" value="isOffline" style="width: 18px; height: 18px;" <%if(resultSet.getInt("isOnlineRegistrationOnShipper")==0){%>checked<%}%>> Off</label>
        </div>
        <label class="col-sm-3 control-label">SHIPPERS Online Login</label>
        <div class="col-sm-1">
        <label style="color:green" ><input class="form-control" type="radio" name="isOnlineRegistrationOnShipperLogin" value="isOnline" style="width: 18px; height: 18px;" <%if(resultSet.getInt("isOnlineRegistrationOnShipperLogin")==1){%>checked<%}%> > On&nbsp;&nbsp;</label>
        <label style="color:red"><input class="form-control" type="radio" name="isOnlineRegistrationOnShipperLogin" value="isOffline" style="width: 18px; height: 18px;" <%if(resultSet.getInt("isOnlineRegistrationOnShipperLogin")==0){%>checked<%}%> > Off </label>
        </div>
        </div>
   	<div class="form-group">
        <label class="col-sm-3 control-label"></label>
        <label class="col-sm-3 control-label">DISPATCHERS Online Registration</label>
        <div class="col-sm-1">
        <label style="color:green" ><input class="form-control" type="radio" name="isOnlineRegistrationOnAgent" value="isOnline" style="width: 18px; height: 18px;" <%if(resultSet.getInt("isOnlineRegistrationOnAgent")==1){%>checked<%}%>> On&nbsp;&nbsp;</label>
        <label style="color:red"><input class="form-control" type="radio" name="isOnlineRegistrationOnAgent" value="isOffline" style="width: 18px; height: 18px;" <%if(resultSet.getInt("isOnlineRegistrationOnAgent")==0){%>checked<%}%>> Off</label>
        </div>
        <label class="col-sm-3 control-label">DISPATCHERS Online Login</label>
        <div class="col-sm-1">
        <label style="color:green" ><input class="form-control" type="radio" name="isOnlineRegistrationOnAgentLogin" value="isOnline" style="width: 18px; height: 18px;" <%if(resultSet.getInt("isOnlineRegistrationOnAgentLogin")==1){%>checked<%}%> > On&nbsp;&nbsp;</label>
        <label style="color:red"><input class="form-control" type="radio" name="isOnlineRegistrationOnAgentLogin" value="isOffline" style="width: 18px; height: 18px;" <%if(resultSet.getInt("isOnlineRegistrationOnAgentLogin")==0){%>checked<%}%> > Off </label>
        </div>
        </div>  
   	<div class="form-group">
        <label class="col-sm-3 control-label"></label>
        <label class="col-sm-3 control-label">DISPATCHERS View Shippers</label>
        <div class="col-sm-1">
        <%
        	Integer isOnlineRegistrationOnAgentShip = (Integer) resultSet.getObject("isOnlineRegistrationOnAgentShip");
        	Integer isOnlineRegistrationOnAgentTruck = (Integer) resultSet.getObject("isOnlineRegistrationOnAgentTruck");
        
        %>
        <label style="color:green" ><input class="form-control" type="radio" name="isOnlineRegistrationOnAgentShip" value="isOnline" style="width: 18px; height: 18px;" <%if(isOnlineRegistrationOnAgentShip != null && isOnlineRegistrationOnAgentShip==1){%>checked<%}%> >All&nbsp;&nbsp;</label>
        <label style="color:orange"><input class="form-control" type="radio" name="isOnlineRegistrationOnAgentShip" value="isOffline" style="width: 18px; height: 18px;" <%if(isOnlineRegistrationOnAgentShip == null || isOnlineRegistrationOnAgentShip==0){%>checked<%}%>>Online Only</label>
        </div>
        <label class="col-sm-3 control-label">DISPATCHERS View Drivers</label>
        <div class="col-sm-1">
        <label style="color:green" ><input class="form-control" type="radio" name="isOnlineRegistrationOnAgentTruck" value="isOnline" style="width: 18px; height: 18px;" <%if(isOnlineRegistrationOnAgentTruck != null && isOnlineRegistrationOnAgentTruck==1){%>checked<%}%>>All&nbsp;&nbsp;</label>
        <label style="color:orange"><input class="form-control" type="radio" name="isOnlineRegistrationOnAgentTruck" value="isOffline" style="width: 18px; height: 18px;" <%if(isOnlineRegistrationOnAgentTruck == null || isOnlineRegistrationOnAgentTruck==0){%>checked<%}%>>Online Only</label>
        </div>
        </div>     
        
    	<div class="form-group">
        <label class="col-sm-3 control-label"></label>
        <label class="col-sm-3 control-label">DISPATCHERS Auto Lock Inactive</label>
        <div class="col-sm-1">
        <%
        	Integer isOnlineRegistrationOnAgentLock = (Integer) resultSet.getObject("isLockInactive");
        
        %>
        <label style="color:green" ><input class="form-control" type="radio" name="isOnlineRegistrationOnAgentLock" value="isOnline" style="width: 18px; height: 18px;" <%if(isOnlineRegistrationOnAgentLock != null && isOnlineRegistrationOnAgentLock==1){%>checked<%}%> >Unlock&nbsp;&nbsp;</label>
        <label style="color:orange"><input class="form-control" type="radio" name="isOnlineRegistrationOnAgentLock" value="isOffline" style="width: 18px; height: 18px;" <%if(isOnlineRegistrationOnAgentLock == null || isOnlineRegistrationOnAgentLock==0){%>checked<%}%>>Lock</label>
        </div>
        <label class="col-sm-3 control-label">&nbsp;</label>
        <div class="col-sm-1">
        &nbsp;
        </div>
        </div>          
        
        <div class="form-group">
        <label class="col-md-3 control-label"></label>
        <div class="col-md-8">
        <input type="submit" class="btn btn-primary" value="Save Changes" name="submit">
        <span></span>
        <input type="reset" class="btn btn-default" onclick="window.location.href='edit_web_site.jsp'" value="Cancel">
        </div>
        </div>
        
        </form>
        
        </div>


        </div>
<p>
        </div>


        </div>




      		<%}
      
      
            				connection.close();
		}


						 }catch (Exception ex){
						     %><%="Error Posting " + ex%><%
						     System.out.println(""+ ex);
						 }

						%>
        <hr>



        </ul>
        </div>
        </div>
        </div>

        </div>
        </div>
        </div>
       <br />




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
        <li>voice: (650) 567-4439</li>
        </ul>
        </div>
    <!-- .subfooter end -->
        </section>



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
        <button type="button" class="btn btn-primary" data-dismiss="modal" onclick="location.href='../index4.jsp'">Dismiss</button>

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

    <!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
    <script src="assets/js/ie10-viewport-bug-workaround.js"></script>

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