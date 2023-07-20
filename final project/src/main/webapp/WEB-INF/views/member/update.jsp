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

		if (p1.length < 6 || (p1 !== p2 && p2.length > 0)) {
			text = '비밀번호가 불일치합니다';
			messageDiv.classList.remove('success-message');
			messageDiv.classList.add('error-message');
		} else {
			text = '비밀번호가 일치합니다';
			messageDiv.classList.remove('error-message');
			messageDiv.classList.add('success-message');
		}

		messageDiv.innerHTML = text;
		messageDiv.style.display = (p2.length === 0) ? 'none' : 'block';
	}

	function changeProfilePic() {
		document.getElementById("m_file").click();
	}

	function togglePasswordConfirmation() {
		  var pwConfirmation = document.getElementById("pw2");
		  var pwConfirmationLabel = document.getElementById("pwConfirmationLabel");
		  var messageDiv = document.getElementById("pw_match_message");
		  var pw1Input = document.getElementById("pw1");
		  var updatePasswordButton = document.getElementById("updatePasswordButton");

		  if (pwConfirmation.style.display === "none") {
		    // Show the password confirmation field and label
		    pwConfirmation.style.display = "block";
		    pwConfirmationLabel.style.display = "block";
		    messageDiv.style.display = "block";

		    // Enable editing the password field
		    pw1Input.removeAttribute("readonly");
		    // Reset the password field to its original value
		    pw1Input.value = "${vo2.pw}";
		    // Reset the password confirmation field
		    pwConfirmation.value = "";
		    // Clear the password matching message
		    messageDiv.innerHTML = "";

		    // Change the button text to "취소"
		    updatePasswordButton.textContent = "취소";
		  } else {
		    // Hide the password confirmation field and label
		    pwConfirmation.style.display = "none";
		    pwConfirmationLabel.style.display = "none";
		    messageDiv.style.display = "none";

		    // Reset the password field to its original value
		    pw1Input.value = "${vo2.pw}";

		    // Disable editing the password field again
		    pw1Input.setAttribute("readonly", "readonly");

		    // Run the password matching check again
		    test2();

		    // Change the button text back to "비밀번호 수정"
		    updatePasswordButton.textContent = "비밀번호 수정";
		  }
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

/* Custom CSS class to adjust button size */
#updatePasswordButton {
width: 71px;
  padding: 0.7rem 0.1rem;
  font-size: 0.5rem;
}

.modals {
  display: none;
  position: fixed;
  z-index: 1;
  top:10%;
  left: 25%;
  width: 35%;
  height: 60%;
  overflow: auto;
  background-color: rgba(0, 0, 0, 0.9);
}

.modals-content {
  position: absolute;
  margin:10% 15%;
  width: 70%;
  height: 80%;
  max-width: 80%;
  max-height: 80%;
  overflow: auto;
  background-color: #fefefe;
  border: 1px solid #888;
  border-radius: 4px;
  padding: 20px;
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
											src="resources/uploadimg/${vo2.profilepic}"> <input
											type="hidden" id="profilepic" name="profilepic"
											value="${vo2.profilepic}">
										<h5 class="title">${vo2.nickname}</h5>
										<p class="description">${vo2.id}</p>
									</div>

									<button type="button" class="btn btn-outline-primarys btn-sm mt-2"
										onclick="changeProfilePic()">프로필 사진 변경</button>

									<!-- 파일 선택용 input (style="display: none;"로 숨김) -->
									<input type="file" id="m_file" name="m_file"
										style="display: none;">

									<!-- modal -->
									<div id="profileModal" class="modals">
										<span class="close" onclick="closeModalProfilePic()">&times;</span>
										<img id="profileModalImg" class="modals-content"
											src="resources/assets/img/damir-bosnjak.jpg"
											alt="Profile Picture">
									</div>

								</div>
								<div class="card-footer">
									<hr>
									<div class="button-container">
										<div class="row">
											<div class="col-lg-3 col-md-6 col-6 ml-auto"></div>

											<div class="col-lg-4 col-md-6 col-6 ml-auto mr-auto"></div>
											<div class="col-lg-3 mr-auto"></div>
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
													name="pw" class="form-control" value="${vo2.pw}" readonly
													oninput="test2()">
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
										<div class="col-md-2">
											<!-- Replace the "확인" (Confirm) button with the "비밀번호 수정" (Update Password) button -->
											<button type="button" id="updatePasswordButton"
												class="btn btn-outline-primarys btn-xs"
												onclick="togglePasswordConfirmation()">비밀번호 수정</button>
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
												class="btn btn-primary btn-round"  style="background-color: #94b5e0"onclick="submitForm()">
											<button type="button" onclick="m_deleteOK()"
												class="btn btn-primary btn-round" style="background-color: #94b5e0">탈퇴하기</button>
										</div>
									</div>

								</div>
							</div>
						</div>
					</div>
				</form>
			</div>
			<jsp:include page="../footer.jsp"></jsp:include>
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

		function showModalProfilePic() {
			var modal = document.getElementById("profileModal");
			var modalImg = document.getElementById("profileModalImg");
			var profilePic = document.getElementById("profile_img");

			// Set the profile pic's src as the modal image's src
			modalImg.src = profilePic.src;

			modal.style.display = "block";
		}

		// 프로필 사진을 클릭했을 때 모달 창을 보여주는 이벤트 처리
		var profileImg = document.getElementById("profile_img");
		profileImg.onclick = function() {
			showModalProfilePic();
		};

		function closeModalProfilePic() {
			var modal = document.getElementById("profileModal");
			modal.style.display = "none";
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

		    // 비밀번호 수정 입력란이 보여질 때만 비밀번호 일치 여부 확인
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