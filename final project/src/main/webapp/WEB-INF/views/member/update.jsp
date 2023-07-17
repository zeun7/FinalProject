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
<title>update</title>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
<script type="text/javascript">
function NickCheck(currentUserNickname) {
	console.log("NickCheck....", $('#nickname').val());

	if ($('#nickname').val() === currentUserNickname) {
		alert("기존 닉네임입니다.");
		return;
	}

	$.ajax({
		url : "json_m_NickCheck.do",
		data : {
			nickname : $('#nickname').val(),
			currentUserNickname : currentUserNickname
		},
		method : 'GET',
		dataType : 'json',
		success : function(obj) {
			console.log('ajax...success:', obj);
			console.log('ajax...success:', obj.result);
			let msg = '';
			if (obj.result === 'OK') {
				msg = '사용가능한 닉네임입니다.';
			} else {
				msg = '사용중인 닉네임입니다.';
			}
			$('#nick_check').text(msg);
		},
		error : function(xhr, status, error) {
			console.log('xhr.status:', xhr.status);
		}
	});
}

function test2() {
	var p1 = document.getElementById('pw1').value;
	var p2 = document.getElementById('pw2').value;
	var text = '';
	
	if (p1.length < 6) {
		text = '6글자 이상이어야 합니다.';
	}

	if (p1 !== p2) {
		text = '비밀번호가 불일치합니다';
	} else {
		text = '비밀번호가 일치합니다';
	}
	
	$('#pw_check').text(text);
}
</script>

<style>
#pw2, #confirmationButton {
	display: none;
}
</style>
</head>
<body>
<jsp:include page="../sidebar.jsp"></jsp:include>
<div class="main-panel">
<jsp:include page="../navbar.jsp"></jsp:include>
<div class="wrapper ">
	<div class="main-panel">		
		<div class="content">
				<form>
			<div class="row">
			
				<!-- 왼쪽 카드 프로필, 팀멤버 카드 -->
				<div class="col-md-4">
					<!--  프로필 이미지, 닉네임 등등  -->
					<div class="card card-user">
						<div class="image">
							<img src="resources/assets/img/damir-bosnjak.jpg" alt="...">
						</div>
						<div class="card-body">
							<div class="author">
								<img class="avatar border-gray" id="profile_img" src="resources/uploadimg/${vo2.profilepic}"
									onclick="">
								<h5 class="title">${vo2.nickname}</h5>
								<p class="description">${vo2.id}</p>
							</div>
							<p class="description text-center">
								"I like the way you work it <br> No diggity <br> I
								wanna bag it up"
							</p>
						</div>
						<div class="card-footer">
							<hr>
							<div class="button-container">
								<div class="row">
									<div class="col-lg-3 col-md-6 col-6 ml-auto">
										<h5>
											12<br>
											<small>Files</small>
										</h5>
									</div>
									<div class="col-lg-4 col-md-6 col-6 ml-auto mr-auto">
										<h5>
											2GB<br>
											<small>Used</small>
										</h5>
									</div>
									<div class="col-lg-3 mr-auto">
										<h5>
											24,6$<br>
											<small>Spent</small>
										</h5>
									</div>
								</div>
							</div>
						</div>
					</div> 
				</div>
				
				<!-- 회원정보 수정 카드 -->
				<div class="col-md-8">
					<div class="card card-user">
						<div class="card-header">
							<h5 class="card-title">회원수정</h5>
						</div>
						<div class="card-body">
								<div class="row">
									<div class="col-md-5 pr-1">
										<div class="form-group">
											<label>ID</label> <input type="text"
												class="form-control" disabled="" value="${vo2.id}">
										</div>
									</div>
									<div class="col-md-4 pr-1">
										<div class="form-group">
											<label>닉네임</label> <input type="text" id="nickname"
												class="form-control" value="${vo2.nickname}"
												onfocusout="NickCheck('${vo2.nickname}')">
											<div id="nick_check"></div>
										</div>
									</div>
								</div>
								<div class="row">
									<div class="col-md-5 pr-1">
										<div class="form-group">
											<label>비밀번호</label> <input type="text" id="pw1" 
												class="form-control">
										</div>
									</div>
									<div class="col-md-5 pr-1">
										<div class="form-group">
											<label>비밀번호 확인</label> <input type="text" id="pw2" 
												class="form-control" onfocusout="test2()">
											<div id="pw_check"></div>
										</div>
									</div>
								</div>
								<div class="row">
									<div class="col-md-6 pr-1">
										<div class="form-group">
											<label>이름</label> <input type="text"
												class="form-control" value="${vo2.name}">
										</div>
									</div>
								</div>
								<div class="row">
									<div class="col-md-4 pr-1">
										<div class="form-group">
											<label>전화번호</label>
											<div class="form-control">${vo2.tel}</div>
										</div>
									</div>
									<div class="col-md-7 pr-1">
										<div class="form-group">
											<label>이메일</label>
											<div class="form-control">${vo2.email}</div>
										</div>
									</div>
								</div>
								<div class="row">
									<div class="col-md-11 pr-1">
										<div class="form-group">
											<label>회원정보 확인 질문</label>
											<div class="form-control">${vo2.question}</div>
										</div>
									</div>
								</div>
								<div class="row">
									<div class="col-md-11 pr-1">
										<div class="form-group">
											<label>회원정보 확인 답변</label>
											<div class="form-control">${vo2.answer}</div>
										</div>
									</div>
								</div>
								<div class="row">
									<div class="update ml-auto mr-auto">
										<button onclick="location.href='m_update.do?id=${vo2.id}'" 
										class="btn btn-primary btn-round">회원수정</button>
									</div>
								</div>
						</div>
					</div>
				</div>
			</div>
							</form>
		</div>
	</div>
