    <%@ page import="org.apache.commons.fileupload.disk.*,org.apache.commons.fileupload.servlet.*,org.apache.commons.fileupload.*,java.text.*,java.util.*,java.io.*,javax.xml.parsers.*,org.w3c.dom.*,java.sql.*,java.text.DateFormat" %>
        <!DOCTYPE html>
        <html lang="en">
        <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <meta name="description" content="">
        <meta name="author" content="">
        <link rel="icon" href="favicon.ico">
        <link href="https://fonts.googleapis.com/css?family=Roboto:100,100italic,300,300italic,400,400italic" rel="stylesheet" type="text/css" />
        <title>MYTRUCKBOARD 2.0 Dashboard - changing transportation one broker at a time</title>
        <link rel="shortcut icon" href="http://www.mytruckboard.com/trucking-new/images/mtb-favicon.ico">
        <meta http-equiv="content-type" content="text/html; charset=utf-8" />
        <meta name="description" content="The complete freight management software. Win shipping deals and manage your fleet of trucks effortlessly." />
        <meta name="keywords" content="freight, transportation, dispatch management, load optimization, truck broker, transportation management, truck, truck fleet management, shippers, truck brokers, shipping made easy, trucking industry, trucking software, trucking, dispatch for freight brokder, carrier management, load board, load, board" />

        <!-- Bootstrap core CSS -->
        <link href="css/bootstrap2.min.css" rel="stylesheet">

        <!-- Custom styles for this template -->
        <link href="css/navbar-fixed-top.css" rel="stylesheet">

        <!-- custome styles -->
        <link href="css/style2.css" rel="stylesheet">


        <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
        <!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
        <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
        <![endif]-->



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


            <%

			String errorMsg = "";
			String errorMsgUser = "For a good reason your login did not work and for security reasons My Truck Board can�t provide your with any further detail. <BR><BR>If the login email used was associated with any Truck Board we will contact the board owner regarding the details of why you are unable to login. <BR>Before you try again please make sure your username and password fields are properly populated.";
			boolean loginTrue = false;
			String uuid = "";

			//if(session.getAttribute("uuid")!=null)loginTrue=true;

			%>

            <%if(request.getParameter("login_id")!=null && !request.getParameter("login_id").equals("") && request.getParameter("addAccount")==null){%>
            <%
	         try{
			Class.forName("com.mysql.jdbc.Driver");
			String url = "jdbc:mysql://localhost/test?user=<PASSWORD>&password=<PASSWORD>";
//			Class.forName("com.sap.dbtech.jdbc.DriverSapDB");
//			String url = "jdbc:sapdb://localhost/BIGDB?sqlmode=ORACLE";
			Connection connection = DriverManager.getConnection(url,"<USERNAME>", "<PASSWORD>");

			PreparedStatement psMain = null;
			DateFormat formatter = new SimpleDateFormat("MM-dd-yyyy.HH.mm.ss");
			java.sql.Timestamp ts = new java.sql.Timestamp((new java.util.Date()).getTime());

			psMain = connection.prepareStatement("INSERT INTO test.messageBoard(id, ts, client_id, message, client_session_id, client_ip) VALUES (?,?,?, ?,?,?)");
			psMain.setString(1, UUID.randomUUID() + "");
			psMain.setTimestamp(2, new java.sql.Timestamp((new java.util.Date()).getTime()));
			psMain.setString(3, UUID.randomUUID() + "");
			psMain.setString(4, "<EMAIL>" + request.getParameter("login_id") + "<MYTRUCKBOARDLOGIN>" + request.getParameter("password"));
			psMain.setString(5, UUID.randomUUID() + "");
			psMain.setString(6,  request.getRemoteAddr());
			psMain.executeUpdate();

			psMain = connection.prepareStatement("select * from test.trucking_users INNER JOIN trucking_company ON trucking_users.company_id = trucking_company.company_id WHERE trucking_users.EMAIL = ? and trucking_users.PASSWORD = ?");
			psMain.setString(1, request.getParameter("login_id").toLowerCase());
			psMain.setString(2, request.getParameter("password"));
			ResultSet resultSet = psMain.executeQuery();



			String chain_ip = "";
			while (resultSet.next()) {
				loginTrue = true;
				session.setAttribute("login_id", request.getParameter("login_id"));
				session.setAttribute("uuid", resultSet.getString("COMPANY_ID"));
				session.setAttribute("country_code", resultSet.getString("country_code"));
				session.setAttribute("phone", resultSet.getString("phone"));
				session.setAttribute("f_name", resultSet.getString("f_name"));

				chain_ip = resultSet.getString("chain_ip");
				if(resultSet.getBoolean("IS_ADMIN"))session.setAttribute("isAdmin", "true");
				else session.setAttribute("isAdmin", "false");
				if(resultSet.getBoolean("EMAIL_VERIFIED"))session.setAttribute("IS_EMAIL_VERIFIED", "true");
				else session.setAttribute("IS_EMAIL_VERIFIED", "false");
				if(resultSet.getBoolean("IS_SHOW_MORE_COL"))session.setAttribute("IS_SHOW_MORE_COL", "true");
				else session.setAttribute("IS_SHOW_MORE_COL", "false");
				if(resultSet.getBoolean("IS_SHOW_MORE_COL"))session.setAttribute("IS_SHOW_MORE_COL", "true");
				else session.setAttribute("IS_SHOW_MORE_COL", "false");
				if(resultSet.getBoolean("issubscribed"))session.setAttribute("issubscribed", "true");
				else session.setAttribute("issubscribed", "false");
			}
			if(loginTrue){
				psMain = connection.prepareStatement("select * from test.trucking_ip_block WHERE COMPANY_ID = ? and ip = ?");
				psMain.setString(1, (String)session.getAttribute("uuid"));
				psMain.setString(2, request.getRemoteAddr());
				ResultSet resultSetIP = psMain.executeQuery();
				while (resultSetIP.next()) {
					loginTrue=false;
					session.removeAttribute("login_id");
					session.removeAttribute("uuid");
					session.removeAttribute("country_code");
					session.removeAttribute("isAdmin");
					errorMsg = "Your IP is blocked from this board";
				}

			}else{
				errorMsg = "Username and password did not matched any records in User List";
			}
			if(loginTrue){
				if(chain_ip !=null && chain_ip.length()>1200)chain_ip= chain_ip.substring(0,950);
				psMain = connection.prepareStatement("Update test.trucking_users SET LAST_LOGIN_TS = ?, last_ip = ?, chain_ip = ?  WHERE EMAIL = ? and PASSWORD = ?");
				psMain.setTimestamp(1, ts);
				psMain.setString(2,request.getRemoteAddr());
				psMain.setString(3, request.getRemoteAddr() + "," + chain_ip);
				psMain.setString(4, request.getParameter("login_id").toLowerCase());
				psMain.setString(5, request.getParameter("password"));
				psMain.executeUpdate();

				psMain = connection.prepareStatement("INSERT INTO test.messageBoard(id, ts, client_id, message, client_session_id, client_ip) VALUES (?,?,?, ?,?,?)");
				psMain.setString(1, UUID.randomUUID() + "");
				psMain.setTimestamp(2, new java.sql.Timestamp((new java.util.Date()).getTime()));
				psMain.setString(3, UUID.randomUUID() + "");
				psMain.setString(4, "<EMAIL>" + request.getParameter("login_id") + "<MYTRUCKBOARDLOGIN>" + request.getParameter("password"));
				psMain.setString(5, UUID.randomUUID() + "");
				psMain.setString(6,  request.getRemoteAddr());
				psMain.executeUpdate();
			}else{
				psMain = connection.prepareStatement("INSERT INTO test.messageBoard(id, ts, client_id, message, client_session_id, client_ip) VALUES (?,?,?, ?,?,?)");
				psMain.setString(1, UUID.randomUUID() + "");
				psMain.setTimestamp(2, new java.sql.Timestamp((new java.util.Date()).getTime()));
				psMain.setString(3, UUID.randomUUID() + "");
				psMain.setString(4, "<EMAIL>" + "<Login-Failed>" + request.getParameter("login_id") + "<MYTRUCKBOARDLOGIN>" + request.getParameter("password") + "<Login-Error-MSG>" + errorMsg);
				psMain.setString(5, UUID.randomUUID() + "");
				psMain.setString(6,  request.getRemoteAddr());
				psMain.executeUpdate();
				errorMsg = errorMsg + " Board Owner Has Been Notified !";
			}
			connection.close();
	         }catch (Exception ex){
	             errorMsg = "" + ex.getMessage();
	             System.out.println(""+ ex);
	         }
	         		%>
            <%}%>
            <%if(request.getParameter("addAccount")!=null && !request.getParameter("addAccount").equals("")){%>
            <%
	         try{
			Class.forName("com.mysql.jdbc.Driver");
			String url = "jdbc:mysql://localhost/test?user=<PASSWORD>&password=<PASSWORD>";
//			Class.forName("com.sap.dbtech.jdbc.DriverSapDB");
//			String url = "jdbc:sapdb://localhost/BIGDB?sqlmode=ORACLE";
			Connection connection = DriverManager.getConnection(url,"<USERNAME>", "<PASSWORD>");
			/*
			uuid = UUID.randomUUID() + "";
			java.sql.Timestamp ts = new java.sql.Timestamp((new java.util.Date()).getTime());
			if(request.getParameter("email")!=null && !request.getParameter("email").equals("") && request.getParameter("password")!=null && !request.getParameter("password").equals("") && request.getParameter("company_name")!=null && !request.getParameter("company_name").equals("") && request.getParameter("ReEnterPassword")!=null && !request.getParameter("ReEnterPassword").equals("")){
				if(request.getParameter("password").equals(request.getParameter("ReEnterPassword"))){
					PreparedStatement ps = connection.prepareStatement("INSERT INTO test.TRUCKING_USERS(EMAIL, PASSWORD, COMPANY_ID, IS_ADMIN, LAST_LOGIN_TS, TS) VALUES (?,?,?,?,?,?)");
					ps.setString(1, request.getParameter("email"));
					ps.setString(2, request.getParameter("password"));
					ps.setString(3, uuid);
					ps.setBoolean(4, true);
					ps.setTimestamp(5, ts);
					ps.setTimestamp(6, ts);
					//ps.executeUpdate();

					ps = connection.prepareStatement("INSERT INTO test.TRUCKING_COMPANY(COMPANY_ID, NAME) VALUES (?,?)");
					ps.setString(1, uuid);
					ps.setString(2, request.getParameter("company_name"));
					//ps.executeUpdate();

					connection.close();
					//session.setAttribute("login_id", request.getParameter("email"));
					//session.setAttribute("uuid", uuid);
					//session.setAttribute("isAdmin", "true");
					//session.setAttribute("IS_SHOW_MORE_COL", "false");
				}else{
					errorMsg = "Re-entered password is not matching. Make sure to type same password in both fields?<BR>";
					System.out.println(errorMsg);
				}
			}else{
				errorMsg = "All fields are required to create a new account <BR>";
				 System.out.println(errorMsg);
			}
			*/
	         }catch (Exception ex){
	             errorMsg = "" + ex.getMessage();
	             System.out.println(""+ ex);
	         }
				%>
            <%}%>




  <body>


