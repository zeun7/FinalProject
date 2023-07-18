<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="twitter:card" content="summary" />
<meta name="twitter:site" content="finalproject" />
<meta name="twitter:title" content="FinalProject" />
<meta name="twitter:description" content="1조 파이널프로젝트" />
<meta name="twitter:image" content="https://farm6.staticflickr.com/5510/14338202952_93595258ff_z.jpg" />
<meta name="twitter:url" content="https://ebd7-218-146-69-112.ngrok-free.app/finalproject/b_selectOne.do?bnum=${param.bnum}" />
<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.4/moment.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.4/moment-with-locales.min.js"></script>
<title>Insert title here</title>
<link rel="stylesheet" href="resources/css/modal.css">
<link rel="stylesheet" href="resources/css/comments.css">
<link rel="stylesheet" href="resources/css/button.css">
<script src="https://t1.kakaocdn.net/kakao_js_sdk/2.2.0/kakao.min.js" integrity="sha384-x+WG2i7pOR+oWb6O5GV5f1KN2Ko6N7PTGPS7UlasYWNxZMKQA63Cj/B2lbUmUfuC" crossorigin="anonymous"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
<script type="text/javascript">
let url = 'https://861c-218-146-69-112.ngrok-free.app/finalproject/b_selectOne.do?bnum='+${param.bnum};
let encodeUrl = encodeURIComponent(location.href)
let iswriter = false;
console.log(encodeUrl);

$(function(){
	//사용자가 해당 글에 좋아요를 눌렀는지 확인하는 함수
	let sid = '';
	sid = '${user_id}';
	if(sid != ''){
		$.ajax({
			url : "json_b_likeCheck.do",
			method : 'GET',
			data : {
				id : sid,
				bnum : ${param.bnum}
			},
			dataType : 'json', 
			success : function(map) {
// 	 			console.log(map.result);
				if(map.result == 0){		//좋아요를 안눌렀다면
					$("#like_button").show();
					$("#lcancel_button").hide();
				}else{
					$("#like_button").hide();
					$("#lcancel_button").show();
				}
			},
			error : function(xhr, status, error) {
				console.log('xhr:', xhr.status);
			}
		});//end $.ajax()
	}
});//end onload

function like(){
	let sid = '';
	sid = '${user_id}';
	$.ajax({
		url : "json_b_like.do",
		method : 'GET',
		data : {
			id : sid,
			bnum : ${param.bnum}
		},
		dataType : 'json', 
		success : function(map) {
//			console.log(map.result);
			if(map.result == 1){
				$("#like_button").hide();
				$("#lcancel_button").show();
				$("#likes_count").text(map.likes);
			}
		},
		error : function(xhr, status, error) {
			console.log('xhr:', xhr.status);
		}
	});//end $.ajax()
}//end like()

function like_cancel(){
	let sid = '';
	sid = '${user_id}';
	$.ajax({
		url : "json_b_like_delete.do",
		method : 'GET',
		data : {
			id : sid,
			bnum : ${param.bnum}
		},
		dataType : 'json', 
		success : function(map) {
			if(map.result == 1){
				$("#like_button").show();
				$("#lcancel_button").hide();
				$("#likes_count").text(map.likes);
			}
		},
		error : function(xhr, status, error) {
			console.log('xhr:', xhr.status);
		}
	});//end $.ajax()
}//end dislike()

function report(){
	let url = "b_report.do?bnum="+${vo2.bnum};
	let name = "신고하기";
	let option = "width = 500, height = 500";
	window.open(url, name, option);
}//end report()

function share_twitter(){
	let option = "width = 500, height = 500";
	let name = "트위터로 공유";
    window.open("http://twitter.com/share?url=" + encodeURIComponent(url) +"&text=" + encodeURIComponent(document.title), name, option);
}//end share_twitter()

function share_facebook(){
	let option = "width = 500, height = 500";
	let name = "페이스북으로 공유";
    window.open("http://www.facebook.com/sharer.php?u=" + encodeURIComponent(url), name, option);
}//end share_facebook()

function copy_url(){
	navigator.clipboard.writeText(url).then(() => {
        alert("복사완료");
      });
}

