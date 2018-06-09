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

        <title>MYTRUCKBOARD 2.0 - next generation simple freight dispatch software</title>
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
    <script type="text/javascript" src="js/transition.js"></script>
    <script type="text/javascript" src="js/collapse.js"></script>


    <script type="text/javascript" src="js/bootstrap-datetimepicker.min.js"></script>


    <!-- datepicker related -->


    <!-- Bootstrap core JavaScript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster -->
    <script src="js/bootstrap2.min.js"></script>


        <%
String uuid = (String)session.getAttribute("uuid");
boolean needStatusUpdate = false;
if(uuid !=null){

%>

    <!-- custom maps markers -->
    <!--<script src="css/fontawesome-markers.min.js"></script>-->



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
        <script src="https://maps.googleapis.com/maps/api/js?v=3.exp&signed_in=true&libraries=places&?key=AIzaSyBpeQ3zGuTunYzxmiNMUltHL352e4beac4"></script>
        <!-- end of google api -->









            <%
            

			HashMap equipmentMap = new HashMap();
			HashMap equipmentMapID = new HashMap();
			HashMap equipmentMapName = new HashMap();
			HashMap mainTruckMap = new HashMap();
			if(true){
				try{
					Class.forName("com.mysql.jdbc.Driver");
					String url = "jdbc:mysql://localhost/test?zeroDateTimeBehavior=convertToNull";		
					Connection connection = DriverManager.getConnection(url,"<USERNAME>", "<PASSWORD>");			
					PreparedStatement ps = connection.prepareStatement("select name, id, isOnline, phone, driver_email from test.trucking_equipment where COMPANY_ID = ? ");
					ps.setString(1, uuid);
					ResultSet resultSet2 = ps.executeQuery();
					while (resultSet2.next()) {
						equipmentMapID.put(resultSet2.getString("phone"),resultSet2.getString("id"));
						equipmentMapID.put(resultSet2.getString("driver_email"),resultSet2.getString("id"));
						equipmentMap.put(resultSet2.getString("phone"),resultSet2.getString("isonline"));
						equipmentMap.put(resultSet2.getString("driver_email"),resultSet2.getString("isonline"));
						equipmentMapName.put(resultSet2.getString("phone"),resultSet2.getString("name"));
						equipmentMapName.put(resultSet2.getString("driver_email"),resultSet2.getString("name"));
					}
	  				connection.close();
		 			}catch (Exception ex){
		     		System.out.println(""+ ex);}
		     	}	
			String searchSql = "";		
			int j = 0;
			

		Class.forName("com.mysql.jdbc.Driver");
		String urldb = "jdbc:mysql://localhost/maids_oltp?user=<USER>&password=<PASSWORD>";			
		Connection connection = DriverManager.getConnection(urldb);


			
			PreparedStatement psMain = connection.prepareStatement("select key_public, phone, f_name, city, zip, state, email, X(location) as city_lat, Y(location) as city_lng from maids_oltp.maids_customers");
            		if(request.getParameter("searchKey")!=null && !request.getParameter("searchKey").equals("")){
				psMain = connection.prepareStatement("select key_public, phone, f_name, city, zip, state, email, X(location) as city_lat, Y(location) as city_lng from maids_oltp.maids_customers where maids_customers.f_name like ? ");
            			psMain.setString(1,"%" + request.getParameter("searchKey") + "%");
            			System.out.println("SEARCH KEY USED");
			}
			ResultSet resultSet = psMain.executeQuery();	
			while (resultSet.next()) {
			//city_lat city_lng
				j =j+1;
				String latLongString = resultSet.getString("state") + " " + resultSet.getString("city");
				String[] dataSet = new String[9];
				dataSet[0]=resultSet.getString("key_public");
				dataSet[1]=resultSet.getString("phone");
				dataSet[2]=resultSet.getString("f_name");
				dataSet[3]="";
				dataSet[4]=resultSet.getFloat("city_lat")+"";
				dataSet[5]=resultSet.getFloat("city_lng")+"";
				dataSet[6]=resultSet.getString("CITY");
				dataSet[7]=resultSet.getString("STATE");
				dataSet[8]=resultSet.getString("email");
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

            <%
            			String locationGoogleMapPinString = "";
 	  			if(true){
				Iterator entries = mainTruckMap.entrySet().iterator();
				while (entries.hasNext()) {
				    Map.Entry entry = (Map.Entry) entries.next();
				    Vector mainTruckLayer = (Vector)entry.getValue();
				    String[] dataSetFirst = (String[])mainTruckLayer.elementAt(0);
					if(equipmentMap.containsKey(dataSetFirst[1]) || equipmentMap.containsKey(dataSetFirst[8])){
				
							String contentString = "";
							locationGoogleMapPinString = locationGoogleMapPinString + "['" + mainTruckLayer.size() + " " + dataSetFirst[0] + "', " + dataSetFirst[4] + ", " + dataSetFirst[5] + " , 'address 1','" + dataSetFirst[0] + "','" + dataSetFirst[6] + "','" + dataSetFirst[7] + "','" +mainTruckLayer.size() + "'],";
						  	
						    for(int k=0;k<mainTruckLayer.size();k++){
							String[] dataSet = (String[])mainTruckLayer.elementAt(k);
							contentString  = contentString +dataSet[2];
							System.out.println(" Value = " + dataSet[0]);
						    }
					}	    
				}
				}%>

        var locations = [
            <%=locationGoogleMapPinString%>
        ['xx', 0, 0, 'address 1','xx','xx','xx','xx']
        ];



        var map ;
        function initialize() {



    var myOptions = {
        center: new google.maps.LatLng(30.8282, -92.5795),
        zoom: 8,
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


    document.getElementById('destCity_lat').value = place2.geometry.location.lat();
    document.getElementById('destCity_lng').value = place2.geometry.location.lng();

    //alert(document.getElementById('destCity_lng').value);

 /*
    var destCityall = (document.getElementById('pac-input2').value);
    var parts2 = destCityall.split(",");

    var destCityv = (document.getElementById('pac-input2').value); // get the city from the submitted form in case it's already split

    var destStatev = ""; //

    if(parts2.length>1){

    destCityv = parts2[0]; // get the city from the submitted form
    destStatev = parts2[1]; // get the state from the submitted form

    document.getElementById('destCity').value = destCityv;
    document.getElementById('destState').value = destStatev;


    if(document.getElementById("pac-input").value != null && document.getElementById("pac-input2").value != null){

    getDistance(document.getElementById("pickCity_lat").value + ',' + document.getElementById("pickCity_lng").value,document.getElementById("destCity_lat").value + ',' + document.getElementById("destCity_lng").value);

    }
    */

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
        var image = 'images/MTBTruck_icon.png';
        var marker3 = new google.maps.Marker({
        map: map, title: countID + " " + city , position: latlngset, icon: image
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
        
	        
        rotater()
        }
        
        function getLinkwithForm(link_file_name, equipmentID){
        var urlString = link_file_name + "&id=" + equipmentID;



        var formF = document.getElementsByTagName("input");
        for(var j = 0; j<formF.length;j++){
        urlString = urlString + "&" + formF[j].name + "=" + encodeURIComponent(formF[j].value);
        }
        //urlString = urlString + "&haulFilter=" +rate_value;
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
	        partialSearchDetail();
        }
        }

        var urlString = "";
        var formF = document.getElementsByTagName("input");
        for(var j = 0; j<formF.length;j++){
        if(formF[j].name!='haulFilter'){
        urlString = urlString + "&" + formF[j].name + "=" + encodeURIComponent(formF[j].value);
        }
        }
        //document.getElementById(startLoc).style.backgroundColor="white";
        //alert(urlString);
        xmlhttp.open("GET", "trucklist-detail_current_gps_to_load.man.jsp?origin=" + encodeURIComponent(startLoc) + "&lat=" + lat +"&long=" + long + urlString,true);
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
        	if(document.getElementById("hideTapBar")!=null){
        		document.getElementById("myTab").style.display = "none";        	
        	}
        }
        }
        var urlString = "";
        var formF = document.getElementsByTagName("input");
        for(var j = 0; j<formF.length;j++){
        if(formF[j].name!='haulFilter'){
        urlString = urlString + "&" + formF[j].name + "=" + encodeURIComponent(formF[j].value);
        }
        }

        xmlhttp.open("GET", "trucklist-trucker-detail.jsp?keyType=CustomerPubKey&id=" + encodeURIComponent(startLoc) + urlString,true);
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
        //document.getElementById("img_Distance").innerHTML = "<img src=\"images/notification_done.png\" width=\"14px\" />";
        //document.getElementById("img_Duration").innerHTML = "<img src=\"images/notification_done.png\" width=\"14px\" />";

        }
        }
        //document.getElementById("img_Distance").innerHTML = "<img src=\"images/notification_error.png\" width=\"14px\" />";
        //document.getElementById("img_Duration").innerHTML = "<img src=\"images/notification_error.png\" width=\"14px\" />";
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
	<script type="text/javascript">
		var itemListLabel ;
		var itemListMain ;
            
		var howOften = 200;
		var doneSetup = 0;
		var foundGps = 0;
  	var urlStringPrev = "";
  	var urlPingStatus = 0;
  	var resultRows = 10;

