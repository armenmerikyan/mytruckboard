<%@ page import="com.big.braintree.GetPaymentToken,com.big.util.*,java.text.*,java.util.*,java.io.*,javax.xml.parsers.*,org.w3c.dom.*,java.sql.*,java.text.DateFormat" %>
<%
    Enumeration requestParameters = request.getParameterNames();

    while (requestParameters.hasMoreElements()) {
        String element = (String) requestParameters.nextElement();
        String value = request.getParameter(element);
        System.out.println("element " + element + " value " + value);
        if(value.contains(new StringBuilder().append("").append('\'').toString())
        || value.contains(new StringBuilder().append("").append('\"').toString())
        || value.contains(new StringBuilder().append("").append('\b').toString())
        || value.contains(new StringBuilder().append("").append('\n').toString())
        || value.contains(new StringBuilder().append("").append('\r').toString())
        || value.contains(new StringBuilder().append("").append('\t').toString())
        || value.contains(new StringBuilder().append("").append('\\').toString())
        || value.toUpperCase().contains("SELECT")
        || value.toUpperCase().contains("UPDATE")
        || value.toUpperCase().contains("DELETE")
        || value.toUpperCase().contains("DROP")
        || value.toUpperCase().contains("INSERT")
        || value.toUpperCase().contains("*")
        || value.toUpperCase().contains("$")
        ){
	        System.out.println(" SQL INJECTION ERROR :::: element " + element + " value " + value);   
	        
				response.sendRedirect("https://mytruckboard.com/mytruckboard/errorRequest.html");
        }
    }	        
