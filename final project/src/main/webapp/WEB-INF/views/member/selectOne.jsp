<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>selectOne</title>
<jsp:include page="../css.jsp"></jsp:include>

</head>
<body>
	<jsp:include page="../top_menu.jsp"></jsp:include>
	<h1>내 정보</h1>
		<table id="myinfo">
			<thead>
			<tr>
				<th>num</th>
				<th>id</th>
				<th>pw</th>
				<th>nickname</th>
				<th>minaddr</th>
				<th>name</th>
				<th>tel</th>
				<th>email</th>
			</tr>
		</thead>
		<tbody>
		
		<tr>
				<td>${vo2.num}</td>
				<td>${vo2.id}</td>
				<td>${vo2.pw}</td>
				<td>${vo2.nickname}</td>
				<td>${vo2.minaddr}</td>
				<td>${vo2.name}</td>
				<td>${vo2.tel}</td>
				<td>${vo2.email}</td>
			</tr>
			<tr>
				<td colspan="8">
					<img width="300px" src="resources/uploadimg/${vo2.profilepic}">
				</td>
			</tr>
			
		</tbody>
			<tfoot>
			<tr>
				<td colspan="8"><a href="m_update.do?num=${param.num}">내정보 수정</a>
					<a href="m_deleteOK.do?num=${param.num}">탈퇴</a></td>
			</tr>
		</tfoot>
	</table>
</body>
</html>