$(function(){
	Kakao.init('8b87b1c63625a7c92d74e9e4019cc90f');
	if(Kakao.isInitialized()){
		Kakao.Share.createScrapButton({
		    container: '#kakaotalk-sharing-btn',
		    requestUrl: url
		});
	}
});

function comments(writer, cnum=0, ccnum=0, bnum=${param.bnum}, insert_num=0){	// 댓글 출력 함수
	console.log("print comments...bnum: ", bnum);
	$.ajax({
		url: 'json_c_selectAll.do',
		data: {bnum: bnum},
		method: 'GET',
		dataType: 'json',
		success: function(arr){
			let tag_comments = '';
			
			$.each(arr, function(index, vo){
				let cdate = moment(vo.cdate).format('YYYY-MM-DD HH:mm:ss');
				checkviewer(writer);
				tag_comments += `
					<li class="comm_one">
						<hr/>
						<div class="cmt_box">
							<div class="comm_top" style="display: flex">	
								<table style="flex: 1 500px">	
									<tr>
										<td class="comm_nick"><strong>\${vo.writer}</strong>\t(\${cdate})</td>
										<td class="comm_top_space"></td>
										<td class="comm_btn_wrap">
											<span><button onclick="c_report(\${vo.cnum}, \${vo.ccnum}, \${bnum})" id="report_\${vo.cnum}">신고</button></span>
											<span><button onclick="comments('\${writer}', 0, 0, \${bnum}, \${vo.cnum})" id="cocoment_\${vo.cnum}">답글</button></span>
											<span><div id="count_clikes_\${vo.cnum}"></div></span>
											<span id="clike_btn_\${vo.cnum}">
												<button onclick="clike(\${vo.cnum})" id="clike_\${vo.cnum}"><img width="15px" src="resources/icon/not_clike.png" /></button>
												<button onclick="cancel_clike(\${vo.cnum})" id="cancel_clike_\${vo.cnum}"><img width="15px" src="resources/icon/clike.png" /></button>
											</span>
										</td>
									</tr>
								</table>
							</div>
						`;
							
				if(cnum === vo.cnum){	// 댓글 수정인 경우
					tag_comments += `
						<div class="comm_write_box" style="display: flex">
							<table style="flex: 1 500px">
								<tr>
									<td rowspan="2"><textarea rows="3" id="comm_content">\${vo.content}</textarea></td>
									<td width="130px;">
										<div class="update_btn_wrap">	
											<span><button onclick="comments('\${writer}', 0, 0, \${bnum}, 0)">취소</button></span>
											<span><button onclick="c_updateOK(\${vo.cnum})">수정완료</button></span>
										</div>
									</td>
								</tr>
								<tr>
									<td class="secret_check">
										<span width="150px;"><input type="checkbox" name="update_secret" id="update_secret" value="1" />비밀댓글</span>
									</td>
								</tr>
							</table>
						</div>
						`;
				}
				else{	// 댓글 출력
					if(vo.secret === 1){	// 비밀 댓글인 경우
						if(vo.writer === '${nickname}' || iswriter || '${mclass}' === '1'){
							tag_comments += `
								<div class="comm_content_box" style="display: flex">
									<table style="flex: 1 500px">
										<tr>
											<td><div class="comm_content">
												<p>\${vo.content}</p>
											</div></td>
											<td width="200px;">
												<div class="updel_wrap">
													<span id="c_delete_\${vo.cnum}">
														<button onclick="c_deleteOK(\${vo.cnum})" >삭제</button></span>
													<span id="c_update_\${vo.cnum}">
														<button onclick="comments('\${writer}', \${vo.cnum}, \${vo.ccnum}, \${bnum})" >수정</button></span>
												</div>
											</td>
										</tr>
									</table>
								</div>
								`;
						}
						else{
							tag_comments += `
								<div class="comm_content_box">
									<div class="comm_content_box"><span class="comm_content">비밀댓글 입니다</span></div>
								</div>	
								`;
						}
					}
					else{	// 비밀 댓글이 아닌 경우
						tag_comments += `
							<div class="comm_content_box" style="display: flex">
									<table style="flex: 1 500px">
									<tr>
										<td><div class="comm_content_box">
											<p class="comm_content">\${vo.content}</p>
										</div></td>
										<td width="200px;">
											<div class="updel_wrap">
												<span id="c_delete_\${vo.cnum}">
													<button onclick="c_deleteOK(\${vo.cnum})" >삭제</button></span>
												<span id="c_update_\${vo.cnum}">
													<button onclick="comments('\${writer}', \${vo.cnum}, \${vo.ccnum}, \${bnum})" >수정</button></span>
											</div>
										</td>
									</tr>
								</table>
							</div>
							`;
					}
				}
					
				tag_comments += `</div>
					</li>
					<li id="cocomments_\${vo.cnum}">`;	// 대댓글 출력 위치
				
				if(insert_num === vo.cnum){	// 대댓글 작성
					tag_comments += `</li>
						<li>
							<hr/>
							<div class="coco_img" style="float: left; padding:10px;">
								<img width="15px" src="resources/icon/cocomment.png" /></div>
							<div class="comm_write_box" style="display: flex">
								<table style="flex: 1 500px; width:100%;">
									<tr>
										<td rowspan="2"><textarea rows="3" id="comm_content"></textarea></td>
										<td width="100px;">
											<div width="130px;" class="insert_wrap">
												<span><button onclick="comments('\${writer}', 0, 0, \${bnum}, 0)">취소</button></span>
												<span><button onclick="c_insertOK(\${vo.cnum}, \${bnum})">등록</button></span>
											</div>
									</tr>
									<tr>
										<td colspan="2" class="secret_check">
											<span><input type="checkbox" name="secret" id="secret" value="1" />비밀댓글</span>
										</td>
									</tr>
								</table>
							</div>
						</li>`;
				}
			});
			
			if(insert_num === 0){	// 답글을 누르지 않았을 때 댓글 입력창
				tag_comments += `</li>
					<li>
						<hr/>
						<div class="comm_write_box" styel="display: flex">
							<table style="flex: 1 500px; width:100%;">
								<tr>
									<td rowspan="2"><textarea rows="3" id="comm_content"></textarea></td>
									<td width="100px;">
										<div width="130px;" class="insert_wrap">
											<span><button width="100px;" onclick="c_insertOK(0, \${bnum})">등록</button></span>
										</div>
									</td>
								</tr>
								<tr>
									<td class="secret_check">
										<span width="150px;"><input type="checkbox" name="secret" id="secret" value="1" />비밀댓글</span>
									</td>
								</tr>
							</table>
						</div>
					</li>`;
			}
			
			$('#comments').html(tag_comments);
			
			$.each(arr, function(index, vo){
				cocomments(writer, vo.cnum, bnum, cnum);	// 대댓글 출력 함수 호출
				is_clike(vo.cnum);					// 댓글 좋아요 확인
				count_clikes(vo.cnum);				// 좋아요 카운트
				
				if('${nickname}' === vo.writer || '${mclass}' === '1'){	// 작성자와 관리자에게만 노출
					$('#c_update_'+vo.cnum).show();
					$('#c_delete_'+vo.cnum).show();
				}
				else{
					$('#c_update_'+vo.cnum).hide();
					$('#c_delete_'+vo.cnum).hide();
				}
				
				if(cnum === vo.cnum){				// 수정중에는 버튼 숨김
					$('#c_update_'+vo.cnum).hide();
					$('#clike_btn_'+vo.cnum).hide();
					$('#cocoment_'+vo.cnum).hide();
					$('#report_'+vo.cnum).hide();
					$('#cdate_'+vo.cnum).hide();
					$('#count_clikes_'+vo.cnum).hide();
					$('#c_delete_'+vo.cnum).hide();
				}
			});
		},
		error : function(xhr, status, error) {
			console.log('xhr:', xhr.status);
		}
	});
}

