<%@page import="java.util.Iterator"%>
<%@page import="com.training.ers.model.User"%>
<%@page import="java.util.List"%>
<%@page import="com.training.ers.dao.LoginDAOImpl"%>
<%@page import="com.training.ers.dao.LoginDAO"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Display</title>
<link type="text/css" rel="stylesheet" href="styles.css">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
</head>
<h2 class="text-light">User: <%= session.getAttribute("username") %></h2>
<h2 class="text-light">Status: <%= session.getAttribute("message") %></h2>
<body>
	<%
	LoginDAO loginDAO = new LoginDAOImpl();
	List<User> users = loginDAO.getUsers("User");
	Iterator<User> iterator = users.iterator();
	
	%>
	<h1 class="text-light">List of all the users</h1>
	<table class="table table-dark">
	<th>User Id</th><th>First Name</th><th>Last Name</th><th>Email</th><th>Password</th><th>Account Type</th><th>Active</th>
	
	<%
	//out.println(users);
	while(iterator.hasNext()) {
		User user = iterator.next();
		//out.println(user);
	%>
		<tr>
		<td><%= user.getUserId() %></td>
		<td><%= user.getFirstName() %></td>
		<td><%= user.getLastName() %></td>
		<td><%= user.getEmail() %></td>
		<td><%= user.getPassword() %></td>
		<td><%= user.getAccountType() %></td>
		<td><%= user.isActive() %></td>
		
		
		
		</tr>
		
	<%
	}
	%>
	
	</table>
	
	<button class="btn btn-primary" onclick="location.href='LoginController'">Back</button>
	<!-- <input type="button" value="Back" onclick="window.location.href='<\% Url.Action("actionName", "controllerName") %>';" />
	 -->
	
</body>
</html>