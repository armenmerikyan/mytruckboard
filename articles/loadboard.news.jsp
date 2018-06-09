<%@ page import="com.big.util.*,java.text.*,java.util.*,java.io.*,javax.xml.parsers.*,org.w3c.dom.*,java.sql.*,java.text.DateFormat" %>			
<!DOCTYPE html>
<%
String uuid = (String)session.getAttribute("uuid");
%>
    <% int pageTotal = 11 ;%>
<html lang="en">
  <head>
	<link rel="shortcut icon" href="https://www.mytruckboard.com/trucking-new/images/mtb-favicon.ico">
        <script type="text/javascript">
        	var oldComment ;
        	var oldCommentCount ;
        	var oldCommentProcess ;
   	
            function getMetaTags(){
             				//alert("Ran agains");
					var xmlhttp;
					if (window.XMLHttpRequest)
					  {// code for IE7+, Firefox, Chrome, Opera, Safari
					  xmlhttp=new XMLHttpRequest();
					  }
					else
					  {// code for IE6, IE5
					  xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
					  }
					xmlhttp.onreadystatechange=function()
					  {
					  if (xmlhttp.readyState==4 && xmlhttp.status==200 )
					    {	
						document.getElementById("responseProcessMetaTags").innerHTML = xmlhttp.responseText;						
						if(document.getElementById("commentNLP")!=null){
							document.getElementById("commentNLP").value=  document.getElementById("comment").value + " " + xmlhttp.responseText;
						}
					    }
					  }
					  if( oldComment == document.getElementById("comment").value && oldCommentCount > 3 && oldCommentProcess == 1){
						oldComment  = document.getElementById("comment").value;
        					document.getElementById("responseProcessMetaTags").innerHTML = "<nav><ul class=\"pager\"><img src=\"images/loading.gif\" style=\"width:5.1em;vertical-align:middle;\" /></ul></nav>";
						var responseString = "comment=" + encodeURIComponent(document.getElementById("comment").value);
						xmlhttp.open("GET", "getMetaTags.jsp?" + responseString ,true);
						xmlhttp.send();   
						oldCommentProcess = 0;  
						oldCommentCount = 0;
					  }else if( oldComment == document.getElementById("comment").value ){
							oldComment  = document.getElementById("comment").value;
							oldCommentCount += 1;
					  }else{
							oldComment  = document.getElementById("comment").value;
					  		oldCommentCount = 0;
							oldCommentProcess = 1;
					  }
            }
            function postLoads(){
            				alert("Ran agains");
					var xmlhttp;
					if (window.XMLHttpRequest)
					  {// code for IE7+, Firefox, Chrome, Opera, Safari
					  xmlhttp=new XMLHttpRequest();
					  }
					else
					  {// code for IE6, IE5
					  xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
					  }
					xmlhttp.onreadystatechange=function()
					  {
					  if (xmlhttp.readyState==4 && xmlhttp.status==200 )
					    {	
						//alert(xmlhttp.responseText.split('|')[0]);
						
						document.getElementById("responseProcess").innerHTML = xmlhttp.responseText;
					    }
					  }
					
					//alert(document.getElementById("comment").value);
					var responseString = "comment=" + encodeURIComponent(document.getElementById("comment").value);
					responseString = responseString + "&email=" + encodeURIComponent(document.getElementById("email").value);
					responseString = responseString + "&pickupLocation=" + encodeURIComponent(document.getElementById("pickupLocation").value);
					responseString = responseString + "&pickupDate=" + encodeURIComponent(document.getElementById("pickupDate").value);
					responseString = responseString + "&dropLocation=" + encodeURIComponent(document.getElementById("dropLocation").value);
					responseString = responseString + "&dropDate=" + encodeURIComponent(document.getElementById("dropDate").value);
					responseString = responseString + "&phone=" + encodeURIComponent(document.getElementById("phone").value);
					xmlhttp.open("GET", "basicbt.mtb.admin.loadboard.email.post.jsp?" + responseString ,true);
					xmlhttp.send();
	    }		
            function emailLoads(){
            				//alert("Ran agains");
					var xmlhttp;
					if (window.XMLHttpRequest)
					  {// code for IE7+, Firefox, Chrome, Opera, Safari
					  xmlhttp=new XMLHttpRequest();
					  }
					else
					  {// code for IE6, IE5
					  xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
					  }
					xmlhttp.onreadystatechange=function()
					  {
					  if (xmlhttp.readyState==4 && xmlhttp.status==200 )
					    {	
						//alert(xmlhttp.responseText.split('|')[0]);
						
						document.getElementById("responseProcess").innerHTML = xmlhttp.responseText;
					    }
					  }
					
					//alert(document.getElementById("comment").value);
					var responseString = "comment=" + encodeURIComponent(document.getElementById("commentNLP").value);
					responseString = responseString + "&email=" + encodeURIComponent(document.getElementById("email").value);
					if(document.getElementById("pickupLocation")!=null)responseString = responseString + "&pickupLocation=" + encodeURIComponent(document.getElementById("pickupLocation").value);
					if(document.getElementById("pickupDate")!=null)responseString = responseString + "&pickupDate=" + encodeURIComponent(document.getElementById("pickupDate").value);
					if(document.getElementById("dropLocation")!=null)responseString = responseString + "&dropLocation=" + encodeURIComponent(document.getElementById("dropLocation").value);
					if(document.getElementById("dropDate")!=null)responseString = responseString + "&dropDate=" + encodeURIComponent(document.getElementById("dropDate").value);
					responseString = responseString + "&phone=" + encodeURIComponent(document.getElementById("phone").value);
					responseString = responseString + "&newsUrl=" + encodeURIComponent(document.getElementById("urlLink").value);
					
					xmlhttp.open("GET", "basicbt.mtb.admin.loadboard.email.news.jsp?" + responseString ,true);
					xmlhttp.send();
	    }			
            function saveLoads(){
            				//alert("Ran agains");
					var xmlhttp;
					if (window.XMLHttpRequest)
					  {// code for IE7+, Firefox, Chrome, Opera, Safari
					  xmlhttp=new XMLHttpRequest();
					  }
					else
					  {// code for IE6, IE5
					  xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
					  }
					xmlhttp.onreadystatechange=function()
					  {
					  if (xmlhttp.readyState==4 && xmlhttp.status==200 )
					    {	
						//alert(xmlhttp.responseText.split('|')[0]);
						
						document.getElementById("responseProcess").innerHTML = xmlhttp.responseText;
					    }
					  }
					
					//alert(document.getElementById("comment").value);
					
					var responseString = "comment=" + encodeURIComponent(document.getElementById("comment").value);
					responseString = responseString + "&searchTags=" + encodeURIComponent(document.getElementById("responseProcessMetaTags").innerHTML);
					xmlhttp.open("GET", "basicbt.mtb.admin.loadboard.save.news.jsp?" + responseString ,true);
					xmlhttp.send();
	    }
	    
        </script>
        	  
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
    <meta name="description" content="">
    <meta name="author" content="">

    <title>My Truck Board - Logistics News</title>
    <link href="https://fonts.googleapis.com/css?family=Roboto:100,100italic,300,300italic,400,400italic" rel="stylesheet" type="text/css" />
    <!--[if lte IE 8]><script src="css/ie/html5shiv.js"></script><![endif]-->

    <script type="text/javascript" src="js/jquery.min.js"></script>
    <script src="js/skel.min.js"></script>
    <script src="js/init.js"></script>

	<link rel="shortcut icon" href="https://www.mytruckboard.com/trucking-new/images/mtb-favicon.ico">

    <noscript>
        <link rel="stylesheet" href="css/skel-noscript.css" />
        <link rel="stylesheet" href="css/style-wide.css" />
     </noscript>


    <!-- Bootstrap core CSS -->
    <link href="css/bootstrap.min.css" rel="stylesheet">

    <link href="css/style.css" rel="stylesheet">


    <!-- Custom styles for this template -->
    <link href="css/navbar-fixed-top.css" rel="stylesheet">


    <!--[if lte IE 8]><link rel="stylesheet" href="trucking-new/css/ie/v8.css" /><![endif]-->
    <!--[if lte IE 9]><link rel="stylesheet" href="trucking-new/css/ie/v9.css" /><![endif]-->

    <style>
        .dark .button
        {
            background: #F45906;
            box-shadow: inset 0 0 0 1px #fff;
            color: #fff;
        }

        .button
        {
            background: #F45906;
         }

    </style>

       <script type="text/javascript">
            function sendSMStoDriver(fillCity){
					var xmlhttp;
					if (window.XMLHttpRequest)
					  {// code for IE7+, Firefox, Chrome, Opera, Safari
					  xmlhttp=new XMLHttpRequest();
					  }
					else
					  {// code for IE6, IE5
					  xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
					  }
					xmlhttp.onreadystatechange=function()
					  {
					  if (xmlhttp.readyState==4 && xmlhttp.status==200 )
					    {	
            					//document.getElementById("location").value = locationName;
            					
	  			    		var containsItems = xmlhttp.responseText.split("<ITEM>");
            					var equipmentID = containsItems[0];
						var imgicon = "IMG" + equipmentID.trim();
						//alert(imgicon);
						if(containsItems[1] == "TRUE"){
							document.getElementById(containsItems[2]).className = 'btn btn-success';
							//document.getElementById("armen.merikyan@liteworks2.com").className = 'btn btn-success';
						 	//alert('GOOD');
						}else{
							document.getElementById(containsItems[2]).className = 'btn btn-danger';
						 ///document.getElementById(imgicon).src = "images/notification_warning.png";
						}
						
					    }
					  }
            				//alert('coming soon');
            				var imgicon = "IMG" + fillCity;
							document.getElementById(fillCity).className = 'btn btn-warning';
					xmlhttp.open("GET", "basic.mtb.admin.email.driver.welcome.jsp?email=" + fillCity ,true);
							document.getElementById(fillCity).className = 'btn btn-warning';
            				//alert(imgicon);
					//document.getElementById(imgicon).src = "images/ajax_loader_blue_512.gif";
					// ajax_loader_blue_512
					xmlhttp.send();            	
            }
            
            function getStockQuote(){
					var xmlhttp;
					if (window.XMLHttpRequest)
					  {// code for IE7+, Firefox, Chrome, Opera, Safari
					  xmlhttp=new XMLHttpRequest();
					  }
					else
					  {// code for IE6, IE5
					  xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
					  }
					xmlhttp.onreadystatechange=function()
					  {
					  if (xmlhttp.readyState==4 && xmlhttp.status==200 )
					    {	
					    	if(xmlhttp.responseText = ""){
            					document.getElementById("tickerBanner").innerHTML = "waiting";   
            					}else{
            					document.getElementById("tickerBanner").innerHTML = xmlhttp.responseText;   
            					}
            					//getStockQuote();
						setTimeout(function(){
						    getStockQuote();
						}, 15000);            					
					    }
					  }
            				document.getElementById("tickerBanner").innerHTML = "loading"; 
					xmlhttp.open("GET", "stockQuotes.jsp?sybol=GE",true);
            				xmlhttp.send();            
            }
        </script>   
  </head>
