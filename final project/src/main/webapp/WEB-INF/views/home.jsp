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
							<th>친구들의 소식</th>
							<th><button onclick="post_friends('vcount')">인기순</button></th>
							<th><button onclick="post_friends('wdate')">최신순</button></th>
						</tr>
					</thead>
					<tbody>`;
					
			$.each(arr, function(index,vo){
				let date = moment(vo.wdate).format('YYYY-MM-DD HH:mm:ss');
				tag_vos += `
					<tr>
						<td>\${vo.mbnum}</td>
						<td>
						`;
				
				if(vo.isFileExist == 1){
					tag_vos += `<i class="fa-regular fa-image"></i>`;
				}
				
				if(vo.mbname === 'diary'){
					tag_vos += `<a href="diary_selectOne.do?id=\${uid}&mbnum=\${vo.mbnum}">\${vo.title}</a></td>`;
				}else{
					tag_vos += `<a href="gallery_selectOne.do?id=\${uid}&mbnum=\${vo.mbnum}">\${vo.title}</a></td>`;
				}
				
				tag_vos += `<td>\${vo.writer}</td>
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
							<th>`;
			tag_vos += `<a href="b_selectAll.do?bname=`+bname+`">`+boardName+`</a>`;
			tag_vos += `			</th>
							<th><button onclick="post_board('`+boardName+`', 'vcount')">인기순</button></th>
							<th><button onclick="post_board('`+boardName+`', 'wdate')">최신순</button></th>
						</tr>
					</thead>
					<tbody>`;
					
			$.each(arr, function(index,vo){
				let date = moment(vo.wdate).format('YYYY-MM-DD HH:mm:ss');
				tag_vos += `
					<tr>
						<td>\${vo.bnum}</td>
						<td>
						`;
				
				if(vo.isFileExist == 1){
					tag_vos += `<i class="fa-regular fa-image"></i>`;
				}
						
				tag_vos += `<a href="b_selectOne.do?bnum=\${vo.bnum}">\${vo.title}[\${vo.ccount}]</a></td>
						<td>\${vo.writer}</td>
						<td>\${date}</td>
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
</script>
</head>
<body>
<jsp:include page="sidebar.jsp"></jsp:include>
<div class="main-panel">
	<h1>Hello world!</h1>

	<table>
		<tr>
			<td id="hot"></td>
			<td id="board1"></td>
		</tr>
		<tr><td colspan="2"><hr></td></tr>
		<tr>
			<td id="board2"></td>
			<td id="board3"></td>
		</tr>
		<tr><td colspan="2"><hr></td></tr>
		<tr>
			<td id="board4"></td>
			<td id="board5"></td>
		</tr>
	</table>
</div>
</body>
</html>