<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Register</title>
</head>
<body>
	<%
	try {

		//Get the database connection
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();

		//Create a SQL statement
		Statement stmt = con.createStatement();
		
		//Get parameters from the HTML form at the register.jsp
		int senderID = Integer.parseInt(request.getParameter("sender"));
		String receiverName = request.getParameter("receiver");
		String message = request.getParameter("message");
		
		//get receiverID from receiver username
		Statement stmt2 = con.createStatement();
		String getReceiverID = "SELECT userID FROM Users WHERE username=\""+receiverName+"\"";
		int receiverID = 0;
		ResultSet rs = stmt.executeQuery(getReceiverID);
		if(rs.next()){
			receiverID = rs.getInt("userID");	
		}
		else{
			response.sendRedirect("error.jsp");
		}
		
		long h = System.currentTimeMillis();
		java.sql.Timestamp time = new java.sql.Timestamp(h);
		
		//Make an insert statement for the Sells table:
		String insert = "INSERT INTO Messages(senderID,receiverID,message,time)"
				+ "VALUES (?, ?, ?, ?)";
		//Create a Prepared SQL statement allowing you to introduce the parameters of the query
		PreparedStatement ps = con.prepareStatement(insert);

		//Add parameters of the query. Start with 1, the 0-parameter is the INSERT statement itself
		ps.setInt(1, senderID);
		ps.setInt(2, receiverID);
		ps.setString(3, message);
		ps.setTimestamp(4, time);
		
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