<!-- NAVBAR
================================================== -->
  <body onload="getStockQuote()" >
    <!-- Fixed navbar -->
    <nav class="navbar navbar-default">
    <div class="container">
    <div class="navbar-header">
    <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar">
    <span class="sr-only">Toggle navigation</span>
    <span class="icon-bar"></span>
    <span class="icon-bar"></span>
    <span class="icon-bar"></span>
    </button>
	<a href="https://www.mytruckboard.com"><span class="image navbar-brand"  style="height: 35px; margin-left: 10px; padding: 10px 0px 0px; border-right-width: 0px;"><img src="/trucking-new/images/mtb_app_logo.png" style="width:35px;height:35px;" ></span></a>
    </div>
    </div>
    </nav>
      <div class="navbar-wrapper">
        <div class="container">              
    <div class="container marketing">
      <div class="panel panel" >
      <div class="panel-head">
      <%
      int imgInt = 1 + (int)(Math.random() * ((22 - 1) + 1));
     // imgInt = 1;
      %>
    <div class="jumbotron" style="padding:25px 0px 0px 0px;background-color:white;border-color:white;">
    <p style="width:100%;text-align:center;padding:0px;font-size:1.8em;"><small><small>&nbsp;</small></small>&nbsp;My News Board <small><small><small>&copy;</small></small></small></p>
