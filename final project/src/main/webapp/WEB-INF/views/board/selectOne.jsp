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
<title>Insert title here</title>
<link rel="stylesheet" href="resources/css/modal.css">
<jsp:include page="../css.jsp"></jsp:include>
<script src="https://t1.kakaocdn.net/kakao_js_sdk/2.2.0/kakao.min.js" integrity="sha384-x+WG2i7pOR+oWb6O5GV5f1KN2Ko6N7PTGPS7UlasYWNxZMKQA63Cj/B2lbUmUfuC" crossorigin="anonymous"></script>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
<script type="text/javascript">
let url = 'https://ebd7-218-146-69-112.ngrok-free.app/finalproject/b_selectOne.do?bnum='+${param.bnum};
let encodeUrl = encodeURIComponent(location.href)
console.log(encodeUrl);

	$(function(){
		//사용자가 해당 글에 좋아요를 눌렀는지 확인하는 함수
		let snum = '';
		snum = '${num}';
		if(snum != ''){
			$.ajax({
				url : "json_b_likeCheck.do",
				method : 'GET',
				data : {
					num : snum,
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
	//				console.log('status:', status);
	//				console.log('error:', error);
				}
			});//end $.ajax()
		}
	});//end onload
	
	function like(){
		let snum = '';
		snum = '${num}';
		$.ajax({
			url : "json_b_like.do",
			method : 'GET',
			data : {
				num : snum,
				bnum : ${param.bnum}
			},
			dataType : 'json', 
			success : function(map) {
// 	 			console.log(map.result);
				if(map.result == 1){
					$("#like_button").hide();
					$("#lcancel_button").show();
					$("#likes_count").text(map.likes);
				}
			},
			error : function(xhr, status, error) {
				console.log('xhr:', xhr.status);
//				console.log('status:', status);
//				console.log('error:', error);
			}
		});//end $.ajax()
	}//end like()
	
	function like_cancel(){
		let snum = '';
		snum = '${num}';
		$.ajax({
			url : "json_b_like_delete.do",
			method : 'GET',
			data : {
				num : snum,
				bnum : ${param.bnum}
			},
			dataType : 'json', 
			success : function(map) {
// 	 			console.log(map.result);
				if(map.result == 1){
					$("#like_button").show();
					$("#lcancel_button").hide();
					$("#likes_count").text(map.likes);
				}
			},
			error : function(xhr, status, error) {
				console.log('xhr:', xhr.status);
//				console.log('status:', status);
//				console.log('error:', error);
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
	    window.open("http://twitter.com/share?url=" + encodeURIComponent('https://ebd7-218-146-69-112.ngrok-free.app/finalproject/b_selectOne.do?bnum='+${param.bnum}) +"&text=" + encodeURIComponent(document.title), name, option);
	}//end share_twitter()
	
	function share_facebook(){
		let option = "width = 500, height = 500";
		let name = "페이스북으로 공유";
	    window.open("http://www.facebook.com/sharer.php?u=" + encodeURIComponent('https://ebd7-218-146-69-112.ngrok-free.app/finalproject/b_selectOne.do?bnum='+${param.bnum}), name, option);
	}//end share_facebook()
	
	function copy_url(){
		navigator.clipboard.writeText('https://ebd7-218-146-69-112.ngrok-free.app/finalproject/b_selectOne.do?bnum='+${param.bnum}).then(() => {
	        alert("복사완료");
	      });
	}
	
	$(function(){
		Kakao.init('8b87b1c63625a7c92d74e9e4019cc90f');
		if(Kakao.isInitialized()){
			Kakao.Share.createScrapButton({
			    container: '#kakaotalk-sharing-btn',
			    requestUrl: 'https://ebd7-218-146-69-112.ngrok-free.app/finalproject/b_selectOne.do?bnum='+${param.bnum}
			});
		}
	});
	
	function comments(cnum=0, ccnum=0, bnum=${param.bnum}){	// 댓글 출력 함수
		console.log("print comments...bnum: ", bnum);
		$.ajax({
			url: 'json_c_selectAll.do',
			data: {bnum: bnum},
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
								<td rowspan="2"><button onclick="c_insertOK(\${cnum})">수정완료</button></td>`;
						}
						else{
							tag_comments += `<td rowspan="2">\${vo.content}</td>`;
						}
						
						tag_comments += `<td><button onclick="clike(\${vo.cnum})" id="clike">clike</button>
							<td><button onclick="insert_comment(\${vo.cnum})">답글</button>
							<td><button onclick="c_report(\${vo.cnum})">신고</button>
						</tr>
						<tr>
							<td><button onclick="comments(\${vo.cnum}, \${vo.ccnum}, \${bnum})" id="c_update">수정</button>
							<td><button onclick="c_delete(\${vo.cnum})" id="c_delete">삭제</button>
							<td>\${vo.cdate}</td>
						</tr>
						<tr><td colspan="6"><div id="cocomments_\${vo.cnum}"></div></td></tr>	// 대댓글 출력 위치
						<tr><td colspan="6"><div id="insert_comment_\${vo.cnum}"></div></td></tr>`; // 대댓글 입력창 출력 위치
				});
				
				if(cnum === 0){	// 답글 버튼을 누르지 않았을 경우
					tag_comments += `<tr><td colspan="5"><div id="insert_comment_0"></div></td></tr>`;
				}
				
				$("#comments").html(tag_comments);
				
				$.each(arr, function(index, vo){
					cocomments(vo.cnum, bnum, cnum);	// 대댓글 출력 함수 호출
				});
				insert_comment();	//	댓글 입력 창 호출 
			},
			error : function(xhr, status, error) {
				console.log('xhr:', xhr.status);
			}
		});
	}
	
	function cocomments(cnum, bnum=${param.bnum}, update_num){		// 대댓글 출력 함수
		console.log('print cocomments...cnum:', cnum, 'bnum: ', bnum);
		$.ajax({
			url: 'json_cc_selectAll.do',
			data: {cnum: cnum},
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
					if(update_num === vo.cnum){
						tag_cocomments += `<td rowspan="2"><input type="text" id="comm_content" value="\${vo.content}"/><td>
						<td rowspan="2"><button onclick="c_insertOK(\${vo.cnum}, \${vo.ccnum})">수정완료</button></td>`;
					}
					else{
						tag_cocomments += `<td rowspan="2">\${vo.content}</td>`;
					}
					
					tag_cocomments += `		<td colspan="2"><button onclick="clike(\${vo.cnum})" id="clike">clike</button>
											<td><button onclick="c_report(\${vo.cnum})">신고</button>
										</tr>
										<tr>
											<td><button onclick="comments(\${vo.cnum}, \${bnum})" id="c_update">수정</button>
											<td><button onclick="c_delete(\${vo.cnum})" id="c_delete">삭제</button>
											<td>\${vo.cdate}</td>
										</tr>
									</tbody>
								</table>
							</td>
						</tr>`;
					if('${user_id}' === vo.writer || '${mclass}' === '1'){	// 작성자와 관리자에게만 노출
						$("#c_update").show();
						$("#c_delete").show();
					}
					else{
						$("#c_update").hide();
						$("#c_delete").hide();
					}
				});
				
				$("#cocomments_"+cnum).html(tag_cocomments);
			},
			error : function(xhr, status, error) {
				console.log('xhr:', xhr.status);
			}
		});
	}
	
	function insert_comment(cnum=0){	// 댓글 입력창 출력
		console.log('insert comments...cnum: ', cnum);
		
		let tag_insert_comment = `
			<td><input type="text" id="comm_content" /><td>
			<td><button onclick="c_insertOK(\${cnum})">등록</button></td>`;
		
		$("#insert_comment_"+cnum).html(tag_insert_comment);
	}
	
</script>
</head>
<body onload="comments()">
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
			<tr>
				<td colspan="3">
					<hr>
					<video src="${vo2.filepath}" width="300" controls id="video"></video>
					<img width="300px" src="${vo2.filepath}" id="img">
				</td>
			</tr>
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
		let str = '${vo2.filepath}'.substr(-3);
		if(str === 'mp4'){
			$('#img').hide();
		}else{
			$('#video').hide();
		}
		
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