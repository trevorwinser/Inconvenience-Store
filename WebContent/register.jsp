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
<%
	if (session.getAttribute("registerMessage") != null)
	out.println("<p>"+session.getAttribute("registerMessage").toString()+"</p>");
%>

<h3>Register Your Account</h3>

<form name="MyForm" method=post action="validateRegister.jsp">
<table style="display:inline">
	<tr>
		<td>Username:</td>
		<td><input type="text" name="userid"  size=10 maxlength=14></td>
	</tr>
	<tr>
		<td>Password:</td>
		<td><input type="password" name="password" size=10 maxlength="14"></td>
	</tr>
</table>
<br/>
<input class="submit" type="submit" name="Submit2" value="Create account">
</form>

</div>

</body>
</html>