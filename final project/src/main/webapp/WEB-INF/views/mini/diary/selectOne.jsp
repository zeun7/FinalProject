<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<html>
<head>
<title>다이어리_selectOne</title>
<jsp:include page="../../css.jsp"></jsp:include>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
<script type="text/javascript">
function minicomments(mcnum=0, mccnum=0, mbnum=${param.mbnum}, insert_num=0){	// 댓글 출력 함수
	console.log("print minicomments...mbnum: ", mbnum);
	$.ajax({
		url: 'json_mc_selectAll.do',
		data: {mbnum: mbnum},
		method: 'GET',
		dataType: 'json',
		success: function(arr){
			let tag_comments = '';
			
			$.each(arr, function(index, vo){
				tag_comments += `
					<tr>
						<td colspan="6"><hr /></td>
					</tr>
					<tr>
						<td rowspan="2">\${vo.writer}</td>`;
					
				if(cnum === vo.cnum){
					tag_comments += `<td rowspan="2"><input type="text" id="comm_content" value="\${vo.content}"/><td>
						<td rowspan="2"><button onclick="mc_updateOK(\${vo.mcnum})">수정완료</button></td>`;
				}
				else{
					tag_comments += `<td rowspan="2">\${vo.content}</td>`;
				}
					
				tag_comments += `<td><button onclick="clike(\${vo.mcnum})" id="clike_\${vo.mcnum}"><img width="15px" src="resources/icon/not_clike.png" /></button>
						<button onclick="cancel_clike(\${vo.mcnum})" id="cancel_clike_\${vo.mcnum}"><img width="15px" src="resources/icon/cliked.png" /></button></td>
						<td><div id="count_clikes_\${vo.mcnum}"></div></td>
						<td><button onclick="minicomments(0, 0, \${mbnum}, \${vo.mcnum})">답글</button></td>
						<td><button onclick="mc_report(\${vo.mcnum}, \${vo.mccnum}, \${mbnum})">신고</button></td>
					</tr>
					<tr>
						<td><button onclick="minicomments(\${vo.mcnum}, \${vo.mccnum}, \${mbnum})" id="mc_update_\${vo.mcnum}">수정</button></td>
						<td><button onclick="mc_deleteOK(\${vo.mcnum})" id="mc_delete_\${vo.mcnum}">삭제</button></td>
						<td>\${vo.vdate}</td>
					</tr>
					<tr><td colspan="6"><div id="minicocomments_\${vo.mcnum}"></div></td></tr>`;	// 대댓글 출력 위치
				
				if(insert_num === vo.mcnum){	// 대댓글 작성
					tag_comments += `<tr>
						<td><img width="15px" src="resources/icon/cocomment.png" /></td>
						<td colspan="3"><input type="text" id="comm_content" /></td>
						<td><button onclick="mc_insertOK(\${vo.mcnum}, \${mbnum})">등록</button></td>
						<td><button onclick="minicomments(0, 0, \${mbnum}, 0)">취소</button></td>
					</tr>`; // 대댓글 입력창 출력 위치
				}
			});
			
			if(insert_num === 0){	// 답글을 누르지 않았을 때
				tag_comments += `<tr>
					<td colspan="5"><input type="text" id="comm_content" /></td>
					<td><button onclick="mc_insertOK(0, \${mbnum})">등록</button></td>
				</tr>`;
			}
			
			
			
			$("#minicomments").html(tag_comments);
			
			$.each(arr, function(index, vo){
				minicocomments(vo.mcnum, mbnum, mcnum);	// 대댓글 출력 함수 호출
				is_clike(vo.mcnum);					// 댓글 좋아요 확인
				count_clikes(vo.mcnum);				// 좋아요 카운트
				
				if('${user_id}' === vo.writer || '${mclass}' === '1'){	// 작성자와 관리자에게만 노출
					$("#mc_update_"+vo.mcnum).show();
					$("#mc_delete_"+vo.mcnum).show();
				}
				else{
					$("#mc_update_"+vo.mcnum).hide();
					$("#mc_delete_"+vo.mcnum).hide();
				}
				
				if(mcnum === vo.mcnum){				// 수정중에는 수정버튼 숨김
					$("#mc_update_"+vo.mcnum).hide();
				}
			});
		},
		error : function(xhr, status, error) {
			console.log('xhr:', xhr.status);
		}
	});
}

