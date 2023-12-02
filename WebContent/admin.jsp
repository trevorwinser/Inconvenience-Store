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
// TODO: Write SQL query that prints out total order amount by day
String sql = "SELECT cast(orderDate as date), SUM(totalAmount) FROM ordersummary GROUP BY cast(orderDate as date) ORDER BY cast(orderDate as date) ASC;";

String url = "jdbc:sqlserver://cosc304_sqlserver:1433;DatabaseName=orders;TrustServerCertificate=True";
String uid = "sa";
String pw = "304#sa#pw";
NumberFormat currFormat = NumberFormat.getCurrencyInstance();

try (Connection con = DriverManager.getConnection(url, uid, pw);) {		
	Statement stmt = con.createStatement();	
	ResultSet rst1 = stmt.executeQuery(sql);

    out.println("<h2>Administrator Sales Report by Day</h2>");
	out.println("<table border='1'><tr><th>Order Date</th><th>Total Order Amount</th></tr>");
	while (rst1.next()) {
		out.println("<tr><td>"+rst1.getDate(1)+"</td><td>"+currFormat.format(rst1.getDouble(2))+"</td></tr>");
	}
		out.println("</table>");
	con.close();
}
catch (SQLException ex) {
	out.println("SQLException: " + ex);
}

%>

</body>
</html>

