<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
	<script src="https://kit.fontawesome.com/7ed6703c9d.js" crossorigin="anonymous"></script>
<script src="http://code.jquery.com/jquery-latest.js"></script>
<script>
	$(function() {
		$("#loginBtn").click(function() {
			location.href = 'login.do';
		})
	})
</script>
<title>아이디 찾기</title>
<style>
.card {
	padding: 80px 30px; /* 상단/하단 80px, 좌우 30px의 공간을 설정합니다. */
	margin: 0 auto;
	max-width: 900px;
}
</style>
</head>
<body>
<jsp:include page="../sidebar.jsp"></jsp:include>
<jsp:include page="../navbar.jsp"></jsp:include>
<div class="main-panel">
	<div class="content">
		<div class="row">
			<div class="col-md-12">
				<div class="card">
					<div class="card-header" style="text-align: center;">
						<h3>아이디 찾기 결과</h3>
					</div>
					<div>
						<h5>${ id }</h5>
						<p class="w3-center">
							<button type="button" id=loginBtn
								class="w3-button w3-block w3-ripple w3-margin-top w3-round"
								style="background-color: #94b5e0">Login</button>
							<button type="button" onclick="history.go(-1);"
								class="w3-button w3-block w3-ripple w3-margin-top w3-round"
								style="background-color: #94b5e0">Cancel</button>
						</p>
					</div>
				</div>
			</div>
		</div>
	</div>
	<jsp:include page="../footer.jsp"></jsp:include>
</div>
</body>
</html>