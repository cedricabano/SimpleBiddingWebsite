<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<jsp:include page="head.jsp"></jsp:include>

<body>

<header>
<div class="banner">
	<h1 style="font-size: 60px">
		<a id="banner_home" href="home.jsp">BuyMe</a>
	</h1>
</div>
</header>

<%
	try{
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();
		Statement stmt = con.createStatement();
		
		int userID = Integer.parseInt(session.getAttribute("userID").toString());
		
		String delAcc = "UPDATE cs336db.Users SET isActive='0' WHERE userID = \"" + userID + "\"";
		PreparedStatement ps = con.prepareStatement(delAcc);
		
		if(ps.executeUpdate()>0){
			%>
			<p>Account deleted</p>
			<a href='home.jsp'>Return to home</a>
			<% 
		}
		
		
	}catch(Exception e){
		out.print(e);
		out.print("delete user failed");
	}

%>

</body>
</html>