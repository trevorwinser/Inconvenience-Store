<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Text Positions</title>
    <style>
        body {
            margin: 0;
            padding: 0;
        }

        #top-middle {
            position: absolute;
            top: 0%;
            left: 50%;
            transform: translate(-50%, -50%);
            text-align: center;
        }
        a {
            text-decoration:none;
        }
        #top-right {
            position: absolute;
            right: 0;
            padding: 10px;
            text-align: left;
        }
        p {
            margin-top: 0px;
            margin-bottom: 0px;
        }
    </style>
</head>
<body>
    <div>
    <%
        String username = (String) session.getAttribute("authenticatedUser");
        if (username != null) {
            out.println("<div id=\"top-right\"><p><b>Signed in as: "+username+"</b></p>");
            out.println("<p><b><a href=\"logout.jsp\">Log out</a></b></p></div>");
        } else {
            out.println("<div id=\"top-right\"><p><b><a href=\"register.jsp\">Create account</a></b></p>");
            out.println("<p><b><a href=\"login.jsp\">Log in</a></b></p></div>");
        }
    %>     
    <h1 id="top-middle" align="center"><a href="index.jsp">The Inconvenience Store</a></h1>
     
    <br>
    <br>
    <br>
    </div>
</body>

