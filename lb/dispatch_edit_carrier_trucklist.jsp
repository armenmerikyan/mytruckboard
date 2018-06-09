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
			

	         try{
	         
	         	

			DateFormat formatter = new SimpleDateFormat("MM-dd-yyyy.HH.mm.ss");
			 String pickCity_lat = "0.0";
			 String pickCity_lng = "0.0";
			 psMain = connection.prepareStatement("select CITY, STATE, NAME, ID, DATE_MODIFIED, TRAILER, COVERED_BY, WTG, CONTACT_PERSON, DATE_STATUS_CHANGE, DATE_COVERED, LAST_MODIFIED_BY, LAST_MODIFIED_DATE, LOAD_TYPE, PHONE, COMMENTS, TRUCKINFO, INSURANCE_EXP_DATE, ISONLINE, X(city_point) as city_lat, Y(city_point) as city_lng from test.TRUCKING_EQUIPMENT where company_id = ? and mc_no = ? and mc_no != '' order by DATE_MODIFIED DESC, LAST_MODIFIED_DATE DESC" );
			 psMain.setString(1, uuid);
			 psMain.setString(2,request.getParameter("MC_NO"));
				




	         }catch (Exception ex){
	             %><font color="#FF0000"><%="Error Posting " + ex%></font><%
	             System.out.println(""+ ex + searchSql);
	         }
	         		%>





	<div class="col-sm-12">



	<table class="table table-hover table-bordered tablesorter" id="boardtable">
	<thead style="font-size:12px">

	<TR>



	<th>Equipment / Trailer </th>
	<!--
	<th>Phone</th>
	-->
	<th>Contact</th>
	<th>Location</th>

	<th>Available</th>

	<th>Wants&nbsp;To&nbsp;Go</th>
	<th>Comments</th>
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

	<TD><div style="min-width:130px;width:100%">
		<%=NullCheck.check(resultSet.getString("NAME"))%><BR>
		<%=NullCheck.check(resultSet.getString("TRAILER"))%><BR>
		<span 
		<%if(NullCheck.check(resultSet.getString("LOAD_TYPE")).equals("Rush")){%>style="color:red;" <%}%>
		<%if(NullCheck.check(resultSet.getString("LOAD_TYPE")).equals("Partial")){%>style="color:#9acd32;"<%}%>
		<%if(NullCheck.check(resultSet.getString("LOAD_TYPE")).equals("In Transit")){%>style="color:blue;"<%}%>
		<%if(NullCheck.check(resultSet.getString("LOAD_TYPE")).equals("Regular")){%>style="color:black;"<%}%>
		>
		<%=NullCheck.check(resultSet.getString("LOAD_TYPE"))%></span>

	</div>
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
		<%if(session.getAttribute("IS_SHOW_MORE_COL").equals("true")){%>
	<TD><div style="min-width:76px;width:100%;">
		<%if(resultSet.getTimestamp("INSURANCE_EXP_DATE")!=null){%>
		<%
						Calendar cal = Calendar.getInstance();
						java.util.Date expireDate = cal.getTime();
						java.util.Date jDate = new java.util.Date(resultSet.getTimestamp("INSURANCE_EXP_DATE").getTime());
						Calendar jcal=Calendar.getInstance();
						jcal.setTime(jDate);
						jcal.add(Calendar.DAY_OF_MONTH, 30);
						%>
		<%if(cal.before(jcal)) {%>
		<%=new SimpleDateFormat("MM-dd-YY").format(resultSet.getDate("INSURANCE_EXP_DATE"))%>
		<%}else{%>
		<%=new SimpleDateFormat("MM-dd-YY").format(resultSet.getDate("INSURANCE_EXP_DATE"))%>
		<%}%>
		<%}else{%>
	&nbsp;
		<%}%>					</div>
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
	        	%>
	</div>

