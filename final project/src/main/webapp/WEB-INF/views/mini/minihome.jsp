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
	<jsp:include page="../mini_top_menu.jsp"></jsp:include>
	<h1>mini/minihome.jsp</h1>
	<div
		style="background-image: url('resources/uploadimg/${vo2.backimg}'); background-size: cover; width: 100%; height: 100vh;">
		<div>${vo2.title}</div>
		<div>${vo2.message}</div>
		<div>
			<audio controls autoplay>
				<source src="resources/uploadbgm/${vo2.bgm}" type="audio/mp3">
			</audio>
		</div>
		<div>vtoday : ${vo2.vtoday}</div>
		<div>vtotal : ${vo2.vtotal}</div>
	</div>
	<iframe src="mini/diary/selectAll.jsp" style="width: 100%; height: 100vh; border: none;"></iframe>
</body>
</html>