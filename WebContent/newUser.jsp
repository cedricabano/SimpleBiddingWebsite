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
		
		//Get parameters from the HTML form at the register.jsp
		String newUsername = request.getParameter("username");
		String newPassword = request.getParameter("password");
		String confirmPW = request.getParameter("confirmPW");
		String email = request.getParameter("email");
		String name = request.getParameter("name");
		String address = request.getParameter("address");
		String state = request.getParameter("state");
		String country = request.getParameter("country");
		String zip = request.getParameter("zip");
		String phone = request.getParameter("phone");
		String permission = request.getParameter("permission");
		
		if(!newPassword.equals(confirmPW)){
			//passwords do not match
		}
		
		String checkUsername="SELECT username FROM Users "
				+ "WHERE username = \""+ newUsername +"\"";
		ResultSet result = stmt.executeQuery(checkUsername);
		
		//if user does not exist
		if(!result.next() && request.getParameter("username") != null){

			//Populate SQL statement with an actual query. It returns a single number. The number of users in the DB.
			String str = "SELECT COUNT(*) as cnt FROM Users";
	
			//Run the query against the DB
			result = stmt.executeQuery(str);
	
			//Start parsing out the result of the query. Don't forget this statement. It opens up the result set.
			result.next();
			//Parse out the result of the query
			int userCount = result.getInt("cnt")+1;
	
			//Make an insert statement for the Sells table:
			String insert = "INSERT INTO Users(userID,username,password,email,name,phoneNumber,address,state,country,zip,permission,isActive)"
					+ "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
			//Create a Prepared SQL statement allowing you to introduce the parameters of the query
			PreparedStatement ps = con.prepareStatement(insert);
	
			//Add parameters of the query. Start with 1, the 0-parameter is the INSERT statement itself
			ps.setInt(1, userCount);
			ps.setString(2, newUsername);
			ps.setString(3, newPassword);
			ps.setString(4, email);
			ps.setString(5, name);
			ps.setString(6, phone);
			ps.setString(7, address);
			ps.setString(8, state);
			ps.setString(9, country);
			ps.setString(10, zip);
			ps.setString(11, permission);
			ps.setBoolean(12, true);
			
			//Run the query against the DB
			ps.executeUpdate();
		}
		else {
		%>
		
		<script>
		alert("Username already in use");
		window.location = "register.jsp";
		</script>
		
		<% 
		}
		
		//Close the connection. Don't forget to do it, otherwise you're keeping the resources of the server allocated.
		con.close();

	} catch (Exception ex) {
		out.print(ex);
		out.print("insert failed");
	}
%>

<p> Thank you for registering. </p>
<br>
	<form method="post" action="index.jsp">
		<input type="submit" value="return to login">
	</form>
<br>
</body>

</html>
