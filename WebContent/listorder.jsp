<%@ page import="java.sql.*" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<!DOCTYPE html>
<html>
<head>
<title>Orders</title>
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

<%@ include file="auth.jsp"%>
<%@ include file="header.jsp"%>
<%@ include file="jdbc.jsp"%>
<h1>Order List</h1>

<%



// Useful code for formatting currency values:	
// NumberFormat currFormat = NumberFormat.getCurrencyInstance();
// out.println(currFormat.format(5.0));  // Prints $5.00

// Make connection
NumberFormat currFormat = NumberFormat.getCurrencyInstance();

try {		
	getConnection();
	PreparedStatement ps1 = con.prepareStatement("SELECT orderId, orderDate, c.customerId, CONCAT(firstName, ' ', lastName), totalAmount FROM ordersummary o JOIN customer c ON o.customerId = c.customerId WHERE c.customerId = ?");
	int custId = (session.getAttribute("customerId") == null) ? -1 : (Integer) session.getAttribute("customerId");
	ps1.setInt(1, custId);
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
}
catch (SQLException ex) {
	out.println("SQLException: " + ex);
} finally {
	closeConnection();
}

%>

</body>
</html>