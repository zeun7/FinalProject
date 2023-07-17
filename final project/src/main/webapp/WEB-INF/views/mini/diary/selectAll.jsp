<!--
=========================================================
* Paper Dashboard 2 - v2.0.1
=========================================================

* Product Page: https://www.creative-tim.com/product/paper-dashboard-2
* Copyright 2020 Creative Tim (https://www.creative-tim.com)

Coded by www.creative-tim.com

 =========================================================

* The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
-->
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
    다이어리
  </title>
  <meta content='width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0, shrink-to-fit=no' name='viewport' />
  <!--     Fonts and icons     -->
  <link href="https://fonts.googleapis.com/css?family=Montserrat:400,700,200" rel="stylesheet" />
  <link href="https://maxcdn.bootstrapcdn.com/font-awesome/latest/css/font-awesome.min.css" rel="stylesheet">
  <!-- CSS Files -->
  <link href="resources/assets/css/bootstrap.min.css" rel="stylesheet" />
  <link href="resources/assets/css/paper-dashboard.css?v=2.0.1" rel="stylesheet" />
<style>
.row-check {
    display: none;
}
</style>
<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.4/moment-with-locales.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
<script type="text/javascript">
let page = 1;
let curPage = 1;
let mh_attr_id = '${mh_attr.id}';

function selectAllCount(){	// diary 목록의 페이징 버튼 출력
	$.ajax({
		url : "json_mb_count.do",
		method : 'GET',
		data : {
			mbname : 'diary',
			writer : '${m_attr.nickname}'
		},
		dataType : 'json', 
		success : function(result) {
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
		error : function(xhr, status, error) {
			console.log('xhr:', xhr.status);
		}
	});//end $.ajax()
}

function selectAll(page){
	$.ajax({
		url : "json_mb_selectAll.do",
		method : 'GET',
		data : {
			mbname : 'diary',
			writer : '${m_attr.nickname}',
			page : page
		},
		dataType : 'json', 
		success : function(arr) {
			let tag_vos = '';
			for ( let i in arr) {
 				let vo = arr[i];
 				let date = moment(vo.wdate).format('YY년 MM월 DD일 HH시mm분');
 				console.log(vo); 
 				tag_vos += `
 					<tr data-mbnum="\${vo.mbnum}">
	 			        <td><input type="checkbox" class="row-check" /></td>
	 			        <td>\${vo.title}</td>
	 			        <td>\${vo.writer}</td>
	 			        <td>\${date}</td>
	 			        <td><a href="diary_selectOne.do?id=\${mh_attr_id}&mbnum=\${vo.mbnum}">자세히 보기</a></td>
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
    const checkedRows = $('.row-check:checked').parents('tr');

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
        const mbnum = row.data('mbnum');  // 데이터 mbnum을 가져옵니다.

        $.ajax({
            url: 'select_mb_deleteOK.do',
            method: 'POST',
            data: {
                mbnum: mbnum
            },
            success: function(response) {
                location.href='./mini_diary.do?id=' + '${mh_attr.id}';
            },
            error: function(xhr, status, error) {
                // 삭제 실패: 에러 메시지를 표시합니다.
                console.error('삭제 실패:', error);
            }
        });
    });

 	// 모든 요청이 완료됐을 때 알림을 표시합니다.
    $.when(...promises).done(function() {
        alert('선택된 사진 완료');
    });
 	
    // 체크박스 숨기기
    $('.row-check').css('display', 'none');
}

</script>
</head>

<body class="" onload="selectAllCount()">
<jsp:include page="../mini_top_menu.jsp"></jsp:include>
  <div class="wrapper ">
    <div class="main-panel" style="background-image: url('resources/uploadimg/${mh_attr.backimg}')">
    <jsp:include page="../mini_navbar.jsp"></jsp:include>
      <div class="content" style="background-size: cover; width: 100%; height: 100vh;">
        <div class="row">
          <div class="col-md-12">
            <div class="card">
              <div class="card-header">
                <h4 class="card-title"> 다이어리</h4>
              </div>
              <div class="card-header" id="buttonContainer">
				<a href="diary_insert.do?id=${mh_attr.id}" id="diary_insert" class="myButton">다이어리 작성</a>
				<button id="selectDeleteButton" onclick="toggleDeleteMode()" class="myButton">선택삭제</button>
              </div>
              <div class="card-body">
                <div class="">
                  <table class="table">
                    <thead class=" text-primary">
                      <th>
                        선택
                      </th>
                      <th>
                        제목
                      </th>
                      <th>
                        글쓴이
                      </th>
                      <th>
                        작성일
                      </th>
                      <th class="text-right">
                      </th>
                    </thead>
                    <tbody id="vos">
                    </tbody>
					<tr>
						<td colspan="4" id="page"></td>
					</tr>
                  </table>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
      <footer class="footer footer-black  footer-white ">
        <div class="container-fluid">
          <div class="row">
            <nav class="footer-nav">
              <ul>
                <li><a href="https://www.creative-tim.com" target="_blank">Creative Tim</a></li>
                <li><a href="https://www.creative-tim.com/blog" target="_blank">Blog</a></li>
                <li><a href="https://www.creative-tim.com/license" target="_blank">Licenses</a></li>
              </ul>
            </nav>
            <div class="credits ml-auto">
              <span class="copyright">
                © <script>
                  document.write(new Date().getFullYear())
                </script>, made with <i class="fa fa-heart heart"></i> by Creative Tim
              </span>
            </div>
          </div>
        </div>
      </footer>
    </div>
  </div>
  <!--   Core JS Files   -->
  <script src="resources/assets/js/core/jquery.min.js"></script>
  <script src="resources/assets/js/core/popper.min.js"></script>
  <script src="resources/assets/js/core/bootstrap.min.js"></script>
  <script src="resources/assets/js/plugins/perfect-scrollbar.jquery.min.js"></script>
  <!-- Control Center for Now Ui Dashboard: parallax effects, scripts for the example pages etc -->
  <script src="resources/assets/js/paper-dashboard.min.js?v=2.0.1" type="text/javascript"></script><!-- Paper Dashboard DEMO methods, don't include it in your project! -->
	  
</body>

<script type="text/javascript">
	//다른 사람의 미니홈피 방문시 다이어리 작성 버튼 숨김
	if('${user_id}' != '${mh_attr.id}'){	
	    $('#buttonContainer').hide();
	}
</script>
</html>