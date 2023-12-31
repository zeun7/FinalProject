<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<script src="https://kit.fontawesome.com/7ed6703c9d.js" crossorigin="anonymous"></script>
<title>아이디 찾기</title>
</head>
<body>
<jsp:include page="../sidebar.jsp"></jsp:include>
<div class="main-panel">
<jsp:include page="../navbar.jsp"></jsp:include>
	<div class="w3-content w3-container w3-margin-top">
		<div class="w3-container w3-card-4">
			<form action="find_id_tel.do" method="get">
				<div class="w3-center w3-large w3-margin-top">
					<h3>아이디 찾기</h3>
				</div>
				<div>
					<p>
						<label>tel</label>
						<input class="w3-input" type="text" id="tel" name="tel" placeholder="010-0000-0000" required>
					</p>
					<p class="w3-center">
						<button type="submit" id=findBtn class="w3-button w3-block w3-black w3-ripple w3-margin-top w3-round">find</button>
						<button type="button" onclick="history.go(-1);" class="w3-button w3-block w3-black w3-ripple w3-margin-top w3-margin-bottom w3-round">Cancel</button>
					</p>
				</div>
			</form>
		</div>
	</div>
	<c:if test="${errorMessage}">
		<script>
			alert('${message}');
		</script>
	</c:if>
	<jsp:include page="../footer.jsp"></jsp:include>
</div>
</body>
</html>