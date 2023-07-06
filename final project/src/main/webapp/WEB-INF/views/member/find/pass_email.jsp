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
<title>비밀번호 찾기</title>
</head>

<body>
	<div class="w3-content w3-container w3-margin-top">
		<div class="w3-container w3-card-4">

					<form action="pass_injeung.do${dice},${email}" method="post">

						<br><br>
						<p>
							<label>인증번호 입력:</label> <input class="w3-input" type="number"
								id="email" name="pass_injeung" required=" 인증번호를 입력하세요.">
						</p>

						<button type="submit" name="submit"
							class="w3-button w3-block w3-black w3-ripple w3-margin-top w3-margin-bottom w3-round">인증번호
							확인</button>

						<button type="button" onclick="history.go(-1);"
							class="w3-button w3-block w3-black w3-ripple w3-margin-top w3-margin-bottom w3-round">Cancel</button>

					</form>
		</div>
	</div>
</body>
</html>