function rotater() {
        setTimeout("rotater()",howOften*100);
	partialSearch();
//        alert(document.getElementById("embeddedDateField").value);
//	alert('Hello Tick');
}
  	function partialSearch()
  			{
  			
  			partialSearchDetail();
  			
			}
  	function partialSearchDetail()
  			{
  			var xmlhttp;
//  			alert('test');
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
  			    	var containsUpdate = xmlhttp.responseText.split("<ROW>");
  			  	var search_countB = 0;
  				//alert("YOYO " + xmlhttp.responseText);
				for(search_countB = 0;search_countB<parseInt(document.getElementById("rowCountTrucks").value);search_countB++){
					var ecid = "ECID" + search_countB;	
					var ccid = "CCID" + search_countB;
  					//alert("YOYO " + xmlhttp.responseText);
					if(document.getElementById(ecid)!=null)document.getElementById(ccid).innerHTML = containsUpdate[search_countB].split("<FIELD>")[1];
					if(document.getElementById(ccid)!=null)document.getElementById(ecid).innerHTML = containsUpdate[search_countB].split("<FIELD>")[0];
				}
  			    }
  			  }
  			  	var search_count = 0;
  			  	var search_query_detail = "?query=";
  			  	resultRows = parseInt(document.getElementById("rowCountTrucks").value);
				for(search_count = 0;search_count<resultRows;search_count++){
					var eid = "EID" + search_count;	
					var cid = "CID" + search_count;	
					var ecid = "ECID" + search_count;	
					var ccid = "CCID" + search_count;
					var lllat = "LLLAT" + search_count;
					var lllng = "LLLNG" + search_count;
					
					if(document.getElementById(eid)!=null)search_query_detail = search_query_detail + "&eid" + search_count + "=" + document.getElementById(eid).value;
					if(document.getElementById(cid)!=null)search_query_detail = search_query_detail + "&cid" + search_count + "=" + document.getElementById(cid).value;
					if(document.getElementById(lllat)!=null)search_query_detail = search_query_detail + "&lllat" + search_count + "=" + document.getElementById(lllat).value;
					if(document.getElementById(lllng)!=null)search_query_detail = search_query_detail + "&lllng" + search_count + "=" + document.getElementById(lllng).value;
					//document.getElementById(ecid).innerHTML = "-";
					//document.getElementById(ccid).innerHTML = "-";
				}
				search_query_detail = search_query_detail + "&resultRows=" + resultRows;
  				//alert("YOYO" + search_query_detail);	
				xmlhttp.open("POST", "trucklist-detail_current_gps_to_load.subdetails.jsp" ,true);
				xmlhttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
				xmlhttp.send(search_query_detail + "&resultRows=" + resultRows);	
				xmlhttp.send();	
  		}
