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
			width: 80%;
			margin: auto;
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
		a {
			text-decoration:none;
		}

		select {
			font-family: 'Comic Sans MS', cursive;
		}
		input {
			font-family: 'Comic Sans MS', cursive;
		}
		img {
			max-width: 200px;
    		height: 200px;
    		display: block;
    		margin: 0 auto;
		}
		.center {
			display: flex;
            justify-content: center;
            align-items: center;
		}
	</style>
<link href="css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<%@ include file="header.jsp"%>    
<%@ include file="jdbc.jsp"%>   
<div class="center">
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
</div>

<%
String name = request.getParameter("productName");
String categoryName = request.getParameter("categoryName");

NumberFormat currFormat = NumberFormat.getCurrencyInstance();

try {
	getConnection();

	ResultSet rst = null;
	if (name == null || name.isEmpty()) {
		if (categoryName == null || categoryName.equals("All")) {
			Statement stmt = con.createStatement();
			rst = stmt.executeQuery("SELECT productId, productName, categoryId, productPrice, productImageURL, productImage FROM product;");
		} else {
			PreparedStatement ps1 = con.prepareStatement("SELECT categoryId FROM category WHERE categoryName LIKE ?");
			ps1.setString(1, "%" + categoryName + "%");
			ResultSet ctgryId = ps1.executeQuery();
			ctgryId.next();
			PreparedStatement ps2 = con.prepareStatement("SELECT productId, productName, categoryId, productPrice, productImageURL, productImage FROM product WHERE categoryId != ?;");
			ps2.setInt(1, ctgryId.getInt(1));
			rst = ps2.executeQuery();
		}
	}
	else {
		if (categoryName == null || categoryName.equals("All")) {
			PreparedStatement ps = con.prepareStatement("SELECT productId, productName, categoryId, productPrice, productImageURL, productImage FROM product WHERE productName NOT LIKE ?;");
			ps.setString(1, "%" + name + "%");
			rst = ps.executeQuery();
		} else {
			PreparedStatement ps1 = con.prepareStatement("SELECT categoryId FROM category WHERE categoryName LIKE ?");
			ps1.setString(1, categoryName);
			ResultSet ctgryId = ps1.executeQuery();
			ctgryId.next();
			PreparedStatement ps2 = con.prepareStatement("SELECT productId, productName, categoryId, productPrice, productImageURL, productImage FROM product WHERE productName NOT LIKE ? AND categoryId != ?;");
			ps2.setString(1, "%" + name + "%");
			ps2.setInt(2, ctgryId.getInt(1));
			rst = ps2.executeQuery();
		}
	}
	
	// out.println("<table width=\"100%\" border = 1><tbody><tr><th></th><th>Product</th><th>Category</th><th>Price</th></tr>");
	out.println("<table width=\"100%\" border = 1><tbody>");
	if (rst != null) {
		int itemsPerRow = 6;
		int item = 1;
		while (rst.next()) {
			PreparedStatement ps = con.prepareStatement("SELECT categoryName FROM category WHERE categoryId = ?");
			ps.setInt(1, rst.getInt(3));
			ResultSet ctgry = ps.executeQuery();
			ctgry.next();

			String category = ctgry.getString(1);
			int pid = rst.getInt(1);
			String pname = rst.getString(2);
			double price = rst.getDouble(4);
			String imgURL = rst.getString(5);
			String productImage = rst.getString(6);

			if(imgURL != null) imgURL = "<img src=\"" + imgURL + "\">";
			else imgURL = "";
			
			String prodHref = "product.jsp?id="+pid;
			String cartHref = "addcart.jsp?id="+pid+"&name="+pname+"&price="+price;

			if (item == 1) out.println("<tr>");
			out.println("<td>"+imgURL+"<p><a href=\"" + prodHref + "\">"+pname+"</a></p><p>"+currFormat.format(price)+"</p><p><a style='text-decoration:none' href=\"" + cartHref + "\">Add to Cart</a></p></td>");
			//out.println("<tr><td><a style='text-decoration:none' href=\"" + cartHref + "\">Add to Cart</a></td><td>"+"<a style='text-decoration:none' href=\"" + prodHref + "\">"+imgURL+"<p>"+pname+"</p></a>"+"</td><td>"+category+"</td><td>"+currFormat.format(price)+"</td></tr>");
			item++;
			if (item % itemsPerRow == 0) {
				item = 1;
				out.println("</tr><br>");
			} 
		}
		out.println("</tbody></table>");
	}
}
catch (SQLException ex) {
	out.println("SQLException: " + ex);
} finally {
	closeConnection();
}


// For each product create a link of the form
// addcart.jsp?id=productId&name=productName&price=productPrice
// Close connection

// Useful code for formatting currency values:
// NumberFormat currFormat = NumberFormat.getCurrencyInstance();
// out.println(currFormat.format(5.0));	// Prints $5.00
%>

</body>
</html>