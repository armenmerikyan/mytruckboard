<%@ page import="com.big.util.*,java.text.*,java.util.*,java.io.*,javax.xml.parsers.*,org.w3c.dom.*,java.sql.*,java.text.DateFormat" %>
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
        <title>MYTRUCKBOARD 2.0 - dead simple freight dispatch</title>
        <link rel="shortcut icon" href="http://www.mytruckboard.com/trucking-new/images/mtb-favicon.ico">
        <meta http-equiv="content-type" content="text/html; charset=utf-8" />
        <meta name="description" content="The complete freight management software. Win shipping deals and manage your fleet of trucks effortlessly." />
        <meta name="keywords" content="freight, transportation, dispatch management, load optimization, truck broker, transportation management, truck, truck fleet management, shippers, truck brokers, shipping made easy, trucking industry, trucking software, trucking, dispatch for freight brokder, carrier management, load board, load, board" />

              <!-- Bootstrap core CSS -->
            <link href="css/bootstrap2.min.css" rel="stylesheet">

            <!-- Custom styles for this template -->
            <link href="css/navbar-fixed-top.css" rel="stylesheet">

            <!-- custom styles -->
            <link href="css/style2.css" rel="stylesheet">

            <!--- custom style -->
            <link href="css/styles3.css" rel="stylesheet">

            <!--- custom style -->
            <link href="css/style4.css" rel="stylesheet">


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
    <script type="text/javascript" src="js/transition.js"></script>
    <script type="text/javascript" src="js/collapse.js"></script>


    <script type="text/javascript" src="js/bootstrap-datetimepicker.min.js"></script>

    <!-- datepicker related -->

    <!-- custom maps markers -->
    <script src="css/fontawesome-markers.min.js"></script>



    <!-- <script>
        $i.noConflict();
        jQuery(document).ready(function(){
        $i( "#startDate" ).datepicker();
        });
        </script>
        <script>
        $i.noConflict();
        jQuery(document).ready(function(){
        $i( "#endDate" ).datepicker();
        });
        </script>
        -->

        <!--<script type="text/javascript"
        src="https://maps.googleapis.com/maps/api/js?key=AIzaSyBpeQ3zGuTunYzxmiNMUltHL352e4beac4">
        </script>
            -->
       <!-- Google api:-->
        <script src="https://maps.googleapis.com/maps/api/js?v=3.exp&signed_in=true&libraries=places"></script>
        <!-- end of google api -->


            <%
			String searchSql = "";
			String uuid = (String)session.getAttribute("uuid");

			if(request.getParameter("haulFilter")!=null){
				if(request.getParameter("haulFilter").equals("Headhaul")){
					if(searchSql.contains("WHERE")) searchSql = searchSql + " AND HAUL = 'Headhaul'";
					else searchSql =  searchSql + " WHERE HAUL = 'Headhaul'";
				}else if(request.getParameter("haulFilter").equals("Backhaul")){
					if(searchSql.contains("WHERE")) searchSql =  searchSql + " AND HAUL = 'Backhaul'";
					else searchSql =  searchSql + " WHERE HAUL = 'Backhaul'";
				}
			}

			if(!searchSql.equals(""))searchSql = searchSql + " AND COMPANY_ID = '" + uuid + "'";
			else searchSql = searchSql + " WHERE COMPANY_ID = '" + uuid + "'";

			if(searchSql.contains("WHERE")) searchSql = searchSql + " and ISONLINE = 1 ";
			else searchSql =  searchSql + " WHERE ISONLINE = 1 ";

			Class.forName("com.mysql.jdbc.Driver");
			String url = "jdbc:mysql://localhost/test?zeroDateTimeBehavior=convertToNull";
			Connection connection = DriverManager.getConnection(url,"<USERNAME>", "<PASSWORD>");


			PreparedStatement ps = connection.prepareStatement("select contact_name from test.trucking_company where COMPANY_ID = ? ");
			ps.setString(1, uuid);
			ResultSet resultSet2 = ps.executeQuery();
			while (resultSet2.next()) {

			session.setAttribute("contact_name", resultSet2.getString("contact_name"));

			}

			PreparedStatement psMain = null;

			%>
            <%
				HashMap mainTruckMap = new HashMap();
				DateFormat formatter = new SimpleDateFormat("MM/dd/yyyy.HH.mm.ss");
			if(request.getParameter("startDate")!=null && !request.getParameter("startDate").equals("") && request.getParameter("endDate")!=null && !request.getParameter("endDate").equals("")){
				java.sql.Date start = null;
				java.sql.Date end = null;
				start = new java.sql.Date(((java.util.Date)formatter.parse(request.getParameter("startDate") + ".00.00.00" )).getTime());
				end = new java.sql.Date(((java.util.Date)formatter.parse(request.getParameter("endDate") + ".23.59.59" )).getTime());
				psMain = connection.prepareStatement("select LANGUAGE, external_id, CITY, STATE, NAME, ID, DATE_MODIFIED, TRAILER, COVERED_BY, WTG, CONTACT_PERSON, DATE_STATUS_CHANGE, DATE_COVERED, LAST_MODIFIED_BY, LAST_MODIFIED_DATE, LOAD_TYPE, PHONE, COMMENTS, TRUCKINFO, INSURANCE_EXP_DATE, ISONLINE, X(city_point) as city_lat, Y(city_point) as city_lng from test.TRUCKING_EQUIPMENT"  + searchSql +  " AND DATE_MODIFIED BETWEEN ? AND ? ");
				psMain.setDate(1, start);
				psMain.setTimestamp(2, new java.sql.Timestamp(end.getTime()));
			}else{
				psMain = connection.prepareStatement("select LANGUAGE, external_id, CITY, STATE, NAME, ID, DATE_MODIFIED, TRAILER, COVERED_BY, WTG, CONTACT_PERSON, DATE_STATUS_CHANGE, DATE_COVERED, LAST_MODIFIED_BY, LAST_MODIFIED_DATE, LOAD_TYPE, PHONE, COMMENTS, TRUCKINFO, INSURANCE_EXP_DATE, ISONLINE, X(city_point) as city_lat, Y(city_point) as city_lng from test.TRUCKING_EQUIPMENT" + searchSql);
			}
			ResultSet resultSet = psMain.executeQuery();
			int j = 0;
			while (resultSet.next()) {
			//city_lat city_lng

				String latLongString = resultSet.getString("state") + " " + resultSet.getString("city");
				String[] dataSet = new String[8];
				dataSet[0]=resultSet.getString("id");
				dataSet[1]=resultSet.getString("phone");
				dataSet[2]=resultSet.getString("CONTACT_PERSON");
				dataSet[3]=resultSet.getString("WTG");
				dataSet[4]=resultSet.getFloat("city_lat")+"";
				dataSet[5]=resultSet.getFloat("city_lng")+"";
				dataSet[6]=resultSet.getString("CITY")+"";
				dataSet[7]=resultSet.getString("STATE")+"";
				if(mainTruckMap.containsKey(latLongString)){
					Vector mainTruckLayer = (Vector)mainTruckMap.get(latLongString);
					mainTruckLayer.add(dataSet);
					mainTruckMap.put(latLongString,mainTruckLayer);
				}else{
					Vector mainTruckLayer = new Vector();
					mainTruckLayer.add(dataSet);
					mainTruckMap.put(latLongString,mainTruckLayer);
				}
	  		}
	  		%>

        <script type="text/javascript">


        var locations = [
            <%
	  			if(true){
				Iterator entries = mainTruckMap.entrySet().iterator();
				while (entries.hasNext()) {
				    Map.Entry entry = (Map.Entry) entries.next();
				    Vector mainTruckLayer = (Vector)entry.getValue();
				    String[] dataSetFirst = (String[])mainTruckLayer.elementAt(0);
							%>['<%=mainTruckLayer.size() + " " + dataSetFirst[0]%>', <%=dataSetFirst[4]%>, <%=dataSetFirst[5]%>, 'address 1','<%=dataSetFirst[0]%>','<%=dataSetFirst[6]%>','<%=dataSetFirst[7]%>','<%=mainTruckLayer.size()%>'],<%
						  	String contentString = "";
						    for(int k=0;k<mainTruckLayer.size();k++){
							String[] dataSet = (String[])mainTruckLayer.elementAt(k);
							contentString  = contentString +dataSet[2];
							System.out.println(" Value = " + dataSet[0]);
						    }
				}
				}%>
        ['xx', 0, 0, 'address 1','xx','xx','xx','xx']
        ];



        var map ;
        function initialize() {



    var myOptions = {
        center: new google.maps.LatLng(30.8282, -92.5795),
        zoom: 4,
        mapTypeId: google.maps.MapTypeId.ROADMAP

        };
        map = new google.maps.Map(document.getElementById("map-canvas"),
        myOptions);
        var bounds = new google.maps.LatLngBounds(
        new google.maps.LatLng(25.82, -124.39),
        new google.maps.LatLng(49.38, -66.94)
        );

        map.fitBounds(bounds);



        var input = /** @type {HTMLInputElement} */(
        document.getElementById('pac-input'));

        var input2 = /** @type {HTMLInputElement} */(
        document.getElementById('pac-input2'));


        var autocomplete = new google.maps.places.Autocomplete(input);
        autocomplete.bindTo('bounds', map);

        var marker = new google.maps.Marker({
        map: map,
        anchorPoint: new google.maps.Point(0, -29),
        animation: google.maps.Animation.DROP
        });

        var autocomplete2 = new google.maps.places.Autocomplete(input2);
        autocomplete2.bindTo('bounds', map);

        var marker2 = new google.maps.Marker({
        map: map,
        anchorPoint: new google.maps.Point(0, -29),
        animation: google.maps.Animation.DROP
        });


        google.maps.event.addListener(autocomplete, 'place_changed', function() {
        // infowindow.close();
        marker.setVisible(false);

        var place = autocomplete.getPlace();


        if (!place.geometry) {
        return;
        }



        marker.setIcon(/** @type {google.maps.Icon} */({
        url: 'http://maps.google.com/mapfiles/ms/icons/green-dot.png',
        size: new google.maps.Size(71, 71),
        origin: new google.maps.Point(0, 0),
        anchor: new google.maps.Point(17, 34),
        scaledSize: new google.maps.Size(35, 35)
        }));

        marker.setPosition(place.geometry.location);


        document.getElementById('pickCity_lat').value = place.geometry.location.lat();
        document.getElementById('pickCity_lng').value = place.geometry.location.lng();

        //alert(document.getElementById('pickCity_lat2').value);
        getDistanceTrucks('', document.getElementById('pickCity_lat').value, document.getElementById('pickCity_lng').value);

     // alert(pickupCitylat);



    //   document.getElementById(pickupCityLat).value = place.geometry.location.lat();
     //   document.getElementById(pickupCityLng).value = place.geometry.location.lng();

     marker.setVisible(true);





        // infowindow.setContent('<div><strong>' + place.name + '</strong><br>' + address);
        // infowindow.open(map, marker);
        });

        google.maps.event.addListener(autocomplete2, 'place_changed', function() {
        // infowindow.close();
        marker2.setVisible(false);
        var place2 = autocomplete2.getPlace();
        if (!place2.geometry) {
        return;
        }

        marker2.setIcon(/** @type {google.maps.Icon} */({
        url: 'http://maps.google.com/mapfiles/ms/icons/red-dot.png',
        size: new google.maps.Size(71, 71),
        origin: new google.maps.Point(0, 0),
        anchor: new google.maps.Point(17, 34),
        scaledSize: new google.maps.Size(35, 35)
        }));
        marker2.setPosition(place2.geometry.location);
        marker2.setVisible(true);
        // infowindow.setContent('<div><strong>' + place.name + '</strong><br>' + address);
        // infowindow.open(map, marker);
        });


        setMarkers(map,locations);


        }




        function setMarkers(map,locations){

        var marker3, i


        for (i = 0; i < locations.length; i++)
        {

        var loan = locations[i][0]
        var loanID = locations[i][4]
        var lat = locations[i][1]
        var long = locations[i][2]
        var add =  locations[i][3]
        var city =  locations[i][5]
        var countID =  locations[i][7]

        latlngset = new google.maps.LatLng(lat, long);
        //var image = 'images/transport.png';
        var marker3 = new google.maps.Marker({
        map: map, title: countID + " " + city , position: latlngset, icon:{
            path: fontawesome.markers.TRUCK,
            scale: 0.5,
            strokeWeight: 0.4,
            strokeColor: 'green',
            strokeOpacity: 1,
            fillColor: '#FFFFFF',
            fillOpacity: 1,
            },
        });
        map.setCenter(marker3.getPosition());


        var content = "Loan Number: " + loan +  '</h3>' + "Address: " + add ;

        var infowindow = new google.maps.InfoWindow();

        google.maps.event.addListener(marker3,'click', (function(marker3,content,infowindow,loanID, lat, long){
        return function() {
        //infowindow.setContent(content);
        //infowindow.open(map,marker);
        showAddress2Trucks(loanID, lat, long);
        };
        })(marker3,content,infowindow,loanID, lat, long));

        }
        }
        function getLinkwithForm(link_file_name, equipmentID){
        var urlString = link_file_name + "&id=" + equipmentID;

        var rates = document.getElementsByName('haulFilter');
        var rate_value;
        for(var i = 0; i < rates.length; i++){
        if(rates[i].checked){
        rate_value = rates[i].value;
        }
        }

        var formF = document.getElementsByTagName("input");
        for(var j = 0; j<formF.length;j++){
        urlString = urlString + "&" + formF[j].name + "=" + encodeURIComponent(formF[j].value);
        }
        urlString = urlString + "&haulFilter=" +rate_value;
        window.location.href =  urlString;
        }
        function showAddress2Trucks(loan, lat, long) {
        //document.getElementById("defaultdd").innerHTML="rgb(0,60,255)";
        //document.getElementById("defaultdd").style.backgroundColor="blue";
        //alert(document.getElementById(loan));
        //alert(loan);
        document.getElementById(loan).style.backgroundColor="white";
        getDistanceTrucks(loan, lat, long);
        }

        function getDistanceTrucks(startLoc, lat, long){
        var myLatlng = new google.maps.LatLng(lat,long);
        map.setCenter(myLatlng);
        //alert("Ran agains");
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
        //document.getElementById("location").value = locationName;
        document.getElementById("defaultdd").innerHTML = xmlhttp.responseText;
        }
        }
        var urlString = "";
        var formF = document.getElementsByTagName("input");
        for(var j = 0; j<formF.length;j++){
        if(formF[j].name!='haulFilter'){
        urlString = urlString + "&" + formF[j].name + "=" + encodeURIComponent(formF[j].value);
        }
        }
        var rates = document.getElementsByName('haulFilter');
        var rate_value;
        for(var i = 0; i < rates.length; i++){
        if(rates[i].checked){
        rate_value = rates[i].value;
        }
        }
        urlString = urlString + "&haulFilter=" +rate_value;
        //document.getElementById(startLoc).style.backgroundColor="white";
        //alert(urlString);
        xmlhttp.open("GET", "trucklist-detail.jsp?origin=" + encodeURIComponent(startLoc) + "&lat=" + lat +"&long=" + long + urlString,true);
        xmlhttp.send();
        }
        function getDetail(startLoc){
        //alert("Ran agains");
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
        //document.getElementById("location").value = locationName;
        document.getElementById("defaultDetail").innerHTML = xmlhttp.responseText;
        }
        }
        var urlString = "";
        var formF = document.getElementsByTagName("input");
        for(var j = 0; j<formF.length;j++){
        if(formF[j].name!='haulFilter'){
        urlString = urlString + "&" + formF[j].name + "=" + encodeURIComponent(formF[j].value);
        }
        }

        xmlhttp.open("GET", "trucklist-trucker-detail.jsp?id=" + encodeURIComponent(startLoc) + urlString,true);
        xmlhttp.send();
        }
        </script>

        <script type="text/javascript">
        var itemListLabel ;
        var itemListMain ;
        var markerPickUp;
        var markerDropOff;
        function getLinkwithForm(link_file_name, equipmentID){
        var urlString = link_file_name + "&id=" + equipmentID;
        var formF = document.getElementsByTagName("input");
        for(var j = 0; j<formF.length;j++){
        urlString = urlString + "&" + formF[j].name + "=" + encodeURIComponent(formF[j].value);
        }
        window.location.href =  urlString;
        }
        function getDistance(startLoc, endLoc){
        //alert("Ran agains");
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
        //document.getElementById("location").value = locationName;
        document.getElementById("distance").value = xmlhttp.responseText.split('|')[0];
        document.getElementById("duration").value = xmlhttp.responseText.split('|')[1];
        document.getElementById("img_Distance").innerHTML = "<img src=\"images/notification_done.png\" width=\"14px\" />";
        document.getElementById("img_Duration").innerHTML = "<img src=\"images/notification_done.png\" width=\"14px\" />";

        }
        }
        document.getElementById("img_Distance").innerHTML = "<img src=\"images/notification_error.png\" width=\"14px\" />";
        document.getElementById("img_Duration").innerHTML = "<img src=\"images/notification_error.png\" width=\"14px\" />";
        xmlhttp.open("GET", "getDirections.jsp?origin=" + encodeURIComponent(startLoc) + "&destination=" + encodeURIComponent(endLoc) ,true);
        xmlhttp.send();
        }


        function autocompleteAddressLookUp(locationName, refID, fillCity, fillState){
        //alert("Ran agains");
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
        //document.getElementById("location").value = locationName;
        var lat = fillCity + "_lat";
        var lng = fillCity + "_lng";
        var gps = fillCity + "_GPS";
        document.getElementById(fillCity).value = xmlhttp.responseText.split('|')[2];
        document.getElementById(fillState).value = xmlhttp.responseText.split('|')[3];
        document.getElementById(lat).value = xmlhttp.responseText.split('|')[5];
        document.getElementById(lng).value = xmlhttp.responseText.split('|')[6];
        document.getElementById(gps).innerHTML = "<img src=\"images/notification_done.png\" width=\"14px\" />";
        if(document.getElementById("destCity").value != null && document.getElementById("pickCity").value != null){
        getDistance(document.getElementById("pickCity_lat").value + ',' + document.getElementById("pickCity_lng").value,document.getElementById("destCity_lat").value + ',' + document.getElementById("destCity_lng").value);

        }
        //alert(fillCity);
        var lngt = parseFloat(xmlhttp.responseText.split('|')[6]) + .02;
        var latlngset = new google.maps.LatLng(xmlhttp.responseText.split('|')[5], lngt);
        var image = 'images/flag_green.png';

        if(fillCity == 'pickCity'){
        image = 'images/flag_green.png';
        if(markerPickUp ==null){
        markerPickUp = new google.maps.Marker({
        map: map, title: "Pick UP" , position: latlngset, icon: image
        });
        }else{
        var latlng = new google.maps.LatLng(xmlhttp.responseText.split('|')[5], lngt);
        markerPickUp.setPosition(latlng);
        }
        map.setCenter(markerPickUp.getPosition());
        getDistanceTrucks('',xmlhttp.responseText.split('|')[5],xmlhttp.responseText.split('|')[6]);
        }else{
        image = 'images/flag_red.png';
        if(markerDropOff ==null){
        markerDropOff = new google.maps.Marker({
        map: map, title: "Drop OFF" , position: latlngset, icon: image
        });
        }else{
        var latlng = new google.maps.LatLng(xmlhttp.responseText.split('|')[5], lngt);
        markerDropOff.setPosition(latlng);
        }
        map.setCenter(markerDropOff.getPosition());

        }
        //https://join.me/264-608-940v
        //marker.setPosition( new google.maps.LatLng( 0, 0 ) );
        }
        }
        xmlhttp.open("GET", "autoFillAddress.jsp?location=" + refID ,true);
        xmlhttp.send();
        }
        function autocompleteAddressLookUpNoDistance(locationName, refID, fillCity, fillState){
        //alert("Ran agains");
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
        //document.getElementById("location").value = locationName;
        var lat = fillCity + "_lat";
        var lng = fillCity + "_lng";
        var gps = fillCity + "_GPS";
        document.getElementById(fillCity).value = xmlhttp.responseText.split('|')[2];
        document.getElementById(fillState).value = xmlhttp.responseText.split('|')[3];
        document.getElementById(lat).value = xmlhttp.responseText.split('|')[5];
        document.getElementById(lng).value = xmlhttp.responseText.split('|')[6];
        document.getElementById(gps).innerHTML = "<img src=\"images/notification_done.png\" width=\"14px\" />";

        }
        }
        xmlhttp.open("GET", "autoFillAddress.jsp?location=" + refID ,true);
        xmlhttp.send();
        }

        function coverDriver(fillCity){
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
        //document.getElementById("location").value = locationName;

        var containsItems = xmlhttp.responseText.split("<ITEM>");
        var equipmentID = containsItems[0];
        var imgicon = "IMGCOVER" + equipmentID.trim();
        //alert(imgicon);
        if(containsItems[1] == "TRUE"){
        document.getElementById(imgicon).src = "images/greenTruck.png";
        }else{
        document.getElementById(imgicon).src = "images/redTruck.png";
        }

        }
        }
        //alert('coming soon');
        var imgicon = "IMGCOVER" + fillCity;
        xmlhttp.open("GET", "coverDriver.jsp?equipmentID=" + fillCity ,true);
        //alert(imgicon);
        document.getElementById(imgicon).src = "images/ajax_loader_blue_512.gif";
        // ajax_loader_blue_512
        xmlhttp.send();
        }
        function sendSMStoDriver(fillCity){
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
        //document.getElementById("location").value = locationName;

        var containsItems = xmlhttp.responseText.split("<ITEM>");
        var equipmentID = containsItems[0];
        var imgicon = "IMG" + equipmentID.trim();
        //alert(imgicon);
        if(containsItems[1] == "TRUE"){
        document.getElementById(imgicon).src = "images/sms.icon.green.gif";
        }else{
        document.getElementById(imgicon).src = "images/sms.icon.red.gif";
        }

        }
        }
        //alert('coming soon');
        var imgicon = "IMG" + fillCity;
        xmlhttp.open("GET", "smsDriver.jsp?equipmentID=" + fillCity ,true);
        //alert(imgicon);
        document.getElementById(imgicon).src = "images/ajax_loader_blue_512.gif";
        // ajax_loader_blue_512
        xmlhttp.send();
        }
        function autocompleteAddress(fillCity, fillState){

        var locationNameCurrent= document.getElementById(fillCity).value;
        for(var j =0;j<itemListLabel.length;j++){
        if(itemListLabel[j] == locationNameCurrent){
        autocompleteAddressLookUp(locationNameCurrent.split(',')[0], itemListMain[j].split(':')[1], fillCity, fillState);
        break;
        }
        }
        }
        function autocompleteAddressNoDistance(fillCity, fillState){

        var locationNameCurrent= document.getElementById(fillCity).value;
        for(var j =0;j<itemListLabel.length;j++){
        if(itemListLabel[j] == locationNameCurrent){
        autocompleteAddressLookUpNoDistance(locationNameCurrent.split(',')[0], itemListMain[j].split(':')[1], fillCity, fillState);
        break;
        }
        }
        }

        function autocompleteLocationName(searchKey, fillTextBoxName){
        //alert('Execute Fine');
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
        	//alert("Response Came Back");

        itemListLabel = xmlhttp.responseText.split('|');
        itemListMain = xmlhttp.responseText.split('|');
        for(var j =0;j<itemListMain.length;j++){
        var itemListSet = itemListMain[j].split(":");
        itemListLabel[j] = itemListSet[0];
        }
        fillTextBoxName = "#" + fillTextBoxName;
        $(fillTextBoxName).autocomplete({ source: itemListLabel });
        }
        }
        var lat = fillTextBoxName + "_lat";
        var lng = fillTextBoxName + "_lng";
        var gps = fillTextBoxName + "_GPS";
        document.getElementById(lat).value = '';
        document.getElementById(lng).value = '';
        //document.getElementById(gps).innerHTML = "<img src=\"images/notification_error.png\" width=\"14px\" />";

        if(searchKey.length>1){
        xmlhttp.open("GET", "autoComplete.jsp?location=" + encodeURIComponent(searchKey) ,true);
        xmlhttp.send();
        }
        }
        function clearFieldsNow() {
        document.getElementById("startDate").value = '';
        document.getElementById("endDate").value = '';
        document.getElementById("searchKeyCity").value = '';
        document.getElementById("searchKeyState").value = '';
        }
        function clearFieldsNowCity() {
        document.getElementById("startDate").value = '';
        document.getElementById("endDate").value = '';
        document.getElementById("searchKeyCity").value = '';
        document.getElementById("searchKeyState").value = '';
        }

        $( ".selector" ).bind( "autocompleteselect", function(event, ui) {
        //access ui.item for anything that was selected you want.
        alert("HELLO 2");
        });


        </script>


    <!-- date picker - required for formatting of the from and to date boxes-->
    <script type="text/javascript">
    $(function () {
    $('#datetimepicker1').datetimepicker({
    format: 'MM/DD/YYYY',
    showClear: true

    });

    $('#datetimepicker2').datetimepicker({
    format: 'MM/DD/YYYY',
    showClear: true

    });
    });

    </script>
    <!--/ end -->

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

        </head>



        <body onload="initialize()">



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
    <span class="image" ><a href="../index4.jsp" class="navbar-brand"  style="height: 35px; margin-left: 0px; padding: 10px 0px 0px; border-right-width: 0px;"><img src="images/mytryckboard_logo_v2i_small.png"></a></span>
    </div>
    <div id="navbar" class="navbar-collapse collapse">
    <ul class="nav navbar-nav">

    <li><a href="standard-truckboard.jsp">Truck Board</a></li>
    <li class="active"><a href="truckboard.jsp">Truck Board 2.0 <small><strong>(new)</strong></small></a></li>
    <li><a href="/trucking/index.lite.jsp">Live Board</a></li>
    <li><a href="new_features.jsp">What's New</a></li>


        <%if(session.getAttribute("isAdmin").equals("true")){%> <li class="dropdown">
    <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">Account Administration<span class="caret"></span></a>
    <ul class="dropdown-menu" role="menu">
    <li><a href="/trucking-new/company_profile_view.jsp">My Account</a></li>

    <li><a href="manage_users.jsp">My Users</a></li>
    <li><a href="add_user.jsp">Add User</a></li>
    <li><a href="add_truck.jsp">Add Truck</a></li>


    </ul>
    </li><%}%>

    </ul>

            <ul class="nav navbar-nav navbar-right">

            <li class="dropdown active">
            <a href="#" class="dropdown-toggle active" data-toggle="dropdown" role="button" aria-expanded="false">Hello <b><%=NullCheck.check((String)session.getAttribute("f_name"))%></b><span class="caret"></span></a>
            <ul class="dropdown-menu" role="menu">
            <li><a href="javascript:void(0)" onclick="logoutuser('<%=session.getAttribute("uuid")%>')" data-toggle="modal" data-target="#logoutconfirm">Log Out</a></li></ul>
            </ul>

        </div><!--/.nav-collapse -->


    <HR style="margin-bottom: 5px;margin-top: 5px;">

    <!-- main select row -->

    <form class="form-inline" name="searchForm" id="searchForm" action="truckboard.jsp" method="post">
    <div class="form-group form-group-sm">
    <label class="sr-only" for="exampleInputAmount">SelectForm</label>
    <div class="input-group input-group-sm">
    <div class="input-group-addon" >Pickup:</div>

    <input type="hidden" name="pickCity_lat" id="pickCity_lat" value="<%=NullCheck.check((String)session.getAttribute("pickCity_lat"))%>" />
    <input type="hidden" name="pickCity_lng" id="pickCity_lng" value="<%=NullCheck.check((String)session.getAttribute("pickCity_lng"))%>" />



    <input type="text" class="form-control" id="pac-input"  placeholder="Pickup City" />



    <div class="input-group-addon">Destination:</div>
    <input type="text" class="form-control" id="pac-input2" placeholder="Destination City" />


    </div></div>

    <div class="form-group form-group-sm">

    <div class="input-group input-group-sm">


    <div class='input-group-addon'>From:</div>
    <div class='input-group date' id='datetimepicker1'>
    <input type='text' class="form-control"  <%if(request.getParameter("startDate")!=null){%> value="<%=request.getParameter("startDate")%>"<%}%> name="startDate" id="startDate" placeholder="Date">
    <span class="input-group-addon">
    <span class="glyphicon glyphicon-calendar"></span>
    </span>

    </div>

    <div class='input-group-addon'>To:</div>
    <div class='input-group date' id='datetimepicker2'>
    <input type='text' class="form-control" <%if(request.getParameter("endDate")!=null){%> value="<%=request.getParameter("endDate")%>"<%}%> name="endDate" id="endDate" placeholder="Date">
    <span class="input-group-addon">
    <span class="glyphicon glyphicon-calendar"></span>
    </span>

    </div>


    </div>
    <button class="btn btn-default btn-sm" type="button" onclick="this.form.submit()" >Filter</button>

    </div>

    <div class="form-group form-group-sm">
    <label class="sr-only" for="Haul">Haul</label>


    Haul All <input type="radio" onchange="this.form.submit()" name="haulFilter" value="All" <%if(request.getParameter("haulFilter")==null || request.getParameter("haulFilter").equals("All")){%>checked<%}%> />
    Head <input type="radio" onchange="this.form.submit()" name="haulFilter" value="Headhaul" <%if(request.getParameter("haulFilter")!=null && request.getParameter("haulFilter").equals("Headhaul")){%>checked<%}%> />
    Back <input type="radio" onchange="this.form.submit()" name="haulFilter" value="Backhaul" <%if(request.getParameter("haulFilter")!=null && request.getParameter("haulFilter").equals("Backhaul")){%>checked<%}%> />



    <!--<button type="submit" class="btn btn-default">Filter</button>-->
    </div>


    <!--
    <select id="haulFilter" class="form-control">

    <option class="" name="haulFilter" value="All" <%if(request.getParameter("haulFilter")==null || request.getParameter("haulFilter").equals("All")){%>selected<%}%> >Haul All</option>
    <option class="" name="haulFilter" value="Headhaul"  <%if(request.getParameter("haulFilter")!=null && request.getParameter("haulFilter").equals("Headhaul")){%>selected<%}%> >Head</option>
    <option class="" name="haulFilter" value="Backhaul">Back</option>
    </select>
    -->



    </form>

    </div>
    </nav>


