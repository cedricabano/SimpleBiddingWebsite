<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<jsp:include page="head.jsp"></jsp:include>
<body>
	<%
	try {

		//Get the database connection
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();

		//Create a SQL statement
		Statement stmt = con.createStatement();
		
		int user = Integer.parseInt(session.getAttribute("userID").toString());
		
		String category = request.getParameter("category");
		String cond = request.getParameter("cond");
		String brand = request.getParameter("brand");
		String metal = request.getParameter("metal");
		String stone = request.getParameter("stone");
		String color = request.getParameter("color");
		
		String insert = "INSERT INTO Alerts(userID,category,cond,brand,metal,stone,color)"
				+ "VALUES (?, ?, ?, ?, ?, ?, ?)";
		PreparedStatement ps = con.prepareStatement(insert);
		ps.setInt(1, user);
		ps.setString(2, category);
		ps.setString(3, cond);
		ps.setString(4, brand);
		ps.setString(5, metal);
		ps.setString(6, stone);
		ps.setString(7, color);
		
		//Run the query against the DB
		ps.executeUpdate();
		
		//Close the connection. Don't forget to do it, otherwise you're keeping the resources of the server allocated.
		con.close();

		} catch (Exception ex) {
			out.print(ex);
			out.print("insert failed");
		}
%>
<br>
	<form method="post" action="home.jsp">
		<input type="submit" value="return to home">
	</form>
<br>
</body>

</html>
