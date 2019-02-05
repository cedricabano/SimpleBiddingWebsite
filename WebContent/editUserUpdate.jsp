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
			
			String updateUserInfo = "UPDATE Users SET ";
			
			if(request.getParameter("username").length() != 0) {
				updateUserInfo += "username = \"" + request.getParameter("username") + "\",";
			}
			
			if(request.getParameter("password").length() != 0) {
				updateUserInfo += "password = \"" + request.getParameter("password") + "\",";
			}
			
			if(request.getParameter("name").length() != 0) {
				updateUserInfo += "name = \"" + request.getParameter("name") + "\",";
			}
			
			if(request.getParameter("email").length() != 0) {
				updateUserInfo += "email = \"" + request.getParameter("email") + "\",";
			}

			if(request.getParameter("address").length() != 0) {
				updateUserInfo += "address = \"" + request.getParameter("address") + "\",";
			}

			if(request.getParameter("state").length() != 0) {
				updateUserInfo += "state = \"" + request.getParameter("state") + "\",";
			}

			if(request.getParameter("country").length() != 0) {
				updateUserInfo += "country = \"" + request.getParameter("country") + "\",";
			}

			if(request.getParameter("zip").length() != 0) {
				updateUserInfo += "zip = \"" + request.getParameter("zip") + "\",";
			}

			if(request.getParameter("phone").length() != 0) {
				updateUserInfo += "phoneNumber = \"" + request.getParameter("phone") + "\",";
			}
			
			updateUserInfo = updateUserInfo.substring(0, updateUserInfo.length() - 1) + " ";
			updateUserInfo += "WHERE userID = " + request.getParameter("userID");

			stmt.executeUpdate(updateUserInfo);
			con.close();
%>
			Update successful!
			

			<form method="post" action="home.jsp">
	        
		        <p class="submit"><input type="submit" value="Return to home"></p>
	    	</form>
<%			
		} catch (Exception ex) {
			out.print(ex);
			out.print("Update failed");
		}
	}
%>
</body>
</html>