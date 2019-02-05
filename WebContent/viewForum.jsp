<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<jsp:include page="head.jsp"></jsp:include>
<body>
<style>
	table{
		border:1px solid black;
		padding:2px;
		background-color: white;
		width:100%;
	}
	th, td {
		border: 1px solid black;
		padding: 2px;
	}
</style>

<%
	if ((session.getAttribute("user") == null)) {
%>
	You are not logged in
	<br />
	<a href="index.jsp">Please Login</a>
<%
	}
	//we need to check to see if the user is a user, admin, or customer rep
	else{
%>

Welcome
<%=session.getAttribute("user")%>

<p><a href='home.jsp'>Back</a>

<%
	if ((session.getAttribute("user") != null)) {
		int u = Integer.parseInt(session.getAttribute("userID").toString());
		ApplicationDB db = new ApplicationDB();
		Connection con = db.getConnection();

		//Create a SQL statement
		Statement stmt = con.createStatement();

		String items = String.format("select * from ForumPosts ORDER BY postID DESC");

		ResultSet result = stmt.executeQuery(items);
%>
<div>
	<form action="searchedForums.jsp">
		<p><label for="searchStr" class="register_labels"> Search for words: </label></p>
        <p><input id="searchStr" type="text" name="searchStr" value="" >
        <input style="width:25%;" type="submit" value="Search Forum"></p>
	</form>
</div>


<div class="container2">
	<form method="post" action="makePost.jsp">
		<p> <input type="submit" value="Post to forum"> </p>
	</form>
			
	<% 
		int currentPostID;
		//while there's a post
		while (result.next()){

			//if the current result is an original post
			if(result.getInt("inReplyTo")==-1){
				%>
				<div class="postDiv" style="border-bottom:1px solid black;">
					<h1 class="posterName">
						<%out.print(result.getString("postername")+": "); %>
					</h1>
					<p class="postText"><%out.print(result.getString("message")); %></p>
						<% 
						currentPostID = result.getInt("postID");
						
						Statement stmt2 = con.createStatement();
						String bids2 = "SELECT * FROM ForumPosts WHERE inReplyTo=\""+currentPostID+"\"";
						ResultSet result2 = stmt2.executeQuery(bids2);
						
						while(result2.next()){
							%>
							<div class="postReplies" style="margin-left:30px;">
							
							<h3 class="posterName">
							<%out.print(result2.getString("postername")+": "); %>
							</h3>
							<p class="postText"><%out.print(result2.getString("message")); %></p>
		
							</div>
							<%
						}
						%>
						<form action='newReply.jsp'>
							<textarea rows = "3" name = "reply"></textarea>
							<input type="hidden" type="text" name="replyToID" value="<%out.print(result.getInt("postID"));%>">
							<input type="hidden" type="text" name="posterID" value="<%out.print(session.getAttribute("userID"));%>">
       					    <input type="hidden" type="text" name="posterName" value="<%out.print(session.getAttribute("user"));%>">
							<input style="width:25%;" type="submit" value="Post reply">
						</form>
						<%
						%>
				</div>
				
				<% 
				
				
					
					
				}
			}
	
		out.print("</table>");
		con.close();
	} else {
%>
You are not logged in
<br />
<a href="login.jsp">Please Login</a>

<%
	}
}
%>

</body>
</html>