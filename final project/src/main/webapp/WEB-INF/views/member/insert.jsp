<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>insert</title>
<jsp:include page="../css.jsp"></jsp:include>

<!-- <script -->
<!-- 	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script> -->
<!-- <script type="text/javascript"> -->

<!-- //  $(function(){ -->
<!-- //  	console.log("onload...."); -->
<!-- //  }); -->

<!-- //  function idCheck(){ -->
<!-- //  	console.log("idCheck....",$('#id').val()); -->
	
<!-- //  	$.ajax({ -->
<!-- //  		url : "json_m_idCheck.do", -->
<!-- //  		data:{id:$('#id').val()}, -->
<!-- //  		method:'GET', -->
<!-- //  		dataType:'json', -->
<!-- //  		success : function(obj) { -->
<!-- //  			console.log('ajax...success:', obj); -->
<!-- //  			console.log('ajax...success:', obj.result); -->
<!-- //  			let msg = ''; -->
<!-- //  			if(obj.result==='OK'){ -->
<!-- //  				msg = '사용가능한 아이디입니다.'; -->
<!-- //  			}else{ -->
<!-- //  				msg = '사용중인 아이디입니다.'; -->
<!-- //  			} -->
<!-- //  			$('#demo1').text(msg); -->
<!-- //  		}, -->
<!-- //  		error:function(xhr,status,error){ -->
<!-- //  			console.log('xhr.status:', xhr.status); -->
<!-- //  		} -->
<!-- //  	});//end $.ajax()... -->
	
<!-- //  }//end idCheck()... -->

<!-- //  function NickCheck(){ -->
<!-- //  	console.log("NickCheck....",$('#nickname').val()); -->
	
<!-- //  	$.ajax({ -->
<!-- //  		url : "json_m_NickCheck.do", -->
<!-- //  		data:{nickname:$('#nickname').val()}, -->
<!-- //  		method:'GET', -->
<!-- //  		dataType:'json', -->
<!-- //  		success : function(obj) { -->
<!-- //  			console.log('ajax...success:', obj); -->
<!-- //  			console.log('ajax...success:', obj.result); -->
<!-- //  			let msg = ''; -->
<!-- //  			if(obj.result==='OK'){ -->
<!-- //  				msg = '사용가능한 닉네임입니다.'; -->
<!-- //  			}else{ -->
<!-- //  				msg = '사용중인 닉네임입니다.'; -->
<!-- //  			} -->
<!-- //  			$('#demo2').text(msg); -->
<!-- //  		}, -->
<!-- //  		error:function(xhr,status,error){ -->
<!-- //  			console.log('xhr.status:', xhr.status); -->
<!-- //  		} -->
<!-- //  	});//end $.ajax()... -->
	
<!-- //  }//end NickCheck()... -->

<!-- </script> -->
</head>
<body>
	<jsp:include page="../top_menu.jsp"></jsp:include>
	<h1>회원가입</h1>
	
	<form action="m_insertOK.do" method="post" enctype="multipart/form-data">
		<table id="memberList">
			<tr>
				<td><label for="id">id:</label></td>
				<td><input type="text" id="id" name="id" value="tester">
				<button type="button" onclick="idCheck()" class="myButton">ID중복체크</button>
					<span id="demo1"></span></td>
			</tr>
			<tr>
				<td><label for="pw">pw:</label></td>
				<td><input type="password" id="pw" name="pw" value="hi11"></td>
			</tr>
			<tr>
				<td><label for="nickname">nickname:</label></td>
				<td><input type="text" id="nickname" name="nickname" value="필수로 입력하세요">
				<button type="button" onclick="NickCheck()" class="myButton">닉네임 중복체크</button>
					<span id="demo2"></span></td>
			</tr>
			<tr>
				<td><label for="question">question:</label></td>
				<td><input type="text" id="text" name="text" value="기억에 남은 일이 뭐야?"></td>
			</tr>
			<tr>
				<td><label for="answer">answer:</label></td>
				<td><input type="text" id="answer" name="answer" value="필수로 입력"></td>
			</tr>
			
			<tr>
				<td><label for="minaddr">minaddr:</label></td>
				<td><input type="url" id="minaddr" name="minaddr" value="필수로 입력"></td>
			</tr>
			<tr>
				<td><label for="name">name:</label></td>
				<td><input type="text" id="name" name="name" value="yang양"></td>
			</tr>
			<tr>
				<td><label for="tel">tel:</label></td>
				<td><input type="text" id="tel" name="tel" value="011"></td>
			</tr>
			<tr>
				<td><label for="email">email:</label></td>
				<td><input type="email" id="email" name="email" value="aaaaa@naver.com"></td>
			</tr>
			<tr>
				<td><label for="file">프로필 사진선택:</label></td>
				<td><input type="file" id="file" name="file" value=""></td>
			</tr>
			<tr>
				<td colspan="2"><input type="submit" class="myButton"></td>
			</tr>
		</table>
	</form>
</body>
</html>