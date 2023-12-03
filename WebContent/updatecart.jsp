<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.io.PrintWriter" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Update Cart</title>
</head>
<body>
<%
    // Get the current list of products
    @SuppressWarnings({"unchecked"})
    HashMap<String, ArrayList<Object>> productList = (HashMap<String, ArrayList<Object>>) session.getAttribute("productList");

    if (productList != null) {
        // Get parameters from the form
        HashMap<String, Integer> updatedQuantities = new HashMap<>();
        for (String productId : productList.keySet()) {
            String paramName = "quantity_" + productId;
            String quantityParam = request.getParameter(paramName);
            if (quantityParam != null) {
                try {
                    int updatedQuantity = Integer.parseInt(quantityParam);
                    updatedQuantities.put(productId, updatedQuantity);
                } catch (NumberFormatException e) {
                    // Handle invalid quantity (not a number)
                    // You may want to display an error message or log the issue
                }
            }
        }

        // Update quantities in the session
        for (String productId : updatedQuantities.keySet()) {
            int updatedQuantity = updatedQuantities.get(productId);
            ArrayList<Object> product = productList.get(productId);
            if (product != null && product.size() >= 4) {
                // Update the quantity in the product list
                product.set(3, updatedQuantity);
            }
        }

        // Redirect back to the shopping cart page
        
    }
    response.sendRedirect("showcart.jsp");
%>
</body>
</html>
