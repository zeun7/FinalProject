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
<script src="http://code.jquery.com/jquery-latest.js"></script>
<script>
	$(function() {

		$("#find_id_btn").click(function() {
			location.href = 'find_id_from.do';
		});
	});
	$(function() {

		$("#find_pw_btn").click(function() {
			location.href = 'find_pw_from.do';
		});
	});
</script>
</head>
<body>
	<jsp:include page="../sidebar.jsp"></jsp:include>
	<div class="w3-content w3-container w3-margin-top">
		<div class="w3-container w3-card-4">
			<div class="w3-center w3-large w3-margin-top">
				<h3>Log In</h3>
			</div>
			<div>
				<form action="loginOK.do" method="post">
					<p>
						<label>ID</label>
						<span class="w3-right w3-button w3-hover-white" title="아이디 찾기" id="find_id_btn">
							<i class="fa fa-exclamation-triangle w3-hover-text-red w3-large"></i>
						</span> <input class="w3-input" id="id" name="id" type="text" required />
					</p>
					<p>
						<label>Password</label>
						<span class="w3-right w3-button w3-hover-white" title="비밀번호 찾기" id="find_pw_btn">
							<i class="fa fa-exclamation-triangle w3-hover-text-red w3-large"></i>
						</span> <input class="w3-input" id="pw" name="pw" type="password" required />
					</p>
					<p class="w3-center">
						<button type="submit" class="w3-button w3-block w3-black w3-ripple w3-margin-top w3-round">
							Log in</button>
						<button type="button"
							class="w3-button w3-block w3-black w3-ripple w3-margin-top w3-margin-bottom w3-round"
							onclick="history.go(-1)">Cancel</button>
					</p>
					<input type="checkbox" name="_spring_security_remember_me" id="remember_me" value="True" />
						로그인 유지<br>
					<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
				</form>
			</div>
		</div>
	</div>
	<c:if test="${errorMessage}">
		<script>
			alert('${message}');
		</script>
	</c:if>
</body>
</html>

