<%@ page language="java" import="java.io.*,java.sql.*"%>
<%@ include file="jdbc.jsp" %>
<%
	boolean created = false;
	session = request.getSession(true);

	try
	{
		created = validateLogin(out,request,session);
	}
	catch(IOException e)
	{	System.err.println(e); }

	if(created)
		response.sendRedirect("validateLogin.jsp");		            // Successful login
	else
		response.sendRedirect("register.jsp");		// Failed login - redirect back to login page with a message 
%>


<%!
	boolean validateLogin(JspWriter out,HttpServletRequest request, HttpSession session) throws IOException
	{
		try {
		String username = request.getParameter("userid");
		String password = request.getParameter("password");

		if (username == null || password == null)
		return false;
		if ((username.length() == 0) || (password.length() == 0))
			return false;

		PreparedStatement ps1 = con.prepareStatement("SELECT userid, password FROM customer WHERE userid = ?");
		ps1.setString(1, username);
		ResultSet rst = ps1.executeQuery();
		if (rst.next()) {
			session.setAttribute("registerMessage","That username is taken!");
			return false;
		}

		
		
        


			getConnection();
			PreparedStatement ps2 = con.prepareStatement("INSERT INTO customer(userid, password, accesslevel) VALUES (?, ?, 1);");
			ps2.setString(1, username);
			ps2.setString(2, password);
			ps2.executeUpdate();
			session.removeAttribute("registerMessage");
			return true;
			
		} 
		catch (SQLException ex) {
			out.println(ex);
		}
		finally
		{
			closeConnection();
		}	
		
        session.setAttribute("registerMessage","There was an error creating your account");
        return false;
	}
%>

