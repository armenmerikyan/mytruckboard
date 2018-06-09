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
  </head>
<!-- NAVBAR
================================================== -->
  <body>
    <div class="navbar-wrapper">
      <div class="container">
        <nav class="navbar navbar-inverse navbar-fixed-top">
          <div class="container">
            <div class="navbar-header">
              <a id="orderNowSPN" class="navbar-brand" href="basicbt.jsp" >LiteWorks2 Inc</a>
            </div>
          </div>
        </nav>

      </div>
    </div>   
    <div class="navbar-wrapper">
      <div class="container">

        

    <div class="container marketing">

 <%
			String uuidBrand = (String)session.getAttribute("uuidBrand");
			if(uuidBrand !=null){
			
			String itemID[] = {"A1","B2","C3","D4","E4","F5","G6","H7","I8","J9","K0","L1","M2","N3","O4","P5","Q6","R7","S8","T9","U0","V1","W2","X3","Y4","Z5","AA","BB","CC","DD","EE","FF","GG","HH", "II","JJ","KK","LL","MM","NN","OO","PP","QQ","RR","SS","TT","XX","X1","X3","X6","X8","X9","XB"};			
			// SELECT * FROM maids_oltp.maids_quotes left join maids_customers on maids_customers.client_id = maids_quotes.client_id  left join maids_oltp.maids_users on maids_users.user_id = maids_quotes.assnproviderid order by maids_quotes.ts desc limit 100 
			Class.forName("com.mysql.jdbc.Driver");
					String urldb = "jdbc:mysql://localhost/maids_oltp?user=<USER>&password=<PASSWORD>";		
					Connection connection = DriverManager.getConnection(urldb);
			PreparedStatement ps = connection.prepareStatement("select * from maids_oltp.litem_board order by ts desc limit 100");
		if(request.getParameter("toField")!=null && !request.getParameter("toField").equals("")
		&& request.getParameter("fromField")!=null && !request.getParameter("fromField").equals("")
		){
			ps = connection.prepareStatement("select * from litem_board where toField = ? and fromField = ? order by ts desc limit 100");
			ps.setString(1,request.getParameter("toField"));
			ps.setString(2,request.getParameter("fromField"));
		}
		if(request.getParameter("toField")!=null && !request.getParameter("toField").equals("")
		&& (request.getParameter("fromField")==null || request.getParameter("fromField").equals(""))
		){
			ps = connection.prepareStatement("select * from litem_board where toField = ? order by ts desc limit 100");
			ps.setString(1,request.getParameter("toField"));
		}
		if((request.getParameter("toField")==null || request.getParameter("toField").equals(""))
		&& request.getParameter("fromField")!=null && !request.getParameter("fromField").equals("")
		){
			ps = connection.prepareStatement("select * from litem_board where fromField = ? order by ts desc limit 100");
			ps.setString(1,request.getParameter("fromField"));
		}
			ResultSet resultSet = ps.executeQuery();
			int j = 0;			
			DecimalFormat df = new DecimalFormat("#.00");
			NumberFormat formatter = NumberFormat.getCurrencyInstance();
			
				while (resultSet.next()) {
		long currentTime = Calendar.getInstance().getTime().getTime();
		long postTime = resultSet.getTimestamp("ts").getTime();
    long diff = currentTime - postTime;
    long diffSeconds = diff / 1000 % 60;
    long diffMinutes = diff / (60 * 1000) % 60;
    long diffHours = diff / (60 * 60 * 1000) % 24;
    long diffDays = diff / (60 * 60 * 1000 * 24);
    String timeDurration = "ago" ;
    if (diffSeconds == 1)timeDurration = "1 Second " + timeDurration;
    else if (diffSeconds > 1) timeDurration = diffSeconds + " Seconds " + timeDurration;
    if (diffMinutes == 1)timeDurration = "1 Minute " + timeDurration;
    else if (diffMinutes > 1) timeDurration = diffMinutes + " Minutes " + timeDurration;
    if (diffHours == 1)timeDurration = "1 Hour " + timeDurration;
    else if (diffHours > 1) timeDurration = diffHours + " Hours " + timeDurration;
    if (diffDays == 1)timeDurration = "1 Day " + timeDurration;
    else if (diffDays > 1) timeDurration = diffDays + " Days " + timeDurration;
%>      		
      <div class="panel panel-success" id="itemIDDIV<%=j%>" name="itemIDDIV<%=j%>">	
      <div class="panel-heading"><%=timeDurration%></div>
      <div class="panel-body">
      <p> 
          <a href="basicbtDetail.jsp?messageID=<%=resultSet.getString("messageId")%>" ><img class="img-circle" src="http://www.liteworks2.com/litem/getImageServiceLow.jsp?CLIENT_ID=<%=resultSet.getString("messageId")%>" alt="Generic placeholder image" width="140" height="140"></a>
      </p>    
          <p name="itemDetailSPN<%=j%>" id="itemDetailSPN<%=j%>"  ><%=resultSet.getString("messageField")%></p>
          <!--
          <p><a class="btn btn-info" href="" role="button" onclick="javascript:showProductDetail('<%=resultSet.getString("messageId")%>','<%=j%>');return false" name="itemDetailSPNBTN<%=j%>" id="itemDetailSPNBTN<%=j%>" >View details &raquo;</a></p>
          -->
          </div>
	  <div class="panel-footer">
					
					<span style="width:100%;padding:0px;font-size:1em;">
						to <a href="basicbt.jsp?toField=<%=resultSet.getString("toField")%>" ><%=resultSet.getString("toField")%></a>
					</span>
					<span style="width:100%;padding:0px;font-size:1em;">
					from <a href="basicbt.jsp?fromField=<%=resultSet.getString("fromField")%>" ><%=resultSet.getString("fromField")%></a>
					</span>
	  </div> 
      </div>
        			<%
        			j=j+1;
        			}%>
           			
 </div>
	        	<input type="hidden" name="totalProductCount" id="totalProductCount" value="<%=j%>" />
      

	<%}%>
      <!-- FOOTER -->
      <footer>
        <p class="pull-right"><a href="#">Back to top</a></p>
        <p>&copy; 2015 LiteWorks2, Inc. &middot; <a href="privacy_policy.html">Privacy Policy</a> &middot; <a href="terms_of_service.only.html">Terms of Service</a></p>
      </footer>

    </div><!-- /.container -->


    <!-- Bootstrap core JavaScript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <!-- Just to make our placeholder images work. Don't actually copy the next line! -->
    <script src="js/vendor/holder.min.js"></script>
    <!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
    <script src="js/ie10-viewport-bug-workaround.js"></script>
<script>
  (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
  (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
  m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
  })(window,document,'script','//www.google-analytics.com/analytics.js','ga');

  ga('create', 'UA-63529886-1', 'auto');
  ga('send', 'pageview');

</script>    
  </body>
</html>
