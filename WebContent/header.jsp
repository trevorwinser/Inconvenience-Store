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

        h4 {
            top: 10px;
            margin: 0px;

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
        #top-left {
            position: absolute;
            padding: 10px;
            text-align: left;
        }

    </style>
</head>
<body>
    <div>
    <%
        String username = (String) session.getAttribute("authenticatedUser");
        if (username != null) {
            out.println("<div id=\"top-right\"><h4>Signed in as: "+username+"</h4>");
            out.println("<h4><a href=\"logout.jsp\">Log out</a></h3></div>");
        } else {
            out.println("<div id=\"top-right\"><h4><a href=\"register.jsp\">Create account</a></h4>");
            out.println("<h4><a href=\"login.jsp\">Log in</a></h4></div>");
        }
    %>
    <div id="top-left"><h4><a href="showcart.jsp">Cart</a></h4></div>
    <h1 id="top-middle" align="center"><a href="index.jsp">The Inconvenience Store</a></h1>
     
    <br>
    <br>
    <br>
    </div>
</body>



