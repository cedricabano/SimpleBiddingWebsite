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

<section class="container">
    <div class="login">
      <h1>Login</h1>
      <form method="post" action="login.jsp">
      <%
      if(session.getAttribute("wrongPasswordFlag") != null){
    	  out.println("<p>Incorrect username or password</p>");
      }
      %>
        <p><input type="text" name="username" value="" placeholder="Username or Email"></p>
        <p><input type="password" name="password" value="" placeholder="Password"></p>
        
        <p class="submit"><input type="submit" value="Submit"></p>
      </form>
      
      <p><a id="register" href="register.jsp">Don't have an account? Register</a></p>	
    </div>
</section>
</body>
</html>