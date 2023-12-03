<!DOCTYPE html>
<html>
<head>
<title>Login Screen</title>
<style>
	body {
        overflow: hidden;
        font-family: 'Comic Sans MS', cursive;
    }
	table {
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

<div style="margin:0 auto;text-align:center;display:inline">

<h3>Please Login to System</h3>

<%
// Print prior error login message if present
if (session.getAttribute("loginMessage") != null)
	out.println("<p>"+session.getAttribute("loginMessage").toString()+"</p>");
%>

<form name="MyForm" method=post action="validateLogin.jsp">
<table style="display:inline">
<tr>
	<td><div align="right">Username:</div></td>
	<td><input type="text" name="username"  size=10 maxlength=14></td>
</tr>
<tr>
	<td><div align="right">Password:</div></td>
	<td><input type="password" name="password" size=10 maxlength="14"></td>
</tr>
</table>
<br/>
<input class="submit" type="submit" name="Submit2" value="Log In">
</form>

</div>

</body>
</html>

