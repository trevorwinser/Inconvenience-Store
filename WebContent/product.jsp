
<%@ page import="java.util.HashMap" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<%@ include file="jdbc.jsp" %>

<html>
<head>
<title>Trevor and Ryan's Grocery - Product Information</title>
<link href="css/bootstrap.min.css" rel="stylesheet">
</head>
<body>

<%@ include file="header.jsp" %>

<%
// Get product name to search for
// TODO: Retrieve and display info for the product
String productId = request.getParameter("id");

String url = "jdbc:sqlserver://cosc304_sqlserver:1433;DatabaseName=orders;TrustServerCertificate=True";
String uid = "sa";
String pw = "304#sa#pw";
NumberFormat currFormat = NumberFormat.getCurrencyInstance();

try (Connection con = DriverManager.getConnection(url, uid, pw)) {
	PreparedStatement ps = con.prepareStatement("SELECT productId, productName, productPrice, productImageURL, productImage, productDesc FROM product WHERE productId = ?;");
	ps.setInt(1, Integer.parseInt(productId));
	ResultSet rst = ps.executeQuery();
    
    rst.next();
	int pid = rst.getInt(1);
	String pname = rst.getString(2);
	double price = rst.getDouble(3);
    String imgURL = rst.getString(4);
    String productImage = rst.getString(5);
    String prodHref = "product.jsp?id="+pid;
	String cartHref = "addcart.jsp?id="+pid+"&name="+pname+"&price="+price;
    String prodDesc = rst.getString(6);
    
    out.println("<p style='font-size: 32px;line-height: 0.1'>"+pname+"</p>");

    if(imgURL != null) 
    out.println("<img src=\"" + imgURL + "\"></img>");

    if(productImage != null)
    out.println("<img src=\"displayImage.jsp?id=" + pid + "\"></img>");

    out.println("<p><b>Description&nbsp</b>"+prodDesc+"</p>");

    out.println("<p><b>Id&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp</b>"+pid);
    out.println("<br><b>Price&nbsp&nbsp</b>"+currFormat.format(price)+"</p>");
    
	out.println("<a style='font-size: 26px;text-decoration:none;color: rgb(45, 125, 201)' href=\"" + cartHref + "\">Add to Cart&nbsp&nbsp</a>");
    out.println("<p><a style='font-size: 26px;text-decoration:none;color: rgb(45, 125, 201)' href='listprod.jsp'>Continue Shopping</a></p>");
    
// TODO: Add links to Add to Cart and Continue Shopping
}
    catch (SQLException ex) {
        out.println("SQLException: " + ex);
} 
%>

</body>
</html>

