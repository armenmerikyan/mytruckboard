<%@ page import="com.big.util.*,java.text.*,java.util.*,java.io.*,javax.xml.parsers.*,org.w3c.dom.*,java.sql.*,java.text.DateFormat,java.net.URL" %>			
<%@ page import="javax.mail.*" %>
<%@ page import="javax.mail.internet.*" %>
<%@ page import="java.util.*" %>

<%@ page import="com.twilio.sdk.TwilioRestClient" %>
<%@ page import="com.twilio.sdk.resource.factory.SmsFactory" %>
<%@ page import="com.twilio.sdk.resource.instance.Sms" %>
<link href="../css/styleTrucking.css" rel="stylesheet" type="text/css" />
<html xmlns="http://www.w3.org/1999/xhtml" xmlns:v="urn:schemas-microsoft-com:vml">
  <head>

	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<meta name="description" content="">
	<meta name="author" content="">
	<title>Company Profile Edit - MYTRUCKBOARD 2.0 - dead simple freight dispatch</title>
	<link rel="shortcut icon" href="http://www.mytruckboard.com/trucking-new/images/mtb-favicon.ico">
	<meta http-equiv="content-type" content="text/html; charset=utf-8" />
	<meta name="description" content="The complete freight management software. Win shipping deals and manage your fleet of trucks effortlessly." />
	<meta name="keywords" content="freight, transportation, dispatch management, load optimization, truck broker, transportation management, truck, truck fleet management, shippers, truck brokers, shipping made easy, trucking industry, trucking software, trucking, dispatch for freight brokder, carrier management, load board, load, board" />


	<meta http-equiv="content-type" content="text/html; charset=utf-8"/>
	<script type="text/javascript" src="/trucking/ckeditor.js"></script>
	<script src="/trucking/sample.js" type="text/javascript"></script>
	<script language="javascript" type="text/javascript" src="/trucking/datetimepicker.js">
	<link href="/trucking/css/sample.css" rel="stylesheet" type="text/css" />
