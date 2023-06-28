<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Manage</title>
<jsp:include page="css.jsp"></jsp:include>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
<script type="text/javascript">
function manage_member(page){	// 회원목록 출력
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
						<select id="\${vo.id}">
							<option value="\${vo.mclass}" class="option_\${vo.mclass}" selected hidden></option>
							<option value="1">관리자</option>
							<option value="2">일반 사용자</option>
						</select>
 					</td>
 					<td><button onclick="update_mclass('\${vo.id}', \$('#\${vo.id} :selected').val(), \${page})">적용</button></td>
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

function update_mclass(id, mclass, page){	// 회원등급 변경 버튼
	console.log(id, mclass, page);
	
	if(wondow.confirm("적용하시겠습니까?")){
		$.ajax({
			url: "json_mng_mclass.do",
			data: {id: id,
				mclass: mclass},
			method: "GET",
			dataType: "json",
			success: function(result){
				manage_member(page);
			},
			error:function(xhr,status,error){
				console.log('xhr.status:', xhr.status);
			}
		});
	}
}

function member_pages(page){	// 회원목록의 페이징 버튼 출력
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
		},
		error:function(xhr,status,error){
			console.log('xhr.status:', xhr.status);
		}
	});
}

function manage_board(page){	// 신고 게시글 목록
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
 					<td><button onclick="del_board=(\${vo.bnum}, \${page}">삭제</button></td>
 					<td><button onclick="del_report(\${vo.rnum}, 'board', \${page})">완료</button></td>
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

function board_pages(page){	// 신고 게시글 목록 페이징 버튼 출력
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
		},
		error:function(xhr,status,error){
			console.log('xhr.status:', xhr.status);
		}
	});
}

function del_board(bnum, page){	// 신고 게시글 삭제 버튼
	if(window.confirm("해당 게시글을 삭제하시겠습니까?")){
		$.ajax({
			url: "b_deletOK",
			data: {bnum, bnum},
			method: "GET",
			dataType: "json",
			success: function(){
				board_pages(page);
			},
			error:function(xhr,status,error){
				console.log('xhr.status:', xhr.status);
			}
		});
	}
}

function manage_comments(page){	// 신고 댓글 목록 출력
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
 					<td><button onclick="del_comments(\${vo.cnum}, \${page})">삭제</button></td>
 					<td><button onclick="del_report(\${vo.rnum}, 'comments', \${page})">완료</button></td>
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
			comments_pages(page);
		},
		error:function(xhr,status,error){
			console.log('xhr.status:', xhr.status);
		}
	});
}

function comments_pages(page){	// 신고 댓글 목록 페이징 버튼 출력
	$.ajax({
		url: "json_mng_ccount.do",
		method: 'GET',
		dataType: 'json',
		success: function(count){
			console.log('ajax...success', count);
			
			let page_bttn = '';
 			let index = 1;
 			while(count > 0){
 				page_bttn += `<button onclick="manage_comments(\${index})" id="page_\${index}">
 								\${index}
 							</button>`;
 				index++;
 				count -= 20;	// 한 페이지에 20개씩 출력
 			}
 			$("#pages").html(page_bttn);
 			$("#page_"+page).css("background-color", "skyblue");
		},
		error:function(xhr,status,error){
			console.log('xhr.status:', xhr.status);
		}
	});
}

function del_comments(cnum, page){	// 신고 댓글 삭제 버튼
	if(window.confirm("해당 댓글을 삭제하시겠습니까?")){
		$.ajax({
			url: "c_deletOK",
			data: {cnum, cnum},
			method: "GET",
			dataType: "json",
			success: function(){
				comments_pages(page);
			},
			error:function(xhr,status,error){
				console.log('xhr.status:', xhr.status);
			}
		});
	}
}

function del_report(rnum, category, page){	// 신고 대응 완료 버튼
	if(window.confirm("해당 신고를 완료처리하시겠습니까?")){
		$.ajax({
			url: 'json_report_deleteOK.do',
			data: {rnum: rnum},
			method: 'GET',
			dataType: 'json',
			success: function(result){
				console.log(result);
				if(category === 'board')
					manage_board(page);
				else
					manage_comments(page);
			},
			error:function(xhr,status,error){
				console.log('xhr.status:', xhr.status);
			}
		});
	}
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