<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://kit.fontawesome.com/7ed6703c9d.js" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.4/moment.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.4/moment-with-locales.min.js"></script>
<title>Insert title here</title>
<link rel="stylesheet" href="resources/css/button.css">
<link rel="stylesheet" href="resources/css/input.css">
<link rel="stylesheet" href="resources/css/pagination.css">
<link rel="stylesheet" href="resources/css/board_table.css">
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
			let tag_pages = `<div class="paging-btn-container">`;
			
			while(result > 0){
				tag_page++;
				let activeClass = (tag_page === curPage) ? 'active' : '';
				tag_pages += `
					<button class="paging-btn \${activeClass}" onclick=selectAll(\${tag_page},\${limit})>\${tag_page}</button>
				`;
				
				result -= limit;
			}
			tag_pages += `</div>`;
			
			if(curPage > tag_page){
				curPage = tag_page;
			}
			selectAll(curPage, limit);
			
			$("#page").html(tag_pages);
		},
		error : function(xhr, status, error) {
			console.log('xhr:', xhr.status);
		}
	});//end $.ajax()
}//end selectAllCount()

function setActive(button) {
    // 모든 버튼에서 'active' 클래스 제거
    document.querySelectorAll('.paging-btn').forEach(btn => btn.classList.remove('active'));
    // 클릭한 버튼에 'active' 클래스 추가
    button.classList.add('active');
}

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
			let tag_vos = '';
			
			// 모든 페이지 버튼에서 'active' 클래스를 제거합니다.
            const pageButtons = document.querySelectorAll('.paging-btn');
            pageButtons.forEach((btn) => btn.classList.remove('active'));

            // 현재 페이지 버튼에만 'active' 클래스를 추가합니다.
            pageButtons[page - 1].classList.add('active');
            
			for ( let i in arr) {
 				let vo = arr[i];
 				let date = '';
 				
 				if(moment().format('YYYY-MM-DD') === moment(vo.wdate).format('YYYY-MM-DD')){	// 오늘 작성한 게시글
 					date = moment(vo.wdate).format('HH:mm');
 				} else{											// 오늘 이전에 작성한 게시글
 					date = moment(vo.wdate).format('MM-DD');
 				}
 				
 				if(vo.caname === 'general'){
					vo.caname = '일반';
				}else if(vo.caname === 'notice'){
					vo.caname = '공지';
				}else{
					vo.caname = '질문';
				}
 				tag_vos += `
 					<tr data-bnum="\${vo.bnum}">
 						<td><a>\${vo.bnum}</a></td>
 						<td>[\${vo.caname}]`;
 				
 				if(vo.isFileExist == 1){
 					tag_vos += `<i class="fa-regular fa-image"></i>`;
 				}
 				tag_vos += `
 						<a href="b_selectOne.do?bnum=\${vo.bnum}">\${vo.title}</a></td>
						<td>\${vo.writer}</td>
						<td>\${vo.vcount}</td>
						<td>\${vo.likes}</td>
						<td>\${date}</td>
					</tr>
 				`;
 			}
			
			$("#vos").html(tag_vos); 
			curPage = page;
		},
		error : function(xhr, status, error) {
			console.log('xhr:', xhr.status);
		}
	});//end $.ajax()
}//end selectAll()

$(document).ready(function(){
	$("body").on("click", "tr[data-bnum]", function(){
	        window.location = $(this).find("a[href]").attr("href");
	        return false; // 이벤트 전파를 중지합니다.
	});
});

function searchListCount(){
// 	console.log('searchListCount()');
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
			searchList(curPage, limit);
			
			$("#page").html(tag_pages);
		},
		error : function(xhr, status, error) {
			console.log('xhr:', xhr.status);
		}
	});//end $.ajax()
}//end searchListCount()

function searchList(page, limit){
 	console.log('searchList()');
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
			let tag_vos = '';
			for ( let i in arr) {
 				let vo = arr[i];
				let date = '';
 				
 				if(moment().format('YYYY-MM-DD') === moment(vo.wdate).format('YYYY-MM-DD')){	// 오늘 작성한 게시글
 					date = moment(vo.wdate).format('HH:mm');
 				} else{											// 오늘 이전에 작성한 게시글
 					date = moment(vo.wdate).format('MM-DD');
 				}

 				if(vo.caname === 'general'){
					vo.caname = '일반';
				}else if(vo.caname === 'notice'){
					vo.caname = '공지';
				}else{
					vo.caname = '질문';
				}
				tag_vos += `
 					<tr>
 						<td><a>\${vo.bnum}</a></td>
 						<td>[\${vo.caname}]`;
 				
 				if(vo.isFileExist == 1){
 					tag_vos += `<i class="fa-regular fa-image">`;
 				}
 				tag_vos += `
 						<a href="b_selectOne.do?bnum=\${vo.bnum}">\${vo.title}</a></td>
 						<td>\${vo.writer}</td>
						<td>\${vo.vcount}</td>
						<td>\${vo.likes}</td>
						<td>\${date}</td>
					</tr>
 				`;
 			}
			
			$("#vos").html(tag_vos); 
			curPage = page;
		},
		error : function(xhr, status, error) {
			console.log('xhr:', xhr.status);
		}
	});//end $.ajax()
}//end searchList()

function changeLimit(){
	limit = $("#limit").val();
// 	console.log(limit);
	if(isSelectAll){
		selectAllCount();
	}else{
		searchListCount();
	}
}

</script>
</head>
<body onload="selectAllCount()">
<jsp:include page="../sidebar.jsp"></jsp:include>
<jsp:include page="../navbar.jsp"></jsp:include>
<div class="main-panel">
	<div class="content">
		<div class="row">
			<div class="col-md-12">
				<div class="card">
					<div class="card-header">
						<h1 class="card-title" style="text-align:center;">${param.bname}</h1>
					</div>
					<div class="card-body">
						<div style="display: flex; justify-content: space-between;">
							<select name="limit" id="limit" onchange="changeLimit()">
								<option value="10">10</option>
								<option value="15">15</option>
								<option value="20">20</option>
							</select>
							<a class="custom-btn btn-4" id="writeBoard" href="b_insert.do?bname=${param.bname}">
								<span style="display: inline-flex; justify-content: center; align-items: center;">글쓰기</span>
							</a>
						</div>
						<table class="table">
							<thead class="text-primary">
								<tr>
									<th>번호</th>
									<th>제목</th>
									<th>글쓴이</th>
									<th>조회수</th>
									<th>추천수</th>
									<th>작성일</th>
								</tr>
							</thead>
							<tbody id="vos">
							</tbody>
							<tfoot style="margin:auto">
								<tr>
									<td colspan="7" style="margin:auto;" id="page"></td>
								</tr>
							</tfoot>	
						</table>
					</div>
					<div class="card-footer" style="margin:auto; display:flex;">
						<select name="searchKey" id="searchKey">
							<option value="title">제목</option>
							<option value="content">내용</option>
							<option value="writer">닉네임</option>
						</select>
						<input type="text" name="searchWord" id="searchWord" value="${param.searchWrod}" class="inputS-1">
						<button onclick="searchListCount()" class="custom-btn btn-4">검색</button>
					</div>
				</div> <!-- end "card" -->
			</div> <!-- end "col-md-12" -->
		</div> <!-- end "row" -->
	</div> <!-- end "content" -->
</div> <!-- end "main-panel" -->
</body>
<script type="text/javascript">
if ('${user_id}' === '') { // 로그아웃 상태
	$('#writeBoard').hide();
}
</script>
</html>