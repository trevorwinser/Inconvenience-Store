<!DOCTYPE html>
<html>
<head>
    <title>Customer Page</title>
    <style>
        body {
            overflow: hidden;
            font-family: 'Comic Sans MS', cursive;
        }
        table {
            margin: auto;
        }
        th {
            text-align: center;
            vertical-align: middle;
        }
        .edit {
            text-align: center;
        }
    </style>
</head>
<body>
    <%@ include file="auth.jsp"%>
    <%@ page import="java.text.NumberFormat" %>
    <%@ include file="jdbc.jsp" %>
    <%@ include file="header.jsp" %>

    <%

    // TODO: Print Customer information
    String sql = "SELECT customerId,firstName,lastName,email,phonenum,address,city,state,postalCode,country,userid,password FROM customer WHERE userid = ?";
    try {    // Load driver class
        Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
    }
    catch (java.lang.ClassNotFoundException e) {
        out.println("ClassNotFoundException: " +e);
    }

    String url = "jdbc:sqlserver://cosc304_sqlserver:1433;DatabaseName=orders;TrustServerCertificate=True";
    String uid = "sa";
    String pw = "304#sa#pw";

    try (Connection con = DriverManager.getConnection(url, uid, pw);) {   
        PreparedStatement ps = con.prepareStatement(sql);
        ps.setString(1, username);
        ResultSet rst = ps.executeQuery();
        rst.next();
        out.println("<form action=\"updatecustomer.jsp\" method=\"post\">");
        out.println("<table border='1'>");
        
        // Iterate through each column and display input fields with values
        for (int i = 1; i <= rst.getMetaData().getColumnCount(); i++) {
            String columnName = rst.getMetaData().getColumnName(i);
            String columnValue = (rst.getString(i) != null) ? rst.getString(i) : "";

            out.println("<tr><th>" + columnName + "</th><td>");
			if (!columnName.equals("customerId"))
            out.println("<input type=\"text\" name=\"" + columnName + "\" value=\"" + columnValue + "\">");
			else out.println(columnValue);
            out.println("</td></tr>");
        }

        out.println("</table>");
        out.println("<p class=\"edit\"><input type=\"submit\" value=\"Save Changes\"></p>");
        out.println("</form>");
    } catch (SQLException ex) {
        out.println("SQLException: " + ex);
    }

    // Make sure to close connection
    %>
</body>
</html>