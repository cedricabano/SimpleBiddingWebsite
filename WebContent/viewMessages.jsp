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

<p><a href="home.jsp">Go back</a></p>

<%
	if ((session.getAttribute("user") != null)) {
		int u = Integer.parseInt(session.getAttribute("userID").toString());
		ApplicationDB db = new ApplicationDB();
		Connection con = db.getConnection();

		//Create a SQL statement
		Statement stmt = con.createStatement();

		int self = Integer.parseInt(session.getAttribute("userID").toString());
		String allMessages = String.format("SELECT * from Messages WHERE receiverID=\""+self+"\"");

		ResultSet result = stmt.executeQuery(allMessages);
%>

<div class="container2">	
<br></br>
	</div>
	<table style="table-layout: fixed; width=100%">
		<col width="10%">
		<col width="20%">
		<col width="70%">
		<tr>
			<td> Sender </td>
			<td> Time </td>
			<td> Message </td>
	<% 
	
		Statement stmt2 = con.createStatement();
		String getSenderName = "";
		while (result.next()) {
			
			//get sender username
			getSenderName = String.format("SELECT username from Users WHERE userID=\""
				+result.getInt("senderID")+"\"");
			ResultSet sender = stmt2.executeQuery(getSenderName);
			sender.next();
			
			out.print("<tr>");

			out.print("<td>");
			out.print(sender.getString("username"));
			out.print("</td>");

			out.print("<td>");
			out.print(result.getTimestamp("time"));
			out.print("</td>");

			out.print("<td style=\"word-wrap: break-word\">");
			out.print(result.getString("message"));
			out.print("</td>");

			out.print("</tr>");
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