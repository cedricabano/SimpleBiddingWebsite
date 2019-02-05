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
		int posterID = Integer.parseInt(request.getParameter("posterID").toString());
		String posterName = request.getParameter("posterName");
		int replyToID = Integer.parseInt(request.getParameter("replyToID").toString());
		String reply = request.getParameter("reply");
		
		long currentTime = System.currentTimeMillis();
		java.sql.Timestamp time = new java.sql.Timestamp(currentTime);
		
		//Make an insert statement for the Sells table:
		String insert = "INSERT INTO ForumPosts(postID,posterID,postername,inReplyTo,message,time)"
				+ "VALUES (?, ?, ?, ?, ?, ?)";
		//Create a Prepared SQL statement allowing you to introduce the parameters of the query
		PreparedStatement ps = con.prepareStatement(insert);

		//Add parameters of the query. Start with 1, the 0-parameter is the INSERT statement itself
		ps.setInt(1, 0);
		ps.setInt(2, posterID);
		ps.setString(3,posterName);
		ps.setInt(4, replyToID);
		ps.setString(5, reply);
		ps.setTimestamp(6,time);
		
		//Run the query against the DB
		ps.executeUpdate();
		
		//Close the connection. Don't forget to do it, otherwise you're keeping the resources of the server allocated.
		con.close();

		} catch (Exception ex) {
			out.print(ex);
			out.print("insert failed");
		}
	
	response.sendRedirect("viewForum.jsp");
%>
<br>
	<form method="post" action="home.jsp">
		<input type="submit" value="return to home">
	</form>
<br>
</body>

</html>
