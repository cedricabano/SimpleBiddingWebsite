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
	
			//Get parameters from the HTML form at the index.jsp

			String username = request.getParameter("username");
			String actualPassword = request.getParameter("password");
			 
			//checks if username or emails matches.
			//var username could count as email if that is what user inputted
			String checkUsername="SELECT * FROM Users "
					+ "WHERE username = \""+ username +"\" OR email = \""+ username +"\"";
			ResultSet result = stmt.executeQuery(checkUsername);
			
			//if there's an existing user
			if(result.next()){
				//returns curser to front of resultset
				//result.beforeFirst();
				String expectedPassword = result.getString("password");
				
				//if password does not match
				if(!expectedPassword.equals(actualPassword) || result.getInt("isActive")==0){
					session.setAttribute("wrongPasswordFlag","true");
					response.sendRedirect("index.jsp");
				}
					
				session.setAttribute("userID", result.getInt("userID")); // the username will be stored in the session
				session.setAttribute("user", username); // the username will be stored in the session
				int temp = result.getInt("permission");
				session.setAttribute("permissions", temp);
		        response.sendRedirect("home.jsp");
			}
			//if username does not match
			else{
				response.sendRedirect("index.jsp");
			}
	
			
			//Close the connection. Don't forget to do it, otherwise you're keeping the resources of the server allocated.
			con.close();
	
		} catch (Exception ex) {
			out.print(ex);
			out.print("login failed");
		}
	%>

Login successful
</body>
</html>