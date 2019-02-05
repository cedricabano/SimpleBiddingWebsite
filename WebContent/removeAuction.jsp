<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<jsp:include page="head.jsp"></jsp:include>

<body>

<header>
	<div class="banner">
    	<h1 style="font-size: 60px"><a id="banner_home" href="home.jsp">BuyMe</a></h1>
	</div>
</header>

<%
	if ((Integer)session.getAttribute("user") == null) {
%>
	You are not logged in.
	<br />
	<a href="index.jsp">Please Login</a>
<%
	}
	//we need to check to see if the user is a user, admin, or customer rep
	else if(Integer.parseInt(session.getAttribute("permissions").toString()) == 0) {
%>
		You do not have permission to view this page.
		<br/>
		<a href="home.jsp">Return to home page</a>
<%
	}
	else {
%>
		<section class="container">
		    <div class="login">
				<h1>Enter itemID to delete auction.</h1>
				<form method="post" action="removeAuctionDelete.jsp">
					<p><input type="text" name="itemID" value="" placeholder="itemID"></p>
					<p class="submit"><input type="submit" value="Submit"></p>
				</form>
			</div>
		</section>
<%
	}
%>
</body>
</html>