</script>     

        </head>



        <body onload="initialize()">


<%@include file="nav_menu.jsp" %>


            <br><br><br>
<!-- Main page: -->

            <div class="container-fluid">
            <div class="row">

            <div class="col-md-offset-1 col-sm-11">

            <!-- center search row -->



            <div class="form-group form-group-sm">
            <label class="sr-only" for="exampleInputAmount">SelectForm</label>
            <div class="input-group input-group-md" >
            <div class="input-group-addon" >Sort by City:</div>
		<input type="hidden" name="distance" id="distance" value="<%=NullCheck.check((String)session.getAttribute("distance"))%>" />
		<input type="hidden" name="duration" id="duration" value="<%=NullCheck.check((String)session.getAttribute("duration"))%>" />

     <input type="hidden" name="pickCity_lat" id="pickCity_lat" value="<%=NullCheck.check((String)session.getAttribute("pickCity_lat"))%>" />
     <input type="hidden" name="pickCity_lng" id="pickCity_lng" value="<%=NullCheck.check((String)session.getAttribute("pickCity_lng"))%>" />
     <input type="hidden" name="destCity_lat" id="destCity_lat" value="<%=NullCheck.check((String)session.getAttribute("destCity_lat"))%>" />
     <input type="hidden" name="destCity_lng" id="destCity_lng" value="<%=NullCheck.check((String)session.getAttribute("destCity_lng"))%>" />



     <input type="text" class="form-control" id="pac-input"  name="pac-input" placeholder="City" value="<%=NullCheck.check((String)session.getAttribute("pac-input"))%>" />
            <input type="hidden" class="form-control" id="pac-input2" name="pac-input2" placeholder="Destination City" value="<%=NullCheck.check((String)session.getAttribute("pac-input2"))%>" />
            </div>
            </div>


    <input type='hidden' id="searchKey" name="searchKey" style="font-size: 14px; padding-left: 5px; width: 110px;" class="form-control" placeholder="Search Key" <%if(request.getParameter("searchKey")!=null){%> value="<%=request.getParameter("searchKey")%>"<%}%>>






