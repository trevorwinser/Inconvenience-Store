<%@ page import="java.sql.*" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Map" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<%@ include file="jdbc.jsp"%>
<%@ include file="header.jsp"%>
<%@ include file="auth.jsp"%>
<!DOCTYPE html>
<html>
<head>
<title>Trevor and Ryan's Grocery Order Processing</title>
<style>
    body {
		font-family: 'Comic Sans MS', cursive;
	}
	table {
		padding-left: 10px;
	}
	h1 {
		padding-left: 10px;
	}
	h2 {
		padding-left: 10px;
	}
	input {
		font-family: 'Comic Sans MS', cursive;
	}
</style>
</head>
<body>

<% 

int custId = (session.getAttribute("customerId") == null) ? -1 : (Integer) session.getAttribute("customerId");
String address = request.getParameter("address");
String city = request.getParameter("city");
String state = request.getParameter("state");
String postalCode = request.getParameter("postalCode");
String country = request.getParameter("country");
@SuppressWarnings({"unchecked"})
HashMap<String, ArrayList<Object>> productList = (HashMap<String, ArrayList<Object>>) session.getAttribute("productList");

NumberFormat currFormat = NumberFormat.getCurrencyInstance();

try {
    getConnection();

	boolean invalidInput = true;
    boolean emptyCart = true;
    if (productList == null) {
    } else if (!productList.isEmpty()) {
        emptyCart = false;
    }
	
	if ((address != null && city != null && state != null && postalCode != null && country != null) && !(address.equals("") || city.equals("") || state.equals("") || postalCode.equals("") || country.equals(""))) {
		invalidInput = false;
	}

    if (emptyCart) {
		out.println("<h1>Your shopping cart is empty!</h1>");  
        out.println("<h2><a href=\"listprod.jsp\">Continue Shopping</a></h2>");
    } else if (invalidInput) {
		out.println("<h1><a href=\"checkout.jsp\">Invalid input. Try Again.</a></h1>");
	} else {
        // Get inputted values from the form


        // Insert into ordersummary
        PreparedStatement pstmt2 = con.prepareStatement("INSERT INTO ordersummary(orderDate, totalAmount, shiptoAddress, shiptoCity, shiptoState, shiptoPostalCode, shiptoCountry, customerId) VALUES (?, ?, ?, ?, ?, ?, ?, ?)", Statement.RETURN_GENERATED_KEYS);

        pstmt2.setTimestamp(1, new Timestamp(System.currentTimeMillis()));
        pstmt2.setDouble(2, (Double) session.getAttribute("totalAmount"));
        pstmt2.setString(3, address);   //address
        pstmt2.setString(4, city);   //city
        pstmt2.setString(5, state);   //state
        pstmt2.setString(6, postalCode);   //postalcode
        pstmt2.setString(7, country);   //country
        pstmt2.setInt(8, custId);

        pstmt2.executeUpdate();

        ResultSet keys = pstmt2.getGeneratedKeys();
        keys.next();
        int orderId = keys.getInt(1);

        out.println("<h1>Your Order Summary</h1>");
        out.println("<table><tr><th>Product Id</th><th>Product Name</th><th>Quantity</th><th>Price</th><th>Subtotal</th></tr>");

        // Insert into orderproduct
        PreparedStatement pstmt3 = con.prepareStatement("INSERT INTO orderproduct(orderId,productId,quantity,price) VALUES (?,?,?,?)");
        Iterator<Map.Entry<String, ArrayList<Object>>> iterator = productList.entrySet().iterator();
        while (iterator.hasNext()) { 
            Map.Entry<String, ArrayList<Object>> entry = iterator.next();
            ArrayList<Object> product = (ArrayList<Object>) entry.getValue();
            String productId = (String) product.get(0);
            String price = (String) product.get(2);
            double pr = (price != null) ? Double.parseDouble(price) : 0.0;
            int qty = ((Integer)product.get(3)).intValue();
            pstmt3.setInt(1, orderId);
            try {
                pstmt3.setInt(2, Integer.parseInt(productId));
            } catch (NumberFormatException e){}
            pstmt3.setInt(3, qty);
            pstmt3.setDouble(4, pr);
            out.println("<tr><td>"+productId+"</td><td>"+product.get(1)+"</td><td align='center'>"+qty+"</td><td align='right'>"+currFormat.format(pr)+"</td><td align='right'>"+currFormat.format(pr*qty)+"</td></tr></tr>");
            pstmt3.executeUpdate();
        }

        out.println("<tr><td colspan=\"4\" align=\"right\"><b>Order Total</b></td>"
            +"<td align=\"right\">"+currFormat.format(session.getAttribute("totalAmount"))+"</td></tr>");
        out.println("</table>");

        session.setAttribute("productList", null);
        out.println("<h1>Order completed. Will be shipped soon...</h1>");
        out.println("<h1>Your order reference number is: "+orderId+"</h1>");
        out.println("<h1>Shipping to customer: " + session.getAttribute("authenticatedUser") + "</h1>");
    } 
}
catch (SQLException ex) {
    out.println("SQLException: " + ex);
}
finally {
    closeConnection();
}
%>
</BODY>
</HTML>