function cocomments(writer, cnum, bnum=${param.bnum}, update_num){		// 대댓글 출력 함수
	console.log('print cocomments...cnum:', cnum, 'bnum: ', bnum);
	console.log('iswriter: ', iswriter);
	$.ajax({
		url: 'json_cc_selectAll.do',
		data: {cnum: cnum},
		method: 'GET',
		dataType: 'json',
		success: function(arr){
			let tag_cocomments = '';
			
			$.each(arr, function(index, vo){
				let cdate = moment(vo.cdate).format('YYYY-MM-DD HH:mm:ss');
				tag_cocomments += `
					<li class="comm_one">
						<hr/>
						<div class="coco_img" style="float:left; padding:10px;">
							<img width="15px" src="resources/icon/cocomment.png" /></div>
						<div class="cmt_wrap">
							<div class="comm_top" style="display: flex">	
								<table style="flex: 1 500px">	
									<tr>
										<td class="comm_nick"><strong>\${vo.writer}</strong>\t(\${cdate})</td>
										<td class="comm_top_space"></td>
										<td class="comm_btn_wrap">
											<span><button onclick="c_report(\${vo.cnum}, \${vo.ccnum}, \${bnum})" id="report_\${vo.cnum}">신고</button></span>
											<span><div id="count_clikes_\${vo.cnum}"></div></span>
											<span id="clike_btn_\${vo.cnum}">
												<button onclick="clike(\${vo.cnum})" id="clike_\${vo.cnum}"><img width="15px" src="resources/icon/not_clike.png" /></button>
												<button onclick="cancel_clike(\${vo.cnum})" id="cancel_clike_\${vo.cnum}"><img width="15px" src="resources/icon/clike.png" /></button>
											</span>
										</td>
									</tr>
								</table>
							</div>
						`;
										
				if(update_num === vo.cnum){	// 대댓글 수정인 경우
					tag_cocomments += `
						<div class="comm_write_box" style="display: flex">
							<table style="flex: 1 500px">
								<tr>
									<td rowspan="2"><textarea cols="100%;" rows="3" id="comm_content">\${vo.content}</textarea></td>
									<td width="130px;">
										<div class="update_btn_wrap">	
											<span><button onclick="comments('\${writer}', 0, 0, \${bnum}, 0)">취소</button></span>
											<span><button onclick="c_updateOK(\${vo.cnum})">수정완료</button></span>
										</div>
									</td>
								</tr>
								<tr>
									<td class="secret_check">
										<span width="150px;"><input type="checkbox" name="update_secret" id="update_secret" value="1" />비밀댓글</span>
									</td>
								</tr>
							</table>
						</div>
					`;
				}
				else{		// 대댓글 출력
					if(vo.secret === 1){	// 비밀 댓글인 경우
						if(vo.writer === '${nickname}' || iswriter || '${mclass}' === '1'){
							tag_cocomments += `
								<div class="comm_content_box" style="display: flex">
									<table style="flex: 1 500px">
										<tr>
											<td><div class="comm_content">
												<span>\${vo.content}</span>
											</div></td>
											<td width="200px;">
												<div class="updel_wrap">
													<span id="c_delete_\${vo.cnum}">
														<button onclick="c_deleteOK(\${vo.cnum})" >삭제</button></span>
													<span id="c_update_\${vo.cnum}">
														<button onclick="comments('\${writer}', \${vo.cnum}, \${vo.ccnum}, \${bnum})" >수정</button></span>
												</div>
											</td>
										</tr>
									</table>
								</div>
								`;
						}
						else{
							tag_cocomments += `<div class="comm_content_box">
								<div class="comm_content_box"><span class="comm_content">비밀댓글 입니다</span></div>
							</div>	
							`;
						}
					}
					else{	// 비밀 댓글이 아닌 경우
						tag_cocomments += `
							<div class="comm_content_box" style="display: flex">
								<table style="flex: 1 500px">
									<tr>
										<td><div class="comm_content_box">
											<span class="comm_content">\${vo.content}</span>
										</div></td>
										<td width="200px;">
											<div class="updel_wrap">
												<span id="c_delete_\${vo.cnum}">
													<button onclick="c_deleteOK(\${vo.cnum})" >삭제</button></span>
												<span id="c_update_\${vo.cnum}">
													<button onclick="comments('\${writer}', \${vo.cnum}, \${vo.ccnum}, \${bnum})" >수정</button></span>
											</div>
										</td>
									</tr>
								</table>
							</div>
							`;
					}
				}
				
				tag_cocomments += `</div>
					</li>`;
				
			});
			
			$('#cocomments_'+cnum).html(tag_cocomments);
			
			$.each(arr, function(index, vo){
				is_clike(vo.cnum);		// 댓글 좋아요 확인
				count_clikes(vo.cnum);	// 좋아요 카운트
				
				if('${user_id}' === vo.writer || '${mclass}' === '1'){	// 작성자와 관리자에게만 노출
					$('#c_update_'+vo.cnum).show();
					$('#c_delete_'+vo.cnum).show();
				}
				else{
					$('#c_update_'+vo.cnum).hide();
					$('#c_delete_'+vo.cnum).hide();
				}
				
				if(update_num === vo.cnum){		// 수정중에는 버튼 숨김
					$('#c_update_'+vo.cnum).hide();
					$('#clike_btn_'+vo.cnum).hide();
					$('#report_'+vo.cnum).hide();
					$('#cdate_'+vo.cnum).hide();
					$('#count_clikes_'+vo.cnum).hide();
					$('#c_delete_'+vo.cnum).hide();
				}
			});
		},
		error : function(xhr, status, error) {
			console.log('xhr:', xhr.status);
		}
	});
}

