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
      <h1>Set an Alert</h1>
      <form method="post" action="newAlert.jsp">
      
      <p>Category:</p>
		<select name="category">
			<option value="Ring">Ring</option>
			<option value="Necklace">Necklace</option>
			<option value="Watch">Watch</option>
		</select>
        
        <p><label for="cond" class="register_labels"> Condition </label></p>
        <p><input id="cond" type="text" name="cond" value=""></p>
        
        <p><label for="brand" class="register_labels"> Brand </label></p>
        <p><input id="brand" type="text" name="brand" value=""></p>
        
        <p><label for="metal" class="register_labels"> Metal </label></p>
        <p><input id="metal" type="text" name="metal" value="" ></p>
        
        <p><label for="stone" class="register_labels"> Stone </label></p>
        <p><input id="stone" type="text" name="stone" value=""></p>
        
        <p><label for="color" class="register_labels"> Color </label></p>
        <p><input id="color" type="text" name="color" value=""></p>
        
        <p class="submit"><input type="submit" value="Set Alert"></p>
      </form>
      
    </div>
</section>
</body>
</html>