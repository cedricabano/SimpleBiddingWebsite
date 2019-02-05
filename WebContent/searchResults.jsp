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
}
</style>

<p>Make a bid here.</p>
<form method="post" action=bid.jsp>
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

	<p>Please press enter to bid! <input type="submit"></p>

</form>
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
	ApplicationDB db = new ApplicationDB();
	Connection con = db.getConnection();
	Statement stmt = con.createStatement();

	String itemID = request.getParameter("itemID");
	String itemName = request.getParameter("itemName");
	String category = request.getParameter("category");
	String cond = request.getParameter("condition");
	String brand = request.getParameter("brand");
	String metal = request.getParameter("metal");
	String stone = request.getParameter("stone");
	String color = request.getParameter("color");
	String minPrice = request.getParameter("minPrice");
	String maxPrice = request.getParameter("maxPrice");

	String[] colNames = new String[]{"name","category","cond","brand","metal","stone","color","minPrice","maxPrice"};
	String[] userInputs = new String[]{itemName,category,cond,brand,metal,stone,color,minPrice,maxPrice};

	String search = "";

	if(!itemID.isEmpty()){
		search = "SELECT * FROM Items "
				+ "WHERE itemID = \""+itemID+"\"";
	}
	else{
		search = "SELECT * FROM Items WHERE ";
		
		int numCriterias = 0;
		//creates query string
		for(int i=0;i<7;i++){
			if(!userInputs[i].isEmpty()){
				search = search + colNames[i]+"=\""+userInputs[i]+"\" AND ";
				numCriterias++;
			}
		}
		
		//get rid of last "AND"
		if(numCriterias>0){
			search = search.substring(0, search.length() - 5);
		}
		else{
			search = search.substring(0, search.length() - 7);
		}
		
		//if price ranges are indicated
		/*
		if(!minPrice.isEmpty()){
			search = search + " AND " + "";
		}
		if(!maxPrice.isEmpty()){
			
		}
		*/
	}

	Statement stmt3 = con.createStatement();
	ResultSet result = stmt.executeQuery(search);
	String getCurrentPrice = "";
			
	while (result.next()) {
		
		int _itemID = result.getInt("itemID");
		
		getCurrentPrice = "SELECT MAX(amount) FROM Bids WHERE itemID = \"";
		getCurrentPrice = getCurrentPrice + _itemID + "\"";
		
		java.sql.Timestamp time = new java.sql.Timestamp(System.currentTimeMillis());
		if (result.getTimestamp("endTime").compareTo(time) >= 0) {
			
			ResultSet currentPrice = stmt3.executeQuery(getCurrentPrice);
			float price;
			
			if(currentPrice.next() && currentPrice.getFloat(1)!=0){
				price = currentPrice.getFloat(1);
			}
			else{
				price = result.getFloat("startingBid");
			}
			
			System.out.println("item name: "+result.getString("name")+" price: "+price);
			if(!minPrice.isEmpty() && Float.parseFloat(minPrice)>price){
				continue;
			}
			if(!maxPrice.isEmpty() && Float.parseFloat(maxPrice)<price){
				continue;
			}
			
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

%>

</body>
</html>