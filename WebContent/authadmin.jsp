<%
    if (session.getAttribute("accesslevel") != null) {
        int accesslevel = (Integer) session.getAttribute("accesslevel");
        boolean admin = accesslevel == 1 ? false : true;
        if (!admin)
        {
            String loginMessage = "You have not been authorized to access the URL "+request.getRequestURL().toString();
            session.setAttribute("loginMessage",loginMessage);        
            response.sendRedirect("login.jsp");
        } 
    }   
%>