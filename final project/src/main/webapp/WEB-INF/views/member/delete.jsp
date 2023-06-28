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
<title>delete view</title>
<jsp:include page="../css.jsp"></jsp:include>

<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	// 취소
	$(".cencle").on("click", function(){
		
		location.href = "m_update.do";
				    
	})

	$("#submit").on("click", function(){
		if($("#pw").val()==""){
			alert("비밀번호를 입력해주세요.");
			$("#pw").focus();
			return false;
		}	
	});
	
		
	
})
</script>
<body>
<section id="container">
	<form action="deleteOK.do" method="post">
		<div class="form-group has-feedback">
			<label class="control-label" for="userId">아이디</label>
			<input class="form-control" type="text" id="id" name="id"  value="${vo2.id}"readonly="readonly"/>
		</div>
		<div class="form-group has-feedback">
			<label class="control-label" for="pw">패스워드</label>
			<input class="form-control" type="password" id="pw" name="pw" />
		</div>
		<div class="form-group has-feedback">
			<label class="control-label" for="name">성명</label>
			<input class="form-control" type="text" id="name" name="name" value="${vo2.name}" readonly="readonly"/>
		</div>
		<div class="form-group has-feedback">
			<button class="btn btn-success" type="submit" id="submit">회원탈퇴</button>
			<button class="cencle btn btn-danger" type="button">취소</button>
		</div>
	</form>
	<div>
		<c:if test="${msg == false}">
			비밀번호가 맞지 않습니다.
		</c:if>
	</div>
</section>

</body>

</html>