</div>

	<div class="w3-content w3-container w3-margin-top">
		<div class="w3-container w3-card-4">
			<div class="w3-center w3-large w3-margin-top">
				<h3>Member Update Form</h3>
			</div>
			<div>
				<form id="joinForm" action="m_updateOK.do" method="post"
					enctype="multipart/form-data">
					<table id="memberList">
						<tr>
							<td><label for="id">id:</label></td>
							<td><input type="hidden" id="id" name="id" value="${vo2.id}"
								u />${vo2.id}
							<td>
						</tr>

						<tr>
							<td><label for="pw">pw:</label></td>
							<td><input class="w3-input" type="password" id="pw1"
								name="pw" value="${vo2.pw}">
								<button type="button" onclick="togglePasswordConfirmation()">비밀번호
									수정</button> <input class="w3-input" type="password" id="pw2" name="pw2"
								placeholder="비밀번호 한번더 입력"> <input
								id="confirmationButton" type="button" onclick="test2()"
								value="확인" class="myButton"></td>
						</tr>
						<tr>
							<td><label for="name">name:</label></td>
							<td><input type="text" id="name" name="name"
								value="${vo2.name}"></td>
						</tr>
						<tr>
							<td><label for="tel">tel:</label></td>
							<td><input type="text" id="tel" name="tel"
								value="${vo2.tel}"></td>
						</tr>
						<tr>
							<td><label for="email">email:</label></td>
							<td><input type="email" id="email" name="email"
								value="${vo2.email}"></td>
						</tr>
						<tr>
							<td><label for="nickname">nickname:</label></td>
							<td><input type="text" id="nickname" name="nickname"
								value="${vo2.nickname}">
								<button type="button" onclick="NickCheck('${vo2.nickname}')"
									class="myButton">닉네임중복체크</button> <span id="demo2"></span></td>
						</tr>
						<tr>
							<td><label for="profilepic">profilepic:</label></td>
							<td><input type="file" id="m_file" name="m_file"> <input
								type="hidden" id="profilepic" name="profilepic"
								value="${vo2.profilepic}"></td>
						</tr>
						<tr>
							<td colspan="2"><input type="button" value="회원수정완료"
								onclick="submitForm()">
								<button type="button" onclick="m_deleteOK()">탈퇴하기</button></td>
						</tr>
					</table>
				</form>
			</div>
		</div>
	</div>
</div>

<script>
	function m_deleteOK() {
		if (window.confirm("탈퇴하시겠습니까?")) {
			location.href = "m_deleteOK.do?id=${vo2.id}";
		}

	}

	function togglePasswordConfirmation() {
		var pwConfirmation = document.getElementById("pw2");
		var pwConfirmationLabel = document
				.getElementById("pwConfirmationLabel");
		var confirmationButton = document
				.getElementById("confirmationButton");

		if (pwConfirmation.style.display === "none") {
			pwConfirmation.style.display = "block";
			pwConfirmationLabel.style.display = "block";
			confirmationButton.style.display = "block";
			pwConfirmation.value = ""; // 비밀번호 확인 필드가 나타날 때 pw2의 값 초기화
		} else {
			pwConfirmation.style.display = "none";
			pwConfirmationLabel.style.display = "none";
			confirmationButton.style.display = "none";
			pwConfirmation.value = document.getElementById("pw1").value; // 비밀번호 확인 필드가 숨겨질 때 pw1과 pw2의 값 일치화
			document.getElementById("pw2").oninput = null;
		}
	}

	function submitForm() {

		var pw1 = document.getElementById("pw1").value;
		var pw2 = document.getElementById("pw2").value;
		var currentUserNickname = "${vo2.nickname}";
		var nickname = document.getElementById("nickname").value;
		var email = document.getElementById("email").value;
		var tel = document.getElementById("tel").value;

		console.log("currentUserNickname:", currentUserNickname);
		console.log("nickname:", nickname);

		if (document.getElementById("pw2").style.display === "block") {
			if (pw1 !== pw2) {
				alert("비밀번호가 일치하지 않습니다.");
				return;
			}
		}

		if (pw1 === "" && pw2 !== "") {
			document.getElementById("pw2").value = "";
		}


		if (nickname !== currentUserNickname) {
			if ($('#nick_check').text() !== '사용가능한 닉네임입니다.') {
				alert("사용중인 닉네임입니다");
				return;
			}
		}

		// 나머지 처리 로직
		document.getElementById("joinForm").submit();
	}
</script>

</body>
</html>