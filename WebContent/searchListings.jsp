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
      <h1>Search for an item</h1>
      <form method="post" action="searchResults.jsp">
      	<p><label for="itemID" class="register_labels"> ItemID, if looking for a specific item </label></p>
        <p><input id="itemID" type="text" pattern="[0-9]*" name="itemID" value=""></p>
        
        <p><label for="itemName" class="register_labels"> Item Name</label></p>
        <p><input id="itemName" type="text" name="itemName" value=""></p>
        
        <p><label for="category" class="register_labels"> Category </label></p>
        <p><input id="category" type="text" name="category" value=""></p>
        
        <p><label for="condition" class="register_labels"> Condition </label></p>
        <p><input id="condition" type="text" name="condition" value=""></p>
        
        <p><label for="brand" class="register_labels"> Brand </label></p>
        <p><input id="brand" type="text" name="brand" value=""></p>
        
        <p><label for="metal" class="register_labels"> Metal </label></p>
        <p><input id="metal" type="text" name="metal" value=""></p>
        
        <p><label for="stone" class="register_labels"> Stone </label></p>
        <p><input id="stone" type="text" name="stone" value=""></p>
       
        <p><label for="color" class="register_labels"> Color </label></p>
        <p><input id="color" type="text" name="color" value=""></p>
       
        <p><label for="minPrice" class="register_labels"> Bid Minimum </label></p>
        <p><input id="minPrice" type="text" pattern="[0-9]*" name="minPrice" value=""></p>
        
        <p><label for="maxPrice" class="register_labels"> Bid Maximum </label></p>
        <p><input id="maxPrice" type="text" pattern="[0-9]*" name="maxPrice" value=""></p>
       
        <p class="submit"><input type="submit" value="Submit"></p>
      </form>
      
    </div>
</section>
</body>
</html>