<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page session="false"%>
<html>
<head>
<title>프로필 수정</title>
<jsp:include page="../css.jsp"></jsp:include>
</head>
<body>
<jsp:include page="../top_menu.jsp"></jsp:include>
	<h1>mini/update.jsp</h1>
	<form action="mini_updateOK.do" method="post"
		enctype="multipart/form-data">
		<table>
			<tr>
				<td><label for="hnum">hnum:</label></td>
				<td><span id="span_hnum">${vo2.hnum}</span></td>
			</tr>
			<tr>
				<td><label for="id">id:</label></td>
				<td><span id="span_id">${vo2.id}</span></td>
			</tr>
			<tr>
				<td><label for="title">title:</label></td>
				<td><input type="text" id="title" name="title" value="${vo2.title}"></td>
			</tr>
			<tr>
				<td><label for="message">message:</label></td>
				<td><input type="text" id="message" name="message"
					value="${vo2.message}"></td>
			</tr>
			<tr>
				<td><label for="miniaddr">miniaddr:</label></td>
				<td>${vo2.miniaddr}</td>
			</tr>
			<tr>
				<td><label for="backimg">backimg:</label></td>
				<td><input type="file" id="file" name="file"> <input
					type="hidden" id="save_name" name="save_name"
					value="${vo2.save_name}"></td>
			</tr>
			<tr>
				<td colspan="2"><input type="submit" value="프로필 수정완료"></td>
			</tr>
		</table>
	</form>
</body>
</html>
