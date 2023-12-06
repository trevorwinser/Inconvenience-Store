<%@ include file="auth.jsp"%>
<%@ include file="authadmin.jsp"%>
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
        ResultSet rst2 = stmt2.executeQuery("SELECT customerId, firstName, lastName, userid FROM customer");

        while (rst2.next()) {
            String name = "";
            if (rst2.getString(2) != null && rst2.getString(3) != null) {
                name = rst2.getString(2)+" "+rst2.getString(3);
            } else {
                name = rst2.getString(4);
            }
            out.println("<tr><td>"+rst2.getInt(1)+"</td><td>"+name+"</td></tr>");
        } 	
        out.println("</table>");
    } catch (SQLException ex) {
        out.println("SQLException: " + ex);
    } finally {
        closeConnection();
    }
    %>
    <h2><a href="admin.jsp">Back to Main Page</a></h2>
</body>
</html>