<!--
        <select id="haulFilter" class="form-control">

        <option class="" name="haulFilter" value="All" <%if(request.getParameter("haulFilter")==null || request.getParameter("haulFilter").equals("All")){%>selected<%}%> >Haul All</option>
        <option class="" name="haulFilter" value="Headhaul"  <%if(request.getParameter("haulFilter")!=null && request.getParameter("haulFilter").equals("Headhaul")){%>selected<%}%> >Head</option>
        <option class="" name="haulFilter" value="Backhaul">Back</option>
        </select>
    -->






    </div> <!-- close the first 12 column -->
    </div> <!-- close the first row -->



    <!-- Main page: -->
    <div class="row">
<hr style="margin-top: 5px; margin-bottom: 5px;">
<!--
    <div class="col-sm-2">
    <strong>Driver Last Location by City</strong>



    <ul class="nav nav-pills nav-stacked">



        <%
	  			if(true){
				Map map = new TreeMap(mainTruckMap);
				Set set2 = map.entrySet();
				Iterator entries = set2.iterator();
				//Iterator entries = mainTruckMap.entrySet().iterator();
				int fool = 0;
				while (entries.hasNext()) {
					fool+=1;
				    Map.Entry entry = (Map.Entry) entries.next();
				    Vector mainTruckLayer = (Vector)entry.getValue();
				    String[] dataSetFirst = (String[])mainTruckLayer.elementAt(0);
					
							%>

    <li><a href="#" onclick="getDistanceTrucks('<%=dataSetFirst[0]%>','<%=dataSetFirst[4]%>','<%=dataSetFirst[5]%>')">
        <%if(NullCheck.check(dataSetFirst[6]).equals("")|| NullCheck.check(dataSetFirst[6]).equals("null")){%>[No City Name]<%}else{%><%=dataSetFirst[6]%>, <%=dataSetFirst[7]%><%}%> (<%=mainTruckLayer.size() %>)</a>

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



    </div>
    -->


    <div class="col-sm-12">

    <!-- column 2 -->

    <!-- center left-->
    <!-- map view -->

    <div class="col-md-7" style="padding-right: 5px; padding-left: 1px;">
    <div class="panel panel-default">

    <div class="panel-body" style="padding: 2px;">

    <div style="float:left;height:340px;width:100%;" id="map-canvas"></div>


    </div>
    </div>
    <!-- end of map biew -->


    </div><!--/col-->


    <div id="defaultDetail" class="col-sm-4" style="max-height: 340px; padding-left: 2px; padding-right: 2px; overflow-y:auto;">

    <!--trucker details - tabs-->




    <!-- tabs-->
	<div class="text-center">
    <h2>MY DRIVERS</h2>
    <h4>REAL-TIME REPORTS</h4>
    <p><small>
Let�s say you are looking for a single report where you can see the current location of every driver, how far away they are from their next scheduled stop and how much time is remaining from now to their next scheduled arrival time. For example John is in Los Angeles now. His next stop is in Pasadena which is 12 miles away from Los Angeles. He is scheduled to arrive there in 1 hour, 45 minutes .     
    </small></p>
    <!--
    <img src="images/appStore.png" width="50%"/>
    -->
    <p>myTruckBoard Driver App <BR> <a href="https://itunes.apple.com/us/app/mytruckboard-driver/id1044398785?mt=8" >more info</a>
    </p>
    
	</div>
    </div><!--/col-span-6-->

    <!--/row-->


    <!-- truck list row starts here -->



    <!-- truckers list view starts here-->

    <div id="defaultdd" style="float:right;width:100%; overflow-y:auto;">
    <h3>START BY ENTERING A CITY NAME ABOVE</h3>
    <h4>Must have linked drivers</h4>
    <h4>Must have load information in dispatch board</h4>
    </div>

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

    <!-- end of if session check -->
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