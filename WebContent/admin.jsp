<!DOCTYPE html>
<html>
<head>
<title>Administrator Page</title>
</head>
<body>

<%@ include file="auth.jsp"%>
<%@ page import="java.text.NumberFormat" %>
<%@ include file="jdbc.jsp" %>

<%

try {		
	getConnection();
	Statement stmt = con.createStatement();	
	ResultSet rst = stmt.executeQuery("SELECT cast(orderDate as date), SUM(totalAmount) FROM ordersummary GROUP BY cast(orderDate as date) ORDER BY cast(orderDate as date) ASC;");

	NumberFormat currFormat = NumberFormat.getCurrencyInstance();

    out.println("<h2>Administrator Sales Report by Day</h2>");
	out.println("<table border='1'><tr><th>Order Date</th><th>Total Order Amount</th></tr>");
	while (rst.next()) {
		out.println("<tr><td>"+rst.getDate(1)+"</td><td>"+currFormat.format(rst.getDouble(2))+"</td></tr>");
	}
		out.println("</table>");
}
catch (SQLException ex) {
	out.println("SQLException: " + ex);
} finally {
	closeConnection();
}

%>

</body>
</html>

