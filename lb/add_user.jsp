<%@ page
        import="com.big.util.*,java.text.*,java.util.*,java.io.*,javax.xml.parsers.*,org.w3c.dom.*,java.sql.*,java.text.DateFormat" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">
    <link rel="icon" href="favicon.ico">
    <link href="https://fonts.googleapis.com/css?family=Roboto:100,100italic,300,300italic,400,400italic"
          rel="stylesheet" type="text/css"/>
    <title>Add Truck - MYTRUCKBOARD 2.0 - freight dispatch and management software</title>
    <link rel="shortcut icon" href="http://www.mytruckboard.com/trucking-new/images/mtb-favicon.ico">
    <meta http-equiv="content-type" content="text/html; charset=utf-8"/>
    <meta name="description"
          content="The complete freight management software. Win shipping deals and manage your fleet of trucks effortlessly."/>
    <meta name="keywords"
          content="freight, transportation, dispatch management, load optimization, truck broker, transportation management, truck, truck fleet management, shippers, truck brokers, shipping made easy, trucking industry, trucking software, trucking, dispatch for freight brokder, carrier management, load board, load, board"/>

    <!-- Bootstrap core CSS -->
    <link href="css/bootstrap2.min.css" rel="stylesheet">

    <!-- Custom styles for this template -->
    <link href="css/navbar-fixed-top.css" rel="stylesheet">

    <!-- custom styles -->
    <link href="css/style2.css" rel="stylesheet">
    <!--- custom style -->
    <link href="css/style4.css" rel="stylesheet">
    <!--- custom style -->
    <link href="css/portlet.css" rel="stylesheet">


    <script type="text/javascript" src="js/jquery-2.1.3.min.js"></script>
    <script type="text/javascript" src="js/jquery-ui.min.js"></script>

    <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
    <!--[if lt IE 9]>
    <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
    <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->


    <!-- Bootstrap core JavaScript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster -->

    <script src="js/bootstrap2.min.js"></script>

    <link rel="stylesheet" href="css/navstyle2.css"/>
    <link rel="stylesheet" href="css/newstyle2.css"/>

    <style>

        .btn-block {

            display: -webkit-inline-box;
        }
        .panel-heading {

            padding: 10px 10px;
        }
    </style>
</head>


