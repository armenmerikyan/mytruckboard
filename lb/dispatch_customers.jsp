<%@ page import="com.big.util.*,java.text.*,java.util.*,java.io.*,javax.xml.parsers.*,org.w3c.dom.*,java.sql.*,java.text.DateFormat" %>


	<html>

	<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<meta name="description" content="">
	<meta name="author" content="">
	<title>MYTRUCKBOARD 2.0 - dispatch shippers</title>
	<link rel="shortcut icon" href="http://www.mytruckboard.com/trucking-new/images/mtb-favicon.ico">
	<meta http-equiv="content-type" content="text/html; charset=utf-8" />
	<meta name="description" content="The complete freight management software. Win shipping deals and manage your fleet of trucks effortlessly." />
	<meta name="keywords" content="freight, transportation, dispatch management, load optimization, truck broker, transportation management, truck, truck fleet management, shippers, truck brokers, shipping made easy, trucking industry, trucking software, trucking, dispatch for freight brokder, carrier management, load board, load, board" />

	<!-- Bootstrap core CSS -->
	<link href="css/bootstrap2.min.css" rel="stylesheet">

	<!-- Custom styles for this template -->
	<link href="css/navbar-fixed-top.css" rel="stylesheet">

	<!-- custom styles -->
	<link href="css/style-ultimate.css" rel="stylesheet">


	<!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
	<!--[if lt IE 9]>
	<script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
	<script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
	<![endif]-->


	<link rel="stylesheet" href="css/bootstrap-datepicker3.min.css" />



	<!-- datepicker related -->

	<script type="text/javascript" src="js/jquery-2.1.3.min.js"></script>
	<script type="text/javascript" src="js/jquery-ui.min.js"></script>

	<script type="text/javascript" src="js/moment.js"></script>
    <!-- datepicker related
    <script type="text/javascript" src="js/transition.js"></script>
    <script type="text/javascript" src="js/collapse.js"></script>-->


    <script type="text/javascript" src="js/bootstrap-datetimepicker.min.js"></script>

	<!-- datepicker related -->

    <script type="text/javascript" src="js/notify.min.js"></script>

	<!--<script type="text/javascript"
	src="https://maps.googleapis.com/maps/api/js?key=AIzaSyBpeQ3zGuTunYzxmiNMUltHL352e4beac4">
	</script>
	-->


	<!--    <script language="JavaScript" type="text/javascript">
            function openCustomerDetail(load_id){
            	window.open("dispatch_edit_customers.jsp?location_id="+ load_id, load_id);
            }
   </script>
	-->
   <!-- <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7/jquery.js"></script>-->
    <script src="js/jquery.form.js"></script>

    <!-- CSS to style the file input field as button and adjust the Bootstrap progress bars -->
    <link rel="stylesheet" href="jQuery-File-Upload-9.11.2/css/jquery.fileupload.css">
    <link rel="stylesheet" href="jQuery-File-Upload-9.11.2/css/jquery.fileupload-ui.css">
    <!-- CSS adjustments for browsers with JavaScript disabled -->
    <noscript><link rel="stylesheet" href="jQuery-File-Upload-9.11.2/css/jquery.fileupload-noscript.css"></noscript>
    <noscript><link rel="stylesheet" href="jQuery-File-Upload-9.11.2/css/jquery.fileupload-ui-noscript.css"></noscript>
 
    <script> 
        // wait for the DOM to be loaded 

    var bar = $('.bar');
    var percent = $('.percent');
    var status = $('#status');
        $(document).ready(function() { 
            // bind 'myForm' and provide a simple callback function 
            $('#myForm').ajaxForm(function() { 
                alert("Thank you for your comment!"); 
		beforeSend: function() {
		    status.empty();
		    var percentVal = '0%';
		    bar.width(percentVal);
		    percent.html(percentVal);
		},
		uploadProgress: function(event, position, total, percentComplete) {
		    var percentVal = percentComplete + '%';
		    bar.width(percentVal);
		    percent.html(percentVal);
		},
		complete: function(xhr) {
		    status.html(xhr.responseText);
		}
        
            }); 
        }); 
    </script> 
        <script>        
        function gotItSMSMessageShow() {
        	//alert('Test');
	    $('#myModal').modal({
		show: 'false'
	    });         
    	}
        function gotItMessageShow() {
        	//alert('Test');
	    $('#myModal').modal({
		show: 'false'
	    });         
    	}
        </script>	
	<script language="JavaScript" type="text/javascript">
	function openCustomerFile(load_id){
		gotItSMSMessageShow();
		//window.location.replace("dispatch_edit_customers.jsp?location_id="+ load_id );
	}
	function openCustomerDetail(load_id){
	window.location.replace("dispatch_edit_customers.jsp?location_id="+ load_id );
	}
	</script>

	<!-- table sorter -->

	<script type="text/javascript" src="js/jquery.tablesorter.js"></script>
	<!-- end -->

	<script>
	$(document).ready(function(){

	$("#boardtable").tablesorter();

	});
	</script>

	<!-- =============== APP STYLES ===============-->
	<!--<link rel="stylesheet" href="css/table-app.css" id="maincss">

	<!-- Bootstrap core JavaScript
	================================================== -->
	<script src="js/bootstrap2.min.js"></script>


	<link rel="stylesheet" href="css/navstyle2.css" />


	<%if(session.getAttribute("issubscribed")!=null && session.getAttribute("issubscribed").equals("true")){%>
		<%
			String uuid = (String)session.getAttribute("uuid");

			if(uuid !=null){
%>


    <style>
    #myModal {
    top:10%;
    outline: none;
    }
    #myModal .modal-dialog  {width:70%; height:70%}
    #myModal .modal-body  {height:70%; overflow: auto;}
    </style>
		</head>


	<body>




			<%@include file="nav_menu.jsp"%>


<!-- Modal -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">File Upload</h4>
      </div>
      <div class="modal-body">


		  <!-- The file upload form used as target for the file upload widget -->
		  <form id="fileupload" action="//jquery-file-upload.appspot.com/" method="POST" enctype="multipart/form-data">
			  <!-- Redirect browsers with JavaScript disabled to the origin page -->
			  <noscript><input type="hidden" name="redirect" value="https://blueimp.github.io/jQuery-File-Upload/"></noscript>
			  <!-- The fileupload-buttonbar contains buttons to add/delete files and start/cancel the upload -->
			  <div class="row fileupload-buttonbar">
				  <div class="col-lg-9">
					  <!-- The fileinput-button span is used to style the file input field as button -->
                <span class="btn btn-success fileinput-button">
                    <i class="glyphicon glyphicon-plus"></i>
                    <span>Add files...</span>
                    <input type="file" name="files[]" multiple>
                </span>
					  <button type="submit" class="btn btn-primary start">
						  <i class="glyphicon glyphicon-upload"></i>
						  <span>Start upload</span>
					  </button>
					  <button type="reset" class="btn btn-warning cancel">
						  <i class="glyphicon glyphicon-ban-circle"></i>
						  <span>Cancel upload</span>
					  </button>
					  <button type="button" class="btn btn-danger delete">
						  <i class="glyphicon glyphicon-trash"></i>
						  <span>Delete</span>
					  </button>
					  <input type="checkbox" class="toggle">
					  <!-- The global file processing state -->
					  <span class="fileupload-process"></span>
				  </div>
				  <!-- The global progress state -->
				  <div class="col-lg-5 fileupload-progress fade">
					  <!-- The global progress bar -->
					  <div class="progress progress-striped active" role="progressbar" aria-valuemin="0" aria-valuemax="100">
						  <div class="progress-bar progress-bar-success" style="width:0%;"></div>
					  </div>
					  <!-- The extended global progress state -->
					  <div class="progress-extended">&nbsp;</div>
				  </div>
			  </div>
			  <!-- The table listing the files available for upload/download -->
			  <table role="presentation" class="table table-striped"><tbody class="files"></tbody></table>
		  </form>



      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
      </div>
    </div>
  </div>
</div>


	<div class="container-fluid">
	<div class="row">
	<div class="col-md-12">
	<br/><br/><br/><br/><br/><br/>
	</div>



	<div class="col-md-12">
	<div class="table-responsive">
	<table class="table table-hover table-bordered tablesorter" id="boardtable">
	<thead style="font-size:14px;" >
	<tr style="background:#F8F8F8;">
	<th>Company Name</th>
	<th>Phone</th>
	<th>Address</th>
	<th>City</th>
	<th>Zip Code</th>
	<th>State</th>
	<th>Files</th>
	<th>Edit</th>

	</tr>
	</thead>
	<tbody style="font-size:14px;">
<%
		 try{

			Class.forName("com.mysql.jdbc.Driver");
			String url = "jdbc:mysql://localhost/test?user=<PASSWORD>&password=<PASSWORD>";

			Connection connection = DriverManager.getConnection(url,"<USERNAME>", "<PASSWORD>");
			DateFormat formatter = new SimpleDateFormat("MM-dd-yyyy.HH.mm.ss");
			DateFormat formatterDate = new SimpleDateFormat("MM-dd-yyyy");
				String stringResponse = "";

				PreparedStatement ps = connection.prepareStatement("select * from test.locations where company_id = ? and location_type = ?");
				if(request.getParameter("isActive")!=null && request.getParameter("isActive").equals("true")){
					ps = connection.prepareStatement("select * from test.locations where company_id = ? and location_type = ? and isActive = 1 and org_name like ?");
					ps.setString(3, "%" + request.getParameter("searchKey") + "%");
				}else if(request.getParameter("isActive")!=null && request.getParameter("isActive").equals("false")){
					ps = connection.prepareStatement("select * from test.locations where company_id = ? and location_type = ? and isActive = 0 and org_name like ?");
					ps.setString(3, "%" + request.getParameter("searchKey") + "%");
				}				
				ps.setString(1, uuid);
				ps.setString(2, "Billing");
				ResultSet resultSet = ps.executeQuery();
				while (resultSet.next()) {
%>

			<tr>
			<td><a href="#" onclick="openCustomerDetail('<%=resultSet.getString("location_id")%>')"><%=resultSet.getString("org_name")%></a></td>
			<td><%=NullCheck.check(resultSet.getString("org_phone"))%></td>
			<td><%=NullCheck.check(resultSet.getString("address"))%></td>
			<td><%=NullCheck.check(resultSet.getString("city"))%></td>
			<td><%=NullCheck.check(resultSet.getString("zip"))%></td>
			<td><%=NullCheck.check(resultSet.getString("state"))%></td>
			<td><a href="#"><span class="glyphicon glyphicon-file" onclick="openCustomerFile('<%=resultSet.getString("location_id")%>')" ></span></a></td>
			<td><a href="#"><span class="glyphicon glyphicon-edit" onclick="openCustomerDetail('<%=resultSet.getString("location_id")%>')" ></span></a></td>

			</tr>	
            <%				
				}
			connection.close();
		 }catch (Exception ex){
		     %><%="Error Posting " + ex%><%
		     System.out.println(""+ ex);
		 }
				%>			

	
	</tbody>
	</table>

	</div>
	</div>
	<!-- END table-responsive-->

	</div>



	<!-- .subfooter start -->
	<!-- ================ -->
	<section id="footer">
	<div class="copyright">
	<ul class="menu">
	<li>Copyright &copy; 2015 Litewsorks2 Inc. All rights reserved.</li>
	</ul>
	<ul class="menu">
	<li>&copy;<a href="http://liteworks2.com">Litewsorks2 Inc</a> </li>
	<li>599 Fairchild Dr, Mountain View, CA 94043 United States</li>
	<li>email: LW2@liteworks2.com </li>
	<li>twitter: @liteworks2</li>
	<li>voice: 1.310.903.6014</li>
	</ul>
	</div>
	<!-- .subfooter end -->
	</section>


	<div class="modal fade" id="delconfirm" role="dialog" aria-labelledby="delconfirm" aria-hidden="true">
	<div class="modal-dialog">
	<div class="modal-content">
	<div class="modal-header">
	<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
	<h4 class="modal-title" id="myModalLabel" style="color:red">Delete Confirmation</h4>
	</div>
	<div class="modal-body">
	<h3>You are about to delete truck from your records.</h3>
	</div>
	<div class="modal-footer">
	<button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
	<button type="button" class="btn btn-primary" id="deleteonclick" >Delete</button>
    <input type="hidden" id="trucktodelete" />

	</div>
	</div>
	</div>
	</div>


	</div> <!--  container end -->


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
	<button type="button" class="btn btn-primary" data-dismiss="modal" onclick="location.href='https://www.mytruckboard.com'">Dismiss</button>

	</div>
	</div>
	</div>
	</div>


	<!------- support modal ---->

	<div class="modal fade" id="support" role="dialog" aria-labelledby="support" aria-hidden="true">
	<div class="modal-dialog">
	<div class="modal-content">
	<div class="modal-header">
	<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
	<h4 class="modal-title" id="myModalLabel" style="color:red">Support Information</h4>
	</div>
	<div class="modal-body">
	<div class="box-sm3a">
	<h2>Support is free.</h2>
	<p>We will get back to you within 24 hours</p>
	<p>Email: <b>lw2@liteworks2.com</b></p>
	<p>Voice: <b>1.310.903.6014</b></p>
	</div>


	</div>
	<div class="modal-footer">
	<button type="button" class="btn btn-primary" data-dismiss="modal">Dismiss</button>

	</div>
	</div>
	</div>
	</div>

	<!-- end of support modal -->

	<!---- gooogle analytics -->

	<script>
	(function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
	(i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
	m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
	})(window,document,'script','//www.google-analytics.com/analytics.js','ga');

	ga('create', 'UA-28886039-1', 'auto');
	ga('send', 'pageview');

	</script>

	<!---- end of gooogle analytics -->


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
<!-- The template to display files available for upload -->
<script id="template-upload" type="text/x-tmpl">
{% for (var i=0, file; file=o.files[i]; i++) { %}
    <tr class="template-upload">
        <td>
            <span class="preview"></span>
        </td>
        <td>
            <p class="name">{%=file.name%}</p>
            <strong class="error text-danger"></strong>
        </td>
        <td>
            <p class="size">Processing...</p>
            <div class="progress progress-striped active" role="progressbar" aria-valuemin="0" aria-valuemax="100" aria-valuenow="0"><div class="progress-bar progress-bar-success" style="width:0%;"></div></div>
        </td>
        <td>
            {% if (!i && !o.options.autoUpload) { %}
                <button class="btn btn-primary start" disabled>
                    <i class="glyphicon glyphicon-upload"></i>
                    <span>Start</span>
                </button>
            {% } %}
            {% if (!i) { %}
                <button class="btn btn-warning cancel">
                    <i class="glyphicon glyphicon-ban-circle"></i>
                    <span>Cancel</span>
                </button>
            {% } %}
        </td>
    </tr>
{% } %}
</script>
<!-- The template to display files available for download -->
<script id="template-download" type="text/x-tmpl">
{% for (var i=0, file; file=o.files[i]; i++) { %}
    <tr class="template-download">
        <td>
            <span class="preview">
                {% if (file.thumbnailUrl) { %}
                    <a href="{%=file.url%}" title="{%=file.name%}" download="{%=file.name%}" data-gallery><img src="{%=file.thumbnailUrl%}"></a>
                {% } %}
            </span>
        </td>
        <td>
            <p class="name">
                {% if (file.url) { %}
                    <a href="{%=file.url%}" title="{%=file.name%}" download="{%=file.name%}" {%=file.thumbnailUrl?'data-gallery':''%}>{%=file.name%}</a>
                {% } else { %}
                    <span>{%=file.name%}</span>
                {% } %}
            </p>
            {% if (file.error) { %}
                <div><span class="label label-danger">Error</span> {%=file.error%}</div>
            {% } %}
        </td>
        <td>
            <span class="size">{%=o.formatFileSize(file.size)%}</span>
        </td>
        <td>
            {% if (file.deleteUrl) { %}
                <button class="btn btn-danger delete" data-type="{%=file.deleteType%}" data-url="{%=file.deleteUrl%}"{% if (file.deleteWithCredentials) { %} data-xhr-fields='{"withCredentials":true}'{% } %}>
                    <i class="glyphicon glyphicon-trash"></i>
                    <span>Delete</span>
                </button>
                <input type="checkbox" name="delete" value="1" class="toggle">
            {% } else { %}
                <button class="btn btn-warning cancel">
                    <i class="glyphicon glyphicon-ban-circle"></i>
                    <span>Cancel</span>
                </button>
            {% } %}
        </td>
    </tr>
{% } %}
</script>

    <script src="//ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
    <!-- The jQuery UI widget factory, can be omitted if jQuery UI is already included -->
    <script src="js/vendor/jquery.ui.widget.js"></script>
    <!-- The Templates plugin is included to render the upload/download listings -->
    <script src="//blueimp.github.io/JavaScript-Templates/js/tmpl.min.js"></script>
    <!-- The Load Image plugin is included for the preview images and image resizing functionality -->
    <script src="//blueimp.github.io/JavaScript-Load-Image/js/load-image.all.min.js"></script>
    <!-- The Canvas to Blob plugin is included for image resizing functionality -->
    <script src="//blueimp.github.io/JavaScript-Canvas-to-Blob/js/canvas-to-blob.min.js"></script>
    <!-- Bootstrap JS is not required, but included for the responsive demo navigation -->
    <script src="//netdna.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"></script>
    <!-- blueimp Gallery script -->
    <script src="//blueimp.github.io/Gallery/js/jquery.blueimp-gallery.min.js"></script>
    <!-- The Iframe Transport is required for browsers without support for XHR file uploads -->
    <script src="jQuery-File-Upload-9.11.2/js/jquery.iframe-transport.js"></script>
    <!-- The basic File Upload plugin -->
    <script src="jQuery-File-Upload-9.11.2/js/jquery.fileupload.js"></script>
    <!-- The File Upload processing plugin -->
    <script src="jQuery-File-Upload-9.11.2/js/jquery.fileupload-process.js"></script>
    <!-- The File Upload image preview & resize plugin -->
    <script src="jQuery-File-Upload-9.11.2/js/jquery.fileupload-image.js"></script>
    <!-- The File Upload audio preview plugin -->
    <script src="jQuery-File-Upload-9.11.2/js/jquery.fileupload-audio.js"></script>
    <!-- The File Upload video preview plugin -->
    <script src="jQuery-File-Upload-9.11.2/js/jquery.fileupload-video.js"></script>
    <!-- The File Upload validation plugin -->
    <script src="jQuery-File-Upload-9.11.2/js/jquery.fileupload-validate.js"></script>
    <!-- The File Upload user interface plugin -->
    <script src="jQuery-File-Upload-9.11.2/js/jquery.fileupload-ui.js"></script>
    <!-- The main application script -->
    <script src="jQuery-File-Upload-9.11.2/js/main.js"></script>
<!--<script src="//ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
<script src="js/vendor/jquery.ui.widget.js"></script>
<script src="//blueimp.github.io/JavaScript-Templates/js/tmpl.min.js"></script>
<script src="//blueimp.github.io/JavaScript-Load-Image/js/load-image.all.min.js"></script>
<script src="//blueimp.github.io/JavaScript-Canvas-to-Blob/js/canvas-to-blob.min.js"></script>
<script src="js/jquery.iframe-transport.js"></script>
<script src="js/jquery.fileupload.js"></script>
    -->
<script>
/* global window, $ */
window.testBasicWidget = $.blueimp.fileupload;
</script>
<script src="js/jquery.fileupload-process.js"></script>
<script src="js/jquery.fileupload-image.js"></script>
<script src="js/jquery.fileupload-audio.js"></script>
<script src="js/jquery.fileupload-video.js"></script>
<script src="js/jquery.fileupload-validate.js"></script>
<script src="js/jquery.fileupload-ui.js"></script>
<script>
/* global window, $ */
window.testUIWidget = $.blueimp.fileupload;
</script>
<script src="//code.jquery.com/qunit/qunit-1.15.0.js"></script>
<script src="js/fileUpload.js"></script>
	</body>
	</html>



		<%}%>
	        	