%>

	<html>

	<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<meta name="description" content="">
	<meta name="author" content="">
	<title>MYTRUCKBOARD 2.0 - dispatch board</title>
	<link rel="shortcut icon" href="http://www.mytruckboard.com/trucking-new/images/mtb-favicon.ico">
	<meta http-equiv="content-type" content="text/html; charset=utf-8" />
	<meta name="description" content="The complete freight management software. Win shipping deals and manage your fleet of trucks effortlessly." />
	<meta name="keywords" content="freight, transportation, dispatch management, load optimization, truck broker, transportation management, truck, truck fleet management, shippers, truck brokers, shipping made easy, trucking industry, trucking software, trucking, dispatch for freight brokder, carrier management, load board, load, board" />

        <script type="text/javascript">
            function makePayment(){            	
            	window.location.href = "subscription_manager.jsp?type=history&typeSub=makePayment";
	    }	
	    function cancelPayment(){
            	window.location.href = "subscription_manager.jsp?type=history";	    
	    }
	    function addPayment(){
            	window.location.href = "subscription_manager.jsp?type=billing&typeSub=addCard";	    
	    }
	    function addSavePayment(){
            	window.location.href = "subscription_manager.jsp?type=billing";	    
	    }
	    function managePayment(){
            	window.location.href = "subscription_manager.jsp?type=billing";	    
	    }
	    function manageServiceType(){
            	window.location.href = "subscription_manager.jsp?type=services";	    
	    }
	    function addCancelPayment(){
            	window.location.href = "subscription_manager.jsp?type=billing";	    
	    }
	    
        </script>	


	<script src="js/bootstrap2.min.js"></script>
	<link href="css/bootstrap2.min.css" rel="stylesheet">












		<%if(session.getAttribute("issubscribed")!=null && session.getAttribute("issubscribed").equals("true")){%>
		<%
			String uuid = (String)session.getAttribute("uuid");

			if(uuid !=null){
%>
         
	<link rel="stylesheet" href="css/navstyle2.css" />

    <script>
        function logoutuser(userID) {
            var xmlhttp;
            if (window.XMLHttpRequest) {// code for IE7+, Firefox, Chrome, Opera, Safari
                xmlhttp = new XMLHttpRequest();
            }
            else {// code for IE6, IE5
                xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
            }
            var userID2 = userID;
            var gov = "true"
            xmlhttp.open("get", "logout.jsp?id=" + userID2 + "&GO=" + gov, true);
            xmlhttp.send();

        }
    </script>	
</head>
	<body >
 
 <!-- this modal kicks in when users click on the logout function, the logout function calls logout.jsp that will clear session attributes, while user gets the modal and is able to go back to the login page -->
 
 <div class="modal fade" id="logoutconfirm" role="dialog" aria-labelledby="logoutconfirm" aria-hidden="true">
     <div class="modal-dialog">
         <div class="modal-content">
             <div class="modal-header">
                 <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                 <h4 class="modal-title" id="myModalLabel" style="color:red">Logout Confirmation</h4>
             </div>
             <div class="modal-body">
                 <h4>You have successfully logged out.</h4>
             </div>
             <div class="modal-footer">
                 <button type="button" class="btn btn-primary" data-dismiss="modal"
                         onclick="location.href='https://www.mytruckboard.com'">Dismiss
                 </button>
 
             </div>
         </div>
     </div>
</div>

			<%@include file="nav_menu.jsp"%>   
		<%

				int userCount = 0;	
				float serviceType_amount =0.0f;
				float serviceType_amount_due =0.0f;
				float serviceType_amount_invoiced =0.0f;
				float serviceType_amount_paid =0.0f;
				float serviceType_amount_paid_last =0.0f;
				String serviceType_amount_paid_last_date ="NA";
				String serviceType_amount_paid_last_time ="NA";
				String productType = "";
				boolean liteResult = false;
				String cardType = "";
				String customerAddress1 = "None";
				String customerPhone = "None";
		%>
		
	<%if(request.getParameter("typeSubFun")!=null && request.getParameter("typeSubFun").equals("makePaymentSave")){%>
		<%
			if(request.getParameter("cc_id")!=null){
		
				 try{
						Class.forName("com.mysql.jdbc.Driver");
						String url = "jdbc:mysql://localhost/test?zeroDateTimeBehavior=convertToNull";
						Connection connection = DriverManager.getConnection(url,"<USERNAME>", "<PASSWORD>");						
						PreparedStatement ps = connection.prepareStatement("select * from test.trucking_c WHERE trucking_c.COMPANY_ID = ? and cc_uuid = ?");
						ps.setString(1, uuid);
						ps.setString(2, request.getParameter("cc_id"));
						ResultSet resultSet = ps.executeQuery();
						String bt_customer_token = "";
						String bt_cc_token = "";
						while (resultSet.next()) {
						  bt_customer_token = resultSet.getString("bt_customer_token");
						  bt_cc_token = resultSet.getString("bt_cc_token");
						}	
    						Calendar cal = Calendar.getInstance();	
    						float paymentAmount = 0.0f;
    						if(request.getParameter("payFull").equals("YES")){
    							paymentAmount = Float.parseFloat(request.getParameter("payFullAmount"));
    						}else{
    							paymentAmount = Float.parseFloat(request.getParameter("amount"));
    						}
    						boolean resultPayment = GetPaymentToken.processPaymenForExistingCustomerSMS(bt_customer_token,bt_cc_token,paymentAmount+"");					
						if(resultPayment){
						java.sql.Timestamp ts = new java.sql.Timestamp((new java.util.Date()).getTime());
						ps = connection.prepareStatement("INSERT INTO test.trucking_company_payments(payment_id, company_id, month, ts, product_type, price_per_user, user_count, payment_type) VALUES (?,?,?,?,?,?,?,?)");
						ps.setString(1, UUID.randomUUID() + "");
						ps.setString(2, uuid);	
						ps.setInt(3, cal.get(Calendar.MONTH));					
						ps.setTimestamp(4, ts);	
						ps.setString(5, "Payment");	
						ps.setFloat(6,paymentAmount);	
						ps.setInt(7, 1);	
						ps.setString(8, "Payment");		
						ps.executeUpdate();
						}			
						System.out.println(bt_cc_token);
				 }catch (Exception ex){
				     %><%=" " + ex %><%
				 }	
	         	}
		%>
	<%}%>
	<%if(request.getParameter("typeSubFun")!=null && request.getParameter("typeSubFun").equals("saveServiceType")){%>
		<%if(true){%>
		<%
	         try{
	         
	         		float service_type_price = 25.00f;
	         		if(request.getParameter("serviceType").equals("unlimited"))service_type_price=250.00f;
	         		if(request.getParameter("serviceType").equals("enterprise"))service_type_price=125.00f;
	         		if(request.getParameter("serviceType").equals("professional"))service_type_price=65.00f;
				Class.forName("com.mysql.jdbc.Driver");
				String url = "jdbc:mysql://localhost/test?zeroDateTimeBehavior=convertToNull";
				Connection connection = DriverManager.getConnection(url,"<USERNAME>", "<PASSWORD>");						
				PreparedStatement ps = connection.prepareStatement("Update test.TRUCKING_COMPANY Set isSubscribed_type = ?, isSubscribed_type_price = ? where company_id = ?");
				ps.setString(1, request.getParameter("serviceType"));	
				ps.setFloat(2,service_type_price);
				ps.setString(3, uuid);	
				ps.executeUpdate();
				System.out.println("XXXXXXXXXXXXXXXXXXX" + request.getParameter("serviceType") + "YYYYY");
	         }catch (Exception ex){
	             %><%=" " + ex %><%
	         }	
	         }
			%>	
	<%}%>
	<%if(request.getParameter("typeSubFun")!=null && request.getParameter("typeSubFun").equals("removeCard")){%>
		<%if(true){%>
		<%
	         try{
				Class.forName("com.mysql.jdbc.Driver");
				String url = "jdbc:mysql://localhost/test?zeroDateTimeBehavior=convertToNull";
				Connection connection = DriverManager.getConnection(url,"<USERNAME>", "<PASSWORD>");						
				PreparedStatement ps = connection.prepareStatement("delete from test.trucking_c where isPrimaryCard = ? and company_id = ? and cc_uuid =?");
				ps.setInt(1, 0);
				ps.setString(2, uuid);	
				ps.setString(3, request.getParameter("cc_uuid"));	
				ps.executeUpdate();			
	         }catch (Exception ex){
	             %><%=" " + ex %><%
	         }	
	         }
			%>	
	<%}%>
	<%if(request.getParameter("typeSubFun")!=null && request.getParameter("typeSubFun").equals("setAsPrimary")){%>

		<%if(true){%>
		<%
	         try{
				Class.forName("com.mysql.jdbc.Driver");
				String url = "jdbc:mysql://localhost/test?zeroDateTimeBehavior=convertToNull";
				Connection connection = DriverManager.getConnection(url,"<USERNAME>", "<PASSWORD>");						
				PreparedStatement ps = connection.prepareStatement("Update test.trucking_c Set isPrimaryCard = ? where company_id = ?");
				ps.setInt(1, 0);
				ps.setString(2, uuid);	
				ps.executeUpdate();
				
				ps = connection.prepareStatement("Update test.trucking_c Set isPrimaryCard = ? where company_id = ? and cc_uuid =?");
				ps.setInt(1, 1);
				ps.setString(2, uuid);	
				ps.setString(3, request.getParameter("cc_uuid"));	
				ps.executeUpdate();			
	         }catch (Exception ex){
	             %><%=" " + ex %><%
	         }	
	         }
			%>								
	<%}%>
	<%if(request.getParameter("typeSub")!=null && request.getParameter("typeSub").equals("saveCard")){%>
		<%
			int isPrimary = 0;
			liteResult = GetPaymentToken.addCustomerProcessPaymentTrucking(uuid,request.getParameter("cc_name"),"",request.getParameter("cardno"),request.getParameter("expmm"),request.getParameter("expyy"),request.getParameter("cvv"), 0);					
			if(liteResult && request.getParameter("setAsPrimaryCC")!=null){
			%>		
			<%
			}
		%>
		
	<%}%>
		<%if(true){%>
		<%
	         try{
				Class.forName("com.mysql.jdbc.Driver");
				String url = "jdbc:mysql://localhost/test?zeroDateTimeBehavior=convertToNull";
				Connection connection = DriverManager.getConnection(url,"<USERNAME>", "<PASSWORD>");						
				PreparedStatement psMain = connection.prepareStatement("select count(email) as itemCount from test.trucking_users WHERE trucking_users.COMPANY_ID = ?");
				psMain.setString(1, uuid);
				ResultSet resultSet = psMain.executeQuery();
				while (resultSet.next()) {
					userCount = resultSet.getInt("itemCount");
				}
    				Calendar cal = Calendar.getInstance();		
    				psMain = connection.prepareStatement("select * from test.trucking_company_payments where company_id = ?");		
    				psMain.setString(1, uuid);
    				resultSet = psMain.executeQuery();
    				while (resultSet.next()) {	
    					userCount = resultSet.getInt("user_count"); 
    					serviceType_amount =  resultSet.getFloat("price_per_user"); 
    					if( resultSet.getString("payment_type").equals("Invoice")){
    						serviceType_amount_invoiced = serviceType_amount_invoiced + (userCount * serviceType_amount);
    					}else{
    						serviceType_amount_paid = serviceType_amount_paid +(userCount * serviceType_amount);
    						serviceType_amount_paid_last = (userCount * serviceType_amount);
    						serviceType_amount_paid_last_date= new SimpleDateFormat("MM/dd/yy").format(resultSet.getTimestamp("ts"));
    						serviceType_amount_paid_last_time= new SimpleDateFormat("h:mm a").format(resultSet.getTimestamp("ts"));
    					}
    				}
    				serviceType_amount_due = serviceType_amount_invoiced - serviceType_amount_paid;
 				psMain = connection.prepareStatement("select * from test.TRUCKING_COMPANY WHERE TRUCKING_COMPANY.COMPANY_ID = ?");
				psMain.setString(1, uuid);
				resultSet = psMain.executeQuery();
				while (resultSet.next()) {
					if(resultSet.getString("isSubscribed_type")!=null)productType = resultSet.getString("isSubscribed_type");
				}
 				psMain = connection.prepareStatement("select * from test.trucking_c WHERE trucking_c.COMPANY_ID = ? order by isPrimaryCard limit 1");
				psMain.setString(1, uuid);
				resultSet = psMain.executeQuery();
				while (resultSet.next()) {
					if(resultSet.getString("bt_cc_type")!=null)cardType = resultSet.getString("bt_cc_type");
				}
 				psMain = connection.prepareStatement("select * from test.TRUCKING_COMPANY WHERE TRUCKING_COMPANY.COMPANY_ID = ? order by isPrimaryCard limit 1");
				psMain.setString(1, uuid);
				resultSet = psMain.executeQuery();
				while (resultSet.next()) {				
					if(resultSet.getString("address")!=null)customerAddress1 = resultSet.getString("address");
					if(resultSet.getString("phone")!=null)customerPhone = resultSet.getString("phone");
				}				
			
	         }catch (Exception ex){
	             %><%=" " + ex %><%
	         }	
	         }
			%>	
	<div class="container-fluid">
	
     <div class="row">
    <div class="col-lg-12">
	<BR><BR><BR><BR><BR>	
	<ul class="nav nav-tabs" id="myTab">
	<li <%if(request.getParameter("type")==null || request.getParameter("type").equals("history")){%> class="active" <%}%>><a href="subscription_manager.jsp?type=history" data-toggle="tab">Transaction history</a></li>
	<li <%if(request.getParameter("type")!=null && request.getParameter("type").equals("billing")){%> class="active" <%}%>><a href="subscription_manager.jsp?type=billing" data-toggle="tab">Billing Settings</a></li>
	<li <%if(request.getParameter("type")!=null && request.getParameter("type").equals("services")){%> class="active" <%}%>><a href="subscription_manager.jsp?type=services" data-toggle="tab">Services</a></li>
	</ul>	
    </div>	
    </div>

    <% float totalDue=0.0f;%>
    
	<%if(request.getParameter("typeSub")!=null && request.getParameter("typeSub").equals("makePayment")){%>
    <FORM name="searchFormPayment" id="searchFormPayment" action="subscription_manager.jsp?type=history&typeSubFun=makePaymentSave" method="post"  >		
     <div class="row">
    <div class="col-lg-12" >
     <h3> Make a payment</h3>
    </div>
    </div>
     <div class="row">
    <div class="col-lg-12" >

    <p>Pay with</p>
<div class="input-group">
      <span class="input-group-addon">
  <span class="glyphicon glyphicon glyphicon-credit-card" aria-hidden="true"></span></span>
  <select class="form-control" name="cc_id"  id="cc_id" style="width:300px;" >
<%if(true){%>
		<%
	         try{
				Class.forName("com.mysql.jdbc.Driver");
				String url = "jdbc:mysql://localhost/test?zeroDateTimeBehavior=convertToNull";
				Connection connection = DriverManager.getConnection(url,"<USERNAME>", "<PASSWORD>");						
				PreparedStatement psMain = connection.prepareStatement("select * from test.trucking_c WHERE trucking_c.COMPANY_ID = ?");
				psMain.setString(1, uuid);
				ResultSet resultSet = psMain.executeQuery();
				while (resultSet.next()) {
				%>
		    		<option value="<%=resultSet.getString("cc_uuid")%>" ><%=resultSet.getString("bt_cc_type")%>  <%=resultSet.getString("bt_cc_mask")%> </option>	
				<%
				}				
			
	         }catch (Exception ex){
	             %><%=" " + ex %><%
	         }	
	         }
			%>       
  </select>
</div>    
</div>    
</div>   
	<p>&nbsp;</p>	
    <p>Specify your payment amount</p> 
    	<% totalDue  = userCount * serviceType_amount;%>
<ul class="list-group">
   <li class="list-group-item">
    <input type="radio" name="payFull" value="YES" checked/>
    <input type="hidden" name="payFullAmount" value="<%=String.format("%.02f", serviceType_amount_due)%>" />
    $<%=String.format("%.02f", serviceType_amount_due)%> (last payment)
    
    </li>
    <li class="list-group-item">
    <input type="radio" name="payFull" value="NO" /> 
    Other amount <input type='text' id="amount" name="amount"  style="text-align:right;width: 150px;"

    value=""  
    placeholder="0.00" /> 
    </li>
    <li class="list-group-item">
		<div class="input-group"  style="padding: 5px;">
		<button class="btn btn-primary" style="width:200px;" type="button" id="paymentButton" onclick="this.form.submit()" >&nbsp;&nbsp;Make a payment&nbsp;&nbsp;</button>
	      &nbsp;&nbsp;
	      <button class="btn btn-default" style="width:200px;" type="button" id="paymentButton" onclick="cancelPayment()" >&nbsp;&nbsp;Cancel&nbsp;&nbsp;</button>
	      </div>  
    </li>
</ul>
    </div>
	</div>
     
    </div>
    </div>

		</form>
	<%}%>
	<%if(request.getParameter("type")==null || (request.getParameter("type").equals("history") && request.getParameter("typeSub")==null)){%>

     <div class="row">
    <div class="col-lg-12" >
     <h3> Transaction history for myTruckBoard Enterprise</h3>
    </div>
    </div>
    
     <div class="row">
    <div class="col-lg-12" >
    <div class="col-sm-10" style="border-style:solid;border-width:1px 1px 0px 1px;" >	
    <div class="col-sm-3">	
    Current Balance<BR>
    	<% totalDue  = userCount * serviceType_amount;%>
    <h3>$<%=String.format("%.02f", serviceType_amount_due )%></h3> 
    <small>Estimated tax of $0.00 has been deducted<BR>
Last payment <%=serviceType_amount_paid_last_date%>, <%=serviceType_amount_paid_last_time%> for $<%=String.format("%.02f", serviceType_amount_paid_last )%><BR><BR></small>

    </div>
    
    <div class="col-sm-3">	
    How you pay<BR>
    <h3>CARD TYPE: <%=cardType%></h3>    
    <small>No Backup<BR>Monthly automatic payments<BR><BR></small> 
    </div>	
    <div class="col-sm-3">	
    Service Type
    <h3><%=productType%></h3>    
    <small><%=customerAddress1%><BR><%=customerPhone%><BR><BR></small> 
    </div>	
    </div>
    
       
        <div class="col-sm-10" style="border-style:solid;border-width:0px 1px 1px 1px;" >
        <div class="col-sm-3">
    		<div class="input-group"  style="padding: 5px;">
    	      <span class="input-group-btn" >
    		<button class="btn btn-primary" style="width:100%;" type="button" id="paymentButton" onclick="makePayment()" >&nbsp;&nbsp;Make&nbsp;Payment&nbsp;&nbsp;</button>
    	      </span>
    		</div> 
    		</div>
    		
        <div class="col-sm-3">
    		<div class="input-group"  style="padding: 5px;">
    	      <span class="input-group-btn" >
    		<button class="btn btn-primary" style="width:100%;" type="button" id="paymentButton" onclick="managePayment()" >&nbsp;&nbsp;Manage&nbsp;Card&nbsp;&nbsp;</button>
    	      </span>
    		</div> 
    		</div> 
        <div class="col-sm-3">
    		<div class="input-group"  style="padding: 5px;">
    	      <span class="input-group-btn" >
    		<button class="btn btn-primary" style="width:100%;" type="button" id="paymentButton" onclick="manageServiceType()" >&nbsp;&nbsp;Manage&nbsp;Service&nbsp;&nbsp;</button>
    	      </span>
    		</div> 
    		</div> 
        </div>
    <div class="col-sm-10" style="border-style:solid;border-width:0px;" > &nbsp;
		</div> 
		
		<%
	         try{
				Class.forName("com.mysql.jdbc.Driver");
				String url = "jdbc:mysql://localhost/test?zeroDateTimeBehavior=convertToNull";
				Connection connection = DriverManager.getConnection(url,"<USERNAME>", "<PASSWORD>");						
				PreparedStatement psMain = connection.prepareStatement("select * from test.trucking_company_payments where company_id = ? order by ts desc");		
    				psMain.setString(1, uuid);
    				ResultSet resultSet = psMain.executeQuery();
    				while (resultSet.next()) {	
%>
    
        <div class="col-lg-12" > 
    
    <div class="col-sm-10" style="border-style:solid;border-width:1px;" > 
    <div class="col-sm-3">	  
    <h3>Service Month - <%=resultSet.getInt("month")+1%></h3>
    <h5><%=resultSet.getString("payment_type")%></h5>
		</div> 
    <div class="col-sm-3">	  
    <h3><%=new SimpleDateFormat("MM/dd/yy").format(resultSet.getTimestamp("ts"))%>,
    <%=new SimpleDateFormat("h:mm a").format(resultSet.getTimestamp("ts"))%>
    </h3>
    
		</div> 
    <div class="col-sm-3" style="text-align:right;">	  
    <h3>$<%=String.format("%.02f", resultSet.getInt("user_count") * resultSet.getFloat("price_per_user"))%> 
    
    </h3>
    <%if(resultSet.getString("payment_type").equals("Invoice")){%>
    <small>
    Price Per User $<%=resultSet.getString("price_per_user")%> 
    Users <%=resultSet.getString("user_count")%>   </small>
    <%}%>
		</div> 
    </div> 
    </div>
<%    						
    						
    				}							
	         }catch (Exception ex){
	             %><%=" " + ex %><%
	         }	
			%>   
    
    </div> 
    </div>    
	<%}%>
	
	<%if(liteResult || request.getParameter("type")!=null && (request.getParameter("type").equals("billing") && request.getParameter("typeSub")==null)){%> 

     <div class="row">
    <div class="col-lg-12" >	
	<h3>Your Selections</h3>
    
    </div>
    </div>
     <div class="row">
    <div class="col-lg-12" >
    <div class="col-sm-3" style="border-style:solid;border-width:0px;">	How You Pay</div>
    <div class="col-sm-6" style="border-style:solid;border-width:0px;"><small>We automatically charge you on the first day of the month for charges accrued during the preceding month. You may make additional payments at any time.</small>. <b>Must provide your 30 days� notice to end a month-to-month contract</b></div>
    </div>
    </div>
     <div class="row">
    <div class="col-lg-12" >
    <div class="col-sm-3" style="border-style:solid;border-width:0px;">	&nbsp;</div>
    <div class="col-sm-6" style="border-style:solid;border-width:0px;">
		<div class="input-group"  style="padding: 5px;">
	      <span class="input-group-btn" >
		<button class="btn btn-primary" style="width:240px;" type="button" id="paymentButton" onclick="addPayment()" >
		
    	<span class="glyphicon glyphicon-plus"></span>
		Add a new payment method</button>
	      </span>
		</div>     
    </div>
    </div>
    </div>

     <div class="row">
    <div class="col-lg-12" >	
	<h3>Available payment methods</h3>
    
    </div>
    </div> 
		<%if(true){%>
		<%
	         try{
				Class.forName("com.mysql.jdbc.Driver");
				String url = "jdbc:mysql://localhost/test?zeroDateTimeBehavior=convertToNull";
				Connection connection = DriverManager.getConnection(url,"<USERNAME>", "<PASSWORD>");						
				PreparedStatement psMain = connection.prepareStatement("select * from test.trucking_c WHERE trucking_c.COMPANY_ID = ?");
				psMain.setString(1, uuid);
				ResultSet resultSet = psMain.executeQuery();
				while (resultSet.next()) {
				%>
     <div class="panel panel-default">
     <div class="panel-body"> 
     
     <div class="row" >
    <div class="col-lg-12" style="padding:5px;">  
    <div class="col-sm-3" ><%=resultSet.getString("cc_name")%></div>
    <div class="col-sm-3" ><%=resultSet.getString("bt_cc_mask")%><BR>
    <%=resultSet.getString("bt_cc_type")%>
    </div>
    <div class="col-sm-3" style="border-style:solid;border-width:0px;">
    <%if(resultSet.getInt("isPrimaryCard")==0){%>
    <a href="subscription_manager.jsp?type=billing&cc_uuid=<%=resultSet.getString("cc_uuid")%>&typeSubFun=removeCard" >Remove</a><BR>
    <a href="subscription_manager.jsp?type=billing&cc_uuid=<%=resultSet.getString("cc_uuid")%>&typeSubFun=setAsPrimary" >Set as Primary</a>
    <%}else{%>
    Primary Card
    <%}%>
    </div>
    </div>
    </div>
    
    </div>
    </div>	 			
				<%
				}				
			
	         }catch (Exception ex){
	             %><%=" " + ex %><%
	         }	
	         }
			%>   
	<%}%>
	<%if(request.getParameter("typeSub")!=null && ((request.getParameter("typeSub").equals("saveCard") && !liteResult) || request.getParameter("typeSub").equals("addCard"))){%>
     <div class="row">
    <div class="col-lg-12">
     <h3> Billing settings</h3>
     <%if(request.getParameter("typeSub").equals("saveCard")){%>
     	
<div class="alert alert-danger" role="alert">
  <span class="glyphicon glyphicon-exclamation-sign" aria-hidden="true"></span>
  <span class="sr-only">Error:</span>
  Error adding card, correct info and try again.
</div>     	
     <%}%>
    </div>
    </div>
     <div class="panel panel-default">
     <div class="panel-body">
    <div class="col-lg-12">
<FORM name="searchForm" id="searchForm" action="subscription_manager.jsp?type=billing&typeSub=saveCard" method="post"  >		
<ul class="list-group"  style="width:320px;">
   <li class="list-group-item">
    <input type='text' style="width:300px;font-size: 14px; padding-left: 5px; padding-right: 5px; "  id="cc_name" name="cc_name" value="<%=NullCheck.check(request.getParameter("cc_name"))%>" placeholder="Name On Card">
    	
    </li>
   <li class="list-group-item">
    <input type='text' style="width:300px;font-size: 14px; padding-left: 5px; padding-right: 5px; " id="cardno" name="cardno" value="<%=NullCheck.check(request.getParameter("cardno"))%>"  placeholder="Credit Card Number">
    	
    
        </li>
   <li class="list-group-item">
    <input type='text' style="width:80px;font-size: 14px; padding-left: 5px; padding-right: 5px; " id="expmm" name="expmm" value="<%=NullCheck.check(request.getParameter("expmm"))%>" placeholder="MM">
    /
    <input type='text' style="width:80px;font-size: 14px; padding-left: 5px; padding-right: 5px; " id="expyy" name="expyy" value="<%=NullCheck.check(request.getParameter("expyy"))%>" placeholder="YY">
    
    
    <input type='text' style="float:right;width:100px;font-size: 14px; padding-left: 5px; padding-right: 5px; " id="cvv" name="cvv" value="<%=NullCheck.check(request.getParameter("cvv"))%>" placeholder="CVC">


    </li>
   <li class="list-group-item">Billing Address
   </li>   
   <li class="list-group-item">
    <input type="checkbox" name="setAsPrimaryCC" value="None" /> Set this payment method as primary
   
   </li>   
    <li class="list-group-item">
		<div class="input-group"  style="padding: 5px;">
		<button class="btn btn-primary" style="width:120px;" type="button" id="paymentButton" onclick="this.form.submit()" >&nbsp;&nbsp;Save&nbsp;&nbsp;</button>
	      &nbsp;&nbsp;
	      <button class="btn btn-default" style="width:120px;" type="button" id="paymentButton" onclick="addCancelPayment()" >&nbsp;&nbsp;Cancel&nbsp;&nbsp;</button>
	      </div>  
    </li>
</ul>    
</form>
    </div>
    </div>
    </div>
    
    </div>
	<%}%>
	<%if(request.getParameter("type")!=null && request.getParameter("type").equals("services")){%> 
	<%
	
	         		String serviceType = "";
	%>
		<%if(true){%>
		<%
	         try{
				Class.forName("com.mysql.jdbc.Driver");
				String url = "jdbc:mysql://localhost/test?zeroDateTimeBehavior=convertToNull";
				Connection connection = DriverManager.getConnection(url,"<USERNAME>", "<PASSWORD>");						
				PreparedStatement psMain = connection.prepareStatement("select * from test.TRUCKING_COMPANY WHERE TRUCKING_COMPANY.COMPANY_ID = ?");
				psMain.setString(1, uuid);
				ResultSet resultSet = psMain.executeQuery();
				while (resultSet.next()) {
					serviceType = resultSet.getString("isSubscribed_type");
				}				
			
	         }catch (Exception ex){
	             %><%=" " + ex %><%
	         }	
	         }
			%>	
<FORM name="searchForm" id="searchForm" action="subscription_manager.jsp?type=services&typeSubFun=saveServiceType" method="post"  >
     <div class="row">
    <div class="col-lg-12">
     <h3> Service Type</h3>
     <p>How billing works: Charged based on user count. A decrease  in user count or service type  will reflect on  the  next  month�s bill. </p>
<ul class="list-group">
   <li class="list-group-item">
    <input type="radio" name="serviceType" value="starter" <%if(serviceType !=null && serviceType.equals("starter")){%>checked="checked"<%}%> />	STARTER

 $ 25 /USER/MO.
Out-of-the-box TMS For up to 10 users

<ul>
                                    <li><span>Equipment location board</span></li>
                                    <li><span>Quick load entry</span></li>
                                    <li><span>Salesman/Broker commissions</span></li>
                                    <li><span>Text Message load tendering</span></li>
                                    <li><span>Multi-Shipment functionality</span></li>
                                    <li><span>Customer Invoicing</span></li>
                                    <li><span>Claims Processing</span></li>
                                    <li><span>Driver app</span></li>
                                    <li><span>MMS messaging</span></li>
                                    <li><span>Real-time tracking</span></li>
</ul>
    </li>
   <li class="list-group-item">
    <input type="radio" name="serviceType" value="professional" <%if(serviceType !=null && serviceType.equals("professional")){%>checked="checked"<%}%> />	
    PROFESSIONAL
    
     $ 65 /USER/MO.
Complete TMS for any size team

                                <ul>
                                    <li style="background: lightgray"><span>All Features of Starter PLUS</span></li>
                                    <li><span>Webinars and live trainings</span></li>
                                    <li><span>Document repository</span></li>
                                    <li><span>Carrier & driver history tracking</span></li>
                                    <li><span>Shared entity rating</span></li>
                                    <li><span>Marketing mass email***</span></li>
                                    <li><span>Marketing mass SMS</span></li>
                                    <li><span>Social media integration</span></li>
                                    <li><span>Dedicated SMS Number</span></li>
                                    <li><span>Super Phone CRM</span></li>
                                </ul>
    </li>
   <li class="list-group-item">
    <input type="radio" name="serviceType" value="enterprise" <%if(serviceType !=null && serviceType.equals("enterprise")){%>checked="checked"<%}%> />	ENTERPRISE

$ 125 /USER/MO.
Let's get serious

                                <ul>
                                    <li style="background: lightgray"><span>&nbsp;All Features of Professional PLUS&nbsp;</span></li>
                                    <li><span>Custom branding</span></li>
                                    <li><span>Branded customer portal</span></li>
                                    <li><span>Branded driver portal</span></li>
                                    <li><span>Branded employee portal</span></li>
                                    <li><span>User group role management</span></li>
                                    <li><span>Integration via Web Service API</span></li>
                                    <li><span>Sales Force Sales Cloud integration</span></li>
                                </ul>
    </li>
   <li class="list-group-item">
    <input type="radio" name="serviceType" value="unlimited" <%if(serviceType !=null && serviceType.equals("unlimited")){%>checked="checked"<%}%> /> UNLIMITED

$ 250 USER/MO.
Fully Customized
                                <ul>
                                    <li style="background: lightgray"><span>&nbsp;All Features of Enterprise PLUS&nbsp;</span></li>
                                    <li><span>Business process automation</span></li>
                                    <li><span>Price Quote Engine</span></li>
                                    <li><span>Automatic dispatching</span></li>
                                    <li><span>Freight marketplace</span></li>
                                    <li><span>Natural language processing</span></li>
                                    <li><span>Asset Location forecasting</span></li>
                                    <li><span>Lane-Analytics</span></li>
                                    <li><span>Localization</span></li>
                                    <li><span>Translation</span></li>
                                </ul>
    </li>
    <li class="list-group-item">
		<div class="input-group"  style="padding: 5px;">
		<button class="btn btn-primary" style="width:120px;" type="button" id="paymentButton" onclick="this.form.submit()" >&nbsp;&nbsp;Save&nbsp;&nbsp;</button>
	      </div>  
    </li>
</ul>       
    </div>
    
    </div>
</form>
	<%}%>
    </div>





	</body>
	</html>





		<%}else{%>
	<a href="http://www.myTruckBoard.com">Please Login</a>
		<%}%>



		<%}else{%>


	</head>

	<body>

	<!-- if user's session expired - open the modal box: and upon clicking relogin - send them to the login page -->


	<script type="text/javascript">
	$(window).load(function(){
	$('#relogin').modal('show');
	});
	</script>


	<div class="modal fade" id="relogin" role="dialog" aria-hidden="false" aria-labelledby="relogin">
	<div class="modal-dialog">
	<div class="modal-content">
	<div class="modal-header">
	<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
	<h4 class="modal-title" id="myModalLabel" style="color:red">Session Expired</h4>
	</div>
	<div class="modal-body">
	<h3>Your session has expired. Please login.</h3>
	</div>
	<div class="modal-footer">
	<button type="button" class="btn btn-primary" onclick="location.href='https://www.mytruckboard.com'">Login</button>

	</div>
	</div>
	</div>
	</div>

	</body>
	</html>



		<%}%>
	        	