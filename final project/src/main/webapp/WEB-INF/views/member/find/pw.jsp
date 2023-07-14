<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<title>비밀번호 찾기</title>

 <%-- 아이디 또는 이메일이 없는 경우 알림창 표시 --%>
    <script>
        var findBtn = document.getElementById("findBtn");
        findBtn.addEventListener("click", function(e) {
            var emailInput = document.getElementById("email");
            var idInput = document.getElementById("id");

            if (emailInput.value.trim() === "" && idInput.value.trim() === "") {
                e.preventDefault();
                alert("아이디 또는 이메일을 입력해주세요.");
            }
        });
    </script>

    <%-- 아이디와 이메일이 동시에 일치하는 사용자가 없는 경우 알림창 표시 --%>
    <%
        String message = (String) request.getAttribute("message");
        if (message != null && !message.isEmpty()) {
    %>
    <script>
        alert("<%= message %>");
    </script>
    <% } %>
	
</head>

<body>
<jsp:include page="../../sidebar.jsp"></jsp:include>
<div class="main-panel">
	<div class="w3-content w3-container w3-margin-top">
		<div class="w3-container w3-card-4">
			<form action="find_pass.do" method="post">
				<div class="w3-center w3-large w3-margin-top">
					<h3>비밀번호 찾기</h3>
				</div>
				<div>
					<p>
						<label>Email</label>
						<input class="w3-input" type="text" id="email" name="email" required>
					</p>
					<p>
						<label>ID</label>
						<input class="w3-input" type="text" id="id" name="id" required>
					</p>
					<p class="w3-center">
						<button type="submit" id=findBtn class="w3-button w3-block w3-black w3-ripple w3-margin-top w3-round">find</button>
						<button type="button" onclick="history.go(-1);" class="w3-button w3-block w3-black w3-ripple w3-margin-top w3-margin-bottom w3-round">Cancel</button>
					</p>
				</div>
			</form>
		</div>
	</div>
</div>
	
</body>
</html>