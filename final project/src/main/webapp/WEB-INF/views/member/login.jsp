<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<title>login from</title>
<jsp:include page="../css.jsp"></jsp:include>
<script src="http://code.jquery.com/jquery-latest.js"></script>
<script>
	$(function() {

		$("#find_id_btn").click(function() {
			location.href = 'find_id_from.do';
		})
	})
	$(function() {

		$("#find_pw_btn").click(function() {
			location.href = 'find_pw_from.do';
		})
	})
</script>
</head>
<body>
	<jsp:include page="../top_menu.jsp"></jsp:include>
	<div class="w3-content w3-container w3-margin-top">
		<div class="w3-center w3-large w3-margin-top">
			<h3>Log In</h3>
		</div>
		<div>
			<form action="loginOK.do" method="post">
				<p>
					<label>ID</label> <span class="w3-rigth w3-button w3-hover-white"
						title="아이디 찾기" id="find_id_btn"> <i
						class="fa fa-exclamation-triangle w3-hover-text-red w3-large"></i>
					</span> <input class="w3-input" type="text" id="id" name="id" required>
				</p>

				<p>
					<label>PW</label> <span class="w3-rigth w3-button w3-hover-white"
						title="비밀번호 찾기" id="find_pw_btn"> <i
						class="fa fa-exclamation-triangle w3-hover-text-red w3-large"></i>
					</span> <input class="w3-input" type="password" id="pw" name="pw" required>
				</p>
				<tr>
					<td colspan="2"><input type="submit"
						class="w3-button w3-block w3-black w3-ripple w3-margin-top w3-margin-bottom w3-round"></td>
				</tr>

			</form>
		</div>
	</div>
</body>
</html>