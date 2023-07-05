<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Manage</title>
<jsp:include page="css.jsp"></jsp:include>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
<%
	String nickname = "";
	if(session.getAttribute("nickname") != null){
		nickname = (String)session.getAttribute("nickname");
	}
%>
<script type="text/javascript">
function friends_list(){		// 친구목록
	let nickname = '<%=nickname%>';
	console.log(nickname);
	
	$.ajax({
		url : "json_m_friends.do",
		data:{nickname: nickname},
		method:'GET',
		dataType:'json',
		success : function(arr) {
			console.log('ajax...success:', arr);
			
 			let tag_vos = `
					<thead>
						<tr>
							<th>닉네임</th>
							<th>채팅</th>
							<th>차단</th>
							<th>친구삭제</th>
							<th>친구등급</th>
							<th>적용</th>
						</tr>
					</thead>
					<tbody>`; 			
 			$.each(arr,function(index,vo){
 				tag_vos += `
 					<tr>
	 					<td>\${vo.nickname2}</td>
	 					<td>
	 						<button onclick="chat_selectOne.do?nickname=\${vo.nickname2}">
	 						채팅</button>
	 					</td>
	 					<td>
	 						<button onclick="add_ban('\${vo.nickname2}')" id="ban_\${vo.nickname2}">
	 						차단</button>
	 					</td>
	 					<td>
							<button onclick="del_friend('\${vo.nickname2}')" id="del_\${vo.nickname2}">
							친구삭제</button>
	 					</td>
	 					<td>
							<select id="\${vo.fnum}">
								<option value="\${vo.grade}" class="option_\${vo.grade}" selected hidden></option>
								<option value="1">1촌</option>
								<option value="2">친구</option>
							</select>
	 					</td>
	 					<td><button onclick="update_grade(\${vo.fnum}, \$('#\${vo.fnum} :selected').val())">적용</button></td>
	 				</tr>
 					`;
 			});
			
 			tag_vos += `</tbody>
 						`;
			$("#vos").html(tag_vos);
			$(".option_1").html("1촌");
			$(".option_2").html("친구");
		},
		error:function(xhr,status,error){
			console.log('xhr.status:', xhr.status);
		}
	});
}

function update_grade(fnum, grade){
	console.log(fnum, grade);
	
	if(window.confirm("적용하시겠습니까?")){
		$.ajax({
			url: "json_mng_grade.do",
			data: {fnum: fnum,
				grade: grade},
			method: "GET",
			dataType: "json",
			success: function(result){
				console.log(result);
				friends_list();
			},
			error:function(xhr,status,error){
				console.log('xhr.status:', xhr.status);
			}
		});
	}
}

