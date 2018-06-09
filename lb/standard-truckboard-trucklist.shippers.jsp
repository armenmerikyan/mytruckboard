<%@ page import="com.big.util.*,java.text.*,java.util.*,java.io.*,javax.xml.parsers.*,org.w3c.dom.*,java.sql.*,java.text.DateFormat" %>

	
		<%
			String searchSql = "";
			String isOnlineSql = "";
			String uuid = (String)session.getAttribute("uuid");


			%>





		<%
			Class.forName("com.mysql.jdbc.Driver");
			String url = "jdbc:mysql://localhost/test?zeroDateTimeBehavior=convertToNull";
			Connection connection = DriverManager.getConnection(url,"<USERNAME>", "<PASSWORD>");
			PreparedStatement psMain = null;
			//System.out.println("BEFORE THE IF STATEMENTS");

			if(session.getAttribute("IS_SHOW_MORE_COL").equals("true") && request.getParameter("IS_SHOW_MORE_COL")==null && request.getParameter("Go")!=null){
				psMain = connection.prepareStatement("Update test.trucking_users SET IS_SHOW_MORE_COL = ? WHERE EMAIL = ?");
				psMain.setBoolean(1, false);
				psMain.setString(2, (String)session.getAttribute("login_id"));
				psMain.executeUpdate();
				session.setAttribute("IS_SHOW_MORE_COL", "false");
			//	System.out.println("Setting show more to false");

			}
			if(!session.getAttribute("IS_SHOW_MORE_COL").equals("true") && request.getParameter("IS_SHOW_MORE_COL")!=null && request.getParameter("Go")!=null){
				psMain = connection.prepareStatement("Update test.trucking_users SET IS_SHOW_MORE_COL = ? WHERE EMAIL = ?");
				psMain.setBoolean(1, true);
				psMain.setString(2, (String)session.getAttribute("login_id"));
				psMain.executeUpdate();
				session.setAttribute("IS_SHOW_MORE_COL", "true");
			//	System.out.println("Setting show more to true");
			}
			%>

		<%
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
			%>

	<%

			if(request.getParameter("searchKey")!=null && !request.getParameter("searchKey").equals("")){
				if(searchSql.contains("WHERE")) searchSql = searchSql + " and SEARCH_KEYS LIKE '%" + request.getParameter("searchKey").toUpperCase() + "%'";
				else searchSql =  searchSql + " WHERE SEARCH_KEYS LIKE '%" + request.getParameter("searchKey").toUpperCase() + "%'";
			}
			/*
			////STATE FILTER REMOVE BECAUSE GPS SEARCH IS ENABLED//////////////
			if(request.getParameter("searchKeyState")!=null && !request.getParameter("searchKeyState").equals("")){
				if(searchSql.contains("WHERE")) searchSql = searchSql + " and STATE LIKE '%" + request.getParameter("searchKeyState").toUpperCase() + "%'";
				else searchSql =  " WHERE STATE LIKE '%" + request.getParameter("searchKeyState").toUpperCase() + "%'";
			}
			*/
			if(request.getParameter("isOnlineFilter")!=null){
				if(request.getParameter("isOnlineFilter").equals("All")){
					//if(searchSql.contains("WHERE")) searchSql = searchSql + " and ISONLINE = 1 ";
					//else searchSql =  searchSql + " WHERE ISONLINE = 1 ";
				}else if(request.getParameter("isOnlineFilter").equals("Online")){
					if(searchSql.contains("WHERE")) searchSql = searchSql + " and ISONLINE = 1 ";
					else searchSql =  searchSql + " WHERE ISONLINE = 1 ";
				}else if(request.getParameter("isOnlineFilter").equals("Offline")){
					if(searchSql.contains("WHERE")) searchSql = searchSql + " and ISONLINE = 0 ";
					else searchSql =  searchSql + " WHERE ISONLINE = 0 ";
				}
			}else{
					if(searchSql.contains("WHERE")) searchSql = searchSql + " and ISONLINE = 1 ";
					else searchSql =  searchSql + " WHERE ISONLINE = 1 ";
			}
			if(!searchSql.equals(""))searchSql = searchSql + " AND COMPANY_ID = '" + uuid + "'";
			else searchSql = searchSql + " WHERE COMPANY_ID = '" + uuid + "'";

			if(request.getParameter("haulFilter")!=null){
				if(request.getParameter("haulFilter").equals("Headhaul")){
					if(searchSql.contains("WHERE")) searchSql = searchSql + " AND HAUL = 'Headhaul'";
					else searchSql =  searchSql + " WHERE HAUL = 'Headhaul'";
				}else if(request.getParameter("haulFilter").equals("Backhaul")){
					if(searchSql.contains("WHERE")) searchSql =  searchSql + " AND HAUL = 'Backhaul'";
					else searchSql =  searchSql + " WHERE HAUL = 'Backhaul'";
				}
			}

			if(request.getParameter("eqTypeFilter")!=null){
				if(request.getParameter("eqTypeFilter").equals("Van")){
					if(searchSql.contains("WHERE")) searchSql = searchSql + " AND TRAILER = 'Van'";
					else searchSql =  searchSql + " WHERE TRAILER = 'Van'";
				}else if(request.getParameter("eqTypeFilter").equals("Reefer")){
					if(searchSql.contains("WHERE")) searchSql =  searchSql + " AND TRAILER = 'Reefer'";
					else searchSql =  searchSql + " WHERE TRAILER = 'Reefer'";
				}
			}
			if(request.getParameter("loadTypeFilter")!=null){
				if(request.getParameter("loadTypeFilter").equals("Rush")){
					if(searchSql.contains("WHERE")) searchSql = searchSql + " AND LOAD_TYPE = 'Rush'";
					else searchSql =  searchSql + " WHERE LOAD_TYPE = 'Rush'";
				}else if(request.getParameter("loadTypeFilter").equals("Partial")){
					if(searchSql.contains("WHERE")) searchSql =  searchSql + " AND LOAD_TYPE = 'Partial'";
					else searchSql =  searchSql + " WHERE LOAD_TYPE = 'Partial'";
				}else if(request.getParameter("loadTypeFilter").equals("In Transit")){
					if(searchSql.contains("WHERE")) searchSql =  searchSql + " AND LOAD_TYPE = 'In Transit'";
					else searchSql =  searchSql + " WHERE LOAD_TYPE = 'In Transit'";
				}
			}

			//searchSql = searchSql + " ORDER BY DATE_MODIFIED ASC";

			System.out.println(searchSql);
			//System.out.println("JUST PRINTED THE SEARCH SQL");
			%>


		<%
	         try{

			DateFormat formatter = new SimpleDateFormat("MM-dd-yyyy.HH.mm.ss");
			 String pickCity_lat = "0.0";
			 String pickCity_lng = "0.0";

			if(request.getParameter("startDate")!=null && !request.getParameter("startDate").equals("") && request.getParameter("endDate")!=null && !request.getParameter("endDate").equals("")){
				java.sql.Date start = null;
				java.sql.Date end = null;
				start = new java.sql.Date(((java.util.Date)formatter.parse(request.getParameter("startDate") + ".00.00.00" )).getTime());
				end = new java.sql.Date(((java.util.Date)formatter.parse(request.getParameter("endDate") + ".23.59.59" )).getTime());
				//System.out.println("*************JUST SET START AND END DATES");

				if(request.getParameter("pickCity_lng")!=null && !request.getParameter("pickCity_lng").equals("") && request.getParameter("pickCity_lat")!=null && !request.getParameter("pickCity_lat").equals("") && request.getParameter("pickState")!=null && !request.getParameter("pickState").equals("")){

				 	pickCity_lng=request.getParameter("pickCity_lng");
					pickCity_lat=request.getParameter("pickCity_lat");

					psMain = connection.prepareStatement("select CITY, STATE, (GLength(LineStringFromWKB(LineString(city_point, GeomFromText('POINT(" + pickCity_lat + " " + pickCity_lng + ")'))))) AS distanceFromPickCity, NAME, ID, DATE_MODIFIED, TRAILER, COVERED_BY, WTG, CONTACT_PERSON, DATE_STATUS_CHANGE, DATE_COVERED, LAST_MODIFIED_BY, LAST_MODIFIED_DATE, LOAD_TYPE, PHONE, COMMENTS, TRUCKINFO, INSURANCE_EXP_DATE, ISONLINE, X(city_point) as city_lat, Y(city_point) as city_lng from test.TRUCKING_shipping" + searchSql + " AND DATE_MODIFIED BETWEEN ? AND ? order by distanceFromPickCity");
					psMain.setDate(1, start);
					psMain.setTimestamp(2, new java.sql.Timestamp(end.getTime()));

				}else{

					psMain = connection.prepareStatement("select CITY, STATE, NAME, ID, DATE_MODIFIED, TRAILER, COVERED_BY, WTG, CONTACT_PERSON, DATE_STATUS_CHANGE, DATE_COVERED, LAST_MODIFIED_BY, LAST_MODIFIED_DATE, LOAD_TYPE, PHONE, COMMENTS, TRUCKINFO, ISONLINE, X(city_point) as city_lat, Y(city_point) as city_lng from test.TRUCKING_shipping"  + searchSql +  " AND DATE_MODIFIED BETWEEN ? AND ? order by DATE_MODIFIED DESC");
					psMain.setDate(1, start);
					psMain.setTimestamp(2, new java.sql.Timestamp(end.getTime()));
				}
			}else{
				//System.out.println(searchSql);
				if(request.getParameter("searchKeyCity_lng")!=null && !request.getParameter("searchKeyCity_lng").equals("") && request.getParameter("searchKeyCity_lat")!=null && !request.getParameter("searchKeyCity_lat").equals("")&& request.getParameter("searchKeyCity")!=null && !request.getParameter("searchKeyCity").equals("")&& request.getParameter("searchKeyState")!=null && !request.getParameter("searchKeyState").equals("")){

					pickCity_lng=request.getParameter("searchKeyCity_lng");
					pickCity_lat=request.getParameter("searchKeyCity_lat");
					psMain = connection.prepareStatement("select X(city_point) as city_lat, Y(city_point) as city_lng,  (GLength(LineStringFromWKB(LineString(city_point, GeomFromText('POINT(" + pickCity_lat + " " + pickCity_lng + ")'))))) AS distanceFromPickCity, CITY, STATE, NAME, ID, DATE_MODIFIED, TRAILER, COVERED_BY, WTG, CONTACT_PERSON, DATE_STATUS_CHANGE, DATE_COVERED, LAST_MODIFIED_BY, LAST_MODIFIED_DATE, LOAD_TYPE, PHONE, COMMENTS, TRUCKINFO, ISONLINE, X(city_point) as city_lat, Y(city_point) as city_lng from test.TRUCKING_shipping" + searchSql + " order by distanceFromPickCity");
				}else if(request.getParameter("pickCity")!=null && !request.getParameter("pickCity").equals("")){
				//System.out.println(searchSql);
					pickCity_lng=request.getParameter("pickCity_lng");
					pickCity_lat=request.getParameter("pickCity_lat");
					psMain = connection.prepareStatement("select LANGUAGE, external_id, X(city_point) as city_lat, Y(city_point) as city_lng,  (GLength(LineStringFromWKB(LineString(city_point, GeomFromText('POINT(" + pickCity_lat + " " + pickCity_lng + ")'))))) AS distanceFromPickCity, CITY, STATE, NAME, ID, DATE_MODIFIED, TRAILER, COVERED_BY, WTG, CONTACT_PERSON, DATE_STATUS_CHANGE, DATE_COVERED, LAST_MODIFIED_BY, LAST_MODIFIED_DATE, LOAD_TYPE, PHONE, COMMENTS, TRUCKINFO, ISONLINE, X(city_point) as city_lat, Y(city_point) as city_lng from test.TRUCKING_shipping" + searchSql + " order by distanceFromPickCity");

				}else{

				//System.out.println("*************LAST ONE --> HERE gets ready to be executed");
					psMain = connection.prepareStatement("select CITY, STATE, NAME, ID, DATE_MODIFIED, TRAILER, COVERED_BY, WTG, CONTACT_PERSON, DATE_STATUS_CHANGE, DATE_COVERED, LAST_MODIFIED_BY, LAST_MODIFIED_DATE, LOAD_TYPE, PHONE, COMMENTS, TRUCKINFO, ISONLINE, X(city_point) as city_lat, Y(city_point) as city_lng from test.TRUCKING_shipping" + searchSql + " order by DATE_MODIFIED DESC, LAST_MODIFIED_DATE DESC" );
				}

			}



	         }catch (Exception ex){
	             %><font color="#FF0000"><%="Error Posting " + ex%></font><%
	             System.out.println(""+ ex + searchSql);
	         }
	         		%>





	<div class="col-sm-12">

		<%if(request.getParameter("cmd")==null || (!request.getParameter("cmd").equals("AddEquipment") && !request.getParameter("cmd").equals("EditEquipment"))){%>



	<table class="table table-hover table-bordered tablesorter" id="boardtable">
	<thead style="font-size:14px">

	<TR>

	<th>Actions</th>


	<th>Equipment / Trailer </th>
	<th>Last Updated By</th>
	<!--
	<th>Phone</th>
	-->
	<th>Contact</th>
	<th>Location</th>

	<th>Date</th>

	<th>Wants&nbsp;To&nbsp;Go</th>
	<th>Comments</th>
	<th>Trucker Info</th>
		<%if(session.getAttribute("IS_SHOW_MORE_COL").equals("true")){%>
	<th>Insurance Exp. Date</th>

	<th>Covered&nbsp;On</th>
	<th>Covered&nbsp;By</th>
	<th>Reserved Date</th>
		<%}%>
	</TR></thead><tbody style="font-size:14px">






		<%
	 try{
			DateFormat formatter = new SimpleDateFormat("MM-dd-yyyy.HH.mm.ss");
			ResultSet resultSet = psMain.executeQuery();
			while (resultSet.next()) {

					//System.out.println(resultSet.getString("ID"));
					%>
		<%
					if(resultSet.getTimestamp("DATE_STATUS_CHANGE")!=null){
						%><TR bgcolor="#CCCCCC"><%
					}else if(resultSet.getTimestamp("DATE_COVERED")!=null){

						Calendar cal = Calendar.getInstance();
						java.util.Date expireDate = cal.getTime();
						java.util.Date jDate = new java.util.Date(resultSet.getTimestamp("DATE_COVERED").getTime());
						Calendar jcal=Calendar.getInstance();
						jcal.setTime(jDate);
						jcal.add(Calendar.MINUTE, 60);
						%>
	<TR
		<%if(cal.before(jcal)) {%>
	bgcolor="#FFCCCC"
		<%}%>
	>
		<%}else{%>
	<TR >
		<%}%>
	<TD><div style="max-width:90px;width:100%">



<!--
	<a href="javascript:void(0)"><button type="button"  id="BT<%=resultSet.getString("ID")%>" class="btn btn-default btn-sm"
	onclick="sendSMStoDriver('<%=resultSet.getString("ID")%>')" alt="SMS Driver to call you back, update your call back info using the My Info page" title="TO : <%=NullCheck.check(resultSet.getString("PHONE"))%> SMS : myTruckBoard.com message from <%=(String)session.getAttribute("f_name")%> call back <%=(String)session.getAttribute("phone")%>">
	<span class="glyphicon glyphicon-share-alt" aria-hidden="true"></span> SMS&nbsp;&nbsp;&nbsp;</button></a>
-->
		<%if(session.getAttribute("isAdmin").equals("true")){%>
	<a href="/trucking-new/edit_shipper.jsp?id=<%=resultSet.getString("ID")%>"><button type="button" class="btn btn-default btn-sm" >
	<span class="glyphicon glyphicon-edit" aria-hidden="true"></span> EDIT&nbsp;&nbsp;&nbsp;</button></a>
	<a href="#" class="btn btn-default btn-sm" style="color:red"
	onclick="setTruckId('<%=resultSet.getString("ID")%>')" data-toggle="modal" data-target="#delconfirm">
	<span class="glyphicon glyphicon-trash" aria-hidden="true"></span> DEL.&nbsp;&nbsp;&nbsp;</a>
		<%}else{%>
	<a href="/trucking-new/add_comment_shipping.jsp?id=<%=resultSet.getString("ID")%>"><button type="button" class="btn btn-default btn-sm" >
	<span class="glyphicon glyphicon-edit" aria-hidden="true"></span> EDIT&nbsp;&nbsp;&nbsp;</button></a>
		<%}%>
	<a href="javascript:void(0)" onclick="getLinkwithForm('add_rate_shipping.jsp?cmd=EditEquipment','<%=resultSet.getString("ID")%>')" ><button type="button" class="btn btn-default btn-sm">
	<span class="glyphicon glyphicon-dashboard" aria-hidden="true"></span> BOOK</button></a>

	</div></TD>

	<TD><div style="min-width:130px;width:100%">
		<%=NullCheck.check(resultSet.getString("NAME"))%><BR>
		<%=NullCheck.check(resultSet.getString("TRAILER"))%>
	<hr>Load Type:<br/><font
		<%if(NullCheck.check(resultSet.getString("LOAD_TYPE")).equals("Rush")){%>color="red"<%}%>
		<%if(NullCheck.check(resultSet.getString("LOAD_TYPE")).equals("Partial")){%>color="#9acd32"<%}%>
		<%if(NullCheck.check(resultSet.getString("LOAD_TYPE")).equals("In Transit")){%>color="blue"<%}%>
	/>
		<%=NullCheck.check(resultSet.getString("LOAD_TYPE"))%>

	</div>
	</TD>
	<TD>



		<%=NullCheck.check(resultSet.getString("LAST_MODIFIED_BY"))%><BR>
		<%if(resultSet.getTimestamp("LAST_MODIFIED_DATE")!=null){%>
		<%=new SimpleDateFormat("MM-dd-yy hh:mm:ss").format(resultSet.getTimestamp("LAST_MODIFIED_DATE"))%>
		<%}%>



	</TD>
	<!--
	<TD nowrap>
	<span style="color:#000000;font-size: 1.5em; line-height: 1.5em;">
		<%=NullCheck.check(resultSet.getString("PHONE"))%>
	</span>
	&nbsp;
	</TD>
	-->
	<TD >
	<div style="min-width:100px;width:100%;overflow:auto;">
		<%=NullCheck.check(resultSet.getString("CONTACT_PERSON"))%>&nbsp;<BR>
		<%=NullCheck.check(resultSet.getString("PHONE"))%>
	</div></TD>
	<TD><div style="min-width:140px;width:100%;overflow:auto;">

		<%=NullCheck.check(resultSet.getString("CITY"))%>,&nbsp;<%=NullCheck.check(resultSet.getString("STATE"))%>
	</div>

		<%if(request.getParameter("pickCity")!=null && !request.getParameter("pickCity").equals("") && !request.getParameter("pickCity_lng").equals("") && request.getParameter("pickCity_lat")!=null && !request.getParameter("pickCity_lat").equals("")){%>
	<hr>
	Distance from Pickup:<br>
		<% DecimalFormat format=new DecimalFormat("####.0");%>

		<%if(resultSet.getString("distanceFromPickCity")!=null){%>
		<%=format.format(Float.parseFloat(resultSet.getString("distanceFromPickCity")) * 62.1371)%>
		<%}%>
	<small>
	mls away
	</small>


		<%}%>



	</TD>

	<TD>
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
		<%=new SimpleDateFormat("MM-dd-YY").format(resultSet.getDate("DATE_MODIFIED"))%>
		<%}else{%>
		<%=new SimpleDateFormat("MM-dd-YY").format(resultSet.getDate("DATE_MODIFIED"))%>
		<%}%>
		<%}else{%>
		<%=new SimpleDateFormat("MM-dd-YY").format(resultSet.getDate("DATE_MODIFIED"))%>
		<%}%>
	</TD>


	<TD>
		<%=NullCheck.check(resultSet.getString("WTG"))%>&nbsp;</TD>
	<TD><div style="min-width:200px;width:100%;height:130px;overflow:auto;">

		<%=NullCheck.check(resultSet.getString("COMMENTS"))%></div>
	</TD>
	<TD><div style="min-width:200px;width:100%;height:130px;overflow:auto;">
		<%=NullCheck.check(resultSet.getString("TRUCKINFO"))%>&nbsp;
	</div>
	</TD>
		<%if(session.getAttribute("IS_SHOW_MORE_COL").equals("true")){%>
	<TD><div style="min-width:76px;width:100%;">
		&nbsp;				</div>
	</TD>

	<TD><div style="min-width:76px;width:100%;">
		<%if(resultSet.getTimestamp("DATE_COVERED")!=null){%>
		<%=new SimpleDateFormat("MM-dd-YY").format(resultSet.getTimestamp("DATE_COVERED"))%>
		<%}else{%>
	&nbsp;
		<%}%></div>
	</TD>
	<td><%=NullCheck.check(resultSet.getString("COVERED_BY"))%></td>
	<TD>
		<%if(resultSet.getTimestamp("DATE_STATUS_CHANGE")!=null){%>
		<%=new SimpleDateFormat("MM-dd-YY").format(resultSet.getTimestamp("DATE_STATUS_CHANGE"))%>
		<%}else{%>
	&nbsp;
		<%}%>
	</TD>
		<%}%>

	</TR>



		<%}%>

		<%
	         }catch (Exception ex){
	             %><font color="#FF0000"><%="Error Posting " + ex%></font><%
	             System.out.println(""+ ex + searchSql);
	         }
	        	%>

	</tbody> </table>

		<% connection.close();
	        	}%>
	</div>
