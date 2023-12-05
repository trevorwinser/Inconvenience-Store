<%@ page import="java.sql.*"%>
<%@ include file="jdbc.jsp"%>
<%@ include file="header.jsp"%>

<%
    // Check if the user is logged in
    int custId = (session.getAttribute("customerId") == null) ? -1 : (Integer) session.getAttribute("customerId");

    // If the user is logged in, attempt to retrieve shipment information
    if (custId != -1) {

        try {
            getConnection();
            PreparedStatement ps = con.prepareStatement("SELECT email, phonenum, address, city, state, postalCode, country FROM customer WHERE customerId = ?");
            ps.setInt(1, custId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {

                // Set default values for respective inputs
                pageContext.setAttribute("email", rs.getString("email"));
                pageContext.setAttribute("phonenum", rs.getString("phonenum"));
                pageContext.setAttribute("address", rs.getString("address"));
                pageContext.setAttribute("city", rs.getString("city"));
                pageContext.setAttribute("state", rs.getString("state"));
                pageContext.setAttribute("postalCode", rs.getString("postalCode"));
                pageContext.setAttribute("country", rs.getString("country"));
            }
        } catch (SQLException e) {
            e.printStackTrace(); // Handle the exception appropriately
        } finally {
            closeConnection();
        }
    }
%>

<html>
<head>
    <title>Trevor and Ryan's Grocery Order Processing</title>
    <style>
        body {
            font-family: 'Comic Sans MS', cursive;
        }
        select {
            font-family: 'Comic Sans MS', cursive;
        }
        input {
            font-family: 'Comic Sans MS', cursive;
        }
    </style>
</head>
<body>
    <h1>Enter your customer id and password to complete the transaction:</h1>

    <form method="get" action="order.jsp">
        <table>
            <tbody>
                <tr><td>Customer ID:</td><td><input type="text" name="customerId" size="20" value="<%= custId %>"></td></tr>
                <tr><td>Password:</td><td><input type="password" name="password" size="20"></td></tr>
                <tr><td>Email:</td><td><input type="text" name="email" size="20" value="<%= (String) pageContext.getAttribute("email") %>"></td></tr>
                <tr><td>Phone Number:</td><td><input type="text" name="phonenum" size="20" value="<%= (String) pageContext.getAttribute("phonenum") %>"></td></tr>
                <tr><td>Address:</td><td><input type="text" name="address" size="20" value="<%= (String) pageContext.getAttribute("address") %>"></td></tr>
                <tr><td>City:</td><td><input type="text" name="city" size="20" value="<%= (String) pageContext.getAttribute("city") %>"></td></tr>
                <tr><td>State:</td><td><input type="text" name="state" size="20" value="<%= (String) pageContext.getAttribute("state") %>"></td></tr>
                <tr><td>Postal Code:</td><td><input type="text" name="postalCode" size="20" value="<%= (String) pageContext.getAttribute("postalCode") %>"></td></tr>
                <tr><td>Country:</td><td><input type="text" name="country" size="20" value="<%= (String) pageContext.getAttribute("country") %>"></td></tr>
                <tr><td><input type="submit" value="Submit"></td><td><input type="reset" value="Reset"></td></tr>
            </tbody>
        </table>
    </form>
</body>
</html>