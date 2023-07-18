<!--
=========================================================
* Paper Dashboard 2 - v2.0.1
=========================================================

* Product Page: https://www.creative-tim.com/product/paper-dashboard-2
* Copyright 2020 Creative Tim (https://www.creative-tim.com)

Coded by www.creative-tim.com

 =========================================================

* The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
-->
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8" />
<link rel="apple-touch-icon" sizes="76x76" href="resources/assets/img/apple-icon.png">
<link rel="icon" type="image/png" href="resources/assets/img/favicon.png">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
<title>다이어리_selectOne</title>
<meta content='width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0, shrink-to-fit=no'
	name='viewport' />
<!--     Fonts and icons     -->
<link href="https://fonts.googleapis.com/css?family=Montserrat:400,700,200" rel="stylesheet" />
<link href="https://maxcdn.bootstrapcdn.com/font-awesome/latest/css/font-awesome.min.css" rel="stylesheet">
<!-- CSS Files -->
<link href="resources/assets/css/bootstrap.min.css" rel="stylesheet" />
<link href="resources/assets/css/paper-dashboard.css?v=2.0.1" rel="stylesheet" />
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
<script src="https://t1.kakaocdn.net/kakao_js_sdk/2.2.0/kakao.min.js" integrity="sha384-x+WG2i7pOR+oWb6O5GV5f1KN2Ko6N7PTGPS7UlasYWNxZMKQA63Cj/B2lbUmUfuC"
	crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.4/moment.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.4/moment-with-locales.min.js"></script>
<link rel="stylesheet" href="resources/css/modal.css">
<link rel="stylesheet" href="resources/css/comments.css">
<script type="text/javascript">
let url = 'https://861c-218-146-69-112.ngrok-free.app/finalproject/diary_selectOne.do?id=${param.id}&mbnum=${param.mbnum}';
let iswriter = false;

$(function(){
	//사용자가 해당 글에 좋아요를 눌렀는지 확인하는 함수
	let sid = '';
	sid = '${user_id}';
	if(sid != ''){
		$.ajax({
			url : "json_mb_likeCheck.do",
			method : 'GET',
			data : {
				id : sid,
				mbnum : ${param.mbnum}
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
		url : "json_mb_like.do",
		method : 'GET',
		data : {
			id : sid,
			mbnum : ${param.mbnum}
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
		url : "json_mb_like_delete.do",
		method : 'GET',
		data : {
			id : sid,
			mbnum : ${param.mbnum}
		},
		dataType : 'json', 
		success : function(map) {
	// 			console.log(map.result);
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
	let url = "mb_report.do?mbnum="+${vo2.mbnum}+"&id=${mh_attr.id}";
	let name = "신고하기";
	let option = "width = 500, height = 500";
	window.open(url, name, option);
}//end report()

function copy_url(){
	navigator.clipboard.writeText(url).then(() => {
        alert("복사완료");
      });
}

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

$(function(){
	Kakao.init('8b87b1c63625a7c92d74e9e4019cc90f');
	if(Kakao.isInitialized()){
		Kakao.Share.createScrapButton({
		    container: '#kakaotalk-sharing-btn',
		    requestUrl: url
		});
	}
});

function minicomments(writer, mcnum=0, mccnum=0, mbnum=${param.mbnum}, insert_num=0){	// 댓글 출력 함수
	console.log("print minicomments...mbnum: ", mbnum);
	$.ajax({
		url: 'json_mc_selectAll.do',
		data: {mbnum: mbnum},
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
											<span><button onclick="mc_report(\${vo.mcnum}, \${vo.mccnum}, \${mbnum})" id="report_\${vo.mcnum}">신고</button></span>
											<span><button onclick="minicomments('\${writer}', 0, 0, \${mbnum}, \${vo.mcnum})" id="cocoment_\${vo.mcnum}">답글</button></span>
											<span><div id="count_clikes_\${vo.mcnum}"></div></span>
											<span id="clike_btn_\${vo.mcnum}">
												<button onclick="clike(\${vo.mcnum})" id="clike_\${vo.mcnum}"><img width="15px" src="resources/icon/not_clike.png" /></button>
												<button onclick="cancel_clike(\${vo.mcnum})" id="cancel_clike_\${vo.mcnum}"><img width="15px" src="resources/icon/clike.png" /></button>
											</span>
										</td>
									</tr>
								</table>
							</div>
						`;
						
				if(mcnum === vo.mcnum){	// 댓글 수정인 경우
					tag_comments += `
						<div class="comm_write_box" style="display: flex">
							<table style="flex: 1 500px">
								<tr>
									<td rowspan="2"><textarea cols="100%;" rows="3" id="comm_content">\${vo.content}</textarea></td>
									<td width="130px;">
										<div class="update_btn_wrap">	
											<span><button onclick="minicomments('\${writer}', 0, 0, \${mbnum}, 0)">취소</button></span>
											<span><button onclick="mc_updateOK(\${vo.mcnum})">수정완료</button></span>
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
				else{ 	// 댓글 출력
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
													<span id="mc_delete_\${vo.mcnum}">
														<button onclick="mc_deleteOK(\${vo.mcnum})" >삭제</button></span>
													<span id="mc_update_\${vo.mcnum}">
														<button onclick="minicomments('\${writer}', \${vo.mcnum}, \${vo.mccnum}, \${mbnum})" >수정</button></span>
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
											<span id="mc_delete_\${vo.mcnum}">
												<button onclick="mc_deleteOK(\${vo.mcnum})" >삭제</button></span>
											<span id="mc_update_\${vo.mcnum}">
												<button onclick="minicomments('\${writer}', \${vo.mcnum}, \${vo.mccnum}, \${mbnum})" >수정</button></span>
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
					<li id="minicocomments_\${vo.mcnum}">`;	// 대댓글 출력 위치
				
				if(insert_num === vo.mcnum){	// 대댓글 작성
					tag_comments += `</li>
						<li>
							<hr/>
							<div class="coco_img" style="float:left; padding:10px;">
								<img width="15px" src="resources/icon/cocomment.png" /></div>
							<div class="comm_write_box" styel="display: flex">
								<table style="flex: 1 500px; width:100%;">
									<tr>
										<td rowspan="2" width="90%;"><textarea cols="100%" rows="3" id="comm_content"></textarea></td>
										<td width="100px;">
											<div width="130px;" class="insert_wrap">
												<span><button onclick="minicomments('\${writer}', 0, 0, \${mbnum}, 0)">취소</button></span>
												<span><button onclick="mc_insertOK(\${vo.mcnum}, \${mbnum})">등록</button></span>
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
			
			if(insert_num === 0){	// 답글을 누르지 않았을 때
				tag_comments += `</li>
					<li>
						<hr/>
						<div class="comm_write_box" styel="display: flex">
							<table style="flex: 1 500px; width:100%;">
								<tr>
									<td rowspan="2"><textarea rows="3" id="comm_content"></textarea></td>
									<td width="100px;">
										<div width="130px;" class="insert_wrap">
											<span><button width="100px;" onclick="mc_insertOK(0, \${mbnum})">등록</button></span>
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
			
			$("#minicomments").html(tag_comments);
			
			$.each(arr, function(index, vo){
				minicocomments(writer, vo.mcnum, mbnum, mcnum);	// 대댓글 출력 함수 호출
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
				
				if(mcnum === vo.mcnum){				// 수정중에는 버튼 숨김
					$("#mc_update_"+vo.mcnum).hide();
					$("#clike_btn_"+vo.mcnum).hide();
					$("#cocoment_"+vo.mcnum).hide();
					$("#report_"+vo.mcnum).hide();
					$("#cdate_"+vo.mcnum).hide();
					$("#count_clikes_"+vo.mcnum).hide();
					$("#c_delete_"+vo.mcnum).hide();
				}
			});
		},
		error : function(xhr, status, error) {
			console.log('xhr:', xhr.status);
		}
	});
}

function minicocomments(writer, mcnum, mbnum=${param.mbnum}, update_num){		// 대댓글 출력 함수
	console.log('print cocomments...mcnum:', mcnum, 'mbnum: ', mbnum);
	$.ajax({
		url: 'json_mcc_selectAll.do',
		data: {mcnum: mcnum},
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
											<span><button onclick="mc_report(\${vo.mcnum}, \${vo.mccnum}, \${mbnum})" id="report_\${vo.mcnum}">신고</button></span>
											<span><div id="count_clikes_\${vo.mcnum}"></div></span>
											<span id="clike_btn_\${vo.mcnum}">
												<button onclick="clike(\${vo.mcnum})" id="clike_\${vo.mcnum}"><img width="15px" src="resources/icon/not_clike.png" /></button>
												<button onclick="cancel_clike(\${vo.mcnum})" id="cancel_clike_\${vo.mcnum}"><img width="15px" src="resources/icon/clike.png" /></button>
											</span>
										</td>
									</tr>
								</table>
							</div>
						`;
										
				if(update_num === vo.mcnum){	// 대댓글 수정인 경우
					tag_cocomments += `
						<div class="comm_write_box" style="display: flex">
							<table style="flex: 1 500px">
								<tr>
									<td rowspan="2"><textarea cols="100%;" rows="3" id="comm_content">\${vo.content}</textarea></td>
									<td width="130px;">
										<div class="update_btn_wrap">	
											<span><button onclick="minicomments('\${writer}', 0, 0, \${mbnum}, 0)">취소</button></span>
											<span><button onclick="mc_updateOK(\${vo.mcnum})">수정완료</button></span>
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
													<span id="mc_delete_\${vo.mcnum}">
														<button onclick="mc_deleteOK(\${vo.mcnum})" >삭제</button></span>
													<span id="mc_update_\${vo.mcnum}">
														<button onclick="minicomments('\${writer}', \${vo.mcnum}, \${vo.mccnum}, \${mbnum})" >수정</button></span>
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
												<span id="mc_delete_\${vo.mcnum}">
													<button onclick="mc_deleteOK(\${vo.mcnum})" >삭제</button></span>
												<span id="mc_update_\${vo.mcnum}">
													<button onclick="minicomments('\${writer}', \${vo.mcnum}, \${vo.mccnum}, \${mbnum})" >수정</button></span>
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
				
				if(update_num === vo.mcnum){		// 수정중에는 버튼 숨김
					$("#mc_update_"+vo.mcnum).hide();
					$("#clike_btn_"+vo.mcnum).hide();
					$("#report_"+vo.mcnum).hide();
					$("#cdate_"+vo.mcnum).hide();
					$("#count_clikes_"+vo.mcnum).hide();
					$("#c_delete_"+vo.mcnum).hide();
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
		data: {mccnum: mcnum,
			mbnum: mbnum,
			id: '${mh_attr.id}',
			writer: '${nickname}',
			content: $("#comm_content").val(),
			secret: $("input[name='secret']").is(":checked")? 1:0},
		method: 'POST',
		dataType: 'json',
		success: function(response){
			if(response.result === 1){
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
			content: $("#comm_content").val(),
			secret: $("input[name='update_secret']").is(":checked")? 1:0},
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
	
	let url = "mc_report.do?mcnum="+mcnum+'&mccnum='+mccnum+'&mbnum='+mbnum+"&id=${mh_attr.id}";
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

function count_clikes(mcnum){		// 댓글 좋아요 카운트 함수
	console.log('count clikes...mcnum: ', mcnum);
	
	$.ajax({
		url: 'json_mc_count_clikes.do',
		data: {mcnum: mcnum},
		method: 'POST',
		dataType: 'json',
		success: function(count){
			console.log('likes: ', mcnum, ' - ', count);
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

function checkviewer(writer){
	console.log('check viewer...', writer);
	if(writer === '${nickname}')	// 게시글 작성자와 게시글 열람자의 닉네임이 같을 경우
		iswriter = true;
	
	console.log('iswriter is...', iswriter);
}
</script>
</head>

<body class="" onload="minicomments('${vo2.writer}')">
<jsp:include page="../mini_top_menu.jsp"></jsp:include>
<div class="wrapper ">
	<div class="main-panel"
		style="background-image: url('resources/uploadimg/${mh_attr.backimg}')">
		<jsp:include page="../mini_navbar.jsp"></jsp:include>
		<div class="content"
			style="background-size: cover; width: 100%; height: 100vh;">
			<div class="row">
				<div class="col-md-12">
					<div class="card">
						<div class="card-header">
							<div class="card-title">
								<h4 class="card-title" id="title">
									<span id="titleSpan">${vo2.title}</span>
								</h4>
								<div>닉네임 : ${vo2.writer}</div>
								<div>작성일자 : ${vo2.wdate}</div>
							</div>
						</div>
						<div class="card-body">
							<div>
								<p id="content">
									<span id="contentSpan">${vo2.content}</span>
								</p>
							</div>
							<div>
								<button onclick="like()" id="like_button">좋아요</button>
								<button onclick="like_cancel()" id="lcancel_button"
									style="display: none">좋아요 취소</button>
								<span id="likes_count">${vo2.likes }</span>
								<button onclick="open_modal()">공유</button>
								<button onclick="report()" id="report_button">신고</button>
							</div>
							<div id="buttonContainer">
								<a href="diary_update.do?id=${mh_attr.id}&mbnum=${param.mbnum}"
									class="myButton">수정</a> <a
									href="diary_deleteOK.do?id=${mh_attr.id}&mbnum=${param.mbnum}"
									class="myButton">삭제</a>
							</div>

						</div>
						<div class="card-footer">
							<div class="comments wrap" id="comments wrap">
								<ul class="comments" id="minicomments">
								</ul>
							</div>
						</div>
					</div>

					<div id="modal">
						<div class="modal-content">
							<h6>공유하기</h6>
							<button onclick="share_twitter()" id="share_button">트위터로
								공유</button>
							<button onclick="share_facebook()" id="share_button">페이스북으로
								공유</button>
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

				</div>
			</div>
		</div>

		<footer class="footer footer-black  footer-white ">
			<div class="container-fluid">
				<div class="row">
					<nav class="footer-nav">
						<ul>
							<li><a href="https://www.creative-tim.com" target="_blank">Creative
									Tim</a></li>
							<li><a href="https://www.creative-tim.com/blog"
								target="_blank">Blog</a></li>
							<li><a href="https://www.creative-tim.com/license"
								target="_blank">Licenses</a></li>
						</ul>
					</nav>
					<div class="credits ml-auto">
						<span class="copyright"> © <script>
                 document.write(new Date().getFullYear())
               </script>, made with <i class="fa fa-heart heart"></i> by
							Creative Tim
						</span>
					</div>
				</div>
			</div>
		</footer>
	</div>
</div>
<!--   Core JS Files   -->
<script src="resources/assets/js/core/jquery.min.js"></script>
<script src="resources/assets/js/core/popper.min.js"></script>
<script src="resources/assets/js/core/bootstrap.min.js"></script>
<script
	src="resources/assets/js/plugins/perfect-scrollbar.jquery.min.js"></script>
<!-- Chart JS -->
<script src="resources/assets/js/plugins/chartjs.min.js"></script>
<!--  Notifications Plugin    -->
<script src="resources/assets/js/plugins/bootstrap-notify.js"></script>
<!-- Control Center for Now Ui Dashboard: parallax effects, scripts for the example pages etc -->
<script src="resources/assets/js/paper-dashboard.min.js?v=2.0.1"
	type="text/javascript"></script>
<!-- Paper Dashboard DEMO methods, don't include it in your project! -->

<script type="text/javascript">
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
<script type="text/javascript">
  // 다른 사람의 미니홈피 방문시 다이어리 작성 버튼 숨김
  if('${user_id}' != '${mh_attr.id}'){	
      $('#buttonContainer').hide();
  }
  if('${vo2.filepath}' == ''){
	  $('#imageContainer').hide();
  }
</script>
</body>

</html>