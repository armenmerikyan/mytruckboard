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
			
			PreparedStatement ps = connection.prepareStatement("select * from test.load_board_finance WHERE load_board_finance.COMPANY_ID = ? and load_id = ? and fin_type = ? order by ts desc");
			ps.setString(1, uuid);
			ps.setString(2, request.getParameter("load_id"));
			ps.setString(3, request.getParameter("new_fin_type"));
			ResultSet resultSet = ps.executeQuery();
			
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
			%>  		
			<div class="row">
			<div class="col-md-3" style="padding:5px;"></div>
			<div class="col-md-5" style="padding:5px;"><h3 class="pull-right">Total</h3></div>
			<div class="col-md-4" style="padding:5px;">
			<h3 class="pull-right"><%=total_fin%>&nbsp;</h3></div></div>
			<BR><ITEM>Start<ITEM><%=total_fin%><ITEM>True<ITEM><%=location_id%><ITEM><%=request.getParameter("new_fin_name")%><ITEM><%=request.getParameter("new_fin_type")%><ITEM>DONE<%
			connection.close();
		 }catch (Exception ex){
		     %><%="Error Posting " + ex%><%
		     System.out.println(""+ ex);
		 }
				%>

 <%}else{%>
Login Error
<%}%>