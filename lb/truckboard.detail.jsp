<%@ page import="com.big.util.*,java.text.*,java.util.*,java.io.*,javax.xml.parsers.*,org.w3c.dom.*,java.sql.*,java.text.DateFormat" %>			

			<%
			String searchSql = "";
			String uuid = (String)session.getAttribute("uuid");
			if(!searchSql.equals(""))searchSql = searchSql + " AND COMPANY_ID = '" + uuid + "'";
			else searchSql = searchSql + " WHERE COMPANY_ID = '" + uuid + "'";
			if(searchSql.contains("WHERE")) searchSql = searchSql + " and ISONLINE = 1 ";
			else searchSql =  searchSql + " WHERE ISONLINE = 1 ";

			if(request.getParameter("haulFilter")!=null){
				if(request.getParameter("haulFilter").equals("Headhaul")){
					if(searchSql.contains("WHERE")) searchSql = searchSql + " AND HAUL = 'Headhaul'";
					else searchSql =  searchSql + " WHERE HAUL = 'Headhaul'";
				}else if(request.getParameter("haulFilter").equals("Backhaul")){
					if(searchSql.contains("WHERE")) searchSql =  searchSql + " AND HAUL = 'Backhaul'";
					else searchSql =  searchSql + " WHERE HAUL = 'Backhaul'";
				}			
			}
			
			Class.forName("com.mysql.jdbc.Driver");
			String url = "jdbc:mysql://localhost/test?zeroDateTimeBehavior=convertToNull";		
			Connection connection = DriverManager.getConnection(url,"<USERNAME>", "<PASSWORD>");			
			PreparedStatement psMain = null;
			System.out.println("EXECUTED DETAIL");
			System.out.println("EXECUTED DETAIL" + searchSql);			
			String pickCity_lng = request.getParameter("long");
			String pickCity_lat = request.getParameter("lat");
			System.out.println("EXECUTED DETAIL" + "select LANGUAGE, external_id, X(city_point) as city_lat, Y(city_point) as city_lng,  (GLength(LineStringFromWKB(LineString(city_point, GeomFromText('POINT(" + pickCity_lat + " " + pickCity_lng + ")'))))) AS distanceFromPickCity, CITY, STATE, NAME, ID, DATE_MODIFIED, TRAILER, COVERED_BY, WTG, CONTACT_PERSON, DATE_STATUS_CHANGE, DATE_COVERED, LAST_MODIFIED_BY, LAST_MODIFIED_DATE, LOAD_TYPE, PHONE, COMMENTS, TRUCKINFO, INSURANCE_EXP_DATE, ISONLINE, X(city_point) as city_lat, Y(city_point) as city_lng from test.TRUCKING_EQUIPMENT" + searchSql + " order by distanceFromPickCity");
			DateFormat formatter = new SimpleDateFormat("MM/dd/yyyy.HH.mm.ss");
			if(request.getParameter("startDate")!=null && !request.getParameter("startDate").equals("") && request.getParameter("endDate")!=null && !request.getParameter("endDate").equals("")){
				java.sql.Date start = null;
				java.sql.Date end = null;
				start = new java.sql.Date(((java.util.Date)formatter.parse(request.getParameter("startDate") + ".00.00.00" )).getTime());
				end = new java.sql.Date(((java.util.Date)formatter.parse(request.getParameter("endDate") + ".23.59.59" )).getTime());				
				psMain = connection.prepareStatement("select LANGUAGE, external_id, X(city_point) as city_lat, Y(city_point) as city_lng,  (GLength(LineStringFromWKB(LineString(city_point, GeomFromText('POINT(" + pickCity_lat + " " + pickCity_lng + ")'))))) AS distanceFromPickCity, CITY, STATE, NAME, ID, DATE_MODIFIED, TRAILER, COVERED_BY, WTG, CONTACT_PERSON, DATE_STATUS_CHANGE, DATE_COVERED, LAST_MODIFIED_BY, LAST_MODIFIED_DATE, LOAD_TYPE, PHONE, COMMENTS, TRUCKINFO, INSURANCE_EXP_DATE, ISONLINE, X(city_point) as city_lat, Y(city_point) as city_lng from test.TRUCKING_EQUIPMENT"  + searchSql +  " AND DATE_MODIFIED BETWEEN ? AND ? " + " order by distanceFromPickCity");
				psMain.setDate(1, start);			
				psMain.setTimestamp(2, new java.sql.Timestamp(end.getTime()));				
			}else{
				psMain = connection.prepareStatement("select LANGUAGE, external_id, X(city_point) as city_lat, Y(city_point) as city_lng,  (GLength(LineStringFromWKB(LineString(city_point, GeomFromText('POINT(" + pickCity_lat + " " + pickCity_lng + ")'))))) AS distanceFromPickCity, CITY, STATE, NAME, ID, DATE_MODIFIED, TRAILER, COVERED_BY, WTG, CONTACT_PERSON, DATE_STATUS_CHANGE, DATE_COVERED, LAST_MODIFIED_BY, LAST_MODIFIED_DATE, LOAD_TYPE, PHONE, COMMENTS, TRUCKINFO, INSURANCE_EXP_DATE, ISONLINE, X(city_point) as city_lat, Y(city_point) as city_lng from test.TRUCKING_EQUIPMENT" + searchSql + " order by distanceFromPickCity");			
			}