function c_insertOK(cnum, bnum){		// 댓글 등록 버튼
	console.log('insert comment...');
	
	$.ajax({
		url: 'json_c_insertOK.do',
		data: {ccnum: cnum,
			bnum: bnum,
			writer: '${nickname}',
			content: $('#comm_content').val(),
			secret: $("input[name='secret']").is(":checked")? 1:0},
		method: 'POST',
		dataType: 'json',
		success: function(response){
			if(response.result == 1){
				comments();
			}
		},
		error : function(xhr, status, error) {
			console.log('xhr:', xhr.status);
		}
	});
}

function c_updateOK(cnum){		// 댓글 수정 완료 버튼
	console.log('update comment...cnum: ', cnum);
	
	$.ajax({
		url: 'json_c_updateOK.do',
		data:{cnum: cnum,
			content: $('#comm_content').val(),
			secret: $("input[name='update_secret']").is(":checked")? 1:0},
		method: 'POST',
		dataType: 'json',
		success: function(response){
			if(response.result == 1){
				comments();
			}
		},
		error: function(xhr, status, error){
			console.log('xhr:', xhr.status);
		}
	});
}

function c_deleteOK(cnum){		// 댓글 삭제
	console.log('delete comment...cnum: ', cnum);
	
	if(window.confirm("댓글을 삭제하시겠습니까?")){
		$.ajax({
			url: 'json_c_deleteOK.do',
			data: {cnum: cnum},
			method: 'POST',
			dataType: 'json',
			success: function(response){
				if(response.result >= 1){
					comments();
				}
			},
			error: function(xhr, status, error){
				console.log('xhr:', xhr.status);
			}
		});
	}
}

