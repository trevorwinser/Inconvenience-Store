<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.ArrayList" %>

<%
// Get the current list of products
@SuppressWarnings({"unchecked"})
HashMap<String, ArrayList<Object>> productList = (HashMap<String, ArrayList<Object>>) session.getAttribute("productList");

if (productList == null)
{	// No products currently in list.  Create a list.
	productList = new HashMap<String, ArrayList<Object>>();
}

String id = request.getParameter("pid");

// Update quantity if add same item to order again
if (productList.containsKey(id)) productList.remove(id);

session.setAttribute("productList", productList);
%>
<jsp:forward page="showcart.jsp" />