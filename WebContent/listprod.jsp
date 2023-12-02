<%@ page import="java.sql.*,java.net.URLEncoder" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<!DOCTYPE html>
<html>
<head>
	<style>
		body {
			font-family: 'Comic Sans MS', cursive;
		}
		table {
		  border-collapse: collapse;
		  width: 100%;
		}
	
		td,
		th {
		  border: 1px solid #dddddd;
		  text-align: left;
		  padding: 8px;
		}
	
		tr:nth-child(even) {
		  background-color: #dddddd;
		}

		select {
			font-family: 'Comic Sans MS', cursive;
		}
		input {
			font-family: 'Comic Sans MS', cursive;
		}
	  </style>
<link href="css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<%@ include file="header.jsp" %>    
<hr>

<h1>Search for the products you want to buy:</h1>

<form method="get" action="listprod.jsp">
<select size="1" name="categoryName">
	<option>All</option>
	<option>Beverages</option>
	<option>Condiments</option>
	<option>Confections</option>
	<option>Dairy Products</option>
	<option>Grains/Cereals</option>
	<option>Meat/Poultry</option>
	<option>Produce</option>
	<option>Seafood</option>       
</select>
<input type="text" name="productName" size="50">
<input type="submit" value="Submit"><input type="reset" value="Reset"> (Leave blank for all products)
</form>


<% // Get product name to search for
String name = request.getParameter("productName");

String categoryName = request.getParameter("categoryName");
out.println(categoryName);
//Note: Forces loading of SQL Server driver
try
{	// Load driver class
	Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
}
catch (java.lang.ClassNotFoundException e)
{
	out.println("ClassNotFoundException: " +e);
}

// Variable 'name' now contains the search string the user entered
// Use it to build a query and print out the resultset.  Make sure to use PreparedStatement!

// Make the connection
String url = "jdbc:sqlserver://cosc304_sqlserver:1433;DatabaseName=orders;TrustServerCertificate=True";
String uid = "sa";
String pw = "304#sa#pw";
NumberFormat currFormat = NumberFormat.getCurrencyInstance();

try (Connection con = DriverManager.getConnection(url, uid, pw)) {


	ResultSet rst = null;
	if (name == null) {
		if (categoryName == null || categoryName.equals("All")) {
			Statement stmt = con.createStatement();
			rst = stmt.executeQuery("SELECT productId, productName, categoryId, productPrice FROM product;");
		} else {
			PreparedStatement ps1 = con.prepareStatement("SELECT categoryId FROM category WHERE categoryName LIKE ?");
			ps1.setString(1, "%" + categoryName + "%");
			ResultSet ctgryId = ps1.executeQuery();
			ctgryId.next();
			PreparedStatement ps2 = con.prepareStatement("SELECT productId, productName, categoryId, productPrice FROM product WHERE categoryId = ?;");
			ps2.setInt(1, ctgryId.getInt(1));
			rst = ps2.executeQuery();
		}
	}
	else {
		if (categoryName == null || categoryName.equals("All")) {
			PreparedStatement ps = con.prepareStatement("SELECT productId, productName, categoryId, productPrice FROM product WHERE productName LIKE ?;");
			ps.setString(1, "%" + name + "%");
			rst = ps.executeQuery();
		} else {
			PreparedStatement ps1 = con.prepareStatement("SELECT categoryId FROM category WHERE categoryName LIKE ?");
			ps1.setString(1, categoryName);
			ResultSet ctgryId = ps1.executeQuery();
			ctgryId.next();
			PreparedStatement ps2 = con.prepareStatement("SELECT productId, productName, categoryId, productPrice FROM product WHERE productName LIKE ? AND categoryId = ?;");
			ps2.setString(1, "%" + name + "%");
			ps2.setInt(2, ctgryId.getInt(1));
			rst = ps2.executeQuery();
		}
	}
	
	out.println("<table width=\"100%\" border = 1><tbody><tr><th></th><th>Product Name</th><th>Category</th><th>Price</th></tr>");
	if (rst != null) {
		while (rst.next()) {
			PreparedStatement ps = con.prepareStatement("SELECT categoryName FROM category WHERE categoryId = ?");
			ps.setInt(1, rst.getInt(3));
			ResultSet ctgry = ps.executeQuery();
			ctgry.next();
			String category = ctgry.getString(1);

			int pid = rst.getInt(1);
			String pname = rst.getString(2);
			double price = rst.getDouble(4);
			String prodHref = "product.jsp?id="+pid;
			String cartHref = "addcart.jsp?id="+pid+"&name="+pname+"&price="+price;
			out.println("<tr><td><a style='text-decoration:none' href=\"" + cartHref + "\">Add to Cart</a></td><td>"+"<a style='text-decoration:none' href=\"" + prodHref + "\">"+pname+"</a>"+"</td><td>"+category+"</td><td>"+currFormat.format(price)+"</td></tr>");
		}
		out.println("</tbody></table>");
	}
	con.close();

}
catch (SQLException ex) {
	out.println("SQLException: " + ex);
} 


// For each product create a link of the form
// addcart.jsp?id=productId&name=productName&price=productPrice
// Close connection

// Useful code for formatting currency values:
// NumberFormat currFormat = NumberFormat.getCurrencyInstance();
// out.println(currFormat.format(5.0);	// Prints $5.00
%>

</body>
</html>