<!-- Main page: -->

            <div class="container-fluid">
            <div class="row">

    <br/><br/><br/><br/><br/><br/><br/>
            <div class="col-sm-2">
            <!-- Left column -->
            <strong>My Trucks: Location</strong>



            <ul class="nav nav-pills nav-stacked">



                <%
	  			if(true){
				Map map = new TreeMap(mainTruckMap);
				Set set2 = map.entrySet();
				Iterator entries = set2.iterator();
				//Iterator entries = mainTruckMap.entrySet().iterator();
				while (entries.hasNext()) {
				    Map.Entry entry = (Map.Entry) entries.next();
				    Vector mainTruckLayer = (Vector)entry.getValue();
				    String[] dataSetFirst = (String[])mainTruckLayer.elementAt(0);
							%>

            <li><a href="#" onclick="getDistanceTrucks('<%=dataSetFirst[0]%>','<%=dataSetFirst[4]%>','<%=dataSetFirst[5]%>')"><%=mainTruckLayer.size() %>  |
                <%=dataSetFirst[6]%><%if(NullCheck.check(dataSetFirst[6]).equals("")){%>[No Name]<%}%>, <%=dataSetFirst[7]%> </a>

            </li>

                <%
						  	String contentString = "";
						    for(int k=0;k<mainTruckLayer.size();k++){
							String[] dataSet = (String[])mainTruckLayer.elementAt(k);
							contentString  = contentString +dataSet[2];
							System.out.println(" Value = " + dataSet[0]);
						    }
				}
				}%>
            </ul>



            </div><!-- /col-2 -->


            <div class="col-sm-10">

            <!-- column 2 -->

            <!-- center left-->
            <!-- map view -->

            <div class="col-md-7" style="padding-right: 5px; padding-left: 5px;">
            <div class="panel panel-default">

            <div class="panel-body" style="padding: 2px;">

            <div style="float:left;height:300px;width:100%;" id="map-canvas"></div>


            </div>
            </div>
            <!-- end of map biew -->


            </div><!--/col-->


            <div id="defaultDetail" class="col-md-3" style="height: 300px; padding-left: 2px; padding-right: 2px; overflow: scroll;">


            <!--trucker details - tabs-->

         


            <!-- tabs-->


            </div><!--/col-span-6-->

           <!--/row-->


            <!-- truck list row starts here -->

            <div class="col-md-10">
            <strong>My Trucks </strong> <small> sorted by pickup city or location</small>

            <hr>


            <!-- truckers list view starts here-->

                <div id="defaultdd" style="float:right;width:100%; overflow: scroll;"></div>

            </div>


            <!-- end of truck list view -->



            </div><!--/col-span-10-->


            </div>
            </div>
            <!-- /Main page -->
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

    <!-- Bootstrap core JavaScript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster -->
     <script src="js/bootstrap2.min.js"></script>
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
</html>