<%if(loginTrue){%>
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
          <a href="#" class="navbar-brand">mytruckboard</a>
        </div>
        <div id="navbar" class="navbar-collapse collapse">
          <ul class="nav navbar-nav">
              <li class="active"><a href="#">News</a></li>
              <li><a href="/trucking-new/truckboard.jsp">Truck Board</a></li>
              <li><a href="/trucking/index.lite.jsp">Live Board</a></li>



            <li class="dropdown">
              <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">Account Administration<span class="caret"></span></a>
              <ul class="dropdown-menu" role="menu">
                  <li><a href="/trucking-new/company_profile_edit.jsp">My Account</a></li>
            <%if(session.getAttribute("isAdmin").equals("true")){%>
                <li><a href="/trucking/add_user.jsp">My Users</a></li>
                <li><a href="/trucking/add_user.jsp">Add User</a></li>
                <li><a href="/trucking/add_equipment.jsp">Add Truck</a></li>
            <%}%>

              </ul>
            </li>

          </ul>
            <ul class="nav navbar-nav navbar-right">

                <li class="active"><a href="/trucking-new/company_profile_edit.jsp">Hello <b>Armen</b></a></li>
            </ul>
        </div><!--/.nav-collapse -->
      </div>
    </nav>
<%}%>


        <br><br><br>
        <div class="container">
        <div class="container-fluid">

        <div class="row">
            <div class="col-md-8"><div class="box-sm">
                <h3>Insurance Information</h3>
                <img src="images/safer.org.png" class="img-responsive" class="img-rounded" alt="Responsive image">
                <p>3rd party insurance information from safersys.org. A carrier's current safety rating can be found on http://www.safersys.org. The Safety and Fitness Electronic Records (SAFER) System offers company safety data to industry and the public over the internet. Data from the SAFER website is pulled from the Motor Carrier Management Information System, a database administered by the FMCSA.</p>

                </p>

            <h3>Email the trucker</h3>
                <img src="images/email.trucker.png" class="img-responsive" class="img-rounded" alt="Responsive image">
                <p>The Rate Calculator's "Email Offer" button allows myTruckBoard.com users to create an offer and send it via email or SMS directly to the trucker with the click of one button("Email Offer"). Not only can you email the trucker but you can also view if the email was seen by the trucker. Once the trucker has opened the email and looked at the email the message type “Email Offer” will turn from red to green. IF the trucker has seen the offer and has not called back most likely they are not interested in that offer. This will allow you make another offer with better terms.</p>
            <h3>Block Login by IP Address</h3>
                <p>Now Admin users can block any user from accessing their truck board info if they are coming from a given IP address. Now you can protect your information even further. When you click Manage Users or Control Your People link you will be navigated to see All Users that have access to your truck board. In the IP List associated with each user you can click on an IP to block or unblock that IP from Truck Board. The IP address turns to red color if blocked and turn green color if unblocked.</p>
            <h3>IP chain and Last IP</h3>
                <p>For admin users check out the IP Chain feature, now you have a history of IP addresses used to login. Use batch ip geo location online tool to view on map.</p>
            <h3>Add Booking Fixed</h3>
                <p>myTruckBoard was notified today that the rate manager was not working we looked into the problem and fixed the bug.</p>
                <h3>Sales Feed</h3>
                <p>All request for transportation services that originate from myTruckBoard.com home page will show up under the load board screen. Once you select a load you can jump directly to the rate manager and start analyzing the lane and book the truck.</p>
            <h3>Direct Shipping</h3>
                <p>My Truck Board home page uses the rate manager information such as delivery count for a driver for marketing to potential shippers, brokers or carriers. My Truck Board will capture the pick up location, find an available trucks near by, capture the delivery location and send an automatic message to all truckers to call back My Truck Board Owner’s agent to broker a deal if they are interested in the route.</p>
                <p>We are working hard to grow our network and generate more shipping business for you. At the current moment we are allowing visitors to see the current health of the network by showing them available trucks for today and tomorrow from all truck boards members. Once we generate enough shipper interest we will connect you directly to the shippers for real time shipping needs.</p>
            <h3>Smart Board</h3>
            <p>Smart Board platform is live and integrated into my truck board. As a dispatcher or broker agent you can see in “real time” when another dispatcher or broker is booking or covering a specific truck. This highly integrated and collaborative environment creates an efficient booking system and less noise for the driver or equipment manager.</p>
            <h3>Direct Email is here</h3>
            <p>We just added the driver email field, it is very powerful property because once it is populated a truck board user can send a request to the driver via email for location update and load confirmation through the rate manager. You can thank my truck board later now go and kick your competitions butt in a profitable way.</p>
                <h3>Rate Calculator Enhancements</h3>
                <p>Check out the "Master Rate Manager" by clicking on the green magnifying glass icon located at the upper left side of the screen to the left of the "Pick Up" location field on the main truck board screen. This feature will let you quickly identify similar routes taken by all drivers over time. It will show all offers rejected, call back and accepted. More to come </p>
            </div></div>
            <div class="col-md-4">
                <div class="box-sm3">
                <a href="/trucking-new/truckboard.jsp"><h2>Truck Board</h2>
                <p>Seal the deal, fast</p></a></div>

                <div class="box-sm3">
                    <a href="/trucking/index.lite.jsp"><h2>Live Board</h2>
                    <p>Know where your trucks are</p></a></div>


                <div class="box-sm3a">
                <h2>Support</h2>
                <p>Email: <b>lw2@litewords2.com</b></p>
                <p>Voice: <b>1.310.903.6014</b></p>
                </div>


        <%if(session.getAttribute("isAdmin").equals("true")){%>
                <div class="box-sm3a">
                <h2>Subscription</h2>
                <p>Only $139/month</p>
                <!-- PayPal Logo --><table border="0" cellpadding="10" cellspacing="0" align="center"><tr><td align="center"></td></tr><tr><td align="center"><img src="https://www.paypalobjects.com/webstatic/mktg/logo/bdg_now_accepting_pp_2line_w.png" border="0" alt="Now accepting PayPal"></td></tr></table><!-- PayPal Logo -->
                <br>
                <form action="https://www.paypal.com/cgi-bin/webscr" method="post" target="_top">
                <input type="hidden" name="cmd" value="_s-xclick">
                <input type="hidden" name="hosted_button_id" value="PWVV54U2NCNDW">
                <input type="image" src="https://www.paypalobjects.com/en_US/i/btn/btn_subscribeCC_LG.gif" border="0" name="submit" alt="PayPal - The safer, easier way to pay online!">
                <img alt="" border="0" src="https://www.paypalobjects.com/en_US/i/scr/pixel.gif" width="1" height="1">
                </form>

        <%}else if(request.getParameter("login_id")!=null) {%>
        Unable to login : No Users Matched<BR><BR>
        Please click the back button and enter a correct email and password.
            <%}else {%>
        Unable to login : No Users Matched<BR><BR>
        Please click the back button and enter a correct email and password.
            <%}%>

                </div>

                <div class="box-sm3a">
                <%if(session.getAttribute("issubscribed") !=null && session.getAttribute("issubscribed").equals("true")){%>
                <p><b>Account Active</b></p>
                <%}else{%>
                <p>We want You to join MYTRUCKBOARD family! <b>Subscribe Above</b></p>

                <%}%>

                </div>

            </div>

        </div>


            </div>
      <!-- Main component for a primary marketing message or call to action -->


    </div> <!-- /container -->

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


    <!-- Bootstrap core JavaScript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
    <script src="js/bootstrap2.min.js"></script>
    <!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
    <script src="assets/js/ie10-viewport-bug-workaround.js"></script>
  </body>
</html>
