<%@ page import="com.big.util.*,java.text.*,java.util.*,java.io.*,javax.xml.parsers.*,org.w3c.dom.*,java.sql.*,java.text.DateFormat" %>
        <%
String uuid = (String)session.getAttribute("uuid");
boolean needStatusUpdate = false;
if(uuid !=null){

%>        <!DOCTYPE html>
<html lang="en">
<% 
			boolean shipperAdded = false;
			String errorMessage = "";
			Class.forName("com.mysql.jdbc.Driver");
			String url = "jdbc:mysql://localhost/test?user=<PASSWORD>&password=<PASSWORD>";
//			Class.forName("com.sap.dbtech.jdbc.DriverSapDB");
//			String url = "jdbc:sapdb://localhost/BIGDB?sqlmode=ORACLE";
			Connection connection = DriverManager.getConnection(url,"<USERNAME>", "<PASSWORD>");	
	try{
			DateFormat formatterDate = new SimpleDateFormat("MM-dd-yyyy");
			DateFormat formatter = new SimpleDateFormat("MM-dd-yyyy");

			if(request.getParameter("cmd")!=null && request.getParameter("cmd").equals("saveComment")){
            		



            String cityall = request.getParameter("city");
            String[] parts = cityall.split(",");
            String cityv = parts[0]; // get the city from the submitted form
            String statev = parts[1]; // get the state from the submitted form


			
			

			formatter = new SimpleDateFormat("MM-dd-yyyy.HH.mm.ss");
			Calendar cal = Calendar.getInstance();
			java.sql.Date date_mod = null;
			
			if(request.getParameter("date")==null || request.getParameter("date").equals("")){
				date_mod = new java.sql.Date(((java.util.Date)formatter.parse(formatterDate.format(cal.getTime()) + ".00.00.00" )).getTime());
			}else{
				date_mod = new java.sql.Date(((java.util.Date)formatter.parse(request.getParameter("date") + ".00.00.00" )).getTime());
			}
				float dailyLimit = 0.0f;
				float totalLimit = 0.0f;
				int radiusLimit = 1;
				int rowCountBack = 0;
					System.out.println("TEST MADE IT HERE 1011" + rowCountBack);
				if(!request.getParameter("dailyLimit").equals(""))dailyLimit = Float.parseFloat(request.getParameter("dailyLimit").trim());
				if(!request.getParameter("totalLimit").equals(""))totalLimit = Float.parseFloat(request.getParameter("totalLimit").trim());
				if(!request.getParameter("radiusLimit").equals(""))radiusLimit = Integer.parseInt(request.getParameter("radiusLimit").trim());			
				if(!request.getParameter("rowCount").equals(""))rowCountBack = Integer.parseInt(request.getParameter("rowCount").trim());			
			String adUUID = UUID.randomUUID() + "";		
			PreparedStatement ps = connection.prepareStatement("update test.ads set LOCATION = GeomFromText(?), city = ?, state = ?, address1 = ?, address2 = ?, zip = ?, name = ?, ad_name = ?, daily_max = ?, total_max = ?, ad_message = ?, start_date = ?, radius = ? where ad_id = ? and company_id = ? ");
			String latLong = "POINT(1 2)";
			if(request.getParameter("city_lat")!=null && request.getParameter("city_lng")!=null){
				latLong = "POINT(" + request.getParameter("city_lat") + " " + request.getParameter("city_lng") + ")";
			}
			ps.setString(1, latLong);
			ps.setString(2, cityv);
			ps.setString(3, statev);
			ps.setString(4, request.getParameter("address1"));
			ps.setString(5, request.getParameter("address2"));
			ps.setString(6, request.getParameter("zip"));
			ps.setString(7, request.getParameter("adName"));
			ps.setString(8, request.getParameter("ad_name"));
			ps.setFloat(9, dailyLimit);
			ps.setFloat(10, totalLimit);
			ps.setString(11, request.getParameter("displayText"));
			ps.setDate(12, date_mod);
			ps.setInt(13,radiusLimit);
			ps.setString(14,request.getParameter("ad_id"));
			ps.setString(15,uuid);
			if(ps.executeUpdate()==1){shipperAdded =true;
        				ps = connection.prepareStatement("delete from test.ads_target where company_id = ? and ad_id = ? order by ts desc ");
					ps.setString(1, uuid);
					ps.setString(2, request.getParameter("ad_id"));		
					ps.executeUpdate();
					
				for(int j=0;j<rowCountBack;j++){
					System.out.println(request.getParameter("TYPECK" + j));			
					if(request.getParameter("TYPECK" + j) != null && request.getParameter(request.getParameter("TYPECK" + j)) !=null && request.getParameter(request.getParameter("TYPECK" + j)).equals("on")){						
						ps = connection.prepareStatement("INSERT INTO test.ads_target(ads_target_id, ad_id, target_id, ts, isActive, company_id) VALUES (?,?,?,?,1,?)");
						ps.setString(1, UUID.randomUUID() + "");
						ps.setString(2, request.getParameter("ad_id"));
						ps.setString(3, request.getParameter("TYPECK" + j));
						ps.setTimestamp(4, new java.sql.Timestamp((new java.util.Date()).getTime()));
						ps.setString(5, uuid);	
						ps.executeUpdate();
					}
				}
			}
			}
			
		 }catch (Exception ex){
		     System.out.println(""+ ex);
		 }
				%>

       		
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">
    <title>Add Truck - MYTRUCKBOARD 2.0 - freight dispatch and management software</title>
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

        <link rel="stylesheet" href="css/bootstrap-datepicker3.min.css" />

        <!-- datepicker related -->


        <script type="text/javascript" src="js/jquery-2.1.3.min.js"></script>
        <script type="text/javascript" src="js/jquery-ui.min.js"></script>

        <script type="text/javascript" src="js/moment.js"></script>
        <script type="text/javascript" src="js/transition.js"></script>
        <script type="text/javascript" src="js/collapse.js"></script>


        <script type="text/javascript" src="js/notify.min.js"></script>



        <script type="text/javascript" src="js/bootstrap-datetimepicker.min.js"></script>

        <!-- form validation -->
        <script type="text/javascript" src="js/validator.js"></script>



        <!-- Bootstrap core JavaScript
        ================================================== -->

        <script src="js/bootstrap2.min.js"></script>


        <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
    <!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
      <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->


        <!-- Google api:-->
        <script src="https://maps.googleapis.com/maps/api/js?v=3.exp&signed_in=true&libraries=places"></script>
        <!-- end of google api -->





        <script language="JavaScript" type="text/javascript">

        function initialize() {

        var options = {
        types: ['(cities)'],
        componentRestrictions: {country: "us"}
        };

        var input = /** @type {HTMLInputElement} */(
        document.getElementById('pac-input'));

        var input2 = /** @type {HTMLInputElement} */(
        document.getElementById('pac-input2'));

        var input3 = /** @type {HTMLInputElement} */(
        document.getElementById('pac-input3'));

        var autocomplete = new google.maps.places.Autocomplete(input);

        google.maps.event.addListener(autocomplete, 'place_changed', function() {


        var place = autocomplete.getPlace();

        if (!place.geometry) {
        return;
        }


        document.getElementById('city_lat').value = place.geometry.location.lat();
        document.getElementById('city_lng').value = place.geometry.location.lng();

        // alert('city lat =');
        //alert(document.getElementById('city_lat').value);

        });


        var autocomplete2 = new google.maps.places.Autocomplete(input2);

        google.maps.event.addListener(autocomplete2, 'place_changed', function() {

        var place2 = autocomplete2.getPlace();

        if (!place2.geometry) {
        return;
        }


        document.getElementById('home_city_lat').value = place2.geometry.location.lat();
        document.getElementById('home_city_lng').value = place2.geometry.location.lng();

        //alert('home city lat =');
        //alert(document.getElementById('home_city_lat').value);

        });


        var autocomplete3 = new google.maps.places.Autocomplete(input3);

        google.maps.event.addListener(autocomplete3, 'place_changed', function() {

        var place3 = autocomplete3.getPlace();

        if (!place3.geometry) {
        return;
        }

        document.getElementById('wtg_lat').value = place3.geometry.location.lat();
        document.getElementById('wtg_lng').value = place3.geometry.location.lng();

        });

        }

        </script>

        <script type="text/javascript">
        $(function () {
        $('#datetimepicker1').datetimepicker({
        format: 'MM-DD-YYYY',
        showClear: true

        });
        });

        </script>

        <!-- this is notification   -->
        <script>
        function addtrucksubmit() {

        if (isDefaultPrevented()) {
        alert('missing required fields')
        } else {
        document.getElementById('addtruckform').submit();
        }
        }
        </script>



        </head>

 


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
                                            //alert(imgicon);

                        // ajax_loader_blue_512
                        xmlhttp.send();

                        //window.location.href =  "../index4.jsp";

      }


        </script>


     <body onload="initialize()">


		<%if(shipperAdded){%>
            <script>
            $.notify(" You have registered as a shipper! ", "success");
            </script>
            	<%}%>
            	<%if(request.getParameter("cmd")!=null && request.getParameter("cmd").equals("saveComment")){%>
		<%if(!shipperAdded){%>
            <script>
            $.notify("Error Message : <%=errorMessage%>! ", "error");
            </script>            	
            	<%}%>          	
            	<%}%>



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
        <li><a href="new_features.jsp">What's New</a></li>
	            <%if(session.getAttribute("isAd_account_only").equals("false")){%>
        <li><a href="standard-truckboard.jsp">Truck Board</a></li>
        <li><a href="truckboard.jsp">Truck Board 2.0 <small><strong>(new)</strong></small></a></li>

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
		<%}%>
        </ul>

        <ul class="nav navbar-nav navbar-right">

        <li class="dropdown active">
        <a href="#" class="dropdown-toggle active" data-toggle="dropdown" role="button" aria-expanded="false">Hello <b><%=NullCheck.check((String)session.getAttribute("f_name"))%></b><span class="caret"></span></a>
        <ul class="dropdown-menu" role="menu">
        <li><a href="company_profile_view.jsp">My Account</a></li>
            <%if(session.getAttribute("isAdmin").equals("true")){%>
        <li><a href="manage_users.jsp">My Users</a></li>
        <li><a href="add_user.jsp">Add User</a></li>
	            <%if(session.getAttribute("isAd_account_only").equals("false")){%>
        <li><a href="add_truck.jsp">Add Truck</a></li>
        		<%}%>
            <%}%>

        <li><a href="javascript:void(0)" onclick="logoutuser('<%=session.getAttribute("uuid")%>')" data-toggle="modal" data-target="#logoutconfirm">Log Out</a></li>

        </ul>
        </ul>
        </div><!--/.nav-collapse -->
      </div>
    </nav>

      </div>
    </div> 
            <br><br><br><br>