function c_report(cnum, ccnum, bnum){	// 댓글 신고하기
	console.log('report comment...cnum: ', cnum, 'ccnum: ', ccnum, 'bnum: ');
	
	let url = "c_report.do?cnum="+cnum+'&ccnum='+ccnum+'&bnum='+bnum;
	let name = "신고하기";
	let option = "width = 400, height = 500";
	window.open(url, name, option);
}

function is_clike(cnum){		// 유저가 해당 댓글의 좋아요를 눌렀는지 체크
	console.log('check clikes...cnum: ', cnum);
	
	$.ajax({
		url: 'json_c_is_clike.do',
		data: {cnum: cnum,
			id: '${user_id}'},
		method: 'POST',
		dataType: 'json',
		success: function(result){
			if(result === 0){
				$("#clike_"+cnum).show();
				$("#cancel_clike_"+cnum).hide();
			}
			else{
				$("#clike_"+cnum).hide();
				$("#cancel_clike_"+cnum).show();
			}
		},
		error: function(xhr, status, error){
			console.log('xhr:', xhr.status);
		}
	});
}

function count_clikes(cnum){		// 댓글 좋아요 카운트 함수
	console.log('count clikes...cnum: ', cnum);
	
	$.ajax({
		url: 'json_c_count_clikes.do',
		data: {cnum: cnum},
		method: 'POST',
		dataType: 'json',
		success: function(count){
			console.log('likes: ', cnum, '-', count);
			$("#count_clikes_"+cnum).html(count);
		},
		error: function(xhr, status, error){
			console.log('xhr: ', xhr.status);
		}
	});
}

