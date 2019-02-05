<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

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
	You are not logged in
	<br />
	<a href="index.jsp">Please Login</a>
<%
	}
	//we need to check to see if the user is a user, admin, or customer rep
	else{
%>

<p><a href='home.jsp'>Go Back</a>
<section class="container">
    <div class="register">
      <h1>Compose new message</h1>
      <form method="post" action="newMessage.jsp">
      	<p><label for="receiver" class="register_labels"> *To: (enter receiver's username) </label></p>
        <p><input id="receiver" type="text" name="receiver" required="required" value=""></p>
        
        <p>Description : </p>
        <textarea id="messageBox" rows = "10" name = "message" required></textarea>
        
        <input type="hidden" type="text" name="sender" value="<%out.print(session.getAttribute("userID"));%>">
        
        <p class="submit"><input type="submit" value="Submit"></p>
      </form>
      
    </div>
</section>
<%} %>
</body>
</html>