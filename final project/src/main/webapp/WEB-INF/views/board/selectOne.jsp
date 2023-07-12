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
<jsp:include page="../css.jsp"></jsp:include>
<script src="https://t1.kakaocdn.net/kakao_js_sdk/2.2.0/kakao.min.js" integrity="sha384-x+WG2i7pOR+oWb6O5GV5f1KN2Ko6N7PTGPS7UlasYWNxZMKQA63Cj/B2lbUmUfuC" crossorigin="anonymous"></script>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
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
					<tr>
						<td colspan="6"><hr /></td>
					</tr>
					<tr>
						<td rowspan="2">\${vo.writer}</td>`;
					
				if(cnum === vo.cnum){	// 댓글 수정인 경우
					tag_comments += `
							<td rowspan="2"><textarea cols="50" rows="3" id="comm_content">\${vo.content}</textarea><td>
							<td><button onclick="c_updateOK(\${vo.cnum})">수정완료</button></td>
							<td><button onclick="comments('\${writer}', 0, 0, \${bnum}, 0)">취소</button></td>
						</tr>
						<tr>
							<td><input type="checkbox" name="update_secret" id="update_secret" value="1" />비밀댓글</td>
						</tr>`;
				}
				else{	// 댓글 출력
					if(vo.secret === 1){	// 비밀 댓글인 경우
						if(vo.writer === '${nickname}' || iswriter || '${mclass}' === '1')
							tag_comments += `<td rowspan="2">\${vo.content}</td>`;
						else
							tag_comments += `<td rowspan="2">비밀댓글 입니다</td>`;
					}
					else	// 비밀 댓글이 아닌 경우
						tag_comments += `<td rowspan="2">\${vo.content}</td>`;
				}
					
				tag_comments += `<td id="clike_btn_\${vo.cnum}"><button onclick="clike(\${vo.cnum})" id="clike_\${vo.cnum}"><img width="15px" src="resources/icon/not_clike.png" /></button>
						<button onclick="cancel_clike(\${vo.cnum})" id="cancel_clike_\${vo.cnum}"><img width="15px" src="resources/icon/cliked.png" /></button></td>
						<td><div id="count_clikes_\${vo.cnum}"></div></td>
						<td><button onclick="comments('\${writer}', 0, 0, \${bnum}, \${vo.cnum})" id="cocoment_\${vo.cnum}">답글</button></td>
						<td><button onclick="c_report(\${vo.cnum}, \${vo.ccnum}, \${bnum})" id="report_\${vo.cnum}">신고</button></td>
					</tr>
					<tr>
						<td><button onclick="comments('\${writer}', \${vo.cnum}, \${vo.ccnum}, \${bnum})" id="c_update_\${vo.cnum}">수정</button></td>
						<td><button onclick="c_deleteOK(\${vo.cnum})" id="c_delete_\${vo.cnum}">삭제</button></td>
						<td colspan="2" id="cdate_\${vo.cnum}">\${cdate}</td>
					</tr>
					<tr><td colspan="6"><div id="cocomments_\${vo.cnum}"></div></td></tr>`;	// 대댓글 출력 위치
				
				if(insert_num === vo.cnum){	// 대댓글 작성
					tag_comments += `<tr>
						<td rowspan="2"><img width="15px" src="resources/icon/cocomment.png" /></td>
						<td colspan="3" rowspan="2"><textarea cols="50" rows="3" id="comm_content" /></textarea></td>
						<td><button onclick="c_insertOK(\${vo.cnum}, \${bnum})">등록</button></td>
						<td><button onclick="comments('\${writer}', 0, 0, \${bnum}, 0)">취소</button></td>
					</tr>
					<tr>
						<td><input type="checkbox" name="secret" id="secret" value="1" />비밀댓글</td>
					</tr>`; // 대댓글 입력창 출력 위치
				}
			});
			
			if(insert_num === 0){	// 답글을 누르지 않았을 때
				tag_comments += `
					<tr>
						<td colspan="5" rowspan="2"><textarea cols="50" rows="3" id="comm_content" /></textarea></td>
						<td><button onclick="c_insertOK(0, \${bnum})">등록</button></td>
					</tr>
					<tr>
						<td><input type="checkbox" name="secret" id="secret" value="1" />비밀댓글</td>
					</tr>`;
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
					<tr><td colspan="6"><hr /></td></tr>
					<tr>
						<td><img width="15px" src="resources/icon/cocomment.png" /></td>
						<td>
							<table>
								<tbody>
									<tr>
										<td rowspan="2">\${vo.writer}</td>`;
										
				if(update_num === vo.cnum){	// 대댓글 수정인 경우
					tag_cocomments += `
						<td rowspan="2"><textarea cols="50" rows="3" id="comm_content">\${vo.content}</textarea><td>
						<td><button onclick="c_updateOK(\${vo.cnum})">수정완료</button></td>
						<td><button onclick="comments('\${writer}', 0, 0, \${bnum}, 0)">취소</button></td>
					</tr>
					<tr>
						<td><input type="checkbox" name="update_secret" id="update_secret" value="1" />비밀댓글</td>
					</tr>`;
				}
				else{		// 대댓글 출력
					if(vo.secret === 1){	// 비밀 댓글인 경우
						if(vo.writer === '${nickname}' || iswriter || '${mclass}' === '1')
							tag_cocomments += `<td rowspan="2">\${vo.content}</td>`;
						else
							tag_cocomments += `<td rowspan="2">비밀 댓글 입니다</td>`;
					}
					else{	// 비밀 댓글이 아닌 경우
						tag_cocomments += `<td rowspan="2">\${vo.content}</td>`;
					}
				}
				
				tag_cocomments += `		<td id="clike_btn_\${vo.cnum}"><button onclick="clike(\${vo.cnum})" id="clike_\${vo.cnum}"><img width="15px" src="resources/icon/not_clike.png" /></button>
										<button onclick="cancel_clike(\${vo.cnum})" id="cancel_clike_\${vo.cnum}"><img width="15px" src="resources/icon/cliked.png" /></button></td>
										<td><div id="count_clikes_\${vo.cnum}"></div></td>
										<td><button onclick="c_report(\${vo.cnum}, \${vo.ccnum}, \${bnum})" id="report_\${vo.cnum}">신고</button></td>
									</tr>
									<tr>
										<td><button onclick="comments('\${writer}', \${vo.cnum}, \${bnum})" id="c_update_\${vo.cnum}">수정</button></td>
										<td><button onclick="c_deleteOK(\${vo.cnum})" id="c_delete_\${vo.cnum}">삭제</button></td>
										<td colspan="2" id="cdate_\${vo.cnum}">\${cdate}</td>
									</tr>
								</tbody>
							</table>
						</td>
					</tr>`;
				
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
</script>
</head>
<body onload="comments('${vo2.writer}')">
	<jsp:include page="../top_menu.jsp"></jsp:include>
