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
	Welcome
	<%=session.getAttribute("user")%>
	<%

		if ((session.getAttribute("user") != null)) {
			int u = Integer.parseInt(session.getAttribute("userID").toString());
			ApplicationDB db = new ApplicationDB();
			Connection con = db.getConnection();

			//Create a SQL statement
			Statement stmt = con.createStatement();
			
			String torun = String.format("SELECT * FROM Items");
			
			ResultSet result = stmt.executeQuery(torun);
			
			out.print("<table id=\"fixedheight\">");
			out.print("<tr>");

			out.print("<td>");
			out.print("itemID");
			out.print("</td>");

			out.print("<td>");
			out.print("name of Item");
			out.print("</td>");

			out.print("<td>");
			out.print("category");
			out.print("</td>");

			out.print("<td>");
			out.print("condition");
			out.print("</td>");

			out.print("<td>");
			out.print("brand");
			out.print("</td>");

			out.print("<td>");
			out.print("metal");
			out.print("</td>");

			out.print("<td>");
			out.print("stone");
			out.print("</td>");

			out.print("<td>");
			out.print("color");
			out.print("</td>");

			out.print("<td>");
			out.print("startingBid");
			out.print("</td>");

			out.print("<td>");
			out.print("increment by");
			out.print("</td>");

			out.print("<td>");
			out.print("endTime");
			out.print("</td>");
			
			out.print("<td>");
			out.print("ending bid");
			out.print("</td>");
			
			out.print("<td>");
			out.print("Highest Bidder");
			out.print("</td>");
			
			out.print("<td>");
			out.print("Was reserve price met?");
			out.print("</td>");

			out.print("</tr>");

			while (result.next()) {

				java.sql.Timestamp time = new java.sql.Timestamp(System.currentTimeMillis());
				if (result.getTimestamp("endTime").compareTo(time) < 0) {
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
					//System.out.println( result.getInt("itemID"));
					String bids2 = String.format("select * from Bids where itemID = '%d' AND amount= (SELECT max(amount) FROM Bids where itemID = '%d')",
							result.getInt("itemID"), result.getInt("itemID"));
					//System.out.println(bids2);
					//System.out.println(bids2);
					ResultSet result2 = stmt2.executeQuery(bids2);

					if (result2.next()) {
						//System.out.println(result2.getString(1));
						out.print("<td>");
						out.print(result2.getFloat("amount"));
						out.print("</td>");
						
						Statement stmt3 = con.createStatement();
						//System.out.println( result.getInt("itemID"));
						String bids3 = String.format("Select * from Users where userID = '%d'", result2.getInt("buyerID"));
						//System.out.println(bids2);
						//System.out.println(bids2);
						ResultSet result3 = stmt3.executeQuery(bids3);
						if(result3.next()){
							out.print("<td>");
							out.print(result3.getString("username"));
							out.print("</td>");
						}
						
						if(result.getFloat("hiddenMinPrice") <= result2.getFloat("amount")){
							out.print("<td>");
							out.print("yes! congrats highest bidder");
							out.print("</td>");
						}
						else{
							out.print("<td>");
							out.print("no winner. reserve price not met");
							out.print("</td>");
						}
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
	%>