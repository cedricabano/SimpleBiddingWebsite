<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Login</title>
</head>
<body>

<%
	if ((session.getAttribute("user") == null)) {
%>
	You are not logged in.
	<br/>
	<a href="index.jsp">Please Login</a>
<%
	}
	//permissions check
	else if((Integer)session.getAttribute("permissions") < 2) {
%>
		You do not have permission to view this page.
		<br/>
		<a href="home.jsp">Return to home page</a>
<%
	}
	else {
		try {
			ApplicationDB db = new ApplicationDB();	

			Connection con = db.getConnection();
			Statement stmt = con.createStatement();
		
			String query = request.getParameter("stats");
			//admin queries
			String checkStats = "";
			int type;
			//total earnings
			if(query.equals("Total earnings")) {
				type = 0;
				checkStats = "SELECT SUM(amount) AS earnings FROM Bids b1 WHERE NOT EXISTS " + 
					"(SELECT * FROM Bids b2 WHERE b1.itemID = b2.itemID AND b1.amount < b2.amount)";
			}
			else {
				type = 1;
				//earnings per item, type, user
				if(query.equals("Earnings by item"))
					checkStats = "SELECT Items.name AS category, SUM(b1.amount) AS earnings FROM Bids b1, Items WHERE b1.itemID = Items.itemID AND NOT EXISTS " +
						"(SELECT * FROM Bids b2 WHERE b1.itemID = b2.itemID AND b1.amount < b2.amount) GROUP BY Items.name";
				else if(query.equals("Earnings by item type"))
					checkStats = "SELECT Items.category AS category, SUM(b1.amount) AS earnings FROM Bids b1, Items WHERE b1.itemID = Items.itemID AND NOT EXISTS " + 
						"(SELECT * FROM Bids b2 WHERE b1.itemID = b2.itemID AND b1.amount < b2.amount) GROUP BY Items.category";
				else if(query.equals("Earnings by user"))
					checkStats = "SELECT Users.username AS category, SUM(b1.amount) AS earnings FROM Bids b1, Users WHERE b1.buyerID = Users.userID AND NOT EXISTS " +
						"(SELECT * FROM Bids b2 WHERE b1.itemID = b2.itemID AND b1.amount < b2.amount) GROUP BY Users.userID";
			
				//best in earnings per item, user
				else if(query.equals("Best selling items"))
					checkStats = "SELECT Items.name AS category, SUM(b1.amount) AS earnings FROM Bids b1, Items WHERE b1.itemID = Items.itemID AND NOT EXISTS" +
						"(SELECT * FROM Bids b2 WHERE b1.itemID = b2.itemID AND b1.amount < b2.amount) GROUP BY Items.name ORDER BY SUM(b1.amount) DESC";
				else
					checkStats = "SELECT Users.username AS category, SUM(b1.amount) AS earnings FROM Bids b1, Users WHERE b1.buyerID = Users.userID AND NOT EXISTS " + 
						"(SELECT * FROM Bids b2 WHERE b1.itemID = b2.itemID AND b1.amount < b2.amount) GROUP BY Users.userID ORDER BY SUM(b1.amount) DESC";
			}
			ResultSet result = stmt.executeQuery(checkStats);
			
			if(type == 0) {
				result.next();
				out.print("Total earnings: $" + result.getString("earnings"));
			}
			else {
%>
				<table>
				<tr>
					<th>Category</th>
					<th>Earnings</th>
				</tr>
<%
				while(result.next()) {
%>
					<tr>
						<td><%=result.getString("category")%></td>
						<td><%=result.getString("earnings")%></td>
					</tr>
<%
				}
%>
				</table>
<%
			}
		
			con.close();		

		} catch (Exception ex) {
			out.print(ex);
	}
}
%>

<br>
	<form method="post" action="home.jsp">
		<input type="submit" value="return to home page">
	</form>
<br>
</body>

</html>
