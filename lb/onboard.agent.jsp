<%@ page import="com.big.util.*,java.text.*,java.util.*,java.io.*,javax.xml.parsers.*,org.w3c.dom.*,java.sql.*,java.text.DateFormat" %>			
<!DOCTYPE HTML>
<html>
	<head>
 <script type="text/javascript">
 var RecaptchaOptions = {
    theme : 'white'
 };
 </script>
    <title>MYTRUCKBOARD 2.0 - Freight management and dispatch made easy.</title>

    <link rel="shortcut icon" href="https://www.mytruckboard.com/trucking-new/images/mtb-favicon.ico">

    <meta http-equiv="content-type" content="text/html; charset=utf-8" />

    <meta name="description" content="The complete freight management software. Get an edge on other brokers and shippers, win shipping deals and effortlessly manage your truck fleet." />
    <meta name="keywords" content="freight, transportation, dispatch management, load optimization, truck broker, transportation management, truck, truck fleet management, shippers, truck brokers, shipping made easy, trucking industry, trucking software, trucking, dispatch for freight brokder, carrier management, load board, load, board" />

    <link href="https://fonts.googleapis.com/css?family=Roboto:100,100italic,300,300italic,400,400italic" rel="stylesheet" type="text/css" />
    <!--[if lte IE 8]><script src="css/ie/html5shiv.js"></script><![endif]-->

    <script type="text/javascript" src="js/jquery.min.js"></script>

    <script src="js/skel.min.js"></script>

    <script src="js/init2.js"></script>

    <noscript>
    <link rel="stylesheet" href="css/skel-noscript.css" />
    <link rel="stylesheet" href="css/style.css" />
    <link rel="stylesheet" href="css/style-wide.css" />

    </noscript>


    <!-- Bootstrap core CSS -->
    <link href="css/bootstrap.min.css" rel="stylesheet">


	</head>
	<body>

		<!-- First -->


			<section id="first" class="main">

				<header>

                    <div class="container">
                        <h2>Welcome to<strong> MYTRUCKBOARD </strong>
                        <br>The form below will help you start becoming a freight broker agent.</h2>
                            <br>
                    </div>
                    <div class="content style4 featured">
                        <div class="container small">
                        	<%if(request.getParameter("error_msg")!=null){%><p> <B><%=NullCheck.check(request.getParameter("error_msg"))%></B></p><%}%>
                            <FORM action="add_board.agent.jsp" method="post">
                             <INPUT type="hidden" name="addAccount" value="true">
<%

			Class.forName("com.mysql.jdbc.Driver");
			String url = "jdbc:mysql://localhost/test?zeroDateTimeBehavior=convertToNull";
			Connection connection = DriverManager.getConnection(url,"<USERNAME>", "<PASSWORD>");


			PreparedStatement ps = connection.prepareStatement("select * from test.trucking_company where is_online_agent_enrole_avail = 1 ");
			ResultSet resultSet2 = ps.executeQuery();
			


%>
                                <div class="row half">
                                    <div class="12u">
                                    <select name="company_pub_id" >
                                    <% 
                                    while (resultSet2.next()) {
                                    %>
                                    <option value="<%=resultSet2.getString("company_pub_id")%>" ><%=resultSet2.getString("company_pub_name")%></option>
                                    <%}%>
                                    </select>
                                    </div>
                                </div>
                                <div class="row half">
                                    <div class="6u"><input type="text" class="text" name="first_name" placeholder="First Name" value="" /></div>
				    <div class="6u"><input type="text" class="text" name="last_name" placeholder="Last Name" value="" /></div>
                                </div>
                                <div class="row half">
                                    <div class="6u"><input type="text" class="text" name="phone" placeholder="Phone" value="" /></div>
				    <div class="6u"><input type="text" class="text" name="home_phone" placeholder="Home Phone" value="" /></div>
                                </div>
                                <div class="row half">
                                    <div class="6u"><input type="text" class="text" name="email" placeholder="Email" value="<%=request.getParameter("email")%>" /></div>
                                    <div class="6u"><input type="text" class="text" name="discount_code" placeholder="Referred By (optional)" value="<%=request.getParameter("discount_code")%>"/></div>
                                </div>
                                <div class="row half">
                                    <div class="6u"><input type="password" class="text" name="password" placeholder="Password" /></div>
                                    <div class="6u"><input type="password" class="text" name="ReEnterPassword" placeholder="Confirm password" /></div>
                                </div>

                                <div class="row half" style="left:-1em;" >
                                <div class="12u"><INPUT type="checkbox" name="term_of_service" value="Yes"> I agree to <a href="/trucking/terms_of_service.html" >Terms of Service</a> & <a href="/trucking/privacy_policy.html" >Privacy Policy</a>.
                                </div>
                                </div>

                                <div class="row half">
                                    <div class="12u">
                                    <ul class="actions">
                                    <li><input type="submit" class="button" value="Create Account" /></li>
                                    </ul>
                                    </div>


                                </div>
                            </form>
                        </div>
                    </div>



				</header>

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
    <script type="text/javascript" src="js/jquery.jscrollpane.min.js"></script>

    <!--instantiate after some browser sniffing to rule out webkit browsers-->
    <script type="text/javascript">

      $(document).ready(function () {
          if (!$.browser.webkit) {
              $('.container').jScrollPane();
          }
      });

    </script>

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