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
<title>Search</title>
<link type="text/css" rel="stylesheet" href="styles.css">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">

</head>
<h2 class="text-light">User: <%= session.getAttribute("username") %></h2>
<h2 class="text-light">Status: <%= session.getAttribute("message") %></h2>
<body>
<h1 class="text-light">User search page</h1>
<form action="searchUserResults.jsp" class="text-light">
Enter Username to search : <input type="text" name="searchname">
<input type="submit" value="Search">
</form>
</body>
</html>