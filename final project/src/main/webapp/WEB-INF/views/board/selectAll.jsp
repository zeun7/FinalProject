<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.4/moment.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.4/moment-with-locales.min.js"></script>
<title>Insert title here</title>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
<script type="text/javascript">
let page = 1;
let limit = 10;

$(function(){
	$.ajax({
		url : "json_b_count.do",
		method : 'GET',
		data : {
			bname : '${param.bname}'
		},
		dataType : 'json', 
		success : function(result) {
// 			console.log(result);
			let tag_page = 0;
			let tag_pages = '';
			
			while(result > 0){
				tag_page++;
				tag_pages += `
					<button onclick=selectAll(\${tag_page},\${limit})>\${tag_page}</button>
				`;
				
				result -= limit;
			}
			
// 			$("#board_name").text('${param.bname}');
			$("#page").html(tag_pages);
		},
		error : function(xhr, status, error) {
			console.log('xhr:', xhr.status);
//			console.log('status:', status);
//			console.log('error:', error);
		}
	});//end $.ajax()
});//end onload

function selectAll(page, limit){
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
 				let date = moment(vo.wdate).format('YYYY-MM-DD HH:mm:ss');
//  				console.log(date);
 				tag_vos += `
 					<tr>
 						<td><a href="b_selectOne.do?bnum=\${vo.bnum}">\${vo.bnum}</a></td>
 						<td>\${vo.caname}</td>
 						<td><a href="b_selectOne.do?bnum=\${vo.bnum}">\${vo.title}</a></td>
 						<td>\${vo.writer}</td>
 						<td>\${date}</td>
 						<td>\${vo.vcount}</td>
 						<td>\${vo.likes}</td>
 					</tr>
 				`;
 			}
			
			$("#vos").html(tag_vos); 
		},
		error : function(xhr, status, error) {
			console.log('xhr:', xhr.status);
//			console.log('status:', status);
//			console.log('error:', error);
		}
	});//end $.ajax()
}//end selectAll()

function searchListCount(){
	console.log('searchListCount()');
	$.ajax({
		url : "json_b_searchList_count.do",
		method : 'GET',
		data : {
			bname : '${param.bname}',
			searchKey : $("#searchKey").val(),
			searchWord : $("#searchWord").val()
		},
		dataType : 'json', 
		success : function(result) {
			console.log(result);
			let tag_page = 0;
			let tag_pages = '';
			
			while(result > 0){
				tag_page++;
				tag_pages += `
					<button onclick=searchList(\${tag_page},\${limit})>\${tag_page}</button>
				`;
				
				result -= limit;
			}
			
// 			$("#board_name").text('${param.bname}');
			$("#page").html(tag_pages);
		},
		error : function(xhr, status, error) {
			console.log('xhr:', xhr.status);
//			console.log('status:', status);
//			console.log('error:', error);
		}
	});//end $.ajax()
}//end searchListCount()

function searchList(page, limit){
// 	console.log('searchList()');
	searchListCount();
	$.ajax({
		url : "json_b_searchList.do",
		method : 'GET',
		data : {
			bname : '${param.bname}',
			page : page,
			limit : limit,
			searchKey : $("#searchKey").val(),
			searchWord : $("#searchWord").val()
		},
		dataType : 'json', 
		success : function(arr) {
// 				console.log('ajax...success:', arr);
// 				console.log(arr);
			let tag_vos = '';
			for ( let i in arr) {
 				let vo = arr[i];
 				let date = moment(vo.wdate).format('YYYY-MM-DD HH:mm:ss');
//  				console.log(date);
 				tag_vos += `
 					<tr>
 						<td><a href="b_selectOne.do?bnum=\${vo.bnum}">\${vo.bnum}</a></td>
 						<td>\${vo.caname}</td>
 						<td><a href="b_selectOne.do?bnum=\${vo.bnum}">\${vo.title}</a></td>
 						<td>\${vo.writer}</td>
 						<td>\${date}</td>
 						<td>\${vo.vcount}</td>
 						<td>\${vo.likes}</td>
 					</tr>
 				`;
 			}
			
			$("#vos").html(tag_vos); 
		},
		error : function(xhr, status, error) {
			console.log('xhr:', xhr.status);
//			console.log('status:', status);
//			console.log('error:', error);
		}
	});//end $.ajax()
}//end searchList()

function changeLimit(){
	limit = $("#limit").val();
	console.log(limit);
}

</script>
</head>
<body onload="selectAll(page, limit)">
	<jsp:include page="../top_menu.jsp"></jsp:include>
	<h1>${param.bname }</h1>
	<select name="limit" id="limit" onchange="changeLimit()">
		<option value="10">10</option>
		<option value="15">15</option>
		<option value="20">20</option>
	</select>
	<a href="b_insert.do?bname=${param.bname }">글쓰기</a>
	<table border="1">
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
	
	<select name="searchKey" id="searchKey">
		<option value="title">제목</option>
		<option value="content">내용</option>
		<option value="writer">작성자</option>
	</select>
	<input type="text" name="searchWord" id="searchWord" value="1">
	<button onclick="searchList(1, 10)">검색</button>
</body>
</html>