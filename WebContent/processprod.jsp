<%@ include file="auth.jsp"%>
<%@ page import="java.sql.*" %>
<%@ include file="jdbc.jsp"%>

<%
try {
    getConnection();

    String action = request.getParameter("action");
    if (action != null) {
        if (action.equals("Update")) {
            String productName = request.getParameter("productName");
            Double productPrice = Double.parseDouble(request.getParameter("productPrice"));
            String productDesc = request.getParameter("productDesc");
            int productId = Integer.parseInt(request.getParameter("productId"));

            PreparedStatement ps = con.prepareStatement("UPDATE product SET productName = ?, productPrice = ?, productDesc = ? WHERE productId = ?");
            ps.setString(1, productName);
            ps.setDouble(2, productPrice);
            ps.setString(3, productDesc);
            ps.setInt(4, productId);
            ps.executeUpdate();
        } 
    }
}
catch (SQLException ex) {
    out.println("SQLException: " + ex);
}
finally {
    closeConnection();
    // Redirect back to the product list page or show a success message
    response.sendRedirect("updateprod.jsp");
}
%>