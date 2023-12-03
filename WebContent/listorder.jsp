<%@ page import="java.sql.*" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<!DOCTYPE html>
<html>
<head>
<title>Trevor and Ryan's Grocery Order Processing</title>
<style>
	body {
	overflow: hidden;
    font-family: 'Comic Sans MS', cursive;
	}
</style>
</head>
<body>

<%@ include file="auth.jsp"%>
<%@ include file="header.jsp" %>
<h1>Order List</h1>

<%

//Note: Forces loading of SQL Server driver
try {	// Load driver class
	Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
}
catch (java.lang.ClassNotFoundException e) {
	out.println("ClassNotFoundException: " +e);
}

// Useful code for formatting currency values:	
// NumberFormat currFormat = NumberFormat.getCurrencyInstance();
// out.println(currFormat.format(5.0));  // Prints $5.00

// Make connection
String url = "jdbc:sqlserver://cosc304_sqlserver:1433;DatabaseName=orders;TrustServerCertificate=True";
String uid = "sa";
String pw = "304#sa#pw";
NumberFormat currFormat = NumberFormat.getCurrencyInstance();

try (Connection con = DriverManager.getConnection(url, uid, pw);) {		

	PreparedStatement ps1 = con.prepareStatement("SELECT orderId, orderDate, c.customerId, CONCAT(firstName, ' ', lastName), totalAmount FROM ordersummary o JOIN customer c ON o.customerId = c.customerId WHERE c.customerId = ?");
	ps1.setInt(1, (Integer)session.getAttribute("customerId"));
	ResultSet rst1 = ps1.executeQuery();
	
	out.println("<table border='1'><tr><th>Order Id</th><th>Order Date</th><th>Customer Id</th><th>Customer Name</th><th>Total Amount</th></tr>");
	while (rst1.next()) {
		PreparedStatement ps = con.prepareStatement("SELECT productId, quantity, price FROM orderproduct WHERE orderId = ?;");
		ps.setInt(1, rst1.getInt(1));
		ResultSet rst2 = ps.executeQuery();

		out.println("<tr><td>"+rst1.getInt(1)+"</td><td>"+rst1.getTimestamp(2)+"</td><td>"+rst1.getInt(3)+"</td><td>"+rst1.getString(4)+"</td><td>"+currFormat.format(rst1.getDouble(5))+"</td></tr>");
		out.println("<tr><td style='border:none;' colspan='2'></td><td colspan='2'><table border='1'><tr><th>Product Id</th><th>Quantity</th><th>Price</th></tr>");
		while(rst2.next()) {
			out.println("<tr><td>"+rst2.getInt(1)+"</td><td>"+rst2.getInt(2)+"</td><td>"+currFormat.format(rst2.getDouble(3))+"</td></tr>");
		}

		out.println("</table></td></tr>");
	}
		out.println("</table>");


	// For each order in the ResultSet

		// Print out the order summary information
		// Write a query to retrieve the products in the order
		//   - Use a PreparedStatement as will repeat this query many times
		// For each product in the order
			// Write out product information 

	// Close connection
	con.close();
}
catch (SQLException ex) {
	out.println("SQLException: " + ex);
}

%>

</body>
</html>