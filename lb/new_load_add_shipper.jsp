<%@ page import="java.util.Vector,com.big.util.*,java.text.*,java.util.*,java.io.*,javax.xml.parsers.*,org.w3c.dom.*,java.sql.*,java.text.DateFormat" %><%
String uuid = (String)session.getAttribute("uuid");
boolean needStatusUpdate = false;
if(uuid !=null){

%>
		     <% int shipper_count = Integer.parseInt(request.getParameter("shipper_count"));
		         String responseText = "";
			String responseFields = "";
			String totalCount = "0";
			%>
		<% String ship_line_id = request.getParameter("ship_line_id");%>
		<% String current_line_id = request.getParameter("current_line_id");%>
		<% System.out.println("COOL YO" + request.getParameter("ship_line_id"));%>
		
		<%if(request.getParameter("current_line_id_remove")!=null){%>			
		<%
			 try{
				System.out.println("ship_line_id_new : " + request.getParameter("ship_line_id_new"));
				Class.forName("com.mysql.jdbc.Driver");
				String url = "jdbc:mysql://localhost/test?zeroDateTimeBehavior=convertToNull";
				Connection connection = DriverManager.getConnection(url,"<USERNAME>", "<PASSWORD>");
				PreparedStatement ps = null;

				ps = connection.prepareStatement("select count(distinct(load_line_id)) as itemCount from load_board_line where company_id = ? and load_id = ?");	
				ps.setString(1, uuid);
				ps.setString(2, request.getParameter("load_id"));
				ResultSet resultSet = ps.executeQuery();
				while (resultSet.next()) {
					if(resultSet.getInt("itemCount")>1){
						ps = connection.prepareStatement("delete from test.load_board_line where load_line_id = ? and company_id = ?");
						ps.setString(1, request.getParameter("current_line_id_remove"));
						ps.setString(2, uuid);
						ps.executeUpdate();	
						ps = connection.prepareStatement("select * from test.load_board_line where company_id = ? and load_id = ? order by ts desc limit 1");	
						ps.setString(1, uuid);
						ps.setString(2, request.getParameter("load_id"));
						resultSet = ps.executeQuery();
						while (resultSet.next()) {
							ship_line_id = resultSet.getString("load_line_id");
						}
					}else{
						ship_line_id = request.getParameter("current_line_id_remove");
					}
				}
				connection.close();
			 }catch (Exception ex){
			     System.out.println(""+ ex);
			 }
				%>
		<%} else if(request.getParameter("ship_line_id_new")!=null){%>		
		<%
	         try{
	         	System.out.println("ship_line_id_new : " + request.getParameter("ship_line_id_new"));
			Class.forName("com.mysql.jdbc.Driver");
			String url = "jdbc:mysql://localhost/test?zeroDateTimeBehavior=convertToNull";
			Connection connection = DriverManager.getConnection(url,"<USERNAME>", "<PASSWORD>");
			PreparedStatement ps = null;
				System.out.println(shipper_count + "XXXX");				
				current_line_id = UUID.randomUUID() +"";
				ship_line_id = current_line_id;
				ps = connection.prepareStatement("INSERT INTO test.load_board_line(load_line_id, load_id, ts, company_id, created_by) VALUES (?,?,?,?,?)");
				ps.setString(1, current_line_id);
				ps.setString(2, request.getParameter("load_id"));
				java.sql.Timestamp ts = new java.sql.Timestamp((new java.util.Date()).getTime());
				ps.setTimestamp(3, ts);
				ps.setString(4, uuid);
				ps.setString(5, (String)session.getAttribute("login_id"));
				ps.executeUpdate();	
			connection.close();
	         }catch (Exception ex){
	             System.out.println(""+ ex);
	         }
				%>
		<%}else if(request.getParameter("ship_line_id")==null && request.getParameter("ship_line_id_new")==null){%>
			<% shipper_count += 1;%>
		<%
	         try{
			Class.forName("com.mysql.jdbc.Driver");
			String url = "jdbc:mysql://localhost/test?zeroDateTimeBehavior=convertToNull";
			Connection connection = DriverManager.getConnection(url,"<USERNAME>", "<PASSWORD>");
			PreparedStatement ps = null;
				System.out.println(shipper_count + "XXXX");
	         	if(shipper_count ==1){
				ps = connection.prepareStatement("select count(distinct(load_line_id)) as itemCount from load_board_line where company_id = ? and load_id = ?");	
				ps.setString(1, uuid);
				ps.setString(2, request.getParameter("load_id"));
				ResultSet resultSet = ps.executeQuery();
				while (resultSet.next()) {
					totalCount = resultSet.getString("itemCount");
				}
				if(totalCount.equals("0")){
					current_line_id = UUID.randomUUID() +"";
					ps = connection.prepareStatement("INSERT INTO test.load_board_line(load_line_id, load_id, ts, company_id, created_by) VALUES (?,?,?,?,?)");
					ps.setString(1, current_line_id);
					ps.setString(2, request.getParameter("load_id"));
					java.sql.Timestamp ts = new java.sql.Timestamp((new java.util.Date()).getTime());
					ps.setTimestamp(3, ts);
					ps.setString(4, uuid);
					ps.setString(5, (String)session.getAttribute("login_id"));
					ps.executeUpdate();				
				}
	         	}
			
			ship_line_id = UUID.randomUUID() +"";

			ps = connection.prepareStatement("INSERT INTO test.load_board_line(load_line_id, load_id, ts, company_id, created_by) VALUES (?,?,?,?,?)");
			ps.setString(1, ship_line_id);
			ps.setString(2, request.getParameter("load_id"));
			java.sql.Timestamp ts = new java.sql.Timestamp((new java.util.Date()).getTime());
			ps.setTimestamp(3, ts);
			ps.setString(4, uuid);
			ps.setString(5, (String)session.getAttribute("login_id"));
			ps.executeUpdate();
			
			connection.close();
	         }catch (Exception ex){
	             System.out.println(""+ ex);
	         }
				%>

		<%}%>
		<%if(true){%>
		<%
	         try{

			Class.forName("com.mysql.jdbc.Driver");
			String url = "jdbc:mysql://localhost/test?zeroDateTimeBehavior=convertToNull";
			Connection connection = DriverManager.getConnection(url,"<USERNAME>", "<PASSWORD>");
				float ship_units = 1.0f; 
				float ship_weight = 1.0f;
				if(request.getParameter("current_line_id_remove")==null){
				
					PreparedStatement ps = connection.prepareStatement("Update test.load_board_line Set pickup_date = ?, type = ?, description= ?, po_numbers = ?, shipper_id = ?, units = ?, weight = ?, notes = ?, customs_id = ? where load_line_id = ?");

					if(!request.getParameter("ship_units").equals(""))ship_units = Float.parseFloat(request.getParameter("ship_units").trim());
					if(!request.getParameter("ship_weight").equals(""))ship_weight = Float.parseFloat(request.getParameter("ship_weight").trim());

					DateFormat formatter = new SimpleDateFormat("MM-dd-yyyy:HH:mm:ss");		
					java.sql.Timestamp pickup_date_sql = null;
					if(request.getParameter("pickup_date")!=null && !request.getParameter("pickup_date").equals("")){
						if(request.getParameter("pickup_time")!=null && !request.getParameter("pickup_time").equals("")){
							pickup_date_sql = new java.sql.Timestamp((formatter.parse(request.getParameter("pickup_date") + ":" + request.getParameter("pickup_time") + ":00" )).getTime());
						}else{
							pickup_date_sql = new java.sql.Timestamp((formatter.parse(request.getParameter("pickup_date") + ":00:00:01" )).getTime());

						}
					}
					ps.setTimestamp(1, pickup_date_sql);
					ps.setString(2, request.getParameter("ship_type"));	
					ps.setString(3, request.getParameter("ship_description"));	
					ps.setString(4, request.getParameter("ship_po"));	
					ps.setString(5, request.getParameter("current_ship_22_id"));	
					ps.setFloat(6, ship_units);	
					ps.setFloat(7, ship_weight);	
					ps.setString(8, request.getParameter("ship_note"));
					ps.setString(9, request.getParameter("current_customs_broker_id"));	

					if(request.getParameter("current_line_id")!=null && !request.getParameter("current_line_id").equals("")){
						ps.setString(10, request.getParameter("current_line_id"));
					}else{	
						ps.setString(10, current_line_id);
					}
					System.out.println("XXX :" + current_line_id);
					System.out.println("XXX :" + request.getParameter("current_ship_22_id"));
					System.out.println("XXX :" + request.getParameter("current_customs_broker_id"));
					ps.executeUpdate();	
				
				}
			
			
			PreparedStatement psMain = connection.prepareStatement("select * from test.locations right join test.load_board_line on locations.location_id=load_board_line.shipper_id WHERE load_board_line.COMPANY_ID = ? and load_id = ? order by load_board_line.ts asc");
			psMain.setString(1, uuid);
			psMain.setString(2, request.getParameter("load_id"));
			ResultSet resultSet = psMain.executeQuery();
			while (resultSet.next()) {
				String tab_label = "New";
				if(resultSet.getString("shipper_id")!=null && !resultSet.getString("shipper_id").equals("")){
					tab_label = resultSet.getString("org_name");
				}
				%>
				<%if(ship_line_id.equals(resultSet.getString("load_line_id"))){ %>

					<% responseText = responseText + "<li class=\"active\" ><a href=\"#home\" onclick=\"viewShipper('" +resultSet.getString("load_line_id")+ "')\" >" +tab_label + "</a></li>";%>
					<%
					String pickDate = "";
					String pickTime = "";
					if(resultSet.getTimestamp("pickup_date")!=null){
						pickDate = new SimpleDateFormat("MM-dd-yyyy").format(resultSet.getTimestamp("pickup_date"));
						pickTime = new SimpleDateFormat("HH:mm").format(resultSet.getTimestamp("pickup_date"));
					}					
					   responseFields = responseFields + NullCheck.check(resultSet.getString("shipper_id")) + "<ITEM>";
					   responseFields = responseFields + NullCheck.check(resultSet.getString("description")) + "<ITEM>";
					   responseFields = responseFields + NullCheck.check(resultSet.getString("type")) + "<ITEM>";
					   responseFields = responseFields + NullCheck.check(resultSet.getString("units")) + "<ITEM>";
					   responseFields = responseFields + NullCheck.check(resultSet.getString("weight")) + "<ITEM>";
					   responseFields = responseFields + NullCheck.check(resultSet.getString("load_board_line.notes")) + "<ITEM>";
					   responseFields = responseFields + NullCheck.check(resultSet.getString("po_numbers")) + "<ITEM>";
					   responseFields = responseFields + NullCheck.check(pickDate) + "<ITEM>";
					   responseFields = responseFields + NullCheck.check(pickTime) + "<ITEM>";
				   	if(resultSet.getString("shipper_id")!=null && !resultSet.getString("shipper_id").equals("")){
					   responseFields = responseFields + NullCheck.check(resultSet.getString("shipper_id")) + "<ITEM>";
					   responseFields = responseFields + NullCheck.check(resultSet.getString("org_name")) + "<ITEM>";
					   responseFields = responseFields + NullCheck.check(resultSet.getString("address")) + "<ITEM>";	
					}else{					
					   responseFields = responseFields + "<ITEM>";
					   responseFields = responseFields + "<ITEM>";
					   responseFields = responseFields + "<ITEM>";	
					}
				   	if(resultSet.getString("customs_id")!=null && !resultSet.getString("customs_id").equals("")){
						psMain = connection.prepareStatement("select * from test.locations WHERE COMPANY_ID = ? and location_id = ?");
						psMain.setString(1, uuid);
						psMain.setString(2, resultSet.getString("customs_id"));
						ResultSet resultSetCustoms = psMain.executeQuery();
						while (resultSetCustoms.next()) {
						   responseFields = responseFields + NullCheck.check(resultSet.getString("customs_id")) + "<ITEM>";
						   responseFields = responseFields + NullCheck.check(resultSetCustoms.getString("org_name")) + "<ITEM>";
						   responseFields = responseFields + NullCheck.check(resultSetCustoms.getString("address")) + "<ITEM>";
						}	
					}else{					
						   responseFields = responseFields + "<ITEM>";
						   responseFields = responseFields + "<ITEM>";
					   	   responseFields = responseFields + "<ITEM>";	
					}
				  } else { 
				  	responseText = responseText + "<li ><a href=\"#home\" onclick=\"viewShipper('" + resultSet.getString("load_line_id")+ "')\">" +tab_label + "</a></li>"; 
				  }
			}
			connection.close();
	         }catch (Exception ex){
	             System.out.println(""+ ex);
	         }		
			%>
		<%}%>
			<%
			
			responseText = responseText + "<li><a href=\"#menu1\" onclick=\"addShipper()\" ><span class=\"glyphicon glyphicon-plus\" ></span></a></li>";
			responseText = responseText + "<input type=\"hidden\" value=\"" + shipper_count + "\" id=\"shipper_count\" name=\"shipper_count\" />";
			responseText = responseText + "<input type=\"hidden\" value=\"" + ship_line_id + "\" id=\"current_line_id\" name=\"current_line_id\" />";
			System.out.println(responseText);
			System.out.println(responseFields);
			%>
		<%=responseText + "<ITEM>" + responseFields %>
	  
<%}%>	  