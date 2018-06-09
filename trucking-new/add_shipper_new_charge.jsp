<%@ page import="com.big.util.*,java.text.*,java.util.*,java.io.*,javax.xml.parsers.*,org.w3c.dom.*,java.sql.*,java.text.DateFormat" %>
<%@ page import="javax.mail.*" %>
<%@ page import="javax.mail.internet.*" %>
<%@ page import="java.util.*" %>

<%@ page import="com.twilio.sdk.TwilioRestClient" %>
<%@ page import="com.twilio.sdk.resource.factory.SmsFactory" %>
<%@ page import="com.twilio.sdk.resource.instance.Sms" %><%
     final String ACCOUNT_SID = "ACbc6b5f29c1627c6aa7e51f5ad340fa2d";
     final String AUTH_TOKEN = "767154b209800bd1be13e38d8a01fc1b";
			
    String FROM = "info@ipubsub.com";   // Replace with your "From" address. This address must be verified.
    String SMTP_USERNAME = "AKIAINFCRKGVZNSB7DHQ";  // Replace with your SMTP username.
    String SMTP_PASSWORD = "Ar/mcRQJkM9i7Vl45r+CzSrgx/QGb+vuJIuIDfJp/mj8";  // Replace with your SMTP password.
    String HOST = "email-smtp.us-east-1.amazonaws.com";    
    int PORT = 25;

