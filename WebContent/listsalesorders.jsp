<%@ include file="auth.jsp"%>
<%@ include file="authadmin.jsp"%>
<%@ page import="java.text.NumberFormat" %>
<%@ include file="header.jsp" %>
<%@ include file="jdbc.jsp" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sales Report by Day</title>
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
	Statement stmt1 = con.createStatement();	
	ResultSet rst1 = stmt1.executeQuery("SELECT cast(orderDate as date), SUM(totalAmount) FROM ordersummary GROUP BY cast(orderDate as date) ORDER BY cast(orderDate as date) ASC;");

	NumberFormat currFormat = NumberFormat.getCurrencyInstance();

    out.println("<h2>Administrator Sales Report by Day</h2>");
	out.println("<table border='1'><tr><th>Order Date</th><th>Total Order Amount</th></tr>");
	while (rst1.next()) {
		out.println("<tr><td>"+rst1.getDate(1)+"</td><td>"+currFormat.format(rst1.getDouble(2))+"</td></tr>");
	}
		out.println("</table>");

}
catch (SQLException ex) {
	out.println("SQLException: " + ex);
} finally {
	closeConnection();
}

%>
<h2><a href="admin.jsp">Back to Main Page</a></h2>
</body>
</html>