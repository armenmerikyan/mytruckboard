<%@ page import="com.big.mtb.business.Customer,com.big.util.*,java.text.*,java.util.*,java.io.*,javax.xml.parsers.*,org.w3c.dom.*,java.sql.*,java.text.DateFormat" %>


	<html>

	<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<meta name="description" content="">
	<meta name="author" content="">
	<title>MYTRUCKBOARD 2.0 - edit customers</title>
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
      
    <script src="https://maps.googleapis.com/maps/api/js?v=3.exp&signed_in=true&libraries=places&?key=AIzaSyBpeQ3zGuTunYzxmiNMUltHL352e4beac4"></script>

    <!-- custom maps markers -->
    <!--<script src="css/fontawesome-markers.min.js"></script>-->
	<script type="text/javascript" src="js/jquery.tablesorter.js"></script>
	<!-- end -->

	<!-- =============== APP STYLES ===============-->
	<!--<link rel="stylesheet" href="css/table-app.css" id="maincss">

	<!-- Bootstrap core JavaScript
	================================================== -->
	<script src="js/bootstrap2.min.js"></script>


	<!-- css styles -->
	<link rel="stylesheet" type="text/css" href="css/newstyle2.css">

	<link rel="stylesheet" href="css/navstyle2.css" />

	<!-- end -->

    <script language="JavaScript" type="text/javascript">

    function initialize() {



		var options = {
    types: ['(cities)'],
    componentRestrictions: {country: "us"}
    };



    var input = /** @type {HTMLInputElement} */(
    document.getElementById('address'));
    
 


    var autocomplete = new google.maps.places.Autocomplete(input);

    google.maps.event.addListener(autocomplete, 'place_changed', function() {


    var place = autocomplete.getPlace();

    if (!place.geometry) {
    return;
    }


    document.getElementById('pickCity_lat').value = place.geometry.location.lat();
    document.getElementById('pickCity_lng').value = place.geometry.location.lng();

		var pickCity_latv = (document.getElementById('pickCity_lat').value);
		var pickCity_lngv = (document.getElementById('pickCity_lng').value);
		var pickCityall = (document.getElementById('address').value);
		var parts = pickCityall.split(",");
		var pickCityv = (document.getElementById('address').value); // get the city from the submitted form in case it's already split
		var pickStatev = ""; //
		if(parts.length==4){
			pickCityv = parts[1]; // get the city from the submitted form
			pickStatev = parts[2]; // get the state from the submitted form
			document.getElementById('address').value = parts[0];
			document.getElementById('city').value = pickCityv;
			document.getElementById('state').value = pickStatev;
			//document.getElementById('zip').value = '';
		}
		if(parts.length==3){
			pickStatev = parts[1]; // get the state from the submitted form
			document.getElementById('address').value = parts[0];
			document.getElementById('city').value = '';
			document.getElementById('state').value = pickStatev;
			//document.getElementById('zip').value = '';
		}
	});
    
        
        
    }

    </script>    

		<%if(session.getAttribute("issubscribed")!=null && session.getAttribute("issubscribed").equals("true")){%>
		<%
			String uuid = (String)session.getAttribute("uuid");

			if(uuid !=null){
%>


		</head>


	<body onload="initialize()">


	<%
	String location_name = "";
	String location_phone = "";
	String location_address = "";
	String location_city = "";
	String location_state = "";
	String location_zip = "";
	String location_contact = "";
	String location_email = "";
	String location_fax = "";
	String location_phone_second = "";
	String location_contact_email = "";
	String location_contact_name = "";
	String location_password = "";
	String location_contact_phone = "";
	String location_sales = "";
	String location_note = "";
	String location_note_admin = "";
	
	String location_mc = "";
	String location_urs = "";
	boolean isBlackListed = false;
	boolean isActive = false;
	boolean isBroker = false;
	boolean isFactoring = false;
	String payment_terms = "";
	String credit_limit_display = "";
	String web_site_url = "";
	String ein_number= "";
	String bond_insurance= "";
	String location_id = request.getParameter("location_id");
	String location_number =  request.getParameter("location_number");
	float city_lat = 0 ;
	float city_lng = 0;
	%>
	<%if(request.getParameter("location_id")!=null || request.getParameter("cmd")!=null){
		 try{

			Class.forName("com.mysql.jdbc.Driver");
			String url = "jdbc:mysql://localhost/test?user=<PASSWORD>&password=<PASSWORD>";

			Connection connection = DriverManager.getConnection(url,"<USERNAME>", "<PASSWORD>");
			DateFormat formatter = new SimpleDateFormat("MM-dd-yyyy.HH.mm.ss");
			DateFormat formatterDate = new SimpleDateFormat("MM-dd-yyyy");
			PreparedStatement ps ;
			if(request.getParameter("cmd")!=null && request.getParameter("cmd").equals("addLocation")){
					boolean saveIsBlackList = false;
					boolean saveIsBroker = false;
					boolean saveIsActive = false;
					boolean saveIsFactoring = false;
					float credit_limit = 0.0f;
					if(request.getParameter("isBlackListed")!=null && request.getParameter("isBlackListed").equals("Yes"))saveIsBlackList= true;
					if(request.getParameter("isBroker")!=null && request.getParameter("isBroker").equals("Yes"))saveIsBroker= true;
					if(request.getParameter("isFactoring")!=null && request.getParameter("isFactoring").equals("Yes"))saveIsFactoring= true;
					if(request.getParameter("isActive")!=null && request.getParameter("isActive").equals("Active"))saveIsActive= true;
					if(!request.getParameter("credit_limit").equals(""))credit_limit = Float.parseFloat(request.getParameter("credit_limit").trim());
			
					Calendar cal = Calendar.getInstance();
					java.sql.Date date_mod = null;
					if(request.getParameter("date")==null || request.getParameter("date").equals("")){
						date_mod = new java.sql.Date(((java.util.Date)formatter.parse(formatterDate.format(cal.getTime()) + ".00.00.00" )).getTime());
					}else{
						date_mod = new java.sql.Date(((java.util.Date)formatter.parse(request.getParameter("date") + ".00.00.00" )).getTime());
					}
					location_id = UUID.randomUUID() + "";
					ps = connection.prepareStatement("INSERT INTO test.locations(location_id, ts, company_id, created_by, org_name, org_phone, org_email, contact_name, contact_phone, contact_email,  city, address, address2, addressLocation, location_type, state, zip, mc_number, urs_number, sales_rep, notes, isBlackListed, isBroker, isActive, credit_limit, payment_terms, org_fax, org_phone_second, web_site_url, ein_number, bond_insurance, isFactoring,notes_admin, password) VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,GeomFromText(?),?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
					ps.setString(1, location_id);
					java.sql.Timestamp ts = new java.sql.Timestamp((new java.util.Date()).getTime());
					ps.setTimestamp(2, ts);
					ps.setString(3, uuid);
					ps.setString(4, (String)session.getAttribute("login_id"));
					ps.setString(5, request.getParameter("location_name"));
					ps.setString(6, request.getParameter("org_phone"));
					ps.setString(7, request.getParameter("org_email"));
					ps.setString(8, request.getParameter("contact_name"));
					ps.setString(9, request.getParameter("contact_phone"));
					ps.setString(10, request.getParameter("contact_email"));
					ps.setString(11, request.getParameter("city"));
					ps.setString(12, request.getParameter("address"));
					ps.setString(13, request.getParameter("address2"));
					String latLong = "POINT(1 2)";
					if(request.getParameter("pickCity_lat")!=null && request.getParameter("pickCity_lng")!=null){
						latLong = "POINT(" + request.getParameter("pickCity_lat") + " " + request.getParameter("pickCity_lng") + ")";
					}
					ps.setString(14, latLong);
					ps.setString(15, "Billing");
					ps.setString(16, request.getParameter("state"));	
					ps.setString(17, request.getParameter("zip"));	
					ps.setString(18, request.getParameter("location_mc"));
					ps.setString(19, request.getParameter("location_urs"));	
					ps.setString(20, request.getParameter("location_sales"));	
					ps.setString(21, request.getParameter("note"));		
					ps.setBoolean(22, saveIsBlackList);	
					ps.setBoolean(23, saveIsBroker);	
					ps.setBoolean(24, saveIsActive);
					ps.setFloat(25, credit_limit);
					ps.setString(26, request.getParameter("payment_terms"));
					ps.setString(27, request.getParameter("org_fax"));
					ps.setString(28, request.getParameter("org_phone_second"));
					ps.setString(29, request.getParameter("web_site_url"));	
					ps.setString(30, request.getParameter("ein_number"));
					ps.setString(31, request.getParameter("bond_insurance"));
					ps.setBoolean(32, saveIsFactoring);	
					ps.setString(33, request.getParameter("note_admin"));	
					ps.setString(34, request.getParameter("cp22"));				
					ps.executeUpdate();
					
					com.big.mtb.business.Customer newCustomer = new com.big.mtb.business.Customer();
					newCustomer.copyCustomerToWeb(location_id, uuid);
	
					
				boolean plusTwo = false;
				for(int tc = 0;tc<20;tc++){
					ps = connection.prepareStatement("select * from test.locations WHERE locations.COMPANY_ID = ? order by locations.location_number_float desc limit 1");
					ps.setString(1, uuid);
					ResultSet resultSet = ps.executeQuery();
					int ln_count = 0;
					int new_ln_count = ln_count + 1;
					while (resultSet.next()) {
						if(resultSet.getString("location_number_float")!=null){
							ln_count = Integer.parseInt(resultSet.getString("location_number_float"));
						}	
							new_ln_count = ln_count + 1 + tc;
							if(plusTwo){new_ln_count = new_ln_count + 1;}
					}
					
		     			System.out.println("NEW LN NUMBER TEMP ::"+ new_ln_count  + "OLD "  + ln_count);
					ps = connection.prepareStatement("Update test.locations Set location_number_tmp = ? where location_id = ? and company_id = ?");
					ps.setString(1, "CN" + new_ln_count);	
					ps.setString(2, location_id);
					ps.setString(3, uuid);	
					ps.executeUpdate();	
					
					ps = connection.prepareStatement("select * from test.locations WHERE locations.COMPANY_ID = ? and location_number_tmp = ?");
					ps.setString(1, uuid);
					ps.setString(2, "CN" + new_ln_count);
					ResultSet resultSetTmp = ps.executeQuery();
					boolean lockedLN = false;
					while (resultSetTmp.next()) {
						if(resultSetTmp.getString("location_id").equals(location_id)){
							lockedLN = true;
						}else{
							lockedLN = false;
							plusTwo = false;
							break;
						}
					}
					if(lockedLN){
						ps = connection.prepareStatement("select * from test.locations WHERE locations.COMPANY_ID = ? and (location_number_float = ? or location_number = ?)");
						ps.setString(1, uuid);
						ps.setFloat(2, (float)new_ln_count);
						ps.setString(3, "CN" + new_ln_count);
						resultSetTmp = ps.executeQuery();
						boolean isUsed = false;
						while (resultSetTmp.next()) {
							isUsed  = true;
							plusTwo = true;
						}
						if(!isUsed){
							ps = connection.prepareStatement("Update test.locations Set location_number_float = ?, location_number = ? where location_id= ? and company_id = ?");
							ps.setFloat(1, (float)new_ln_count);
							ps.setString(2, "CN" + new_ln_count);	
							ps.setString(3, location_id);
							ps.setString(4, uuid);	
							ps.executeUpdate();	
							location_number = "CN" + new_ln_count;
							tc=21;
							break;
						}
					}								
				}					
			}
			if(request.getParameter("cmd")!=null && request.getParameter("cmd").equals("saveLocation")){	
					boolean saveIsBlackList = false;
					boolean saveIsBroker = false;
					boolean saveIsActive = false;
					boolean saveIsFactoring = false;
					float credit_limit = 0.0f;
					if(request.getParameter("isBlackListed")!=null && request.getParameter("isBlackListed").equals("Yes"))saveIsBlackList= true;
					if(request.getParameter("isBroker")!=null && request.getParameter("isBroker").equals("Yes"))saveIsBroker= true;
					if(request.getParameter("isFactoring")!=null && request.getParameter("isFactoring").equals("Yes"))saveIsFactoring= true;
					if(request.getParameter("isActive")!=null && request.getParameter("isActive").equals("Active"))saveIsActive= true;
					if(!request.getParameter("credit_limit").equals(""))credit_limit = Float.parseFloat(request.getParameter("credit_limit").trim());
					ps = connection.prepareStatement("Update test.locations Set org_name = ?, org_phone = ?, address = ?, city = ?, state = ?, zip = ?, contact_name = ?, contact_phone = ?, org_email = ?, mc_number =?, urs_number = ?, sales_rep = ?, notes = ?, isBlackListed = ?, isBroker = ?, isActive= ?, credit_limit = ?, payment_terms = ?, addressLocation = GeomFromText(?), org_fax = ?, org_phone_second = ?, web_site_url = ?, ein_number =?, bond_insurance =?, isFactoring = ?, notes_admin=?, password = ?  where company_id = ? and location_id = ?");
					ps.setString(1, request.getParameter("location_name"));	
					ps.setString(2, request.getParameter("org_phone"));
					ps.setString(3, request.getParameter("address"));	
					ps.setString(4, request.getParameter("city"));	
					ps.setString(5, request.getParameter("state"));	
					ps.setString(6, request.getParameter("zip"));	
					ps.setString(7, request.getParameter("contact_name"));	
					ps.setString(8, request.getParameter("contact_phone"));	
					ps.setString(9, request.getParameter("org_email"));	
					ps.setString(10, request.getParameter("location_mc"));
					ps.setString(11, request.getParameter("location_urs"));	
					ps.setString(12, request.getParameter("location_sales"));	
					ps.setString(13, request.getParameter("note"));		
					ps.setBoolean(14, saveIsBlackList);	
					ps.setBoolean(15, saveIsBroker);	
					ps.setBoolean(16, saveIsActive);
					ps.setFloat(17, credit_limit);
					ps.setString(18, request.getParameter("payment_terms"));	
					String latLong = "POINT(1 2)";
					if(request.getParameter("pickCity_lat")!=null && request.getParameter("pickCity_lng")!=null){
						latLong = "POINT(" + request.getParameter("pickCity_lat") + " " + request.getParameter("pickCity_lng") + ")";
					}
					ps.setString(19, latLong);					
					ps.setString(20, request.getParameter("org_fax"));	
					ps.setString(21, request.getParameter("org_phone_second"));
					ps.setString(22, request.getParameter("web_site_url"));	
					ps.setString(23, request.getParameter("ein_number"));		
					ps.setString(24, request.getParameter("bond_insurance"));	
					ps.setBoolean(25, saveIsFactoring);	
					ps.setString(26, request.getParameter("note_admin"));
					ps.setString(27, request.getParameter("cp22"));
					ps.setString(28, uuid);
					ps.setString(29, request.getParameter("location_id"));	
					ps.executeUpdate();	
					

	com.big.mtb.business.Customer newCustomer = new com.big.mtb.business.Customer();
	newCustomer.copyCustomerToWeb(request.getParameter("location_id"), uuid);
	
			}
			
			
			ps = connection.prepareStatement("select password, location_number, isFactoring, bond_insurance, ein_number, notes_admin, web_site_url, org_phone_second, org_fax, org_name, org_phone, address, city, state, zip, contact_name, contact_phone, contact_email, org_email, notes, sales_rep, mc_number, urs_number, isBlackListed, isActive, isBroker, credit_limit, payment_terms, X(addressLocation) as city_lat, Y(addressLocation) as city_lng from test.locations where company_id = ? and location_id = ?");						
			ps.setString(1, uuid);
			ps.setString(2, location_id);
			ResultSet resultSetShow = ps.executeQuery();
			while (resultSetShow.next()) {
				location_name = resultSetShow.getString("org_name");
				location_phone = resultSetShow.getString("org_phone");
				location_address = resultSetShow.getString("address");
				location_city = resultSetShow.getString("city");
				location_state = resultSetShow.getString("state");
				location_zip = resultSetShow.getString("zip");
				location_contact_name = resultSetShow.getString("contact_name");
				location_password = resultSetShow.getString("password");
				location_contact_phone = resultSetShow.getString("contact_phone");
				location_contact_email = resultSetShow.getString("contact_email");
				location_email = resultSetShow.getString("org_email");
				location_fax = resultSetShow.getString("org_fax");
				location_phone_second = resultSetShow.getString("org_phone_second");
				location_note = resultSetShow.getString("notes");
				location_note_admin = resultSetShow.getString("notes_admin");				
				location_sales = resultSetShow.getString("sales_rep");
				location_mc = resultSetShow.getString("mc_number");
				location_urs = resultSetShow.getString("urs_number");
				isBlackListed = resultSetShow.getBoolean("isBlackListed");
				isActive = resultSetShow.getBoolean("isActive");
				isBroker = resultSetShow.getBoolean("isBroker");
				isFactoring = resultSetShow.getBoolean("isFactoring");
				credit_limit_display = resultSetShow.getString("credit_limit");
				web_site_url = resultSetShow.getString("web_site_url");
				payment_terms = resultSetShow.getString("payment_terms");
				ein_number  = resultSetShow.getString("ein_number");
				bond_insurance =   resultSetShow.getString("bond_insurance");
				city_lat = resultSetShow.getFloat("city_lat");
				city_lng = resultSetShow.getFloat("city_lng");
				location_number =  resultSetShow.getString("location_number");
			}
			
			connection.close();
		 }catch (Exception ex){
		     %><%="Error Posting " + ex%><%
		     System.out.println(""+ ex);
		 }		
	}%>


			<%@include file="nav_menu.jsp"%>   


	<!-- Main page: -->

	<div class="container">
		<div class="row">
			<br/><br/><br/><br/>
			<form  name="searchForm" id="searchForm" action="dispatch_edit_customers.jsp" method="post">
				<div class="panel panel-primary" >
					<div class="panel-heading">
						<div class="input-group" style="padding:5px;">
							<input type="hidden" name="pickCity_lat" id="pickCity_lat" value="<%=city_lat%>" />
							<input type="hidden" name="pickCity_lng" id="pickCity_lng" value="<%=city_lng%>" />
							<input type="hidden" name="pickCity" id="pickCity" value="">
							<input type="hidden" name="pickState" id="pickState" value="">
							<a href="dispatch_customers.jsp?isActive=true&searchKey=&ShowSearchCustomers=true" style="color:white"><span class="glyphicon glyphicon-backward" aria-hidden="true" style="color:white" ></span>&nbsp;BACK</a>&nbsp;&nbsp;
							<button class="btn btn-primary"  role="button"  name="btn_shipper_save" id="btn_shipper_save" type="submit" ><span class="glyphicon glyphicon-save" aria-hidden="true"></span>&nbsp;SAVE</button>
							&nbsp;&nbsp;

						</div>
					</div>
					<div class="panel-body">
						<ul class="nav nav-tabs">

							<%if(request.getParameter("location_id")!=null || (request.getParameter("cmd")!=null && request.getParameter("cmd").equals("addLocation"))){%>
							<li class="active"><a data-toggle="tab" href="#home" onclick="showLoadInfo()" >Edit Customer - <%=NullCheck.check(location_number)%></a></li>
							<%}else{%>
							<li class="active"><a data-toggle="tab" href="#home" onclick="showLoadInfo()" >Add New Customer</a></li>
							<%}%>
						</ul>


						<div id="load_info" name="load_info" style="display:inline;" >
							<div class="form-wrapper">

								<div class="input-group" style="padding:5px;">


									<div class="row">
										<div class="col-md-3">
											<div class="form-group">
												<label>Company Name </label>
												<%if(request.getParameter("location_id")!=null || (request.getParameter("cmd")!=null && request.getParameter("cmd").equals("addLocation"))){%>
												<input type="hidden" id="location_id" name="location_id" value="<%=location_id%>" />
												<input type="hidden" id="cmd" name="cmd" value="saveLocation" />
												<%}else{%>
												<input type="hidden" id="cmd" name="cmd" value="addLocation" />
												<%}%>
												<input type="text" class="form-control" name="location_name" id="location_name"  placeholder="Name" value="<%=location_name%>" />
											</div>
										</div>

										<div class="col-md-2">
											<div class="form-group">
												<label>Main Phone</label>
												<input type="text" class="form-control"  name="org_phone" id="org_phone"  placeholder="" value="<%=NullCheck.check(location_phone)%>"/>
											</div>
										</div>

										<div class="col-md-3">
											<div class="form-group">
												<label>Address</label>
												<input type="text" class="form-control"  placeholder="" name="address" id="address" value="<%=NullCheck.check(location_address)%>"/>
											</div>
										</div>

										<div class="col-md-2">
											<div class="form-group">
												<label>City</label>
												<input type="text" class="form-control"  name="city" id="city" placeholder=""  value="<%=NullCheck.check(location_city)%>"/>
											</div>
										</div>

										<div class="col-md-1">
											<div class="form-group">
												<label>State</label>
												<input type="text" class="form-control"  name="state" id="state"  placeholder="" value="<%=NullCheck.check(location_state)%>"/>
											</div>
										</div>


										<div class="col-md-1">
											<div class="form-group">
												<label>Zip Code</label>
												<input type="text" class="form-control"  placeholder=""  name="zip" id="zip"  value="<%=NullCheck.check(location_zip)%>"/>
											</div>
										</div>

									</div>





									<div class="row">
										<div class="col-md-3">
											<div class="form-group">
												<label>Primary Contact [Click to Edit]</label>
												<input readonly onfocus="this.removeAttribute('readonly');"  type="text" class="form-control" name="contact_name" id="contact_name"  placeholder="" value="<%=NullCheck.check(location_contact_name)%>" />
											</div>
										</div>

										<div class="col-md-2">
											<div class="form-group">
												<% 
												if(location_password ==null || location_password.equals("")){
													location_password  = (UUID.randomUUID() + "").substring(0,6);
												}	
												%>
												<label>Portal Password</label>
												<input type="text" class="form-control"  name="cp22" id="cp22"  placeholder="" value="<%=NullCheck.check(location_password)%>" />
											</div>
										</div>
		
										<div class="col-md-3" >
											<div class="form-group">
												<label>E-MAIL [Click to Edit]</label>
												<input readonly onfocus="this.removeAttribute('readonly');" type="text" class="form-control"  placeholder="john@gmail.com" name="org_email" id="org_email" value="<%=location_email%>" />
											</div>
										</div>

										<div class="col-md-2">
											<div class="form-group">
												<label>Contact Phone</label>
												<input type="text" class="form-control"  name="contact_phone" id="contact_phone"  placeholder="" value="<%=location_contact_phone%>" />
											</div>
										</div>

										<div class="col-md-2">
											<div class="form-group">
												<label>Fax</label>
												<input type="text" class="form-control"  placeholder="" name="org_fax" id="org_fax" value="<%=NullCheck.check(location_fax)%>" />
											</div>
										</div>

									</div>
								</div>
							</div>
							<div class="form-wrapper">

								<div class="row">
									<div class="col-md-2">
										<div class="form-group">
											<label>M.C. #</label>
											<input type="text" class="form-control" name="location_mc" id="location_mc"  placeholder=""  onblur="updateSaferSys()" value="<%=NullCheck.check(location_mc)%>" />
										</div>
									</div>

									<div class="col-md-2">
										<div class="form-group">
											<label>URS #</label>
											<input type="text" class="form-control"  name="location_urs" id="location_urs"  placeholder="" value="<%=NullCheck.check(location_urs)%>" />
										</div>
									</div>

									<div class="col-md-2">
										<div class="form-group">
											<label>EIN Number </label>
											<input type="text" class="form-control" name="ein_number" id="ein_number"  placeholder="54-983142" value="<%=NullCheck.check(ein_number)%>" />
										</div>
									</div>

									<div class="col-md-2">
										<div class="form-group">
											<label>Customer ID</label>
											<input type="text" class="form-control" style="color:green;" name="location_number" id="location_number"  placeholder="CRN555-fe" readonly value="<%=NullCheck.check(location_number)%>" />
										</div>
									</div>

									<div class="col-md-2">
										<div class="form-group">
											<label style="padding-left:5px">Account Status</label><br/>

											<label class="radio-inline" style="color:#777; padding: 7px;">
												<input type="radio" name="isActive" id="isActive" value="Active" <%if(isActive){%>checked<%}%> > Active
											</label>
											<label class="radio-inline" style="color:#777; padding: 7px;">
												<input type="radio" name="isActive" id="isActive" value="Inactive" <%if(!isActive){%>checked<%}%> > Inactive
											</label>

										</div>
									</div>

								</div>

							</div>

							<div class="form-wrapper">

								<div class="row">

									<div class="col-md-3">
										<div class="form-group">
											<label>Payment Terms</label>

											<select class="form-control" name="payment_terms" id="payment_terms" value="<%=NullCheck.check(payment_terms)%>">
												<option value="4">30 Days</option><option value="183"> 5% 7 days</option><option value="174">- COD (Check or Cash on Delivery)</option><option value="229">1</option><option value="297">1 day</option><option value="129">1%</option><option value="127">1%</option><option value="135">1% 14 days</option><option value="141">1% 15 days</option><option value="21">1% 7 Days Net 15</option><option value="322">1% net 10</option><option value="1">1% Net 30</option><option value="154">1.10</option><option value="222">1.5% 15 days Net 30</option><option value="99">1.5% 2 days</option><option value="41">1.5% 2 Net 30</option><option value="103">1.5% 3 days</option><option value="131">1.5% 90 DAYS</option><option value="139">1.9%Quick Pay</option><option value="15">1/2% 10 Days</option><option value="82">1/2% Due on Receipt</option><option value="251">10 day</option><option value="133">10 Days</option><option value="252">11 day</option><option value="253">12 day</option><option value="256">13 day</option><option value="259">14 day</option><option value="145">14 days</option><option value="22">14 days 1%</option><option value="262">15 day</option><option value="59">15 Days</option><option value="264">16 day</option><option value="267">17 day</option><option value="210">17 days</option><option value="269">18 day</option><option value="272">19 day</option><option value="231">1day</option><option value="300">2 day</option><option value="234">2 day</option><option value="115">2%</option><option value="86">2% 0-</option><option value="92">2% 0-30</option><option value="16">2% 10 Days Net 30</option><option value="36">2% 15 Days Net 30</option><option value="143">2% 3 days</option><option value="180">2% 5 days</option><option value="74">2% 7 days quick pay</option><option value="34">2% 7days, Net 30</option><option value="324">2% net 14</option><option value="94">2% net 15</option><option value="2">2% Net 30</option><option value="105">2% next day</option><option value="213">2% Quick Pay</option><option value="123">2.25</option><option value="125">2.25 next day</option><option value="119">2.5%</option><option value="181">2.5% quick pay</option><option value="195">2.75%</option><option value="65">2.9% net 30</option><option value="275">20 day</option><option value="276">21 day</option><option value="12">21 Days</option><option value="278">22 day</option><option value="279">23 day</option><option value="96">23 Days</option><option value="282">24 day</option><option value="209">24 hours</option><option value="283">25 day</option><option value="286">26 day</option><option value="287">27 day</option><option value="290">28 day</option><option value="3">28 Days</option><option value="162">28 days</option><option value="293">29 day</option><option value="235">3 day</option><option value="301">3 day</option><option value="205">3%</option><option value="208">3% 10 days</option><option value="23">3% 10 Days Net 30</option><option value="101">3% 2 days</option><option value="107">3% 3 days</option><option value="88">3% 31-45 days</option><option value="117">3% 5 days</option><option value="43">3% 7 days, Net 30</option><option value="60">3% Next Day</option><option value="98">3% quick pay</option><option value="228">3.5 % + 5$</option><option value="194">3.5% - 1 Day</option><option value="64">3.5% Quick Pay -7Days</option><option value="62">3.75% Quick Pay</option><option value="39">3.9 % Quick Pay</option><option value="294">30 day</option><option value="4" selected="selected">30 Days</option><option value="111">35 days</option><option value="56">37 Days</option><option value="303">4 day</option><option value="236">4 day</option><option value="217">4%</option><option value="219">4% 1 Day</option><option value="76">4% 3 days quick pay</option><option value="90">4% 46-60 days</option><option value="170">4% 5 days</option><option value="44">4% 7 Days</option><option value="158">4% same day</option><option value="319">4.2% Net</option><option value="321">4.25% Net</option><option value="84">4.5% Net</option><option value="185">4.95</option><option value="25">45 Days</option><option value="239">5 day</option><option value="306">5 day</option><option value="78">5% 1 day </option><option value="24">5% 1 Net 30</option><option value="109">5% 2 days</option><option value="33">5% 28 days, Net 30</option><option value="147">5% 3days</option><option value="153">5% next day</option><option value="149">5% quick pay</option><option value="35">5%, 10 Days net 30</option><option value="309">6 day</option><option value="242">6 day</option><option value="202">6%</option><option value="198">6%</option><option value="187">6%</option><option value="156">60 days</option><option value="13">60 Days</option><option value="245">7 day</option><option value="312">7 day</option><option value="199">7%</option><option value="314">8 day</option><option value="246">8 days</option><option value="225">8 days</option><option value="46">80</option><option value="316">9 day</option><option value="248">9 day</option><option value="48">90</option><option value="14">90 Days</option><option value="70">ACH</option><option value="11">Cash on Delivery</option><option value="121">Check on Delivery</option><option value="178">COD (Check or Cash on Delivery)</option><option value="5">Consignment</option><option value="172">COP (Check or Cash on Pick-up)</option><option value="18">Credit Card</option><option value="223">days</option><option value="6">Due on Receipt</option><option value="57">Factored</option><option value="168">INSTAPAY PAYMENT 1.9%</option><option value="26">NET</option><option value="31">Net </option><option value="7">Net 10</option><option value="68">Net 10 @ 2%</option><option value="67">Net 14 Days</option><option value="8">Net 15</option><option value="37">Net 20</option><option value="186">net 23</option><option value="160">net 24</option><option value="32">Net 25</option><option value="9">Net 30</option><option value="113">Net 30 Days</option><option value="215">Net 30 From Ship Date</option><option value="326">Net 35</option><option value="10">Net 60</option><option value="30">Net 7</option><option value="329">Net 7 Upon Customer Receipt</option><option value="189">NET DUE</option><option value="19">Prepaid</option><option value="71">Quick 2%</option><option value="20">Quick Pay</option><option value="137">Quick Pay</option><option value="52">Quick Pay 1-2 Days</option><option value="176">Quick Pay 2 days</option><option value="151">quick pay 4% 1-2 days</option><option value="54">Quick Pay 5 Business Days</option><option value="27">Quick Pay 5 Days</option><option value="164">Quick pay 5%</option><option value="166">Quick pay 6%</option><option value="28">Quick Pay 7 Days</option><option value="29">Quick Pay ACH</option><option value="191">Quick pay Com Check</option><option value="192">Quick pay EFS</option><option value="73">Quickpay 4%</option><option value="50">Wire Transfer</option>								</select>


										</div>
									</div>



									<div class="col-md-2">
										<div class="form-group">
											<label>Blacklisted</label>

											<div class="checkbox">
												<label style="padding-left:25px">
													<input type="checkbox" name="isBlackListed" id="isBlackListed" value="Yes"  <%if(isBlackListed){%>checked<%}%> >
													Is blacklisted
												</label>
											</div>

										</div>
									</div>



									<div class="col-md-2">
										<div class="form-group">
											<label>Broker</label>

											<div class="checkbox">
												<label style="padding-left:25px">
													<input type="checkbox" name="isBroker" id="isBroker" value="Yes"  <%if(isBroker){%>checked<%}%>>
													This is a broker
												</label>
											</div>

										</div>
									</div>
									<div class="col-md-3">
										<div class="form-group">
											<label>Factoring</label>

											<div class="checkbox">
												<label style="padding-left:25px">
													<input type="checkbox" name="isFactoring" id="isFactoring" value="Yes"  <%if(isFactoring){%>checked<%}%>>
													Customer is using Factoring
												</label>
											</div>

										</div>
									</div>
								</div>



								<div class="row">

										<div class="col-md-3">
											<div class="form-group">
												<label>Bond Insurance</label>
												<input type="text" class="form-control" name="bond_insurance" id="bond_insurance"  placeholder="" value="<%=NullCheck.check(bond_insurance)%>" />
											</div>
										</div>

										<div class="col-md-2">
											<div class="form-group">
												<label>Credit Limit ($)</label>
												<input type="text" class="form-control" name="credit_limit" id="credit_limit"  placeholder="" value="<%=NullCheck.check(credit_limit_display)%>" />
											</div>
										</div>

										<div class="col-md-2">
											<div class="form-group">
												<label>Sales Person </label>
												<input type="text" class="form-control" name="location_sales" id="location_sales"  placeholder="" value="<%=NullCheck.check(location_sales)%>" />
											</div>
										</div>


								</div>


							</div>

							<div class="form-wrapper">
									<div class="row">
										<div class="col-md-4">
											<div class="form-group">
												<label>Web Site Address</label>
												<input type="text" class="form-control" name="web_site_url" id="web_site_url"  placeholder="http://www.ShipperWebSite.com" value="<%=NullCheck.check(web_site_url)%>" />
											</div>
										</div>

									</div>

								<div class="row">
									<div class="col-md-12">

										<div class="form-group">
											<label>Notes</label>
											<textarea class="form-control" rows="2" name="note" id="note"  placeholder="notes....." ><%=NullCheck.check(location_note)%></textarea>
										</div>

									</div>
								</div>
								<div class="row">
									<div class="col-md-12">
										<div class="form-group">
											<label>Admin Notes</label>
											<textarea class="form-control" rows="2" name="note_admin" id="note_admin"  placeholder="Admin notes....." ><%=NullCheck.check(location_note_admin)%></textarea>
										</div>
									</div>

								</div>

							</div><!-- end of form wrapper -->
						</div>
					</div>


				</div>
			</form>



		</div><!-- end of row -->



		<%}%>

	<!-- /Main page -->
	<!-- .subfooter start -->
	<!-- ================ -->
	<section id="footer">
	<div class="copyright">
	<ul class="menu">
	<li>Copyright &copy; 2015 Litewsorks2 Inc. All rights reserved.</li>
	</ul>
	<ul class="menu">
	<li>&copy;<a href="http://liteworks2.com">Litewsorks2 Inc </a> </li>
	<li>599 Fairchild Dr, Mountain View, CA 94043 United States</li>
	<li>email: LW2@liteworks2.com </li>
	<li>twitter: @liteworks2</li>
	<li>voice: (650) 567-4439</li>
	</ul>
	</div>
	<!-- .subfooter end -->
	</section>




	</div><!-- /.container -->



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
	        	