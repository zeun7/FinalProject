<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="utf-8" />
  <link rel="apple-touch-icon" sizes="76x76" href="resources/assets/img/apple-icon.png">
  <link rel="icon" type="image/png" href="resources/assets/img/favicon.png">
  <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
  <title>
    방명록
  </title>
  <meta content='width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0, shrink-to-fit=no' name='viewport' />
  <!--     Fonts and icons     -->
  <link href="https://fonts.googleapis.com/css?family=Montserrat:400,700,200" rel="stylesheet" />
  <link href="https://maxcdn.bootstrapcdn.com/font-awesome/latest/css/font-awesome.min.css" rel="stylesheet">
  <!-- CSS Files -->
  <script src="https://kit.fontawesome.com/7ed6703c9d.js" crossorigin="anonymous"></script>
  <link href="resources/assets/css/bootstrap.min.css" rel="stylesheet" />
  <link href="resources/assets/css/paper-dashboard.css?v=2.0.1" rel="stylesheet" />
  <link rel="stylesheet" href="resources/css/pagination.css">
  
<link rel="stylesheet" href="resources/css/postit.css">
<link rel="stylesheet" href="resources/css/visitors_log.css">
<style>
.row-check {
    display: none;
}
</style>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
<script type="text/javascript">
let page = 1;
let curPage = 1;
let mh_attr_id = '${mh_attr.id}';

function back_img(){
	$('#back_img').css({
		"background-image" : "url('resources/AI_Backimg/cork_board.png')",
		"background-size" : "100% 100%",
		"background-repeat" : "no-repeat"
	});
}

function findAllCount(){	// 방명록 목록의 페이징 버튼 출력
	back_img();
	
	$.ajax({
		url : "json_mc_count.do",
		method : 'GET',
		data : {
			mbnum : 0,
			id : mh_attr_id
		},
		dataType : 'json', 
		success : function(result) {
			console.log(result);
			let tag_page = 0;
			let tag_pages = '';
			
			while(result > 0){
				tag_page++;
				let activeClass = (tag_page === curPage) ? 'active' : '';
				tag_pages += `
					<button class="paging-btn \${activeClass}" onclick=findAll(\${tag_page})>\${tag_page}</button>
				`;
				result -= 10;
			}
			
			if(curPage > tag_page){
				curPage = tag_page;
			}
			findAll(curPage);
			
			$("#page").html(tag_pages);
		},
		error : function(xhr, status, error) {
			console.log('xhr:', xhr.status);
		}
	});//end $.ajax()
}

function findAll(page){
    $.ajax({
        url: "json_mc_findAll2.do",
        method: "get",
        data : {
        	mbnum : 0,
			id : mh_attr_id,
			page : page
		},
        dataType: "json",
        success: function(arr) {
            let visit_log = ``;
            
        	// 모든 페이지 버튼에서 'active' 클래스를 제거합니다.
            const pageButtons = document.querySelectorAll('.paging-btn');
            pageButtons.forEach((btn) => btn.classList.remove('active'));

            // 현재 페이지 버튼에만 'active' 클래스를 추가합니다.
            pageButtons[page - 1].classList.add('active');
            
            for ( let i in arr) {
            	let vo = arr[i];
 				console.log(vo); 
 				
//  				let content = vo.content;
//  				if (content.length > 20) {
//  					  content = content.substring(0, 20) + '...';
//  				}
 				
 				visit_log += `
 					<div class="postit" style="background-color:\${vo.color}" data-mcnum="\${vo.mcnum}" onclick="if (!deleteMode) {gotoFindOne(\${vo.mcnum})};">
 					<div>
 					<span>
	 					<input type="checkbox" class="row-check" />
				        <div class="postit-content">\${vo.content}</div><br>
			        </span>
			        </div>
			        <div style="margin-top: auto;">- \${vo.writer} -</div>
			        <div>\${vo.cdate}</div>
			        </div>
			        `;
            }
            
            $("#visitors_log").html(visit_log);
			curPage = page;
        },
        error: function(request, status, error) {
            console.error('Request failed', status, error);
        }
    });//end $.ajax()
}//end findAll()

