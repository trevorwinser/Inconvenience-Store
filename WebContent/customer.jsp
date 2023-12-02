<!DOCTYPE html>
<html>
<head>
<title>Customer Page</title>
<style>
	th {
    	text-align: center; 
    	vertical-align: middle;
	}
</style>
</head>
<body>

<%@ include file="auth.jsp"%>
<%@ page import="java.text.NumberFormat" %>
<%@ include file="jdbc.jsp" %>

<%
	String userName = (String) session.getAttribute("authenticatedUser");
	out.println("<h1>"+userName+"</h1>");
%>

<%

// TODO: Print Customer information
String sql = "SELECT * FROM customer WHERE userid = ?";
try {	// Load driver class
	Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
}
catch (java.lang.ClassNotFoundException e) {
	out.println("ClassNotFoundException: " +e);
}

String url = "jdbc:sqlserver://cosc304_sqlserver:1433;DatabaseName=orders;TrustServerCertificate=True";
String uid = "sa";
String pw = "304#sa#pw";

try (Connection con = DriverManager.getConnection(url, uid, pw);) {	
	PreparedStatement ps = con.prepareStatement(sql);
	ps.setString(1, userName);
	ResultSet rst = ps.executeQuery();
	rst.next();
	out.println("<table border='1'>");

	out.println("<tr><th>Id</th><td>"+rst.getInt(1)+"</td></tr>");
	out.println("<tr><th>First Name</th><td>"+rst.getString(2)+"</td></tr>");
	out.println("<tr><th>Last Name</th><td>"+rst.getString(3)+"</td></tr>");
	out.println("<tr><th>Email</th><td>"+rst.getString(4)+"</td></tr>");
	out.println("<tr><th>Phone</th><td>"+rst.getString(5)+"</td></tr>");
	out.println("<tr><th>Address</th><td>"+rst.getString(6)+"</td></tr>");
	out.println("<tr><th>City</th><td>"+rst.getString(7)+"</td></tr>");
	out.println("<tr><th>State</th><td>"+rst.getString(8)+"</td></tr>");
	out.println("<tr><th>Postal Code</th><td>"+rst.getString(9)+"</td></tr>");
	out.println("<tr><th>Country</th><td>"+rst.getString(10)+"</td></tr>");
	out.println("<tr><th>User id</th><td>"+rst.getString(11)+"</td></tr>");
} catch (SQLException ex) {
	out.println("SQLException: " + ex);
}

// Make sure to close connection
%>

</body>
</html>

