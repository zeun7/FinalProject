<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page session="false"%>
<html>
<head>
<title>미니홈피</title>
<jsp:include page="../css.jsp"></jsp:include>
</head>
<body>
<jsp:include page="../top_menu.jsp"></jsp:include>
	<h1>mini/minihome.jsp</h1>
	
	<ul>
		<li><a href="mini_update.do?hnum=1">프로필 수정</a></li>
		<li><a href="">최신 게시글</a></li>
		<li><a href="mini_random.do">랜덤 미니홈피 가기</a></li>
	</ul>
	<ul>
		<li><a href="mini_home.do">홈</a></li>
		<li><a href="mini_diary.do">다이어리</a></li>
		<li><a href="mini_visit.do">방명록</a></li>
		<li><a href="mini_gallery.do">갤러리</a></li>
		<li><a href="mini_game.do">게임</a></li>
	</ul>
		<li><a href="home.do">메인페이지</a></li>
	
	
</body>
</html>
