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
<title>비밀번호 찾기</title>

<style>
.card {
	padding: 80px 30px; /* 상단/하단 80px, 좌우 30px의 공간을 설정합니다. */
	margin: 0 auto;
	max-width: 900px;
}
</style>
</head>

<body>
<jsp:include page="../../sidebar.jsp"></jsp:include>
<jsp:include page="../../navbar.jsp"></jsp:include>
<div class="main-panel">
	<div class="content">
		<div class="row">
			<div class="col-md-12">
				<div class="card">
					<div class="card-header" style="text-align: center;">
						<h3>비밀번호 찾기</h3>
					</div>
					<div>
						<form action="find_pass.do" method="post">
							<p>
								<strong>아이디</strong> <input class="w3-input" type="text"
									id="id" name="id" placeholder="회원가입한 아이디를 입력하세요" required>
							</p>
							<p>
								<strong>이메일</strong> <input class="w3-input" type="text"
									id="email" name="email" placeholder="회원가입한 이메일주소를 입력하세요"
									required>
							</p>
							<p class="w3-center">
								<button type="submit" id=findBtn
									class="w3-button w3-block w3-ripple w3-margin-top w3-round"
									style="background-color: #94b5e0">find</button>
								<button type="button" onclick="history.go(-1);"
									class="w3-button w3-block w3-ripple w3-margin-top w3-round"
									style="background-color: #94b5e0">Cancel</button>
							</p>
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>
	<jsp:include page="../../footer.jsp"></jsp:include>
</div>
<%-- 아이디 또는 이메일이 없는 경우 알림창 표시 --%>
<script>
       var findBtn = document.getElementById("findBtn");
       findBtn.addEventListener("click", function(e) {
           var emailInput = document.getElementById("email");
           var idInput = document.getElementById("id");

           if (emailInput.value.trim() === "" && idInput.value.trim() === "") {
               e.preventDefault();
               alert("아이디 또는 이메일을 입력해주세요.");
               window.location.href = "find_pw_from.do";
           }
       });
   </script>

<%-- 아이디와 이메일이 동시에 일치하는 사용자가 없는 경우 알림창 표시 --%>
<%
String message = (String) request.getAttribute("message");
if (message != null && !message.isEmpty()) {
%>
<script>
   alert("<%=message%>");
   window.location.href = "find_pw_from.do";
   <%}%>
   });
   </script>
</body>
</html>