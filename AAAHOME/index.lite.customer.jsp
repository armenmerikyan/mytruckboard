<%@ page import="com.big.util.*,java.text.*,java.util.*,java.io.*,javax.xml.parsers.*,org.w3c.dom.*,java.sql.*,java.text.DateFormat" %>			
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" "http://www.w3.org/TR/REC-html40/loose.dtd">
			<html>
			<head>
<link rel="stylesheet" type="text/css" href="css/table.cell.css">		
<script src="//code.jquery.com/jquery-1.11.1.min.js"></script>
<script type="text/javascript" charset="utf8" src="//cdn.datatables.net/1.10.5/js/jquery.dataTables.js"></script>
<script>
$(document).ready(function() {
    $('#example').DataTable();
} );
</script> 
  </head>
  <body >
	  <Table border="1" id="example" class="display" cellspacing="0" width="100%">	  
	        	<thead>
	        	<TR style="width:100%;" >
			<th >NO</th>
			<th >Phone</th>
			<th >TS</th>
			<th >Email</th>
			<th >Type</th>
			<th >Address</th>
			<th >City</th>
			<th >State</th>
	        	</TR>
	        	</thead> 
	        	
    <tbody>
 <%
			String uuidBrand = (String)session.getAttribute("uuidBrand");
			String isShowMoreCol = (String)session.getAttribute("isShowMoreCol");
			//if(uuidBrand !=null){
			// SELECT * FROM maids_oltp.maids_quotes left join maids_customers on maids_customers.client_id = maids_quotes.client_id  left join maids_oltp.maids_users on maids_users.user_id = maids_quotes.assnproviderid order by maids_quotes.ts desc limit 100 
			Class.forName("com.mysql.jdbc.Driver");
					String urldb = "jdbc:mysql://localhost/maids_oltp?user=<USER>&password=<PASSWORD>";		
					Connection connection = DriverManager.getConnection(urldb);

			PreparedStatement psMain = connection.prepareStatement("SELECT * FROM maids_oltp.maids_customers order by ts desc ");
			ResultSet resultSet = psMain.executeQuery();
			int j = 1;			
			DecimalFormat df = new DecimalFormat("#.00");
				while (resultSet.next()) {
					%>
					<TR >
					<TD >
					<div id="<%=resultSet.getString("client_id")%>" style="float:left;padding:5px;">					
					<span style="text-align: right;float:left;width:2%;padding:5px;">
					<%=j%>
					<%j++;%>
					</span> 
					</TD >
					<TD >
					<span style="text-align: right;float:left;width:5%;padding:5px;">
					<%=resultSet.getString("phone")%><BR>
					</span> 		
					</TD >
					<TD nowrap>
					<span style="float:left;width:15%;padding:5px;text-align: center;">
					<%=resultSet.getString("ts")%>
					</span> 		
					</TD >
					<TD >
					<span style="float:left;width:20%;padding:5px;">
					<%=resultSet.getString("email")%>
					</span> 		
					</TD >
					<TD >
					<span style="float:left;width:10%;padding:5px;">
					<%if(resultSet.getString("maid_user_id")!=null){%>
						MaidUser
					<%}else{%>
						CustomerUser
					<%}%>
					</span> 
					</TD >
					<TD >		
					<span style="float:left;width:15%;padding:5px;">
					<%=NullCheck.check(resultSet.getString("ccAddress"))%>
					</span> 		
					</TD >
					<TD >
					<span style="float:left;width:15%;padding:5px;">
					<%=NullCheck.check(resultSet.getString("ccCity"))%>
					</span> 		
					</TD >
					<TD >
					<span style="float:left;width:2%;padding:5px;">
					<%=NullCheck.check(resultSet.getString("ccState"))%>
					</span> 
					</div>
					</TD >
					</TR >
				<%
				}
			%>     
			<tbody>
	        	</table>
	Beta Sales DashBoard
  </body>
</html>

	        	