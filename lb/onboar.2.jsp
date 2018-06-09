<%@ page import="com.big.util.*,java.text.*,java.util.*,java.io.*,javax.xml.parsers.*,org.w3c.dom.*,java.sql.*,java.text.DateFormat" %>

        <!DOCTYPE HTML>
<html>
<head>
    <meta name="google-site-verification" content="1QihUOuRwEWAj8QtNgUtpFsrC2CI7cY100legePbzWQ" />
    <meta http-equiv="cache-control" content="max-age=0" />
    <meta http-equiv="cache-control" content="no-cache" />
    <meta http-equiv="expires" content="0" />
    <meta http-equiv="expires" content="Tue, 01 Jan 1980 1:00:00 GMT" />
    <meta http-equiv="pragma" content="no-cache" />


    <script type="text/javascript">
        var RecaptchaOptions = {
            theme : 'white'
        };
    </script>

    <title>MYTRUCKBOARD 2.0 - Freight management and dispatch made easy.</title>

    <link rel="shortcut icon" href="https://www.mytruckboard.com/images/mtb-favicon.ico">

    <meta http-equiv="content-type" content="text/html; charset=utf-8" />

    <meta name="description" content="Manage independent truck drivers and un-utilized capacity with GPS based dispatch system designed to drive more profit to your brokerage." />
    <meta name="keywords" content="freight, transportation, dispatch management, load optimization, truck broker, transportation management, truck, truck fleet management, shippers, truck brokers, shipping made easy, trucking industry, trucking software, trucking, dispatch for freight brokder, carrier management, load board, load, board" />

    <link href="https://fonts.googleapis.com/css?family=Roboto:100,100italic,300,300italic,400,400italic" rel="stylesheet" type="text/css" />
    <!--[if lte IE 8]><script src="css/ie/html5shiv.js"></script><![endif]-->

    <script type="text/javascript" src="js/jquery.min.js"></script>
    <script src="js/skel.min.js"></script>
    <script src="js/init2.js"></script>


    <noscript>
        <link rel="stylesheet" href="css/skel-noscript.css" />
        <link rel="stylesheet" href="css/style-wide.css" />
     </noscript>


    <!-- Bootstrap core CSS -->
    <link href="css/bootstrap.min.css" rel="stylesheet">

    <link href="css/style.css" rel="stylesheet">


    <!-- Custom styles for this template -->
    <link href="css/navbar-fixed-top.css" rel="stylesheet">


    <!--[if lte IE 8]><link rel="stylesheet" href="css/ie/v8.css" /><![endif]-->
    <!--[if lte IE 9]><link rel="stylesheet" href="css/ie/v9.css" /><![endif]-->

    <style>
        .dark .button
        {
            background: #47A249;
            box-shadow: inset 0 0 0 1px #fff;
            color: #fff;
        }

        .button
        {
            background: #47A249;
           }

    .checkbox input
        {
        border: 3px #47A249;
        margin-top: 8px;

            }

    .checkbox label {
    padding-left: 5px;
    padding-bottom: 3px;
    font-size: 1em;
    color: #337ab7;
    font-weight: 300;
    }
    </style>
    <script language="JavaScript" type="text/javascript">
        function updateSaferSys(){
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
			var addressList = xmlhttp.responseText.split("<ITEM>");
			//alert( xmlhttp.responseText);
			//document.getElementById("safer_address1").value = addressList[3]; 
			//document.getElementById("safer_city").value = addressList[4]; 
			//document.getElementById("safer_state").value = addressList[5]; 
			//document.getElementById("safer_zip").value = addressList[6]; 
			//document.getElementById("safer_fax").value = addressList[8]; 
			//document.getElementById("safer_needed").value = addressList[1]; 
			//document.getElementById("safer_onfile").value = addressList[2];  
			if(addressList[7].length > 0 ){
				document.getElementById("phone").value = addressList[7]; 
			}
			if(addressList[9].length > 0 ){
				document.getElementById("company_name").value = addressList[9]; 
			}
			
			//document.getElementById("safer_mc").value = document.getElementById("location_mc").value; 
			
		}
		}
		var responseString = "?MC_NO=" + encodeURIComponent(document.getElementById("location_mc").value);
		xmlhttp.open("GET", "safersys.api.jsp" + responseString,true);
		xmlhttp.send();
            }   
     </script>
