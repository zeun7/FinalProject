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
<title>insert</title>
<script src="https://kit.fontawesome.com/7ed6703c9d.js" crossorigin="anonymous"></script>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
<script type="text/javascript">
	$(function() {
		console.log("onload....");
	});
	
	$(function() {

		$("#gohome").click(function() {
			location.href = 'home.do';
		});
	});

	function fn_emailChk_Ajax() {
		var userEmail = $("#email").val().trim();
		var emailRegex = /^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/;

		if (userEmail === "") {
			// 이메일이 입력되지 않은 경우
			$("#showDiv").prop("disabled", true);
			return;
		}

		if (!emailRegex.test(userEmail)) {
			// 유효한 이메일 형식이 아닌 경우
			$("#showDiv").prop("disabled", true);
			return;
		}

		// 이메일이 유효하므로 버튼을 활성화
		$("#showDiv").prop("disabled", false);
	}

	function fn_sendEmail_Ajax() {
		var userEmail = $("#email").val().trim();

		// 이메일이 입력되지 않은 경우 처리
		if (userEmail === "") {
			alert("이메일 주소를 입력해야 합니다.");
			return;
		}

		var form = {
			"email" : userEmail
		};

		$.ajax({
			url : "checkEmailAjax.do",
			method : "POST",
			data : JSON.stringify(form),
			contentType : "application/json; charset=utf-8;",
			async : false,
			success : function(data) {

				if (data.exists === "true") {
					alert("이미 가입된 이메일입니다.");

				} else {
					alert("입력하신 이메일 주소에서 발급된 코드를 확인하세요.");

					resultCode = data.joinCode;

					$("#checkCodeDiv").show();
				}
			},
			error : function() {
				alert("네트워크가 불안정합니다. 다시 시도해 주세요.222");
			},
		});
	}

	function fn_checkCode() {
		var inputCode = $("#verification_code").val().trim();

		// 인증 코드가 입력되지 않은 경우 처리
		if (inputCode === "") {
			alert("인증 코드를 입력해주세요.");
			return;
		}

		// 인증 코드 확인 로직 구현
		var sentCode = resultCode;
		if (inputCode === sentCode) {
			// 인증 코드가 일치하는 경우
			alert("인증이 완료되었습니다.");
		} else {
			// 인증 코드가 일치하지 않는 경우
			alert("인증 코드가 올바르지 않습니다. 다시 확인해주세요.");
			// 다시 인증 번호 요청을 보낼 수 있도록 설정
			$("#checkCodeDiv").hide();
			resultCode = "";
		}
	}

	function idCheck() {
		console.log("idCheck....", $('#id').val());

		$.ajax({
			url : "json_m_idCheck.do",
			data : {
				id : $('#id').val()
			},
			method : 'GET',
			dataType : 'json',
			success : function(obj) {
				console.log('ajax...success:', obj);
				console.log('ajax...success:', obj.result);
				let msg = '';
				if (obj.result === 'OK') {
					msg = '사용가능한 아이디입니다.';
				} else {
					msg = '사용중인 아이디입니다.';
				}
				$('#demo1').text(msg);
			},
			error : function(xhr, status, error) {
				console.log('xhr.status:', xhr.status);
			}
		});//end $.ajax()...

	}//end idCheck()...

	function TelCheck() {
		console.log("TelCheck....", $('#tel').val());

		$.ajax({
			url : "json_m_TelCheck.do",
			data : {
				tel : $('#tel').val()
			},
			method : 'GET',
			dataType : 'json',
			success : function(obj) {
				console.log('ajax...success:', obj);
				console.log('ajax...success:', obj.result);
				let msg = '';
				if (obj.result === 'OK') {
					msg = '사용가능 합니다 ';
				} else {
					msg = '로그인 되어있는 전화번호입니다.'
				}
				$('#demo3').text(msg);
			},
			error : function(xhr, status, error) {
				console.log('xhr.status:', xhr.status);
			}
		});//end $.ajax()...

	}//end NickCheck()...
	function NickCheck() {
		console.log("NickCheck....", $('#nickname').val());

		$.ajax({
			url : "json_m_NickCheck.do",
			data : {
				nickname : $('#nickname').val()
			},
			method : 'GET',
			dataType : 'json',
			success : function(obj) {
				console.log('ajax...success:', obj);
				console.log('ajax...success:', obj.result);
				let msg = '';
				if (obj.result === 'OK') {
					msg = ' 사용 가능한 닉네임 입니다';
				} else {
					msg = '사용중인 닉네임 입니다'

				}
				$('#demo2').text(msg);
			},
			error : function(xhr, status, error) {
				console.log('xhr.status:', xhr.status);
			}
		});//end $.ajax()...

	}//end NickCheck()...

	function test() {
		var p1 = document.getElementById('pw1').value;
		var p2 = document.getElementById('pw2').value;

		if (p1.length < 6) {
			alert('입력한 글자가 6글자 이상이어야 합니다.');
			return false;
		}

		if (p1 != p2) {
			alert("비밀번호불일치");
			return false;
		} else {
			alert("비밀번호가 일치합니다");
			return true;
		}
	}
</script>

</head>
<style>
.card {
	padding: 80px 30px;
	margin: 0 auto;
	max-width: 900px;
}

.button-container {
	display: flex;
	justify-content: center;
	margin-top: 20px;
}