String uuid = (String)session.getAttribute("uuid");
boolean needStatusUpdate = false;
if(uuid !=null){
%>
            <%
            
		try{
				if(request.getParameter("new_fin_name_notesms")!=null && !request.getParameter("new_fin_name_notesms").equals("")){
					String login_id = (String)session.getAttribute("login_id");
					Class.forName("com.mysql.jdbc.Driver");
					String url = "jdbc:mysql://localhost/test?zeroDateTimeBehavior=convertToNull";		
					Connection connection = DriverManager.getConnection(url,"<USERNAME>", "<PASSWORD>");
					PreparedStatement ps = connection.prepareStatement("select * from test.load_board left join test.trucking_equipment on load_board.load_equipment_id=trucking_equipment.id left join test.locations on load_board.bill_to_id = locations.location_id WHERE load_board.COMPANY_ID = ? and load_board.load_board_id = ? order by load_board.ts asc");			
					ps.setString(1, uuid);
					ps.setString(2, request.getParameter("load_id"));
					ResultSet resultSet = ps.executeQuery();
					while (resultSet.next()) {				
						System.out.println(request.getParameter("equipmentID"));
						TwilioRestClient client = new TwilioRestClient(ACCOUNT_SID, AUTH_TOKEN);
						Map<String, String> params = new HashMap<String, String>();								
						params.put("Body", "myTruckBoard.com message from " + (String)session.getAttribute("f_name") + " " +request.getParameter("new_fin_name") + " $" + request.getParameter("new_fin_amount") + " " + request.getParameter("new_fin_name_notesms") );
						params.put("To", "+1" + resultSet.getString("trucking_equipment.PHONE"));
						params.put("From", "+14242887641");
						SmsFactory messageFactory = client.getAccount().getSmsFactory();
						Sms message = messageFactory.create(params);
						System.out.println(message.getSid());	    										
						System.out.print("Message Send TRUE : ");   
					}
				}			
		 }catch (Exception ex){
		 }            
		 try{

			Class.forName("com.mysql.jdbc.Driver");
			String url = "jdbc:mysql://localhost/test?user=<PASSWORD>&password=<PASSWORD>";


			Connection connection = DriverManager.getConnection(url,"<USERNAME>", "<PASSWORD>");
			DateFormat formatter = new SimpleDateFormat("MM-dd-yyyy:HH:mm:ss");
			DateFormat formatterDate = new SimpleDateFormat("MM-dd-yyyy");
			Calendar cal = Calendar.getInstance();
			java.sql.Timestamp date_mod = null;
			String location_id = UUID.randomUUID() + "";
			float fin_amount = 0.0f;
			
			PreparedStatement ps = connection.prepareStatement("INSERT INTO test.load_board_finance(fin_id, ts, company_id, created_by, load_id, fin_name, fin_type, fin_date, fin_amount, fin_name_note, fin_name_notesms) VALUES (?,?,?,?,?,?,?,?,?,?,?)");

			if(request.getParameter("fin_remove")!=null &&  !request.getParameter("fin_remove").equals("")){
				ps = connection.prepareStatement("delete from test.load_board_finance where fin_id = ? and company_id = ?");
				ps.setString(1, request.getParameter("fin_id"));
				ps.setString(2, uuid);
				ps.executeUpdate();			
			}else{
			
				String cc = "";
				StringBuilder sb = new StringBuilder("None".length());
				if(request.getParameter("new_fin_name_notesms")!=null){
					cc = request.getParameter("new_fin_name_notesms");
					sb = new StringBuilder(cc.length());
				    for (int i = 0; i < cc.length(); i++) {
					if(i< cc.length()-4)sb.append('*');
					else sb.append(cc.substring(i, i+1));
				    }		
				}
				if(request.getParameter("new_fin_date")!=null &&  !request.getParameter("new_fin_date").equals("")){
					date_mod = new java.sql.Timestamp((formatter.parse(request.getParameter("new_fin_date") + ":00:00:02" )).getTime());					
				}else{
					date_mod = new java.sql.Timestamp((new java.util.Date()).getTime());									
				}
				if(!request.getParameter("new_fin_amount").equals(""))fin_amount = Float.parseFloat(request.getParameter("new_fin_amount").trim());
				ps.setString(1, location_id);
				java.sql.Timestamp ts = new java.sql.Timestamp((new java.util.Date()).getTime());
				ps.setTimestamp(2, ts);
				ps.setString(3, uuid);
				ps.setString(4, (String)session.getAttribute("login_id"));
				ps.setString(5, request.getParameter("load_id"));
				ps.setString(6, request.getParameter("new_fin_name"));
				ps.setString(7, request.getParameter("new_fin_type"));
				ps.setTimestamp(8, date_mod);
				ps.setFloat(9, fin_amount);
				ps.setString(10, request.getParameter("new_fin_name_note"));
				ps.setString(11, sb.toString());
				ps.executeUpdate();
			}
			float total_fin_due = 0.0f;
			float total_fin_car_due = 0.0f;
			ps = connection.prepareStatement("select * from test.load_board WHERE load_board.load_board_id = ? and company_id = ? order by ts desc");
			ps.setString(1, request.getParameter("load_id"));
			ps.setString(2, uuid);
			ResultSet resultSet = ps.executeQuery();
			while (resultSet.next()) {
				total_fin_due = (((resultSet.getFloat("load_rate") * resultSet.getFloat("load_units")) +resultSet.getFloat("load_other")) - resultSet.getFloat("bill_to_advances"));	
				total_fin_car_due = (resultSet.getFloat("carrier_rate") +resultSet.getFloat("load_carrier_fee")) - resultSet.getFloat("advances_total");		
			}				
			ps = connection.prepareStatement("select * from test.load_board_finance WHERE load_board_finance.COMPANY_ID = ? and load_id = ? and fin_type = ? order by ts desc");
			ps.setString(1, uuid);
			ps.setString(2, request.getParameter("load_id"));
			ps.setString(3, request.getParameter("new_fin_type"));
			resultSet = ps.executeQuery();
			
			float total_fin = 0.0f;
			while (resultSet.next()) {
				String tmp_fin_date = "";
				if(resultSet.getTimestamp("fin_date")!=null){
				tmp_fin_date = new SimpleDateFormat("MM-dd-yyyy").format(resultSet.getTimestamp("fin_date"));
				}	
				total_fin = total_fin + resultSet.getFloat("fin_amount");
				%>  
				
  		<div class="row">
			<div class="col-md-3" style="padding:5px;">
			    <div class='input-group date' id='datetimepicker99'>
			    <span class="input-group-addon">
			    <span class="glyphicon glyphicon-calendar"></span>
			    </span>
			    <input type='text' style="font-size: 14px; padding-left: 5px; padding-right: 2px;" class="form-control" id="new_advances_date<%=resultSet.getString("fin_id")%>" name="new_advances_date<%=resultSet.getString("fin_id")%>" value="<%=tmp_fin_date%>" placeholder="Date">
			    </div>  
			</div>
			<div class="col-md-5" style="padding:5px;">
            
				<div class="input-group">
			  <span class="input-group-addon" id="basic-addon1">Name</span>
		  <input type="text" class="form-control"  aria-describedby="basic-addon1"  name="new_advances_name<%=resultSet.getString("fin_id")%>" id="new_advances_name<%=resultSet.getString("fin_id")%>" value="<%=resultSet.getString("fin_name")%>" placeholder="Name">
				</div>
        		</div> 
			<div class="col-md-4" style="padding:5px;">  
				<div class="input-group">
  <span class="input-group-addon" id="basic-addon1">Amount</span>
  <input type="text" class="form-control"  aria-describedby="basic-addon1"  name="new_advances_amount<%=resultSet.getString("fin_id")%>" id="new_advances_amount<%=resultSet.getString("fin_id")%>" value="<%=resultSet.getString("fin_amount")%>" placeholder="" >
      	<span onclick="removeFin('<%=resultSet.getString("fin_id")%>','<%=resultSet.getString("fin_type")%>')" class="input-group-addon" id="basic-addon1"><span class="glyphicon glyphicon-trash" aria-hidden="true"></span></span>
				</div>
			 </div>
        	</div>	
        	<%if(resultSet.getString("fin_name_note") !=null && !resultSet.getString("fin_name_note").equals("")){%>
  		<div class="row">
			<div class="col-md-12" style="padding:5px;">
			<input type="text" class="form-control"  aria-describedby="basic-addon1"  name="new_advances_name_note<%=resultSet.getString("fin_id")%>" id="new_advances_name_note<%=resultSet.getString("fin_id")%>" value="<%=resultSet.getString("fin_name_note")%>" placeholder="Note">			
			 </div>
        	</div>		
        	<%}%>
        	<%if(resultSet.getString("fin_name_notesms") !=null && !resultSet.getString("fin_name_notesms").equals("")){%>
  		<div class="row">
			<div class="col-md-12" style="padding:5px;">
			<input type="text" class="form-control"  aria-describedby="basic-addon1"  name="new_advances_name_notesms<%=resultSet.getString("fin_id")%>" id="new_advances_name_notesms<%=resultSet.getString("fin_id")%>" value="<%=resultSet.getString("fin_name_notesms")%>" placeholder="SMS Code">			
			 </div>
        	</div>		
        	<%}%>
				<%
			}
			total_fin_due = total_fin_due - total_fin;
			total_fin_car_due = total_fin_car_due - total_fin;
			%>  		
			<div class="row">
			<div class="col-md-3" style="padding:5px;"></div>
			<div class="col-md-5" style="padding:5px;"><h3 class="pull-right">Total</h3></div>
			<div class="col-md-4" style="padding:5px;">
			<h3 class="pull-right"><%=total_fin%>&nbsp;</h3></div></div>
			<BR><ITEM>Start<ITEM><%=total_fin%><ITEM>True<ITEM><%=location_id%><ITEM><%=request.getParameter("new_fin_name")%><ITEM><%=request.getParameter("new_fin_type")%><ITEM><%=request.getParameter("load_id")%><ITEM><%=total_fin_due%><ITEM><%=total_fin_car_due%><ITEM>DONE<%
			connection.close();
		 }catch (Exception ex){
		     %><%="Error Posting " + ex%><%
		     System.out.println(""+ ex);
		 }
				%>

 <%}else{%>
Login Error
<%}%>