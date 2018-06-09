<%@ page import="com.big.util.*,java.text.*,java.util.*,java.io.*,javax.xml.parsers.*,org.w3c.dom.*,java.sql.*,java.text.DateFormat" %>
<%
String uuid = (String)session.getAttribute("uuid");
boolean needStatusUpdate = false;
if(uuid !=null){
%>
            <%
		 try{

			Class.forName("com.mysql.jdbc.Driver");
			String url = "jdbc:mysql://localhost/test?user=<PASSWORD>&password=<PASSWORD>";

			Connection connection = DriverManager.getConnection(url,"<USERNAME>", "<PASSWORD>");

				float load_rate = 0.0f; 
				float load_units = 0.0f;
				float load_pd = 0.0f;
				float load_fsc = 0.0f;
				float load_other = 0.0f;
				float load_carrier_fee = 0.0f;
				float load_rate_all = 0.0f;
				float advances_total = 0.0f;
				float bill_to_advances_total = 0.0f;
				float carrier_rate = 0.0f;
				float gross_rate_manager = 0.0f;
				float gross_rate_sales = 0.0f;
				float gross_rate_agent = 0.0f;
				if(!request.getParameter("load_rate").equals(""))load_rate = Float.parseFloat(request.getParameter("load_rate").trim());		
				if(!request.getParameter("load_units").equals(""))load_units = Float.parseFloat(request.getParameter("load_units").trim());		
				if(!request.getParameter("load_pd").equals(""))load_pd = Float.parseFloat(request.getParameter("load_pd").trim());		
				if(!request.getParameter("load_fsc").equals(""))load_fsc = Float.parseFloat(request.getParameter("load_fsc").trim());		
				if(!request.getParameter("load_carrier_fee").equals(""))load_carrier_fee = Float.parseFloat(request.getParameter("load_carrier_fee").trim());		
				if(!request.getParameter("load_rate_all").equals(""))load_rate_all = Float.parseFloat(request.getParameter("load_rate_all").trim());		
				if(!request.getParameter("load_other_charge").equals(""))load_other = Float.parseFloat(request.getParameter("load_other_charge").trim());		
				if(!request.getParameter("load_carrier_advance").equals(""))advances_total = Float.parseFloat(request.getParameter("load_carrier_advance").trim());
				if(!request.getParameter("bill_to_advances").equals(""))bill_to_advances_total = Float.parseFloat(request.getParameter("bill_to_advances").trim());
				if(!request.getParameter("carrier_rate").equals(""))carrier_rate = Float.parseFloat(request.getParameter("carrier_rate").trim());		
			
			String load_id =  request.getParameter("load_id");
			String load_number =  request.getParameter("load_number");
			
			PreparedStatement ps = connection.prepareStatement("select count(distinct(load_board_id)) as itemCount from load_board where load_board_id = ?");				
			ps.setString(1, load_id);
			ResultSet resultSet = ps.executeQuery();
			int totalCount = 0;
			while (resultSet.next()) {
				totalCount = resultSet.getInt("itemCount");
			}
			
			if(totalCount==0){
			
				HashMap user_map = new HashMap();
				ps = connection.prepareStatement("select * from test.TRUCKING_USERS WHERE COMPANY_ID = ?");
				ps.setString(1, uuid);
				resultSet = ps.executeQuery();
				int agentCount = 0;
				int agentagentCount = 0;
				while (resultSet.next()) {
					String[] userItem = new String[6];
					userItem[0] = resultSet.getString("email");
					userItem[1] = resultSet.getString("f_name");
					userItem[2] = resultSet.getString("l_name");
					userItem[3] = resultSet.getString("phone");
					userItem[4] = resultSet.getString("pay_type");
					userItem[5] = resultSet.getString("gross_rate");
					user_map.put(resultSet.getString("email") , userItem);
					if(request.getParameter("managerID").equals(resultSet.getString("email"))){
						gross_rate_manager = resultSet.getFloat("gross_rate_manager")*.01f;
					}
					if(request.getParameter("salString").contains(resultSet.getString("email"))){
						gross_rate_sales += (resultSet.getFloat("gross_rate_sales")*.01f);
						agentCount +=1;
					}
					if(request.getParameter("disString").contains(resultSet.getString("email"))){
						gross_rate_agent += (resultSet.getFloat("gross_rate_dispatcher")*.01f);
						agentagentCount +=1;
					}
				}			
				if(agentCount!=0)gross_rate_sales = gross_rate_sales/agentCount;
				if(agentagentCount!=0)gross_rate_agent = gross_rate_agent/agentagentCount;
				gross_rate_manager = gross_rate_manager-(gross_rate_sales +gross_rate_agent);
				if(gross_rate_manager<0)gross_rate_manager=0;
				ps = connection.prepareStatement("INSERT INTO test.load_board(load_board_id, ts, load_number, load_status, load_wo, load_type, load_rate, load_units, load_pd, load_fsc_check, load_fsc, load_other, load_rate_all, load_carrier_fee, company_id, created_by, bill_to_id, load_equipment_id, disDetail, salDetail, advances_total, bill_to_advances, carrier_type, carrier_rate, load_board_id_pub,managerID, gross_rate_manager, gross_rate_sales, gross_rate_agent) VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
				ps.setString(1, load_id);
				java.sql.Timestamp ts = new java.sql.Timestamp((new java.util.Date()).getTime());
				ps.setTimestamp(2, ts);
				ps.setString(3, "");
				ps.setString(4, request.getParameter("load_status"));
				ps.setString(5, request.getParameter("load_wo"));
				ps.setString(6, request.getParameter("load_type"));
				ps.setFloat(7, load_rate);
				ps.setFloat(8, load_units);
				ps.setFloat(9, load_pd);
				ps.setInt(10, 0);
				ps.setFloat(11, load_fsc);
				ps.setFloat(12, load_other);
				ps.setFloat(13, load_rate_all);
				ps.setFloat(14, load_carrier_fee);
				ps.setString(15, uuid);
				ps.setString(16, (String)session.getAttribute("login_id"));
				ps.setString(17,  request.getParameter("current_bill_22_id"));
				ps.setString(18,  request.getParameter("current_carrier_22_id"));
				ps.setString(19,  request.getParameter("disString"));
				ps.setString(20,  request.getParameter("salString"));
				ps.setFloat(21, advances_total);
				ps.setFloat(22, bill_to_advances_total);
				ps.setString(23,  request.getParameter("load_equipment_type"));
				ps.setFloat(24, carrier_rate);
				ps.setString(25,  UUID.randomUUID() +"");
				ps.setString(26, request.getParameter("managerID"));
				ps.setFloat(27, gross_rate_manager);
				ps.setFloat(28, gross_rate_sales);
				ps.setFloat(29, gross_rate_agent);
				
				
				ps.executeUpdate();
				boolean plusTwo = false;
				for(int tc = 0;tc<20;tc++){
					ps = connection.prepareStatement("select * from test.load_board WHERE load_board.COMPANY_ID = ? order by load_board.load_number_float desc limit 1");
					ps.setString(1, uuid);
					resultSet = ps.executeQuery();
					int ln_count = 0;
					int new_ln_count = ln_count + 1;
					while (resultSet.next()) {
						if(resultSet.getString("load_number_float")!=null){
							ln_count = Integer.parseInt(resultSet.getString("load_number_float"));
						}	
							new_ln_count = ln_count + 1 + tc;
							if(plusTwo){new_ln_count = new_ln_count + 1;}
					}
					
		     			System.out.println("NEW LN NUMBER TEMP ::"+ new_ln_count  + "OLD "  + ln_count);
					ps = connection.prepareStatement("Update test.load_board Set load_number_tmp = ? where load_board_id = ? and company_id = ?");
					ps.setString(1, "LN" + new_ln_count);	
					ps.setString(2, load_id);
					ps.setString(3, uuid);	
					ps.executeUpdate();	
					
					ps = connection.prepareStatement("select * from test.load_board WHERE load_board.COMPANY_ID = ? and load_number_tmp = ?");
					ps.setString(1, uuid);
					ps.setString(2, "LN" + new_ln_count);
					ResultSet resultSetTmp = ps.executeQuery();
					boolean lockedLN = false;
					while (resultSetTmp.next()) {
						if(resultSetTmp.getString("load_board_id").equals(load_id)){
							lockedLN = true;
						}else{
							lockedLN = false;
							plusTwo = false;
							break;
						}
					}
					if(lockedLN){
						ps = connection.prepareStatement("select * from test.load_board WHERE load_board.COMPANY_ID = ? and (load_number_float = ? or load_number = ?)");
						ps.setString(1, uuid);
						ps.setFloat(2, (float)new_ln_count);
						ps.setString(3, "LN" + new_ln_count);
						resultSetTmp = ps.executeQuery();
						boolean isUsed = false;
						while (resultSetTmp.next()) {
							isUsed  = true;
							plusTwo = true;
						}
						if(!isUsed){
							ps = connection.prepareStatement("Update test.load_board Set load_number_float = ?, load_number = ? where load_board_id = ? and company_id = ?");
							ps.setFloat(1, (float)new_ln_count);
							ps.setString(2, "LN" + new_ln_count);	
							ps.setString(3, load_id);
							ps.setString(4, uuid);	
							ps.executeUpdate();	
							load_number = "LN" + new_ln_count;
							tc=21;
							break;
						}
					}								
				}
				
			}else{				
				ps = connection.prepareStatement("Update test.load_board Set load_number = ?, load_status = ?, load_wo = ?, load_type = ?, load_rate = ?, load_units = ?, load_pd = ?, load_fsc_check = ?, load_fsc =?, load_other =?, load_rate_all =?, load_carrier_fee = ?, bill_to_id = ?, load_equipment_id = ?, advances_total = ?, bill_to_advances = ?, carrier_type = ?, carrier_rate = ? where load_board_id = ? and company_id = ?");
				ps.setString(1, request.getParameter("load_number"));	
				ps.setString(2, request.getParameter("load_status"));	
				ps.setString(3, request.getParameter("load_wo"));
				ps.setString(4, request.getParameter("load_type"));
				ps.setFloat(5, load_rate);
				ps.setFloat(6, load_units);
				ps.setFloat(7, load_pd);
				ps.setInt(8, 0);
				ps.setFloat(9, load_fsc);
				ps.setFloat(10, load_other);
				ps.setFloat(11, load_rate_all);
				ps.setFloat(12, load_carrier_fee);
				ps.setString(13,  request.getParameter("current_bill_22_id"));
				ps.setString(14,  request.getParameter("current_carrier_22_id"));	
				//ps.setString(15,  request.getParameter("disString"));
				//ps.setString(16,  request.getParameter("salString"));	
				ps.setFloat(15, advances_total);				
				ps.setFloat(16, bill_to_advances_total);	
				ps.setString(17,  request.getParameter("load_equipment_type"));		
				ps.setFloat(18, carrier_rate);			
				ps.setString(19, load_id);
				ps.setString(20, uuid);
				ps.executeUpdate();			
			}
			%>Start<ITEM>True<ITEM><%=load_id%><ITEM><%=load_number%><ITEM>DONE<%
			connection.close();
		 }catch (Exception ex){
		     %><%="Error Posting " + ex%><%
		     System.out.println(""+ ex);
		 }
				%>

 <%}else{%>
Login Error
<%}%>