<!--
    <p style="width:100%;text-align:center;">
    <a href="loadboard.news.jsp?news_category=trucking">Trucking</a> - 
    <a href="loadboard.news.jsp?news_category=business">Business</a> - 
    <a href="loadboard.news.jsp?news_category=supplychain">Supply chain</a> - 
    <a href="loadboard.news.jsp?news_category=logistics">Logistics</a> - 
    <a href="loadboard.news.jsp?news_category=technology">Technology</a></p>
-->
    <img src="images/news/<%=imgInt%>.jpg" style="width:100%;" /></div>
    	<div class="well" style="padding:5px;background-color:white;border-color:white;">
    	<span id="tickerBanner"><small>loading</small></span></div>

	
      </div>   
      <div class="panel-body" style="background-color:white;"> 
      <%
		try{

		if(true){
			Class.forName("com.mysql.jdbc.Driver");
			String url = "jdbc:mysql://localhost/test?zeroDateTimeBehavior=convertToNull";
			Connection connection = DriverManager.getConnection(url,"<USERNAME>", "<PASSWORD>");
			// psMain = connection.prepareStatement("select count(load_nlp_id) as rowCount from loads_nlp_news where email is not null and phone is not null and message is not null");
			 
      %>
    <!--
<nav>
  <ul class="pagination">
    <li>
      <a href="loadboard.news.jsp?page=0" aria-label="Previous">
        <span aria-hidden="true">&laquo;</span>
      </a>
    </li>
    <%for(int b=1;b<pageTotal;b++){
    	%><li
<%
				if(request.getParameter("page")!=null){
					int  pageNumReq = Integer.parseInt(request.getParameter("page"));
					if(pageNumReq ==b ){
						%> class="active" <%
					}
				}
    	%>
    	><a href="loadboard.news.jsp?page=<%=b%>"><%=b%></a></li><%
    }%>
    <li>
      <a href="loadboard.news.jsp?page=<%=pageTotal+1%>" aria-label="Next">
        <span aria-hidden="true">&raquo;</span>
      </a>
    </li>
  </ul>
</nav>  
    -->
		<div id="responseProcess" style="font-size: 14px;background-color:white;">
<%
		

				PreparedStatement psMain = connection.prepareStatement("select *  from loads_nlp_news order by ts desc limit 20");	
				ResultSet resultSetTruck = psMain.executeQuery();				
				while (resultSetTruck.next()) {
				if(resultSetTruck.getString("message")!=null){
				
			    String timeDurration = "ago" ;
			    	if(true && resultSetTruck.getTimestamp("ts")!=null){
			    long currentTime = Calendar.getInstance().getTime().getTime();
			    long postTime = resultSetTruck.getTimestamp("ts").getTime();
			    long diff = currentTime - postTime;
			    long diffSeconds = diff / 1000 % 60;
			    long diffMinutes = diff / (60 * 1000) % 60;
			    long diffHours = diff / (60 * 60 * 1000) % 24;
			    long diffDays = diff / (60 * 60 * 1000 * 24);
			    //if (diffSeconds == 1)timeDurration = "1 Second " + timeDurration;
			    //else if (diffSeconds > 1) timeDurration = diffSeconds + " Seconds " + timeDurration;
			    if (diffMinutes == 1)timeDurration = "1 Minute " + timeDurration;
			    else if (diffMinutes > 1) timeDurration = diffMinutes + " Minutes " + timeDurration;
			    if (diffHours == 1)timeDurration = "1 Hour " + timeDurration;
			    else if (diffHours > 1) timeDurration = diffHours + " Hours " + timeDurration;
			    if (diffDays == 1)timeDurration = "1 Day " + timeDurration;
			    else if (diffDays > 1) timeDurration = diffDays + " Days " + timeDurration;  
			    	}				
					%><div class="well" style="background-color:white;border-width:0px;">
					<!--
					<span class="glyphicon glyphicon-user"></span>&nbsp;
					Account Number 
<%if(uuid !=null){%> 					
					<a href="loadboard.jsp?imgInt=<%=imgInt%>&source_client_id=<%=resultSetTruck.getString("source_client_id")%>" ><%=resultSetTruck.getString("source_client_id")%></a>					
<%}else{%>		
	<a href="../" >Sign in</a> or 
	<a href="../trucking-new/onboard.jsp" >Create New Account</a>
<%}%>
					<BR><BR>
					<span class="glyphicon glyphicon-file"></span>
					-->
					<span style="color:black;font-size:1.4em;"><%=resultSetTruck.getString("message").trim()%>.</span> 
					 <BR><BR>
					 <%
					  String[] wordArray = resultSetTruck.getString("message").trim().split(" ");
					  String smartUrl = "";
					  for(int k=0;k<4;k++){
					  	smartUrl = smartUrl+ wordArray[k]+ "_";
					  }
					  smartUrl = smartUrl+ "article";
					 %>
					 
					<% boolean showLineBreak = false;%>
					<%if((resultSetTruck.getString("fromLocation")!=null && !resultSetTruck.getString("fromLocation").equals(""))|| (resultSetTruck.getString("fromDate")!=null && !resultSetTruck.getString("fromDate").equals(""))){%>					
					<BR> 
					<% showLineBreak = true;%>
					<strong>
					<span class="glyphicon glyphicon-flag" style="font-size:1.8em;color:green;"></span> <%=NullCheck.check(resultSetTruck.getString("fromLocation"))%>
					</strong>
<BR><BR> 
					<%}%>
					<%if((resultSetTruck.getString("toLocation")!=null && !resultSetTruck.getString("toLocation").equals(""))|| (resultSetTruck.getString("toDate")!=null && !resultSetTruck.getString("toDate").equals(""))){%>					
					<%if(showLineBreak ==false){%>
					<BR> 
					<%}%>
					<strong>
					<span class="glyphicon glyphicon-flag" style="font-size:1.8em;color:green;"></span> <%=NullCheck.check(resultSetTruck.getString("toLocation"))%>
					</strong>
					
<BR><BR> 
					<%}%>
<!--
					 <a href="../article/<%=smartUrl%>/index.html?imgInt=<%=imgInt%>&article_id=<%=resultSetTruck.getString("load_nlp_id")%>" >
					 <span class="glyphicon glyphicon-eye-open" aria-hidden="true" style="font-size:1.8em;"></span>
					 <small>quick view</small></a>
&nbsp;&nbsp; 
					 <a href="loadboard.news.more.jsp?imgInt=<%=imgInt%>&article_id=<%=resultSetTruck.getString("load_nlp_id")%>" >
					 <span class="glyphicon glyphicon-search" aria-hidden="true" style="font-size:1.8em;"></span>
					 <small>more</small></a> 
-->
					&nbsp;&nbsp;
					<span class="glyphicon glyphicon-hand-right" aria-hidden="true"></span>
					&nbsp;&nbsp;
					<span class="glyphicon glyphicon-calendar"></span>
					<%=new SimpleDateFormat("MM/dd/YYYY h:mm a").format(resultSetTruck.getTimestamp("TS"))%> <small>PST</small>
					
					
					&nbsp;&nbsp;
					
					
					<%
					if(timeDurration.equals("ago")){
						timeDurration = "Seconds ago";
					}
					%>
					<span class="glyphicon glyphicon-time"></span> <%=timeDurration%>
					
					<%if(resultSetTruck.getString("messageSourceLocation")!=null){%>
					<BR><BR>
					
					<span class="glyphicon glyphicon-globe"></span> Area Code   
					<%=resultSetTruck.getString("messageSourceLocation")%>
					<%}%>

					</div>
					<HR style="height:7px;background-image: url('images/news/<%=imgInt%>.jpg');" >
					<%
				}
				}
				
				connection.close();
		}
	         }catch (Exception ex){
	             %><%=" " + ex %><%
	         }
