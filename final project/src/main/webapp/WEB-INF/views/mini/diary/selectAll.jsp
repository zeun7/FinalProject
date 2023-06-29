<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<html>
<head>
<title>다이어리_selectAll</title>
<jsp:include page="../../css.jsp"></jsp:include>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
<script type="text/javascript">
let page = 1;
let curPage = 1;
let limit = 10;
let isSelectAll = true;

function selectAllCount(){
	console.log('selectAllCount()');
	isSelectAll = true;
	console.log('isSelectAll:', isSelectAll);
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
			
			if(curPage > tag_page){
				curPage = tag_page;
			}
			selectAll(curPage, limit);
			
// 			$("#board_name").text('${param.bname}');
			$("#page").html(tag_pages);
		},
		error : function(xhr, status, error) {
			console.log('xhr:', xhr.status);
//			console.log('status:', status);
//			console.log('error:', error);
		}
	});//end $.ajax()
}//end selectAllCount()

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
 				if(vo.caname === 'general'){
					vo.caname = '일반';
				}else if(vo.caname === 'notice'){
					vo.caname = '공지';
				}else{
					vo.caname = '질문';
				}
 				tag_vos += `
 					<tr>
 						<td><a href="b_selectOne.do?bnum=\${vo.bnum}">\${vo.bnum}</a></td>
 						<td>\${vo.caname}</td>
 						<td>
 				`;
 				
 				if(vo.filepath != null){
 					tag_vos += `<i class="fa-regular fa-image">`;
 				}
 				tag_vos += `
 						<a href="b_selectOne.do?bnum=\${vo.bnum}">\${vo.title}</a></td>
						<td>\${vo.writer}</td>
						<td>\${date}</td>
						<td>\${vo.vcount}</td>
						<td>\${vo.likes}</td>
					</tr>
 				`;
 			}
			
			$("#vos").html(tag_vos); 
			curPage = page;
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
	searchList(curPage, limit);
	isSelectAll = false;
	console.log('isSelectAll:', isSelectAll);
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
			
			if(curPage > tag_page){
				curPage = tag_page;
			}
			selectAll(curPage, limit);
			
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
				if(vo.caname === 'general'){
					vo.caname = '일반';
				}else if(vo.caname === 'notice'){
					vo.caname = '공지';
				}else{
					vo.caname = '질문';
				}
				tag_vos += `
 					<tr>
 						<td><a href="b_selectOne.do?bnum=\${vo.bnum}">\${vo.bnum}</a></td>
 						<td>\${vo.caname}</td>
 						<td>
 				`;
 				
 				if(vo.filepath != null){
 					tag_vos += `<i class="fa-regular fa-image">`;
 				}
 				tag_vos += `
 						<a href="b_selectOne.do?bnum=\${vo.bnum}">\${vo.title}</a></td>
						<td>\${vo.writer}</td>
						<td>\${date}</td>
						<td>\${vo.vcount}</td>
						<td>\${vo.likes}</td>
					</tr>
 				`;
 			}
			
			$("#vos").html(tag_vos); 
			curPage = page;
		},
		error : function(xhr, status, error) {
			console.log('xhr:', xhr.status);
//			console.log('status:', status);
//			console.log('error:', error);
		}
	});//end $.ajax()
}//end searchList()


$(document).ready(function() {
    // 다른 사람의 미니홈피 방문시 다이어리 작성 버튼 숨김
    if('${user_id}' != '${mh_attr.id}'){	
        $('#diary_insert').hide();
    }
});
</script>


</head>
<body>
<jsp:include page="../../top_menu.jsp"></jsp:include>
<jsp:include page="../mini_top_menu.jsp"></jsp:include>
	<h1>mini/diary/selectAll.jsp ${user_id}</h1>
	<div
		style="background-image: url('resources/uploadimg/${mh_attr.backimg}'); background-size: cover; width: 100%; height: 100vh;">
			<h1>다이어리</h1>
		<a href="diary_insert.do?id=${mh_attr.id}" id="diary_insert" class="myButton">다이어리 작성</a>
		
		<table id="boardList">
		<thead>
			<tr>
				<th>mbnum</th>
				<th>mbname</th>
				<th>writer</th>
				<th>title</th>
				<th>wdate</th>
				<th></th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="vo" items="${vos}">
				<tr>
					<td>${vo.mbnum}</td>
					<td>${vo.mbname}</td>
					<td>${vo.writer}</td>
					<td>${vo.title}</td>
					<td>${vo.wdate}</td>
					<td><a href="diary_selectOne.do?id=${mh_attr.id}&mbnum=${vo.mbnum}">자세히 보기</a></td>
				</tr>
			</c:forEach>
		</tbody>
		<tfoot>
			<tr>
				<td colspan="6" id="page"></td>
			</tr>
		</tfoot>
		</table>
	</div>
	
</body>
</html>