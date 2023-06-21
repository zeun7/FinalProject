<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>selectAll</title>
<jsp:include page="../css.jsp"></jsp:include>
</head>
<body>
	<jsp:include page="../top_menu.jsp"></jsp:include>
	<h1>댓글목록</h1>

	<table id="commentsList">
	<thead>
		<tr>
			<th>cnum</th>
			<th>writer</th>
			<th>content</th>
			<th>cdate</th>
		</tr>
	</thead>
	<tbody>
		<c:forEach var="vo" items="${vos}">
			<tr>
				<td>${vo.cnum}</td>
				<td>${vo.writer}</td>
				<td>${vo.content}</td>
				<td>${vo.cdate}</td>
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