%>		
	      </div>   

           <p><small>Trending now: <small>truck sharing platform truckboard
           crooked hillary energy bills job opening mechanical bullies expertise revolution america marketresearch recycle manufacturing slavery neverhillaryorwarren cars rightwingdems authors demplatform fashionstyle rock scrap demexit jobopportunity harcourtschool jobs whittier marketing learnandgrow careerarc tempe corruptdems networking used ohio farmaceutico experience hotrod motorcycle joinalc alc heating horatiocaine engineering sharing cintasjobs plumbing insulation parts salvage automotive job carparts benghazi hiring junkyard applied truck learning platform salute head devs car flex lies alcfam brexit green halalcosmetics peterbilt neverhillary mentoring. online america! developer growth merchants indiana
    </small></small></p>   
       </div>       		
       </div>
       <BR>
    
            <div class="container">
       <h4>news by "My Truck Board" <small><small>&copy;</small></small></h4>             
      <ul class="nav navbar-nav navbar-right" style="width:100%;" >
	<li >
      <a href="https://www.mytruckboard.com/articles/loadboard.news.jsp">
        Home 
        
      </a></li>
        </ul>
    
            </div>     
       <hr>
    	<footer>
        <p style="padding:5px;"> &copy; 2015 LiteWorks2, Inc. &middot; <a href="privacy_policy.html">Privacy Policy</a> &middot; <a href="terms_of_service.only.html">Terms of Service</a></p>
      </footer>	
      
      </div>
      </div>       
      </div>		
    <script>
        (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
                    (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
                m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
        })(window,document,'script','//www.google-analytics.com/analytics.js','ga');

        ga('create', 'UA-28886039-1', 'auto');
        ga('send', 'pageview');

    </script>	  		  	 
  </body>
</html>