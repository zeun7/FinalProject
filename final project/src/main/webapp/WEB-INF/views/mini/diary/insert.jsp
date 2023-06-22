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
	
	<form action="diary_insertOK.do" method="post">
	
		<div>
			<h1 style="font-size: 24px;">${vo2.mbname}</h1>
		</div>
		<input type="hidden" id="writer" name="writer" value="${vo2.writer}">
		<div>제목 :<input type="text" style="border: none;" id="title" name="title" value="다이어리 제목을 입력하세요"></div>
		<div>
			<textarea rows="10" cols="90" name="content">내용을 입력하세요</textarea>
		</div>
		<div>
			<input type="submit" class="myButton" value="다이어리 작성완료">
		</div>
	</form>
</body>
</html>