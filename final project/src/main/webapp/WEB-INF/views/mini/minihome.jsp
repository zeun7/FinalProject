<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<html>
<head>
<title>미니홈피</title>
<jsp:include page="../css.jsp"></jsp:include>
</head>
<body>
	<jsp:include page="../top_menu.jsp"></jsp:include>
	<jsp:include page="mini_top_menu.jsp"></jsp:include>
	<h1>mini/minihome.jsp</h1>
	<div
		style="background-image: url('resources/uploadimg/${mh_attr.backimg}'); background-size: cover; width: 100%; height: 100vh;">
		<h1>미니홈피 제목 : ${mh_attr.title}</h1>
	</div>
</body>
</html>