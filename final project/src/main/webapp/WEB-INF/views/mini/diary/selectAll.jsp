<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page session="false"%>
<html>
<head>
<title>다이어리_selectAll</title>
<jsp:include page="../../css.jsp"></jsp:include>
</head>
<body>
<jsp:include page="../../top_menu.jsp"></jsp:include>
	<h1>mini/diary/selectAll.jsp</h1>
	<h1>다이어리</h1>
	
	<table id="boardList">
	<thead>
		<tr>
			<th>mbnum</th>
			<th>mbname</th>
			<th>writer</th>
			<th>title</th>
			<th>content</th>
			<th>wdate</th>
		</tr>
	</thead>
	<tbody>
		<c:forEach var="vo" items="${vos}">
			<tr>
				<td><a href="diary_selectOne.do?mbnum=${vo.mbnum}">${vo.mbnum}</a></td>
				<td>${vo.mbname}</td>
				<td>${vo.writer}</td>
				<td>${vo.title}</td>
				<td>${vo.content}</td>
				<td>${vo.wdate}</td>
			</tr>
		</c:forEach>
	</tbody>
	<tfoot>
		<tr>
			<td colspan="6">1 2 3 4 5</td>
		</tr>
	</tfoot>
	</table>
	
</body>
</html>