<!-- 	페이스북 공유 sdk -->
	<div id="fb-root"></div>
	<script async defer crossorigin="anonymous" src="https://connect.facebook.net/ko_KR/sdk.js#xfbml=1&version=v17.0" nonce="NOEk7uEg"></script>
	<table>
		<thead>
			<tr>
				<td><h3>${vo2.title }</h3></td>
				<td>${vo2.writer }</td>
				<td>${vo2.vcount }</td>
			</tr>
			<tr>
				<td>${vo2.wdate }</td>
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
<%-- 				<td colspan="3"><textarea rows="15" cols="30" readonly>${vo2.content }</textarea></td> --%>
				<td colspan="3"><div>${vo2.content }<hr></div></td>
			</tr>
		</tbody>
		<tfoot>
			<tr>
				<td>
					<button onclick="like()" id="like_button">좋아요</button>
					<button onclick="like_cancel()" id="lcancel_button" style="display: none">좋아요 취소</button>
					<span id="likes_count">${vo2.likes }</span>
					<button onclick="open_modal()">공유</button>					
					<button onclick="report()" id="report_button">신고</button>
				</td>
				<td id="update_delete"><a href="b_update.do?bnum=${vo2.bnum }">수정</a> <a
					href="b_deleteOK.do?bnum=${vo2.bnum }&bname=${vo2.bname}">삭제</a></td>
			</tr>
		</tfoot>
	</table>
	
	<div id="modal">
		<div class="modal-content">
			<h6>공유하기</h6>
			<button onclick="share_twitter()" id="share_button">트위터로 공유</button>
			<button onclick="share_facebook()" id="share_button">페이스북으로 공유</button>
			<button id="kakaotalk-sharing-btn">카카오톡으로 공유</button>
			<div>
				<label for="copy_url_btn" id="url"></label>			
				<button id="copy_url_btn" onclick="copy_url()">링크복사</button>
			</div>
			<div>
				<button onclick="close_modal()">닫기</button>
			</div>
		</div>
	</div>
	
	<table id="comments">
	</table>
	
	<script type="text/javascript">
		if('${nickname}' === '${vo2.writer}'){
			$('#update_delete').show();
		}else{
			$('#update_delete').hide();
		}
		
		//첨부파일이 video인지 img인지
// 		let str = '${vo2.filepath}'.substr(-3);
// 		if(str === 'mp4'){
// 			$('#img').hide();
// 		}else{
// 			$('#video').hide();
// 		}
		
		$('#url').html(url);
		let modal = document.getElementById("modal");
		
		function open_modal(){
			modal.style.display = "block";
			document.body.style.overflow = "hidden"; // 스크롤바 제거
		}
		
		function close_modal(){
			modal.style.display = "none";
			document.body.style.overflow = "auto"; // 스크롤바
		}
	</script>
</body>
</html>