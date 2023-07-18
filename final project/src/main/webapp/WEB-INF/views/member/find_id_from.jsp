<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<title>아이디 찾기</title>
<script src="http://code.jquery.com/jquery-latest.js"></script>
<script>
	$(function() {

		$("#findEmail").click(function() {
			location.href = 'find_id_from_email.do';
		});
	});
	$(function() {

		$("#findQuestion").click(function() {
			location.href = 'find_id_from_question.do';
		});
	});
</script>
<style>
 .card{ 
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
					<div class="card-header"style="text-align: center;">
					<h3>아이디 찾기</h3>
					</div>
					<div style="padding:5px">
			<form action="find_id.do" method="get">

		<button type="button" id="findEmail"   class="w3-button w3-block w3-ripple w3-margin-top w3-round" style="background-color: #94b5e0">이메일로 찾기</button>
		<button type="button"  id="findQuestion" class="w3-button w3-block w3-ripple w3-margin-top w3-round" style="background-color: #94b5e0">질문으로 찾기</button>
		<button type="button" onclick="history.go(-1);"  class="w3-button w3-block w3-ripple w3-margin-top w3-round" style="background-color: #94b5e0">Cancel</button>
			</form>
					</div>
				</div>
		</div>
	</div>
</div>
</div>

</body>
</html>