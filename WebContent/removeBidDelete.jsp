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
<jsp:include page="head.jsp"></jsp:include>

<body>

<header>
	<div class="banner">
    	<h1 style="font-size: 60px"><a id="banner_home" href="home.jsp">BuyMe</a></h1>
	</div>
</header>

<%
	if ((session.getAttribute("user") == null)) {
%>
	You are not logged in.
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
		try {
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();
	
			Statement stmt = con.createStatement();
	
			String bidID = request.getParameter("bidID");

			String deleteBid = "DELETE FROM Bids "
						+ "WHERE bidId = \""+ bidID + "\"";
			ResultSet result = stmt.executeQuery(deleteBid);
			con.close();
			
%>
			Delete successful!
<%
			response.sendRedirect("home.jsp");
	
		} catch (Exception ex) {
			out.print(ex);
			out.print("delete failed");
		}
	}
%>

</body>
</html>