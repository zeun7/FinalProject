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
		<li><a href="mini_update.do?id=${param.id}">프로필 수정</a></li>
		<li><a href="">최신 게시글</a></li>
		<li><a href="mini_random.do">랜덤 미니홈피 가기</a></li>
	</ul>
	<ul>
		<li><a href="mini_home.do?id=${param.id}">홈</a></li>
		<li><a href="mini_diary.do?id=${param.id}">다이어리</a></li>
		<li><a href="mini_visit.do?id=${param.id}">방명록</a></li>
		<li><a href="mini_gallery.do?id=${param.id}">갤러리</a></li>
		<li><a href="mini_game.do?hnum=?id=${param.id}">게임</a></li>
	</ul>
	
	<div style="background-image: url('resources/uploadimg/${vo2.backimg}'); background-size: cover; width: 100%; height: 100vh;">
	<div>${vo2.title}</div>
	<div>${vo2.message}</div>
	<div>bgm : ${vo2.bgm}
		<audio src="https://ccrma.stanford.edu/~jos/mp3/harpsi-cs.mp3" controls></audio>
	</div>
	<div>vtoday : ${vo2.vtoday}</div>
	<div>vtotal : ${vo2.vtotal}</div>
	</div>
	
</body>
</html>