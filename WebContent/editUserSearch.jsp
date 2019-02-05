<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">



<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Edit User Info</title>
</head>
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
	else if((Integer)session.getAttribute("permissions") == 0) {
%>
		You do not have permission to view this page.
		<br/>
		<a href="home.jsp">Return to home page</a>
<%
	}
	else {
		try {
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();
	
			Statement stmt = con.createStatement();
	
			String userID = request.getParameter("userID");

			String checkUserID = "SELECT * FROM Users "
						+ "WHERE userID = \""+ userID + "\"";
			ResultSet result = stmt.executeQuery(checkUserID);
			
			if(result.next()) {
				if(!result.getString("permission").equals("0")) {
%>
					<script>
						alert("Account cannot be edited");
						window.location = "editUser.jsp";
					</script>
<%				
				}
				else {
				//format text boxes with selected user data
%>	
				<p>User found</p>
				<form method="post" action="editUserUpdate.jsp">
    			  	<p><label for="username" class="register_labels"> Username </label></p>
    			    <p><input id="username" type="text" name="username" value="" placeholder=<%=result.getString("username")%>></p>
        
					<p><label for="password" class="register_labels"> Password </label></p>
					<p><input id="password" type="password" name="password" placeholder=<%=request.getParameter("password")%>></p>
                
					<p><label for="name" class="register_labels"> Name </label></p>
					<p><input id="name" type="text" name="name" value="" placeholder=<%=result.getString("name")%>></p>
        
					<p><label for="email" class="register_labels"> Email </label></p>
					<p><input id="email" type="email" name="email" value="" placeholder=<%=result.getString("email")%>></p>
        
					<p><label for="address" class="register_labels"> Address </label></p>
					<p><input id="address" type="text" name="address" value="" placeholder=<%=result.getString("address")%>></p>
        
					<p><label for="state" class="register_labels"> State </label></p>
					<p><input id="state" type="text" name="state" value="" placeholder=<%=result.getString("state")%>></p>
        
					<p><label for="country" class="register_labels"> Country </label></p>
					<p><input id="country" type="text" name="country" value="" placeholder=<%=result.getString("country")%>></p>
        
					<p><label for="zip" class="register_labels"> Zip Code </label></p>
					<p><input id="zip" type="text" name="zip" value="" placeholder=<%=result.getString("zip")%> max="5"></p>
        
					<p><label for="phone" class="register_labels"> Phone </label></p>
					<p><input id="phone" type="tel" name="phone" value="" placeholder=<%=result.getString("phoneNumber")%>></p>
        
					<input type="hidden" type="number" name="userID" value=<%=userID %>> </input>
        
					<p class="submit"><input type="submit" value="Submit"></p>
				</form>
<%
				}
			}	
			else {
%>
				<script>
					alert("UserID does not exist");
					window.location = "editUser.jsp";
				</script>
<%
			}
	
			con.close();
	
		} catch (Exception ex) {
			out.print(ex);
			out.print("login failed");
		}
	}
%>

</body>
</html>