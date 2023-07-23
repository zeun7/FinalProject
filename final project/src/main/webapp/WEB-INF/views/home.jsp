<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
	language="java"%>
<html>
<head>
<title>Home</title>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
<script src="https://kit.fontawesome.com/7ed6703c9d.js"
	crossorigin="anonymous"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.4/moment.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.4/moment-with-locales.min.js"></script>
<link rel="stylesheet" href="resources/css/button3.css">
<link rel="stylesheet" href="resources/css/board_table.css">
<%
String id = "";
if (session.getAttribute("user_id") != null) {
	id = (String) session.getAttribute("user_id");
}
%>
<script type="text/javascript">
let uid = '${user_id}';
let limit = 5;

$(function(){
	console.log('load posts...');
	
	post_board('board01', 'wdate');
	post_board('board02', 'wdate');
	post_board('board03', 'wdate');
	post_board('board04', 'wdate');
	post_board('board05', 'wdate');
	if(uid === ''){
		post_board('hot', 'wdate');
	}
	else{
		post_friends('wdate');
	}
});

function post_friends(sortKey){
	console.log('load friends posts...');
	
	$.ajax({
		url: 'json_post_friends.do',
		data: {
			id: uid,
			limit: limit,
			sortKey: sortKey
			},
		method: 'GET',
		dataType: 'json',
		success: function(arr){
			console.log('ajax success...', arr);
			
			let tag_vos = `
				<table>
					<thead>
					    <tr>
				            <th colspan="2" style="width: 120px; text-align: center;">친구들의 소식</th>
				        	<th style="display: flex;">
					            <button class="button btnPush" onclick="post_friends('vcount')">인기순</button>
					            <button class="button btnPush" onclick="post_friends('wdate')">최신순</button>
				            </th>
					    </tr>
					</thead>
					<tbody><tr><td style="width: 200px;"></td><td style="width: 120px;"></td><td style="width: 100px;"></td></tr>`;
					
			$.each(arr, function(index,vo){
				let date = '';
				if(moment().format('YYYY-MM-DD') === moment(vo.wdate).format('YYYY-MM-DD')){	// 오늘 작성한 게시글
 					date = moment(vo.wdate).format('HH시mm분');
 				} else{											// 오늘 이전에 작성한 게시글
 					date = moment(vo.wdate).format('MM월DD일');
 				}
				
				tag_vos += `
					<tr data-bnum="\${vo.mbnum}">
						<td style="width: 200px; max-width: 200px; overflow: hidden; text-overflow: ellipsis; white-space: nowrap;">
						`;
				
				if(vo.isFileExist == 1){
					tag_vos += `<i class="fa-regular fa-image"></i>`;
				}
				
				if(vo.mbname === 'diary'){
					tag_vos += `<a style="width: 200px;" href="diary_selectOne.do?nickname=\${vo.writer}&mbnum=\${vo.mbnum}">\${vo.title} `;
					
					if(vo.ccount !== 0){
						tag_vos += `<small>[\${vo.ccount}]</small></a></td>`;
					} else {
						tag_vos += `</a></td>`;
					}
				}else{
					tag_vos += `<a style="width: 200px;" href="gallery_selectOne.do?nickname=\${vo.writer}&mbnum=\${vo.mbnum}">\${vo.title} `;

					if(vo.ccount !== 0){
						tag_vos += `<small>[\${vo.ccount}]</small></a></td>`;
					} else {
						tag_vos += `</a></td>`;
					}
				}
				
				tag_vos += `<td style="width: 120px; max-width: 120px; overflow: hidden; text-overflow: ellipsis; white-space: nowrap;">\${vo.writer}</td>
						<td style="width: 100px; text-align: center;">\${date}</td>
					</tr>`;
			});
			
			tag_vos += `
					</tbody>
				</table>
				`;
			
			$('#인기글').html(tag_vos);
		}
	});
}