function clike(cnum){		// 댓글 좋아요 함수
	console.log('like comment...cnum: ', cnum);
	
	$.ajax({
		url: 'json_c_clike.do',
		data:{cnum: cnum,
			id: '${user_id}'},
		method:'POST',
		dataType: 'json',
		success: function(response){
			comments();
		},
		error: function(xhr, status, error){
			console.log('xhr:', xhr.status);
		}
	});
}

function cancel_clike(cnum){	// 댓글 좋아요 취소 함수
	console.log('cancel clikes...cnum: ', cnum);
	
	$.ajax({
		url: 'json_c_cancel_clike.do',
		data:{cnum: cnum,
			id: '${user_id}'},
		method: 'POST',
		dataType: 'json',
		success: function(response){
			comments();
		},
		error: function(xhr, status, error){
			console.log('xhr:', xhr.status);
		}
	});
}

function checkviewer(writer){
	console.log('check viewer...', writer);
	if(writer === '${nickname}')	// 게시글 작성자와 게시글 열람자의 닉네임이 같을 경우
		iswriter = true;
	
	console.log('iswriter is...', iswriter);
}

function goBack() {
	  window.history.back();
} 
</script>
</head>
<body onload="comments('${vo2.writer}')">
<jsp:include page="../sidebar.jsp"></jsp:include>
<div class="main-panel">
<jsp:include page="../navbar.jsp"></jsp:include>
	<div class="content">
		<div class="row">
			<div class="col-md-12">
				<div class="card">
					<div class="card-header">
						<h3 class="card-title">${vo2.title}</h3>
					</div>
					<div class="card-body">
					<!-- 	페이스북 공유 sdk -->
						<div id="fb-root"></div>
						<script async defer crossorigin="anonymous" src="https://connect.facebook.net/ko_KR/sdk.js#xfbml=1&version=v17.0" nonce="NOEk7uEg"></script>
						<table class="table">
							<thead>
								<tr>
									<td>${vo2.writer}</td>
									<td>${vo2.wdate}</td>
									<td>조회수: ${vo2.vcount}</td>
								</tr>
							</thead>
							<tbody>
					<!-- 			<tr> -->
					<!-- 				<td colspan="3"> -->
					<!-- 					<hr> -->
					<%-- 					<video src="${vo2.filepath}" width="300" controls id="video"></video> --%>
					<%-- 					<img width="300px" src="${vo2.filepath}" id="img"> --%>
					<!-- 				</td> -->
					<!-- 			</tr> -->
								<tr>
<%-- 									<td colspan="3"><textarea rows="15" cols="30" readonly>${vo2.content }</textarea></td> --%>
									<td colspan="3">
								        <p>${vo2.content}</p>
								        <p>&nbsp;</p><p>&nbsp;</p><p>&nbsp;</p><p>&nbsp;</p><p>&nbsp;</p><p>&nbsp;</p>
								    </td>
								</tr>
							</tbody>
							<tfoot>
								<tr>
									<td colspan="3">
										<div id="buttonss" style="display: flex; justify-content: space-between;">
											<button class="custom-btn btn-1" onclick="goBack()">게시판</button>
											<div style="display: flex; justify-content: center; align-items: center;">
												<button onclick="like()" class="heartButton" id="like_button"><img width="25px" src="resources/icon/not_like.png" /></button>
												<button onclick="like_cancel()" class="heartButton" id="lcancel_button" style="display: none"><img width="25px" src="resources/icon/like.png" /></button>
												<span id="likes_count" style="margin-left:5px;">${vo2.likes }</span>
											</div>
											<div style="display: flex; justify-content: end;">
												<button class="custom-btn btn-11" onclick="open_modal()">공유</button>					
												<button class="custom-btn btn-11" onclick="report()" id="report_button">신고</button>
												<div id="update_delete">
													<a class="custom-btn btn-12" href="b_update.do?bnum=${vo2.bnum}">수정</a> 
													<a class="custom-btn btn-12" href="b_deleteOK.do?bnum=${vo2.bnum }&bname=${vo2.bname}">삭제</a>
												</div>
											</div>
										</div>
									</td>
								</tr>
							</tfoot>
						</table>
					</div>
					<div class="card-footer">
						<div class="comments wrap" id="comments wrap">
							<ul class="comments" id="comments">
							</ul>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>	
