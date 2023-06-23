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
					msg = '사용가능한 닉네임입니다.';
				} else {
					msg = '사용중인 닉네임입니다.';
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
						<tr>
							<td><label for="pw">pw:</label></td>
							<td><input class="w3-input" type="password" id="pw"
								name="pw" placeholder="비밀번호"></td>
						</tr>
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
								placeholder="010-0000-0000"></td>
						</tr>
						<tr>
							<td><label for="email">email:</label></td>
							<td><input class="w3-input" type="email" id="email"
								name="email" placeholder="aaaaa@naver.com"></td>
							<!-- 				<button type="button" onclick="EmailCheck()" class="myButton">이메일 중복체크</button> -->
							<!-- 					<span id="demo3"></span></td> -->
						</tr>
						<tr>
							<td><label for="file">프로필 사진선택:</label></td>
							<td><input class="w3-input" type="file" id="file"
								name="file" placeholder=" "></td>
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