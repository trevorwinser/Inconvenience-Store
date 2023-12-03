<%@ page import="java.sql.*, java.io.*" %>
<%@ include file="jdbc.jsp" %>

<%
if (request.getMethod().equals("POST")) {
    String sql = "UPDATE customer SET firstName=?, lastName=?, email=?, phonenum=?, address=?, city=?, state=?, postalCode=?, country=? WHERE userid=?";
    try (Connection con = DriverManager.getConnection(url, uid, pw);
         PreparedStatement ps = con.prepareStatement(sql);) {

        // Retrieve values from the form
        String firstName = request.getParameter("firstName");
        String lastName = request.getParameter("lastName");
        String email = request.getParameter("email");
        String phone = request.getParameter("phonenum");
        String address = request.getParameter("address");
        String city = request.getParameter("city");
        String state = request.getParameter("state");
        String postalCode = request.getParameter("postalCode");
        String country = request.getParameter("country");

        // Set parameters for the SQL query
        ps.setString(1, firstName);
        ps.setString(2, lastName);
        ps.setString(3, email);
        ps.setString(4, phone);
        ps.setString(5, address);
        ps.setString(6, city);
        ps.setString(7, state);
        ps.setString(8, postalCode);
        ps.setString(9, country);
        ps.setString(10, (String) session.getAttribute("authenticatedUser"));  // assuming username is available from the previous page

        // Execute the update query
        int rowsAffected = ps.executeUpdate();

        if (rowsAffected > 0) {
            response.sendRedirect("customer.jsp");
        } else {
            response.sendRedirect("customer.jsp");
            out.println("<h1>Failed to update profile.</h1>");
        }
    } catch (SQLException ex) {
        out.println("SQLException: " + ex);
    }
}
%>
