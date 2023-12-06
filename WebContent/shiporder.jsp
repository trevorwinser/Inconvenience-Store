<%@ page import="java.sql.*" %>
<%@ include file="jdbc.jsp" %>
<%@ include file="header.jsp" %>

<%
    try {
        getConnection();
        Statement statement = con.createStatement();
        ResultSet resultSet = statement.executeQuery("SELECT * FROM ordersummary");
%>

<html>
<head>
    <title>Order List</title>
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
    <h2>Order List</h2>

    <table border="1">
        <tr>
            <th>Order ID</th>
            <th>Order Date</th>
            <th>Total Amount</th>
            <th></th>
        </tr>

        <% while (resultSet.next()) { %>
            <tr>
                <td><%= resultSet.getInt("orderId") %></td>
                <td><%= resultSet.getTimestamp("orderDate") %></td>
                <td><%= resultSet.getBigDecimal("totalAmount") %></td>
                <td><a href="ship.jsp?orderId=<%= resultSet.getInt("orderId") %>">Ship</a></td>
            </tr>
        <% } %>
    </table>
</body>
</html>

<%
    } catch (SQLException ex) {
        out.println("SQLException: " + ex);
    } finally {
        closeConnection();
    }
%>