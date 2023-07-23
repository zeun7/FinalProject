<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리</title>
<link rel="stylesheet" href="resources/css/button.css">
<link rel="stylesheet" href="resources/css/button2.css">
<link rel="stylesheet" href="resources/css/pagination.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
<script src="https://kit.fontawesome.com/7ed6703c9d.js" crossorigin="anonymous"></script>
<script type="text/javascript">
function manage_member(page){	// 회원목록 출력
	console.log('manage member...');
	$.ajax({
		url : "json_mng_member.do",
		data: {page: page},
		method:'GET',
		dataType:'json',
		success : function(arr) {
			console.log('ajax...success:', arr);
			
 			let tag_vos = `
 						<thead class="text-primary">
							<tr>
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
 						<a href="m_selectOne.do?id=\${vo.id}">\${vo.id}</a>
 					</td>
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
 					<td><button class="btn-gradient cyan mini" onclick="update_mclass('\${vo.id}', \$('#\${vo.id} :selected').val(), \${page})">적용</button></td>
 				</tr>
 				`;
 			});
			
 			tag_vos += `</tbody>
 						<tfoot>
 							<tr>
 								<td colspan="7" id="pages" style="text-align:center;">
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
	console.log('update mclass...id:', id, 'mclass:', mclass, 'page:',page);
	
	if(window.confirm("적용하시겠습니까?")){
		$.ajax({
			url: "json_mng_mclass.do",
			data: {id: id,
				mclass: mclass},
			method: "POST",
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
	console.log('print manage member page button...');
	$.ajax({
		url: "json_mng_mcount.do",
		method: 'GET',
		dataType: 'json',
		success: function(count){
			console.log('ajax...success', count);
			
			let page_bttn = '';
 			let index = 1;
 			while(count > 0){
 				page_bttn += `<button class="paging-btn" onclick="manage_member(\${index})" id="page_\${index}">
 								\${index}
 							</button>`;
 				index++;
 				count -= 10;	// 한 페이지에 10개씩 출력
 			}
 			$("#pages").html(page_bttn);
 			$("#page_"+page).css("background-color", "#89d8d3");
		},
		error:function(xhr,status,error){
			console.log('xhr.status:', xhr.status);
		}
	});
}

function manage_board(page){	// 신고 게시글 목록
	console.log('manage board...');
	$.ajax({
		url : "json_mng_board.do",
		method:'GET',
		dataType:'json',
		success : function(arr) {
			console.log('ajax...success:', arr);
			
 			let tag_vos = `
 						<thead class="text-primary" style="text-align:center;">
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
 					<tr style="text-align:center;">
 					<td>\${vo.rnum}</td>
 					<td><a href="mng_selectOne.do?bnum=\${vo.bnum}&mbnum=\${vo.mbnum}&id=\${vo.id}">\${vo.title}</a></td>
 					<td>\${vo.writer}</td>
 					<td>\${vo.reason}</td>
 					<td><button class="btn-gradient red mini" onclick="del_board(\${vo.bnum}, \${page})">삭제</button></td>
 					<td><button class="btn-gradient orange mini" onclick="del_b_report(\${vo.rnum}, \${page})">완료</button></td>
 				</tr>
 				`;
 			});
			
 			tag_vos += `</tbody>
		 				<tfoot>
							<tr>
								<td colspan="7" id="pages" style="text-align:center;">
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
	console.log('print manage board page button...');
	$.ajax({
		url: "json_mng_bcount.do",
		method: 'GET',
		dataType: 'json',
		success: function(count){
			console.log('ajax...success', count);
			
			let page_bttn = '';
 			let index = 1;
 			while(count > 0){
 				page_bttn += `<button class="paging-btn" onclick="manage_board(\${index})" id="page_\${index}">
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
	console.log('delete board... bnum:', bnum, 'page:', page);
	if(window.confirm("해당 게시글을 삭제하시겠습니까?")){
		$.ajax({
			url: "json_mng_b_deleteOK.do",
			data: {bnum: bnum},
			method: "GET",
			dataType: "json",
			success: function(result){
				manage_board(page);
			},
			error:function(xhr,status,error){
				console.log('xhr.status:', xhr.status);
			}
		});
	}
}

function manage_comments(page){	// 신고 댓글 목록 출력
	console.log('manage comments...');
	$.ajax({
		url : "json_mng_comments.do",
		method:'GET',
		dataType:'json',
		success : function(arr) {
			console.log('ajax...success:', arr);
			
 			let tag_vos = `
 						<thead class="text-primary" style="text-align:center;">
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
 					<tr style="text-align:center;">
 					<td>\${vo.rnum}</td>
 					<td><a href="mng_selectOne.do?bnum=\${vo.bnum}&mbnum=\${vo.mbnum}&id=\${vo.id}">\${vo.content}</a></td>
 					<td>\${vo.writer}</td>
 					<td>\${vo.reason}</td>
 					<td><button class="btn-gradient red mini" onclick="del_comments(\${vo.cnum}, \${vo.ccnum}, \${page})">삭제</button></td>
 					<td><button class="btn-gradient orange mini" onclick="del_c_report(\${vo.rnum}, \${page})">완료</button></td>
 				</tr>
 				`;
 			});
			
 			tag_vos += `</tbody>
 				<tfoot>
 					<tr>
						<td colspan="7" id="pages" style="text-align:center;">
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
	console.log('print manage comments page button...');
	$.ajax({
		url: "json_mng_ccount.do",
		method: 'GET',
		dataType: 'json',
		success: function(count){
			console.log('ajax...success', count);
			
			let page_bttn = '';
 			let index = 1;
 			while(count > 0){
 				page_bttn += `<button class="paging-btn" onclick="manage_comments(\${index})" id="page_\${index}">
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

function del_comments(cnum, ccnum, page){	// 신고 댓글 삭제 버튼
	console.log('delete comments cnum:', cnum, 'ccnum:', ccnum, 'page:', page);
	if(window.confirm("해당 댓글을 삭제하시겠습니까?")){
		$.ajax({
			url: "json_mng_c_deleteOK.do",
			data: {cnum: cnum,
				ccnum: ccnum},
			method: "GET",
			dataType: "json",
			success: function(){
				manage_comments(page);
			},
			error:function(xhr,status,error){
				console.log('xhr.status:', xhr.status);
			}
		});
	}
}

function del_b_report(rnum, page){	// 게시글 신고 대응 완료 버튼
	console.log('delete board report... rnum:', rnum, 'page:', page);
	if(window.confirm("해당 신고를 완료처리하시겠습니까?")){
		$.ajax({
			url: 'json_b_report_deleteOK.do',
			data: {rnum: rnum},
			method: 'GET',
			dataType: 'json',
			success: function(result){
				console.log(result);
				manage_board(page);
			},
			error:function(xhr,status,error){
				console.log('xhr.status:', xhr.status);
			}
		});
	}
}

function del_c_report(rnum, page){	// 댓글 신고 대응 완료 버튼
	console.log('delete comments report... rnum:', rnum, 'page:', page);
	if(window.confirm("해당 신고를 완료처리하시겠습니까?")){
		$.ajax({
			url: 'json_c_report_deleteOK.do',
			data: {rnum: rnum},
			method: 'GET',
			dataType: 'json',
			success: function(result){
				console.log(result);
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
<body onload="manage_member(1)">
<jsp:include page="sidebar.jsp"></jsp:include>
<div class="main-panel"
style="background-image: url('resources/AI_Backimg/Manage.png'); background-size:cover; background-repeat:no-repeat;">
<jsp:include page="navbar.jsp"></jsp:include>
	<div class="content">
		<div class="row">
			<div class="col-md-12">
				<div class="card" style="background-color: rgba(255, 255, 255, 0.9);">
					<div class="card-header">
					<ul class="menu" style="list-style-type: none; display: flex; justify-content: center; align-items: center;">
						<li><button class="custom-btn btn-16" style="color: #ff80c0; font-size: 15px; font-weight: bold;" onclick="manage_member(1)">회원관리</button></li>
						<li><button class="custom-btn btn-16" style="width: 200px; color: #ff80c0; font-size: 15px; font-weight: bold;" onclick="manage_board(1)">신고 게시글</button></li>
						<li><button class="custom-btn btn-16" style="color: #ff80c0; font-size: 15px; font-weight: bold;" onclick="manage_comments(1)">신고 댓글</button></li>
					</ul>
					</div>
					<div class="card-body">
						<table class="table" id="vos">
						</table>
					</div>
				</div>
			</div>
		</div>
	</div>
	<jsp:include page="footer.jsp"></jsp:include>
</div>
</body>
</html>