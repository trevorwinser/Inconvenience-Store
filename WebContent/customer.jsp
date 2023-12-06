<%@ include file="auth.jsp"%>
<%@ page import="java.text.NumberFormat" %>
<%@ include file="jdbc.jsp"%>
<%@ include file="header.jsp"%>
<!DOCTYPE html>
<html>
<head>
    <title>Customer Page</title>
    <style>
        body {
            font-family: 'Comic Sans MS', cursive;
            margin: 0;
            padding: 0;
            text-align: center;
        }
        header {
            background-color: #333;
            color: #fff;
            padding: 1rem;
        }
        h2 {
            font-family: 'Comic Sans MS', cursive;
            margin-top: 20px;
            margin-bottom: 20px;
        }
        table {
            width: 40%;
            margin: 20px auto;
            border-collapse: collapse;
        }
        th, td {
            border: 1px solid #ddd;
            padding: 8px;
            text-align: left;
        }
        th {
            background-color: #333;
            color: white;
        }
        input {
            font-family: 'Comic Sans MS', cursive;
        }
    </style>
</head>
<body>

    <%

    // TODO: Print Customer information

    try {   
        getConnection();
        PreparedStatement ps = con.prepareStatement("SELECT customerId,firstName,lastName,email,phonenum,address,city,state,postalCode,country,userid,password FROM customer WHERE userid = ?");
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
    } finally {
        closeConnection();
    }

    // Make sure to close connection
    %>
</body>
</html>