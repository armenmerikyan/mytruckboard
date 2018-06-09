<%@ page import="com.big.util.*,java.text.*,java.util.*,java.io.*,javax.xml.parsers.*,org.w3c.dom.*,java.sql.*,java.text.DateFormat" %>			
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
    <meta name="description" content="">
    <meta name="author" content="">
    <link rel="icon" href="../../favicon.ico">

    <title>LiteWorks2</title>

    <!-- Bootstrap core CSS -->
    <link href="css/bootstrap.min.css" rel="stylesheet">

    <!-- Just for debugging purposes. Don't actually copy these 2 lines! -->
    <!--[if lt IE 9]><script src="js/ie8-responsive-file-warning.js"></script><![endif]-->
    <script src="js/ie-emulation-modes-warning.js"></script>

    <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
    <!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
      <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->

    <!-- Custom styles for this template -->
    <link href="carousel.css" rel="stylesheet">
  </head>
<!-- NAVBAR
================================================== -->
  <body>
      <div class="navbar-wrapper">
        <div class="container">
          <nav class="navbar navbar-inverse navbar-fixed-top">
            <div class="container">
              <div class="navbar-header">
                <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar">
                  <span class="sr-only">Toggle navigation</span>
                  <span class="icon-bar"></span>
                  <span class="icon-bar"></span>
                  <span class="icon-bar"></span>
                </button>     
			<%@include file="basicbt.mtb.admin.menu.jsp"%>       
              </div>          
            </div>
          </nav>
  
        </div>
      </div>   
      <p>&nbsp;</p>
    <p>&nbsp;</p>
      <div class="navbar-wrapper">
        <div class="container">
  
          
  
    <div class="container marketing">
    <h3>My Truck Board - Support Operations Center</h3>
  <%
	try{
			String uuidBrand = (String)session.getAttribute("uuidBrand");
			//if(uuidBrand !=null){
			Class.forName("com.mysql.jdbc.Driver");
			String url = "jdbc:mysql://localhost/test?zeroDateTimeBehavior=convertToNull";
			Connection connection = DriverManager.getConnection(url,"<USERNAME>", "<PASSWORD>");
			
			PreparedStatement ps = connection.prepareStatement("select count(distinct(company_id)) as itemCount from TRUCKING_COMPANY");	
			ResultSet resultSet = ps.executeQuery();
			String totalCount = "0";
			while (resultSet.next()) {
				totalCount = resultSet.getString("itemCount");
			}
			%><h4>Companies <%=totalCount%></h4><%
			ps = connection.prepareStatement("select * from TRUCKING_COMPANY order by ts desc");
			resultSet = ps.executeQuery();
			int j= 0;
			while (resultSet.next()) {	
				j+=1;
			    String timeDurration = "ago" ;
			    	if(true && resultSet.getTimestamp("ts")!=null){
			    long currentTime = Calendar.getInstance().getTime().getTime();
			    long postTime = resultSet.getTimestamp("ts").getTime();
			    long diff = currentTime - postTime;
			    long diffSeconds = diff / 1000 % 60;
			    long diffMinutes = diff / (60 * 1000) % 60;
			    long diffHours = diff / (60 * 60 * 1000) % 24;
			    long diffDays = diff / (60 * 60 * 1000 * 24);
			    if (diffSeconds == 1)timeDurration = "1 Second " + timeDurration;
			    else if (diffSeconds > 1) timeDurration = diffSeconds + " Seconds " + timeDurration;
			    if (diffMinutes == 1)timeDurration = "1 Minute " + timeDurration;
			    else if (diffMinutes > 1) timeDurration = diffMinutes + " Minutes " + timeDurration;
			    if (diffHours == 1)timeDurration = "1 Hour " + timeDurration;
			    else if (diffHours > 1) timeDurration = diffHours + " Hours " + timeDurration;
			    if (diffDays == 1)timeDurration = "1 Day " + timeDurration;
			    else if (diffDays > 1) timeDurration = diffDays + " Days " + timeDurration;  
			    	}
				%>	
      <div class="panel panel-success" >
      <div class="panel-heading">Company Name: <a href="basicbt.mtb.admin.users.jsp?company_id=<%=resultSet.getString("company_id")%>" ><%=resultSet.getString("name")%></a>
      
      </div>
      <div class="panel-body"><%
				ps = connection.prepareStatement("select count(id) as itemCount from TRUCKING_EQUIPMENT where company_id = ? ");	
				ps.setString(1, resultSet.getString("company_id"));
				ResultSet resultSet2 = ps.executeQuery();
				String countResult = "0";
				while (resultSet2.next()) {
					countResult = resultSet2.getString("itemCount");
				}
				%> Registered Trucks: <%=countResult%><BR>

		  		<%
				ps = connection.prepareStatement("select count(email) as itemCount from TRUCKING_USERS where company_id = ? ");
				ps.setString(1, resultSet.getString("company_id"));
				resultSet2 = ps.executeQuery();
				countResult = "0";
				while (resultSet2.next()) {
					countResult = resultSet2.getString("itemCount");
				}
				%> Registered Users: <%=countResult%><BR>
				Customer Since: <%=timeDurration%><BR>
				Phone : <%=resultSet.getString("phone")%><BR>
				<%
				ps = connection.prepareStatement("select f_name, l_name, entity, only_demo, email from TRUCKING_USERS where company_id = ? ");
				ps.setString(1, resultSet.getString("company_id"));
				ResultSet resultSet3 = ps.executeQuery();
				while (resultSet3.next()) {
						%>

				  Name: <%=resultSet3.getString("f_name")%>, <%=resultSet3.getString("l_name")%><BR>
				  Business Type: <%=resultSet3.getString("entity")%><BR>
		  		  Signed up for: <% if (resultSet3.getString("only_demo") !=null){%> Call back & software demo <% } else { %> Free Trial <%}%><BR>
		  		  E-mail: <%=resultSet3.getString("email")%>

					<%
						}
							%>



          </div>
	  <div class="panel-footer">
					
				TIME: <%=resultSet.getString("ts")%>	  
	  </div> 
      </div>	
				<%
			}

	connection.close();
		 }catch (Exception ex){
		     %><%="Error Posting " + ex%><%
		     System.out.println(""+ ex);
		 }
					//}
			
%>    	  
</div> 
      </div>
         
				
			 			
 </div>
  </body>
</html>