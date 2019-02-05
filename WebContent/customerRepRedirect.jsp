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
	You are not logged in
	<br />
	<a href="index.jsp">Please Login</a>
<%
	}
	//we need to check to see if the user is a user, admin, or customer rep
	else if((Integer)session.getAttribute("permissions") == 0) {
%>
		You do not have permission to view this page.
		<br/>
		<a href="home.jsp">Return to home page</a>
<%
	}
	else {
		String type = request.getParameter("function");
		if(type.equals("Modify user information"))
			response.sendRedirect("editUser.jsp");
		else if(type.equals("Delete illegal bids"))
			response.sendRedirect("removeBid.jsp");
		else
			response.sendRedirect("removeAuction.jsp");
	}
%>
</body>
</html>