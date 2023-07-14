<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<title>login from</title>

</head>
<body>
<jsp:include page="../../sidebar.jsp"></jsp:include>
<div class="main-panel">
	<div class="w3-content w3-container w3-margin-top">
		<div class="w3-container w3-card-4">
			<div class="w3-center w3-large w3-margin-top">
				<br />
				<h3>비밀번호 변경</h3>
				<br />
				<h2>비밀번호 변경이 완료 되었습니다</h2>
				<br />

				<button type="button"
					class="w3-button w3-block w3-black w3-ripple w3-margin-top w3-margin-bottom w3-round">
					<a href="login.do">Login</a>
				</button>
				<br />
			</div>
		</div>
	</div>
</div>
</body>
</html>