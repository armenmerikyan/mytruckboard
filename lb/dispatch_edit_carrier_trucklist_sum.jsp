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
			 psMain = connection.prepareStatement("select TRAILER, count(*) as num from test.TRUCKING_EQUIPMENT where company_id = ? and mc_no = ? and mc_no != '' group by TRAILER" );
			 psMain.setString(1, uuid);
			 psMain.setString(2,request.getParameter("MC_NO"));
				




	         }catch (Exception ex){
	             %><font color="#FF0000"><%="Error Posting " + ex%></font><%
	             System.out.println(""+ ex + searchSql);
	         }
	         		%>





	<div class="col-sm-12">


					<%if(session.getAttribute("isAdmin").equals("true") && request.getParameter("MC_NO")!=null){%>
				Add new truck for <a href="add_truck.jsp?MC_NO=<%=request.getParameter("MC_NO")%>">MC<%=NullCheck.check(request.getParameter("MC_NO"))%></a>
					<%}%>	
	<table class="table table-hover table-bordered tablesorter" id="boardtable">
	<thead style="font-size:12px">

	<TR>



	<th>Count </th>
	<th>Equipment / Trailer </th>
	<th>MC Number </th>
	</TR></thead><tbody style="font-size:14px">






		<%
	 try{
			DateFormat formatter = new SimpleDateFormat("MM-dd-yyyy.HH.mm.ss");
			ResultSet resultSet = psMain.executeQuery();
			while (resultSet.next()) {
					%>
	<TR >

	<TD><div style="min-width:130px;width:100%">
		<%=NullCheck.check(resultSet.getString("num"))%>

	</div>
	</TD>
	<TD>
		<%=NullCheck.check(resultSet.getString("TRAILER"))%>



	</TD>
	<TD>
		<%=request.getParameter("MC_NO")%>



	</TD>

	
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