function gotoFindOne(mcnum){
	window.location.href="visit_findOne.do?id="+mh_attr_id+"&mcnum="+mcnum;
}

let deleteMode = false;

function toggleDeleteMode() {
    deleteMode = !deleteMode;

    if (deleteMode) {
        // 선택삭제 모드로 전환: 체크박스를 보이게 하고, 버튼 텍스트를 변경
        $('.row-check').css('display', 'inline');
        $('#selectDeleteButton').text('선택삭제 완료');
    } else {
        // 일반 모드로 전환: 체크된 행을 삭제하고, 체크박스를 숨기며, 버튼 텍스트를 원래대로 복구
        select_diary_deleteOK();
        $('.row-check').css('display', 'none');
        $('#selectDeleteButton').text('선택삭제');
    }
}

function select_diary_deleteOK() {
    // 체크된 행을 찾기
    const checkedRows = $('.row-check:checked').parents('.postit');

    // 체크된 행이 없다면 함수를 종료
    if (checkedRows.length === 0) {
        alert('삭제할 항목을 선택해 주세요.');
        return;
    }

	// 모든 AJAX 요청에 대한 Promise를 저장할 배열
    const promises = [];
    
 	// 체크된 행에 대한 삭제 요청을 보냅니다.
    checkedRows.each(function() {
        const row = $(this);
        const mcnum = row.data('mcnum');  // 데이터 mcnum을 가져옵니다.

	const promise = $.ajax({
            url: 'select_mc_deleteOK.do',
            method: 'POST',
            data: {
                mcnum: mcnum
            },
            success: function(response) {
            	console.log('삭제 성공:', response);
            },
            error: function(xhr, status, error) {
                // 삭제 실패: 에러 메시지를 표시합니다.
                console.error('삭제 실패:', error);
            }
        });
    });

	// 모든 요청이 완료됐을 때 알림을 표시하고 페이지를 새로고침합니다.
    $.when(...promises).done(function() {
        alert('선택된 방명록 삭제완료');
        location.href='./mini_visit.do?id=' + '${mh_attr.id}';
    });
 	
    // 체크박스 숨기기
    $('.row-check').css('display', 'none');
}

</script>
</head>

<body class="" onload="findAllCount()">
<jsp:include page="../mini_top_menu.jsp"></jsp:include>
  <div class="wrapper ">
    <div class="main-panel" style="background-image: url('resources/uploadimg/${mh_attr.backimg}'); background-size:cover; background-repeat:no-repeat;">
    <jsp:include page="../../navbar.jsp"></jsp:include>
      <div class="content" style="height: 100%; min-height: 85vh;">
        <div class="row">
          <div class="col-md-12">
            <div class="card">
              <div class="card-header" style="text-align:center; font-family: Georgia; font-size: 20px; font-weight: bold;">
                <h4 class="card-title"> 방명록</h4>
              </div>
              <div class="card-body" style="height: 800px;" id="back_img">
              	<div id="buttonContainer" style="display: flex; justify-content: space-between;">
					<button id="selectDeleteButton" onclick="toggleDeleteMode()" class="btn btn-outline-danger" style="border-radius: 10px; background-color:#ef8157; color:white;">선택삭제</button>
					<a href="visit_insert.do?id=${mh_attr.id}&writer=${nickname}" id="visit_insert" class="btn btn-outline-success" style="border-radius: 10px;">방명록 쓰기</a>
				</div>
				<hr>
                <div id="visitors_log"></div>
              </div>
              <div class="card-footer ">
                <hr>
		        <div id="page" class="text-center"></div>
              </div>
            </div>
          </div>
        </div>
      </div>
      <jsp:include page="../../footer.jsp"></jsp:include>
    </div>
  </div>

<script type="text/javascript">
	if('${user_id}' != '${mh_attr.id}'){	
	    $('#selectDeleteButton').hide();
	}
</script>
</body>
</html>