<%
    String uuid = (String) session.getAttribute("uuid");
    boolean needStatusUpdate = false;
    String[] user_teams = new String[3];
    int j = 0;
    if (uuid != null && (session.getAttribute("isAdmin").equals("true"))) {
        String errorMsg = "";
%>

<%
    try {
    Class.forName("com.mysql.jdbc.Driver");
    String url = "jdbc:mysql://localhost/test?zeroDateTimeBehavior=convertToNull";
    Connection connection = DriverManager.getConnection(url, "<USERNAME>", "<PASSWORD>");

    PreparedStatement psMain = null;
    psMain = connection.prepareStatement("select name from test.TRUCKING_USER_teams where company_id = ?");
    psMain.setString(1, uuid);
    ResultSet resultSet = psMain.executeQuery();
    int i = 0;

    while (resultSet.next()) {
        user_teams[i] = resultSet.getString("name");
        i++;
    }

        connection.close();
    } catch (Exception ex) {
    errorMsg = "" + ex.getMessage();
    System.out.println("" + ex);
    }
    boolean didAddUser = false;
%>

%>

<%if (request.getParameter("addaccount") != null) {%>
<%if (request.getParameter("email") != null && !request.getParameter("email").equals("") && request.getParameter("password") != null && !request.getParameter("password").equals("") && request.getParameter("ReEnterPassword") != null && !request.getParameter("ReEnterPassword").equals("")) {%>
<%if (request.getParameter("password").equals(request.getParameter("ReEnterPassword"))) {%>
<%
    try {

        float fin_amount = 0.0f;
        if (!request.getParameter("gross_rate").equals(""))
            fin_amount = Float.parseFloat(request.getParameter("gross_rate").trim());

        boolean saveIsActive = false;
        boolean saveOwner = false;
        boolean saveAccessDriverPay = false;
        boolean saveEditDriverPay = false;
        boolean savePrintPendingLoads = false;
        boolean saveCreatePendingLoads = false;
        boolean saveSaveUserSearch = false;
        boolean saveAccountingContact = false;
        boolean savePrimaryContact = false;

        boolean saveManager = false;
        boolean saveSales = false;
        boolean saveDispatcher = false;

        if(request.getParameter("primary_contact")!=null && request.getParameter("primary_contact").equals("Yes"))savePrimaryContact= true;
        if(request.getParameter("isActive")!=null && request.getParameter("isActive").equals("Active"))saveIsActive= true;
        if(request.getParameter("owner")!=null && request.getParameter("owner").equals("Yes"))saveOwner= true;
        if(request.getParameter("access_driver_pay")!=null && request.getParameter("access_driver_pay").equals("Yes"))saveAccessDriverPay= true;
        if(request.getParameter("edit_driver_pay")!=null && request.getParameter("edit_driver_pay").equals("Yes"))saveEditDriverPay= true;
        if(request.getParameter("print_pending_loads")!=null && request.getParameter("print_pending_loads").equals("Yes"))savePrintPendingLoads= true;
        if(request.getParameter("create_pending_loads")!=null && request.getParameter("create_pending_loads").equals("Yes"))saveCreatePendingLoads= true;
        if(request.getParameter("save_user_search")!=null && request.getParameter("save_user_search").equals("Yes"))saveSaveUserSearch= true;
        if(request.getParameter("accounting_contact")!=null && request.getParameter("accounting_contact").equals("Yes"))saveAccountingContact= true;

        if(request.getParameter("manager")!=null && request.getParameter("manager").equals("Yes"))saveManager= true;
        if(request.getParameter("sales")!=null && request.getParameter("sales").equals("Yes"))saveSales= true;
        if(request.getParameter("dispatcher")!=null && request.getParameter("dispatcher").equals("Yes"))saveDispatcher= true;


        Class.forName("com.mysql.jdbc.Driver");
        String url = "jdbc:mysql://localhost/test?zeroDateTimeBehavior=convertToNull";
        Connection connection = DriverManager.getConnection(url, "<USERNAME>", "<PASSWORD>");


        PreparedStatement ps = connection.prepareStatement("INSERT INTO test.TRUCKING_USERS(EMAIL, PASSWORD, COMPANY_ID, IS_ADMIN, email_code, sms_code, start_ip, last_ip, chain_ip, ts, f_name, l_name, address1, city, zip, state, country, phone, fax, pay_type, is_owner, primary_contact, accounting_contact, gross_rate, is_online, access_driver_pay, edit_driver_pay, create_pending_loads, print_pending_loads, save_user_search, email2, ss, dl, is_online_register) VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,0)");
        ps.setString(1, request.getParameter("email").toLowerCase());
        ps.setString(2, request.getParameter("password"));
        ps.setString(3, uuid);
        ps.setBoolean(4, false);
        ps.setString(5, (UUID.randomUUID() + "").substring(0, 4));
        ps.setString(6, (UUID.randomUUID() + "").substring(0, 4));
        ps.setString(7, request.getRemoteAddr());
        ps.setString(8, request.getRemoteAddr());
        ps.setString(9, request.getRemoteAddr());
        java.sql.Timestamp ts = new java.sql.Timestamp((new java.util.Date()).getTime());
        ps.setTimestamp(10, ts);
        ps.setString(11, request.getParameter("f_name"));
        ps.setString(12, request.getParameter("l_name"));
        ps.setString(13, request.getParameter("address1"));
        ps.setString(14, request.getParameter("city"));
        ps.setString(15, request.getParameter("zip"));
        ps.setString(16, request.getParameter("state"));
        ps.setString(17, request.getParameter("country"));
        ps.setString(18, request.getParameter("phone"));
        ps.setString(19, request.getParameter("fax"));
        ps.setString(20, request.getParameter("pay_type"));
        ps.setBoolean(21, saveOwner);
        ps.setBoolean(22, savePrimaryContact);
        ps.setBoolean(23, saveAccountingContact);
        ps.setFloat(24, fin_amount);
        ps.setBoolean(25, saveIsActive);
        ps.setBoolean(26, saveAccessDriverPay);
        ps.setBoolean(27, saveEditDriverPay);
        ps.setBoolean(28, saveCreatePendingLoads);
        ps.setBoolean(29, savePrintPendingLoads);
        ps.setBoolean(30, saveSaveUserSearch);
        ps.setString(31, request.getParameter("email2"));
        ps.setString(32, request.getParameter("ss"));
        ps.setString(33, request.getParameter("dl"));

        if(ps.executeUpdate()>0)didAddUser=true;


        connection.close();
    } catch (Exception ex) {
        errorMsg = "" + ex.getMessage();
        System.out.println("" + ex);
    }
%>
<%} else {%>
<% errorMsg = "Re-entered password is not matching. Make sure to type same password in both fields?<BR>";%>
<%}%>
<%} else {%>
<% errorMsg = "Email and Password fields are required to create a new account <BR>";%>
<%}%>
<%}%>

<script language="JavaScript" type="text/javascript">

    function updateStatus(username, newRole, newTeam) {
        //alert("called load trucks");
        var xmlhttp;
        if (window.XMLHttpRequest) {// code for IE7+, Firefox, Chrome, Opera, Safari
            xmlhttp = new XMLHttpRequest();
        }
        else {// code for IE6, IE5
            xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
        }
        xmlhttp.onreadystatechange = function () {
            if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {

                var addressList = xmlhttp.responseText.split("<ITEM>");
                var updatedSelectBox = "select" + addressList[2];
                var updatedSpanBox = "spanWOLink" + addressList[2];
                var tmpElementName = "";
                var tmpElementNameL = "L";
                if (addressList[3] == "Manager") {
                    tmpElementName = "M" + addressList[2] + addressList[1];
                }
                if (addressList[3] == "Sales") {
                    tmpElementName = "S" + addressList[2] + addressList[1];
                }
                if (addressList[3] == "Dispatcher") {
                    tmpElementName = "D" + addressList[2] + addressList[1];
                }
                tmpElementNameL = tmpElementNameL + tmpElementName;
                if (addressList[4] == "true") {
                    document.getElementById(tmpElementNameL).style.backgroundColor = "";
                } else {
                    document.getElementById(tmpElementNameL).style.backgroundColor = "red";
                }
            }
        }
        var responseString = "?consignee_count=0";
        responseString = responseString + "&user_id=" + username;
        responseString = responseString + "&role=" + newRole;
        responseString = responseString + "&team_id=" + newTeam;
        var tmpElementName = "";
        var tmpElementNameL = "L";
        if (newRole == "Manager") {
            tmpElementName = "M" + username + newTeam;
        }
        if (newRole == "Sales") {
            tmpElementName = "S" + username + newTeam;
        }
        if (newRole == "Dispatcher") {
            tmpElementName = "D" + username + newTeam;
        }
        tmpElementNameL = tmpElementNameL + tmpElementName;
        document.getElementById(tmpElementNameL).style.backgroundColor = "Orange";
        responseString = responseString + "&check_status=" + document.getElementById(tmpElementName).checked;
        xmlhttp.open("GET", "manage_teams.state.jsp" + responseString, true);
        xmlhttp.send();
    }
</script>
<body>

<!-- Fixed navbar -->

<%@include file="nav_menu.jsp"%>

<br><br><br>
<!-- Main page: -->

<div class="container">
 <div class="row">
<%if(!errorMsg.equals("")){%>
<div class="alert alert-danger" role="alert">
  <span class="glyphicon glyphicon-exclamation-sign" aria-hidden="true"></span>
  <span class="sr-only">Error:</span>
  <%=errorMsg%>
</div>
<%}else if(didAddUser){%>
<div class="alert alert-success" role="alert">
  <span class="glyphicon glyphicon-exclamation-sign" aria-hidden="true"></span>
  <span class="sr-only">Success:</span>
  User added
</div>
<%}%>
        <form  name="searchForm" id="searchForm" action="add_user.jsp" method="post">
            <input type="hidden" name="addaccount" value="createaccount">


            <div class="portlet box blue">
                <div class="portlet-title">
                    <div class="caption">
                        <i class="fa fa-user" style="margin-top: 2px;"></i>Add New User
                    </div>
                     <div class="tools">
                        <button class="btn btn-success btn-xs"  role="button"  name="save" id="btn_save" type="submit" ><span class="glyphicon glyphicon-save" aria-hidden="true"></span>&nbsp;SAVE</button>

                    </div>
             </div>


                <div class="panel-body">
                    <div class="form-wrapper">

                        <div class="row">
                            <div class="col-md-2">
                                <div class="form-group">
                                    <label>First Name </label>
                                    <input type="text" class="form-control" name="f_name"
                                           id="f_name"  />
                                </div>
                            </div>

                            <div class="col-md-2">
                                <div class="form-group">
                                    <label>Last Name</label>
                                    <input type="text" class="form-control" name="l_name" id="l_name"
                                    />
                                </div>
                            </div>




                            <div class="col-md-2">
                                <div class="form-group">
                                    <label>Driver License No.</label>

                                        <input type="text" class="form-control" name="dl"
                                               id="dl"
                                        />

                                </div>
                            </div>

                            <div class="col-md-2">
                                <div class="form-group">
                                    <label>Social Security</label>


                                        <input type="text" class="form-control" name="ss"
                                               id="ss"
                                        />

                                </div>
                            </div>
                        </div>


                        <div class="row">


                            <div class="col-md-4">
                                <div class="form-group">

                                        <label>e-mail / username</label>
                                        <input type="text" class="form-control" name="email"
                                               id="email" value="<%=NullCheck.check(request.getParameter("f_name"))%>"

                                        />

                                </div>
                            </div>

                            <div class="col-md-2">
                                <div class="form-group">

                                        <label>password</label>
                                        <input type="password" class="form-control" name="password"
                                               id="password"

                                        />

                                </div>
                            </div>

                            <div class="col-md-2">
                                <div class="form-group">

                                    <label>confirm password</label>
                                    <input type="password" class="form-control" name="ReEnterPassword"
                                           id="ReEnterPassword"
                                    />

                                </div>
                            </div>

                            <div class="row">

                                <div class="col-md-3">
                                    <div class="form-group">
                                        <label>secondary e-mail</label>
                                        <input type="text" class="form-control" name="email2"
                                               id="email2"
                                        />
                                    </div>
                                </div>

                            </div>

                        </div>



                        <div class="row">
                              <div class="col-md-2">
                                <div class="form-group">
                                    <label>Cell Phone</label>
                                    <input type="text" class="form-control" name="phone"
                                           id="phone"
                                           />
                                </div>
                            </div>

                            <div class="col-md-2">
                                <div class="form-group">
                                    <label>Fax</label>
                                    <input type="text" class="form-control"
                                           name="fax" id="fax"
                                     />
                                </div>
                            </div>

                            <div class="col-md-2">
                                <div class="form-group">
                                    <label>Address</label>
                                    <input type="text" class="form-control"
                                           name="address1" id="address1"
                                     />
                                </div>
                            </div>

                            <div class="col-md-2">
                                <div class="form-group">
                                    <label>City</label>
                                    <input type="text" class="form-control" name="city" id="city"
                                   />
                                </div>
                            </div>


                            <div class="col-md-1">
                                <div class="form-group">
                                    <label>Zip Code</label>
                                    <input type="text" class="form-control" name="zip"
                                           id="zip"
                                     />
                                </div>
                            </div>

                            <div class="col-md-1">
                                <div class="form-group">
                                    <label>State</label>
                                    <input type="text" class="form-control" name="state" id="state"
                                    />
                                </div>
                            </div>

                            <div class="col-md-2">
                                <div class="form-group">
                                    <label>Country</label>
                                    <input type="text" class="form-control" name="country" id="country"
                                    />
                                </div>
                            </div>


                        </div>



                    </div><!-- end of form wrapper -->

                    <div class="form-wrapper">

                        <div class="row">

                            <div class="col-md-3">
                                <div class="form-group">
                                    <label>Team</label>
                                    <select class="form-control">
                                        <% for (j = 0; j < user_teams.length; j++) {
                                         %>
                                        <option value="<%=NullCheck.check(user_teams[j])%>"><%=NullCheck.check(user_teams[j])%></option>
                                        <%}%>
                                    </select>
                                </div>
                            </div>


                        </div>


                        <div class="row">


                            <div class="col-md-2">
                                <div class="form-group">

                                        <label>Manager</label>

                                        <input type="checkbox" name="manager" id="manager"
                                        value="Yes"

                                        />



                                    <input type="text" class="form-control" name="manager_commission"
                                           id="manager_commission"
                                           >
                                </div>
                            </div>

                            <div class="col-md-2">
                                <div class="form-group">

                                        <label>Sales</label>

                                        <input type="checkbox" name="sales" id="sales"
                                               value="Yes"
                                                />

                                    <input type="text" class="form-control" name="sales_commission"
                                           id="sales_commission"
                                           >
                                </div>
                            </div>


                            <div class="col-md-2">
                                <div class="form-group">

                                        <label>Dispatcher</label>

                                        <input type="checkbox" name="dispatch" id="dispatch"
                                               value="Yes"
                                                />

                                    <input type="text" class="form-control" name="dispatcher_commission"
                                           id="dispatcher_commission"
                                          >
                                </div>
                            </div>


                            <div class="col-md-2">
                                <div class="form-group">
                                    <label>Pay Type</label>
                                    <input type="text" class="form-control" name="pay_type"
                                           id="gross" placeholder="Percent Gross"

                                           />
                                </div>
                            </div>

                            <div class="col-md-2">
                                <div class="form-group">
                                    <label>Gross %</label>
                                    <input type="text" class="form-control" name="gross_rate"
                                           id="gross_rate"
                                     />
                                </div>
                            </div>


                        </div>

                    </div>

                    <div class="form-wrapper">

                        <div class="row">

                            <div class="col-md-2">
                                <div class="form-group">
                                    <label>Owner</label>

                                    <div class="checkbox">
                                        <label style="padding-left:20px">
                                            <input type="checkbox" name="owner" id="owner"
                                            value="Yes"  />
                                            Company owner
                                        </label>
                                    </div>

                                </div>
                            </div>


                            <div class="col-md-2">
                                <div class="form-group">
                                    <label>Contact</label>

                                    <div class="checkbox">
                                        <label style="padding-left:20px">
                                            <input type="checkbox" name="primary_contact" id="primary_contact"
                                                   value="Yes"/>
                                            Primary contact
                                        </label>
                                    </div>

                                </div>
                            </div>

                            <div class="col-md-2">
                                <div class="form-group">
                                    <label>Accounting</label>

                                    <div class="checkbox">
                                        <label style="padding-left:20px">
                                            <input type="checkbox" name="accounting_contact" id="accounting_contact"

                                                   value="Yes"  />
                                            Accounting contact
                                        </label>
                                    </div>

                                </div>
                            </div>


                            <div class="col-md-2">
                                <div class="form-group">
                                    <label>Account Status</label><br/>

                                    <label class="radio-inline" style="color:#777; padding-left: 20px;margin-top: 10px;">
                                        <input type="radio" name="isActive" id="isActive" value="Active" checked
                                      /> Active
                                    </label>
                                    <label class="radio-inline" style="color:#777; padding-left: 20px;margin-top: 10px;">
                                        <input type="radio" name="isActive" id="isActive" value="Inactive"
                                              /> Inactive
                                    </label>

                                </div>
                            </div>

                        </div>

                    </div>



                    <div class="form-wrapper">

                        <div class="row">

                            <div class="col-md-2">
                                <div class="form-group">
                                    <label>Driver Pay</label>

                                    <div class="checkbox">
                                        <label style="padding-left:20px">
                                            <input type="checkbox" name="access_driver_pay" id="access_driver_pay"

                                                   value="Yes" />
                                            Access Driver Pay
                                        </label>
                                    </div>

                                </div>
                            </div>


                            <div class="col-md-2">
                                <div class="form-group">
                                    <label>Pending Loads</label>

                                    <div class="checkbox">
                                        <label style="padding-left:20px">
                                            <input type="checkbox" name="create_pending_loads" id="create_pending_loads"
                                                   value="Yes" />
                                            Create Only PLs
                                        </label>
                                    </div>

                                </div>
                            </div>

                            <div class="col-md-2">
                                <div class="form-group">
                                    <label>Print</label>

                                    <div class="checkbox">
                                        <label style="padding-left:20px">
                                            <input type="checkbox" name="print_pending_loads" id="print_pending_loads"

                                                   value="Yes" />
                                            Print Pending Loads
                                        </label>
                                    </div>

                                </div>
                            </div>

                            <div class="col-md-2">
                                <div class="form-group">
                                    <label>Save User Search</label>

                                    <div class="checkbox">
                                        <label style="padding-left:20px">
                                            <input type="checkbox" name="save_user_search" id="save_user_saerch"

                                                   value="Yes" />
                                            Save User Search
                                        </label>
                                    </div>

                                </div>
                            </div>
                            <div class="col-md-2">
                                <div class="form-group">
                                    <label>Edit Driver Pay</label>

                                    <div class="checkbox">
                                        <label style="padding-left:20px">
                                            <input type="checkbox" name="edit_driver_pay" id="edit_driver_pay"

                                                   value="Yes" />
                                            Edit Driver Pay
                                        </label>
                                    </div>

                                </div>
                            </div>

                        </div>
                    </div>

                </div>

            </div>
        </form>
        <br />




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
                    <li>voice: (650) 567-4439</li>
                </ul>
            </div>
            <!-- .subfooter end -->
        </section>

    </div>

</div>

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
                <button type="button" class="btn btn-primary" data-dismiss="modal" onclick="location.href='../index4.jsp'">Dismiss</button>

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


<!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
<script src="assets/js/ie10-viewport-bug-workaround.js"></script>
<!---- gooogle analytics -->

<script type="text/javascript">

    var _gaq = _gaq || [];
    _gaq.push(['_setAccount', 'UA-28886039-1']);
    _gaq.push(['_trackPageview']);

    (function () {
        var ga = document.createElement('script');
        ga.type = 'text/javascript';
        ga.async = true;
        ga.src = ('https:' == document.location.protocol ? 'https://' : 'http://') + 'stats.g.doubleclick.net/dc.js';
        var s = document.getElementsByTagName('script')[0];
        s.parentNode.insertBefore(ga, s);
    })();

</script>
</body>
</html>
<%} else {%>

<body>

<!-- if user's session expired - open the modal box: and upon clicking relogin - send them to the login page -->


<script type="text/javascript">
    $(window).load(function () {
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
                <button type="button" class="btn btn-primary" onclick="location.href='https://www.mytruckboard.com'">
                    Login
                </button>

            </div>
        </div>
    </div>
</div>

</body>
</html>


<%}%>
