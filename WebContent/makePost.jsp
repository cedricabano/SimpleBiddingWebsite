<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<jsp:include page="head.jsp"></jsp:include>

<body>

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

<section class="container">
    <div class="register">
      <h1>Compose new post</h1>
      <form method="post" action="newPost.jsp">
        
        <p>Text: </p>
        <textarea id="messageBox" rows = "10" name = "message" required></textarea>
        
        <input type="hidden" type="text" name="posterID" value="<%out.print(session.getAttribute("userID"));%>">
        <input type="hidden" type="text" name="posterName" value="<%out.print(session.getAttribute("user"));%>">
        
        <p class="submit"><input type="submit" value="Post"></p>
      </form>
      
    </div>
</section>

<%} %>
</body>
</html>