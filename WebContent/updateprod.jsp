

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Update Product Information</title>
    <style>
        body {
            font-family: 'Comic Sans MS', cursive;
            margin: 20px;
        }

        h2 {
            text-align:center;
            color: #333;
        }

        .product {
            background-color: #fff;
            padding: 20px;
            margin-bottom: 20px;
            border: 1px solid #ddd;
            border-radius: 5px;
        }

        label {
            display: block;
            margin-bottom: 5px;
        }

        input {
            font-family: 'Comic Sans MS', cursive;
        }

        input[type="text"], textarea {
            
            width: 100%;
            padding: 8px;
            margin-bottom: 10px;
            box-sizing: border-box;
        }

        input[type="submit"] {
            background-color: #4caf50;
            color: #fff;
            padding: 10px 15px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }

        hr {
            border: 0;
            height: 1px;
            background: #ddd;
            margin-top: 10px;
            margin-bottom: 20px;
        }
    </style>
</head>
<body>

<%@ include file="jdbc.jsp" %>
<%@ include file="header.jsp" %>
<%@ include file="auth.jsp" %>
<%
try {        
    getConnection();
    Statement stmt = con.createStatement();
    ResultSet rs = stmt.executeQuery("SELECT * FROM product");

    out.println("<h2>Update Product Information</h2>");

    while (rs.next()) {
        int productId = rs.getInt("productId");
        String productName = rs.getString("productName");
        double productPrice = rs.getDouble("productPrice");
        String productDesc = rs.getString("productDesc");
%>
        <div class="product">
            <h3>Product ID: <%= productId %></h3>
            <form action="processprod.jsp" method="post">
                <input type="hidden" name="productId" value="<%= productId %>">
                
                <label for="productName">Product Name:</label>
                <input type="text" name="productName" value="<%= productName %>">

                <label for="productPrice">Product Price:</label>
                <input type="text" name="productPrice" value="<%= productPrice %>">

                <label for="productDesc">Product Description:</label>
                <textarea name="productDesc" rows="4" cols="50"><%= productDesc %></textarea>

                <input type="submit" name="action" value="Update">
            </form>
        </div>
<%
    }
}
catch (SQLException ex) {
    out.println("SQLException: " + ex);
} finally {
    closeConnection();
}
%>

</body>
</html>