<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page session="false"%>
<html>
<head>
<title>다이어리_selectOne</title>
<jsp:include page="../../css.jsp"></jsp:include>
</head>
<body>
	<jsp:include page="../../top_menu.jsp"></jsp:include>
	<h1>mini/diary/selectOne.jsp</h1>

	<div>${vo2.mbname}</div>
	<div>제목 : ${vo2.title}</div>
	<div>작성일자 : ${vo2.wdate}</div>
	<div>
		<textarea rows="10" cols="90" name="content">~~~~</textarea>
	</div>
	<div>
		<a href="diary_update.do?mbnum=${param.mbnum}" class="myButton">수정</a>
		<a href="diary_deleteOK.do?mbnum=${param.mbnum}" class="myButton">삭제</a>
	</div>
	<div>1 2 3 4 5</div>
</body>
</html>
