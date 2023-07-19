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
	    var messageDiv = document.getElementById('pw_match_message');

	    if (p1.length < 6) {
	        text = '6글자 이상이어야 합니다.';
	        messageDiv.classList.remove('success-message');
	        messageDiv.classList.add('error-message');
	    } else if (p1 !== p2) {
	        text = '비밀번호가 불일치합니다';
	        messageDiv.classList.remove('success-message');
	        messageDiv.classList.add('error-message');
	    } else {
	        text = '비밀번호가 일치합니다';
	        messageDiv.classList.remove('error-message');
	        messageDiv.classList.add('success-message');
	    }

	    messageDiv.innerHTML = text;
	    messageDiv.style.display = (p1 === p2 || p1.length < 6) ? 'none' : 'block';
	}


	function changeProfilePic() {
		document.getElementById("m_file").click();
	}
</script>



<style>
    .error-message {
        color: red;
    }

    .success-message {
        color: green;
    }
</style>

<style>
#pw2 {
	display: none;
}
</style>

</head>
<body>
	<jsp:include page="../sidebar.jsp"></jsp:include>
	<jsp:include page="../navbar.jsp"></jsp:include>

	<div class="wrapper ">
		<div class="main-panel">
			<div class="content">
				<form id="joinForm" action="m_updateOK.do" method="post"
					enctype="multipart/form-data">
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
										<img class="avatar border-gray" id="profile_img"
											src="resources/uploadimg/${vo2.profilepic}"
											onclick="changeProfilePic()"> <input type="hidden"
											id="profilepic" name="profilepic" value="${vo2.profilepic}">
										<h5 class="title">${vo2.nickname}</h5>
										<p class="description">${vo2.id}</p>
									</div>

									<!-- 파일 선택용 input (style="display: none;"로 숨김) -->
									<input type="file" id="m_file" name="m_file"
										style="display: none;">
									
								</div>
								<div class="card-footer">
									<hr>
									<div class="button-container">
										<div class="row">
											<div class="col-lg-3 col-md-6 col-6 ml-auto">
												
											</div>
											<div class="col-lg-4 col-md-6 col-6 ml-auto mr-auto">
												
											</div>
											<div class="col-lg-3 mr-auto">
												
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
												<label>ID</label> <input type="text" class="form-control"
													name="id" readonly value="${vo2.id}">
											</div>
										</div>
										<div class="col-md-4 pr-1">
											<div class="form-group">
												<label>닉네임</label> <input type="text" id="nickname"
													name="nickname" class="form-control"
													value="${vo2.nickname}"
													onfocusout="NickCheck('${vo2.nickname}')">
												<div id="nick_check"></div>
											</div>
										</div>
									</div>

									<div class="row">
										<div class="col-md-5 pr-1">
											<div class="form-group">
												<label>비밀번호</label> <input type="password" id="pw1"
													name="pw" class="form-control" value="${vo2.pw}"
													oninput="test2()" placeholder="${vo2.pw}"
													onmouseenter="togglePasswordConfirmation()">
											</div>
										</div>
										<div class="col-md-5 pr-1">
											<div class="form-group">
												<label id="pwConfirmationLabel" style="display: none;">비밀번호
													확인</label> <input type="password" id="pw2" class="form-control"
													oninput="test2()" style="display: none;">
												<div id="pw_match_message" style="display: none;"></div>
											</div>
										</div>
									</div>

									<div class="row">
										<div class="col-md-6 pr-1">
											<div class="form-group">
												<label>이름</label> <input type="text" class="form-control"
													value="${vo2.name}" name="name">
											</div>
										</div>
									</div>
									<div class="row">
										<div class="col-md-4 pr-1">
											<div class="form-group">
												<label>전화번호</label> <input type="text" id="tel" name="tel"
													class="form-control" value="${vo2.tel}">
											</div>
										</div>
										<div class="col-md-7 pr-1">
											<div class="form-group">
												<label>이메일</label><input type="email" id="email"
													name="email" class="form-control" value="${vo2.email}">
											</div>
										</div>
									</div>
									<div class="row">
										<div class="col-md-11 pr-1">
											<div class="form-group">
												<label>회원정보 확인 질문</label> <select class="w3-select"
													id="question" name="question">
													<option value="" disabled selected>선택하세요</option>
													<option value="가장 행복했던 순간은?"
														${vo2.question == '가장 행복했던 순간은?' ? 'selected' : ''}>
														가장 행복했던 순간은?</option>
													<option value="집주소는?"
														${vo2.question == '집주소는?' ? 'selected' : ''}>
														집주소는?</option>
													<option value="가입하게 된 이유"
														${vo2.question == '가입하게 된 이유' ? 'selected' : ''}>
														가입하게 된 이유</option>
												</select>

											</div>
										</div>
									</div>
									<div class="row">
										<div class="col-md-11 pr-1">
											<div class="form-group">
												<label>회원정보 확인 답변</label> <input type="text" id="answer"
													name="answer" class="form-control" value="${vo2.answer}">
											</div>
										</div>
									</div>
									<div class="row">
										<div class="update ml-auto mr-auto">
											<input type="button" value="회원수정완료"
												class="btn btn-primary btn-round" onclick="submitForm()">
											<button type="button" onclick="m_deleteOK()"
												class="btn btn-primary btn-round">탈퇴하기</button>
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

	<script>
		function m_deleteOK() {
			if (window.confirm("탈퇴하시겠습니까?")) {
				location.href = "m_deleteOK.do?id=${vo2.id}";
			}
		}
		document
				.getElementById("m_file")
				.addEventListener(
						"change",
						function() {
							var reader = new FileReader();
							reader.onload = function(e) {
								document.getElementById("profile_img").src = e.target.result;
							};
							reader.readAsDataURL(this.files[0]);
						});

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