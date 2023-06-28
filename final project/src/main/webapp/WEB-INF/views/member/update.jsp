<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<title>update</title>
<jsp:include page="../css.jsp"></jsp:include>

</head>
<body>
	<jsp:include page="../top_menu.jsp"></jsp:include>
	<div class="w3-content w3-container w3-margin-top">
		<div class="w3-container w3-card-4">
			<div class="w3-center w3-large w3-margin-top">
				<h3>Member Update Form</h3>
			</div>
			<div>
				<form id="joinForm" action="m_updateOK.do" method="post" enctype="multipart/form-data">
					<table id="memberList">
						<tr>
				<td><label for="num">num:</label></td>
				<td><span id="span_num">${vo2.num}</span><input type="hidden" id="num" name="num"
					value="${vo2.num}"></td>
			</tr>
			<tr>
				<td><label for="id">id:</label></td>
				<td><span id="span_id">${vo2.id}</span></td>
			</tr>
			<tr>
				<td><label for="pw">pw:</label></td>
				<td><input type="password" id="pw" name="pw" value="${vo2.pw}"></td>
			</tr>
			<tr>
				<td><label for="name">name:</label></td>
				<td><input type="text" id="name" name="name"
					value="${vo2.name}"></td>
			</tr>
			<tr>
				<td><label for="tel">tel:</label></td>
				<td><input type="text" id="tel" name="tel" value="${vo2.tel}"></td>
			</tr>
			<tr>
				<td><label for="email">email:</label></td>
				<td><input type="email" id="email" name="email" value="${vo2.email}"></td>
			</tr>
			<tr>
				<td><label for="nickname">nickname:</label></td>
				<td><input type="text" id="nickname" name="nickname" value="${vo2.nickname}"></td>
			</tr>
			<tr>
				<td><label for="profilepic">profilepic:</label></td>
				<td>
					<input type="file" id="m_file" name="m_file">
					<input type="hidden" id="m_file" name="m_file" value="${vo2.profilepic}">
				</td>
			</tr>
			<tr>
				<td colspan="2"><input type="submit" value="회원수정완료">
				<button type="button" onclick="m_deleteOK()"> 탈퇴하기 </button>	</td>
			</tr>
		</table>
	</form>
			</div>
		</div>
	</div>
	<script>
function m_deleteOK() {
	if(window.confirm("탈퇴하시겠습니까?")){
	location.href="delete.do";
	}
	
}
</script>
</body>
</html>