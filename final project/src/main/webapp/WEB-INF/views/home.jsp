<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<html>
<head>
<title>Home</title>
<jsp:include page="css.jsp"></jsp:include>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
<%
String id = "";
if(session.getAttribute("user_id") != null){
	id = (String)session.getAttribute("user_id");
}
%>
<script type="text/javascript">
$(function(){
	console.log('load posts...');
	if('${user_id}' === ''){
		post_new();
	}
	else{
		post_friends();
	}
// 	post_board('board1');
// 	post_board('board2');
// 	post_board('board3');
// 	post_board('board4');
// 	post_board('board5');
});

function post_friends(){
	console.log('load friends posts...');
	let id = '<%=id%>';
	
	$.ajax({
		url: 'json_post_friends.do',
		data: {id: id},
		method: 'GET',
		dataType: 'json',
		success: function(arr){
			console.log('ajax success...', arr);
			
			let tag_vos = `
				<table>
					<thead>
						<tr>
							<th>친구들의 소식</th>
							<th>인기순</th>
							<th>최신순</th>
						</tr>
					</thead>
					<tbody>`;
					
			$.each(arr, function(index,vo){
				tag_vos += `
					<tr>
						<td>${vo.title}</td>
						<td>${vo.writer}</td>
						<td>${vo.wdate}</td>
					</tr>
			});
			
			tag_vos += `
					</tbody>
				</table>
				`;
		}
	});
}
</script>
</head>
<body>
<jsp:include page="top_menu.jsp"></jsp:include>
	<h1>Hello world!</h1>
	user_id: ${user_id}<br/>
	nickname: ${nickname}<br />
	mclass: ${mclass}
	
	<table>
		<tr>
			<td id="vos1"></td>
			<td id="vos2"></td>
		</tr>
		<tr>
			<td id="vos3"></td>
			<td id="vos4"></td>
		</tr>
		<tr>
			<td id="vos5"></td>
			<td id="vos6"></td>
		</tr>
	</table>
</body>
</html>