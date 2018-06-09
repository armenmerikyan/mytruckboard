<%@ page import="org.apache.http.client.fluent.Form,org.apache.http.client.fluent.Request,org.apache.http.client.methods.HttpGet,org.apache.http.Header,org.apache.http.HttpResponse,org.apache.http.NameValuePair,org.apache.http.client.entity.UrlEncodedFormEntity,org.apache.http.message.BasicNameValuePair,org.apache.http.client.methods.HttpPost,org.apache.http.impl.client.DefaultHttpClient,org.apache.http.client.HttpClient,com.big.util.*,java.text.*,java.util.*,java.io.*,javax.xml.parsers.*,org.w3c.dom.*,java.sql.*,java.text.DateFormat" %>


	<ul class="list-group small" id="myTab">
	<li class="active"><a href="#ratehistory" data-toggle="tab">Rate History</a></li>
	<li><a href="#comments" data-toggle="tab">Comments</a></li>
	<li class="" ><a href="#info" data-toggle="tab">Info</a></li>
	</ul>
	<div class="tab-content">


				<%
						String equipment_id = request.getParameter("id");
						String uuid = (String)session.getAttribute("uuid");
	String phone_no = "" ;
	String driver_email = "" ;
	String client_id = "" ;
	String driver_name = "" ;
	String company_name = "" ;
	float driver_direction = -0.01f ;
	String wtg = "";
	String basicNotes = "";
	String specialNotes = "";
	String ratePerMile = "";
	int currentState = 0;
	int currentTruckType = 0;
						 
						if(request.getParameter("keyType")!=null && request.getParameter("keyType").equals("CustomerPubKey")){
						try{
							Class.forName("com.mysql.jdbc.Driver");
							String urldb = "jdbc:mysql://localhost/maids_oltp?user=<USER>&password=<PASSWORD>";			
							Connection connection = DriverManager.getConnection(urldb);			
							PreparedStatement psMain = connection.prepareStatement("select * from maids_oltp.maids_customers where key_public = ? ");
							psMain.setString(1, request.getParameter("id"));
							ResultSet resultSet = psMain.executeQuery();
							while (resultSet.next()) {
								phone_no = resultSet.getString("phone");
								driver_email =  resultSet.getString("email");
								client_id = resultSet.getString("client_id");
								driver_name= NullCheck.check(resultSet.getString("f_name")) + " " + NullCheck.check(resultSet.getString("l_name"));
								company_name =NullCheck.check(resultSet.getString("company_name"));
								driver_direction = resultSet.getFloat("directionCurrent");
								wtg = NullCheck.check(resultSet.getString("wtg"));
								basicNotes = NullCheck.check(resultSet.getString("basicNotes"));
								specialNotes= NullCheck.check(resultSet.getString("specialNotes"));
								ratePerMile = (new DecimalFormat("#.00")).format(resultSet.getFloat("price_per_mile")*.1);
								if(resultSet.getString("current_State")!=null){
									currentState = Integer.parseInt(resultSet.getString("current_State"));
								}
								if(resultSet.getString("currentTruckType")!=null){
									currentTruckType = Integer.parseInt(resultSet.getString("currentTruckType"));
								}
								
							}
							connection.close();		
						 }catch (Exception ex){	         
						     %><%="Error Posting " + ex%><%  
						     System.out.println(""+ ex);
						 }
						 try{
							Class.forName("com.mysql.jdbc.Driver");							
							String url = "jdbc:mysql://localhost/test?zeroDateTimeBehavior=convertToNull";		
							Connection connection = DriverManager.getConnection(url,"<USERNAME>", "<PASSWORD>");
							System.out.println("dETAIL CALLED " + request.getParameter("pickCity_lat"));
							PreparedStatement ps = connection.prepareStatement("select * from test.TRUCKING_EQUIPMENT where (phone = ? or driver_email = ?) and company_id = ? ");
							ps.setString(1, phone_no);
							ps.setString(2, driver_email);	
							ps.setString(3, uuid);						
							ResultSet resultSet = ps.executeQuery();
							while (resultSet.next()) {
								equipment_id = resultSet.getString("id");
							
							}
							connection.close();		
						 }catch (Exception ex){	         
						     %><%="Error Posting " + ex%><%  
						     System.out.println(""+ ex);
						 }						
						}
							boolean isDriverFound=false;
						 try{
						 	
							DateFormat formatter = new SimpleDateFormat("MM-dd-yyyy");
							Class.forName("com.mysql.jdbc.Driver");
							String url = "jdbc:mysql://localhost/test?zeroDateTimeBehavior=convertToNull";		
							
//							Class.forName("com.sap.dbtech.jdbc.DriverSapDB");							
//							String url = "jdbc:sapdb://localhost/BIGDB?sqlmode=ORACLE";
							Connection connection = DriverManager.getConnection(url,"<USERNAME>", "<PASSWORD>");
							System.out.println("dETAIL CALLED " + request.getParameter("pickCity_lat"));
							PreparedStatement ps = connection.prepareStatement("select dot_no, external_id, id, driver_email, NAME, TRAILER, LOAD_TYPE, CITY, STATE, PHONE, ZONE, WTG, FAX, CONTACT_PERSON, LANGUAGE, HOME_CITY, COVERED_BY, DATE_MODIFIED, MC_NO, OWNER_NAME, COMPANY_NAME, ISONLINE, HAUL, TRUCKINFO, COMMENTS, X(city_point) as city_lat, Y(city_point) as city_lng, X(wtg_point) as wtg_lat, Y(wtg_point) as wtg_lng, X(home_point) as home_lat, Y(home_point) as home_lng from test.TRUCKING_EQUIPMENT where ID = ? ");
							ps.setString(1, equipment_id);
							ResultSet resultSet = ps.executeQuery();
							while (resultSet.next()) {
							isDriverFound=true;
							%>


	<div class="tab-pane active" id="ratehistory">
	
	<div class="text-center">
    	<ul class="list-group list-group-xsm">
	<li class="list-group-item list-group-sm <%if(resultSet.getBoolean("isOnline")){%>list-group-item-success<%}else{%>list-group-item-danger<%}%>">
	<h4><span class="badge pull-left"><span class="fa fa-truck"></span></span>
		
		<%if(NullCheck.check(resultSet.getString("CONTACT_PERSON")).equals("")){%>[No Name]<%}else{%>
		<%=NullCheck.check(resultSet.getString("CONTACT_PERSON"))%><%}%>
				<%if(session.getAttribute("isAdmin").equals("true")){%>
			    <a href="javascript:void(0)" onclick="getLinkwithForm('add_rate.jsp?cmd=EditEquipment','<%=resultSet.getString("ID")%>')" >		 		
<span class="badge pull-right" style="background-color:white;"><span class="fa fa-plus" style="color:#3EA055;"></span></span>
		            </a>
				<%}else{%>
			    <a href="javascript:void(0)" onclick="getLinkwithForm('add_comment.jsp?cmd=EditEquipment','<%=resultSet.getString("ID")%>')" >
			    <span class="badge pull-right" style="background-color:white;"><span class="fa fa-edit" style="color:#3EA055;" ></span></span></a>
				<%}%>

	        </h4>
	        </li>


					<%
							if(true){
							//trucking_quote.quote_id = maids_image_load.quote_id where equipment_id = ? order by ts desc 
							ps = connection.prepareStatement("select count(quote_id) as coutID from test.trucking_quote where equipment_id = ? order by ts desc");
							ps.setString(1, equipment_id);
							ResultSet resultSetCount = ps.executeQuery();
							while (resultSetCount.next()) {	
								%><ul class="list-group list-group-sm">
	<li class="list-group-item">TOTAL OFFERS
	<span class="badge pull-right" style="background-color:white;color:black;" ><%=resultSetCount.getString("coutID")%></span>
	</li><%
							}
							}							
							if(true){
							//trucking_quote.quote_id = maids_image_load.quote_id where equipment_id = ? order by ts desc 
							ps = connection.prepareStatement("select count(quote_id) as coutID from test.trucking_quote where equipment_id = ? and reject_status = 'Rejected' order by ts desc");
							ps.setString(1, equipment_id);
							ResultSet resultSetCount = ps.executeQuery();
							while (resultSetCount.next()) {	
								%><li class="list-group-item">REJECTED
								<span class="badge pull-right"  style="background-color:white;color:black;"><%=resultSetCount.getString("coutID")%></span>
								</li><%
							}
							}							
							if(true){
							//trucking_quote.quote_id = maids_image_load.quote_id where equipment_id = ? order by ts desc 
							ps = connection.prepareStatement("select count(quote_id) as coutID from test.trucking_quote where equipment_id = ? and status = 'Call Back' order by ts desc");
							ps.setString(1, equipment_id);
							ResultSet resultSetCount = ps.executeQuery();
							while (resultSetCount.next()) {	
								%><li class="list-group-item">
								CALL BACK
								<span class="badge pull-right"  style="background-color:white;color:black;"><%=resultSetCount.getString("coutID")%></span>
								</li>
								<%
							}
							}	
							
							if(true){
							//trucking_quote.quote_id = maids_image_load.quote_id where equipment_id = ? order by ts desc 
							ps = connection.prepareStatement("select count(quote_id) as coutID from test.trucking_quote where equipment_id = ? and accept_status = 'Accepted' order by ts desc");
							ps.setString(1, equipment_id);
							ResultSet resultSetCount = ps.executeQuery();
							while (resultSetCount.next()) {	
								%><li class="list-group-item">ACCEPTED
								<span class="badge pull-right"  style="background-color:white;color:black;"><%=resultSetCount.getString("coutID")%></span>
								</li>
								<%
							}
							}							
							if(true){
							int rate = 0 ;
							int rateHigh = 0 ;
							int rateLow = 0 ;
							int rateCount = 0 ;
							PreparedStatement psQ = connection.prepareStatement("select wtg, image_load_id, drop_date, id, TRAILER, name, equipment_id, phone, owner_name, trucking_quote.ts, user_id, miscel_pay, miles, rate, truck_mpg, driver_pay_mpg, avg_diesel, status, pickCity, pickState, destCity, destState, (GLength(LineStringFromWKB(LineString(pickCityLocation, GeomFromText('POINT(" + request.getParameter("pickCity_lat") + " " + request.getParameter("pickCity_lng") + ")'))))) AS distanceFromPickCity, (GLength(LineStringFromWKB(LineString(pickCityLocation, GeomFromText('POINT(" + request.getParameter("destCity_lat") + " " + request.getParameter("destCity_lng") + ")'))))) AS distanceFromDestCity, (GLength(LineStringFromWKB(LineString(destCityLocation, GeomFromText('POINT(" + request.getParameter("pickCity_lat") + " " + request.getParameter("pickCity_lng") + ")'))))) AS ddistanceFromPickCity, (GLength(LineStringFromWKB(LineString(destCityLocation, GeomFromText('POINT(" + request.getParameter("destCity_lat") + " " + request.getParameter("destCity_lng") + ")'))))) AS ddistanceFromDestCity  from test.trucking_quote LEFT JOIN test.TRUCKING_EQUIPMENT ON TRUCKING_EQUIPMENT.id = trucking_quote.equipment_id LEFT JOIN maids_image_load ON trucking_quote.quote_id = maids_image_load.quote_id where trucking_quote.equipment_id = ? and accept_status = 'Accepted' order by ts desc limit 500");							
							psQ.setString(1, equipment_id);
							ResultSet resultSetQ = psQ.executeQuery();
							DecimalFormat df = new DecimalFormat("#.#");
							while (resultSetQ.next()) {							
								%>
								<%
								
								if(resultSetQ.getString("distanceFromPickCity")!=null && resultSetQ.getString("ddistanceFromDestCity")!=null && (Float.parseFloat(resultSetQ.getString("distanceFromPickCity")) * 62.1371) < 50 && (Float.parseFloat(resultSetQ.getString("ddistanceFromDestCity")) * 62.1371) < 50){%>
								<%
								rate = rate + resultSetQ.getInt("rate") + 1;%>
								<%rateCount = rateCount+ 1;%>
								<%if(resultSetQ.getInt("rate")>rateHigh){%><%rateHigh=resultSetQ.getInt("rate");%><%}%>
								<%if(rateLow==0){%><%rateLow=resultSetQ.getInt("rate");%><%}%>
								<%if(resultSetQ.getInt("rate")<rateLow){%><%rateLow=resultSetQ.getInt("rate");%><%}%>
								<%
								}
								%>								
								<%								
							}
							if(rateCount!=0){%>
							<li class="list-group-item"><large>&nbsp;</large>
							<large class="pull-left"><strong><%=rateCount%></strong> <small>trips</small> AT <strong>$<%=rate/rateCount%></strong><small> avg</small> <strong>$<%=rate%></strong><small> total</small>
							</large>
							<span class="badge pull-right" style="background-color:#3EA055;color:white;"><span class="fa fa-usd" style="color:white;" ></span><%=rateHigh%><small> max</small></span>
							<span class="badge pull-right" style="background-color:orange;color:white;"><span class="fa fa-usd" style="color:white;" ></span><%=rateLow%><small> min</small></span>
							</li>
							<%}
							}	
							%>
	</ul>


    </div>
    </div>

    <div class="tab-pane" id="comments">
	<div class="text-center">
    
    	<ul class="list-group list-group-sm">
	<li class="list-group-item list-group-item-info">
    <h4><span class="badge pull-left"><span class="fa fa-user"></span></span>

 <%if(NullCheck.check(resultSet.getString("CONTACT_PERSON")).equals("")){%>[No Name]<%}else{%><%=NullCheck.check(resultSet.getString("CONTACT_PERSON"))%><%}%>
                                <%if(session.getAttribute("isAdmin").equals("true")){%>
                            <a href="javascript:void(0)" onclick="getLinkwithForm('edit_truck.jsp?starter=nutthin','<%=resultSet.getString("ID")%>')" >
                            <span class="badge pull-right" style="background-color:white;"><span class="fa fa-edit" style="color:#3EA055;" ></span></span>
                            </a>
                                <%}else{%>
                            <a href="javascript:void(0)" onclick="getLinkwithForm('add_comment.jsp?cmd=EditEquipment','<%=resultSet.getString("ID")%>')" >
                            <span class="badge pull-right" style="background-color:white;"><span class="fa fa-edit" style="color:#3EA055;" ></span></span>
                            </a>
                                <%}%>

                            </h4></li>
	
<li class="list-group-item">
							<h4>Comments</h4>
							<p><%=NullCheck.check(resultSet.getString("COMMENTS"))%> </li>
</ul>
	</div>
	</div>


	<div class="tab-pane" id="info">
	<div class="text-center">
    	<ul class="list-group list-group-sm">
	<li class="list-group-item list-group-item-info">
	<h4><span class="badge pull-left"><span class="fa fa-user"></span></span>


	<%if(NullCheck.check(resultSet.getString("CONTACT_PERSON")).equals("")){%>[No Name]<%}else{%>
	<%=NullCheck.check(resultSet.getString("CONTACT_PERSON"))%><%}%>
		<%if(session.getAttribute("isAdmin").equals("true")){%>
	<a href="javascript:void(0)" onclick="getLinkwithForm('edit_truck.jsp?starter=nutthin','<%=resultSet.getString("ID")%>')" >
                            <span class="badge pull-right" style="background-color:white;"><span class="fa fa-edit" style="color:#3EA055;" ></span></span>
	</a>
		<%}else{%>
	<a href="javascript:void(0)" onclick="getLinkwithForm('add_comment.jsp?cmd=EditEquipment','<%=resultSet.getString("ID")%>')" >
                            <span class="badge pull-right" style="background-color:white;"><span class="fa fa-edit" style="color:#3EA055;" ></span></span>
	</a>
		<%}%>

	</h4></li>
	
							<li class="list-group-item">

	<h4>Info</h4>
	<%=NullCheck.check(resultSet.getString("TRUCKINFO"))%> </li>
								<%
		
	
							}
							DateFormat formatterFull = new SimpleDateFormat("MM-dd-yyyy HH:mm:ss");
							
							ps = connection.prepareStatement("select * from test.trucking_comment_history where equipment_id = ? order by ts desc");
							ps.setString(1, equipment_id);
							resultSet = ps.executeQuery();
							
							while (resultSet.next()) {
							%><!--<li class="list-group-item">
							<%=NullCheck.check(resultSet.getString("comment"))%><BR><small>
							<%=formatterFull.format(resultSet.getTimestamp("TS"))%>	
							<%=resultSet.getString("CREATED_BY")%></small></li>
							-->
							<%
							}
							connection.close();								
						 }catch (Exception ex){	         
						     %><%="Error Posting " + ex%><%  
						     System.out.println(""+ ex);
						 }	
	%>
		</ul>
	</div>
	<%					 
						if(!client_id.equals("")){
						 %>
						 <!--
	<div class="text-center">
						 <img src="../AAA/getImageService.byCustomer.pub.id.jsp?client_id=<%=request.getParameter("id")%>" width="40%" style="float:left;"/><BR>
	</div>					 
						-->
						 <%
						 }
							if(!isDriverFound){
								%>	
	<input type="hidden" name="hideTapBar" id="hideTapBar"  value="true" />
	<div class="text-center">
	<ul class="list-group">
	<li class="list-group-item list-group-item-info">
	<%	String[] driver_state = {"OFFLINE", "SLEEPING", "RESTING", "DRIVING", "ONLINE"};%>
	<%	String[] current_truck_type = {"DRY VAN TRUCK", "FLATBED TRUCK", "REEFER TRUCK", "BOX TRUCK", "CAR CARRIER TRUCK"};%>
	
	 <%if(!driver_name.trim().equals("")){%><%=driver_name%><%
	 }else{%>[No Name]<%}%>	 <B>[<%=driver_state[currentState]%>]</B> <%=current_truck_type[currentTruckType]%>
    <span class="badge pull-left"><span class="glyphicon glyphicon-user" aria-hidden="true" ></span></span>
	 		</li> 	
		<li class="list-group-item" style="background-color:gray;color:white;">	
                                <span class="badge pull-left"><span class="glyphicon glyphicon-link fa-lg" aria-hidden="true" style="color:white;">
				</span></span>
				<a href="add_truck.jsp?phone_no=<%=phone_no%>&driver_email=<%=driver_email%>&driverName=<%=driver_name%>&companyName=<%=company_name%>" >
				<span class="badge pull-right" style="background-color:white;color:#3EA055;"><small> <small> LINK</small></small>
				<span class="glyphicon glyphicon-plus fa-lg" aria-hidden="true" style="color:#3EA055;"></span></span>
				</a>
                                &nbsp;
	 <%if(!company_name.equals("")){%><%=company_name%><%}else{%>[No Company Name]<%}%>
		</li> 	
		<li class="list-group-item">	
						<%if(phone_no.length()<15){%><%=phone_no%><%}else{%>none<%}%>
		
    <span class="badge pull-left"><span class="glyphicon glyphicon-phone" aria-hidden="true" ></span></span></li> 	
		<li class="list-group-item">	
			<%=driver_email%>
          
    <span class="badge pull-left"><span class="glyphicon glyphicon-envelope" aria-hidden="true" ></span></span>                      
</li>  
<!--
         <li class="list-group-item">
                                <%if(session.getAttribute("isAdmin").equals("true")){%>
                                <strong><a href="add_truck.jsp?phone_no=<%=phone_no%>&driver_email=<%=driver_email%>" >
                                <span class="glyphicon glyphicon-plus" aria-hidden="true" >Add</span> 
                                Add Driver</a></stronge>
                                <%}%></li>    -->                            
	
								<%	
							}

						if(!client_id.equals("")){							
						try{				
							Class.forName("com.mysql.jdbc.Driver");
							String urldb = "jdbc:mysql://localhost/maids_oltp?user=<USER>&password=<PASSWORD>";			
							Connection connection = DriverManager.getConnection(urldb);			
							PreparedStatement psMain = connection.prepareStatement("select count(archive_id) as itemCount  from maids_oltp.customer_location_archive where client_id = ? ");
							psMain.setString(1, client_id);
							ResultSet resultSet = psMain.executeQuery();
							int totalCountDelivered = 0;
							while (resultSet.next()) {
								totalCountDelivered = resultSet.getInt("itemCount");							
							}
							psMain = connection.prepareStatement("select  SUM(speedCurrent)/count(speedCurrent) AS itemCount from maids_oltp.customer_location_archive where client_id = ? and speedCurrent > 1");
							psMain.setString(1, client_id);
							resultSet = psMain.executeQuery();
							int averageSpeed = 0;
							while (resultSet.next()) {
								averageSpeed = resultSet.getInt("itemCount");							
							}
							psMain = connection.prepareStatement("select  max(speedCurrent) AS itemCount from maids_oltp.customer_location_archive where client_id = ? and speedCurrent > 1");
							psMain.setString(1, client_id);
							resultSet = psMain.executeQuery();
							int maxSpeed = 0;
							while (resultSet.next()) {
								maxSpeed = resultSet.getInt("itemCount");							
							}
							%>
							

							<%
							if(totalCountDelivered>0){%>
							
	<li class="list-group-item">
	<span class="badge pull-left"><span class="glyphicon glyphicon-flag" aria-hidden="true" > </span></span>
	<span class="pull-left"> &nbsp;LOCATION HISTORY</span>&nbsp;
	<span class="badge pull-right" style="background-color:white;color:black;"><%=totalCountDelivered%></span></li>
	<%}%>

		<%if(ratePerMile!=null && !ratePerMile.equals("")){%>
	<li class="list-group-item">
	<span class="badge pull-left"><span class="glyphicon glyphicon-usd" aria-hidden="true" > </span></span>
	<span class="pull-left"> &nbsp;Rate Per Mile </span>&nbsp;
	<span class="badge pull-right" style="background-color:white;color:black;">$<%=ratePerMile%><small> per mile.</small></span></li>
	</li>
		<%}%>
		<%if(basicNotes!=null || !basicNotes.equals("")){%>
	<li class="list-group-item">
	<span class="badge pull-left"><span class="glyphicon glyphicon-pencil" aria-hidden="true" > </span></span>
	<span class="pull-left"> &nbsp;Notes</span>&nbsp;
	<span class="pull-right" style="background-color:white;color:black;"> <%=NullCheck.check(basicNotes)%></span></li>
	</li>
		<%}%>	
		<%if(specialNotes!=null || !specialNotes.equals("")){%>
	<li class="list-group-item">
	<span class="badge pull-left"><span class="glyphicon glyphicon-pencil" aria-hidden="true" > </span></span>
	<span class="pull-left"> &nbsp;Special Notes</span>&nbsp;
	<span class="pull-right" style="background-color:white;color:black;"> <%=NullCheck.check(specialNotes)%></span></li>
	</li>
		<%}%>	
		<%if(wtg!=null || !wtg.equals("")){%>
	<li class="list-group-item">
	<span class="badge pull-left"><span class="glyphicon glyphicon-flag" aria-hidden="true" > </span></span>
	<span class="pull-left"> &nbsp;WANTS TO GO TO</span>&nbsp;
	<span class="pull-right" style="background-color:white;color:black;"> <%=NullCheck.check(wtg)%></span></li>
	</li>
		<%}%>
							<%if(averageSpeed>0){%>
	<li class="list-group-item">
	<span class="badge pull-left"><span class="glyphicon glyphicon-dashboard" aria-hidden="true" > </span></span>
	<span class="pull-left"> &nbsp;AVERAGE SPEED</span>&nbsp;
	<span class="badge pull-right" style="background-color:white;color:black;"><%=averageSpeed%><small> mph.</small></span>
	</li>
	<%}
							if(maxSpeed>0){%> 
							
	<li class="list-group-item">
	<span class="badge pull-left"><span class="glyphicon glyphicon-dashboard" aria-hidden="true" > </span></span>
	<span class="pull-left"> &nbsp;MAXIMUM SPEED</span>&nbsp;
	<span class="badge pull-right" style="background-color:white;color:black;"><%=maxSpeed%><small> mph.</small></span></li><%}%>
	<%
String directions[] = {"NORTH", "NORTHEAST", "EAST", "SOUTHEAST", "SOUTH", "SOUTHWEST", "WEST", "NORTHWEST", "NORTH"};
String dierctionText  =  directions[ (int)Math.round((  ((double)driver_direction % 360) / 45)) ];
if(driver_direction>0.0f){
%>
	<li class="list-group-item">
	<span class="badge pull-left" ><span class="glyphicon glyphicon-road" aria-hidden="true" > </span></span>
	<span class="pull-left" > &nbsp;Heading Towards</span>&nbsp;
	<span class="badge pull-right" style="background-color:white;color:black;"><%=dierctionText%></span></li><%}%>
	</ul>
							<%
							
						 }catch (Exception ex){	         
						     %><%="Error Posting " + ex%><%  
						     System.out.println(""+ ex);
						 }	
							}
	         
						%>
                        </div>
                        </div>
                        </div>