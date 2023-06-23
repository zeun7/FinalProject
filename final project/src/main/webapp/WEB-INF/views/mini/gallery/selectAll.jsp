<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<html>
<head>
<title>사진첩_selectAll</title>
<jsp:include page="../../css.jsp"></jsp:include>
</head>
<body>
	<jsp:include page="../../top_menu.jsp"></jsp:include>
	<h1>mini/gallery/selectAll.jsp</h1>
	<h1>사진첩</h1>

	<c:forEach var="vo" items="${vos}">
		<img src="resources/uploadimg/thumb_${vo.filepath}">
	</c:forEach>
	<h2>이미지추가</h2><br>
	<form action="insertOK.do" method="post" enctype="multipart/form-data">
		<input type="file" id="file" name="file"> 
		<input type="hidden" id=""filepath"" name=""filepath"" value="${vo2.backimg}">
		<input type="submit" value="사진올리기" class="myButton">
	</form>
	
	<div>1 2 3 4 5</div>
</body>
</html>