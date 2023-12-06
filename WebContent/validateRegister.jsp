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
		String username = request.getParameter("userid");
		String password = request.getParameter("password");

		if (username == null || password == null)
			return false;
		if ((username.length() == 0) || (password.length() == 0))
			return false;

		String url = "jdbc:sqlserver://cosc304_sqlserver:1433;DatabaseName=orders;TrustServerCertificate=True";
		String uid = "sa";
		String pw = "304#sa#pw";
        

		try (Connection con = DriverManager.getConnection(url, uid, pw)) {
			PreparedStatement ps = con.prepareStatement("SELECT userid FROM customer WHERE userid = ?;");
			ps.setString(1, username);
			ResultSet rst = ps.executeQuery();

			if (rst.next()) {
                session.setAttribute("registerMessage","That username is taken!");
                return false;
            } else {
                PreparedStatement ps1 = con.prepareStatement("INSERT INTO customer(userid, password, accesslevel) VALUES (?, ?, 1);");
                ps1.setString(1, username);
                ps1.setString(2, password);
                ps1.executeUpdate();
                session.removeAttribute("registerMessage");
                return true;
            }
			
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