function minicocomments(mcnum, mbnum=${param.mbnum}, update_num){		// 대댓글 출력 함수
	console.log('print cocomments...mcnum:', mcnum, 'mbnum: ', mbnum);
	$.ajax({
		url: 'json_mcc_selectAll.do',
		data: {mcnum: mcnum},
		method: 'GET',
		dataType: 'json',
		success: function(arr){
			let tag_cocomments = '';
			
			$.each(arr, function(index, vo){
				tag_cocomments += `
					<tr><td colspan="6"><hr /></td></tr>
					<tr>
						<td><img width="15px" src="resources/icon/cocomment.png" /></td>
						<td>
							<table>
								<tbody>
									<tr>
										<td rowspan="2">\${vo.writer}</td>`;
										
				if(update_num === vo.mcnum){
					tag_cocomments += `<td rowspan="2"><input type="text" id="comm_content" value="\${vo.content}"/><td>
						<td rowspan="2"><button onclick="mc_updateOK(\${vo.mcnum})">수정완료</button></td>`;
				}
				else{
					tag_cocomments += `<td rowspan="2">\${vo.content}</td>`;
				}
				
				tag_cocomments += `		<td><button onclick="clike(\${vo.mcnum})" id="clike_\${vo.mcnum}"><img width="15px" src="resources/icon/not_clike.png" /></button>
										<button onclick="cancel_clike(\${vo.mcnum})" id="cancel_clike_\${vo.mcnum}"><img width="15px" src="resources/icon/cliked.png" /></button></td>
										<td><div id="count_clikes_\${vo.mcnum}"></div></td>
										<td><button onclick="mc_report(\${vo.mcnum}, \${vo.mccnum}, \${mbnum})">신고</button></td>
									</tr>
									<tr>
										<td><button onclick="minicomments(\${vo.mcnum}, \${mbnum})" id="mc_update_\${vo.mcnum}">수정</button></td>
										<td><button onclick="mc_deleteOK(\${vo.mcnum})" id="mc_delete_\${vo.mcnum}">삭제</button></td>
										<td>\${vo.vdate}</td>
									</tr>
								</tbody>
							</table>
						</td>
					</tr>`;
				
			});
			
			$("#minicocomments_"+mcnum).html(tag_cocomments);
			
			$.each(arr, function(index, vo){
				is_clike(vo.mcnum);		// 댓글 좋아요 확인
				count_clikes(vo.mcnum);	// 좋아요 카운트
				
				if('${user_id}' === vo.writer || '${mclass}' === '1'){	// 작성자와 관리자에게만 노출
					$("#mc_update_"+vo.mcnum).show();
					$("#mc_delete_"+vo.mcnum).show();
				}
				else{
					$("#mc_update_"+vo.mcnum).hide();
					$("#mc_delete_"+vo.mcnum).hide();
				}
				
				if(update_num === vo.mcnum){		// 수정중에는 수정 버튼 숨김
					$("#mc_update_"+vo.mcnum).hide();
				}
			});
		},
		error : function(xhr, status, error) {
			console.log('xhr:', xhr.status);
		}
	});
}

function mc_insertOK(mcnum, mbnum){		// 댓글 등록 버튼
	console.log('insert comment...');
	
	$.ajax({
		url: 'json_mc_insertOK.do',
		data: {mcnum: mcnum,
			mbnum: mbnum,
			writer: '${user_id}',
			content: $("#comm_content").val()},
		method: 'POST',
		dataType: 'json',
		success: function(response){
			if(response.result == 1){
				minicomments();
			}
		},
		error : function(xhr, status, error) {
			console.log('xhr:', xhr.status);
		}
	});
}

function mc_updateOK(mcnum){		// 댓글 수정 완료 버튼
	console.log('update comment...mcnum: ', mcnum);
	
	$.ajax({
		url: 'json_mc_updateOK.do',
		data:{mcnum: mcnum,
			content: $("#comm_content").val()},
		method: 'POST',
		dataType: 'json',
		success: function(response){
			if(response.result == 1){
				minicomments();
			}
		},
		error: function(xhr, status, error){
			console.log('xhr:', xhr.status);
		}
	});
}

function mc_deleteOK(mcnum){		// 댓글 삭제
	console.log('delete comment...mcnum: ', mcnum);
	
	if(window.confirm("댓글을 삭제하시겠습니까?")){
		$.ajax({
			url: 'json_mc_deleteOK.do',
			data: {mcnum: mcnum},
			method: 'POST',
			dataType: 'json',
			success: function(response){
				if(response.result === 1){
					minicomments();
				}
			},
			error: function(xhr, status, error){
				console.log('xhr:', xhr.status);
			}
		});
	}
}

