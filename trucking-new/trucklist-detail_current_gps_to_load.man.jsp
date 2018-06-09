<%@ page import="com.big.util.*,java.text.*,java.util.*,java.io.*,javax.xml.parsers.*,org.w3c.dom.*,java.sql.*,java.text.DateFormat" %>


    <table class="table table-hover table-striped">
    <thead>
    <tr>
    <th><span class="glyphicon glyphicon-mail" aria-hidden="true" ></span> Email</th>
    <th><span class="glyphicon glyphicon-user" aria-hidden="true" ></span> Driver</th>
    <th><span class="glyphicon glyphicon-phone" aria-hidden="true" ></span> Phone</th>
    <th><span class="glyphicon glyphicon-calendar" aria-hidden="true" ></span> Date</th>
    <th><span class="glyphicon glyphicon-road" aria-hidden="true" ></span> Distance</th>  
    <th><span class="glyphicon glyphicon-triangle-left" aria-hidden="true" ></span> Previous Scheduled Stop</th>
    <th><span class="glyphicon glyphicon-triangle-bottom" aria-hidden="true" ></span> Location</th>
    <th><span class="glyphicon glyphicon-triangle-right" aria-hidden="true" ></span> Next Scheduled Stop</th>
    
    </tr>
    </thead>
    <tbody>


			<%
			
			String uuid = (String)session.getAttribute("uuid");
			
			try{
			String searchSql = "";

				DateFormat formatter = new SimpleDateFormat("MM/dd/yyyy.HH.mm.ss");			
			String pickCity_lng = request.getParameter("long");
			String pickCity_lat = request.getParameter("lat");
					Class.forName("com.mysql.jdbc.Driver");
					String url = "jdbc:mysql://localhost/test?zeroDateTimeBehavior=convertToNull";		
					Connection connection = DriverManager.getConnection(url,"<USERNAME>", "<PASSWORD>");			
					PreparedStatement ps = connection.prepareStatement("select contact_person, currentCheckIndate, currentCity, currentState, X(currentCity_point) as city_lat, Y(currentCity_point) as city_lng , (GLength(LineStringFromWKB(LineString(currentCity_point, GeomFromText('POINT(" + pickCity_lat + " " + pickCity_lng + ")'))))) AS distanceFromPickCity, name, id, isOnline, phone, driver_email from test.TRUCKING_EQUIPMENT where COMPANY_ID = ? ");
					ps.setString(1, uuid);

			
			ResultSet resultSet = ps.executeQuery();
			int j = 1;
			while (resultSet.next()) {
						if(resultSet.getString("distanceFromPickCity")!=null ){
						j +=1;
			//city_lat city_lng
			
				String latLongString = resultSet.getFloat("city_lat") + " " + resultSet.getFloat("city_lng");
				String[] dataSet = new String[10];
				dataSet[0]=resultSet.getString("id");
				dataSet[1]="";
				dataSet[2]=resultSet.getString("name");
				dataSet[3]="";		
				dataSet[4]=resultSet.getFloat("city_lat")+"";		
				dataSet[5]=resultSet.getFloat("city_lng")+"";	
				dataSet[6]=resultSet.getString("currentcity")+"";		
				dataSet[7]=resultSet.getString("currentState")+"";		
				dataSet[8]="";
				dataSet[9]=resultSet.getString("driver_email")+"";		
				%>
					<input name="EID<%=j%>"  id="EID<%=j%>" value="<%=resultSet.getString("id")%>" type="hidden" />
					<input name="CID<%=j%>"  id="CID<%=j%>" value="<%=resultSet.getString("id")%>" type="hidden" />

					<input name="LLLAT<%=j%>"  id="LLLAT<%=j%>" value="<%=resultSet.getString("city_Lat")%>" type="hidden" />
					<input name="LLLNG<%=j%>"  id="LLLNG<%=j%>" value="<%=resultSet.getString("city_Lng")%>" type="hidden" />
				<tr>


				<TD>
					<%=resultSet.getString("driver_email")%>
				</TD>
				<td><a href="#" onclick="getDetail('<%=NullCheck.check(resultSet.getString("id"))%>')">				
				<%if(NullCheck.check(resultSet.getString("contact_person")).equals("")){%>[No Name]<%}else{%><%=resultSet.getString("contact_person")%><%}%></a>
				</td>
				
				<td><%if(!resultSet.getString("phone").equals("") && resultSet.getString("phone").length()<15){%><%=resultSet.getString("phone")%><%}else{%>none<%}%>
			
				</td>
				
				<td>			
				
					<%if(resultSet.getTimestamp("currentCheckIndate")!=null){%>
								<%
												Calendar cal = Calendar.getInstance();
												java.util.Date expireDate = cal.getTime();
												java.util.Date jDate = new java.util.Date(resultSet.getTimestamp("currentCheckIndate").getTime());
												Calendar jcal=Calendar.getInstance();
												jcal.setTime(jDate);
												jcal.add(Calendar.DAY_OF_MONTH, 2);
												%>
								<%if(cal.before(jcal)) {%>
								<font color="blue"> <%=new SimpleDateFormat("MM-dd HH:mm").format(resultSet.getTimestamp("currentCheckIndate").getTime())%></font>
								<%}else{%>
								<font color="orange"> <%=new SimpleDateFormat("MM-dd HH:mm").format(resultSet.getTimestamp("currentCheckIndate").getTime())%></font>
								<%}%>
								
					<%}else{%>
						<%=new SimpleDateFormat("MM-dd").format(resultSet.getDate("ts"))%>
					<%}%>
								<% DecimalFormat format=new DecimalFormat("####.0");%>
				</td>
				<td>
						<%if(resultSet.getString("distanceFromPickCity")!=null && Float.parseFloat(resultSet.getString("distanceFromPickCity"))* 62.1371>.1){%>
						<%=format.format(Float.parseFloat(resultSet.getString("distanceFromPickCity")) * 62.1371)%>
						miles
						<%}else{%>
						-
						<%}%>
						
				</td>
				<TD><small><span name="ECID<%=j%>"  id="ECID<%=j%>" >
					<img src="images/loading.gif" style="width:1.1em;vertical-align:middle;" /> 
					</span>	</small>			
				</TD>
				<td><%=NullCheck.check(resultSet.getString("currentCity"))%>, <%=NullCheck.check(resultSet.getString("currentstate"))%></td>				
				<TD><small>
				<span name="CCID<%=j%>"  id="CCID<%=j%>" ><img src="images/loading.gif" style="width:1.1em;vertical-align:middle;" /></span>
				</small></TD>
				</tr>

				<%
				}
	  		}


	  				connection.close();
	  				%><input type="hidden" name="rowCountTrucks" id="rowCountTrucks"  value="<%=j+1%>" /> <%
		 			}catch (Exception ex){
		     		%><%="Error Posting " + ex%><%
		     		System.out.println(""+ ex);}
				%>



    </tbody>
    </table>
