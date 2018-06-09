<%@ page import="org.apache.http.client.fluent.Form,org.apache.http.client.fluent.Request,org.apache.http.client.methods.HttpGet,org.apache.http.Header,org.apache.http.HttpResponse,org.apache.http.NameValuePair,org.apache.http.client.entity.UrlEncodedFormEntity,org.apache.http.message.BasicNameValuePair,org.apache.http.client.methods.HttpPost,org.apache.http.impl.client.DefaultHttpClient,org.apache.http.client.HttpClient,com.big.util.*,java.text.*,java.util.*,java.io.*,javax.xml.parsers.*,org.w3c.dom.*,java.sql.*,java.text.DateFormat" %>



				<%
						String equipment_id = request.getParameter("id");
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
						 
						try{
							Class.forName("com.mysql.jdbc.Driver");
							String urldb = "jdbc:mysql://localhost/maids_oltp?user=<USER>&password=<PASSWORD>";			
							Connection connection = DriverManager.getConnection(urldb);	
							
							
							
							PreparedStatement psMain = connection.prepareStatement("select * from maids_oltp.maids_customers where key_public = ? ");
							psMain.setString(1, request.getParameter("equipmentID"));
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
						 					
						
						%>

	
	<li class="list-group-item" style="background-image: url('http://nuculeus.io/io/image.jsp?imageTypeFormat=landscape&imageType=1024&userid=b2d4402b-4f95-4cdb-bb0b-ac4440aac2b9');background-size: cover;">
	<div class="text-center">
						 <a href="truck_board_public_driver.jsp?equipmentID=<%=request.getParameter("equipmentID")%>"><img src="../AAA/getImageService.byCustomer.pub.id.jsp?client_id=<%=request.getParameter("equipmentID")%>" style="border-bottom: thick solid orange;" width="30%" /></a><BR>
						 <a href="truck_board_public_driver.jsp?equipmentID=<%=request.getParameter("equipmentID")%>"><button type="button" class="btn btn-default"  style="width:30%;"  >Learn More</button></a>
	</div>	
	
</li>
	<li class="list-group-item list-group-item-warning">	
	<h4 class="text-center" >
	 <%if(!driver_name.trim().equals("")){%><%=driver_name%><%
	 }else{%>[No Name]<%}%></h4>
	 		</li> 
		<li class="list-group-item" style="background-color:gray;color:white;">	
				&nbsp;
	 <%if(!company_name.equals("")){%><%=company_name%><%}else{%>[No Company Name]<%}%>
		</li> 	
	
	<li class="list-group-item">
	<%	String[] driver_state = {"OFFLINE", "SLEEPING", "RESTING", "DRIVING", "ONLINE"};%>
	
	 		
	<%	String[] current_truck_type = {"DRY VAN TRUCK", "FLATBED TRUCK", "REEFER TRUCK", "BOX TRUCK", "CAR CARRIER TRUCK"};%>
	<div class="text-center">
	<%=current_truck_type[currentTruckType]%>
	
	  <B>DRIVER IS</B> <%=driver_state[currentState]%>
	</div>
	 		</li>		
		<li class="list-group-item">	&nbsp;
						<%if(phone_no.length()<15){%><%=phone_no%><%}else{%>none<%}%>
		
    <span class="badge pull-left"><span class="glyphicon glyphicon-phone" aria-hidden="true" ></span></span></li> 	
		<li class="list-group-item">	&nbsp;
			<%=driver_email%>
          
    <span class="badge pull-left"><span class="glyphicon glyphicon-envelope" aria-hidden="true" ></span></span>                      
</li> 	 	 

		<%if(basicNotes!=null || !basicNotes.equals("")){%>
	<li class="list-group-item">
	<span class="badge pull-left"><span class="glyphicon glyphicon-pencil" aria-hidden="true" > </span></span>
	<span class="pull-left"> &nbsp;Notes?</span>&nbsp;
	<span class="pull-right" style="background-color:white;color:black;"> <%=NullCheck.check(basicNotes)%></span></li>
	</li>
		<%}%>	
		<%if(specialNotes!=null || !specialNotes.equals("")){%>
	<li class="list-group-item">
	<span class="badge pull-left"><span class="glyphicon glyphicon-pencil" aria-hidden="true" > </span></span>
	<span class="pull-left"> &nbsp;Special Notes?</span>&nbsp;
	<span class="pull-right" style="background-color:white;color:black;"> <%=NullCheck.check(specialNotes)%></span></li>
	</li>
		<%}%>	
		<%if(wtg!=null || !wtg.equals("")){%>
	<li class="list-group-item">
	<span class="badge pull-left"><span class="glyphicon glyphicon-flag" aria-hidden="true" > </span></span>
	<span class="pull-left"> &nbsp;WANTS TO GO TO?</span>&nbsp;
	<span class="pull-right" style="background-color:white;color:black;"> <%=NullCheck.check(wtg)%></span></li>
	</li>
		<%}%>	