function post_board(boardName, sortKey){
	console.log('load board posts...'+boardName);
	
	let bname = '';
	if(boardName === 'board01'){
		bname = '자유';
	} else if(boardName === 'board02'){
		bname = '일상';
	} else if(boardName === 'board03'){
		bname = '유머';
	} else if(boardName === 'board04'){
		bname = '엔터';
	} else if(boardName === 'board05'){
		bname = '스포츠';
	} else if(boardName === 'hot'){
		bname = '인기글';
	}
	
	$.ajax({
		url: 'json_post_board.do',
		data: {
			bname: boardName,
			limit: limit,
			sortKey: sortKey
			},
		method: 'GET',
		dataType: 'json',
		success: function(arr){
			console.log('ajax success...', arr);
			
			let tag_vos = `
				<table>
					<thead>
						<tr>
							<th colspan="2" style="width: 120px; text-align: center;">`;
			tag_vos += `<a href="b_selectAll.do?bname=`+boardName+`">`+bname+`</a></th>`;
			tag_vos += `			
							<th style="display: flex;">
								<button class="button btnPush" onclick="post_board('`+boardName+`', 'vcount')">인기순</button>
								<button class="button btnPush" onclick="post_board('`+boardName+`', 'wdate')">최신순</button>
							</th>
						</tr>
					</thead>
					<tbody><tr><td style="width: 200px;"></td><td style="width: 120px;"></td><td style="width: 100px;"></td></tr>`;
					
			$.each(arr, function(index,vo){
				let date = '';
				if(moment().format('YYYY-MM-DD') === moment(vo.wdate).format('YYYY-MM-DD')){	// 오늘 작성한 게시글
 					date = moment(vo.wdate).format('HH시mm분');
 				} else{											// 오늘 이전에 작성한 게시글
 					date = moment(vo.wdate).format('MM월DD일');
 				}
				
				tag_vos += `
					<tr data-bnum="\${vo.bnum}">
						<td style="width: 200px; max-width: 200px; overflow: hidden; text-overflow: ellipsis; white-space: nowrap;">
						`;
				
				if(vo.isFileExist == 1){
					tag_vos += `<i class="fa-regular fa-image"></i>`;
				}
				
				if(vo.ccount != 0){
					tag_vos += `<a href="b_selectOne.do?bnum=\${vo.bnum}">\${vo.title} <small>[\${vo.ccount}]</small></a></td>`;
				} else {
					tag_vos += `<a href="b_selectOne.do?bnum=\${vo.bnum}">\${vo.title}</a></td>`;
				}
				
				tag_vos += `<td style="width: 120px; max-width: 120px; overflow: hidden; text-overflow: ellipsis; white-space: nowrap;">\${vo.writer}</td>
						<td style="width: 100px; text-align: center;">\${date}</td>
					</tr>`;
				
			});
			
			tag_vos += `
					</tbody>
				</table>
				`;
			
			$('#'+bname).html(tag_vos);
		}
	});
}

$(document).ready(function(){
	$("body").on("click", "tr[data-mbnum], tr[data-bnum]", function(){
	        window.location = $(this).find("a[href]").attr("href");
	        return false; // 이벤트 전파를 중지합니다.
	});
});
</script>
</head>
<body>
	<jsp:include page="sidebar.jsp"></jsp:include>
	<jsp:include page="navbar.jsp"></jsp:include>
	<div class="main-panel"
		style="background-image: url('resources/AI_Backimg/MainHome.png'); background-size: cover; background-repeat: no-repeat;">
		<div class="content" style="height: 100%;">
			<div class="row">
				<div class="col-md-12">
					<div class="card"
						style="background-color: rgba(255, 255, 255, 0.9);">
						<div class="card-body"
							style="display: flex; justify-content: center; flex: 1;">
							<table style="display: flex; justify-content: space-between;">
								<tr style="display: flex;">
									<td id="인기글" style="width: 500px;"></td>
									<td id="자유" style="margin-left: 80px; width: 500px;"></td>
								</tr>
								<tr>
									<td colspan="2" style="width: 1000px;"><hr></td>
								</tr>
								<tr style="display: flex;">
									<td id="일상" style="width: 500px;"></td>
									<td id="유머" style="margin-left: 80px; width: 500px;"></td>
								</tr>
								<tr>
									<td colspan="2" style="width: 1000px;"><hr></td>
								</tr>
								<tr style="display: flex;">
									<td id="엔터" style="width: 500px;"></td>
									<td id="스포츠" style="margin-left: 80px; width: 500px;"></td>
								</tr>
								<tr>
									<td colspan="2" style="width: 1000px;"><br></td>
								</tr>
							</table>
						</div>
						<!-- end "card-body" -->
					</div>
					<!-- end "card" -->
				</div>
				<!-- end "col-md-12" -->
			</div>
			<!-- end "row" -->
		</div>
		<!-- end "content" -->
		<jsp:include page="footer.jsp"></jsp:include>
	</div>
	<!-- end "main-panel" -->
</body>
</html>