<%
     final String ACCOUNT_SID = "ACbc6b5f29c1627c6aa7e51f5ad340fa2d";
     final String AUTH_TOKEN = "767154b209800bd1be13e38d8a01fc1b";
			
    String FROM = "info@mytruckboard.com";   // Replace with your "From" address. This address must be verified.
    String SMTP_USERNAME = "AKIAINFCRKGVZNSB7DHQ";  // Replace with your SMTP username.
    String SMTP_PASSWORD = "Ar/mcRQJkM9i7Vl45r+CzSrgx/QGb+vuJIuIDfJp/mj8";  // Replace with your SMTP password.
    String HOST = "email-smtp.us-east-1.amazonaws.com";    
    int PORT = 25;
			
				if(request.getParameter("pickCity")!=null)session.setAttribute("pickCity", request.getParameter("pickCity"));
				if(request.getParameter("pickCity_lat")!=null)session.setAttribute("pickCity_lat", request.getParameter("pickCity_lat"));
				if(request.getParameter("pickCity_lng")!=null)session.setAttribute("pickCity_lng", request.getParameter("pickCity_lng"));
				if(request.getParameter("pickState")!=null)session.setAttribute("pickState", request.getParameter("pickState"));
				if(request.getParameter("destCity")!=null)session.setAttribute("destCity", request.getParameter("destCity"));
				if(request.getParameter("destCity_lat")!=null)session.setAttribute("destCity_lat", request.getParameter("destCity_lat"));
				if(request.getParameter("destCity_lng")!=null)session.setAttribute("destCity_lng", request.getParameter("destCity_lng"));
				if(request.getParameter("destState")!=null)session.setAttribute("destState", request.getParameter("destState"));
				if(request.getParameter("distance")!=null)session.setAttribute("distance", request.getParameter("distance"));
				if(request.getParameter("duration")!=null)session.setAttribute("duration", request.getParameter("duration"));
				if(request.getParameter("searchKeyCity")!=null)session.setAttribute("searchKeyCity", request.getParameter("searchKeyCity"));
				if(request.getParameter("searchKeyState")!=null)session.setAttribute("searchKeyState", request.getParameter("searchKeyState"));
				if(request.getParameter("searchKeyCity_lat")!=null)session.setAttribute("searchKeyCity_lat", request.getParameter("searchKeyCity_lat"));
				if(request.getParameter("searchKeyCity_lng")!=null)session.setAttribute("searchKeyCity_lng", request.getParameter("searchKeyCity_lng"));
				if(request.getParameter("pac-input2")!=null)session.setAttribute("pac-input2", request.getParameter("pac-input2"));
				if(request.getParameter("pac-input")!=null)session.setAttribute("pac-input", request.getParameter("pac-input"));
				
			%>	
	<style id="styles" type="text/css">

		#editorsForm
		{
			overflow: auto;
		}

	</style>
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
<script>
function calNumbers() {
    var id = setInterval(function() {
    	  calNumbersTimer();
//          clearInterval(id);
  }, 420)
}
function calNumbersTimer()
{
	var rate = 0;
	var qpr = 0;
	var miles = 0;
	var per_mile = 0; 
	var truckmpg = 0;
	var avg_diesel = 0;
	var driver_pay = 0; 
	var diesel_no = 0; 
	var broker_pay = 0; 
	var carrier_pay = 0; 
	var profit = 0;
	var miscel_pay = 0;
	
	rate = Number(document.getElementsByName("rate")[0].value);
	qpr = Number(document.getElementsByName("qp")[0].value);
	miles = Number(document.getElementsByName("miles")[0].value);
	if(miles == 0)miles = 1;
	per_mile = Number(document.getElementsByName("per_mile")[0].value);
	truckmpg = Number(document.getElementsByName("truckmpg")[0].value);
	if(truckmpg == 0)truckmpg =1;
	avg_diesel = Number(document.getElementsByName("avg_diesel")[0].value);
	driver_pay = Number(document.getElementsByName("driver_pay")[0].value);
	broker_pay = Number(document.getElementsByName("rate")[0].value);
	carrier_pay = Number(document.getElementsByName("carrier_pay")[0].value);
	miscel_pay = Number(document.getElementsByName("miscel_pay")[0].value);
	
//	profit = Math.round((qpr - (((miles / truckmpg) * avg_diesel) + (driver_pay * miles))) * 100)/100 ;
	profit = Math.round((qpr - carrier_pay) * 100)/100 ;
//	alert(profit);
//	document.getElementsByName("carrier_pay")[0].value = Math.round(((miles / truckmpg) * avg_diesel) + (driver_pay * miles));
	document.getElementsByName("qp")[0].value = Math.round((rate * .97) * 1) / 1;
	document.getElementsByName("per_mile")[0].value = Math.round((rate / miles) * 100) / 100;
//	document.getElementsByName("approx_profit")[0].value = Math.round((rate * .97) * 1) / 1 - Math.round(((miles / truckmpg) * avg_diesel) + (driver_pay * miles));
	document.getElementsByName("approx_profit")[0].value = profit;
	document.getElementsByName("diesel_no")[0].value = Math.round(miles / truckmpg);
	document.getElementsByName("Diesel_dor")[0].value = Math.round(((miles / truckmpg)* avg_diesel) * 100)/100;
	document.getElementsByName("driver_cost")[0].value = Math.round((driver_pay * miles) * 100)/100;
	document.getElementsByName("profit")[0].value = Math.round((profit - miscel_pay) * 100)/100;
	document.getElementsByName("percent_profit")[0].value = Math.round(((profit - miscel_pay)/broker_pay)*10000)/100;
	
	
	
	
	//alert(per_mile);
}	
</script>
			</head>
			<body bgcolor="#FFFFFF" text="#000000" link="#0000FF" vlink="#800080" alink="#FF0000" onload="loadLastSaved();calNumbers();">
				
