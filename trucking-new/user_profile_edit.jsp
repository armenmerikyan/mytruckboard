<%@ page import="com.big.util.*,java.text.*,java.util.*,java.io.*,javax.xml.parsers.*,org.w3c.dom.*,java.sql.*,java.text.DateFormat" %>
        <!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">

        <title>Company Profile Edit - MYTRUCKBOARD 2.0 - dead simple freight dispatch</title>
        <link rel="shortcut icon" href="http://www.mytruckboard.com/trucking-new/images/mtb-favicon.ico">
        <meta http-equiv="content-type" content="text/html; charset=utf-8" />
        <meta name="description" content="The complete freight management software. Win shipping deals and manage your fleet of trucks effortlessly." />
        <meta name="keywords" content="freight, transportation, dispatch management, load optimization, truck broker, transportation management, truck, truck fleet management, shippers, truck brokers, shipping made easy, trucking industry, trucking software, trucking, dispatch for freight brokder, carrier management, load board, load, board" />

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
      String uuid = (String)session.getAttribute("uuid");

      if(uuid !=null){
  %>
  <%if(session.getAttribute("isAdmin").equals("true") && request.getParameter("cmd")!=null && request.getParameter("cmd").equals("saveprofileinfo")){
    %>

  <%
      try {
          float fin_amount = 0.0f;
          float fin_amount_manager = 0.0f;
          float fin_amount_sales = 0.0f;
          float fin_amount_dispatcher = 0.0f;
          if (!request.getParameter("gross_rate").equals(""))
              fin_amount = Float.parseFloat(request.getParameter("gross_rate").trim());
          if (!request.getParameter("manager_commission").equals(""))
              fin_amount_manager = Float.parseFloat(request.getParameter("manager_commission").trim());
          if (!request.getParameter("sales_commission").equals(""))
              fin_amount_sales = Float.parseFloat(request.getParameter("sales_commission").trim());
          if (!request.getParameter("dispatch_commission").equals(""))
              fin_amount_dispatcher = Float.parseFloat(request.getParameter("dispatch_commission").trim());

          boolean saveIsActive = false;
          boolean saveOwner = false;
          boolean saveAccessDriverPay = false;
          boolean saveEditDriverPay = false;
          boolean savePrintPendingLoads = false;
          boolean saveCreatePendingLoads = false;
          boolean saveSaveUserSearch = false;
          boolean saveAccountingContact = false;
          boolean savePrimaryContact = false;

          if(request.getParameter("primary_contact")!=null && request.getParameter("primary_contact").equals("Yes"))savePrimaryContact= true;
          if(request.getParameter("isActive")!=null && request.getParameter("isActive").equals("Active"))saveIsActive= true;
          if(request.getParameter("owner")!=null && request.getParameter("owner").equals("Yes"))saveOwner= true;
          if(request.getParameter("access_driver_pay")!=null && request.getParameter("access_driver_pay").equals("Yes"))saveAccessDriverPay= true;
          if(request.getParameter("edit_driver_pay")!=null && request.getParameter("edit_driver_pay").equals("Yes"))saveEditDriverPay= true;
          if(request.getParameter("print_pending_loads")!=null && request.getParameter("print_pending_loads").equals("Yes"))savePrintPendingLoads= true;
          if(request.getParameter("create_pending_loads")!=null && request.getParameter("create_pending_loads").equals("Yes"))saveCreatePendingLoads= true;
          if(request.getParameter("save_user_search")!=null && request.getParameter("save_user_search").equals("Yes"))saveSaveUserSearch= true;
          if(request.getParameter("accounting_contact")!=null && request.getParameter("accounting_contact").equals("Yes"))saveAccountingContact= true;

          Class.forName("com.mysql.jdbc.Driver");
          String url = "jdbc:mysql://localhost/test?zeroDateTimeBehavior=convertToNull";
          Connection connection = DriverManager.getConnection(url, "<USERNAME>", "<PASSWORD>");
          PreparedStatement ps2 = connection.prepareStatement("Update test.TRUCKING_USERS Set f_name = ?, l_name = ?, address1 = ?, city = ?, zip = ?, state = ?, country = ?, phone = ?, fax = ?, pay_type = ?, is_owner = ?, primary_contact = ?, accounting_contact = ?, gross_rate = ?, is_online = ?, access_driver_pay = ?, edit_driver_pay = ?, create_pending_loads = ?, print_pending_loads = ?, save_user_search = ?, email2 = ?, dl = ?, ss = ?, gross_rate_sales = ?, gross_rate_manager = ?, gross_rate_dispatcher = ? where email = ? and company_id = ?");
          ps2.setString(1, request.getParameter("f_name"));
          ps2.setString(2, request.getParameter("l_name"));
          ps2.setString(3, request.getParameter("address1"));
          ps2.setString(4, request.getParameter("city"));
          ps2.setString(5, request.getParameter("zip"));
          ps2.setString(6, request.getParameter("state"));
          ps2.setString(7, request.getParameter("country"));
          ps2.setString(8, request.getParameter("phone"));
          ps2.setString(9, request.getParameter("fax"));
          ps2.setString(10, request.getParameter("pay_type"));
          ps2.setBoolean(11, saveOwner);
          ps2.setBoolean(12, savePrimaryContact);
          ps2.setBoolean(13, saveAccountingContact);
          ps2.setFloat(14, fin_amount);
          ps2.setBoolean(15, saveIsActive);
          ps2.setBoolean(16, saveAccessDriverPay);
          ps2.setBoolean(17, saveEditDriverPay);
          ps2.setBoolean(18, saveCreatePendingLoads);
          ps2.setBoolean(19, savePrintPendingLoads);
          ps2.setBoolean(20, saveSaveUserSearch);
          ps2.setString(21, request.getParameter("email2"));
          ps2.setString(22, request.getParameter("dl"));
          ps2.setString(23, request.getParameter("ss"));
          ps2.setFloat(24, fin_amount_sales);
          ps2.setFloat(25, fin_amount_manager);
          ps2.setFloat(26, fin_amount_dispatcher);
          ps2.setString(27, request.getParameter("user_id"));
          ps2.setString(28, uuid);
          ps2.executeUpdate();
          connection.close();


      } catch (Exception ex) {
  %><%="Error Posting " + ex%><%
          System.out.println("" + ex);
      }
  %>

  <%}%>


<%

    String truck_count = "0";
    boolean needStatusUpdate = false;
    boolean isActive = false;
    boolean owner = false;
    boolean access_driver_pay = false;
    boolean edit_driver_pay = false;
    boolean print_pending_loads = false;
    boolean create_pending_loads = false;
    boolean save_user_search = false;
    boolean accounting_contact = false;
    boolean primary_contact = false;

%>


        <!-- logout function  -->
        <script>
        function logoutuser(userID) {
        var xmlhttp;
        if (window.XMLHttpRequest)
        {// code for IE7+, Firefox, Chrome, Opera, Safari
        xmlhttp=new XMLHttpRequest();
        }
        else
        {// code for IE6, IE5
        xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
        }
        var userID2 = userID;
        var gov ="true"
        xmlhttp.open("get", "logout.jsp?id=" + userID2 +"&GO=" + gov ,true);
        xmlhttp.send();

        }
        </script>
        <body>




        <!-- Fixed navbar -->
        <%@include file="nav_menu.jsp"%>
        <br><br><br>
<!-- Main page: -->

            <%
						 try{


                            HashMap user_state_map = new HashMap();
                            String team_name = "0";
                            String team_id = "0";
                             int totalCountUsers = 0;
                             int totalCountTeams = 0;

                             Class.forName("com.mysql.jdbc.Driver");
							String url = "jdbc:mysql://localhost/test?zeroDateTimeBehavior=convertToNull";
							Connection connection = DriverManager.getConnection(url,"<USERNAME>", "<PASSWORD>");

                             PreparedStatement psMain = connection.prepareStatement("select user_state, user_id, team_id from test.TRUCKING_USER_teams_User_state WHERE COMPANY_ID = ? AND user_id = ?");
                             psMain.setString(1, uuid);
                             psMain.setString(2, request.getParameter("user_id"));
                             ResultSet resultSet1 = psMain.executeQuery();
                             while (resultSet1.next()) {
                                 user_state_map.put(resultSet1.getString("user_state") + resultSet1.getString("user_id"), resultSet1.getString("user_state") + resultSet1.getString("user_id"));
                                 team_id = resultSet1.getString("team_id");
                             }

                             psMain = connection.prepareStatement("select name from test.TRUCKING_USER_teams WHERE COMPANY_ID = ? AND team_id = ?");
                             psMain.setString(1, uuid);
                             psMain.setString(2, team_id);
                             ResultSet resultSet3 = psMain.executeQuery();
                             while (resultSet3.next()) {
                                 team_name = resultSet3.getString("name");
                             }

                             psMain = connection.prepareStatement("select count(EMAIL) as itemCount from test.TRUCKING_USERS WHERE COMPANY_ID = ?");
                             psMain.setString(1, uuid);
                             ResultSet resultSet = psMain.executeQuery();
                             while (resultSet.next()) {
                                 totalCountUsers = resultSet.getInt("itemCount");
                             }

                             psMain = connection.prepareStatement("select count(team_id) as itemCount from test.TRUCKING_USER_teams where company_id = ?");
                             psMain.setString(1, uuid);
                             resultSet = psMain.executeQuery();
                             while (resultSet.next()) {
                                 totalCountTeams = resultSet.getInt("itemCount");
                             }


                            PreparedStatement ps2 = connection.prepareStatement("select * from test.TRUCKING_USERS where email = ? and company_id = ?");
							ps2.setString(1, request.getParameter("user_id"));
							ps2.setString(2, uuid);
                            ResultSet resultSet2 = ps2.executeQuery();
							while (resultSet2.next()) {


                                isActive = resultSet2.getBoolean("is_online");
                                owner = resultSet2.getBoolean("is_owner");
                                access_driver_pay = resultSet2.getBoolean("access_driver_pay");
                                edit_driver_pay = resultSet2.getBoolean("edit_driver_pay");
                                print_pending_loads = resultSet2.getBoolean("print_pending_loads");
                                create_pending_loads = resultSet2.getBoolean("create_pending_loads");
                                save_user_search = resultSet2.getBoolean("save_user_search");
                                accounting_contact = resultSet2.getBoolean("accounting_contact");
                                primary_contact = resultSet2.getBoolean("primary_contact");








            %>

        <div class="container">


            <div class="row">


                <div class="col-md-12">
                    <div class="row">

                        <a href="manage_teams.jsp">
                        <div class="col-lg-6 col-sx-12">
                            <div class="panel panel-primary">
                                <div class="panel-heading" style="background-color:green">
                                    <div class="row">
                                        <div class="col-xs-3">
                                            <i class="fa fa-user fa-3x"></i>
                                        </div>
                                        <div class="col-xs-9 text-right">
                                            <div class="huge"><span id="divCountUsers" ><%=totalCountUsers%></span></div>
                                            <div>Total Users</div>
                                        </div>
                                    </div>
                                </div>

                            </div>
                        </div>
                        </a>

                        <a href="manage_teams.jsp">
                            <div class="col-lg-6 col-sx-12">
                                <div class="panel panel-primary">
                                    <div class="panel-heading" style="background-color:saddlebrown">
                                        <div class="row">
                                            <div class="col-xs-3">
                                                <i class="fa fa-group fa-3x"></i>
                                            </div>
                                            <div class="col-xs-9 text-right">
                                                <div class="huge"><span id="divCountTeams" ><%=totalCountTeams%></span></div>
                                                <div>Teams</div>
                                            </div>
                                        </div>
                                    </div>

                                </div>
                            </div>
                        </a>


                    </div>
                </div>

            </div>


            <div class="row">


    <form  name="searchForm" id="searchForm" action="user_profile_edit.jsp" method="post">
        <input type="hidden" name="cmd" value="saveprofileinfo">
        <input type="hidden" name="user_id"  value="<%=request.getParameter("user_id")%>">




        <div class="portlet box blue">
            <div class="portlet-title">
                <div class="caption">
                    <i class="fa fa-user" style="margin-top: 2px;"></i><%=NullCheck.check(resultSet2.getString("f_name"))%> <%=NullCheck.check(resultSet2.getString("l_name"))%>
                </div>


                <div class="tools">
                    <button class="btn btn-primary btn-xs"  role="button"  name="btn_save" id="btn_shipper_save" ><span class="glyphicon glyphicon-download" aria-hidden="true"></span>&nbsp;W-2</button>
                    <button class="btn btn-success btn-xs"  role="button"  name="btn_save" id="btn_shipper_save" type="submit" ><span class="glyphicon glyphicon-save" aria-hidden="true"></span>&nbsp;SAVE</button>

                </div>


            </div>


        <div class="panel-body">
              <div class="form-wrapper">

                        <div class="row">
                            <div class="col-md-2">
                                <div class="form-group">
                                    <label>First Name </label>
                                    <input type="text" class="form-control" name="f_name"
                                           id="f_name"  value="<%=NullCheck.check(resultSet2.getString("f_name"))%>"/>
                                </div>
                            </div>

                            <div class="col-md-2">
                                <div class="form-group">
                                    <label>Last Name</label>
                                    <input type="text" class="form-control" name="l_name" id="l_name"

                                           value="<%=NullCheck.check(resultSet2.getString("l_name"))%>"
                                    >
                                </div>
                            </div>

                            <div class="col-md-4">
                                <div class="form-group">
                                    <fieldset disabled>
                                        <label>e-mail / username</label>
                                    <input type="text" class="form-control" name="user_id"
                                           id="user_id"
                                           value="<%=NullCheck.check(resultSet2.getString("email"))%>"
                                    />
                                        </fieldset>
                                </div>
                            </div>


                                <div class="col-md-2">
                                    <div class="form-group">
                                        <label>Driver License No.</label>

                                        <input type="text" class="form-control dis" name="dl"
                                               id="dl" value="<%=NullCheck.check(resultSet2.getString("dl"))%>"
                                        />

                                    </div>
                                </div>

                                <div class="col-md-2">
                                    <div class="form-group">
                                        <label>Social Security</label>
                                        <input type="text" class="form-control disabled" name="ss"
                                               id="ss" value="<%=NullCheck.check(resultSet2.getString("ss"))%>"
                                        />

                                    </div>
                                </div>






                        </div>

                        <div class="row">



                            <div class="col-md-2">
                                <div class="form-group">
                                    <label>Cell Phone</label>
                                    <input type="text" class="form-control" name="phone"
                                           id="phone"
                                           value="<%=NullCheck.check(resultSet2.getString("phone"))%>" />
                                </div>
                            </div>

                            <div class="col-md-2">
                                <div class="form-group">
                                    <label>Fax</label>
                                    <input type="text" class="form-control"
                                           name="fax" id="fax"
                                           value="<%=NullCheck.check(resultSet2.getString("fax"))%>"
                                    />
                                </div>
                            </div>

                            <div class="col-md-2">
                                <div class="form-group">
                                    <label>Address</label>
                                    <input type="text" class="form-control"
                                           name="address1" id="address1"
                                           value="<%=NullCheck.check(resultSet2.getString("address1"))%>"
                                    />
                                </div>
                            </div>

                            <div class="col-md-2">
                                <div class="form-group">
                                    <label>City</label>
                                    <input type="text" class="form-control" name="city" id="city"

                                           value="<%=NullCheck.check(resultSet2.getString("city"))%>"
                                    />
                                </div>
                            </div>


                            <div class="col-md-1">
                                <div class="form-group">
                                    <label>Zip Code</label>
                                    <input type="text" class="form-control" name="zip"
                                           id="zip"
                                           value="<%=NullCheck.check(resultSet2.getString("zip"))%>"
                                    />
                                </div>
                            </div>

                            <div class="col-md-1">
                                <div class="form-group">
                                    <label>State</label>
                                    <input type="text" class="form-control" name="state" id="state"

                                           value="<%=NullCheck.check(resultSet2.getString("state"))%>"
                                    />
                                </div>
                            </div>

                            <div class="col-md-2">
                                <div class="form-group">
                                    <label>Country</label>
                                    <input type="text" class="form-control" name="country" id="country"
                                    value="<%=NullCheck.check(resultSet2.getString("country"))%>"
                                    >
                                </div>
                            </div>


                        </div>
                        <div class="row">

                            <div class="col-md-4">
                                <div class="form-group">
                                    <label>secondary e-mail</label>
                                    <input type="text" class="form-control" name="email2"
                                           id="email2"
                                           value="<%=NullCheck.check(resultSet2.getString("email2"))%>"
                                           />
                                </div>
                            </div>


                        </div>


            </div><!-- end of form wrapper -->

            <div class="form-wrapper">

                <div class="row">

                    <div class="col-md-4">
                        <div class="form-group">
                            <label>Team</label>
                            <input type="text" class="form-control" name="team"
                                   id="team"
                                   value="<%=team_name%>"
                            />
                        </div>
                    </div>


               </div>


                <div class="row">


                    <div class="col-md-2">
                        <div class="form-group">
                            <fieldset disabled>
                                <label>Manager</label>

                                <input type="checkbox" name="manager_ck" id="manager_ck"
                                       value="Yes"
                                       <%if(user_state_map.containsKey("Manager" + resultSet2.getString("email"))){%>checked<%}%>
                                />

                            </fieldset>

                            <input type="text" class="form-control" name="manager_commission"
                                   id="manager_commission"
                                   value="<%=NullCheck.check(resultSet2.getString("gross_rate_manager"))%>">
                        </div>
                    </div>

                    <div class="col-md-2">
                        <div class="form-group">
                            <fieldset disabled>
                                <label>Sales</label>

                                <input type="checkbox" name="sales_ck" id="sales_ck"
                                       value="Sales"
                                       <%if(user_state_map.containsKey("Sales" + resultSet2.getString("email"))){%>checked<%}%>
                                />
                            </fieldset>
                            <input type="text" class="form-control" name="sales_commission"
                                   id="sales_commission"
                                   value="<%=NullCheck.check(resultSet2.getString("gross_rate_sales"))%>">
                        </div>
                    </div>


                    <div class="col-md-2">
                        <div class="form-group">
                            <fieldset disabled>
                                <label>Dispatcher</label>

                            <input type="checkbox" name="dispatch_commission_ck" id="dispatch_commission_ck"
                                   value="Yes"
                                   <%if(user_state_map.containsKey("Dispatcher" + resultSet2.getString("email"))){%>checked<%}%>
                            />
                            </fieldset>
                            <input type="text" class="form-control" name="dispatch_commission"
                                   id="dispatch_commission"
                                   value="<%=NullCheck.check(resultSet2.getString("gross_rate_dispatcher"))%>" >
                        </div>
                    </div>


                    <div class="col-md-2">
                        <div class="form-group">
                            <label>Pay Type</label>
                            <input type="text" class="form-control" name="pay_type"
                                   id="gross" placeholder="Percent Gross"
                                   value="<%=NullCheck.check(resultSet2.getString("pay_type"))%>" />
                        </div>
                    </div>

                    <div class="col-md-2">
                        <div class="form-group">
                            <label>Gross %</label>
                            <input type="text" class="form-control" name="gross_rate"
                                   id="gross_rate"
                                   value="<%=NullCheck.check(resultSet2.getString("gross_rate"))%>">
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
                                           value="Yes"
                                           <%if(owner){%>checked<%}%>>
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
                                    <input type="checkbox" name="primary_contact" id="primary_contact" value="Yes"
                                           <%if(primary_contact){%>checked<%}%>
                                    >
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
                                           value="Yes"
                                           <%if(accounting_contact){%>checked<%}%>
                                    >
                                    Accounting contact
                                </label>
                            </div>

                        </div>
                    </div>


                    <div class="col-md-2">
                        <div class="form-group">
                            <label>Account Status</label><br/>

                            <label class="radio-inline" style="color:#777; padding-left: 20px;margin-top: 10px;">
                                <input type="radio" name="isActive" id="isActive" value="Active"
                                       <%if(isActive){%>checked<%}%>
                                > Active
                            </label>
                            <label class="radio-inline" style="color:#777; padding-left: 20px;margin-top: 10px;">
                                <input type="radio" name="isActive" id="isActive" value="Inactive"
                                       <%if(!isActive){%>checked<%}%>
                                > Inactive
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
                                           value="Yes"
                                           <%if(access_driver_pay){%>checked<%}%>>
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
                                    <input type="checkbox" name="create_pending_loads" id="create_pending_loads" value="Yes"
                                           <%if(create_pending_loads){%>checked<%}%>
                                    >
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
                                           value="Yes"
                                           <%if(print_pending_loads){%>checked<%}%>>
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
                                           value="Yes"
                                           <%if(save_user_search){%>checked<%}%>>
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
                                           value="Yes"
                                           <%if(edit_driver_pay){%>checked<%}%>>
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
                <%
                    	}

          				connection.close();

						 }catch (Exception ex){
						     %><%="Error Posting " + ex%><%
						     System.out.println(""+ ex);
						 }

						%>

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