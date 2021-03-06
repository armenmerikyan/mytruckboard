<%@ page import="com.big.util.*,java.text.*,java.util.*,java.io.*,javax.xml.parsers.*,org.w3c.dom.*,java.sql.*,java.text.DateFormat" %>


    <table class="table table-hover table-striped">
    <thead>
    <tr>
    <th><span class="glyphicon glyphicon-link" aria-hidden="true" ></span></th>
    <th><span class="glyphicon glyphicon-user" aria-hidden="true" ></span> Name</th>
    <th><span class="glyphicon glyphicon-phone" aria-hidden="true" ></span> Phone</th>
    <th><span class="glyphicon glyphicon-envelope" aria-hidden="true" ></span> Email</th>
    <th><span class="glyphicon glyphicon-globe" aria-hidden="true" ></span> Location</th>
    <th><span class="glyphicon glyphicon-road" aria-hidden="true" ></span> Distance</th>
    <th><span class="glyphicon glyphicon-dashboard" aria-hidden="true" ></span>  Speed</th>
    <th><span class="glyphicon glyphicon-calendar" aria-hidden="true" ></span> Date Modified</th>
    </tr>
    </thead>
    <tbody>


			<%
			HashMap equipmentMap = new HashMap();
			String uuid = (String)session.getAttribute("uuid");
			try{
					Class.forName("com.mysql.jdbc.Driver");
					String url = "jdbc:mysql://localhost/test?zeroDateTimeBehavior=convertToNull";		
					Connection connection = DriverManager.getConnection(url,"<USERNAME>", "<PASSWORD>");			
					PreparedStatement ps = connection.prepareStatement("select isOnline, phone, driver_email from test.TRUCKING_EQUIPMENT where COMPANY_ID = ? ");
					ps.setString(1, uuid);
					ResultSet resultSet2 = ps.executeQuery();
					while (resultSet2.next()) {
						equipmentMap.put(resultSet2.getString("phone"),resultSet2.getString("isonline"));
						equipmentMap.put(resultSet2.getString("driver_email"),resultSet2.getString("isonline"));
					}
	  				connection.close();
		 			}catch (Exception ex){
		     		%><%="Error Posting " + ex%><%
		     		System.out.println(""+ ex);}
			try{
			String searchSql = "";
		Class.forName("com.mysql.jdbc.Driver");
		String urldb = "jdbc:mysql://localhost/maids_oltp?user=<USER>&password=<PASSWORD>";			
		Connection connection = DriverManager.getConnection(urldb);


				HashMap mainTruckMap = new HashMap();
				DateFormat formatter = new SimpleDateFormat("MM/dd/yyyy.HH.mm.ss");			
			String pickCity_lng = request.getParameter("long");
			String pickCity_lat = request.getParameter("lat");
			
			PreparedStatement psMain = connection.prepareStatement("select producttype, email, ts_last_update, speedcurrent, ts, key_public, phone, f_name, city, zip, state, email, X(location) as city_lat, Y(location) as city_lng , (GLength(LineStringFromWKB(LineString(location, GeomFromText('POINT(" + pickCity_lat + " " + pickCity_lng + ")'))))) AS distanceFromPickCity from maids_oltp.maids_customers where maids_customers.is_Not_Test_account is null and producttype is null order by distanceFromPickCity ");
            		if(request.getParameter("searchKey")!=null && !request.getParameter("searchKey").equals("")){
				psMain = connection.prepareStatement("select producttype, email, ts_last_update, speedcurrent, ts, key_public, phone, f_name, city, zip, state, email, X(location) as city_lat, Y(location) as city_lng, (GLength(LineStringFromWKB(LineString(location, GeomFromText('POINT(" + pickCity_lat + " " + pickCity_lng + ")'))))) AS distanceFromPickCity from maids_oltp.maids_customers where maids_customers.f_name like ? and maids_customers.is_Not_Test_account is null and producttype is null order by distanceFromPickCity ");
            			psMain.setString(1,"%" + request.getParameter("searchKey") + "%");
			}
			
			ResultSet resultSet = psMain.executeQuery();
			int j = 1;
			while (resultSet.next()) {
						if(resultSet.getString("distanceFromPickCity")!=null ){
						j +=1;
			//city_lat city_lng
			
				String latLongString = resultSet.getFloat("city_lat") + " " + resultSet.getFloat("city_lng");
				String[] dataSet = new String[10];
				dataSet[0]=resultSet.getString("key_public");
				dataSet[1]="";
				dataSet[2]=resultSet.getString("f_name");
				dataSet[3]="";		
				dataSet[4]=resultSet.getFloat("city_lat")+"";		
				dataSet[5]=resultSet.getFloat("city_lng")+"";	
				dataSet[6]=resultSet.getString("CITY")+"";		
				dataSet[7]=resultSet.getString("STATE")+"";		
				dataSet[8]=resultSet.getString("speedcurrent")+"";
				dataSet[9]=resultSet.getString("email")+"";		
				
				System.out.println("EXECUTED DETAIL" + resultSet.getString("CITY"));
				%>



				<tr>
				<td>
				<% int isRed = 0;%>
				<%if(equipmentMap.containsKey(resultSet.getString("phone"))){%>
				  <%if(((String)equipmentMap.get(resultSet.getString("phone")))== null){%>
				  <%}else if(((String)equipmentMap.get(resultSet.getString("phone"))).equals("0")){
				  	isRed = 1;
				  %>
				  <%} else if(((String)equipmentMap.get(resultSet.getString("phone"))).equals("1") && isRed !=1){
				  	isRed = 2;
				  %>
				  <%}%>				  
				  <%}%>	
				<%if(equipmentMap.containsKey(resultSet.getString("email"))){%>
				  <%if(((String)equipmentMap.get(resultSet.getString("email")))== null && isRed !=1){%>
				  <%}else if(((String)equipmentMap.get(resultSet.getString("email"))).equals("0") && isRed !=1){
					  isRed = 1;				 
					%>
				  <%} else if(((String)equipmentMap.get(resultSet.getString("email"))).equals("1") && isRed !=1){
				   	isRed = 2;				 
				  %>
				  <%}%>				  
				  <%}%>	
				<%if(isRed == 1){%>		
					<span class="glyphicon glyphicon-link" aria-hidden="true" style="color:red;"></span>
				  <%}else if (isRed==2){%>	
				  <span class="glyphicon glyphicon-link" aria-hidden="true" style="color:green;"></span>
				  <%}%>
				</td>
				<td><a href="#" onclick="getDetail('<%=NullCheck.check(resultSet.getString("key_public"))%>')">				
				<%if(NullCheck.check(resultSet.getString("f_name")).equals("")){%>[No Name]<%}else{%><%=resultSet.getString("f_name")%><%}%></a>
				</td>
				<td><%if(!resultSet.getString("phone").equals("") && resultSet.getString("phone").length()<15){%><%=resultSet.getString("phone")%><%}else{%>-<%}%>
			
				</td>
				<td><%if(resultSet.getString("email").length()>3){%><%=resultSet.getString("email")%><%}else{%>none<%}%>			
				</td>
				<td><%=NullCheck.check(resultSet.getString("CITY"))%>, <%=NullCheck.check(resultSet.getString("STATE"))%></td>
				<% DecimalFormat format=new DecimalFormat("####.0");%>
				<td align="right">
						<%if(resultSet.getString("distanceFromPickCity")!=null && Float.parseFloat(resultSet.getString("distanceFromPickCity"))* 62.1371>.1){%>
						<%=format.format(Float.parseFloat(resultSet.getString("distanceFromPickCity")) * 62.1371)%>
						<small>miles</small>
						<%}else{%>
						-
						<%}%>
						
				</td>	
				<td align="right">
						<%if(resultSet.getString("speedcurrent")!=null && resultSet.getFloat("speedcurrent")>0){%>
						<%=format.format(resultSet.getFloat("speedcurrent"))%>
						<small>mph.</small>
						<%}else{%>
						-
						<%}%>
				</td>							
				<td align="right">			
				
					<%if(resultSet.getTimestamp("ts_last_update")!=null){%>
								<%
												Calendar cal = Calendar.getInstance();
												java.util.Date expireDate = cal.getTime();
												java.util.Date jDate = new java.util.Date(resultSet.getTimestamp("ts_last_update").getTime());
												Calendar jcal=Calendar.getInstance();
												jcal.setTime(jDate);
												jcal.add(Calendar.DAY_OF_MONTH, 2);
												%>
								<%if(cal.before(jcal)) {%>
								<font color="blue"> <%=new SimpleDateFormat("MM-dd HH:mm").format(resultSet.getTimestamp("ts_last_update").getTime())%></font>
								<%}else{%>
								<font color="orange"> <%=new SimpleDateFormat("MM-dd HH:mm").format(resultSet.getTimestamp("ts_last_update").getTime())%></font>
								<%}%>
								
					<%}else{%>
						<%=new SimpleDateFormat("MM-dd").format(resultSet.getDate("ts"))%>
					<%}%>
				</td>
				<!--
				<td width="50px"><img src="../AAA/getImageService.byCustomer.pub.id.jsp?client_id=<%=resultSet.getString("key_public")%>" width="100%" /></td>
				-->
				</tr>

				<%
						}
	  		}


	  				connection.close();
		 			}catch (Exception ex){
		     		%><%="Error Posting " + ex%><%
		     		System.out.println(""+ ex);}
				%>



    </tbody>
    </table>