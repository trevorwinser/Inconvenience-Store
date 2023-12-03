<html>
<head>
<title>Trevor and Ryan's Grocery Order Processing</title>
<style>
	body {
			font-family: 'Comic Sans MS', cursive;
	}
    select {
			font-family: 'Comic Sans MS', cursive;
	}
	input {
			font-family: 'Comic Sans MS', cursive;
	}
</style>
</head>
<body>
<%@ include file="header.jsp" %>
<h1>Enter your customer id and password to complete the transaction:</h1>


<form method="get" action="order.jsp">
    <table>
        <tbody>
            <tr><td>Customer ID:</td><td><input type="text" name="customerId" size="20"></td></tr>
            <tr><td>Password:</td><td><input type="password" name="password" size="20"></td></tr>
            <tr><td><input type="submit" value="Submit"></td><td><input type="reset" value="Reset"></td></tr>
        </tbody>
    </table>
</form>

</body>
</html>

