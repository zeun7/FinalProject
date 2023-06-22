<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Manage</title>
<jsp:include page="css.jsp"></jsp:include>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
<script type="text/javascript">
function friends_list(){
	$.ajax({
		url : "json_m_friends.do",
		method:'GET',
		dataType:'json',
		success : function(arr) {
			console.log('ajax...success:', arr);
			
 			let tag_vos = `
					<thead>
						<tr>
							<th>친구등급</th>
							<th>닉네임</th>
							<th>채팅</th>
							<th>차단하기</th>
							<th>친구삭제</th>
						</tr>
					</thead>
					<tbody>`; 			
 			$.each(arr,function(index,vo){
 				tag_vos += `
 					<tr>
	 					<td>\${vo.nickname}</td>
	 					<td>\${vo.grade}</td>
	 					<td>
	 						<button onclick="chat_selectOne.do?nickname=\${vo.nickname}">채팅</button>
	 					</td>
	 					<td>
							<button onclick="del_friends()">친구삭제</button>
	 					</td>
	 				</tr>
 					`;
 			});
			
 			tag_vos += `</tbody>
 						`;
			$("#vos").html(tag_vos);
		},
		error:function(xhr,status,error){
			console.log('xhr.status:', xhr.status);
		}
	});
}

function friends_ban(){
	$.ajax({
		url : "json_m_bans.do",
		method:'GET',
		dataType:'json',
		success : function(arr) {
			console.log('ajax...success:', arr);
			
 			let tag_vos = `
					<thead>
						<tr>
							<th>닉네임</th>
							<th>차단해제</th>
						</tr>
					</thead>
					<tbody>`; 			
 			$.each(arr,function(index,vo){
 				tag_vos += `
 					<tr>
 					<td>\${vo.nickname}</td>
 					<td>
 						<button onclick="location.href='m_bansDel?nickname=\${vo.nickname}'">차단해제</button>
 					</td>
 				</tr>
 				`;
 			});
			
 			tag_vos += `</tbody>
 						`;
			$("#vos").html(tag_vos);
		},
		error:function(xhr,status,error){
			console.log('xhr.status:', xhr.status);
		}
	});
}

function friends_add(){
	let tag_vos = `
		<thead>
			<tr>
				<input type="text" name="nickname" id="nickname" />
				<button onclick="searchUser()">검색</button>
			</tr>
			<tr>
				<th>닉네임</th>
				<th>친구추가</th>
				<th>차단</th>
			</tr>
		</thead>
		<tbody>`; 	

	tag_vos += `</tbody>
			`;
	$("#vos").html(tag_vos);
}
					
function searchUser(){
	$.ajax({
		url : "json_mng_comments.do",
		method:'GET',
		dataType:'json',
		success : function(arr) {
			console.log('ajax...success:', arr);
			
 			let tag_vos = `
					<thead>
 						<tr>
		 					<input type="text" name="nickname" id="nickname" />
		 					<button onclick="searchUser()">검색</button>
 						</tr>
						<tr>
							<th>닉네임</th>
							<th>친구추가</th>
							<th>차단</th>
						</tr>
					</thead>
					<tbody>`; 			
 			$.each(arr,function(index,vo){
 				tag_vos += `
 					<tr>
 					<td>\${vo.nickname}</td>
 					<td>
 						<button onclick="location.href='m_friendsAdd.do?nickname=\${vo.nickname}'">친구추가</button>
 					</td>
 					<td>
 						<button onclick="location.href='m_ban?nickname=\${vo.nickname}'">차단</button>
 					</td>
 				</tr>
 				`;
 			});
			
 			tag_vos += `</tbody>
 						`;
			$("#vos").html(tag_vos);
		},
		error:function(xhr,status,error){
			console.log('xhr.status:', xhr.status);
		}
	});
}
</script>
</head>
<body>
	<jsp:include page="top_menu.jsp"></jsp:include>
	<ul>
		<li><button onclick="friends_list()">친구목록</button></li>
		<li><button onclick="friends_ban()">차단목록</button></li>
		<li><button onclick="friends_add()">친구추가</button></li>
	</ul>
	<table id="vos">
	</table>
</body>
</html>