<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Trevor and Ryan's Grocery Main Page</title>
    <style>
        body {
            overflow: hidden;
            font-family: 'Comic Sans MS', cursive;
        }

        h2 {
            position: absolute;
        }
        a {
            text-decoration:none;
        }
    </style>
</head>
<body>
    <%@ include file="header.jsp" %>

    <h2 align="center"><a href="login.jsp">Login</a></h2>

    <h2 align="center"><a href="listprod.jsp">Begin Shopping</a></h2>

    <h2 align="center"><a href="listorder.jsp">List All Orders</a></h2>

    <h2 align="center"><a href="index.jsp">New Main Page</a></h2>

    <h2 align="center"><a href="customer.jsp">Customer Info</a></h2>

    <h2 align="center"><a href="admin.jsp">Administrators</a></h2>

    <h2 align="center"><a href="logout.jsp">Log out</a></h2>

    <h2 align="center"><a href="showcart.jsp">Show cart</a></h2>

    <script>
        document.addEventListener('DOMContentLoaded', function() {
    const h2Elements = document.querySelectorAll('h2');

    h2Elements.forEach(function(element) {
        const ranX = Math.random() * (window.innerWidth - element.clientWidth - 50);
        const ranY = Math.random() * (window.innerHeight - element.clientHeight - 50);
        element.style.left = ranX + 'px';
        element.style.top = ranY + 'px';

        var speedX = (Math.random() > 0.5 ? 0.5 : -0.5) * (Math.random() * 2 + 1) + 0.5;
        var speedY = (Math.random() > 0.5 ? 0.5 : -0.5) * (Math.random() * 2 + 1) + 0.5;

        function move() {
            const rect = element.getBoundingClientRect();

            if (rect.left + speedX < 0 || rect.right + speedX > window.innerWidth) {
                speedX *= -1;
                changeColor();
            }
            if (rect.top + speedY < 0 || rect.bottom + speedY > window.innerHeight) {
                speedY = speedY * -1;
                changeColor();
            }
            element.style.left = rect.left + speedX + 'px';
            const currentTop = parseFloat(element.style.top) || 0;
            element.style.top = currentTop + speedY + 'px';


            requestAnimationFrame(move);
        }

        function changeColor() {
                const randomColor = getRandomColor();
                element.style.color = randomColor;
                const anchor = element.querySelector('a');
                if (anchor) {
                        anchor.style.color = randomColor;
                }
        }

        function getRandomColor() {
                const letters = '0123456789ABCDEF';
                let color = '#';
                for (let i = 0; i < 6; i++) {
                        color += letters[Math.floor(Math.random() * 16)];
                }
                return color;
        }

        move();
    });
	});

</script>



<%
	String userName = (String) session.getAttribute("authenticatedUser");
	if (userName != null)
		out.println("<h2 align=\"center\">Signed in as: "+userName+"</h2>");
%>

</body>
</html>


