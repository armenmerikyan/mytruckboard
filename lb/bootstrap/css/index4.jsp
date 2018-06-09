<%@ page import="com.big.util.*,java.text.*,java.util.*,java.io.*,javax.xml.parsers.*,org.w3c.dom.*,java.sql.*,java.text.DateFormat" %><%
if(request.getHeader("Host")!=null){	
    if(request.getHeader("Host").equals("www.uberflowerlyft.com") || request.getHeader("Host").equals("uberflowerlyft.com")){
			try{
				response.sendRedirect("http://uberflowerlyft.com/AAAHOME/index.jsp");
			}catch(Exception ex){
			    %><%=ex%><%			
			}
	}
	if(request.getHeader("Host").equals("www.yawadi.com") || request.getHeader("Host").equals("yawadi.com")){
			try{
				response.sendRedirect("http://yawadi.com/AAAHOME/index.jsp");
			}catch(Exception ex){
			    %><%=ex%><%			
			}
	}
	if(request.getHeader("Host").equals("www.liteworks2.com") || request.getHeader("Host").equals("liteworks2.com")){
			try{
				response.sendRedirect("http://liteworks2.com/liteworks2/index.jsp");
			}catch(Exception ex){
			    %><%=ex%><%			
			}
	}
	if(request.getHeader("Host").equals("www.ipubsub.com") || request.getHeader("Host").equals("ipubsub.com")){
			try{
				response.sendRedirect("http://ipubsub.com/ipubsub/index.jsp");
			}catch(Exception ex){
			    %><%=ex%><%			
			}
	}
	if(request.getHeader("Host").equals("www.ustiredepot.com") || request.getHeader("Host").equals("ustiredepot.com")){
			try{
				response.sendRedirect("http://ustiredepot.com/ustiredepot/index.jsp");
			}catch(Exception ex){
			    %><%=ex%><%			
			}
	}
}	
%>			
<!DOCTYPE HTML>
<html>
	<head>
<meta name="google-site-verification" content="1QihUOuRwEWAj8QtNgUtpFsrC2CI7cY100legePbzWQ" />
<meta http-equiv="cache-control" content="max-age=0" />
<meta http-equiv="cache-control" content="no-cache" />
<meta http-equiv="expires" content="0" />
<meta http-equiv="expires" content="Tue, 01 Jan 1980 1:00:00 GMT" />
<meta http-equiv="pragma" content="no-cache" />

	
 <script type="text/javascript">
 var RecaptchaOptions = {
    theme : 'white'
 };
 </script>
 <%
 		HashMap truckList = (HashMap)session.getAttribute("truckList");
 		truckList = new HashMap();
 		session.setAttribute("truckList", new HashMap());
 %>
        <title>MYTRUCKBOARD 2.0 - freight management made easy.</title>

        <link rel="shortcut icon" href="http://www.mytruckboard.com/trucking-new/images/mtb-favicon.ico">

        <meta http-equiv="content-type" content="text/html; charset=utf-8" />

        <meta name="description" content="The complete freight management software. Win shipping deals and manage your fleet of trucks effortlessly." />
        <meta name="keywords" content="freight, transportation, dispatch management, load optimization, truck broker, transportation management, truck, truck fleet management, shippers, truck brokers, shipping made easy, trucking industry, trucking software, trucking, dispatch for freight brokder, carrier management, load board, load, board" />

        <link href="https://fonts.googleapis.com/css?family=Roboto:100,100italic,300,300italic,400,400italic" rel="stylesheet" type="text/css" />
		<!--[if lte IE 8]><script src="trucking-new/css/ie/html5shiv.js"></script><![endif]-->

        <script type="text/javascript" src="trucking-new/js/jquery.min.js"></script>

        <script src="trucking-new/js/skel.min.js"></script>

        <script src="trucking-new/js/init.js"></script>



		<noscript>
			<link rel="stylesheet" href="trucking-new/css/skel-noscript.css" />
			<link rel="stylesheet" href="trucking-new/css/style.css" />
			<link rel="stylesheet" href="trucking-new/css/style-wide.css" />

		</noscript>


    <!-- Bootstrap core CSS -->
    <link href="trucking-new/css/bootstrap.min.css" rel="stylesheet">

    <!-- Custom styles for this template -->
    <link href="trucking-new/css/navbar-fixed-top.css" rel="stylesheet">



        <script type="text/javascript">

			var guid = createGuid();

	    function postMessage(){
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
			    	document.getElementById("messageDiv").value = xmlhttp.responseText;
			    }
			  }
			var uuid = createGuid();
			var url = encodeURIComponent(document.getElementById("message").value) + "&name=" + encodeURIComponent(document.getElementById("messageName").value) + "&email=" + encodeURIComponent(document.getElementById("messageEmail").value) + "&id=" + uuid + "&guid=" + guid;

			xmlhttp.open("GET", "\.\./trucking-new/js-custom/postMessage.jsp?message=" +  url,true);
			xmlhttp.send();