<%
String uuid = (String)session.getAttribute("uuid");
boolean needStatusUpdate = false;
if(uuid !=null){
%>		
	<% String mpgLast = "";%>
	<% String drvPayLast = "";
		String quoteKey = "";
	
				float driver_pay = 0.0f;
				float miscel_pay = 0.0f;
				String goingRate = "";
				String truckerPhone = "";
	%>
	<%if(request.getParameter("cmd")!=null && request.getParameter("cmd").equals("saveComment")){%>
				<%
		 try{
			Class.forName("com.mysql.jdbc.Driver");
			String url = "jdbc:mysql://localhost/test?zeroDateTimeBehavior=convertToNull";		
		 
//			Class.forName("com.sap.dbtech.jdbc.DriverSapDB");
//			String url = "jdbc:sapdb://localhost/BIGDB?sqlmode=ORACLE";
			Connection connection = DriverManager.getConnection(url,"<USERNAME>", "<PASSWORD>");			
			
			
			
			if(request.getParameter("SaveCalculation")!=null){
				int rate = 0;
				int miles = 0; 
				float truckmpg = 0.0f;
				float avg_diesel = 0.0f;
				float length = 0.0f;
				float height = 0.0f;
				int weight = 0; 
				float width = 0.0f;
				float density = 0.0f;
				int f_class = 0; 
				
				DateFormat formatter = new SimpleDateFormat("MM-dd-yyyy.HH.mm.ss");		
				java.sql.Date drop_date_sql = null;
				java.sql.Date pickup_date_sql = null;
				if(request.getParameter("drop_date")!=null && !request.getParameter("drop_date").equals(""))drop_date_sql = new java.sql.Date(((java.util.Date)formatter.parse(request.getParameter("drop_date") + ".00.00.00" )).getTime());
				if(request.getParameter("pickup_date")!=null && !request.getParameter("drop_date").equals(""))pickup_date_sql = new java.sql.Date(((java.util.Date)formatter.parse(request.getParameter("pickup_date") + ".00.00.00" )).getTime());
				
				if(!request.getParameter("rate").equals(""))rate = Integer.parseInt(request.getParameter("rate").trim());
				if(!request.getParameter("miles").equals("") && request.getParameter("miles").contains(".")){
					miles = Integer.parseInt(request.getParameter("miles").substring(0, request.getParameter("miles").indexOf(".")));
				}else if(!request.getParameter("miles").equals("")){
					miles = Integer.parseInt(request.getParameter("miles"));
				}
				if(!request.getParameter("truckmpg").equals(""))truckmpg = Float.parseFloat(request.getParameter("truckmpg").trim());
				if(!request.getParameter("avg_diesel").equals(""))avg_diesel = Float.parseFloat(request.getParameter("avg_diesel").trim());
				if(!request.getParameter("driver_pay").equals(""))driver_pay = Float.parseFloat(request.getParameter("driver_pay").trim());
				if(!request.getParameter("miscel_pay").equals(""))miscel_pay = Float.parseFloat(request.getParameter("miscel_pay").trim());
				if(!request.getParameter("freight_length").equals(""))length = Float.parseFloat(request.getParameter("freight_length").trim());
				if(!request.getParameter("freight_width").equals(""))width = Float.parseFloat(request.getParameter("freight_width").trim());
				if(!request.getParameter("freight_height").equals(""))height = Float.parseFloat(request.getParameter("freight_height").trim());
				if(!request.getParameter("freight_weight").equals(""))weight = Integer.parseInt(request.getParameter("freight_weight").trim());
				if(!request.getParameter("freight_density").equals(""))density = Float.parseFloat(request.getParameter("freight_density").trim());
				if(!request.getParameter("freight_class").equals(""))f_class = Integer.parseInt(request.getParameter("freight_class").trim());
				String latLong = "POINT(1 2)";
				Float goingRateFloat = 0.0f;
				if(request.getParameter("miscel_pay")!=null && !request.getParameter("miscel_pay").equals("")){goingRateFloat = ((Float.parseFloat(request.getParameter("miles").trim()) / Float.parseFloat(request.getParameter("truckmpg").trim())) * Float.parseFloat(request.getParameter("avg_diesel").trim())) + (Float.parseFloat(request.getParameter("driver_pay").trim()) * Float.parseFloat(request.getParameter("miles").trim())) + Float.parseFloat(request.getParameter("miscel_pay").trim());}
				else {goingRateFloat = ((Float.parseFloat(request.getParameter("miles").trim()) / Float.parseFloat(request.getParameter("truckmpg").trim())) * Float.parseFloat(request.getParameter("avg_diesel").trim())) + Float.parseFloat(request.getParameter("driver_pay").trim()) * Float.parseFloat(request.getParameter("miles").trim());}

				goingRate = "" + Math.round(goingRateFloat);
				quoteKey = UUID.randomUUID() + "";
				PreparedStatement ps = connection.prepareStatement("INSERT INTO test.trucking_quote(quote_id, ts, user_id, company_id, rate, miles, truck_mpg, avg_diesel, driver_pay_mpg, miscel_pay,equipment_id,status, pickCity, pickState, pickCityLocation, destCity, destState, destCityLocation, length, width, height, weight, density, class, pickup_date, drop_date, load_type) VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,GeomFromText(?),?,?,GeomFromText(?),?,?,?,?,?,?,?,?,?)");
				ps.setString(1, quoteKey);			
				ps.setTimestamp(2, new java.sql.Timestamp((new java.util.Date()).getTime()));			
				ps.setString(3, (String)session.getAttribute("login_id"));	
				ps.setString(4, uuid);
				ps.setInt(5, rate);
				ps.setInt(6, miles);
				ps.setFloat(7, truckmpg);
				ps.setFloat(8, avg_diesel);
				ps.setFloat(9, driver_pay);
				ps.setFloat(10, miscel_pay);
				ps.setString(11, request.getParameter("id"));
				ps.setString(12, request.getParameter("SaveCalculation"));
				ps.setString(13, request.getParameter("pickCity"));
				ps.setString(14, request.getParameter("pickState"));
				if(request.getParameter("pickCity_lat")!=null && request.getParameter("pickCity_lng")!=null){
					latLong = "POINT(" + request.getParameter("pickCity_lat") + " " + request.getParameter("pickCity_lng") + ")";
				}
				ps.setString(15, latLong);				
				ps.setString(16, request.getParameter("destCity"));
				ps.setString(17, request.getParameter("destState"));
				latLong = "POINT(1 2)";
				if(request.getParameter("destCity_lat")!=null && request.getParameter("destCity_lng")!=null){
					latLong = "POINT(" + request.getParameter("destCity_lat") + " " + request.getParameter("destCity_lng") + ")";
				}
					
				ps.setString(18, latLong);				
				ps.setFloat(19, length);
				ps.setFloat(20, width);
				ps.setFloat(21, height);
				ps.setInt(22, weight);
				ps.setFloat(23, density);
				ps.setInt(24, f_class);
				ps.setDate(25, pickup_date_sql);			
				ps.setDate(26, drop_date_sql);			
				ps.setString(27, request.getParameter("trailer"));
				ps.executeUpdate();					
			}			
			

			connection.close();		
		 }catch (Exception ex){	         
		     %><%="Error Posting " + ex%><%  
		     System.out.println(""+ ex + "Rate : " + request.getParameter("per_mile"));
		 }				
				%>
				
	<%}%>






					<table border=0 cellpadding="3" width="100%">
				<FORM action="add_rate.jsp" method="post" onsubmit="calNumbersTimer()">
<%
        
            	String inputAll = "";
        try {
            // get URL content

            	URL dPrice = new URL("http://www.eia.gov/petroleum/gasdiesel/includes/gas_diesel_rss.xml");
        	BufferedReader in = new BufferedReader(new InputStreamReader(dPrice.openStream()));
            	String inputLine = "";
            	while ((inputLine = in.readLine()) != null) {
                    inputAll = inputAll + inputLine;
            	}
            	in.close();

            %><%inputAll = inputAll.substring(inputAll.indexOf("On-Highway Diesel Fuel Retail Price"),inputAll.length());%><%
            %><%inputAll = inputAll.substring(inputAll.indexOf(".")-1,inputAll.indexOf(".")+3);%><%

        } catch (Exception e) {
            %><%=e%><%
        }
%>				
						<input type="hidden" name="cmd" value="saveComment">		
						<input type="hidden" name="id" value="<%=request.getParameter("id")%>">	
						<%
						 try{
						 	
							DateFormat formatter = new SimpleDateFormat("MM-dd-yyyy");

							Class.forName("com.mysql.jdbc.Driver");
							String url = "jdbc:mysql://localhost/test?zeroDateTimeBehavior=convertToNull";		
							
//							Class.forName("com.sap.dbtech.jdbc.DriverSapDB");
//							String url = "jdbc:sapdb://localhost/BIGDB?sqlmode=ORACLE";
							Connection connection = DriverManager.getConnection(url,"<USERNAME>", "<PASSWORD>");

							PreparedStatement ps = connection.prepareStatement("select * from test.TRUCKING_EQUIPMENT where ID = ? ");
							ps.setString(1, request.getParameter("id"));
							ResultSet resultSet = ps.executeQuery();
							while (resultSet.next()) {

						if(resultSet.getTimestamp("DATE_COVERED")!=null){

						Calendar cal = Calendar.getInstance();
						java.util.Date expireDate = cal.getTime();
						java.util.Date jDate = new java.util.Date(resultSet.getTimestamp("DATE_COVERED").getTime());
						Calendar jcal=Calendar.getInstance();
						jcal.setTime(jDate);
						jcal.add(Calendar.MINUTE, 60);
						%>
						 
							<%if(cal.before(jcal)) {%>
							<input type="hidden" name="coveredBY" value="<%=NullCheck.check(resultSet.getString("COVERED_BY"))%>">						
							<%}else{%>
							<input type="hidden" name="coveredBY" value="">						
							<%}%>
						<%
						}else{
						%>
						<input type="hidden" name="coveredBY" value="<%=NullCheck.check(resultSet.getString("COVERED_BY"))%>">						
						<%
						}
						%>
							<TR>
							<td colspan=8 align=center>
							<a href="standard-truckboard.jsp" >Truck Board</a>
								&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
								&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
								|
								&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
								&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							<a href="truckboard.jsp" >Truck Board 2.0 (new)</a>
							<%if(session.getAttribute("isAdmin").equals("true")){%>	
								&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
								&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
								|
								&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
								&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
								<a href="edit_truck.jsp?id=<%=request.getParameter("id")%>">Edit Truck</a>
							<%}%>
								&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
								&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
								|
								&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
								&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							<a href="new_features.jsp">What's New</a>
							</TD>	
							</TR>
							
							<table border=1 cellpadding="4" style="font-size: 13px; line-height:13px; width: 100%;">
								<TR style="font-size: 10px; line-height:11px;">
								<TD nowrap >Rate</TD>
								<TD nowrap >Status</TD>
								<TD nowrap style="font-size: 14px; line-height:11px;" >Pick-Up<img src="images/flag_green_large.png" height="11px" ></TD>
								<TD nowrap >Miles<img src="images/flag_green.png" height="18px" ></TD>
								<TD nowrap >Miles<img src="images/flag_red.png" height="18px" ></TD>
								<TD nowrap style="font-size: 14px; line-height:11px;" >Drop<img src="images/flag_red_large.png" height="11px" ></TD>
								<TD nowrap >Miles<img src="images/flag_green.png" height="18px" ></TD>
								<TD nowrap >Miles<img src="images/flag_red.png" height="18px" ></TD>
								<TD nowrap >Miles</TD>
								<TD nowrap >QP 3%</TD>
								<TD nowrap >Rate P/M</TD>
								<TD nowrap >MPG</TD>
								<TD nowrap >Diesel P/M</TD>
								<TD nowrap >Driver P/M</TD>
								<TD nowrap >Carrier</TD>
								<TD nowrap >Profit</TD>
								<TD nowrap >Misc</TD>
								<TD nowrap >Profit</TD>
								<TD nowrap >Profit %</TD>
								<TD nowrap >Gallons</TD>
								<TD nowrap >Diesel</TD>
								<TD nowrap >Driver</TD>
								<TD nowrap >User</TD>
								<TD nowrap >Date</TD>								
								</TR>
							<%
							DecimalFormat format=new DecimalFormat("#.##");
							PreparedStatement psQ = connection.prepareStatement("select (GLength(LineStringFromWKB(LineString(location, GeomFromText('POINT(" + request.getParameter("pickCity_lat") + " " + request.getParameter("pickCity_lng") + ")'))))) AS distanceFromPickCity, (GLength(LineStringFromWKB(LineString(location, GeomFromText('POINT(" + request.getParameter("destCity_lat") + " " + request.getParameter("destCity_lng") + ")'))))) AS distanceFromDestCity from test.mtb_trucker_keys where phone = ? and sms_verified = 1 order by ts desc  LIMIT 1");
							psQ.setString(1, truckerPhone);
							ResultSet resultSetQNow = psQ.executeQuery();
							DecimalFormat df = new DecimalFormat("#.#");
							while (resultSetQNow.next()) {
								%>
								<TR style="font-size: 10px; line-height:11px;">
								<TD nowrap colspan="24">
									From Pick Up : <%if(resultSetQNow.getString("distanceFromPickCity")!=null){%><%=df.format(Float.parseFloat(resultSetQNow.getString("distanceFromPickCity")) * 62.1371)%><%}else{%>NA<%}%>
									From Destination : <%if(resultSetQNow.getString("distanceFromDestCity")!=null){%><%=df.format(Float.parseFloat(resultSetQNow.getString("distanceFromDestCity")) * 62.1371)%><%}else{%>NA<%}%>
								
								</TD>								
								</TR>								
								<%
							}
							psQ = connection.prepareStatement("select trucking_quote.quote_id, image_load_id, trucking_quote.ts, user_id, miscel_pay, miles, rate, truck_mpg, driver_pay_mpg, avg_diesel, status, pickCity, pickState, destCity, destState, (GLength(LineStringFromWKB(LineString(pickCityLocation, GeomFromText('POINT(" + request.getParameter("pickCity_lat") + " " + request.getParameter("pickCity_lng") + ")'))))) AS distanceFromPickCity, (GLength(LineStringFromWKB(LineString(pickCityLocation, GeomFromText('POINT(" + request.getParameter("destCity_lat") + " " + request.getParameter("destCity_lng") + ")'))))) AS distanceFromDestCity, (GLength(LineStringFromWKB(LineString(destCityLocation, GeomFromText('POINT(" + request.getParameter("pickCity_lat") + " " + request.getParameter("pickCity_lng") + ")'))))) AS ddistanceFromPickCity, (GLength(LineStringFromWKB(LineString(destCityLocation, GeomFromText('POINT(" + request.getParameter("destCity_lat") + " " + request.getParameter("destCity_lng") + ")'))))) AS ddistanceFromDestCity from test.trucking_quote LEFT JOIN maids_image_load ON trucking_quote.quote_id = maids_image_load.quote_id where equipment_id = ? order by ts desc  LIMIT 2400");
							psQ.setString(1, request.getParameter("id"));
							ResultSet resultSetQ = psQ.executeQuery();
							while (resultSetQ.next()) {
								%>
								<%if(resultSetQ.getString("distanceFromPickCity")!=null && resultSetQ.getString("ddistanceFromDestCity")!=null && (Float.parseFloat(resultSetQ.getString("distanceFromPickCity")) * 62.1371) < 55 && (Float.parseFloat(resultSetQ.getString("ddistanceFromDestCity")) * 62.1371) < 55){%>
									<TR style="background-color: #A9F3A9;">
								<%}else if(resultSetQ.getString("distanceFromPickCity")!=null && resultSetQ.getString("ddistanceFromDestCity")!=null && (Float.parseFloat(resultSetQ.getString("distanceFromDestCity")) * 62.1371) < 55){%>
									<TR style="background-color: #A0E6E6;">
								<%}else if(resultSetQ.getString("distanceFromPickCity")!=null && resultSetQ.getString("ddistanceFromDestCity")!=null && (Float.parseFloat(resultSetQ.getString("distanceFromPickCity")) * 62.1371) < 55){%>
									<TR style="background-color: #FFB2B2;">
								<%}else{%>
									<TR>
								<%}%>
								<TD align="right" nowrap><a href="add_rate.jsp?id=<%=request.getParameter("id")%>&quote_id=<%=resultSetQ.getString("quote_id")%>" ><%=resultSetQ.getInt("rate")%></a></TD>
								<TD align="center" nowrap>
								<%if(resultSetQ.getString("status")!=null && resultSetQ.getString("status").startsWith("Accepted")){%>
								 	<img src="images/thumbs_up.png" width="16px">
								<%}else if(resultSetQ.getString("status")!=null && resultSetQ.getString("status").startsWith("Rejected")){%>
								 	<img src="images/thumbs_down.png" width="16px">
								<%} else if(resultSetQ.getString("status")!=null && resultSetQ.getString("status").startsWith("Call Back")){%>
								 	<img src="images/call.png" width="16px">
								<%}else {%>
									<%if(resultSetQ.getString("image_load_id")!=null){%>
										<B><span style="color:green;"><%=resultSetQ.getString("status")%></span></B>
									<%}else{%>
										<B><span style="color:#ff0000;"><%=resultSetQ.getString("status")%></span></B>
									<%}%>
								<%}%>
								</TD>
								<TD align="right" nowrap><%=resultSetQ.getString("pickCity")%>, <%=resultSetQ.getString("pickState")%></TD>
								<TD><%if(resultSetQ.getString("distanceFromPickCity")!=null){%><%=df.format(Float.parseFloat(resultSetQ.getString("distanceFromPickCity")) * 62.1371)%><%}else{%>NA<%}%></TD>
								<TD><%if(resultSetQ.getString("distanceFromDestCity")!=null){%><%=df.format(Float.parseFloat(resultSetQ.getString("distanceFromDestCity")) * 62.1371)%><%}else{%>NA<%}%></TD>								
								<TD align="right" nowrap><%=resultSetQ.getString("destCity")%>, <%=resultSetQ.getString("destState")%></TD>
								<TD><%if(resultSetQ.getString("ddistanceFromPickCity")!=null){%><%=df.format(Float.parseFloat(resultSetQ.getString("ddistanceFromPickCity")) * 62.1371)%><%}else{%>NA<%}%></TD>
								<TD><%if(resultSetQ.getString("ddistanceFromDestCity")!=null){%><%=df.format(Float.parseFloat(resultSetQ.getString("ddistanceFromDestCity")) * 62.1371)%><%}else{%>NA<%}%></TD>								
								<TD align="right" nowrap><%=resultSetQ.getInt("miles")%></TD>
								<TD align="right" nowrap><%=Math.round(resultSetQ.getInt("rate") * .97) %></TD>
								<TD align="right" nowrap><%=format.format(resultSetQ.getFloat("rate")/resultSetQ.getFloat("miles"))%></TD>
								<% if(mpgLast.equals(""))mpgLast=resultSetQ.getFloat("truck_mpg") + "";%>
								<% if(drvPayLast.equals(""))drvPayLast=resultSetQ.getFloat("driver_pay_mpg") + "";%>
								<TD align="right" nowrap><%=resultSetQ.getFloat("truck_mpg")%></TD>
								<TD align="right" nowrap><%=resultSetQ.getFloat("avg_diesel")%></TD>
								<TD align="right" nowrap><%=resultSetQ.getFloat("driver_pay_mpg")%></TD>
								<TD align="right" nowrap><%=Math.round(((resultSetQ.getInt("miles") / resultSetQ.getFloat("truck_mpg")) * resultSetQ.getFloat("avg_diesel")) + (resultSetQ.getFloat("driver_pay_mpg") * resultSetQ.getInt("miles")))%></TD>
								<TD align="right" nowrap><%=Math.round((resultSetQ.getInt("rate") * .97) - (((resultSetQ.getInt("miles") / resultSetQ.getFloat("truck_mpg")) * resultSetQ.getFloat("avg_diesel")) + (resultSetQ.getFloat("driver_pay_mpg") * resultSetQ.getInt("miles"))))%></TD>
								<TD align="right" nowrap><%=resultSetQ.getInt("miscel_pay")%></TD>
								<TD align="right" nowrap><%=Math.round((resultSetQ.getInt("rate") * .97) - (((resultSetQ.getInt("miles") / resultSetQ.getFloat("truck_mpg")) * resultSetQ.getFloat("avg_diesel")) + (resultSetQ.getFloat("driver_pay_mpg") * resultSetQ.getInt("miles")) + resultSetQ.getInt("miscel_pay")))%></TD>
								<TD align="right" nowrap><%=format.format(((resultSetQ.getInt("rate") * .97) - (((resultSetQ.getInt("miles") / resultSetQ.getFloat("truck_mpg")) * resultSetQ.getFloat("avg_diesel")) + (resultSetQ.getFloat("driver_pay_mpg") * resultSetQ.getInt("miles")) + resultSetQ.getInt("miscel_pay")))/(resultSetQ.getInt("rate") * .97))%></TD>
								<TD align="right" nowrap><%if(resultSetQ.getFloat("truck_mpg")>0){%><%=Math.round(resultSetQ.getInt("miles")/resultSetQ.getFloat("truck_mpg"))%><%}else{%>0<%}%></TD>
								<TD align="right" nowrap><%=Math.round((resultSetQ.getInt("miles")/resultSetQ.getFloat("truck_mpg")) * resultSetQ.getFloat("avg_diesel"))%></TD>
								<TD align="right" nowrap><%=Math.round(resultSetQ.getInt("miles")*resultSetQ.getFloat("driver_pay_mpg"))%></TD>
								<TD nowrap nowrap><%=resultSetQ.getString("user_id")%></TD>
								<TD nowrap nowrap><%=new SimpleDateFormat("MM-dd-yyyy hh:mm").format(resultSetQ.getTimestamp("TS"))%></TD>
								</TR>
								<%
							}
							%>
							</table>
								<%
	
							}					
							connection.close();		
						 }catch (Exception ex){	         
						     %>XX<%= (String)session.getAttribute("distance") %>XX<%="Error Posting " + ex%><%  
						     System.out.println(""+ ex);
						 }
	         
						%>	
				</FORM>	
				</table>
	<script type="text/javascript">
	//<![CDATA[

		// Create all editor instances at the end of the page, so we are sure
		// that the "bottomSpace" div is available in the DOM (IE issue).



		CKEDITOR.replace( 'comments',
			{
				sharedSpaces :
				{
					top : 'topSpace',
					bottom : 'bottomSpace'
				},

				// Removes the maximize plugin as it's not usable
				// in a shared toolbar.
				// Removes the resizer as it's not usable in a
				// shared elements path.
				removePlugins : 'maximize,resize'
			} );				

	//]]>
	</script>
<script>
function loadLastSaved()
{	
	document.getElementsByName("truckmpg")[0].value = '<%=mpgLast%>';
	document.getElementsByName("driver_pay")[0].value = '<%=drvPayLast%>';
	calNumbers();
	
}
	</script>

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
	        	</html> 	
<%}else{%>
	        	<a href="../index4.html">Please Login</a>
<%}%>