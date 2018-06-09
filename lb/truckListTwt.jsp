<%@ page import="com.big.util.*,java.text.*,java.util.*,java.io.*,javax.xml.parsers.*,org.w3c.dom.*,java.sql.*,java.text.DateFormat" %>
<%
			Class.forName("com.mysql.jdbc.Driver");
			String url = "jdbc:mysql://localhost/test?zeroDateTimeBehavior=convertToNull";
			Connection connection = DriverManager.getConnection(url,"<USERNAME>", "<PASSWORD>");
			PreparedStatement psMain = null;
			//System.out.println("BEFORE THE IF STATEMENTS");
			psMain = connection.prepareStatement("select CITY, STATE, NAME, ID, DATE_MODIFIED, TRAILER, COVERED_BY, WTG, CONTACT_PERSON, DATE_STATUS_CHANGE, DATE_COVERED, LAST_MODIFIED_BY, LAST_MODIFIED_DATE, LOAD_TYPE, PHONE, COMMENTS, TRUCKINFO, INSURANCE_EXP_DATE, ISONLINE, X(city_point) as city_lat, Y(city_point) as city_lng from test.TRUCKING_EQUIPMENT order by DATE_MODIFIED DESC, LAST_MODIFIED_DATE DESC" );

	 try{
			DateFormat formatter = new SimpleDateFormat("MM-dd-yyyy.HH.mm.ss");
			ResultSet resultSet = psMain.executeQuery();
			while (resultSet.next()) {
			%>
		
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
				<%=NullCheck.check(resultSet.getString("TRAILER"))%><ITEM>
				<%=new SimpleDateFormat("MM-dd-YY").format(resultSet.getDate("DATE_MODIFIED"))%><ITEM>
				<%=NullCheck.check(resultSet.getString("LOAD_TYPE"))%><ITEM>
				<%=NullCheck.check(resultSet.getString("wtg"))%><ITEM>
				<%=NullCheck.check(resultSet.getString("CITY"))%><ITEM><%=NullCheck.check(resultSet.getString("STATE"))%><ITEM><ROWS>
			<%}else{%>
			
			<%}%>
			<%}else{%>
			
			<%}%>
			<%}
	         }catch (Exception ex){
	             %><font color="#FF0000"><%="Error Posting " + ex%></font><%
	             System.out.println(""+ ex );
	         }
	         connection.close();%>