function mc_report(mcnum, mccnum, mbnum){	// 댓글 신고하기
	console.log('report comment...mcnum: ', mcnum, 'mccnum: ', mccnum, 'mbnum: ');
	
	let url = "mc_report.do?mcnum="+mcnum+'&mccnum='+mccnum+'&mbnum='+mbnum;
	let name = "신고하기";
	let option = "width = 400, height = 500";
	window.open(url, name, option);
}

function is_clike(mcnum){		// 유저가 해당 댓글의 좋아요를 눌렀는지 체크
	console.log('check clikes...mcnum: ', mcnum);
	
	$.ajax({
		url: 'json_mc_is_clike.do',
		data: {mcnum: mcnum,
			id: '${user_id}'},
		method: 'POST',
		dataType: 'json',
		success: function(result){
			if(result === 0){
				$("#clike_"+mcnum).show();
				$("#cancel_clike_"+mcnum).hide();
			}
			else{
				$("#clike_"+mcnum).hide();
				$("#cancel_clike_"+mcnum).show();
			}
		},
		error: function(xhr, status, error){
			console.log('xhr:', xhr.status);
		}
	});
}

function count_clikes(cnum){		// 댓글 좋아요 카운트 함수
	console.log('count clikes...mcnum: ', mcnum);
	
	$.ajax({
		url: 'json_mc_count_clikes.do',
		data: {mcnum: mcnum},
		method: 'POST',
		dataType: 'json',
		success: function(count){
			console.log('', mcnum, ': ', count);
			$("#count_clikes_"+mcnum).html(count);
		},
		error: function(xhr, status, error){
			console.log('xhr: ', xhr.status);
		}
	});
}

function clike(mcnum){		// 댓글 좋아요 함수
	console.log('like comment...mcnum: ', mcnum);
	
	$.ajax({
		url: 'json_mc_clike.do',
		data:{mcnum: mcnum,
			id: '${user_id}'},
		method:'POST',
		dataType: 'json',
		success: function(response){
			minicomments();
		},
		error: function(xhr, status, error){
			console.log('xhr:', xhr.status);
		}
	});
}

function cancel_clike(mcnum){	// 댓글 좋아요 취소 함수
	console.log('cancel clikes...mcnum: ', mcnum);
	
	$.ajax({
		url: 'json_mc_cancel_clike.do',
		data:{mcnum: mcnum,
			id: '${user_id}'},
		method: 'POST',
		dataType: 'json',
		success: function(response){
			minicomments();
		},
		error: function(xhr, status, error){
			console.log('xhr:', xhr.status);
		}
	});
}
</script>
</head>
<body onload="minicomments()">
	<jsp:include page="../../top_menu.jsp"></jsp:include>
	<jsp:include page="../mini_top_menu.jsp"></jsp:include>
	<h1>mini/diary/selectOne.jsp</h1>
	<h1>${user_id}</h1>
	<h1>${mh_attr.id}</h1>
	<div>${vo2.mbname}</div>
	<div id="title">
		제목 : <span id="titleSpan">${vo2.title}</span>
	</div>
	<div>닉네임 : ${vo2.writer}</div>
	<div>작성일자 : ${vo2.wdate}</div>
	<div style="border: 1px solid black; width: 700px; height: 350px;">
		<p id="content">
			<span id="contentSpan">${vo2.content}</span>
		</p>
	</div>
	<div id=imageContainer>
		<img src="resources/uploadimg/${vo2.filepath}">
	</div>
	<div id="buttonContainer">
		<a href="diary_update.do?id=${mh_attr.id}&mbnum=${param.mbnum}"
			class="myButton">수정</a> <a
			href="diary_deleteOK.do?id=${mh_attr.id}&mbnum=${param.mbnum}"
			class="myButton">삭제</a>
	</div>

	<table id="minicomments">
	</table>
</body>
</html>
<script type="text/javascript">
  // 다른 사람의 미니홈피 방문시 다이어리 작성 버튼 숨김
  if('${user_id}' != '${mh_attr.id}'){	
      $('#buttonContainer').hide();
  }
  if('${vo2.filepath}' == ''){
	  $('#imageContainer').hide();
  }
</script>