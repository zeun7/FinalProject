<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>selectOne</title>
<jsp:include page="../css.jsp"></jsp:include>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
</head>
<body>
	<jsp:include page="../top_menu.jsp"></jsp:include>
	<h1>내 정보</h1>
	<table id="myinfo">
		<thead>
			<tr>
				<th>num</th>
				<th>id</th>
				<th>nickname</th>
				<th>name</th>
				<th>tel</th>
				<th>email</th>
			</tr>
		</thead>
		<tbody>
			<tr>
				<td>${vo2.num}</td>
				<td>${vo2.id}</td>
				<td>${vo2.nickname}</td>
				<td>${vo2.name}</td>
				<td>${vo2.tel}</td>
				<td>${vo2.email}</td>
			</tr>
			<tr>
				<td colspan="8"><img width="300px"
					src="https://drive.google.com/file/d/1r9rQTz2M_TbrR24xm0ZZ5HpfhSZxiRLS/view?usp=drive_link"></td>
			</tr>

		</tbody>
		<tfoot>
			<tr>
				<td colspan="8"><a href="m_update.do?num=${param.num}">내정보 수정</a> 
			</tr>
		</tfoot>
	</table>
</body>
</html>