function friends_ban(){	// 차단 목록 출력
	console.log('friends_ban()....');
	let nickname = '<%=nickname%>';
	
	$.ajax({
		url : "json_m_bans.do",
		data: {nickname: nickname},
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
	 					<td>\${vo.nickname2}</td>
	 					<td>
	 						<button onclick="del_ban('\${vo.nickname2}')">차단해제</button>
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

function friends_add(){ // 친구추가 화면 출력
	let tag_vos = `
		<thead>
			<tr>
				<td colspan="2">
					<input type="text" name="searchWord" id="searchWord" />
					<button onclick="searchUser()">검색</button>
				</td>
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
					


function add_friend(nickname2) {	// 친구추가 버튼
	console.log('add friend()....');
	let nickname = '<%=nickname%>';
	
	if(window.confirm("친구추가 하시겠습니까?")){
		$.ajax({
			url : "json_m_friendsAdd.do",
			data:{nickname1:nickname,
				nickname2:nickname2},
			method:'GET',
			dataType:'json',
			success : function(response) {
				console.log('ajax...success:', response.result);
				let msg = response.result === 1?'등록완료':'친구추가';
				if(response.result === 1){					// 친구등록 성공 시
					$("#txt_"+nickname2).text(msg);					// 등록완료로 변경
					$("#add_"+nickname2).prop('disabled', true);	// 친구추가 버튼 비활성화
					$("#ban_"+nickname2).prop('disabled', true);	// 차단 버튼 비활성화
				}
			},
			error:function(xhr,status,error){
				console.log('xhr.status:', xhr.status);
			}
		});
	}
}

function del_friend(nickname2) {	// 친구삭제 버튼
	console.log('del friend()....');
	let nickname = '<%=nickname%>';
	
	if(window.confirm("친구목록에서 삭제하시겠습니까?")){
		$.ajax({
			url : "json_m_friendsDel.do",
			data:{nickname1:nickname,
				nickname2:nickname2},
			method:'GET',
			dataType:'json',
			success : function(response) {
				console.log('ajax...success:', response.result);
				if(response.result === 1){		// 친구삭제 성공 시
					friends_list();
				}
			},
			error:function(xhr,status,error){
				console.log('xhr.status:', xhr.status);
			}
		});
	}
}

function searchUser(){	// 유저 검색 결과 출력
	let nickname = '<%=nickname%>';
	
	$.ajax({
		url : "json_m_searchUser.do",
		data: {nickname: nickname,
			searchWord: $('#searchWord').val()},
		method:'GET',
		dataType:'json',
		success : function(arr) {
			console.log('ajax...success:', arr);
			
 			let tag_vos = `
				<thead>
					<tr>
 						<td>
		 					<input type="text" name="searchWord" id="searchWord" />
		 					<button onclick="searchUser()">검색</button>
		 				</td>
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
 					<td id="nickname">\${vo.nickname}</td>
 					<td>
 						<button onclick="add_friend('\${vo.nickname}')" id="add_\${vo.nickname}">
 							<span id="txt_\${vo.nickname}">친구추가</span></button>
 					</td>
 					<td>
						<button onclick="new_ban('\${vo.nickname}')" id="ban_\${vo.nickname}">
						차단</button>
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

function add_ban(nickname2) {	// 친구목록에서 차단
	console.log('ban()....');
	let nickname = '<%=nickname%>';
	
	if(window.confirm("사용자를 차단하시겠습니까?")){
		$.ajax({
			url : "json_m_addban.do",
			data:{nickname1:nickname,
				nickname2:nickname2},
			method:'GET',
			dataType:'json',
			success : function(response) {
				console.log('ajax...success:', response.result);
				if(response.result === 1){		// 차단 성공 시
					friends_list();
				}
			},
			error:function(xhr,status,error){
				console.log('xhr.status:', xhr.status);
			}
		});
	}
}

function new_ban(nickname2) {	// 사용자 검색에서 차단
	console.log('ban()....');
	let nickname = '<%=nickname%>';
	
	if(window.confirm("사용자를 차단하시겠습니까?")){
		$.ajax({
			url : "json_m_newban.do",
			data:{nickname1:nickname,
				nickname2:nickname2},
			method:'GET',
			dataType:'json',
			success : function(response) {
				console.log('ajax...success:', response.result);
				if(response.result === 1){		// 차단 성공 시
					$("#ban_"+nickname2).prop('disabled', true);	// 차단 버튼 비활성화
					$("#add_"+nickname2).prop('disabled', true);	// 친구추가 버튼 비활성화
				}
			},
			error:function(xhr,status,error){
				console.log('xhr.status:', xhr.status);
			}
		});
	}
}

function del_ban(nickname2) {	// 차단 해제
	console.log('ban()....');
	let nickname = '<%=nickname%>';
	
	if(window.confirm("차단을 해제하시겠습니까?")){
		$.ajax({
			url : "json_m_delban.do",
			data:{nickname1:nickname,
				nickname2:nickname2},
			method:'GET',
			dataType:'json',
			success : function(response) {
				console.log('ajax...success:', response.result);
				if(response.result === 1){		// 차단 해제 성공 시
					friends_ban();
				}
			},
			error:function(xhr,status,error){
				console.log('xhr.status:', xhr.status);
			}
		});
	}
}
</script>
</head>
<body onload="friends_list()">
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