</div>

<div id="modal">
	<div class="modal-content" style="top:5%; left:10%; width:300px; height:300px">
		<h6>공유하기</h6>
		<button onclick="share_twitter()" id="share_button">
			<img width="30px" src="resources/icon/twitter.png"/>트위터로 공유하기</button>
		<button onclick="share_facebook()" id="share_button">
			<img width="30px" src="resources/icon/facebook.png"/>페이스북으로 공유하기</button>
		<button id="kakaotalk-sharing-btn">
			<img width="30px" src="resources/icon/kakaotalk.png"/>카카오톡으로 공유하기</button>
		<div>
			<label for="copy_url_btn" id="url"></label>			
			<button id="copy_url_btn" onclick="copy_url()">링크복사</button>
		</div>
		<div>
			<button onclick="close_modal()">닫기</button>
		</div>
	</div>
</div>

<div id="cmt_modal">
	<div class="modal-content" id="report_content" style="top:5%; left:10%; width:300px; height:500px">
		<div><strong>신고사유를 선택하세요</strong></div>
		<input type="radio" id="reason1" name="reason" value="욕설/혐오/차별적 표현입니다">
		<label for="reason1">욕설/혐오/차별적 표현입니다</label><br/>
		<input type="radio" id="reason2" name="reason" value="스팸홍보/도배글입니다">
		<label for="reason2">스팸홍보/도배글입니다</label><br/>
		<input type="radio" id="reason3" name="reason" value="음란물입니다">
		<label for="reason3">음란물입니다</label><br/>
		<input type="radio" id="reason4" name="reason" value="개인정보 노출 게시물입니다">
		<label for="reason4">개인정보 노출 게시물입니다</label><br/>
		<input type="radio" id="reason5" name="reason" value="명예훼손 또는 저작권이 침해되었습니다">
		<label for="reason5">명예훼손 또는 저작권이 침해되었습니다</label><br/>
		<input type="radio" id="reason6" name="reason" value="불쾌한 표현이 있습니다">
		<label for="reason6">불쾌한 표현이 있습니다</label><br/><br/>
		<button type="button" onclick="submitReport()" class="report_btn">신고</button>
	</div>
</div>

<script type="text/javascript">
function submit_board_report(){
	console.log('submit board report...');
	$.ajax({
		url: 'c_reportOK.do',
		data: {cnum: ${param.cnum},
			ccnum: ${param.ccnum},
			bnum: ${param.bnum},
			reason: $('input[name=reason]:checked').val()},
		method: 'POST',
		dataType: 'json',
		success: function(response){
			$('#report_content').empty();
			$('#report_content').txt("신고가 완료되었습니다.");
		},
		error: function(xhr, status, error){
			console.log('xhr:', xhr.status);
		}
		
	});
}

	if('${nickname}' === '${vo2.writer}'){
		$('#update_delete').show();
	}else{
		$('#update_delete').hide();
	}
		
// 	첨부파일이 video인지 img인지
// 	let str = '${vo2.filepath}'.substr(-3);
// 	if(str === 'mp4'){
// 		$('#img').hide();
// 	}else{
// 		$('#video').hide();
// 	}
		
	$('#url').html(url);
	let modal = document.getElementById("modal");
	let cmt_modal = document.getElementById("cmt_modal")
	
	function open_modal(){
		modal.style.display = "block";
		document.body.style.overflow = "hidden"; // 스크롤바 제거
	}
	
	function cmt_report_modal(){
		
	}
	
	function close_modal(){
		modal.style.display = "none";
		document.body.style.overflow = "auto"; // 스크롤바
	}
</script>
</body>
</html>