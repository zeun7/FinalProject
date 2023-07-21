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
<title>미니홈피 수정</title>
<meta content='width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0, shrink-to-fit=no' name='viewport' />
<!--     Fonts and icons     -->
<link href="https://fonts.googleapis.com/css?family=Montserrat:400,700,200" rel="stylesheet" />
<link href="https://maxcdn.bootstrapcdn.com/font-awesome/latest/css/font-awesome.min.css" rel="stylesheet">
<!-- CSS Files -->
<link href="resources/assets/css/bootstrap.min.css" rel="stylesheet" />
<link href="resources/assets/css/paper-dashboard.css?v=2.0.1" rel="stylesheet" />
<link rel="stylesheet" href="resources/css/pagination.css">
<link rel="stylesheet" href="resources/css/button2.css">
<style type="text/css">
.pr-1 {
	margin: auto;
}
</style>
<link rel="stylesheet" href="resources/css/modal.css">
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
				let activeClass = (tag_page === curPage) ? 'active' : '';
				tag_pages += `
					<button class="paging-btn \${activeClass}" onclick=selectAll(\${tag_page})>\${tag_page}</button>
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

function setActive(button) {
    // 모든 버튼에서 'active' 클래스 제거
    document.querySelectorAll('.paging-btn').forEach(btn => btn.classList.remove('active'));
    // 클릭한 버튼에 'active' 클래스 추가
    button.classList.add('active');
}

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
			
			// 모든 페이지 버튼에서 'active' 클래스를 제거합니다.
            const pageButtons = document.querySelectorAll('.paging-btn');
            pageButtons.forEach((btn) => btn.classList.remove('active'));

            // 현재 페이지 버튼에만 'active' 클래스를 추가합니다.
            pageButtons[page - 1].classList.add('active');
			
			for(let i in arr){
				let vo = arr[i];
				console.log(vo);
				tag_vos +=`
					<tr>
					<td style="text-align:center;">\${vo.bgm}
					<span id="btn_\${i}"><btn class="btn btn-sm btn-round btn-icon" onclick="showMusicPlayer('btn_\${i}', '\${vo.bgm}')">
					<i class="nc-icon nc-headphones"></i></btn></span></td>
					<td><button class="btn-gradient cyan mini" type="button" onclick="setBGM('\${vo.bgm}')">설정하기</button></td>
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

function showMusicPlayer(btn_id ,bgm){
    console.log(bgm);
    let audio=`
        <audio controls autoplay>
            <source src="resources/uploadbgm/\${bgm}" type="audio/mp3">
        </audio>
    `;
    $("#"+btn_id).html(audio);
}

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

<body class="" onload="selectAllCount()">
	<jsp:include page="./mini_top_menu.jsp"></jsp:include>
	<div class="wrapper ">
		<div class="main-panel"
			style="background-image: url('resources/uploadimg/${mh_attr.backimg}'); background-size:cover; background-repeat:no-repeat;">
			<jsp:include page="./mini_navbar.jsp"></jsp:include>
			<div class="content" style="height: 100%;">
				<div class="row">
					<div class="col-md-12">
						<div class="card card-user">
							<div class="card-header text-center">
								<h5 class="card-title">미니홈피 수정</h5>
							</div>
							<div class="card-body">
								<form action="mini_updateOK.do" method="post"
									enctype="multipart/form-data">
									<input type="hidden" id="hnum" name="hnum" value="${vo2.hnum}">
									<div class="row">
										<div class="col-md-6 pr-1">
											<div class="form-group">
												<label for="id">id</label> <input type="text"
													class="form-control" id="id" name="id" value="${user_id}"
													readonly="readonly">
											</div>
										</div>
									</div>
									<div class="row">
										<div class="col-md-6 pr-1">
											<div class="form-group">
												<label for="title">title</label> <input type="text"
													class="form-control" id="title" name="title"
													value="${vo2.title}">
											</div>
										</div>
									</div>
									<div class="row">
										<div class="col-md-6 pr-1">
											<div class="form-group">
												<label for="message">message</label> <input type="text"
													class="form-control" id="message" name="message"
													value="${vo2.message}">
											</div>
										</div>
									</div>
									<div class="row">
										<div class="col-md-6 pr-1">
											<div class="form-group">
												<label for="backimg">backimg</label><br> <img
													src="resources/uploadimg/thumb_${vo2.backimg}"> <input
													type="hidden" id="backimg" name="backimg"
													value="${vo2.backimg}">
											</div>
											<input type="file" id="file" name="file" class="form-control">
										</div>
									</div>
									<br>
									<div class="row">
										<div class="col-md-6 pr-1">
											<div class="form-group">
												<label for="bgm">bgm</label>
												<div id="bgm_title">${vo2.bgm}</div>
												<div style="display: flex;">
													<div id="music_player">
														<audio controls>
															<source src="resources/uploadbgm/${vo2.bgm}"
																type="audio/mp3">
														</audio>
													</div>
													<!-- 					<input type="file" id="musicFile" name="musicFile">  -->
														<button type="button" onclick="open_modal()" class="btn">bgm 선택</button>
												</div>
												<input type="hidden" id="bgm" name="bgm" value="${vo2.bgm}">
											</div>
										</div>
									</div>
									<div class="row">
										<div class="update ml-auto mr-auto">
											<input type="submit" class="btn btn-primary btn-round"
												value="미니홈피 수정완료">
										</div>
									</div>
								</form>
							</div>
						</div>
					</div>
				</div>

				<div id="modal">
					<div class="juke-modal-content">
						<h1>쥬크박스</h1>
						<table>
							<thead>
								<tr>
									<th>보유 음악</th>
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
			</div>
			<jsp:include page="../footer.jsp"></jsp:include>
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