<style type="text/css">
body{
    background-color: #525252;
}
.centered-form{
	margin-top: 60px;
}

.centered-form .panel{
	background: rgba(255, 255, 255, 0.8);
	box-shadow: rgba(0, 0, 0, 0.3) 20px 20px 20px;
}
</style>     
</head>
<body>



<!-- First -->

<div class="container">
        <div class="row centered-form">
        <div class="col-xs-12 col-sm-8 col-md-4 col-sm-offset-2 col-md-offset-4">
        	<div class="panel panel-default">
        		<div class="panel-heading">
			    		<h3 class="panel-title">Please sign up for Bootsnipp <small>It's free!</small></h3>
			 			</div>
			 			<div class="panel-body">
			    		<form role="form">
			    			<div class="row">
			    				<div class="col-xs-6 col-sm-6 col-md-6">
			    					<div class="form-group">
			                <input type="text" name="first_name" id="first_name" class="form-control input-sm" placeholder="First Name">
			    					</div>
			    				</div>
			    				<div class="col-xs-6 col-sm-6 col-md-6">
			    					<div class="form-group">
			    						<input type="text" name="last_name" id="last_name" class="form-control input-sm" placeholder="Last Name">
			    					</div>
			    				</div>
			    			</div>

			    			<div class="form-group">
			    				<input type="email" name="email" id="email" class="form-control input-sm" placeholder="Email Address">
			    			</div>

			    			<div class="row">
			    				<div class="col-xs-6 col-sm-6 col-md-6">
			    					<div class="form-group">
			    						<input type="password" name="password" id="password" class="form-control input-sm" placeholder="Password">
			    					</div>
			    				</div>
			    				<div class="col-xs-6 col-sm-6 col-md-6">
			    					<div class="form-group">
			    						<input type="password" name="password_confirmation" id="password_confirmation" class="form-control input-sm" placeholder="Confirm Password">
			    					</div>
			    				</div>
			    			</div>
			    			
			    			<input type="submit" value="Register" class="btn btn-info btn-block">
			    		
			    		</form>
			    	</div>
	    		</div>
    		</div>
    	</div>
    </div>


    <!-- the jScrollPane script -->
    <script type="text/javascript" src="js/jquery.jscrollpane.min.js"></script>

    <!-- Bootstrap core JavaScript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster -->
    <script src="js/bootstrap2.min.js"></script>


    <script>
        (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
                    (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
                m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
        })(window,document,'script','//www.google-analytics.com/analytics.js','ga');

        ga('create', 'UA-28886039-1', 'auto');
        ga('send', 'pageview');

    </script>
    <script>
    $(document).ready(function() {
        $('#registerForm')
            .formValidation({
                framework: 'bootstrap',
                icon: {
                    valid: 'glyphicon glyphicon-ok',
                    invalid: 'glyphicon glyphicon-remove',
                    validating: 'glyphicon glyphicon-refresh'
                },
                fields: {
                    userName: {
                        validators: {
                            notEmpty: {
                                message: 'The user name is required'
                            },
                            remote: {
                                url: '/examples/adding-warning-validation-state/test.json'
                            }
                        }
                    }
                }
            })
            // This event will be triggered when the field passes given validator
            .on('success.validator.fv', function(e, data) {
                // data.field     --> The field name
                // data.element   --> The field element
                // data.result    --> The result returned by the validator
                // data.validator --> The validator name
    
                if (data.field === 'userName'
                    && data.validator === 'remote'
                    && (data.result.available === false || data.result.available === 'false'))
                {
                    // The userName field passes the remote validator
                    data.element                    // Get the field element
                        .closest('.form-group')     // Get the field parent
    
                        // Add has-warning class
                        .removeClass('has-success')
                        .addClass('has-warning')
    
                        // Show message
                        .find('small[data-fv-validator="remote"][data-fv-for="userName"]')
                            .show();
                }
            })
            // This event will be triggered when the field doesn't pass given validator
            .on('err.validator.fv', function(e, data) {
                // We need to remove has-warning class
                // when the field doesn't pass any validator
                if (data.field === 'userName') {
                    data.element
                        .closest('.form-group')
                        .removeClass('has-warning');
                }
            });
    });
</script>
	</body>
</html>