<%@ page import="java.sql.*"%>
<%@ include file="jdbc.jsp"%>
<%@ include file="header.jsp"%>
<%@ include file="auth.jsp"%>

<%
    int custId = (session.getAttribute("customerId") == null) ? -1 : (Integer) session.getAttribute("customerId");
    try {
        getConnection();
        PreparedStatement ps = con.prepareStatement("SELECT email, phonenum, address, city, state, postalCode, country FROM customer WHERE customerId = ?");
        ps.setInt(1, custId);
        ResultSet rs = ps.executeQuery();

        if (rs.next()) {

            // Set default values for respective inputs
            pageContext.setAttribute("address", (rs.getString("address")==null)?"":rs.getString("address"));
            pageContext.setAttribute("city", (rs.getString("city")==null)?"":rs.getString("city"));
            pageContext.setAttribute("state", (rs.getString("state")==null)?"":rs.getString("state"));
            pageContext.setAttribute("postalCode", (rs.getString("postalCode")==null)?"":rs.getString("postalCode"));
            pageContext.setAttribute("country", (rs.getString("country")==null)?"":rs.getString("country"));
            
        }
    } catch (SQLException e) {
        e.printStackTrace(); // Handle the exception appropriately
    } finally {
        closeConnection();
    }
%>

<html>
<head>
    <title>Checkout</title>
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
        .pad {
            padding-left: 10px;
        }
    </style>
</head>
<body>
    <div class="pad">
    <h1>Enter Information:</h1>

    <form method="get" action="order.jsp">
        <table>
            <tbody>
                <tr><td>Address:</td><td><input type="text" name="address" size="20" value="<%= (String) pageContext.getAttribute("address") %>"></td></tr>
                <tr><td>City:</td><td><input type="text" name="city" size="20" value="<%= (String) pageContext.getAttribute("city") %>"></td></tr>
                <tr><td>State:</td><td><input type="text" name="state" size="20" value="<%= (String) pageContext.getAttribute("state") %>"></td></tr>
                <tr><td>Postal Code:</td><td><input type="text" name="postalCode" size="20" value="<%= (String) pageContext.getAttribute("postalCode") %>"></td></tr>
                <tr><td>Country:</td><td><input type="text" name="country" size="20" value="<%= (String) pageContext.getAttribute("country") %>"></td></tr>
                <tr><td><input type="submit" value="Submit"></td></tr>
            </tbody>
        </table>
    </form>
</div>
</body>
</html>