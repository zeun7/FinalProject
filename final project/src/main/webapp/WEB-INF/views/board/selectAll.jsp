<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
<script type="text/javascript">
let page = 1;
let limit = 10;

$(function(){
// 	console.log('onload...');
	$.ajax({
		url : "json_b_selectAll.do",
		method : 'GET',
		data : {
			bname : '${param.bname}',
			page : page,
			limit : limit
		},
		dataType : 'json', 
		success : function(arr) {
// 				console.log('ajax...success:', arr);
// 				console.log(arr);
			let tag_vos = '';
			for ( let i in arr) {
 				let vo = arr[i];
 				tag_vos += `
 					<tr>
 						<td><a href="b_selectOne.do?bnum=\${vo.bnum}">\${vo.bnum}</a></td>
 						<td>\${vo.caname}</td>
 						<td><a href="b_selectOne.do?bnum=\${vo.bnum}">\${vo.title}</a></td>
 						<td>\${vo.writer}</td>
 						<td>\${vo.wdate}</td>
 						<td>\${vo.vcount}</td>
 						<td>\${vo.likes}</td>
 					</tr>
 				`;
 			}
			
			$("#vos").html(tag_vos); //response가 텍스트가 아닌 객체
		},
		error : function(xhr, status, error) {
			console.log('xhr:', xhr.status);
//			console.log('status:', status);
//			console.log('error:', error);
		}
	});//end $.ajax()
});//end onload
</script>
</head>
<body>
	<jsp:include page="../top_menu.jsp"></jsp:include>
	<h1>게시판 이름</h1>
	<table>
		<thead>
			<tr>
				<th>번호</th>
				<th>유형</th>
				<th>제목</th>
				<th>글쓴이</th>
				<th>작성일</th>
				<th>조회수</th>
				<th>추천수</th>
			</tr>
		</thead>
		<tbody id="vos">
		
		</tbody>
		<tfoot>
			<tr>
				<td colspan="7" id="page"></td>
			</tr>
		</tfoot>	
	</table>
</body>
</html>