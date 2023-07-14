<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>selectOne</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
</head>
<body>
<jsp:include page="../sidebar.jsp"></jsp:include>
<div class="main-panel">
	<h1>내 정보</h1>
	<table id="myinfo">
		<thead>
			<tr>
				<th>id</th>
				<th>nickname</th>
				<th>name</th>
				<th>tel</th>
				<th>email</th>
			</tr>
		</thead>
		<tbody>
			<tr>
				<td>${vo2.id}</td>
				<td>${vo2.nickname}</td>
				<td>${vo2.name}</td>
				<td>${vo2.tel}</td>
				<td>${vo2.email}</td>
			</tr>
			<tr>
				<td colspan="8"><img width="300px"
					src="resources/uploadimg/${vo2.profilepic}"></td>
			</tr>
	
		</tbody>
		<tfoot>
			<tr>
				<td colspan="8"><a href="m_update.do?id=${param.id}">내정보 수정</a> 
			</tr>
		</tfoot>
	</table>
</div>
</body>
</html>