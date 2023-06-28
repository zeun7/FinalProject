<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Manage</title>
<jsp:include page="css.jsp"></jsp:include>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
<script type="text/javascript">
function manage_member(page){
	$.ajax({
		url : "json_mng_member.do",
		data: {page: page},
		method:'GET',
		dataType:'json',
		success : function(arr) {
			console.log('ajax...success:', arr);
			
 			let tag_vos = `
 						<thead>
							<tr>
							<th>No.</th>
							<th>ID</th>
							<th>닉네임</th>
							<th>프로필 이미지</th>
							<th>이름</th>
							<th>전화번호</th>
							<th>사용자 등급</th>
							<th>적용</th>
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
 					<td><img src="resources/uploadimg/thumb_\${vo.profilepic}"></td>
 					<td>\${vo.name}</td>
 					<td>\${vo.tel}</td>
 					<td>
						<select name="mclass" id="mclass" value="\${vo.mclass}">
							<option value="\${vo.mclass}" class="option_\${vo.mclass}" selected hidden></option>
							<option value="1">관리자</option>
							<option value="2">일반 사용자</option>
						</select>
 					</td>
 					<td><button onclick="update_mclass('\${vo.id}', \$('#mclass :selected').val(), \${page})">적용</button></td>
 				</tr>
 				`;
 			});
			
 			tag_vos += `</tbody>
 						<tfoot>
 							<tr>
 								<td colsapn="6" id="pages">
 								</td>
 							</tr>
 						</tfoot>
 						`;
			$("#vos").html(tag_vos);
			$(".option_1").html("관리자");
			$(".option_2").html("일반 사용자");
			member_pages(page);	// 페이징 버튼 출력, 현재 페이지 넘겨줌
		},
		error:function(xhr,status,error){
			console.log('xhr.status:', xhr.status);
		}
	});
}

function update_mclass(id, mclass, page){
	console.log(id, mclass, page);
	$.ajax({
		url: "json_mng_mclass.do",
		data: {id: id,
			mclass: mclass},
		method: "GET",
		dataType: "json",
		success: function(result){
			manage_member(page);
		}
	});
}

function member_pages(page){
	$.ajax({
		url: "json_mng_mcount.do",
		method: 'GET',
		dataType: 'json',
		success: function(count){
			console.log('ajax...success', count);
			
			let page_bttn = '';
 			let index = 1;
 			while(count > 0){
 				page_bttn += `<button onclick="manage_member(\${index})" id="page_\${index}">
 								\${index}
 							</button>`;
 				index++;
 				count -= 10;	// 한 페이지에 10개씩 출력
 			}
 			$("#pages").html(page_bttn);
 			$("#page_"+page).css("background-color", "skyblue");
		}
	});
}

function manage_board(page){
	$.ajax({
		url : "json_mng_board.do",
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
							<th>게시글 삭제</th>
							<th>완료</th>
							</tr>
						</thead>
						<tbody>`; 			
 			$.each(arr,function(index,vo){
 				tag_vos += `
 					<tr>
 					<td>\${vo.bnum}</td>
 					<td><a href="b_selectOne.do?bnum=\${vo.bnum}">\${vo.title}</a></td>
 					<td>\${vo.writer}</td>
 					<td>\${vo.reason}</td>
 					<td><button onclick="location.href='b_deleteOK.do?bnum=\${vo.bnum}'">삭제</button></td>
 					<td><button onclick="del_report(\${vo.rnum}, 'board')">완료</button></td>
 				</tr>
 				`;
 			});
			
 			tag_vos += `</tbody>
		 				<tfoot>
							<tr>
								<td colsapn="6" id="pages">
								</td>
							</tr>
						</tfoot>
						`;
			$("#vos").html(tag_vos);
			board_pages(page);
		},
		error:function(xhr,status,error){
			console.log('xhr.status:', xhr.status);
		}
	});
}

function board_pages(page){
	$.ajax({
		url: "json_mng_bcount.do",
		method: 'GET',
		dataType: 'json',
		success: function(count){
			console.log('ajax...success', count);
			
			let page_bttn = '';
 			let index = 1;
 			while(count > 0){
 				page_bttn += `<button onclick="manage_board(\${index})" id="page_\${index}">
 								\${index}
 							</button>`;
 				index++;
 				count -= 20;	// 한 페이지에 20개씩 출력
 			}
 			$("#pages").html(page_bttn);
 			$("#page_"+page).css("background-color", "skyblue");
		}
	});
}

function manage_comments(page){
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
							<th>댓글 삭제</th>
							<th>완료</th>
							</tr>
						</thead>
						<tbody>`; 			
 			$.each(arr,function(index,vo){
 				tag_vos += `
 					<tr>
 					<td>\${vo.cnum}</td>
 					<td><a href="b_selectOne.do?bnum=\${vo.bnum}">\${vo.content}</a></td>
 					<td>\${vo.writer}</td>
 					<td>\${vo.reason}</td>
 					<td><button onclick="location.href='c_deleteOK.do?cnum=\${vo.cnum}'">삭제</button></td>
 					<td><button onclick="del_report(\${vo.rnum}, 'comments')">완료</button></td>
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

function del_report(rnum, category){
	$.ajax({
		url: 'json_report_deleteOK.do',
		data: {rnum: rnum},
		method: 'GET',
		dataType: 'json',
		success: function(result){
			console.log(result);
			if(category === 'board')
				manage_board(1);
			else
				manage_comments(1);
		}
	});
}
</script>
</head>
<body>
	<jsp:include page="top_menu.jsp"></jsp:include>
	<ul>
		<li><button onclick="manage_member(1)">회원관리</button></li>
		<li><button onclick="manage_board(1)">신고 게시글</button></li>
		<li><button onclick="manage_comments(1)">신고 댓글</button></li>
	</ul>
	<table id="vos">
	</table>
</body>
</html>