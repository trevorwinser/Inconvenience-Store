<%@ include file="auth.jsp"%>

<%@ include file="jdbc.jsp" %>
<%@ include file="header.jsp" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Customer List</title>
    <style>
        body {
            font-family: 'Comic Sans MS', cursive;
            background-color: #f4f4f4;
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
            width: 80%;
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
    </style>
</head>
<body>
    <%
    try {
        getConnection();
        out.println("<h2>Customer List</h2>");
        out.println("<table border='1'<tr><th>Customer Id</th><th>Customer Name</th></tr>");
        Statement stmt2 = con.createStatement();
        ResultSet rst2 = stmt2.executeQuery("SELECT customerId, firstName, lastName FROM customer");

        while (rst2.next()) {
            out.println("<tr><td>"+rst2.getInt(1)+"</td><td>"+rst2.getString(2)+" "+rst2.getString(3)+"</td></tr>");
        } 	
        out.println("</table>");
    } catch (SQLException ex) {
        out.println("SQLException: " + ex);
    } finally {
        closeConnection();
    }
    %>
</body>
</html>