<!-- Main page: -->


        <div class="container">
        <div class="row">


        <div class="col-md-12">


        <div class="col-md-12">
					<%
					PreparedStatement ps ;
        				ps = connection.prepareStatement("select name, city_all, city, radius, start_date, ad_message, daily_max, total_max, X(location) as city_lat, Y(location) as city_lng from test.ads where company_id = ? and ad_id = ? order by ts desc ");
					ps.setString(1, uuid);
					ps.setString(2, request.getParameter("ad_id"));
					ResultSet resultSet = ps.executeQuery();
					String city =  "";
					String radius =  "";
					String start_date =  "";
					String name =  "";
					String ad_message =  "";
					String dailyMax =  "";
					String totalMax =  "";
					String city_lat =  "0";
					String city_lng =  "0";
			DateFormat formatter = new SimpleDateFormat("MM-dd-yyyy.HH.mm.ss");
					while (resultSet.next()) {
						city = NullCheck.check(resultSet.getString("city_all"));
						radius = NullCheck.check(resultSet.getString("radius"));
						if(resultSet.getDate("start_date")!=null)start_date = formatter.format(resultSet.getDate("start_date"));
						ad_message = NullCheck.check(resultSet.getString("ad_message"));
						dailyMax = NullCheck.check(resultSet.getString("daily_Max"));
						totalMax = NullCheck.check(resultSet.getString("total_Max"));
						city_lat = NullCheck.check(resultSet.getString("city_lat"));
						city_lng = NullCheck.check(resultSet.getString("city_lng"));
						name = NullCheck.check(resultSet.getString("name"));
					}
					%>
        <h1><a name="DriverRegister" >Ad Manager</a></h1>
        <h3>myTruckBoard iOS and Android App ads network <a href="adManager.list.jsp" >list</a>
         <a href="adManager.jsp" >add</a>
        </h3>
        <hr>
        <div class="row">

        <!-- edit form column -->
        <div class="col-md-12" personal-info">

        <form action="adManager.edit.jsp" id="addtruckform" name="addtruckform" method="post" class="form-horizontal" role="form" data-toggle="validator">
        <input type="hidden" name="cmd" value="saveComment">
        <input type="hidden" name="ad_id" value="<%=request.getParameter("ad_id")%>">
         
        

        <div class="form-group">
        	<label class="col-sm-3 control-label">Ad Location:</label>
		<div class="col-sm-8 text-center">
			<div class="input-group input-group-lg">
			<span class="input-group-addon" id="basic-addon2">
			City
			<span class="glyphicon glyphicon-pencil" id="passwordInputglyphicon" name="passwordInputglyphicon" ></span></span>
        		<INPUT type="text" class="form-control" id="pac-input"  required name="city" placeholder="City" value="<%=city%>">
        		<input type="hidden" name="city_lat" id="city_lat" value="<%=city_lat%>">
        		<input type="hidden" name="city_lng" id="city_lng" value="<%=city_lng%>">
        		</div>
        		<div class="help-block with-errors"></div>
        </div>
        </div>





        <div class="form-group">
        <label class="col-sm-3 control-label">Radius:</label>
        <div class="col-sm-8">
        <input class="form-control" type="text" name="radiusLimit"  placeholder="Radius" value="<%=radius%>" required>
        </div>
        </div>



        <div class="form-group">
        	<label class="col-sm-3 control-label">Date:</label>
        	<div class="col-sm-8 text-center">
			<div class='input-group  input-group-lg date' id='datetimepicker1'>
			<span class="input-group-addon" id="basic-addon2">Available:</span>
			<input type='text' name="date" id="date" class="form-control"  value="<%=start_date%>">
			<span class="input-group-addon">
			<span class="glyphicon glyphicon-calendar"></span>
        		</span>

        		</div>
        	</div>
        </div>


        <div class="form-group">
        <label class="col-sm-3 control-label">Name:</label>
        <div class="col-sm-8">
        <input class="form-control" type="text" name="adName"  placeholder="Name" required value="<%=name%>" >
        </div>
        </div>

        <div class="form-group">
        <label class="col-sm-3 control-label">Ad Display Text:</label>
        <div class="col-sm-8">
        <input class="form-control" type="text" name="displayText" placeholder="Phone Number, email or web address" value="<%=ad_message%>">
        </div>
        </div>
        <div class="form-group">
        <label class="col-sm-3 control-label">Audience Targeting Criteria:</label>
        <div class="col-sm-8">		<%
        				ps = connection.prepareStatement("select * from test.ads_target where company_id = ? and ad_id = ? ");
					ps.setString(1, uuid);
					ps.setString(2, request.getParameter("ad_id"));
					resultSet = ps.executeQuery();
					HashMap selectedItem = new HashMap();
					while (resultSet.next()) {
						selectedItem.put(resultSet.getString("target_id"),resultSet.getString("target_id"));
					}
        				ps = connection.prepareStatement("select * from test.ad_audience_results order by ts desc ");
					resultSet = ps.executeQuery();
					String stringResponseAll =  new String();
					int rowCount = 0;
					while (resultSet.next()) {	
						//stringResponseAll = stringResponseAll + "Start<FIELD>" + resultSet.getString("type") + "<FIELD>" + resultSet.getString("description") + "<FIELD>Done<ROW>" ;
					%>
						<INPUT type="hidden" name="TYPECK<%=rowCount%>" value="<%=resultSet.getString("result_id")%>" />
						<INPUT type="checkbox" name="<%=resultSet.getString("result_id")%>" <%if(selectedItem.containsKey(resultSet.getString("result_id"))){%>checked<%}%>  > <%=resultSet.getString("name")%> (<%=resultSet.getString("count")%>)<BR/>
					<%
						rowCount += 1;
					}
			connection.close();
					%>
					<INPUT type="hidden" name="rowCount" value="<%=rowCount%>" />
        </div>
        </div>
         <div class="form-group">
        <label class="col-sm-3 control-label">Set a daily maximum (required):</label>
        <div class="col-sm-8">
        <input class="form-control" type="text" name="dailyLimit"  placeholder="$50.00" required value="<%=dailyMax%>">
        </div>
        </div>    
         <div class="form-group">
        <label class="col-sm-3 control-label">Set a total budget (optional):</label>
        <div class="col-sm-8">
        <input class="form-control" type="text" name="totalLimit"  placeholder="$200.00" value="<%=totalMax%>" >
        </div>
        </div> 

        <div class="form-group">
        <label class="col-sm-3 control-label"></label>
        <div class="col-sm-8">

        <input type="submit" class="btn btn-primary btn-lg" value="Save Advertisement" name="submit1" onclick="addtrucksubmit();">
        <span></span>
        <input type="reset" class="btn btn-default btn-lg" value="Reset Info" >
        </div>
        </div>
        </form>
        </div>
        </div>

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


    <!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
    <script src="assets/js/ie10-viewport-bug-workaround.js"></script>

    <!---- gooogle analytics -->

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
</html><%}else{%>
	        	<a href="../index4.html">Please Login</a>
<%}%>