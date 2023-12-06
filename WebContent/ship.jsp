<%@ page import="java.sql.*" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.Date" %>
<%@ include file="jdbc.jsp" %>
<%@ include file="header.jsp" %>


<html>
<head>
<title>Trevor and Ryan's Grocery Order Processing</title>
<style>
		body {
		overflow: hidden;
		font-family: 'Comic Sans MS', cursive;
	}
</style>
</head>
<body>
        


<%
	String id = request.getParameter("orderId");

	try {	
		getConnection();
		PreparedStatement ps1 = con.prepareStatement("SELECT productId, quantity FROM orderproduct WHERE orderId = ?");
		ps1.setInt(1, Integer.parseInt(id));
		ResultSet rst1 = ps1.executeQuery();
	
		boolean insufficientInventory = false;

		con.setAutoCommit(false);

		int productsShipped = 0;
		while (rst1.next() && productsShipped < 3) {
			int pid = rst1.getInt(1);
			int qty = rst1.getInt(2);
			// TODO: For each item verify sufficient quantity available in warehouse 1
			String sql2 = "SELECT quantity FROM productinventory WHERE warehouseId = 1 AND productId = ?";
			PreparedStatement ps2 = con.prepareStatement(sql2);
			ps2.setInt(1, rst1.getInt(1));
			ResultSet rst2 = ps2.executeQuery();

			if (rst2.next()) {
			int warehouseqty = rst2.getInt(1);
			if (warehouseqty < qty) {
				insufficientInventory = true;
				out.println("<h1>Shipment not done. Insufficient inventory for product id: "+pid+"</h1>");
				break;
			} else {
				String sql3 = "UPDATE productinventory SET quantity = ? WHERE warehouseId = 1 AND productId = ?";
				PreparedStatement ps3 = con.prepareStatement(sql3);
				int newqty = warehouseqty-qty;
				ps3.setInt(1, newqty);
				ps3.setInt(2, rst1.getInt(1));
				ps3.executeUpdate();
				out.println("<h1>Ordered produce: "+pid+" Qty: "+qty+" Previous inventory: "+warehouseqty+" New inventory: "+newqty+"</h1>");
			}
			} else {
				insufficientInventory = true;
				out.println("<h1>Shipment not done. Insufficient inventory for product id: "+pid+"</h1>");
				break;
			}
			productsShipped++;
		}
		
		String sql4 = "INSERT INTO shipment(shipmentDate, shipmentDesc, warehouseId) VALUES (?, ?, 1)";
		PreparedStatement ps4 = con.prepareStatement(sql4);
		ps4.setTimestamp(1, new Timestamp(System.currentTimeMillis()));
		ps4.setString(2, "");
		ps4.executeUpdate();

		// TODO: If any item does not have sufficient inventory, cancel transaction and rollback. Otherwise, update inventory for each item.
		if(insufficientInventory) con.rollback();

		con.setAutoCommit(true);

	} catch (SQLException ex) {
		out.println("SQLException: " + ex);
	} finally {
		closeConnection();
	}
%>                       				

<h2><a href="admin.jsp">Back to Main Page</a></h2>

</body>
</html>
