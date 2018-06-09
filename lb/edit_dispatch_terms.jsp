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

            <%if(session.getAttribute("isAdmin").equals("true") && request.getParameter("cmd")!=null && request.getParameter("cmd").equals("removeTerm")){%>
              <%
		 try{
			Class.forName("com.mysql.jdbc.Driver");
			String url = "jdbc:mysql://localhost/test?zeroDateTimeBehavior=convertToNull";
			Connection connection = DriverManager.getConnection(url,"<USERNAME>", "<PASSWORD>");
			PreparedStatement ps = connection.prepareStatement("delete from test.trucking_company_dispatch_terms where term_id = ? and company_id = ?");
			ps.setString(1, request.getParameter("term_id"));				
			ps.setString(2, uuid);
			ps.executeUpdate();
			connection.close();
		 }catch (Exception ex){
		     %><%="Error Posting " + ex%><%
		     System.out.println(""+ ex);
		 }
				%>               
            <%} else if(session.getAttribute("isAdmin").equals("true") && request.getParameter("cmd")!=null && request.getParameter("cmd").equals("addComment")){%>
              <%
		 try{
			Class.forName("com.mysql.jdbc.Driver");
			String url = "jdbc:mysql://localhost/test?zeroDateTimeBehavior=convertToNull";
			Connection connection = DriverManager.getConnection(url,"<USERNAME>", "<PASSWORD>");
			PreparedStatement ps = connection.prepareStatement("INSERT INTO test.trucking_company_dispatch_terms(term_id, ts, term, company_id, created_by, term_type) VALUES (?,?,?,?,?,?)");
			ps.setString(1, UUID.randomUUID() +"");				
			java.sql.Timestamp ts = new java.sql.Timestamp((new java.util.Date()).getTime());
			ps.setTimestamp(2, ts);
			ps.setString(3, request.getParameter("term"));
			ps.setString(4, uuid);
			ps.setString(5, (String)session.getAttribute("login_id"));
			ps.setString(6, "Carrier Terms");
			ps.executeUpdate();
			connection.close();
		 }catch (Exception ex){
		     %><%="Error Posting " + ex%><%
		     System.out.println(""+ ex);
		 }
				%>          
            <%}else if(session.getAttribute("isAdmin").equals("true") && request.getParameter("cmd")!=null && request.getParameter("cmd").equals("saveComment")){%>
            <%
		 try{
			Class.forName("com.mysql.jdbc.Driver");
			String url = "jdbc:mysql://localhost/test?zeroDateTimeBehavior=convertToNull";
			Connection connection = DriverManager.getConnection(url,"<USERNAME>", "<PASSWORD>");
			PreparedStatement ps = connection.prepareStatement("Update test.trucking_company_dispatch_terms Set term = ? where COMPANY_ID = ? and term_id = ?");
			ps.setString(1, request.getParameter("term"));
			ps.setString(2, uuid);
			ps.setString(3, request.getParameter("term_id"));
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
    <div class="panel panel-default">
  <div class="panel-body">   
        <div class="row">
        <!-- edit form column -->
        <div class="col-md-9 personal-info">
	<p>&nbsp;</P><p>&nbsp;</P>
        <form action="edit_dispatch_terms.jsp" method="post" class="form-horizontal" role="form">
        <input type="hidden" name="cmd" value="addComment">
        <input type="hidden" name="id" value="<%=uuid%>">
        
        <div class="form-group">
        <label class="col-md-3 control-label">Dispatch Term:</label>
        <div class="col-md-8">
        <textarea class="form-control" type="text" name="term" ></textarea>
        </div>
        </div>        
               
        
        <div class="form-group">
        <label class="col-md-3 control-label"></label>
        <div class="col-md-8">
        <input type="submit" class="btn btn-primary" value="Save" name="submit">
        <span></span>
        </div>
        </div>
        
        </form>
        
        </div>
        </div>
        </div>
            <%
            try{
		if(session.getAttribute("isAdmin").equals("true")){
		
			Class.forName("com.mysql.jdbc.Driver");
			String url = "jdbc:mysql://localhost/test?zeroDateTimeBehavior=convertToNull";
			Connection connection = DriverManager.getConnection(url,"<USERNAME>", "<PASSWORD>");

			PreparedStatement ps = connection.prepareStatement("select * from test.trucking_company_dispatch_terms where COMPANY_ID = ? ");
			ps.setString(1, uuid);
			ResultSet resultSet = ps.executeQuery();
			while (resultSet.next()) {
			%>

        <section id="company"></section><br/><br/><br/><br/>
<div class="panel panel-default">
  <div class="panel-body">        
        <div class="row">
        <!-- edit form column -->
        <div class="col-md-9 personal-info">

        <form action="edit_dispatch_terms.jsp" method="post" class="form-horizontal" role="form">
        <input type="hidden" name="cmd" value="saveComment">
        <input type="hidden" name="term_id" value="<%=NullCheck.check(resultSet.getString("term_id"))%>">
        
        <div class="form-group">
        <label class="col-md-3 control-label">Dispatch Terms:</label>
        <div class="col-md-8">
        <textarea class="form-control" type="text" name="term" ><%=NullCheck.check(resultSet.getString("term"))%></textarea>
        </div>
        </div>        
               
        
        <div class="form-group">
        <label class="col-md-3 control-label"></label>
        <div class="col-md-8">
        <input type="submit" class="btn btn-primary" value="Save Changes" name="submit">
        <span></span>
        
        </div>
        </div>
        
        </form>
        <button class="btn btn-danger btn-primary pull-right"  onclick="window.location.href='edit_dispatch_terms.jsp?cmd=removeTerm&term_id=<%=NullCheck.check(resultSet.getString("term_id"))%>'"><span class="fa fa-times"></span>&nbsp &nbsp Remove &nbsp &nbsp</button>
        
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