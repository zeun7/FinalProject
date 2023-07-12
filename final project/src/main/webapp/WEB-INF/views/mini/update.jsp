<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<html>
<head>
<title>미니홈피 수정</title>
<link rel="stylesheet" href="resources/css/modal.css">
<jsp:include page="../css.jsp"></jsp:include>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
<script type="text/javascript">
let page = 1;
let curPage = 1; 
function selectAllCount(){ // 음악 목록의 페이징 버튼 출력
	$.ajax({
		url : "json_j_count.do",
		method : 'GET',
		data : {
			id : '${user_id}'
		},
		dataType : 'json',
		success : function(result){
			let tag_page = 0;
			let tag_pages = '';
			
			while(result > 0){
				tag_page++;
				tag_pages += `
					<button onclick=selectAll(\${tag_page})>\${tag_page}</button>
				`;
				result -= 10;
			}
			
			if(curPage > tag_page){
				curPage = tag_page;
			}
			selectAll(curPage);
			
			$("#page").html(tag_pages);
		},
		error : function(xhr, status, error){
			console.log('xhr:',xhr.status);
		}
	});//end $.ajax()
}//end selectAllCount()

function selectAll(page){
	$.ajax({
		url : "json_j_selectAll.do",
		method : 'get',
		data : {
			id : '${user_id}',
			page : page
		},
		dataType : 'json',
		success : function(arr){
			let tag_vos = '';
			for(let i in arr){
				let vo = arr[i];
				console.log(vo);
				tag_vos +=`
					<tr>
					<td>\${vo.bgm}</td>
					<td><button type="button" id="btn_\${i}" onclick="showMusicPlayer('btn_\${i}', '\${vo.bgm}')">\${vo.bgm}</button></td>
					<td><button type="button" onclick="setBGM('\${vo.bgm}')">설정하기</button></td>
		        	</tr>	
				`;
			}
			$("#vos").html(tag_vos);
			curPage = page;
		},
		error : function(xhr, status, error){
			console.log('xhr', xhr.status);
		}
	});//end $.ajax()
}//end selectAll()

function setBGM(bgm){
	let tag_mp = `
		<audio controls>
	      <source src="resources/uploadbgm/\${bgm}" type="audio/mp3">
		</audio>
	`;
	
	$('#bgm').val(bgm);
	$('#bgm_title').html(bgm);
	$('#music_player').html(tag_mp);
	
	alert('설정 완료');
}
</script>
</head>
<body onload="selectAllCount()">
<jsp:include page="../top_menu.jsp"></jsp:include>
<jsp:include page="mini_top_menu.jsp"></jsp:include>
	<h1>mini/update.jsp</h1>
	<form action="mini_updateOK.do" method="post" enctype="multipart/form-data">
		<table id="memberList">
			<tr>
				<td><label for="hnum">hnum:</label></td>
				<td>
					<span id="span_hnum">${vo2.hnum}</span>
					<input type="hidden" id="hnum" name="hnum" value="${vo2.hnum}">
				</td>
			</tr>
			<tr>
				<td><label for="id">id:</label></td>
				<td>
					<span id="span_id">${user_id}</span>
					<input type="hidden" id="id" name="id" value="${user_id}">
				</td>
			</tr>
			<tr>
				<td><label for="title">title:</label></td>
				<td><input type="text" id="title" name="title" value="${vo2.title}"></td>
			</tr>
			<tr>
				<td><label for="message">message:</label></td>
				<td><input type="text" id="message" name="message"
					value="${vo2.message}"></td>
			</tr>
			<tr>
				<td><label for="backimg">backimg:</label></td>
				<td>
					<img src="resources/uploadimg/thumb_${vo2.backimg}">
					<input type="file" id="file" name="file">
					<input type="hidden" id="backimg" name="backimg" value="${vo2.backimg}">
				</td>
			</tr>
			<tr>
				<td><label for="bgm">bgm:</label></td>
				<td>
					<div id="bgm_title">${vo2.bgm}</div>
					<div id="music_player">
						<audio controls>
					      <source src="resources/uploadbgm/${vo2.bgm}" type="audio/mp3">
	   					</audio>
					</div>
<!-- 					<input type="file" id="musicFile" name="musicFile">  -->
					<button type="button" onclick="open_modal()">bgm 선택</button>
					<input type="hidden" id="bgm" name="bgm" value="${vo2.bgm}">
				</td>
			</tr>
			
			<tr>
				<td colspan="2">
					<input type="submit" value="미니홈피 수정완료">
				</td>
			</tr>
		</table>
	</form>
	
	<div id="modal">
		<div class="modal-content">
			<h1>쥬크박스</h1>
	        <table>
	        	<thead>
		        	<tr>
		        		<th>보유 음악</th>
		        		<th>미리듣기</th>
		        	</tr>
	        	</thead>
	        	<tbody id="vos">
	        		
	        	</tbody>
	        	<tfoot>
	        		<tr>
	        			<td colspan="2" id="page"></td>
	        		</tr>
	        	</tfoot>
	        </table>
			<div>
				<button onclick="close_modal()">닫기</button>
			</div>
		</div>
	</div>
	
	<script type="text/javascript">
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