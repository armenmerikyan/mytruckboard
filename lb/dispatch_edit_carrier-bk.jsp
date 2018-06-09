<%@ page import="com.big.util.*,java.text.*,java.util.*,java.io.*,javax.xml.parsers.*,org.w3c.dom.*,java.sql.*,java.text.DateFormat" %>


	<html>

	<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<meta name="description" content="">
	<meta name="author" content="">
	<title>MYTRUCKBOARD 2.0 - edit carrier</title>
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
    
        function updateTruckListSum(){
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
			document.getElementById("carrier_equipment_list_sum").innerHTML = xmlhttp.responseText; 
			
		}
		}
		var responseString = "?MC_NO=" + encodeURIComponent(document.getElementById("location_mc").value);
		xmlhttp.open("GET", "dispatch_edit_carrier_trucklist_sum.jsp" + responseString,true);
		xmlhttp.send();
            }    
        function updateTruckList(){
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
			document.getElementById("carrier_equipment_list").innerHTML = xmlhttp.responseText; 
			
		}
		}
		var responseString = "?MC_NO=" + encodeURIComponent(document.getElementById("location_mc").value);
		xmlhttp.open("GET", "dispatch_edit_carrier_trucklist.jsp" + responseString,true);
		xmlhttp.send();
            }
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
			document.getElementById("safer_address1").value = addressList[3]; 
			document.getElementById("safer_city").value = addressList[4]; 
			document.getElementById("safer_state").value = addressList[5]; 
			document.getElementById("safer_zip").value = addressList[6]; 
			document.getElementById("safer_phone").value = addressList[7]; 
			document.getElementById("safer_fax").value = addressList[8]; 
			document.getElementById("safer_needed").value = addressList[1]; 
			document.getElementById("safer_onfile").value = addressList[2]; 
			document.getElementById("safer_mc").value = document.getElementById("location_mc").value; 
			document.getElementById("org_fax").value = addressList[8]; 
			document.getElementById("org_phone").value = addressList[7]; 
			document.getElementById("location_name").value = addressList[9]; 
			document.getElementById("address").value = addressList[3]; 
			document.getElementById("city").value = addressList[4]; 
			document.getElementById("state").value = addressList[5]; 
			document.getElementById("zip").value = addressList[6]; 
			
		}
		}
		var responseString = "?MC_NO=" + encodeURIComponent(document.getElementById("location_mc").value);
		xmlhttp.open("GET", "safersys.api.jsp" + responseString,true);
		xmlhttp.send();
            }
        function showCarrierInfo(){
        		document.getElementById("carrier_info").style.display = "inline"; 
        		document.getElementById("carrier_notes").style.display = "none";    
        		document.getElementById("carrier_insurance").style.display = "none";      		
        		document.getElementById("carrier_equipment").style.display = "none";   
        		document.getElementById("carrier_equipment_sum").style.display = "none";           		        		
        }
        function showInsuranceInfo(){
        		document.getElementById("carrier_info").style.display = "none"; 
        		document.getElementById("carrier_notes").style.display = "none";    
        		document.getElementById("carrier_insurance").style.display = "inline";      		
        		document.getElementById("carrier_equipment").style.display = "none";      
        		document.getElementById("carrier_equipment_sum").style.display = "none";           		        		
        		updateSaferSys();
        		
        }
        function showEquipmentInfo(){
        		document.getElementById("carrier_info").style.display = "none"; 
        		document.getElementById("carrier_notes").style.display = "none";    
        		document.getElementById("carrier_insurance").style.display = "none";            		
        		document.getElementById("carrier_equipment").style.display = "inline";
        		document.getElementById("carrier_equipment_sum").style.display = "none";           		        		
        		updateTruckList();
        }
        function showEquipmentSumInfo(){
        		document.getElementById("carrier_info").style.display = "none"; 
        		document.getElementById("carrier_notes").style.display = "none";    
        		document.getElementById("carrier_insurance").style.display = "none";            		
        		document.getElementById("carrier_equipment").style.display = "none";
        		document.getElementById("carrier_equipment_sum").style.display = "inline";           		        		
        		updateTruckListSum();
        }
        function showNotesInfo(){
        		document.getElementById("carrier_info").style.display = "none"; 
        		document.getElementById("carrier_notes").style.display = "inline";    
        		document.getElementById("carrier_insurance").style.display = "none";        		
        		document.getElementById("carrier_equipment").style.display = "none";     
        		document.getElementById("carrier_equipment_sum").style.display = "none";           		        		
        		
        }
        
    </script>    
    <script type="text/javascript">
    $(function () {
    $('#datetimepicker1').datetimepicker({
    format: 'MM-DD-YYYY',
    showClear: true

    });
    $('#datetimepicker2').datetimepicker({
    format: 'MM-DD-YYYY',
    showClear: true

    });
    $('#datetimepicker3').datetimepicker({
    format: 'MM-DD-YYYY',
    showClear: true

    });
    });
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
	boolean isCorporation = false;
	String payment_terms = "";
	String credit_limit_display = "";
	String web_site_url = "";
	String ein_number= "";
	String ssn_number= "";
	String dot_number= "";
	String bond_insurance= "";
	String location_id = request.getParameter("location_id");
	String location_number =  request.getParameter("location_number");
	float city_lat = 0 ;
	float city_lng = 0;
	String ins_name= "";
	String ins_contact= "";
	String ins_phone= "";
	String ins_policy_no= "";
	String ins_exp_date= "";
	float ins_amount = 0;
	String ins_name_auto= "";
	String ins_contact_auto= "";
	String ins_phone_auto= "";
	String ins_policy_no_auto= "";
	String ins_exp_date_auto= "";
	float ins_amount_auto = 0;
	String ins_name_cargo= "";
	String ins_contact_cargo= "";
	String ins_phone_cargo= "";
	String ins_policy_no_cargo= "";
	String ins_exp_date_cargo= "";
	float ins_amount_cargo = 0;
	String ins_notes = "";
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
					boolean saveIsCorporation = false;
					float credit_limit = 0.0f;
					float saveins_amount = 0.0f;
					float saveins_amount_auto = 0.0f;
					float saveins_amount_cargo = 0.0f;
					if(request.getParameter("isBlackListed")!=null && request.getParameter("isBlackListed").equals("Yes"))saveIsBlackList= true;
					if(request.getParameter("isBroker")!=null && request.getParameter("isBroker").equals("Yes"))saveIsBroker= true;
					if(request.getParameter("isFactoring")!=null && request.getParameter("isFactoring").equals("Yes"))saveIsFactoring= true;
					if(request.getParameter("isActive")!=null && request.getParameter("isActive").equals("Active"))saveIsActive= true;
					if(request.getParameter("isCorporation")!=null && request.getParameter("isCorporation").equals("Yes"))saveIsCorporation= true;
					if(!request.getParameter("ins_amount").equals(""))saveins_amount = Float.parseFloat(request.getParameter("ins_amount").trim());
					if(!request.getParameter("ins_amount_auto").equals(""))saveins_amount_auto = Float.parseFloat(request.getParameter("ins_amount_auto").trim());
					if(!request.getParameter("ins_amount_cargo").equals(""))saveins_amount_cargo = Float.parseFloat(request.getParameter("ins_amount_cargo").trim());
							
					Calendar cal = Calendar.getInstance();
					java.sql.Timestamp date_mod = null;
					java.sql.Timestamp date_mod_auto = null;
					java.sql.Timestamp date_mod_cargo = null;
					if(request.getParameter("ins_exp_date")!=null &&  !request.getParameter("ins_exp_date").equals("")){
						date_mod = new java.sql.Timestamp((formatter.parse(request.getParameter("ins_exp_date") + ".00.00.02" )).getTime());					
					}
					if(request.getParameter("ins_exp_date_auto")!=null &&  !request.getParameter("ins_exp_date_auto").equals("")){
						date_mod_auto = new java.sql.Timestamp((formatter.parse(request.getParameter("ins_exp_date_auto") + ".00.00.02" )).getTime());					
					}
					if(request.getParameter("ins_exp_date_cargo")!=null &&  !request.getParameter("ins_exp_date_cargo").equals("")){
						date_mod_cargo = new java.sql.Timestamp((formatter.parse(request.getParameter("ins_exp_date_cargo") + ".00.00.02" )).getTime());					
					}
					location_id = UUID.randomUUID() + "";
					ps = connection.prepareStatement("INSERT INTO test.locations(location_id, ts, company_id, created_by, org_name, org_phone, org_email, contact_name, contact_phone, contact_email,  city, address, address2, addressLocation, location_type, state, zip, mc_number, urs_number, sales_rep, notes, isBlackListed, isBroker, isActive, credit_limit, payment_terms, org_fax, org_phone_second, web_site_url, ein_number, bond_insurance, isFactoring,notes_admin, isCorporation, dot_number, ssn_number, ins_name, ins_contact, ins_phone, ins_policy_no, ins_exp_date, ins_amount, ins_name_auto, ins_contact_auto, ins_phone_auto, ins_policy_no_auto, ins_exp_date_auto, ins_amount_auto, ins_name_cargo, ins_contact_cargo, ins_phone_cargo, ins_policy_no_cargo, ins_exp_date_cargo, ins_amount_cargo, ins_notes) VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,GeomFromText(?),?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
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
					ps.setString(15, "Carrier");
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
					ps.setBoolean(34, saveIsCorporation);	
					ps.setString(35, request.getParameter("dot_number"));
					ps.setString(36, request.getParameter("ssn_number"));
					ps.setString(37, request.getParameter("ins_name"));
					ps.setString(38, request.getParameter("ins_contact"));	
					ps.setString(39, request.getParameter("ins_phone"));
					ps.setString(40, request.getParameter("ins_policy_no"));
					ps.setTimestamp(41, date_mod);
					ps.setFloat(42, saveins_amount);
					ps.setString(43, request.getParameter("ins_name_auto"));
					ps.setString(44, request.getParameter("ins_contact_auto"));	
					ps.setString(45, request.getParameter("ins_phone_auto"));
					ps.setString(46, request.getParameter("ins_policy_no_auto"));
					ps.setTimestamp(47, date_mod_auto);
					ps.setFloat(48, saveins_amount_auto);
					ps.setString(49, request.getParameter("ins_name_cargo"));
					ps.setString(50, request.getParameter("ins_contact_cargo"));	
					ps.setString(51, request.getParameter("ins_phone_cargo"));
					ps.setString(52, request.getParameter("ins_policy_no_cargo"));
					ps.setTimestamp(53, date_mod_cargo);
					ps.setFloat(54, saveins_amount_cargo);	
					ps.setString(55, request.getParameter("ins_notes"));
					ps.executeUpdate();
					
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
					ps.setString(1, "CRN" + new_ln_count);	
					ps.setString(2, location_id);
					ps.setString(3, uuid);	
					ps.executeUpdate();	
					
					ps = connection.prepareStatement("select * from test.locations WHERE locations.COMPANY_ID = ? and location_number_tmp = ?");
					ps.setString(1, uuid);
					ps.setString(2, "CRN" + new_ln_count);
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
						ps.setString(3, "CRN" + new_ln_count);
						resultSetTmp = ps.executeQuery();
						boolean isUsed = false;
						while (resultSetTmp.next()) {
							isUsed  = true;
							plusTwo = true;
						}
						if(!isUsed){
							ps = connection.prepareStatement("Update test.locations Set location_number_float = ?, location_number = ? where location_id= ? and company_id = ?");
							ps.setFloat(1, (float)new_ln_count);
							ps.setString(2, "CRN" + new_ln_count);	
							ps.setString(3, location_id);
							ps.setString(4, uuid);	
							ps.executeUpdate();	
							location_number = "CRN" + new_ln_count;
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
					boolean saveIsCorporation = false;
					float credit_limit = 0.0f;
					float saveins_amount = 0.0f;
					float saveins_amount_auto = 0.0f;
					float saveins_amount_cargo = 0.0f;
					if(request.getParameter("isBlackListed")!=null && request.getParameter("isBlackListed").equals("Yes"))saveIsBlackList= true;
					if(request.getParameter("isBroker")!=null && request.getParameter("isBroker").equals("Yes"))saveIsBroker= true;
					if(request.getParameter("isFactoring")!=null && request.getParameter("isFactoring").equals("Yes"))saveIsFactoring= true;
					if(request.getParameter("isActive")!=null && request.getParameter("isActive").equals("Active"))saveIsActive= true;
					if(request.getParameter("isCorporation")!=null && request.getParameter("isCorporation").equals("Yes"))saveIsCorporation= true;
					if(!request.getParameter("ins_amount").equals(""))saveins_amount = Float.parseFloat(request.getParameter("ins_amount").trim());
					if(!request.getParameter("ins_amount_auto").equals(""))saveins_amount_auto = Float.parseFloat(request.getParameter("ins_amount_auto").trim());
					if(!request.getParameter("ins_amount_cargo").equals(""))saveins_amount_cargo = Float.parseFloat(request.getParameter("ins_amount_cargo").trim());
					
					java.sql.Timestamp date_mod = null;
					java.sql.Timestamp date_mod_auto = null;
					java.sql.Timestamp date_mod_cargo = null;
					if(request.getParameter("ins_exp_date")!=null &&  !request.getParameter("ins_exp_date").equals("")){
						date_mod = new java.sql.Timestamp((formatter.parse(request.getParameter("ins_exp_date") + ".00.00.02" )).getTime());					
					}
					if(request.getParameter("ins_exp_date_auto")!=null &&  !request.getParameter("ins_exp_date_auto").equals("")){
						date_mod_auto = new java.sql.Timestamp((formatter.parse(request.getParameter("ins_exp_date_auto") + ".00.00.02" )).getTime());					
					}
					if(request.getParameter("ins_exp_date_cargo")!=null &&  !request.getParameter("ins_exp_date_cargo").equals("")){
						date_mod_cargo = new java.sql.Timestamp((formatter.parse(request.getParameter("ins_exp_date_cargo") + ".00.00.02" )).getTime());					
					}
					
					ps = connection.prepareStatement("Update test.locations Set org_name = ?, org_phone = ?, address = ?, city = ?, state = ?, zip = ?, contact_name = ?, contact_phone = ?, org_email = ?, mc_number =?, urs_number = ?, sales_rep = ?, notes = ?, isBlackListed = ?, isBroker = ?, isActive= ?, credit_limit = ?, payment_terms = ?, addressLocation = GeomFromText(?), org_fax = ?, org_phone_second = ?, web_site_url = ?, ein_number =?, bond_insurance =?, isFactoring = ?, notes_admin=?, isCorporation = ?, dot_number = ?, ssn_number = ?, ins_name=?,ins_contact=?,ins_phone=?,ins_policy_no=?,ins_exp_date=?,ins_amount=?, ins_name_auto=?,ins_contact_auto=?,ins_phone_auto=?,ins_policy_no_auto=?,ins_exp_date_auto=?,ins_amount_auto=?, ins_name_cargo=?,ins_contact_cargo=?,ins_phone_cargo=?,ins_policy_no_cargo=?,ins_exp_date_cargo=?,ins_amount_cargo=?, ins_notes=? where company_id = ? and location_id = ?");
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
					ps.setBoolean(27, saveIsCorporation);	
					ps.setString(28, request.getParameter("dot_number"));	
					ps.setString(29, request.getParameter("ssn_number"));	
					ps.setString(30, request.getParameter("ins_name"));
					ps.setString(31, request.getParameter("ins_contact"));	
					ps.setString(32, request.getParameter("ins_phone"));
					ps.setString(33, request.getParameter("ins_policy_no"));
					ps.setTimestamp(34, date_mod);
					ps.setFloat(35, saveins_amount);
					ps.setString(36, request.getParameter("ins_name_auto"));
					ps.setString(37, request.getParameter("ins_contact_auto"));	
					ps.setString(38, request.getParameter("ins_phone_auto"));
					ps.setString(39, request.getParameter("ins_policy_no_auto"));
					ps.setTimestamp(40, date_mod_auto);
					ps.setFloat(41, saveins_amount_auto);
					ps.setString(42, request.getParameter("ins_name_cargo"));
					ps.setString(43, request.getParameter("ins_contact_cargo"));	
					ps.setString(44, request.getParameter("ins_phone_cargo"));
					ps.setString(45, request.getParameter("ins_policy_no_cargo"));
					ps.setTimestamp(46, date_mod_cargo);
					ps.setFloat(47, saveins_amount_cargo);	
					ps.setString(48, request.getParameter("ins_notes"));					
					ps.setString(49, uuid);
					ps.setString(50, request.getParameter("location_id"));	
					ps.executeUpdate();				
			}
			
			ps = connection.prepareStatement("select ins_notes, ins_name_cargo, ins_contact_cargo, ins_phone_cargo, ins_policy_no_cargo, ins_exp_date_cargo, ins_amount_cargo, ins_name_auto, ins_contact_auto, ins_phone_auto, ins_policy_no_auto, ins_exp_date_auto, ins_amount_auto, ins_name, ins_contact, ins_phone, ins_policy_no, ins_exp_date, ins_amount, ssn_number, dot_number, isCorporation, location_number, isFactoring, bond_insurance, ein_number, notes_admin, web_site_url, org_phone_second, org_fax, org_name, org_phone, address, city, state, zip, contact_name, contact_phone, contact_email, org_email, notes, sales_rep, mc_number, urs_number, isBlackListed, isActive, isBroker, credit_limit, payment_terms, X(addressLocation) as city_lat, Y(addressLocation) as city_lng from test.locations where company_id = ? and location_id = ?");						
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
				isCorporation = resultSetShow.getBoolean("isCorporation");
				credit_limit_display = resultSetShow.getString("credit_limit");
				web_site_url = resultSetShow.getString("web_site_url");
				payment_terms = resultSetShow.getString("payment_terms");
				ein_number  = resultSetShow.getString("ein_number");
				bond_insurance =   resultSetShow.getString("bond_insurance");
				city_lat = resultSetShow.getFloat("city_lat");
				city_lng = resultSetShow.getFloat("city_lng");
				location_number =  resultSetShow.getString("location_number");
				dot_number =  resultSetShow.getString("dot_number");
				ssn_number =  resultSetShow.getString("ssn_number");
				ins_name =  resultSetShow.getString("ins_name");
				ins_contact =  resultSetShow.getString("ins_contact");
				ins_phone =  resultSetShow.getString("ins_phone");
				ins_policy_no =  resultSetShow.getString("ins_policy_no");
				ins_amount =  resultSetShow.getFloat("ins_amount");
				ins_name_auto =  resultSetShow.getString("ins_name_auto");
				ins_contact_auto =  resultSetShow.getString("ins_contact_auto");
				ins_phone_auto =  resultSetShow.getString("ins_phone_auto");
				ins_policy_no_auto =  resultSetShow.getString("ins_policy_no_auto");
				ins_amount_auto =  resultSetShow.getFloat("ins_amount_auto");
				ins_name_cargo =  resultSetShow.getString("ins_name_cargo");
				ins_contact_cargo =  resultSetShow.getString("ins_contact_cargo");
				ins_phone_cargo =  resultSetShow.getString("ins_phone_cargo");
				ins_policy_no_cargo =  resultSetShow.getString("ins_policy_no_cargo");
				ins_amount_cargo =  resultSetShow.getFloat("ins_amount_cargo");
				if(resultSetShow.getTimestamp("ins_exp_date")!=null){
					ins_exp_date = new SimpleDateFormat("MM-dd-yyyy").format(resultSetShow.getTimestamp("ins_exp_date"));
				}					
				if(resultSetShow.getTimestamp("ins_exp_date_auto")!=null){
					ins_exp_date_auto = new SimpleDateFormat("MM-dd-yyyy").format(resultSetShow.getTimestamp("ins_exp_date_auto"));
				}					
				if(resultSetShow.getTimestamp("ins_exp_date_cargo")!=null){
					ins_exp_date_cargo = new SimpleDateFormat("MM-dd-yyyy").format(resultSetShow.getTimestamp("ins_exp_date_cargo"));
				}
				ins_notes = resultSetShow.getString("ins_notes");
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
	<form  name="searchForm" id="searchForm" action="dispatch_edit_carrier.jsp" method="post">	
	<div class="panel panel-primary" >
	<div class="panel-heading">
	<div class="input-group" style="padding:5px;">
    <input type="hidden" name="pickCity_lat" id="pickCity_lat" value="<%=city_lat%>" />
    <input type="hidden" name="pickCity_lng" id="pickCity_lng" value="<%=city_lng%>" />
    <input type="hidden" name="pickCity" id="pickCity" value="">
    <input type="hidden" name="pickState" id="pickState" value="">
	<a href="dispatch_carriers.jsp?ShowSearchCarriers=true" style="color:white"><span class="glyphicon glyphicon-backward" aria-hidden="true" style="color:white" ></span>&nbsp;BACK</a>&nbsp;&nbsp;
	<button class="btn btn-primary"  role="button"  name="btn_shipper_save" id="btn_shipper_save" type="submit" ><span class="glyphicon glyphicon-save" aria-hidden="true"></span>&nbsp;SAVE</button>
	&nbsp;&nbsp;

	</div>
	</div>
	<div class="panel-body">
	<ul class="nav nav-tabs">

	<%if(request.getParameter("location_id")!=null || (request.getParameter("cmd")!=null && request.getParameter("cmd").equals("addLocation"))){%>
	<li class="active"><a data-toggle="tab" href="#home" onclick="showCarrierInfo()" >Edit Carrier - <%=location_number%></a></li>
	<%}else{%>
	<li class="active"><a data-toggle="tab" href="#home" onclick="showCarrierInfo()" >Add New Carrier</a></li>
	<%}%>	
	<li ><a data-toggle="tab" href="#home" onclick="showInsuranceInfo()" >Insurance Info</a></li>
	<li ><a data-toggle="tab" href="#home" onclick="showEquipmentInfo()" >Equipment List</a></li>
	<li ><a data-toggle="tab" href="#home" onclick="showEquipmentSumInfo()" >Equipment Summary</a></li>	
	<li ><a data-toggle="tab" href="#home" onclick="showNotesInfo()" >Notes</a></li>
	</ul>


	<div id="carrier_info" name="carrier_info" style="display:inline;" >
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
	<input type="text" class="form-control" name="location_name" id="location_name"  placeholder="James Franco Trucking, Inc." value="<%=location_name%>" />
	</div>
	</div>

	<div class="col-md-2">
	<div class="form-group">
	<label>Main Phone</label>
	<input type="text" class="form-control"  name="org_phone" id="org_phone"  placeholder="773-555-1212" value="<%=NullCheck.check(location_phone)%>"/>
	</div>
	</div>

	<div class="col-md-3">
	<div class="form-group">
	<label>Address</label>
	<input type="text" class="form-control"  placeholder="5415 N. Sheridan" name="address" id="address" value="<%=NullCheck.check(location_address)%>"/>
	</div>
	</div>

	<div class="col-md-2">
	<div class="form-group">
	<label>City</label>
	<input type="text" class="form-control"  name="city" id="city" placeholder="Chicago"  value="<%=NullCheck.check(location_city)%>"/>
	</div>
	</div>


	<div class="col-md-1">
	<div class="form-group">
	<label>Zip Code</label>
	<input type="text" class="form-control"  placeholder="60695"  name="zip" id="zip"  value="<%=NullCheck.check(location_zip)%>"/>
	</div>
	</div>

	<div class="col-md-1">
	<div class="form-group">
	<label>State</label>
	<input type="text" class="form-control"  name="state" id="state"  placeholder="IL" value="<%=NullCheck.check(location_state)%>"/>
	</div>
	</div>

	</div>





	<div class="row">
			<div class="col-md-3">
			<div class="form-group">
			<label>Primary Contact </label>
			<input type="text" class="form-control" name="contact_name" id="contact_name"  placeholder="John Kelly" value="<%=NullCheck.check(location_contact_name)%>" />
			</div>
			</div>

			<div class="col-md-2">
			<div class="form-group">
			<label>Contact Phone</label>
			<input type="text" class="form-control"  name="contact_phone" id="contact_phone"  placeholder="773-555-1212" value="<%=location_contact_phone%>" />
			</div>
			</div>

			<div class="col-md-3">
			<div class="form-group">
			<label>e-mail</label>
			<input type="text" class="form-control"  placeholder="john@gmail.com" name="org_email" id="org_email" value="<%=location_email%>" />
			</div>
			</div>
			<div class="col-md-2">
			<div class="form-group">
			<label>Fax</label>
			<input type="text" class="form-control"  placeholder="" name="org_fax" id="org_fax" value="<%=NullCheck.check(location_fax)%>" />
			</div>
			</div>
			<div class="col-md-2">
			<div class="form-group">
			<label>Secondary Phone</label>
			<input type="text" class="form-control"  placeholder="" name="org_phone_second" id="org_phone_second" value="<%=NullCheck.check(location_phone_second)%>" />
			</div>
			</div>

	</div>


		<div class="row">
			<div class="col-md-2">
			<div class="form-group">
			<label>M.C. #</label>
			<input type="text" class="form-control" name="location_mc" id="location_mc"  placeholder="MC23123232"  onblur="updateSaferSys()" value="<%=NullCheck.check(location_mc)%>" />
			</div>
			</div>

			<div class="col-md-2">
			<div class="form-group">
			<label>URS #</label>
			<input type="text" class="form-control"  name="location_urs" id="location_urs"  placeholder="229991223" value="<%=NullCheck.check(location_urs)%>" />
			</div>
			</div>

			<div class="col-md-2">
			<div class="form-group">
			<label>Blacklisted</label>

					<div class="checkbox">
						<label>
						<input type="checkbox" name="isBlackListed" id="isBlackListed" value="Yes"  <%if(isBlackListed){%>checked<%}%> >
						This carrier is blacklisted
						</label>
					</div>

			</div>
			</div>



			<div class="col-md-2">
			<div class="form-group">
			<label>Broker</label>

			<div class="checkbox">
			<label>
			<input type="checkbox" name="isBroker" id="isBroker" value="Yes"  <%if(isBroker){%>checked<%}%>>
			This is a broker
			</label>
			</div>

			</div>
			</div>
			<div class="col-md-2">
			<div class="form-group">
			<label>Factoring</label>

			<div class="checkbox">
			<label>
			<input type="checkbox" name="isFactoring" id="isFactoring" value="Yes"  <%if(isFactoring){%>checked<%}%>>
			Carrier is using Factoring
			</label>
			</div>

			</div>
			</div>


			<div class="col-md-2">
			<div class="form-group">
			<label>Account Status</label><br/>

					<label class="radio-inline" style="color:#777; padding: 7px;">
					<input type="radio" name="isActive" id="isActive" value="Active" <%if(isActive){%>checked<%}%> > Active
					</label>
					<label class="radio-inline" style="color:#777; padding: 7px;">
					<input type="radio" name="isActive" id="isActive" value="Inactive" <%if(!isActive){%>checked<%}%> > Inactive
					</label>

			</div>
			</div>

		</div>



	<div class="row">
			<div class="col-md-2">
			<div class="form-group">
			<label>DOT Number</label>
			<input type="text" class="form-control" name="dot_number" id="dot_number"  placeholder="DOT Number" value="<%=NullCheck.check(dot_number)%>" />
			</div>
			</div>

			<div class="col-md-4">
			<div class="form-group">
			<label>Payment Terms</label>
			<input type="text" class="form-control"  name="payment_terms" id="payment_terms"  placeholder="" value="<%=NullCheck.check(payment_terms)%>"/>
			</div>
			</div>
			<div class="col-md-2">
			<div class="form-group">
			<label>Corporation</label>

			<div class="checkbox">
			<label>
			<input type="checkbox" name="isCorporation" id="isCorporation" value="Yes"  <%if(isCorporation){%>checked<%}%>>
			Carrier is a Corporation
			</label>
			</div>

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
			<label>SSN</label>
			<input type="text" class="form-control" name="ssn_number" id="ssn_number"  placeholder="549-83-1942" value="<%=NullCheck.check(ssn_number)%>" />
			</div>
			</div>

	</div>
	<div class="row">
			<div class="col-md-8">
			<div class="form-group">
			<label>Web Site Address</label>
			<input type="text" class="form-control" name="web_site_url" id="web_site_url"  placeholder="http://www.CarrierWebSite.com" value="<%=NullCheck.check(web_site_url)%>" />
			</div>
			</div>
			<div class="col-md-3">
			<div class="form-group">
			<label>Carrier ID</label>
			<input type="text" class="form-control" style="color:green;" name="location_number" id="location_number"  placeholder="CRN555-fe" readonly value="<%=NullCheck.check(location_number)%>" />
			</div>
			</div>
	</div>






		</div>

 	</div><!-- end of form wrapper -->
	</div>

	<div id="carrier_notes" name="carrier_notes" style="display:none;" >
	<div class="form-wrapper">

	<div class="input-group" style="padding:5px;">
	<div class="row">

			<div class="col-md-12">
			<div class="form-group">
			<label>Notes</label>
			<textarea class="form-control" width="100%" rows="4" name="note" id="note"  placeholder="notes....." ><%=NullCheck.check(location_note)%></textarea>
			</div>
			</div>

	</div>
	<div class="row">

			<div class="col-md-12">
			<div class="form-group">
			<label>Admin Notes</label>
			<textarea class="form-control" style="width:100%;" rows="4" name="note_admin" id="note_admin"  placeholder="Admin notes....." ><%=NullCheck.check(location_note_admin)%></textarea>
			</div>
			</div>

	</div>
	
	</div>
 	</div><!-- end of form wrapper -->
	</div>

	<div id="carrier_insurance" name="carrier_insurance" style="display:none;" >
	<div class="form-wrapper">

	<div class="input-group" style="padding:5px;">
	<div class="row">
			<div class="col-md-1">
			<div class="form-group">
			<label>MC</label>
			<input type="text" class="form-control" style="color:green;" name="safer_mc" id="safer_mc"  placeholder="714900" value="" />
			</div>
			</div>
			<div class="col-md-3">
			<div class="form-group">
			<label>Address</label>
			<input type="text" class="form-control" style="color:green;" name="safer_address1" id="safer_address1"  placeholder="" value="" />
			</div>
			</div>
			<div class="col-md-2">
			<div class="form-group">
			<label>City</label>
			<input type="text" class="form-control" style="color:green;" name="safer_city" id="safer_city"  placeholder="" value="" />
			</div>
			</div>
			<div class="col-md-2">
			<div class="form-group">
			<label>State</label>
			<input type="text" class="form-control" style="color:green;" name="safer_state" id="safer_state"  placeholder="" value="" />
			</div>
			</div>
			<div class="col-md-2">
			<div class="form-group">
			<label>Zip</label>
			<input type="text" class="form-control" style="color:green;" name="safer_zio" id="safer_zip"  placeholder="" value="" />
			</div>
			</div>
	</div>
	<div class="row">
			<div class="col-md-3">
			<div class="form-group">
			<label>Phone</label>
			<input type="text" class="form-control" style="color:green;" name="safer_phone" id="safer_phone"  placeholder="" value="" />
			</div>
			</div>
			<div class="col-md-3">
			<div class="form-group">
			<label>Fax</label>
			<input type="text" class="form-control" style="color:green;" name="safer_fax" id="safer_fax"  placeholder="" value="" />
			</div>
			</div>
			<div class="col-md-2">
			<div class="form-group">
			<label>Insurance On File</label>
			<input type="text" class="form-control" style="color:green;" name="safer_onfile" id="safer_onfile"  placeholder="" value="" />
			</div>
			</div>
			<div class="col-md-2">
			<div class="form-group">
			<label>Insurance Needed</label>
			<input type="text" class="form-control" style="color:green;" name="safer_needed" id="safer_needed"  placeholder="" value="" />
			</div>
			</div>
	</div>
	<div class="row">
			<div class="col-md-3">
			<div class="form-group">
			<label>Liability Insurance Company</label>
			<input type="text" class="form-control" style="color:green;" name="ins_name" id="ins_name"  placeholder="" value="<%=ins_name%>" />
			</div>
			</div>
			<div class="col-md-2">
			<div class="form-group">
			<label>Contact Name</label>
			<input type="text" class="form-control" style="color:green;" name="ins_contact" id="ins_contact"  placeholder="" value="<%=ins_contact%>" />
			</div>
			</div>
			<div class="col-md-2">
			<div class="form-group">
			<label>Phone</label>
			<input type="text" class="form-control" style="color:green;" name="ins_phone" id="ins_phone"  placeholder="" value="<%=ins_phone%>" />
			</div>
			</div>
			<div class="col-md-2">
			<div class="form-group">
			<label>Policy&nbsp;NO</label>
			<input type="text" class="form-control" style="color:green;" name="ins_policy_no" id="ins_policy_no"  placeholder="" value="<%=ins_policy_no%>" />
			</div>
			</div>

		<div class="col-md-2">
		<div class="form-group">
		<label>Exp Date</label>
		<div class='input-group date' id='datetimepicker1'>
		<span class="input-group-addon">
		<span class="glyphicon glyphicon-calendar"></span>
		</span>
		<input type='text' value="<%=ins_exp_date%>" style="font-size: 14px; padding-left: 5px; padding-right: 2px;" class="form-control" id="ins_exp_date" name="ins_exp_date"  placeholder="Date">
		</div>
		</div>
		</div>			
			<div class="col-md-2">
			<div class="form-group">
			<label>Liability&nbsp;($)</label>
			<input type="text" class="form-control" style="color:green;" name="ins_amount" id="ins_amount"  placeholder="" value="<%=ins_amount%>" />
			</div>
			</div>
	</div>
	<div class="row">
			<div class="col-md-3">
			<div class="form-group">
			<label>Auto Insurance Company Name</label>
			<input type="text" class="form-control" style="color:green;" name="ins_name_auto" id="ins_name_auto"  placeholder="" value="<%=ins_name_auto%>" />
			</div>
			</div>
			<div class="col-md-2">
			<div class="form-group">
			<label>Contact Name</label>
			<input type="text" class="form-control" style="color:green;" name="ins_contact_auto" id="ins_contact_auto"  placeholder="" value="<%=ins_contact_auto%>" />
			</div>
			</div>
			<div class="col-md-2">
			<div class="form-group">
			<label>Phone</label>
			<input type="text" class="form-control" style="color:green;" name="ins_phone_auto" id="ins_phone_auto"  placeholder="" value="<%=ins_phone_auto%>" />
			</div>
			</div>
			<div class="col-md-2">
			<div class="form-group">
			<label>Policy&nbsp;NO</label>
			<input type="text" class="form-control" style="color:green;" name="ins_policy_no_auto" id="ins_policy_no_auto"  placeholder="" value="<%=ins_policy_no_auto%>" />
			</div>
			</div>

		<div class="col-md-2">
		<div class="form-group">
		<label>Exp Date</label>
		<div class='input-group date' id='datetimepicker2'>
		<span class="input-group-addon">
		<span class="glyphicon glyphicon-calendar"></span>
		</span>
		<input type='text' value="<%=ins_exp_date_auto%>" style="font-size: 14px; padding-left: 5px; padding-right: 2px;" class="form-control" id="ins_exp_date_auto" name="ins_exp_date_auto"  placeholder="Date">
		</div>
		</div>
		</div>			
			<div class="col-md-2">
			<div class="form-group">
			<label>Liability&nbsp;($)</label>
			<input type="text" class="form-control" style="color:green;" name="ins_amount_auto" id="ins_amount_auto"  placeholder="" value="<%=ins_amount_auto%>" />
			</div>
			</div>
	</div>

	<div class="row">
			<div class="col-md-3">
			<div class="form-group">
			<label>Cargo Insurance Company Name</label>
			<input type="text" class="form-control" style="color:green;" name="ins_name_cargo" id="ins_name_cargo"  placeholder="" value="<%=ins_name_cargo%>" />
			</div>
			</div>
			<div class="col-md-2">
			<div class="form-group">
			<label>Contact Name</label>
			<input type="text" class="form-control" style="color:green;" name="ins_contact_cargo" id="ins_contact_cargo"  placeholder="" value="<%=ins_contact_cargo%>" />
			</div>
			</div>
			<div class="col-md-2">
			<div class="form-group">
			<label>Phone</label>
			<input type="text" class="form-control" style="color:green;" name="ins_phone_cargo" id="ins_phone_cargo"  placeholder="" value="<%=ins_phone_cargo%>" />
			</div>
			</div>
			<div class="col-md-2">
			<div class="form-group">
			<label>Policy&nbsp;NO</label>
			<input type="text" class="form-control" style="color:green;" name="ins_policy_no_cargo" id="ins_policy_no_cargo"  placeholder="" value="<%=ins_policy_no_cargo%>" />
			</div>
			</div>
		<div class="col-md-2">
		<div class="form-group">
		<label>Exp Date</label>
		<div class='input-group date' id='datetimepicker3'>
		<span class="input-group-addon">
		<span class="glyphicon glyphicon-calendar"></span>
		</span>
		<input type='text' value="<%=ins_exp_date_cargo%>" style="font-size: 14px; padding-left: 5px; padding-right: 2px;" class="form-control" id="ins_exp_date_cargo" name="ins_exp_date_cargo"  placeholder="Date">
		</div>
		</div>
		</div>
			<div class="col-md-2">
			<div class="form-group">
			<label>Liability&nbsp;($)</label>
			<input type="text" class="form-control" style="color:green;" name="ins_amount_cargo" id="ins_amount_cargo"  placeholder="" value="<%=ins_amount_cargo%>" />
			</div>
			</div>
	</div>	
	<div class="row">
			<div class="col-md-12">
			<div class="form-group">
			<label>Notes</label>
			<input type="text" class="form-control" style="color:green;" name="ins_notes" id="ins_notes"  placeholder="" value="<%=ins_notes%>" />
			</div>
			</div>
	</div>
		
	</div>
 	</div><!-- end of form wrapper -->
	</div>
	
	<div id="carrier_equipment" name="carrier_equipment" style="display:none;" >
	<div class="form-wrapper">

	<div class="input-group" style="padding:5px;">
		<div id="carrier_equipment_list" name="carrier_equipment_list" >
		</div>		
	</div>
 	</div><!-- end of form wrapper -->
	</div>
	<div id="carrier_equipment_sum" name="carrier_equipment_sum" style="display:none;" >
	<div class="form-wrapper">

	<div class="input-group" style="padding:5px;">
		<div id="carrier_equipment_list_sum" name="carrier_equipment_list_sum" >
		</div>		
	</div>
 	</div><!-- end of form wrapper -->
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
	        	