//			alert('Message Send');
	    }
	    function createGuid()
		{
		    return 'xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx'.replace(/[xy]/g, function(c) {
		        var r = Math.random()*16|0, v = c === 'x' ? r : (r&0x3|0x8);
		        return v.toString(16);
		    });
		}
</script>

		<!--[if lte IE 8]><link rel="stylesheet" href="trucking-new/css/ie/v8.css" /><![endif]-->
		<!--[if lte IE 9]><link rel="stylesheet" href="trucking-new/css/ie/v9.css" /><![endif]-->
	</head>
	<body>

        <%
			String dateString = new java.text.SimpleDateFormat("MM/dd/yyyy").format(new java.util.Date());
			String equipCount = "0";
			String equipCountTom = "0";
			%>
        <%
			Class.forName("com.mysql.jdbc.Driver");
			String url = "jdbc:mysql://localhost/test?zeroDateTimeBehavior=convertToNull";
			Connection connection = DriverManager.getConnection(url,"<USERNAME>", "<PASSWORD>");
			PreparedStatement psMain = null;

				psMain = connection.prepareStatement("INSERT INTO test.messageBoard(id, ts, client_id, message, client_session_id, client_ip) VALUES (?,?,?, ?,?,?)");
				psMain.setString(1, UUID.randomUUID() + "");
				psMain.setTimestamp(2, new java.sql.Timestamp((new java.util.Date()).getTime()));
				psMain.setString(3, UUID.randomUUID() + "");
				psMain.setString(4, "<HOMEPAGE>");
				psMain.setString(5, UUID.randomUUID() + "");
				psMain.setString(6,  request.getRemoteAddr());
				psMain.executeUpdate();


			DateFormat formatter = new SimpleDateFormat("MM/dd/yyyy.HH.mm.ss");
			DecimalFormat format=new DecimalFormat("#.00");
			java.sql.Date start = null;
			java.sql.Date end = null;
			start = new java.sql.Date(((java.util.Date)formatter.parse(dateString + ".00.00.00" )).getTime());
			end = new java.sql.Date(((java.util.Date)formatter.parse(dateString + ".23.59.59" )).getTime());


			psMain = connection.prepareStatement("select count(id) as numb_rows from test.TRUCKING_EQUIPMENT where DATE_MODIFIED BETWEEN ? AND ? ");
			psMain.setDate(1, start);
			psMain.setTimestamp(2, new java.sql.Timestamp(end.getTime()));
			ResultSet resultSet = psMain.executeQuery();
			while (resultSet.next()) {
			%>

        <%
				equipCount = resultSet.getString("numb_rows");
			}

			Calendar c = Calendar.getInstance();
			c.add(Calendar.DATE, 1);

			String dateStringTom = new java.text.SimpleDateFormat("MM/dd/yyyy").format(c.getTime());
			start = new java.sql.Date(((java.util.Date)formatter.parse(dateStringTom + ".00.00.00" )).getTime());

			c.add(Calendar.DATE, 2);
			dateStringTom = new java.text.SimpleDateFormat("MM/dd/yyyy").format(c.getTime());
			end = new java.sql.Date(((java.util.Date)formatter.parse(dateStringTom + ".23.59.59" )).getTime());

			psMain = connection.prepareStatement("select count(id) as numb_rows from test.TRUCKING_EQUIPMENT where DATE_MODIFIED BETWEEN ? AND ? limit 5");
			psMain.setDate(1, start);
			psMain.setTimestamp(2, new java.sql.Timestamp(end.getTime()));

			ResultSet resultTomSet = psMain.executeQuery();
			while (resultTomSet.next()) {
			%>

        <%
				equipCountTom = resultTomSet.getString("numb_rows");
			}
			%>




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
    <a class="navbar-brand" href="#">mytruckboard</a>
    </div>
    <div id="navbar" class="navbar-collapse collapse">
    <ul class="nav navbar-nav">
    <li class="active"><a href="#" class="scrolly">Home</a></li>
    <li ><a href="#second" class="scrolly">Product Tour</span></a></li>
    <li ><a href="#first" class="scrolly">Sign Up</a></li>
    <li ><a href="#fourth" class="scrolly">Contact</a></li>
    </ul>
    <form class="navbar-form navbar-right" action="trucking-new/dashboard.jsp" method="post">
    <div class="form-group">
    <input type="email" placeholder="Email" name="login_id" class="form-control">
    </div>
    <div class="form-group">
    <input type="password" placeholder="Password" name="password" class="form-control">
    </div>
    <button type="submit" class="btn btn-success">Sign in</button>
    </form>
    </div><!--/.nav-collapse -->
    </div>
    </nav>


    <section id="header" class="dark">



                <header>


                <span class="image"><img src="trucking-new/images/mytryckboard_logo_v2i.png" alt="MYTRUCKBOARD 2.0 logo"></span><br />







    <div class="inner">

    <header>
    <h2>FREIGHT DISPATCH</h2>
    </header>
    <p>Like you have <strong>NEVER</strong>, seen before.</p>
    <header>
    <h2>RATE MANAGEMENT</h2>
    </header>
    <p>Putting<strong> YOU AHEAD </strong> of other brokers.<br />
    </p>
    <footer>
    <ul class="buttons vertical">
    <li><a href="#first" class="button fit scrolly">Curious? Sign up and manage your fleet for FREE!</a></li>
    </ul>
    </footer>


    </div></div>

    </header>

			</section>

		<!-- First -->


			<section id="first" class="main">

				<header>
                    <br>
                    <div >
                        <h2>START HERE<br>
                        Manage your people, equipment, rates and directly book un-utilized capacity online from myTruckBoard.com</h2>
                            <br>
                    </div>
                    <div class="content style4 featured">
                        <div class="container small">
                            <FORM action="trucking/newFace/newFace.new.board.jsp" method="post">
                             <INPUT type="hidden" name="addAccount" value="true">
                                <div class="row half">
                                    <div class="4u"><input type="text" class="text" name="email" placeholder="Email" /></div>
                                    <div class="4u"><input type="text" class="text" name="company_name" placeholder="Company Name" /></div>
                                    <div class="4u"><input type="text" class="text" name="discount_code" placeholder="Referred By (optional)" /></div>
                                </div>
                                <div class="row half">

                                    <div class="4u"></div>
                                    <div class="4u"><input type="submit" class="button" value="Create Account" /></div>
                                    <div class="4u"></div>

                                </div>
                            </form>
                        </div>
                    </div>
                    <div >
                        <p>Membership is FREE.<br>My Truck Board has no setup fees, no monthly fees and no credit card is required to signup.<br>Why is mytruckboard so awesome ? Scroll down to find out.</p>
                        <br><ul class="icons">
                            <li><a href="#second" class="fa fa-arrow-circle-down solo scrolly"><span>Down</span></a></li>
                        </ul>
                    </div>



				</header>

			</section>

		<!-- Second -->
			<section id="second" class="main">

                <div class="content dark style1 featured">
                    <div >
                        <div class="row 0%">
                            <div class="4u">
                                <section>
                                    <span class="feature-icon"><span class="fa fa-dollar"></span></span>
                                    <header>
                                        <h3>Rate Manager</h3>
                                    </header>
                                    <p>As much fun as it is to know that Wakalaka Texas is only 10 miles away from Chocolaka Texas we think the computer should be responsible for understanding this otherwise useless information. That is why we developed the GPS based rate manager.</p>
                                </section>
                            </div>
                            <div class="4u">
                                <section>
                                    <span class="feature-icon"><span class="fa fa-truck"></span></span>
                                    <header>
                                        <h3>Truck Board</h3>
                                    </header>
                                    <p>Software industry is focusing on integration and we are taking advantage of these changes in major ways to provide low priced tools for our community members.
                                    </p>
                                </section>
                            </div>
                            <div class="4u">
                                <section>
                                    <span class="feature-icon"><span class="fa fa-cogs"></span></span>
                                    <header>
                                        <h3>Live Board</h3>
                                    </header>
                                    <p style="padding-right: 20px">Integrated with companies such as Google, Amazon and Twillio to name a few. Seamless application integration with Google Maps for visualization, Directions for routing and Places for location standardization and Amazon SES service for email correspondence</p>
                                </section>
                            </div>
                        </div>
                        <div class="row">
                            <div class="12u">
                                <footer>
                                    <a href="#fourth" class="button scrolly"  >Have a question ? Talk to us</a>
                                </footer>
                            </div>
                        </div>
                    </div>
                </div>
			</section>

		<!-- Fifth -->
			<section id="fifth" class="main">
        <header>
            <h2>Already have an account?</h2>
            <h2>Welcome back! - you can login here:</h2><br>

    <form action="/trucking/index_login.jsp" method="post">


				<div class="content style4 featured">
					<div class="container small">
						<form method="post" action="#">
							<div class="row">
								<div class="6u"><input type="text" class="text" name="login_id" placeholder="email" /></div>
								<div class="6u"><input type="password" class="text" name="password" placeholder="password" /></div>
							</div>
							<div class="row">
								<div class="12u"><input type="submit" class="button" value="Log In" /></div>

							</div>
							<div class="row">
								<div class="12u">
									<ul class="actions">
										<li>&nbsp;</li>
									</ul>
								</div>
							</div>
						</form>
					</div>
				</div>

			</form> </header>
			</section>
		<!-- Fourth -->
			<section id="fourth" name="fourth" class="main">
				<br><header>
					<div >
						<h2>We want to hear from you</h2>
						<p>Questions ? Comments ? <a href="http://www.facebook.com/myTruckBoard">connect via facebook.</a><br />
						We are good, but we can't read your mind. MYTRUCKBOARD network can help you start shipping, brokering, delivering right away.</p>
					</div>
				</header>
				<!--
				<div class="content style4 featured">
					<div class="container small">
						<form method="post" action="#">
							<div class="row half">
								<div class="6u"><input type="text" class="text" onkeypress="postMessage()" placeholder="Name" id="messageName" name="messageName" /></div>
								<div class="6u"><input type="text" class="text" onkeypress="postMessage()" placeholder="Email" id="messageEmail" name="messageEmail" /></div>
							</div>
							<div class="row half">
								<div class="12u"><div name="messageDiv"><textarea name="message" onkeypress="postMessage()" id="message" placeholder="Message"></textarea></div></div>
							</div>
							<div class="row">
								<div class="12u">
									<ul class="actions">
										<li><input type="submit" class="button" value="Send Message" onclick="postMessage()" /></li>
										<li><input type="reset" class="button alt" value="Clear Form" /></li>
									</ul>
								</div>
							</div>
						</form>
					</div>
				</div>
				-->
			</section>


		<!-- Footer -->
			<section id="footer">
				<ul class="icons">
					<li><a href="https://twitter.com/MyTruckBoard" class="fa fa-twitter solo"><span>Twitter</span></a></li>
					<li><a href="https://www.facebook.com/myTruckBoard" class="fa fa-facebook solo"><span>Facebook</span></a></li>

				</ul>
				<div class="copyright">
					<ul class="menu">
                        <li>Copyright &copy; 2015 Litewsorks2 Inc. All rights reserved.</li>
						<li>Design: <a href="http://www.34beats.com/">34Beats.com</a></li>
					</ul>
					<ul class="menu">
						<li>&copy;<a href="http://liteworks2.com">Litewsorks2 Inc</a> </li>
                        <li>599 Fairchild Dr, Mountain View, CA 94043 United States</li>
                        <li>email: LW2@liteworks2.com </li>
                        <li>twitter: @liteworks2</li>
                        <li>voice: (650) 567-4439</li>
					</ul>
				</div>
			</section>

    <!-- the jScrollPane script -->
    <script type="text/javascript" src="trucking-new/js/jquery.jscrollpane.min.js"></script>

    <!--instantiate after some browser sniffing to rule out webkit browsers-->
    <script type="text/javascript">

      $(document).ready(function () {
          if (!$.browser.webkit) {
              $('.container').jScrollPane();
          }
      });

    </script>
<script type="text/javascript">

  var _gaq = _gaq || [];
  _gaq.push(['_setAccount', 'UA-28886039-1']);
  _gaq.push(['_trackPageview']);

  (function() {
    var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
    ga.src = ('https:' == document.location.protocol ? 'https://' : 'http://') + 'stats.g.doubleclick.net/dc.js';
    var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
  })();

</script>
	</body>
</html>