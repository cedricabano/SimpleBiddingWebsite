<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<jsp:include page="head.jsp"></jsp:include>
<body>
<style>
	table{
		border:1px solid black;
		padding:2px;
		background-color: white;
		width:100%;
	}
	th, td {
		border: 1px solid black;
		padding: 2px;
	}
</style>

<%
	if ((session.getAttribute("user") == null)) {
%>
	You are not logged in
	<br />
	<a href="index.jsp">Please Login</a>
<%
	}
	//we need to check to see if the user is a user, admin, or customer rep
	else{
%>

Welcome
<%=session.getAttribute("user")%>

<p><a href='home.jsp'>Go Back</a>

<%
	if ((session.getAttribute("user") != null)) {
		int u = Integer.parseInt(session.getAttribute("userID").toString());
		ApplicationDB db = new ApplicationDB();
		Connection con = db.getConnection();

		//Create a SQL statement
		Statement stmt = con.createStatement();

		String items = String.format("select * from Items");

		ResultSet result = stmt.executeQuery(items);
%>

<div class="container2">
<p>Make a bid here.</p>
	<form method="post" action="makeBid.jsp">
	<div>
		<p>Enter Item ID here: <input type="number" name="itemID" required></p>
	</div>


	<div>
	<p>
		Enter whether you want automatic bidding or not: <select
			name="automatic" required>
			<option value="0">Non-automatic bidding</option>
			<option value="1">automatic bidding</option>
		</select>
	</p>
	</div>

	<div>
	<p>
		Enter bidding amount here: <input type="number" name="amount"
			required>
	</p>
	</div>

	<p> <input type="submit" value="Make a Bid!" width="30%"> </p>
	</form>
	
	view history of an items bids here.
	<form method="post" action="viewBids.jsp">
		<div>
			Enter Item ID here: <input type="number" name="itemID" required>
			<input style="width:20%;" type="submit" value="View History">
		</div>
	</form>
	
	<br></br>
	
	<div>
	<form method="post" action="sortedResults.jsp">
	Sort By:
	<select name="column">
		<option value="itemID">Item ID</option>
		<option value="name">Name</option>
		<option value="category">Category</option>
		<option value="cond">Condition</option>
		<option value="brand">Brand</option>
		<option value="metal">Metal</option>
		<option value="stone">Stone</option>
		<option value="color">Color</option>
		<option value="startingBid">Starting Bid</option>
	</select>
	<input type="radio" name="sortOption" value="Ascending" checked>Ascending
	<input type="radio" name="sortOption" value="Descending">Descending
	<input id="sort_btn" type="submit" value="sort">
	</form>
	</div>
	</div>
	
	<br></br>

	<table id="fixedheight">
		<tr>
			<td> itemID </td>
			<td> item name </td>
			<td> category </td>
			<td> condition </td>
			<td> brand </td>
			<td> metal </td>
			<td> stone </td>
			<td> color </td>
			<td> starting bid </td>
			<td> increment </td>
			<td> end time </td>
			<td> current bid </td>
			
	<% 
		while (result.next()) {

			java.sql.Timestamp time = new java.sql.Timestamp(System.currentTimeMillis());
			if (result.getTimestamp("endTime").compareTo(time) >= 0) {
				out.print("<tr>");

				out.print("<td>");
				out.print(result.getInt("itemID"));
				out.print("</td>");

				out.print("<td>");
				out.print(result.getString("name"));
				out.print("</td>");

				out.print("<td>");
				out.print(result.getString("category"));
				out.print("</td>");

				out.print("<td>");
				out.print(result.getString("cond"));
				out.print("</td>");

				out.print("<td>");
				out.print(result.getString("brand"));
				out.print("</td>");

				out.print("<td>");
				out.print(result.getString("metal"));
				out.print("</td>");

				out.print("<td>");
				out.print(result.getString("stone"));
				out.print("</td>");

				out.print("<td>");
				out.print(result.getString("color"));
				out.print("</td>");

				out.print("<td>");
				out.print(result.getFloat("startingBid"));
				out.print("</td>");

				out.print("<td>");
				out.print(result.getFloat("increment"));
				out.print("</td>");

				out.print("<td>");
				out.print(result.getTimestamp("endTime"));
				out.print("</td>");

				Statement stmt2 = con.createStatement();
				String bids2 = String.format("select * from Bids where itemID = '%d' AND amount= (SELECT max(amount) FROM Bids where itemID = '%d')",
						result.getInt("itemID"), result.getInt("itemID"));
				ResultSet result2 = stmt2.executeQuery(bids2);

				if (result2.next()) {
					out.print("<td>");
					out.print(result2.getFloat("amount"));
					out.print("</td>");
				}
				else{
					out.print("<td>");
					out.print("no current bids");
					out.print("</td>");
				}
				out.print("</tr>");
			}
		}
		out.print("</table>");
		con.close();
	} else {
%>
You are not logged in
<br />
<a href="login.jsp">Please Login</a>

<%
	}
}
%>

</body>
</html>