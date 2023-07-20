<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
	language="java"%>
<html>
<head>
<title>Home</title>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
<script src="https://kit.fontawesome.com/7ed6703c9d.js" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.4/moment.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.4/moment-with-locales.min.js"></script>
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
	
	post_board('board1', 'wdate');
	post_board('board2', 'wdate');
	post_board('board3', 'wdate');
	post_board('board4', 'wdate');
	post_board('board5', 'wdate');
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
							<th colspan="3" style="text-align: center;"><친구들의 소식></th>
							<th colspan="2" style="display: flex;">
								<button style="margin-right:2px;" class="button btnPush" onclick="post_friends('vcount')">인기순</button>
								<button class="button btnPush" onclick="post_friends('wdate')">최신순</button>
							</th>
						</tr>
					</thead>
					<tbody>`;
					
			$.each(arr, function(index,vo){
				let date = moment(vo.wdate).format('YY/MM/DD HH:mm');
				tag_vos += `
					<tr data-bnum="\${vo.mbnum}">
						<td style="width: 50px">\${vo.mbnum}</td>
						<td style="width: 200px; max-width: 200px; overflow: hidden; text-overflow: ellipsis; white-space: nowrap;">
						`;
				
				if(vo.isFileExist == 1){
					tag_vos += `<i class="fa-regular fa-image"></i>`;
				}
				
				if(vo.mbname === 'diary'){
					tag_vos += `<a style="width: 200px;" href="diary_selectOne.do?id=\${uid}&mbnum=\${vo.mbnum}">\${vo.title}</a></td>`;
				}else{
					tag_vos += `<a style="width: 200px;" href="gallery_selectOne.do?id=\${uid}&mbnum=\${vo.mbnum}">\${vo.title}</a></td>`;
				}
				
				tag_vos += `<td style="width: 120px; max-width: 120px; overflow: hidden; text-overflow: ellipsis; white-space: nowrap;">\${vo.writer}</td>
						<td>\${date}</td>
					</tr>`;
			});
			
			tag_vos += `
					</tbody>
				</table>
				`;
			
			$('#hot').html(tag_vos);
		}
	});
}

function post_board(boardName, sortKey){
	console.log('load board posts...'+boardName);
	let bname = boardName;
	
	$.ajax({
		url: 'json_post_board.do',
		data: {
			bname: bname,
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
							<th colspan="3" style="text-align: center;">`;
			tag_vos += `<a href="b_selectAll.do?bname=`+bname+`">`+boardName+`</a>`;
			tag_vos += `			</th>
							<th colspan="2" style="display: flex;">
								<button style="margin-right:2px;" class="button btnPush" onclick="post_board('`+boardName+`', 'vcount')">인기순</button>
								<button class="button btnPush" onclick="post_board('`+boardName+`', 'wdate')">최신순</button>
							</th>
						</tr>
					</thead>
					<tbody>`;
					
			$.each(arr, function(index,vo){
				let date = moment(vo.wdate).format('YY/MM/DD HH:mm');
				tag_vos += `
					<tr data-bnum="\${vo.bnum}">
						<td style="width: 50px">\${vo.bnum}</td>
						<td style="width: 200px; max-width: 200px; overflow: hidden; text-overflow: ellipsis; white-space: nowrap;">
						`;
				
				if(vo.isFileExist == 1){
					tag_vos += `<i class="fa-regular fa-image"></i>`;
				}
				if(vo.ccount != 0){
					tag_vos += `<a href="b_selectOne.do?bnum=\${vo.bnum}">\${vo.title}[\${vo.ccount}]</a></td>
							<td style="width: 120px; max-width: 120px; overflow: hidden; text-overflow: ellipsis; white-space: nowrap;">\${vo.writer}</td>
							<td>\${date}</td>
						</tr>`;
				} else{
					tag_vos += `<a href="b_selectOne.do?bnum=\${vo.bnum}">\${vo.title}</a></td>
						<td style="width: 120px; max-width: 120px; overflow: hidden; text-overflow: ellipsis; white-space: nowrap;">\${vo.writer}</td>
						<td>\${date}</td>
					</tr>`;
				}
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
<div class="main-panel">
	<div class="content">
		<div class="row">
			<div class="col-md-12">
				<div class="card">
					<div class="card-body" style="display: flex; justify-content: center; flex: 1;">
						<table style="display:flex; justify-content: space-between;">
							<tr style="display:flex;">
								<td id="hot"></td>
								<td id="board1" style="margin-left: 80px;"></td>
							</tr>
							<tr><td colspan="2"><hr></td></tr>
							<tr style="display:flex;">
								<td id="board2"></td>
								<td id="board3" style="margin-left: 80px;"></td>
							</tr>
							<tr><td colspan="2"><hr></td></tr>
							<tr style="display:flex;">
								<td id="board4"></td>
								<td id="board5" style="margin-left: 80px;"></td>
							</tr>
							<tr><td colspan="2"><br></td></tr>
						</table>
					</div> <!-- end "card-body" -->
				</div> <!-- end "card" -->
			</div> <!-- end "col-md-12" -->
		</div> <!-- end "row" -->
	</div> <!-- end "content" -->
	<jsp:include page="footer.jsp"></jsp:include>
</div> <!-- end "main-panel" -->
</body>
</html>