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
    <div class="register">
      <h1>Register</h1>
      <form method="post" action="newUser.jsp">
      	<p><label for="username" class="register_labels"> *Username </label></p>
        <p><input id="username" type="text" name="username" required="required" value="" placeholder="e.g. JohnSmith12"></p>
        
        <p><label for="password" class="register_labels"> *Password </label></p>
        <p><input id="password" type="password" name="password" required="required" value="" placeholder="e.g. password123"></p>
        
        <p><label for="confirmPW" class="register_labels"> *Confirm Password </label></p>
        <p><input id="confirmPW" type="password" name="confirmPW" required="required" value="" placeholder="Confirm Password"></p>
        
        <p><label for="name" class="register_labels"> *Name </label></p>
        <p><input id="name" type="text" name="name" required="required" value="" placeholder="e.g. John Smith"></p>
        
        <p><label for="email" class="register_labels"> *Email </label></p>
        <p><input id="email" type="email" name="email" required="required" value="" placeholder="e.g. xxx@xxx.com"></p>
        
        <p><label for="address" class="register_labels"> Address </label></p>
        <p><input id="address" type="text" name="address" value="" placeholder="e.g. 123 Oak Lane"></p>
        
        <p><label for="state" class="register_labels"> State </label></p>
        <p><input id="state" type="text" name="state" value="" placeholder="e.g. New Jersey"></p>
        
        <p><label for="country" class="register_labels"> Country </label></p>
        <p><input id="country" type="text" name="country" value="" placeholder="e.g. USA"></p>
        
        <p><label for="zip" class="register_labels"> Zip Code </label></p>
        <p><input id="zip" type="text" name="zip" value="" placeholder="e.g. 01234" max="5"></p>
        
        <p><label for="phone" class="register_labels"> Phone </label></p>
        <p><input id="phone" type="tel" name="phone" value="" placeholder="e.g. 123-456-7890"></p>
       
        <input type="hidden" type="number" name="permission" value="0">
        
        <p class="submit"><input type="submit" value="Submit"></p>
      </form>
      
    </div>
</section>
</body>
</html>