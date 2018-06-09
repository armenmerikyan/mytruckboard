<%@ page
        import="com.big.util.*,java.text.*,java.util.*,java.io.*,javax.xml.parsers.*,org.w3c.dom.*,java.sql.*,java.text.DateFormat" %>
<%
    String uuid = (String) session.getAttribute("uuid");
    boolean needStatusUpdate = false;
    if (uuid != null) {
%>

<%if (session.getAttribute("isAdmin").equals("true") && request.getParameter("cmd") != null && request.getParameter("cmd").equals("saveprofileinfo")) {%>


<%
    try {
        float fin_amount = 0.0f;
        if (!request.getParameter("gross_rate").equals(""))
            fin_amount = Float.parseFloat(request.getParameter("gross_rate").trim());

        Class.forName("com.mysql.jdbc.Driver");
        String url = "jdbc:mysql://localhost/test?zeroDateTimeBehavior=convertToNull";
        Connection connection = DriverManager.getConnection(url, "<USERNAME>", "<PASSWORD>");
        PreparedStatement ps2 = connection.prepareStatement("Update test.TRUCKING_USERS Set f_name = ?, l_name = ?, address1 = ?, city = ?, zip = ?, state = ?, country = ?, phone = ?, pay_type = ?, is_owner = ?, primary_contact = ?, accounting_contact = ?, gross_rate = ?, is_online = ?, access_driver_pay = ?, edit_driver_pay = ?, create_pending_loads = ?, print_pending_loads = ?, save_user_search = ? where email = ? and company_id = ?");
        ps2.setString(1, request.getParameter("f_name"));
        ps2.setString(2, request.getParameter("l_name"));
        ps2.setString(3, request.getParameter("address1"));
        ps2.setString(4, request.getParameter("city"));
        ps2.setString(5, request.getParameter("zip"));
        ps2.setString(6, request.getParameter("state"));
        ps2.setString(7, request.getParameter("country"));
        ps2.setString(8, request.getParameter("phone"));
        ps2.setString(9, request.getParameter("pay_type"));
        ps2.setString(10, request.getParameter("is_owner"));
        ps2.setString(11, request.getParameter("primary_contact"));
        ps2.setString(12, request.getParameter("accounting_contact"));
        ps2.setFloat(13, fin_amount);
        ps2.setString(14, request.getParameter("is_online"));
        ps2.setString(15, request.getParameter("access_driver_pay"));
        ps2.setString(16, request.getParameter("edit_driver_pay"));
        ps2.setString(17, request.getParameter("create_pending_loads"));
        ps2.setString(18, request.getParameter("print_pending_loads"));
        ps2.setString(19, request.getParameter("save_user_seaerchp"));
        ps2.setString(20, request.getParameter("user_id"));
        ps2.setString(21, uuid);
        ps2.executeUpdate();
        connection.close();

    } catch (Exception ex) {
%><%="Error Posting " + ex%><%
        System.out.println("" + ex);
    }
%>

<%} else {%>
Login Error
<%}%>
<%}%>