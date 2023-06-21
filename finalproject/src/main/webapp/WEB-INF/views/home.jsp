<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Home</title>
<jsp:include page="css.jsp"></jsp:include>
</head>
<body>
	<jsp:include page="top_menu.jsp"></jsp:include>
	<h1>Hello world! ${user_id}</h1>
	<h1>${message}</h1>

	<P>The time on the server is ${serverTime}.</P>
</body>
</html>
