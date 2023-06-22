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
							<th>No.</th>
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
 					<td>				
 						<a href="m_selectOne.do?num=\${vo.num}">\${vo.num}</a>
 					</td>
 					<td>\${vo.id}</td>
 					<td>\${vo.nickname}</td>
 					<td>\${vo.profliepic}</td>
 					<td>\${vo.name}</td>
 					<td>\${vo.tel}</td>
 					<td>\${vo.miniaddr}</td>
 					<td>\${vo.mclass}</td>
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
						<th>No.</th>
						<th>제목</th>
						<th>작성자</th>
						<th>신고사유</th>
						<th>삭제</th>
						</tr>
					</thead>
					<tbody>`; 			
 			$.each(arr,function(index,vo){
 				tag_vos += `
 					<tr>
 					<td>\${vo.bnum}</td>
 					<td><a href="b_selectOne.do?bnum=\${vo.bnum}">\${vo.title}</a></td>
 					<td>\${vo.writer}</td>
 					<td>\${vo.reportreason}</td>
 					<td><button onclick="location.href='b_deleteOK.do?bnum=\${vo.bnum}'">삭제</button></td>
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
	$.ajax({
		url : "json_mng_comments.do",
		method:'GET',
		dataType:'json',
		success : function(arr) {
			console.log('ajax...success:', arr);
			
 			let tag_vos = `
					<thead>
						<tr>
						<th>No.</th>
						<th>댓글 내용</th>
						<th>작성자</th>
						<th>신고사유</th>
						<th>삭제</th>
						</tr>
					</thead>
					<tbody>`; 			
 			$.each(arr,function(index,vo){
 				tag_vos += `
 					<tr>
 					<td>\${vo.cnum}</td>
 					<td><a href="b_selectOne.do?bnum=\${vo.bnum}">\${vo.content}</a></td>
 					<td>\${vo.writer}</td>
 					<td>\${vo.reportreason}</td>
 					<td><button onclick="location.href='c_deleteOK.do?cnum=\${vo.cnum}'">삭제</button></td>
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
		<li><button onclick="friends_list()">회원관리</button></li>
		<li><button onclick="friends_ban()">신고 게시글</button></li>
		<li><button onclick="friends_add()">신고 댓글</button></li>
	</ul>
	<table id="vos">
	</table>
</body>
</html>