.w3-button {
	width: 140px;
	margin: 10px;
}
</style>
<body>
<jsp:include page="../sidebar.jsp"></jsp:include>
<jsp:include page="../navbar.jsp"></jsp:include>
<div class="main-panel">
	<div class="content">
		<div class="row">
			<div class="col-md-12">
				<div class="card">
					<div class="card-header" style="text-align: center;">
						<h3>회원가입</h3>
					</div>
					<div>
						<form id="joinForm" action="m_insertOK.do" method="post"
							enctype="multipart/form-data">
							<table>
								<tr>
									<td><strong for="id">id:</strong></td>
									<td><input class="w3-input" type="text" id="id" name="id"
										placeholder="아이디">
										<button type="button" onclick="idCheck()"
											class="btn btn-outline-primarys">ID중복체크</button> <span
										id="demo1"></span></td>
								</tr>

								<tr>
									<td><strong for="pw">pw:</strong></td>
									<td><input class="w3-input" type="password" id="pw1"
										name="pw" placeholder="비밀번호"> <input class="w3-input"
										type="password" id="pw2" name="pw2" placeholder="비밀번호 한번더 입력">
										<input type="button" onclick="test()" value="확인"
										class="btn btn-outline-primarys"></td>


								</tr>

								<tr>
									<td><strong for="nickname">nickname:</strong></td>
									<td><input class="w3-input" type="text" id="nickname"
										name="nickname" placeholder="닉네임">
										<button type="button" onclick="NickCheck()"
											class="btn btn-outline-primarys">닉네임 중복체크</button> <span
										id="demo2"></span></td>
								</tr>
								<tr>
									<td><strong for="question">question:</strong></td>
									<td><select class="w3-select" id="question"
										name="question">
											<option value="" disabled selected>질문을 선택하세요</option>
											<option value="가장 행복했던 순간은?">가장 행복했던 순간은?</option>
											<option value="집주소는?">집주소는?</option>
											<option value="가입하게 된 이유">가입하게 된 이유</option>
									</select></td>
								</tr>
								<tr>
									<td><strong for="answer">answer:</strong></td>
									<td><input class="w3-input" type="text" id="answer"
										name="answer" placeholder="답"></td>
								</tr>

								<tr>
									<td><strong for="name">name:</strong></td>
									<td><input class="w3-input" type="text" id="name"
										name="name" placeholder="이름"></td>
								</tr>
								<tr>
									<td><strong for="tel">tel:</strong></td>
									<td><input class="w3-input" type="text" id="tel"
										name="tel" placeholder="010-0000-0000">
										<button type="button" onclick="TelCheck()"
											class="btn btn-outline-primarys">전화번호 중복체크</button> <span
										id="demo3"></span></td>
								</tr>

								<tr class="count-box">
									<td><strong id="resultMailBox">Email</strong></td>
									<td><i class="bi bi-at"></i> <span class="userEmail"><input
											placeholder="이메일을 입력하세요" class="w3-input" type="text"
											id="email" name="email" oninput="fn_emailChk_Ajax()" />
											<button type="button" class="btn btn-outline-primarys"
												id="showDiv" onclick="fn_sendEmail_Ajax()">
												<i class="fa fa-search"></i>이메일 인증
											</button>
											<h6 style="color: green;">※ 이메일을 입력해주세요</h6>

											<td style="display: none;" id="checkCodeDiv"><input
												type="text" id=verification_code name="verification_code"
												placeholder="인증코드 입력" class="w3-input" />
												<button type="button" class="btn btn-outline-primarys"
													onclick="fn_checkCode()">확인</button></td> </span></td>
								</tr>

								<tr>
									<td><strong for="m_file">프로필 사진선택:</strong></td>
									<td><input class="w3-input" type="file" id="m_file"
										name="m_file" placeholder=" "></td>
								</tr>
							</table>
							<div class="button-container">
								<button type="button" onclick="submitForm()" id="joinBtn"
									class="w3-button w3-ripple w3-round btn-round"
									"
									style="background-color: #94b5e0">Join</button>
								<button type="button" id="gohome"
									class="w3-button w3-ripple w3-round btn-round"
									"
									style="background-color: #94b5e0">Cancel</button>
							</div>

						</form>
					</div>
				</div>
			</div>
		</div>
	</div>
	<jsp:include page="../footer.jsp"></jsp:include>
</div>
<script>
	function submitForm() {
		var pw1 = document.getElementById("pw1").value;
		var pw2 = document.getElementById("pw2").value;

		if (pw1 !== pw2) {
			alert("비밀번호가 일치하지 않습니다.");
			return;
		}

		// Rest of the code for form submission
		var id = document.getElementById("id").value;
		var nickname = document.getElementById("nickname").value;
		var email = document.getElementById("email").value;
		var tel = document.getElementById("tel").value;
		var question = document.getElementById("question").value;
		var answer = document.getElementById("answer").value;

		if (id.trim() === '' || pw1.trim() === '' || pw2.trim() === ''
				|| nickname.trim() === '' || email.trim() === ''
				|| tel.trim() === '' || question.trim() === ''
				|| answer.trim() === '') {
			alert("빈칸을 채워주세요. 모든 필드는 필수 입력 항목입니다.");
			return;
		}

		// 중복 체크를 통한 회원가입 제어
		if ($('#demo1').text() !== '사용가능한 아이디입니다.') {
			alert("사용중인 아이디입니다.");
			return;
		}
		if ($('#demo2').text() !== ' 사용 가능한 닉네임 입니다') {
			alert("사용중인 닉네임 입니다");
			return;
		}
		if ($('#demo3').text() !== '사용가능 합니다 ') {
			alert("로그인 되어있는 전화번호입니다.");
			return;
		}
		if ($('#verification_code').val().trim() === '') {
			alert("이메일 인증이 필요합니다.");
			return;
		}

		// 나머지 처리 로직
		document.getElementById("joinForm").submit();
	}
</script>

</body>
</html>