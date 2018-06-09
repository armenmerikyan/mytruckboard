<%@ page import="com.big.util.*,java.text.*,java.util.*,java.io.*,javax.xml.parsers.*,org.w3c.dom.*,java.sql.*,java.text.DateFormat" %>

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

    <title>MYTRUCKBOARD 2.0 - Freight management and dispatch made easy.</title>

    <link rel="shortcut icon" href="https://www.mytruckboard.com/images/mtb-favicon.ico">

    <meta http-equiv="content-type" content="text/html; charset=utf-8" />

    <meta name="description" content="Manage independent truck drivers and un-utilized capacity with GPS based dispatch system designed to drive more profit to your brokerage." />
    <meta name="keywords" content="freight, transportation, dispatch management, load optimization, truck broker, transportation management, truck, truck fleet management, shippers, truck brokers, shipping made easy, trucking industry, trucking software, trucking, dispatch for freight brokder, carrier management, load board, load, board" />

    <link href="https://fonts.googleapis.com/css?family=Roboto:100,100italic,300,300italic,400,400italic" rel="stylesheet" type="text/css" />
    <!--[if lte IE 8]><script src="css/ie/html5shiv.js"></script><![endif]-->

    <script type="text/javascript" src="js/jquery.min.js"></script>
    <script src="js/skel.min.js"></script>
    <script src="js/init2.js"></script>


    <noscript>
        <link rel="stylesheet" href="css/skel-noscript.css" />
        <link rel="stylesheet" href="css/style-wide.css" />
     </noscript>


    <!-- Bootstrap core CSS -->
    <link href="css/bootstrap.min.css" rel="stylesheet">

    <link href="css/style.css" rel="stylesheet">


    <!-- Custom styles for this template -->
    <link href="css/navbar-fixed-top.css" rel="stylesheet">


    <!--[if lte IE 8]><link rel="stylesheet" href="css/ie/v8.css" /><![endif]-->
    <!--[if lte IE 9]><link rel="stylesheet" href="css/ie/v9.css" /><![endif]-->

    <style>
        .dark .button
        {
            background: #47A249;
            box-shadow: inset 0 0 0 1px #fff;
            color: #fff;
        }

        .button
        {
            background: #47A249;
           }

    .checkbox input
        {
        border: 3px #47A249;
        margin-top: 8px;

            }

    .checkbox label {
    padding-left: 5px;
    padding-bottom: 3px;
    font-size: 1em;
    color: #337ab7;
    font-weight: 300;
    }
    </style>
    <script language="JavaScript" type="text/javascript">
        function updateSaferSys(){
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
			var addressList = xmlhttp.responseText.split("<ITEM>");
			//alert( xmlhttp.responseText);
			//document.getElementById("safer_address1").value = addressList[3]; 
			//document.getElementById("safer_city").value = addressList[4]; 
			//document.getElementById("safer_state").value = addressList[5]; 
			//document.getElementById("safer_zip").value = addressList[6]; 
			//document.getElementById("safer_fax").value = addressList[8]; 
			//document.getElementById("safer_needed").value = addressList[1]; 
			//document.getElementById("safer_onfile").value = addressList[2];  
			if(addressList[7].length > 0 ){
				document.getElementById("phone").value = addressList[7]; 
			}
			if(addressList[9].length > 0 ){
				document.getElementById("company_name").value = addressList[9]; 
			}
			
			//document.getElementById("safer_mc").value = document.getElementById("location_mc").value; 
			
		}
		}
		var responseString = "?MC_NO=" + encodeURIComponent(document.getElementById("location_mc").value);
		xmlhttp.open("GET", "safersys.api.jsp" + responseString,true);
		xmlhttp.send();
            }   
     </script>
</head>
<body>



<!-- First -->


<section id="first" class="main">

        <div class="content style4 featured">
            <div class="container small">
                <div class="row">
                    <div class="col-md-12">
         <span class="image"  style="margin-left: 0px; padding: 10px 0px 0px; border-right-width: 0px;"><img src="images/mytryckboard_logo_v2i_small.png"></span>



        <strong><h2 style="margin-bottom: 0px; font-weight: 700;">START TODAY WITH INSTANT ACCESS</h2></strong><BR><BR>
                    </div>


                </div>

                <%if(request.getParameter("error_msg")!=null){%><p> <B><%=NullCheck.check(request.getParameter("error_msg"))%></B></p><%}%>


                <FORM action="add_board.jsp" method="post">

                    <INPUT type="hidden" name="addAccount" value="true">
                    <INPUT type="hidden" name="discount_code" value="<%=request.getParameter("discount_code")%>">
                    


