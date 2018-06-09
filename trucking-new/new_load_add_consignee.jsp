<%@ page import="com.big.mtb.business.Order,java.util.Vector,com.big.util.*,java.text.*,java.util.*,java.io.*,javax.xml.parsers.*,org.w3c.dom.*,java.sql.*,java.text.DateFormat" %><%
String uuid = (String)session.getAttribute("uuid");
boolean needStatusUpdate = false;
if(uuid !=null){
%>
		     <% int consignee_count = Integer.parseInt(request.getParameter("consignee_count"));
		         String responseText = "";
			String responseFields = "";
			String totalCount = "0";
			%>
		<% String consignee_line_id = request.getParameter("consignee_line_id");%>
		<% String current_line_id = request.getParameter("current_consignee_line_id");%>
		<% System.out.println("COOL YO" + request.getParameter("consignee_line_id"));%>
		
		<%if(request.getParameter("current_line_id_remove")!=null){%>			
		<%
			 try{
				System.out.println("consignee_line_id_new : " + request.getParameter("consignee_line_id_new"));
				Class.forName("com.mysql.jdbc.Driver");
				String url = "jdbc:mysql://localhost/test?zeroDateTimeBehavior=convertToNull";
				Connection connection = DriverManager.getConnection(url,"<USERNAME>", "<PASSWORD>");
				PreparedStatement ps = null;

				ps = connection.prepareStatement("select count(distinct(load_line_id)) as itemCount from load_board_line_consignee where company_id = ? and load_id = ?");	
				ps.setString(1, uuid);
				ps.setString(2, request.getParameter("load_id"));
				ResultSet resultSet = ps.executeQuery();
				while (resultSet.next()) {
					if(resultSet.getInt("itemCount")>1){
						ps = connection.prepareStatement("delete from test.load_board_line_consignee where load_line_id = ? and company_id = ?");
						ps.setString(1, request.getParameter("current_line_id_remove"));
						ps.setString(2, uuid);
						ps.executeUpdate();	
						ps = connection.prepareStatement("select * from test.load_board_line_consignee where company_id = ? and load_id = ? order by ts desc limit 1");	
						ps.setString(1, uuid);
						ps.setString(2, request.getParameter("load_id"));
						resultSet = ps.executeQuery();
						while (resultSet.next()) {
							consignee_line_id = resultSet.getString("load_line_id");
						}
					}else{
						consignee_line_id = request.getParameter("current_line_id_remove");
					}
				}
				connection.close();
			 }catch (Exception ex){
			     System.out.println(""+ ex);
			 }
				%>
		<%} else if(request.getParameter("consignee_line_id_new")!=null){%>		
		<%
	         try{
	         	System.out.println("consignee_line_id_new : " + request.getParameter("consignee_line_id_new"));
			Class.forName("com.mysql.jdbc.Driver");
			String url = "jdbc:mysql://localhost/test?zeroDateTimeBehavior=convertToNull";
			Connection connection = DriverManager.getConnection(url,"<USERNAME>", "<PASSWORD>");
			PreparedStatement ps = null;
				System.out.println(consignee_count + "XXXX");				
				current_line_id = UUID.randomUUID() +"";
				consignee_line_id = current_line_id;
				ps = connection.prepareStatement("INSERT INTO test.load_board_line_consignee(load_line_id, load_id, ts, company_id, created_by) VALUES (?,?,?,?,?)");
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
		<%}else if(request.getParameter("consignee_line_id")==null && request.getParameter("consignee_line_id_new")==null){%>
			<% consignee_count += 1;%>
		<%
	         try{
			Class.forName("com.mysql.jdbc.Driver");
			String url = "jdbc:mysql://localhost/test?zeroDateTimeBehavior=convertToNull";
			Connection connection = DriverManager.getConnection(url,"<USERNAME>", "<PASSWORD>");
			PreparedStatement ps = null;
				System.out.println(consignee_count + "XXXX");
	         	if(consignee_count ==1){
				ps = connection.prepareStatement("select count(distinct(load_line_id)) as itemCount from load_board_line_consignee where company_id = ? and load_id = ?");	
				ps.setString(1, uuid);
				ps.setString(2, request.getParameter("load_id"));
				ResultSet resultSet = ps.executeQuery();
				while (resultSet.next()) {
					totalCount = resultSet.getString("itemCount");
				}
				if(totalCount.equals("0")){
					current_line_id = UUID.randomUUID() +"";
					ps = connection.prepareStatement("INSERT INTO test.load_board_line_consignee(load_line_id, load_id, ts, company_id, created_by) VALUES (?,?,?,?,?)");
					ps.setString(1, current_line_id);
					ps.setString(2, request.getParameter("load_id"));
					java.sql.Timestamp ts = new java.sql.Timestamp((new java.util.Date()).getTime());
					ps.setTimestamp(3, ts);
					ps.setString(4, uuid);
					ps.setString(5, (String)session.getAttribute("login_id"));
					ps.executeUpdate();				
				}
	         	}
			
			consignee_line_id = UUID.randomUUID() +"";

			ps = connection.prepareStatement("INSERT INTO test.load_board_line_consignee(load_line_id, load_id, ts, company_id, created_by) VALUES (?,?,?,?,?)");
			ps.setString(1, consignee_line_id);
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
				
					PreparedStatement ps = connection.prepareStatement("Update test.load_board_line_consignee Set pickup_date = ?, type = ?, description= ?, po_numbers = ?, consignee_id = ?, units = ?, weight = ?, notes = ? where load_line_id = ?");

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
					ps.setString(5, request.getParameter("current_consignee_22_id"));	
					ps.setFloat(6, ship_units);	
					ps.setFloat(7, ship_weight);	
					ps.setString(8, request.getParameter("ship_note"));	

					if(request.getParameter("current_consignee_line_id")!=null && !request.getParameter("current_consignee_line_id").equals("")){
						ps.setString(9, request.getParameter("current_consignee_line_id"));
					}else{	
						ps.setString(9, current_line_id);
					}
					System.out.println("XXX :" + current_line_id);
					System.out.println("XXX :" + request.getParameter("current_consignee_22_id"));
					ps.executeUpdate();	
				
				}
			
			
			PreparedStatement psMain = connection.prepareStatement("select * from test.locations right join test.load_board_line_consignee on locations.location_id=load_board_line_consignee.consignee_id WHERE load_board_line_consignee.COMPANY_ID = ? and load_id = ? order by load_board_line_consignee.ts asc");
			psMain.setString(1, uuid);
			psMain.setString(2, request.getParameter("load_id"));
			ResultSet resultSet = psMain.executeQuery();
			while (resultSet.next()) {
				String tab_label = "New";
				if(resultSet.getString("consignee_id")!=null && !resultSet.getString("consignee_id").equals("")){
					tab_label = resultSet.getString("org_name");
				}
				%>
				<%if(consignee_line_id.equals(resultSet.getString("load_line_id"))){ %>

					<% responseText = responseText + "<li class=\"active\" ><a href=\"#home\" onclick=\"viewConsignee('" +resultSet.getString("load_line_id")+ "')\" >" +tab_label + "</a></li>";%>
					<%
					String pickDate = "";
					String pickTime = "";
					if(resultSet.getTimestamp("pickup_date")!=null){
						pickDate = new SimpleDateFormat("MM-dd-yyyy").format(resultSet.getTimestamp("pickup_date"));
						pickTime = new SimpleDateFormat("HH:mm").format(resultSet.getTimestamp("pickup_date"));
					}					
					   responseFields = responseFields + NullCheck.check(resultSet.getString("consignee_id")) + "<ITEM>";
					   responseFields = responseFields + NullCheck.check(resultSet.getString("description")) + "<ITEM>";
					   responseFields = responseFields + NullCheck.check(resultSet.getString("type")) + "<ITEM>";
					   responseFields = responseFields + NullCheck.check(resultSet.getString("units")) + "<ITEM>";
					   responseFields = responseFields + NullCheck.check(resultSet.getString("weight")) + "<ITEM>";
					   responseFields = responseFields + NullCheck.check(resultSet.getString("load_board_line_consignee.notes")) + "<ITEM>";
					   responseFields = responseFields + NullCheck.check(resultSet.getString("po_numbers")) + "<ITEM>";
					   responseFields = responseFields + NullCheck.check(pickDate) + "<ITEM>";
					   responseFields = responseFields + NullCheck.check(pickTime) + "<ITEM>";
				   	if(resultSet.getString("consignee_id")!=null && !resultSet.getString("consignee_id").equals("")){
					   responseFields = responseFields + NullCheck.check(resultSet.getString("consignee_id")) + "<ITEM>";
					   responseFields = responseFields + NullCheck.check(resultSet.getString("org_name")) + "<ITEM>";
					   responseFields = responseFields + NullCheck.check(resultSet.getString("address")) + "<ITEM>";	
					}else{					
					   responseFields = responseFields + "<ITEM>";
					   responseFields = responseFields + "<ITEM>";
					   responseFields = responseFields + "<ITEM>";	
					}
				  } else { 
				  	responseText = responseText + "<li ><a href=\"#home\" onclick=\"viewConsignee('" + resultSet.getString("load_line_id")+ "')\">" +tab_label + "</a></li>"; 
				  }
			}
			connection.close();
	         }catch (Exception ex){
	             System.out.println(""+ ex);
	         }		
			%>
		<%}%>
			<%
			

	com.big.mtb.business.Order newOrder = new com.big.mtb.business.Order();
	newOrder.copyOrderToWebBoards(request.getParameter("load_id"), uuid);

			responseText = responseText + "<li><a href=\"#menu1\" onclick=\"addConsignee()\" ><span class=\"glyphicon glyphicon-plus\" ></span></a></li>";
			responseText = responseText + "<input type=\"hidden\" value=\"" + consignee_count + "\" id=\"consignee_count\" name=\"consignee_count\" />";
			responseText = responseText + "<input type=\"hidden\" value=\"" + consignee_line_id + "\" id=\"current_consignee_line_id\" name=\"current_consignee_line_id\" />";
			System.out.println(responseText);
			System.out.println(responseFields);
			%>
		<%=responseText + "<ITEM>" + responseFields %>
	  
<%}%>	  