//			psMain = connection.prepareStatement("select LANGUAGE, external_id, CITY, STATE, NAME, ID, DATE_MODIFIED, TRAILER, COVERED_BY, WTG, CONTACT_PERSON, DATE_STATUS_CHANGE, DATE_COVERED, LAST_MODIFIED_BY, LAST_MODIFIED_DATE, LOAD_TYPE, PHONE, COMMENTS, TRUCKINFO, INSURANCE_EXP_DATE, ISONLINE, X(city_point) as city_lat, Y(city_point) as city_lng from test.TRUCKING_EQUIPMENT" + searchSql);
			ResultSet resultSet = psMain.executeQuery();
			int j = 1;
			while (resultSet.next()) {
			//city_lat city_lng
			
				String latLongString = resultSet.getFloat("city_lat") + " " + resultSet.getFloat("city_lng");
				String[] dataSet = new String[8];
				dataSet[0]=resultSet.getString("id");
				dataSet[1]=resultSet.getString("phone");
				dataSet[2]=resultSet.getString("CONTACT_PERSON");
				dataSet[3]=resultSet.getString("WTG");		
				dataSet[4]=resultSet.getFloat("city_lat")+"";		
				dataSet[5]=resultSet.getFloat("city_lng")+"";	
				dataSet[6]=resultSet.getString("CITY")+"";		
				dataSet[7]=resultSet.getString("STATE")+"";	
				
				System.out.println("EXECUTED DETAIL" + resultSet.getString("CITY"));
				%>
				<span style="text-align:right;padding:5px;display: inline-block;width:2%;border: 2px solid;color:#000000;font-size: 0.8em; line-height: 1.0em;">
				<%=j%>
				<% j ++;%>
				</span>					
				
						<span style="padding:5px;display: inline-block;border: 2px solid;width:30%;color:#000000;font-size: 0.8em; line-height: 1.0em;">
				<a href="#"onclick="getDetail('<%=NullCheck.check(resultSet.getString("id"))%>')"><%=resultSet.getString("CONTACT_PERSON")%><%if(NullCheck.check(resultSet.getString("CONTACT_PERSON")).equals("")){%>[No Name]<%}%></a> 
				</span>					
				<span style="padding:5px;display: inline-block;width:8%;border: 2px solid;color:#000000;font-size: 0.8em; line-height: 1.0em;">
				<%=resultSet.getString("phone")%>&nbsp;
				</span>					
				<span style="padding:5px;display: inline-block;width:15%;border: 2px solid;color:#000000;font-size: 0.8em; line-height: 1.0em;">
				 <a href="javascript:void(0)" onclick="getLinkwithForm('add_rate.jsp?cmd=EditEquipment','<%=resultSet.getString("ID")%>')" >
				 <%=NullCheck.check(resultSet.getString("CITY"))%>&nbsp;</a>
					<%=NullCheck.check(resultSet.getString("STATE"))%>&nbsp;
				</span>					
				<span style="padding:5px;display: inline-block;width:7%;border: 2px solid;color:#000000;font-size: 0.8em; line-height: 1.0em;">
					
					<%if(resultSet.getTimestamp("DATE_MODIFIED")!=null){%>
						<%
						Calendar cal = Calendar.getInstance();
						java.util.Date expireDate = cal.getTime();
						java.util.Date jDate = new java.util.Date(resultSet.getTimestamp("DATE_MODIFIED").getTime());
						Calendar jcal=Calendar.getInstance();
						jcal.setTime(jDate);
						jcal.add(Calendar.DAY_OF_MONTH, 2);
						%>
						<%if(cal.before(jcal)) {%>
							<%=new SimpleDateFormat("MM-dd").format(resultSet.getDate("DATE_MODIFIED"))%>						
						<%}else{%>						
							<font color="#FF0000"> <%=new SimpleDateFormat("MM-dd").format(resultSet.getDate("DATE_MODIFIED"))%></font>
						<%}%>						
					<%}else{%>
						<%=new SimpleDateFormat("MM-dd").format(resultSet.getDate("DATE_MODIFIED"))%>
					<%}%>
					<% DecimalFormat format=new DecimalFormat("####.0");%>
						</span>
						<span style="text-align: right;padding:5px;display: inline-block;width:7%;border: 2px solid;color:#000000;font-size: 0.8em; line-height: 1.0em;">
						<%if(resultSet.getString("distanceFromPickCity")!=null){%>
					<%=format.format(Float.parseFloat(resultSet.getString("distanceFromPickCity")) * 62.1371)%>
						<%}%>
						<span style="color:#000000;font-size: 0.5em; line-height: 0.5em;">
					 mls 
						</span>
						
					
						</span>
						<span style="padding:5px;display: inline-block;width:18%;border: 2px solid;color:#000000;font-size: 0.8em; line-height: 1.0em;">
						<%=NullCheck.check(resultSet.getString("WTG"))%>&nbsp;
						
						</span>
						<BR>				
				<%
	  		}
	  		%>