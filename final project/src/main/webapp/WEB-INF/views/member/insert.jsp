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
<jsp:include page="../css.jsp"></jsp:include>

<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
<script type="text/javascript">
	$(function() {
		console.log("onload....");
	});

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

	//  function EmailCheck(){
	//   	console.log("EmailCheck....",$('#EmailCheck').val());

	//  	$.ajax({
	//   		url : "json_m_EmailCheck.do",
	//   		data:{nickname:$('#nickname').val()},
	//   		method:'GET',
	//   		dataType:'json',
	//   		success : function(obj) {
	//   			console.log('ajax...success:', obj);
	//   			console.log('ajax...success:', obj.result);
	//   			let msg = '';
	//  			if(obj.result==='OK'){
	//   				msg = '사용가능한 이메일입니다.';
	//  			}else{
	//   				msg = '사용중인 이메일입니다.';
	//   			}
	//  			$('#demo3').text(msg);
	//   		},
	//  		error:function(xhr,status,error){
	//   			console.log('xhr.status:', xhr.status);
	//   		}
	//   	});//end $.ajax()...

	//   }//end EmailCheck()...
	// 	$(document).ready(function() {
	// 		$("#join").click(function() {
	// 			var gubun = $('#btnOverlapped').prop('disabled');
	// 			if (!gubun) {
	// 				alert('중복체크를 클릭해주세요.');
	// 				return;
	// 			}
	// 			if (!compare_result) {
	// 				alert('비밀번호가 일치하지 않습니다.');
	// 				return;
	// 			}
	// 			$("#joinForm").submit();

	// 		});

	// 	});
	// 	var compare_result = false;
	// 	function fn_compare_pwd() {
	// 		var pwd1 = $("#member_pwd1").val();
	// 		var pwd2 = $("#member_pwd2").val();
	// 		var $s_result = $("#s_result");
	// 		if (pwd1 == pwd2) {

	// 			compare_result = true;
	// 			$s_result.text("비밀번호가 일치합니다.");
	// 			return;

	// 		}
	// 		compare_result = false;

	// 		$s_result.text("비밀번호가 일치하지 않습니다.");
	// 	}
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
<body>
	<jsp:include page="../top_menu.jsp"></jsp:include>
	<div class="w3-content w3-container w3-margin-top">
		<div class="w3-container w3-card-4">
			<div class="w3-center w3-large w3-margin-top">
				<h3>Member Join Form</h3>
			</div>
			<div>
				<form id="joinForm" action="m_insertOK.do" method="post"
					enctype="multipart/form-data">
					<table id="memberList">
						<tr>
							<td><label for="id">id:</label></td>
							<td><input class="w3-input" type="text" id="id" name="id"
								placeholder="아이디">
								<button type="button" onclick="idCheck()" class="myButton">ID중복체크</button>
								<span id="demo1"></span></td>
						</tr>
						<!-- 						<tr> -->
						<!-- 							<td><input type="password" id="pw1">비밀번호 :</td> -->
						<!-- 							<td><input type="password" id="pw2">비밀번호 확인:</td> -->
						<!-- 							<td><input type="button" onclick="test()" value="확인"></td> -->
						<!-- 						</tr> -->

						<!-- 						<tr> -->
						<!-- 							<td><label for="pw">pw:</label></td> -->
						<!-- 							<td><input class="w3-input" type="password" id="pw2" -->
						<!-- 								name="pw" placeholder="비밀번호"></td> -->
						<!-- 						</tr> -->
						<tr>
							<td><label for="pw">pw:</label></td>
							<td><input type="password" id="pw1"
								placeholder="비밀번호를 입력하세요"></br> <input type="password"
								id="pw2" placeholder="비밀번호 한 번더 입력"></br> <input
								type="button" onclick="test()" value="확인"></td>
						</tr>
						<!-- 						<tr> -->
						<!-- 							<td><label for="pw">pw:</label></td> -->
						<!-- 							<td><input class="w3-input"  -->
						<!-- 								id="pw1" type="password"  placeholder="비밀번호"></td> -->
						<!-- 						</tr> -->
						<!-- 						<tr> -->
						<!-- 							<td><label for="pw">비밀번호 확인:</label></td> -->
						<!-- 							<td><input class="w3-input"  -->
						<!-- 								id="pw1" type="password" placeholder="비밀번호 한 번 더 입력"> -->
						<!-- 							<input type="button" onclick="test()" value="확인"> -->
						<!-- 						</tr> -->
						<tr>
							<td><label for="nickname">nickname:</label></td>
							<td><input class="w3-input" type="text" id="nickname"
								name="nickname" placeholder="닉네임">
								<button type="button" onclick="NickCheck()" class="myButton">닉네임
									중복체크</button> <span id="demo2"></span></td>
						</tr>
						<tr>
							<td><label for="question">question:</label></td>
							<td><input class="w3-input" type="text" id="question"
								name="question" placeholder="질문"></td>
						</tr>
						<tr>
							<td><label for="answer">answer:</label></td>
							<td><input class="w3-input" type="text" id="answer"
								name="answer" placeholder="답"></td>
						</tr>

						<tr>
							<td><label for="name">name:</label></td>
							<td><input class="w3-input" type="text" id="name"
								name="name" placeholder="이름"></td>
						</tr>
						<tr>
							<td><label for="tel">tel:</label></td>
							<td><input class="w3-input" type="text" id="tel" name="tel"
								placeholder="010-0000-0000">
								<button type="button" onclick="TelCheck()" class="myButton">전화번호
									중복체크</button> <span id="demo3"></span></td>
						</tr>
						<tr>
							<td><label for="email">email:</label></td>
							<td><input class="w3-input" type="email" id="email"
								name="email" placeholder="aaaaa@naver.com"></td>
							<!-- 				<button type="button" onclick="EmailCheck()" class="myButton">이메일 중복체크</button> -->
							<!-- 					<span id="demo3"></span></td> -->
						</tr>
						<tr>
							<td><label for="m_file">프로필 사진선택:</label></td>
							<td><input class="w3-input" type="file" id="m_file"
								name="m_file" placeholder=" "></td>
						</tr>
						<tr>
							<button type="submit" id="joinBtn"
								class="w3-button w3-block w3-black w3-ripple w3-margin-top w3-round">Join</button>
							<button
								class="w3-button w3-block w3-black w3-ripple w3-margin-top w3-margin-bottom w3-round">
								<a href="home.do">Cancle</a>
							</button>
							<!-- 						<button type="button" onclick="history.go(-1);" class="w3-button w3-block w3-black w3-ripple w3-margin-top w3-margin-bottom w3-round">Cancel</button> -->
						</tr>
					</table>
				</form>
			</div>
		</div>
	</div>
</body>
</html>