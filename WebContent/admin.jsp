<%@ include file="auth.jsp"%>
<%@ include file="authadmin.jsp"%>
<%@ include file="header.jsp" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Administrator Page</title>
  <style>
    body {
		font-family: 'Comic Sans MS', cursive;
      margin: 0;
      padding: 0;
    }
    header {
      text-align: center;
      padding: 1rem;
    }
    h2 {
      font-family: 'Comic Sans MS', cursive;
      margin-bottom: 20px;
      text-align: center;
    }
    .links {
      display: block;
      color: white;
      padding: 14px 16px;
      text-align: center;
      text-decoration: none;
      font-size: 18px;
      margin: 10px auto;
      width: 40%;
      border-radius: 5px;
      transition: background-color 0.3s;
    }
  </style>
</head>
<body>
  <header>
    <h1>Administrator Page</h1>
  </header>
  <div class="links">
    <h2><a href="listsalesorders.jsp">Display Sales</a></h2>
    <h2><a href="listcustomer.jsp">List Customers</a></h2>
    <h2><a href="updateprod.jsp">Update Product Information</a></h2>
    <h2><a href="loaddata.jsp">Restore Database</a></h2>
    <h2><a href="shiporder.jsp">Ship Order</a></h2>
  </div>
</body>
</html>