<!--
                    <div class="row" style="margin-right: 2px;">
        <div class="2u" style="height: 2px;">&nbsp;</div>
                        <div class="8u"><input type="text" class="text" id="location_mc" name="location_mc" onblur="updateSaferSys()" placeholder="MC12345 (optional)" value="" /></div>
        <div class="2u" style="height: 2px;">&nbsp;</div>
                    </div>
                    <div class="row" style="margin-right: 2px;">
        <div class="2u" style="height: 2px;">&nbsp;</div>
                        <div class="8u"><input type="text" class="text" id="phone" name="phone" placeholder="Phone" value="" /></div>
        <div class="2u" style="height: 2px;">&nbsp;</div>
                    </div>
                    -->

                    <div class="row" style="margin-right: 2px;">
        <div class="2u" style="height: 2px;">&nbsp;</div>
                        <div class="8u"><input type="text" class="text" name="email" placeholder="Email" value="" /></div>
        <div class="2u" style="height: 2px;">&nbsp;</div>
                    </div>
                    <div class="row" style="margin-right: 2px;">
        <div class="2u" style="height: 2px;">&nbsp;</div>
                        <div class="8u"><input type="password" class="text" name="password" placeholder="Choose Password" /></div>

        <div class="2u" style="height: 2px;">&nbsp;</div>
                    </div>


                    

                    <div class="row" style="margin-right: 5px;">
        		<div class="2u" style="height: 2px;">&nbsp;</div>
                        <div class="8u" > <input type="text" class="text" id="company_name" name="company_name" placeholder="Company Name" value=""/></div>
		        <div class="2u" style="height: 2px;">&nbsp;</div>
                    </div>


                    <div class="row" style="margin-right: 2px;">
			<div class="2u"></div>
                          <div class="8u">
                          <select name="country_code" id="country_code" >
                          <option  value="CA">Canada<option>
                          <option  value="CR">Costa Rica<option>
                          <option  value="MX">Mexico<option>
                          <option  value="GB">United Kingdom<option>
                          <option  value="US" selected >United States<option>
                          </select>
                          </div>

			<div class="2u"></div>
                      </div>
                    <div class="row">
                    <div class="col-md-3"></div>
                    <div class="col-md-6" ><input type="text" class="text" name="discount_code" placeholder="Referred By (optional)" value="<%=NullCheck.check(request.getParameter("ac"))%>"/></div>
                    <div class="col-md-3"></div>
                    </div>

                    <div class="row">
                        <!-- <div class="12u"><INPUT type="checkbox" name="ad_network_only" value="Yes" > myTruckBoard Ad Network Account Only. This will be a free account only for Advertising to Truck Drivers via myTruckBoard App Ad Network.</a>.
                         </div>
                         -->
                    </div>
                    <div class="row">
        <div class="2u" style="height: 2px;">&nbsp;</div>
                        <div class="8u">
    <INPUT type="hidden" name="term_of_service" value="Yes"> I agree to <a href="/trucking-new/terms_of_service.html" >Terms of Service</a> & <a href="/trucking-new/privacy_policy.html" >Privacy Policy</a>.
                                </div>
        <div class="2u" style="height: 2px;">&nbsp;</div>
    
                        </div>

                    <div class="row">
        <div class="2u" style="height: 2px;">&nbsp;</div>
                        <div class="8u">
                            <input type="submit" class="button" value="Create Account" />

                        </div>
        <div class="2u" style="height: 2px;">&nbsp;</div>
                    </div>
                    <div class="row">
        <div class="2u" style="height: 2px;">&nbsp;</div>
                        <div class="8u">
                           <a href="../mytruckboard-pricing-plans.html" >Cancel</a>

                        </div>
        <div class="2u" style="height: 2px;">&nbsp;</div>
                    </div>
                </form>
            </div>
        </div>





		<!-- Footer -->
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
						<li>&copy;<a href="http://liteworks2.com">Litewsorks2 Inc</a> </li>
                        <li>twitter: @mytruckboard</li>
                        <li>voice: 1.310.903.6014</li>
					</ul>
				</div>
			</section>

    <!-- the jScrollPane script -->
    <script type="text/javascript" src="js/jquery.jscrollpane.min.js"></script>

    <!-- Bootstrap core JavaScript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster -->
    <script src="js/bootstrap2.min.js"></script>


	</body>
</html>
