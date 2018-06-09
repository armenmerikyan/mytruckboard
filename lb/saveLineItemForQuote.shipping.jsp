<%@ page import="com.big.util.*,java.text.*,java.util.*,java.io.*,javax.xml.parsers.*,org.w3c.dom.*,java.sql.*,java.text.DateFormat,java.net.URL" %>			
<%@ page import="javax.mail.*" %>
<%@ page import="javax.mail.internet.*" %>
<%@ page import="java.util.*" %>
<%@ page import="com.twilio.sdk.TwilioRestClient" %>
<%@ page import="com.twilio.sdk.resource.factory.SmsFactory" %>
<%@ page import="com.twilio.sdk.resource.instance.Sms" %>
<%
String uuid = (String)session.getAttribute("uuid");
boolean needStatusUpdate = false;
if(uuid !=null){
		 try{
			Class.forName("com.mysql.jdbc.Driver");
			String url = "jdbc:mysql://localhost/test?zeroDateTimeBehavior=convertToNull";		
			Connection connection = DriverManager.getConnection(url,"<USERNAME>", "<PASSWORD>");	
				int qt = 0;
				float length = 0.0f;
				float height = 0.0f;
				int weight = 0; 
				float width = 0.0f;
				PreparedStatement ps ;
				if(request.getParameter("actionType") != null && !request.getParameter("actionType").equals("") && request.getParameter("actionType").equals("addItem")){
					DateFormat formatter = new SimpleDateFormat("MM-dd-yyyy.HH.mm.ss");		
					java.sql.Date drop_date_sql = null;
					java.sql.Date pickup_date_sql = null;
					//if(request.getParameter("drop_date")!=null && !request.getParameter("drop_date").equals(""))drop_date_sql = new java.sql.Date(((java.util.Date)formatter.parse(request.getParameter("drop_date") + ".00.00.00" )).getTime());
					//if(request.getParameter("pickup_date")!=null && !request.getParameter("drop_date").equals(""))pickup_date_sql = new java.sql.Date(((java.util.Date)formatter.parse(request.getParameter("pickup_date") + ".00.00.00" )).getTime());
					System.out.println("ETERNAMLLLLLL ID: " + request.getParameter("external_id"));
					System.out.println("ETERNAMLLLLLL ID: " + request.getParameter("description"));
					System.out.println("ETERNAMLLLLLL ID: " + request.getParameter("qt"));
					System.out.println("ETERNAMLLLLLL ID: " + request.getParameter("length"));
					System.out.println("ETERNAMLLLLLL ID: " + request.getParameter("width"));
					System.out.println("ETERNAMLLLLLL ID: " + request.getParameter("height"));
					System.out.println("ETERNAMLLLLLL ID: " + request.getParameter("weight"));
					if(!request.getParameter("qt").equals(""))qt = Integer.parseInt(request.getParameter("qt").trim());
					if(!request.getParameter("length").equals(""))length = Float.parseFloat(request.getParameter("length").trim());
					if(!request.getParameter("width").equals(""))width = Float.parseFloat(request.getParameter("width").trim());		
					if(!request.getParameter("height").equals(""))height = Float.parseFloat(request.getParameter("height").trim());		
					if(!request.getParameter("weight").equals(""))weight = Integer.parseInt(request.getParameter("weight").trim());		
				
					ps = connection.prepareStatement("INSERT INTO test.trucking_quote_lineitem_shipping(line_item_id, external_id, ts, description, type, qt, length, width, height, weight, quote_id) VALUES (?,?,?,?,?,?,?,?,?,?,?)");				
					ps.setString(1, UUID.randomUUID() + "");
					ps.setString(2, request.getParameter("external_id"));
					ps.setTimestamp(3, new java.sql.Timestamp((new java.util.Date()).getTime()));	
					ps.setString(4, request.getParameter("description"));
					ps.setString(5, request.getParameter("type"));	
					ps.setInt(6, qt);	
					ps.setFloat(7, length);
					ps.setFloat(8, width);
					ps.setFloat(9, height);
					ps.setInt(10, weight);
					ps.setString(11, request.getParameter("quote_id"));	
					ps.executeUpdate();	
				}
				if(request.getParameter("actionType") != null && !request.getParameter("actionType").equals("") && request.getParameter("actionType").equals("removeItem")){
					ps = connection.prepareStatement("delete from test.trucking_quote_lineitem_shipping where line_item_id = ?");				
					ps.setString(1, request.getParameter("line_item_id"));	
					ps.executeUpdate();					
				}
				%>
  <table class="table">   
    <thead>
      <tr>
        <th>External ID</th>
        <th>Desciption</th>
        <th>Type</th>
        <th>Qt.</th>
        <th>Length</th>
        <th>Width</th>
        <th>Height</th>
        <th>Weight</th>
        <th>&nbsp;</th>
      </tr>
    </thead>  
    <tbody>
      <tr>
        <td>
<div class="input-group">
  <span class="input-group-addon" id="basic-addon1"></span>
  <input type="text" class="form-control"  aria-describedby="basic-addon1"  name="external_id" id="external_id" value="">
</div> </td>
        <td>
<div class="input-group">
  <span class="input-group-addon" id="basic-addon1"></span>
  <input type="text" class="form-control"  aria-describedby="basic-addon1"  name="descriptionItem" id="description" value="">
</div> </td>
        <td>
<div class="input-group">
  <span class="input-group-addon" id="basic-addon1"></span>
  <input type="text" class="form-control"  aria-describedby="basic-addon1"  name="typeItem" id="type" value="">
</div> </td>
        <td>
<div class="input-group">
  <span class="input-group-addon" id="basic-addon1"></span>
  <input type="text" class="form-control"  aria-describedby="basic-addon1"  name="qt" id="qt" value="1">
</div> </td>
        <td>
<div class="input-group">
  <span class="input-group-addon" id="basic-addon1"></span>
  <input type="text" class="form-control"  aria-describedby="basic-addon1"  name="lengthLIMTB" id="lengthLIMTB" value="">
</div> </td>
        <td>
<div class="input-group">
  <span class="input-group-addon" id="basic-addon1"></span>
  <input type="text" class="form-control"  aria-describedby="basic-addon1"  name="widthLIMTB" id="widthLIMTB" value="">
</div> </td>
        <td>
<div class="input-group">
  <span class="input-group-addon" id="basic-addon1"></span>
  <input type="text" class="form-control"  aria-describedby="basic-addon1"  name="heightLIMTB" id="heightLIMTB" value="">
</div> </td>
        <td>
<div class="input-group">
  <span class="input-group-addon" id="basic-addon1"></span>
  <input type="text" class="form-control"  aria-describedby="basic-addon1"  name="weightLIMTB" id="weightLIMTB" value="">
</div> </td>

        <td>        
<div class="input-group"><a class="btn btn-primary" href="javascript:void(0)" role="button" onclick="addLineItem('addItem');"><span class="glyphicon glyphicon-plus" aria-hidden="true"></span></a>
</div> </td>
      </tr>
      <%
				ps = connection.prepareStatement("select * from test.trucking_quote_lineitem_shipping where quote_id = ? order by ts desc ");
				ps.setString(1, request.getParameter("quote_id"));
				ResultSet resultSet = ps.executeQuery();
				String stringResponseAll =  new String();				
				while (resultSet.next()) {				
					//stringResponseAll = stringResponseAll + "Start<FIELD>" + resultSet.getString("type") + "<FIELD>" + resultSet.getString("description") + "<FIELD>Done<ROW>" ;
					%>	
      <tr>
        <td>
<div class="input-group">
  <span class="input-group-addon" id="basic-addon1"></span>
  <input type="text" class="form-control"  aria-describedby="basic-addon1"  name="external_id" id="external_id" value="<%=resultSet.getString("external_id")%>">
</div> </td>
        <td>
<div class="input-group">
  <span class="input-group-addon" id="basic-addon1"></span>
  <input type="text" class="form-control"  aria-describedby="basic-addon1"  name="descriptionItem" id="description" value="<%=resultSet.getString("description")%>">
</div> </td>
        <td>
<div class="input-group">
  <span class="input-group-addon" id="basic-addon1"></span>
  <input type="text" class="form-control"  aria-describedby="basic-addon1"  name="typeItem" id="type" value="<%=resultSet.getString("type")%>">
</div> </td>
        <td>
<div class="input-group">
  <span class="input-group-addon" id="basic-addon1"></span>
  <input type="text" class="form-control"  aria-describedby="basic-addon1"  name="qt" id="qt" value="<%=resultSet.getString("qt")%>">
</div> </td>
        <td>
<div class="input-group">
  <span class="input-group-addon" id="basic-addon1"></span>
  <input type="text" class="form-control"  aria-describedby="basic-addon1"  name="lengthLIMTB" id="lengthLIMTB" value="<%=resultSet.getString("length")%>">
</div> </td>
        <td>
<div class="input-group">
  <span class="input-group-addon" id="basic-addon1"></span>
  <input type="text" class="form-control"  aria-describedby="basic-addon1"  name="widthLIMTB" id="widthLIMTB" value="<%=resultSet.getString("width")%>">
</div> </td>
        <td>
<div class="input-group">
  <span class="input-group-addon" id="basic-addon1"></span>
  <input type="text" class="form-control"  aria-describedby="basic-addon1"  name="heightLIMTB" id="heightLIMTB" value="<%=resultSet.getString("height")%>">
</div> </td>
        <td>
<div class="input-group">
  <span class="input-group-addon" id="basic-addon1"></span>
  <input type="text" class="form-control"  aria-describedby="basic-addon1"  name="weightLIMTB" id="weightLIMTB" value="<%=resultSet.getString("weight")%>">
</div> </td>

        <td>        
<div class="input-group"><a class="btn btn-primary" href="javascript:void(0)" role="button" onclick="addLineItem('removeItem','<%=resultSet.getString("line_item_id")%>');"><span class="glyphicon glyphicon-minus" aria-hidden="true"></span></a>
</div> </td>
      </tr>      
					<%
				}	
				connection.close();	
			%>      
    </tbody>
  </table>  		<%
		 }catch (Exception ex){	         
		     %><%="Error Posting " + ex%><%  
		     System.out.println(""+ ex + "Rate : " + request.getParameter("per_mile"));
		 }				
				%>	
<%}else{%>
	        	<a href="../index4.html">Please Login</a>
<%}%>