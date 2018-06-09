<%if (session.getAttribute("issubscribed") != null && session.getAttribute("issubscribed").equals("true")) {%>
<!-- Fixed navbar -->
<nav class="navbar navbar-default navbar-fixed-top">
    <div class="container">
        <div class="navbar-header">

            <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar"
                    aria-expanded="false" aria-controls="navbar">
                <span class="sr-only">Toggle navigation</span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
        </div>
        <div id="navbar" class="navbar-collapse collapse">
            <ul class="nav navbar-nav">


                <li class="dropdown">
                    <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">File<span
                            class="caret"></span></a>

                    <ul class="dropdown-menu" role="menu">
                        <li>
                            <a href="new_features.jsp">Home</a>
                        </li>
                        <li>
                            <a href="dispatch_customers.jsp?isActive=true&searchKey=&ShowSearchCustomers=true">Customers</a>
                        </li>
                        <li>
                            <a href="dispatch_carriers.jsp?isActive=true&searchKey=&ShowSearchCarriers=true">Carriers</a>
                        </li>
                        <li>
                            <a href="dispatch_shippers.jsp?isActive=true&searchKey=&ShowSearchShippers=true">Consignors</a>
                        </li>
                        <li><a href="dispatch_consignees.jsp?isActive=true&searchKey=&ShowSearchConsignees=true">Consignees</a>
                        </li>
                        <li><a href="dispatch_customsbrokers.jsp?isActive=true&searchKey=&ShowSearchCustoms=true">Customs
                            Brokers</a></li>
                            <!--
                        <li class="disabled"><a href="#">Teams</a></li>
                        <li class="disabled"><a href="#">Users</a></li>
                        <li class="disabled"><a href="#">Drivers</a></li>
                        <li class="disabled"><a href="#">Trucks</a></li>
                        <li class="disabled"><a href="#">Trailers</a></li>
                        <li class="disabled"><a href="#">Settings</a></li>
                        <li class="disabled"><a href="#">Companies</a></li>
				-->
                    </ul>
                </li>
                <li class="dropdown">
                    <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">Accounting<span
                            class="caret"></span></a>

                    <ul class="dropdown-menu" role="menu">
                    <!--
                        <li>
                            <a href="dispatch_board_fuel_fact.jsp?isActive=true&searchKey=&ShowSearchFuelFact=true&batch_type=Fuel">Fuel
                                Expenses</a></li>
                        <li>
                            <a href="dispatch_board_fuel_fact.jsp?isActive=true&searchKey=&ShowSearchFuelFact=true&batch_type=Factoring">Factoring
                                Expenses</a></li>
                                -->
                        <li ><a href="dispatch_board_accounting_customer.jsp?ShowSearchAccountingCustomer=true">Customer Payments</a></li>
                        <li ><a href="dispatch_board_accounting_carrier.jsp?ShowSearchAccountingCarrier=true">Carrier Payments</a></li>
                        <!--
                        <li class="disabled"><a href="#">Driver Payments</a></li>
                        -->
                        <li ><a href="dispatch_board_accounting_contractor.jsp?ShowSearchAccountingContractor=true">Manager Payments</a></li>
                        <li ><a href="dispatch_board_accounting_sales.jsp?ShowSearchAccountingSales=true">Sales Payments</a></li>
                        <li ><a href="dispatch_board_accounting_agent.jsp?ShowSearchAccountingAgent=true" >Agent Payments</a></li>
                        <li ><a href="dispatch_board_accounting_bonuses_manager.jsp?ShowSearchAccountingBonusesManager=true">Manager Bonuses</a></li>
                        <li ><a href="dispatch_board_accounting_bonuses_sales.jsp?ShowSearchAccountingBonusesSales=true">Sales Bonuses</a></li>
                        <li ><a href="dispatch_board_accounting_bonuses_agent.jsp?ShowSearchAccountingBonusesAgent=true">Agent Bonuses</a></li>
                        <li ><a href="dispatch_board_accounting_penalties.jsp?ShowSearchAccountingPenalties=true">Penalties</a></li>
                        <li ><a href="dispatch_board_accounting.jsp?ShowSearchAccounting=true" >Accounting Manager</a>
                        </li>
                    </ul>
                </li>
                <li class="dropdown">
                    <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">Truck
                        Board <span class="caret"></span></a>

                    <ul class="dropdown-menu" role="menu">
                        <li><a href="truckboard_current.jsp?driverBank=true">Shared Truck Board</a></li>
                        <li><a href="standard-truckboard.jsp">Private Truck Board</a></li>
                        <!--
			<li><a href="truckboard.jsp">My Truck Board Map</a></li>
                        <li><a href="standard-truckboard.shippers.jsp">my Truck Board Shippers</a></li>
			-->
                    </ul>
                </li>


                <li class="dropdown">

                    <%if (session.getAttribute("msg_count") != null && !session.getAttribute("msg_count").equals("")) {%>

                    <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">Messages
                        <span class="badge"
                              style="background:orangered;"><%=session.getAttribute("msg_count")%></span><span
                                class="caret"></span></a>

                    <%} else {%>

                    <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">Messages
                        <span class="caret"></span></a>
                    <%}%>

                    <ul class="dropdown-menu" role="menu">
                        <%if (session.getAttribute("isAdmin").equals("true")) {%>
                        <li><a href="add_message.jsp">Send Message</a></li>
                        <%}%>
                        <li><a href="message_center.jsp">Message Center</a></li>

                    </ul>
                </li>

                <li class="dropdown">
                    <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">Dispatch<span
                            class="caret"></span></a>

                    <ul class="dropdown-menu" role="menu">

                        <li><a href="dispatch_board.jsp?ShowSearch=true">Dispatch Board</a></li>
                        <li><a href="truckboard_current_gps_to_load.jsp">Progress Report by GPS</a></li>
                        <li><a href="truckboard_current_gps_to_load.man.jsp">Progress Report by Logs</a></li>
                        <!--<li class="disabled"><a href="#">IFTA</a></li>
                        <li class="disabled"><a href="#">Dashboard</a></li>
                        <li class="disabled"><a href="#">Reports</a></li>
                        <li class="disabled"><a href="#">Financing</a></li>
                        -->

                    </ul>
                </li>


                <li class="dropdown ">
                    <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">Add
                        <span class="caret"></span></a>

                    <ul class="dropdown-menu" role="menu">
                        <li><a href="new_load.jsp">New Load</a></li>
                        <!--
                        <li><a href="new_load.jsp?cmd=newLoad&statusLD=Pending">New Pending Load</a></li>
                        <li><a href="new_load.jsp?cmd=newLoad&statusLD=Dispatched">New Dispatched Load</a></li>
                        -->
                        <li role="separator" class="divider"></li>
                        <li><a href="dispatch_edit_carrier.jsp">Add Carrier</a></li>
                        <li><a href="dispatch_edit_customers.jsp">Add Customer</a></li>
                        <li><a href="dispatch_edit_shipper.jsp">Add Consignor</a></li>
                        <li><a href="dispatch_edit_consignee.jsp">Add Consignee</a></li>
                        <li><a href="dispatch_edit_customsbrokers.jsp">Add Customs Broker</a></li>

                    </ul>
                </li>

            </ul>

            <ul class="nav navbar-nav navbar-right">

                <li class="dropdown">
                    <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">Hello
                        <b><%=NullCheck.check((String) session.getAttribute("f_name"))%>
                        </b> <span class="glyphicon glyphicon-option-vertical"></span></a>
                    <ul class="dropdown-menu" role="menu">

			<%if (session.getAttribute("issubscribed") != null && session.getAttribute("issubscribed").equals("true")) {%>
				<li><a href="subscription_manager.jsp">My Billing</a></li>
			<%}%>                    
                        <li><a href="company_profile_view.jsp">My Account</a></li>
                        <%if (session.getAttribute("isAdmin").equals("true")) {%>
                        <li><a href="manage_users.jsp">My Users</a></li>
                        <li><a href="manage_teams.jsp">My Teams</a></li>
                        <li><a href="manage_referrals.jsp">My Referrals</a></li>
                        <li role="separator" class="divider"></li>
                        <li><a href="add_user.jsp">Add User</a></li>
                        <li><a href="add_truck.jsp">Add Truck</a></li>
                        <%}%>
                        <!--<li role="separator" class="divider"></li>
                        <li class="disabled"><a href="#">Training</a></li>
                        <li class="disabled"><a href="#">Help</a></li>-->
                        <li role="separator" class="divider"></li>
                        <li><a href="javascript:void(0)" onclick="logoutuser('<%=session.getAttribute("uuid")%>')"
                               data-toggle="modal" data-target="#logoutconfirm">Log Out</a></li>


                    </ul>
                </li>
             </ul>
        </div><!--/.nav-collapse -->

        <%if (request.getParameter("ShowSearchCustomers") != null) {%>

        <HR style="margin-bottom: 5px;margin-top: 5px;">
        <!-- main select row -->
        <div class="row">
            <div class="col-sm-12" align="center">

                <form class="form-inline" name="searchForm" id="searchForm"
                      action="dispatch_customers.jsp?ShowSearchCustomers=true" method="post">

                    <a href="dispatch_edit_customers.jsp">Add Customer</a>
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;

                    <label class="radio-inline" style="color:#777; padding: 7px;">
                        <input type="radio" name="isActive" id="isActive" value="true"
                               <%if(request.getParameter("isActive")!=null && request.getParameter("isActive").equals("true")){%>checked<%}%> >
                        Active
                    </label>
                    <label class="radio-inline" style="color:#777; padding: 7px;">
                        <input type="radio" name="isActive" id="isActive" value="false"
                               <%if(request.getParameter("isActive")!=null && request.getParameter("isActive").equals("false")){%>checked<%}%> >
                        Inactive
                    </label>


                    <div class="form-group form-group-sm">
                        <label class="sr-only">SelectForm</label>
                        <div class="input-group input-group-sm">
                            <div class="input-group-addon">Find:</div>

                            <input type="text" class="form-control" id="searchKey" name="searchKey"
                                   placeholder="Search key"
                                   value="<%=NullCheck.check(request.getParameter("searchKey"))%>"/>
                            <!--
                                <div class="input-group-addon">Search For:</div>
                                        <select class="form-control" name="searchType" >
                                        <option value="all">All</option>
                                        <option value="customers">Customers</option>
                                        <option value="brokers">Brokers</option>
                                        </select>


                                </div>
                                -->
                        </div>


                        <button class="btn btn-default btn-sm" type="submit">Go</button>

                </form>
                <!-- end search form -->
            </div>
        </div>
        <%}%>
        <%if (request.getParameter("ShowSearchFuelFact") != null) {%>
        <!-- main select row -->
        <div class="row">
            <div class="col-sm-12" align="center">

                <form onsubmit="return submitForProcessingNull()" class="form-inline" name="searchForm" id="searchForm"
                      action="#" method="post">
                    <div class="input-group input-group-sm">
                        <div class="input-group-addon">Total</div>
                        <input type="text" class="form-control" id="batch_total" name="batch_total" readonly value=""/>

                    </div>


                    <button class="btn btn-default btn-sm" type="submit" onclick="submitForProcessing()">Process Batch
                    </button>

                </form>
                <!-- end search form -->
            </div>
        </div>
        <%}%>
        <%if (request.getParameter("ShowSearchConsignees") != null) {%>
        <!-- main select row -->
        <div class="row">
            <div class="col-sm-12" align="center">

                <form class="form-inline" name="searchForm" id="searchForm"
                      action="dispatch_consignees.jsp?ShowSearchConsignees=true" method="post">

                    <a href="dispatch_edit_consignee.jsp">Add Consignee</a>
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;

                    <label class="radio-inline" style="color:#777; padding: 7px;">
                        <input type="radio" name="isActive" id="isActive" value="true"
                               <%if(request.getParameter("isActive")!=null && request.getParameter("isActive").equals("true")){%>checked<%}%> >
                        Active
                    </label>
                    <label class="radio-inline" style="color:#777; padding: 7px;">
                        <input type="radio" name="isActive" id="isActive" value="false"
                               <%if(request.getParameter("isActive")!=null && request.getParameter("isActive").equals("false")){%>checked<%}%> >
                        Inactive
                    </label>


                    <div class="form-group form-group-sm">
                        <label class="sr-only">SelectForm</label>
                        <div class="input-group input-group-sm">
                            <div class="input-group-addon">Find:</div>

                            <input type="text" class="form-control" id="searchKey" name="searchKey"
                                   placeholder="Search key"
                                   value="<%=NullCheck.check(request.getParameter("searchKey"))%>"/>

                        </div>


                        <button class="btn btn-default btn-sm" type="submit">Go</button>

                </form>
                <!-- end search form -->
            </div>
        </div>
        <%}%>
        <%if (request.getParameter("ShowSearchShippers") != null) {%>

        <!-- main select row -->
        <div class="row">
            <div class="col-sm-12" align="center">

                <form class="form-inline" name="searchForm" id="searchForm"
                      action="dispatch_shippers.jsp?ShowSearchShippers=true" method="post">

                    <a href="dispatch_edit_shipper.jsp">Add Consignor</a>
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;

                    <label class="radio-inline" style="color:#777; padding: 7px;">
                        <input type="radio" name="isActive" id="isActive" value="true"
                               <%if(request.getParameter("isActive")!=null && request.getParameter("isActive").equals("true")){%>checked<%}%> >
                        Active
                    </label>
                    <label class="radio-inline" style="color:#777; padding: 7px;">
                        <input type="radio" name="isActive" id="isActive" value="false"
                               <%if(request.getParameter("isActive")!=null && request.getParameter("isActive").equals("false")){%>checked<%}%> >
                        Inactive
                    </label>


                    <div class="form-group form-group-sm">
                        <label class="sr-only">SelectForm</label>
                        <div class="input-group input-group-sm">
                            <div class="input-group-addon">Find:</div>

                            <input type="text" class="form-control" id="searchKey" name="searchKey"
                                   placeholder="Search key"
                                   value="<%=NullCheck.check(request.getParameter("searchKey"))%>"/>

                        </div>


                        <button class="btn btn-default btn-sm" type="submit">Go</button>
                    </div>
                </form>
                <!-- end search form -->
            </div>
        </div>
        <%}%>
        <%if (request.getParameter("ShowSearchCustoms") != null) {%>

        <!-- main select row -->
        <div class="row">
            <div class="col-sm-12" align="center">

                <form class="form-inline" name="searchForm" id="searchForm"
                      action="dispatch_customsbrokers.jsp?ShowSearchCustoms=true" method="post">

                    <a href="dispatch_edit_customsbrokers.jsp">Add Customs Broker</a>
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;

                    <label class="radio-inline" style="color:#777; padding: 7px;">
                        <input type="radio" name="isActive" id="isActive" value="true"
                               <%if(request.getParameter("isActive")!=null && request.getParameter("isActive").equals("true")){%>checked<%}%> >
                        Active
                    </label>
                    <label class="radio-inline" style="color:#777; padding: 7px;">
                        <input type="radio" name="isActive" id="isActive" value="false"
                               <%if(request.getParameter("isActive")!=null && request.getParameter("isActive").equals("false")){%>checked<%}%> >
                        Inactive
                    </label>


                    <div class="form-group form-group-sm">
                        <label class="sr-only">SelectForm</label>
                        <div class="input-group input-group-sm">
                            <div class="input-group-addon">Find:</div>

                            <input type="text" class="form-control" id="searchKey" name="searchKey"
                                   placeholder="Search key"
                                   value="<%=NullCheck.check(request.getParameter("searchKey"))%>"/>

                        </div>


                        <button class="btn btn-default btn-sm" type="submit">Go</button>
                    </div>
                </form>
                <!-- end search form -->
            </div>
        </div>
        <%}%>
        <%if (request.getParameter("ShowSearchCarriers") != null) {%>

        <!-- main select row -->
        <div class="row">
            <div class="col-sm-12" align="center">

                <form class="form-inline" name="searchForm" id="searchForm"
                      action="dispatch_carriers.jsp?ShowSearchCarriers=true" method="post">

                    <a href="dispatch_edit_carrier.jsp">Add Carrier</a>
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    <label class="radio-inline" style="color:#777; padding: 7px;">
                        <input type="radio" name="isActive" id="isActive" value="true"
                               <%if(request.getParameter("isActive")!=null && request.getParameter("isActive").equals("true")){%>checked<%}%> >
                        Active
                    </label>
                    <label class="radio-inline" style="color:#777; padding: 7px;">
                        <input type="radio" name="isActive" id="isActive" value="false"
                               <%if(request.getParameter("isActive")!=null && request.getParameter("isActive").equals("false")){%>checked<%}%> >
                        Inactive
                    </label>


                    <div class="form-group form-group-sm">
                        <label class="sr-only">SelectForm</label>
                        <div class="input-group input-group-sm">
                            <div class="input-group-addon">Find:</div>

                            <input type="text" class="form-control" id="searchKey" name="searchKey"
                                   placeholder="Search key"
                                   value="<%=NullCheck.check(request.getParameter("searchKey"))%>"/>

                        </div>


                        <button class="btn btn-default btn-sm" type="submit">Go</button>
                    </div>
                </form>
                <!-- end search form -->
            </div>
        </div>
        <%}%>
        <%if (request.getParameter("ShowSearchAccountingCustomer") != null) {%>
        <form class="form-inline" name="searchForm" id="searchForm"
              action="dispatch_board_accounting_customer.jsp?ShowSearchAccountingCustomer=true" style="margin-bottom: 5px;"
              method="post">
            <div class="row">
                <div class="col-sm-12" align="center">
                    <div class="input-group input-group-sm">
                        <div class="input-group-addon">Key:</div>
                        <input type="text" class="form-control" id="searchKey" name="searchKey" placeholder="Search key"
                               value="<%=NullCheck.check(request.getParameter("searchKey"))%>"/>
                    </div>

                    <div class="input-group input-group-sm">

                        <select class="form-control" name="searchType">
                            <option value="all"
                                    <%if(request.getParameter("searchType")!=null && request.getParameter("searchType").equals("all")){%>selected<%}%> >
                                Search All
                            </option>
                            <option value="LoadStatus"
                                    <%if(request.getParameter("searchType")!=null && request.getParameter("searchType").equals("LoadStatus")){%>selected<%}%> >
                                Load Status
                            </option>
                            <option value="load_number"
                                    <%if(request.getParameter("searchType")!=null && request.getParameter("searchType").equals("load_number")){%>selected<%}%> >
                                Load Number
                            </option>
                            <option value="wo_number"
                                    <%if(request.getParameter("searchType")!=null && request.getParameter("searchType").equals("wo_number")){%>selected<%}%> >
                                W/O
                            </option>
                            <option value="customer"
                                    <%if(request.getParameter("searchType")!=null && request.getParameter("searchType").equals("customer")){%>selected<%}%> >
                                Customer
                            </option>
                        </select>


                    </div>
                    <button class="btn btn-default btn-sm" type="submit">Search</button>
                </div>
            </div>
        </form>
        <%}%>
        <%if (request.getParameter("ShowSearchAccountingCarrier") != null) {%>
        <form class="form-inline" name="searchForm" id="searchForm"
              action="dispatch_board_accounting_carrier.jsp?ShowSearchAccountingCarrier=true" style="margin-bottom: 5px;"
              method="post">
            <div class="row">
                <div class="col-sm-12" align="center">
                    <div class="input-group input-group-sm">
                        <div class="input-group-addon">Key:</div>
                        <input type="text" class="form-control" id="searchKey" name="searchKey" placeholder="Search key"
                               value="<%=NullCheck.check(request.getParameter("searchKey"))%>"/>
                    </div>

                    <div class="input-group input-group-sm">

                        <select class="form-control" name="searchType">
                            <option value="all"
                                    <%if(request.getParameter("searchType")!=null && request.getParameter("searchType").equals("all")){%>selected<%}%> >
                                Search All
                            </option>
                            <option value="LoadStatus"
                                    <%if(request.getParameter("searchType")!=null && request.getParameter("searchType").equals("LoadStatus")){%>selected<%}%> >
                                Load Status
                            </option>
                            <option value="load_number"
                                    <%if(request.getParameter("searchType")!=null && request.getParameter("searchType").equals("load_number")){%>selected<%}%> >
                                Load Number
                            </option>
                            <option value="wo_number"
                                    <%if(request.getParameter("searchType")!=null && request.getParameter("searchType").equals("wo_number")){%>selected<%}%> >
                                W/O
                            </option>
                            <option value="customer"
                                    <%if(request.getParameter("searchType")!=null && request.getParameter("searchType").equals("customer")){%>selected<%}%> >
                                Customer
                            </option>
                            <option value="mc_number"
                                    <%if(request.getParameter("searchType")!=null && request.getParameter("searchType").equals("mc_number")){%>selected<%}%> >
                                MC Number
                            </option>
                        </select>


                    </div>
                    <button class="btn btn-default btn-sm" type="submit">Search</button>
                </div>
            </div>
        </form>
        <%}%>  
  
        <%if (request.getParameter("ShowSearchAccountingAgent") != null) {%>
        <form onsubmit="return submitForProcessingNull()" class="form-inline" name="searchForm" id="searchForm"
              action="dispatch_board_accounting_agent.jsp?ShowSearchAccountingAgent=true" style="margin-bottom: 5px;"
              method="post">
            <div class="row">
                <div class="col-sm-12" align="center">
                    <div class="input-group input-group-sm">
                        <div class="input-group-addon">Key:</div>
                        <input type="text" class="form-control" id="searchKey" name="searchKey" placeholder="Search key"
                               value="<%=NullCheck.check(request.getParameter("searchKey"))%>"/>
                    </div>

                    <div class="input-group input-group-sm">

                        <select class="form-control" name="searchType">
                            <option value="all"
                                    <%if(request.getParameter("searchType")!=null && request.getParameter("searchType").equals("all")){%>selected<%}%> >
                                Search All
                            </option>
                            <option value="LoadStatus"
                                    <%if(request.getParameter("searchType")!=null && request.getParameter("searchType").equals("LoadStatus")){%>selected<%}%> >
                                Load Status
                            </option>
                            <option value="load_number"
                                    <%if(request.getParameter("searchType")!=null && request.getParameter("searchType").equals("load_number")){%>selected<%}%> >
                                Load Number
                            </option>
                            <option value="wo_number"
                                    <%if(request.getParameter("searchType")!=null && request.getParameter("searchType").equals("wo_number")){%>selected<%}%> >
                                W/O
                            </option>
                        </select>


                    </div>
                    <button class="btn btn-default btn-sm" type="submit" onclick="submitSearch()">Search</button>
                    <div class="input-group input-group-sm">
                        <div class="input-group-addon">Total</div>
                        <input type="text" class="form-control" id="batch_total" name="batch_total" readonly value=""/>

                    </div>


                    <button class="btn btn-default btn-sm" type="submit" onclick="submitForProcessing()">Process Batch
                    </button>    
                </div>
            </div>
        </form>
        <%}%>     
        <%if (request.getParameter("ShowSearchAccountingSales") != null) {%>
        <form onsubmit="return submitForProcessingNull()" class="form-inline" name="searchForm" id="searchForm"
              action="dispatch_board_accounting_sales.jsp?ShowSearchAccountingSales=true" style="margin-bottom: 5px;"
              method="post">
            <div class="row">
                <div class="col-sm-12" align="center">
                    <div class="input-group input-group-sm">
                        <div class="input-group-addon">Key:</div>
                        <input type="text" class="form-control" id="searchKey" name="searchKey" placeholder="Search key"
                               value="<%=NullCheck.check(request.getParameter("searchKey"))%>"/>
                    </div>

                    <div class="input-group input-group-sm">

                        <select class="form-control" name="searchType">
                            <option value="all"
                                    <%if(request.getParameter("searchType")!=null && request.getParameter("searchType").equals("all")){%>selected<%}%> >
                                Search All
                            </option>
                            <option value="LoadStatus"
                                    <%if(request.getParameter("searchType")!=null && request.getParameter("searchType").equals("LoadStatus")){%>selected<%}%> >
                                Load Status
                            </option>
                            <option value="load_number"
                                    <%if(request.getParameter("searchType")!=null && request.getParameter("searchType").equals("load_number")){%>selected<%}%> >
                                Load Number
                            </option>
                            <option value="wo_number"
                                    <%if(request.getParameter("searchType")!=null && request.getParameter("searchType").equals("wo_number")){%>selected<%}%> >
                                W/O
                            </option>
                        </select>


                    </div>
                    <button class="btn btn-default btn-sm" type="submit" onclick="submitSearch()">Search</button>
                    <div class="input-group input-group-sm">
                        <div class="input-group-addon">Total</div>
                        <input type="text" class="form-control" id="batch_total" name="batch_total" readonly value=""/>

                    </div>


                    <button class="btn btn-default btn-sm" type="submit" onclick="submitForProcessing()">Process Batch
                    </button>                     
                </div>
            </div>
        </form>
        <%}%>   
        <%if (request.getParameter("ShowSearchAccountingContractor") != null) {%>
        <form onsubmit="return submitForProcessingNull()" class="form-inline" name="searchForm" id="searchForm"
              action="dispatch_board_accounting_contractor.jsp?ShowSearchAccountingContractor=true" style="margin-bottom: 5px;"
              method="post">
            <div class="row">
                <div class="col-sm-12" align="center">
                    <div class="input-group input-group-sm">
                        <div class="input-group-addon">Key:</div>
                        <input type="text" class="form-control" id="searchKey" name="searchKey" placeholder="Search key"
                               value="<%=NullCheck.check(request.getParameter("searchKey"))%>"/>
                    </div>

                    <div class="input-group input-group-sm">

                        <select class="form-control" name="searchType">
                            <option value="all"
                                    <%if(request.getParameter("searchType")!=null && request.getParameter("searchType").equals("all")){%>selected<%}%> >
                                Search All
                            </option>
                            <option value="LoadStatus"
                                    <%if(request.getParameter("searchType")!=null && request.getParameter("searchType").equals("LoadStatus")){%>selected<%}%> >
                                Load Status
                            </option>
                            <option value="load_number"
                                    <%if(request.getParameter("searchType")!=null && request.getParameter("searchType").equals("load_number")){%>selected<%}%> >
                                Load Number
                            </option>
                            <option value="wo_number"
                                    <%if(request.getParameter("searchType")!=null && request.getParameter("searchType").equals("wo_number")){%>selected<%}%> >
                                W/O
                            </option>
                        </select>


                    </div>
                    <button class="btn btn-default btn-sm" type="submit" onclick="submitSearch()">Search</button>
                    <div class="input-group input-group-sm">
                        <div class="input-group-addon">Total</div>
                        <input type="text" class="form-control" id="batch_total" name="batch_total" readonly value=""/>

                    </div>


                    <button class="btn btn-default btn-sm" type="submit" onclick="submitForProcessing()">Process Batch
                    </button>  
                </div>
            </div>
        </form>
        <%}%>   
        <%if (request.getParameter("ShowSearchAccountingBonusesManager") != null) {%>
        <form class="form-inline" name="searchForm" id="searchForm"
              action="dispatch_board_accounting_bonuses_manager.jsp?ShowSearchAccountingBonusesManager=true" style="margin-bottom: 5px;"
              method="post">
            <div class="row">
                <div class="col-sm-12" align="center">
                    <div class="input-group input-group-sm">
                        <div class="input-group-addon">Key:</div>
                        <input type="text" class="form-control" id="searchKey" name="searchKey" placeholder="Search key"
                               value="<%=NullCheck.check(request.getParameter("searchKey"))%>"/>
                    </div>

                    <div class="input-group input-group-sm">

                        <select class="form-control" name="searchType">
                            <option value="all"
                                    <%if(request.getParameter("searchType")!=null && request.getParameter("searchType").equals("all")){%>selected<%}%> >
                                Search All
                            </option>
                            <option value="LoadStatus"
                                    <%if(request.getParameter("searchType")!=null && request.getParameter("searchType").equals("LoadStatus")){%>selected<%}%> >
                                Load Status
                            </option>
                            <option value="load_number"
                                    <%if(request.getParameter("searchType")!=null && request.getParameter("searchType").equals("load_number")){%>selected<%}%> >
                                Load Number
                            </option>
                            <option value="wo_number"
                                    <%if(request.getParameter("searchType")!=null && request.getParameter("searchType").equals("wo_number")){%>selected<%}%> >
                                W/O
                            </option>
                        </select>


                    </div>
                    <button class="btn btn-default btn-sm" type="submit">Search</button>
                </div>
            </div>
        </form>
        <%}%>      
        <%if (request.getParameter("ShowSearchAccountingBonusesSales") != null) {%>
        <form class="form-inline" name="searchForm" id="searchForm"
              action="dispatch_board_accounting_bonuses_sales.jsp?ShowSearchAccountingBonusesSales=true" style="margin-bottom: 5px;"
              method="post">
            <div class="row">
                <div class="col-sm-12" align="center">
                    <div class="input-group input-group-sm">
                        <div class="input-group-addon">Key:</div>
                        <input type="text" class="form-control" id="searchKey" name="searchKey" placeholder="Search key"
                               value="<%=NullCheck.check(request.getParameter("searchKey"))%>"/>
                    </div>

                    <div class="input-group input-group-sm">

                        <select class="form-control" name="searchType">
                            <option value="all"
                                    <%if(request.getParameter("searchType")!=null && request.getParameter("searchType").equals("all")){%>selected<%}%> >
                                Search All
                            </option>
                            <option value="LoadStatus"
                                    <%if(request.getParameter("searchType")!=null && request.getParameter("searchType").equals("LoadStatus")){%>selected<%}%> >
                                Load Status
                            </option>
                            <option value="load_number"
                                    <%if(request.getParameter("searchType")!=null && request.getParameter("searchType").equals("load_number")){%>selected<%}%> >
                                Load Number
                            </option>
                            <option value="wo_number"
                                    <%if(request.getParameter("searchType")!=null && request.getParameter("searchType").equals("wo_number")){%>selected<%}%> >
                                W/O
                            </option>
                        </select>


                    </div>
                    <button class="btn btn-default btn-sm" type="submit">Search</button>
                </div>
            </div>
        </form>
        <%}%>    
        <%if (request.getParameter("ShowSearchAccountingBonusesAgent") != null) {%>
        <form class="form-inline" name="searchForm" id="searchForm"
              action="dispatch_board_accounting_bonuses_agent.jsp?ShowSearchAccountingBonusesAgent=true" style="margin-bottom: 5px;"
              method="post">
            <div class="row">
                <div class="col-sm-12" align="center">
                    <div class="input-group input-group-sm">
                        <div class="input-group-addon">Key:</div>
                        <input type="text" class="form-control" id="searchKey" name="searchKey" placeholder="Search key"
                               value="<%=NullCheck.check(request.getParameter("searchKey"))%>"/>
                    </div>

                    <div class="input-group input-group-sm">

                        <select class="form-control" name="searchType">
                            <option value="all"
                                    <%if(request.getParameter("searchType")!=null && request.getParameter("searchType").equals("all")){%>selected<%}%> >
                                Search All
                            </option>
                            <option value="LoadStatus"
                                    <%if(request.getParameter("searchType")!=null && request.getParameter("searchType").equals("LoadStatus")){%>selected<%}%> >
                                Load Status
                            </option>
                            <option value="load_number"
                                    <%if(request.getParameter("searchType")!=null && request.getParameter("searchType").equals("load_number")){%>selected<%}%> >
                                Load Number
                            </option>
                            <option value="wo_number"
                                    <%if(request.getParameter("searchType")!=null && request.getParameter("searchType").equals("wo_number")){%>selected<%}%> >
                                W/O
                            </option>
                        </select>


                    </div>
                    <button class="btn btn-default btn-sm" type="submit">Search</button>
                </div>
            </div>
        </form>
        <%}%>            
        <%if (request.getParameter("ShowSearchAccountingPenalties") != null) {%>
        <form class="form-inline" name="searchForm" id="searchForm"
              action="dispatch_board_accounting_penalties.jsp?ShowSearchAccountingPenalties=true" style="margin-bottom: 5px;"
              method="post">
            <div class="row">
                <div class="col-sm-12" align="center">
                    <div class="input-group input-group-sm">
                        <div class="input-group-addon">Key:</div>
                        <input type="text" class="form-control" id="searchKey" name="searchKey" placeholder="Search key"
                               value="<%=NullCheck.check(request.getParameter("searchKey"))%>"/>
                    </div>

                    <div class="input-group input-group-sm">

                        <select class="form-control" name="searchType">
                            <option value="all"
                                    <%if(request.getParameter("searchType")!=null && request.getParameter("searchType").equals("all")){%>selected<%}%> >
                                Search All
                            </option>
                            <option value="LoadStatus"
                                    <%if(request.getParameter("searchType")!=null && request.getParameter("searchType").equals("LoadStatus")){%>selected<%}%> >
                                Load Status
                            </option>
                            <option value="load_number"
                                    <%if(request.getParameter("searchType")!=null && request.getParameter("searchType").equals("load_number")){%>selected<%}%> >
                                Load Number
                            </option>
                            <option value="wo_number"
                                    <%if(request.getParameter("searchType")!=null && request.getParameter("searchType").equals("wo_number")){%>selected<%}%> >
                                W/O
                            </option>
                        </select>


                    </div>
                    <button class="btn btn-default btn-sm" type="submit">Search</button>
                </div>
            </div>
        </form>
        <%}%>             
        <%if (request.getParameter("ShowSearchAccounting") != null) {%>
        <form class="form-inline" name="searchForm" id="searchForm"
              action="dispatch_board_accounting.jsp?ShowSearchAccounting=true" style="margin-bottom: 5px;"
              method="post">
            <div class="row">
                <div class="col-sm-12" align="center">
                    <div class="input-group input-group-sm">
                        <div class="input-group-addon">Key:</div>
                        <input type="text" class="form-control" id="searchKey" name="searchKey" placeholder="Search key"
                               value="<%=NullCheck.check(request.getParameter("searchKey"))%>"/>
                    </div>

                    <div class="input-group input-group-sm">

                        <select class="form-control" name="searchType">
                            <option value="all"
                                    <%if(request.getParameter("searchType")!=null && request.getParameter("searchType").equals("all")){%>selected<%}%> >
                                Search All
                            </option>
                            <option value="LoadStatus"
                                    <%if(request.getParameter("searchType")!=null && request.getParameter("searchType").equals("LoadStatus")){%>selected<%}%> >
                                Load Status
                            </option>
                            <option value="load_number"
                                    <%if(request.getParameter("searchType")!=null && request.getParameter("searchType").equals("load_number")){%>selected<%}%> >
                                Load Number
                            </option>
                            <option value="wo_number"
                                    <%if(request.getParameter("searchType")!=null && request.getParameter("searchType").equals("wo_number")){%>selected<%}%> >
                                W/O
                            </option>
                        </select>


                    </div>
                    <button class="btn btn-default btn-sm" type="submit">Search</button>
                </div>
            </div>
        </form>
        <%}%>      
        <%if (request.getParameter("ShowSearch") != null) {%>
        <!-- main select row -->

        <div class="row">
            <div class="col-sm-12" align="center">
                <form class="form-inline" name="searchForm" id="searchForm" action="dispatch_board.jsp?ShowSearch=true"
                      style="margin-bottom: 5px;" method="post">
                    <div class="form-group form-group-sm">
                        <div class="input-group input-group-sm">
                            <div class="input-group-addon">Find:</div>
                            <input type="text" class="form-control" id="searchKey" name="searchKey"
                                   placeholder="Search key"
                                   value="<%=NullCheck.check(request.getParameter("searchKey"))%>"/>
                        </div>

                        <div class="input-group input-group-sm">

                            <select class="form-control" name="searchType">
                                <option value="all"
                                        <%if(request.getParameter("searchType")!=null && request.getParameter("searchType").equals("all")){%>selected<%}%> >
                                    Search All
                                </option>
                                <option value="LoadStatus"
                                        <%if(request.getParameter("searchType")!=null && request.getParameter("searchType").equals("LoadStatus")){%>selected<%}%> >
                                    Load Status
                                </option>
                                <option value="load_number"
                                        <%if(request.getParameter("searchType")!=null && request.getParameter("searchType").equals("load_number")){%>selected<%}%> >
                                    Load Number
                                </option>
                                <option value="wo_number"
                                        <%if(request.getParameter("searchType")!=null && request.getParameter("searchType").equals("wo_number")){%>selected<%}%> >
                                    W/O
                                </option>
                                <option value="customer"
                                        <%if(request.getParameter("searchType")!=null && request.getParameter("searchType").equals("customer")){%>selected<%}%> >
                                    Customer
                                </option>
                                <option value="dispatcher"
                                        <%if(request.getParameter("searchType")!=null && request.getParameter("searchType").equals("dispatcher")){%>selected<%}%> >
                                    Dispatcher
                                </option>
                                <option value="carrier"
                                        <%if(request.getParameter("searchType")!=null && request.getParameter("searchType").equals("carrier")){%>selected<%}%> >
                                    Carrier
                                </option>
                                <option value="consignee"
                                        <%if(request.getParameter("searchType")!=null && request.getParameter("searchType").equals("consignee")){%>selected<%}%> >
                                    Consignee
                                </option>
                                <option value="shipper"
                                        <%if(request.getParameter("searchType")!=null && request.getParameter("searchType").equals("shipper")){%>selected<%}%> >
                                    Shipper
                                </option>
                            </select>


                        </div>
                    </div>

                    <div class="form-group form-group-sm">

                        <div class="input-group input-group-sm">

                            <div class='input-group-addon'>From:</div>
                            <div class='input-group date' id='datetimepicker1'>
                                <input type='text' style="width: 95px;"
                                       class="form-control"  <%if(request.getParameter("startDate")!=null){%>
                                       value="<%=request.getParameter("startDate")%>"<%}%> name="startDate"
                                       id="startDate" placeholder="Date">
					<span class="input-group-addon">
					<span class="glyphicon glyphicon-calendar"></span>
					</span>

                            </div>

                            <div class='input-group-addon'>To:</div>
                            <div class='input-group date' id='datetimepicker2'>
                                <input type='text' style="width: 95px;"
                                       class="form-control" <%if(request.getParameter("endDate")!=null){%>
                                       value="<%=request.getParameter("endDate")%>"<%}%> name="endDate" id="endDate"
                                       placeholder="Date">

					<span class="input-group-addon">
					<span class="glyphicon glyphicon-calendar"></span>
					</span>

                            </div>


                        </div>
                        <button class="btn btn-default btn-sm" type="submit">Search</button>
                        <button class="btn btn-default btn-sm" type="submit">Show&nbsp;All</button>

                    </div>
                </form>
                <!-- end search form -->
            </div>
        </div>
        <%}%>
    </div>
    </div>
</nav>
<!-- end of nav -->
<%}%>