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
    사진첩
  </title>
  <meta content='width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0, shrink-to-fit=no' name='viewport' />
  <!--     Fonts and icons     -->
  <link href="https://fonts.googleapis.com/css?family=Montserrat:400,700,200" rel="stylesheet" />
  <link href="https://maxcdn.bootstrapcdn.com/font-awesome/latest/css/font-awesome.min.css" rel="stylesheet">
  <!-- CSS Files -->
  <link href="resources/assets/css/bootstrap.min.css" rel="stylesheet" />
  <link href="resources/assets/css/paper-dashboard.css?v=2.0.1" rel="stylesheet" />
  <link rel="stylesheet" href="resources/css/pagination.css">

<style>
.row-check {
    display: none;
}
</style>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
<script type="text/javascript">
function gallery_insertOK() {
    let fileInput = document.getElementById('file');
    let file = fileInput.files[0];
    let title = document.getElementById('title').value;
    let formData = new FormData();
    
    if(title === ''){
        alert('제목을 입력해주세요.');
        return;
    }
    
    if(!file){
        alert('파일을 업로드해주세요.');
        return;
    }
    
    formData.append('mbname', 'gallery');
    formData.append('writer', '${m_attr.nickname}'); 
    formData.append('title', title);
    for(let i = 0; i < fileInput.files.length; i++){
		formData.append('file', fileInput.files[i]);
	}

    $.ajax({
        url: 'gallery_insertOK.do', 
        type: 'POST',
        data: formData,
        processData: false,  
        contentType: false,  
        success: function(response) {
            // 서버에서 응답을 받았을 때의 처리
            console.log(response);
            
            alert('사진올리기 완료');
            location.href='./mini_gallery.do?id=' + '${mh_attr.id}';
        },
        error: function(xhr, status, error) {
            console.log(error);
        }
    });
}

let page = 1;
let curPage = 1;
let mh_attr_id = '${mh_attr.id}';

function selectAllCount(){	// gallery 목록의 페이징 버튼 출력
	$.ajax({
		url : "json_mb_count.do",
		method : 'GET',
		data : {
			mbname : 'gallery',
			writer : '${m_attr.nickname}'
		},
		dataType : 'json', 
		success : function(result) {
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
		error : function(xhr, status, error) {
			console.log('xhr:', xhr.status);
		}
	});//end $.ajax()
}

function setActive(button) {
    // 모든 버튼에서 'active' 클래스 제거
    document.querySelectorAll('.paging-btn').forEach(btn => btn.classList.remove('active'));
    // 클릭한 버튼에 'active' 클래스 추가
    button.classList.add('active');
}

function selectAll(page){
	$.ajax({
		url : "json_mb_selectAll.do",
		method : 'GET',
		data : {
			mbname : 'gallery',
			writer : '${m_attr.nickname}',
			page : page
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
 				console.log(vo);
 				let filepath = vo.filepath;
				if(filepath != null){
	 				tag_vos += `
	 					<span data-mbnum="\${vo.mbnum}">
		 					<input type="checkbox" class="row-check" />
		 		        	 <a href="gallery_selectOne.do?id=\${mh_attr_id}&mbnum=\${vo.mbnum}">`;
		 		    
		 		    if(filepath.indexOf(',') > 0){
		 		    	tag_vos += `<img src="resources/uploadimg/thumb_\${vo.filepath.substring(0,vo.filepath.indexOf(','))}">`;
		 		    }else{
		 		    	tag_vos += `<img src="resources/uploadimg/thumb_\${vo.filepath}">`;
		 		    }
		 		        	 
		 			tag_vos += `
		 				    </a>
	 		        	</span>
	 				`;
	 		    }
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
        select_gallery_deleteOK();
        $('.row-check').css('display', 'none');
        $('#selectDeleteButton').text('선택삭제');
    }
}

function select_gallery_deleteOK() {
    // 체크된 행을 찾기
    const checkedRows = $('.row-check:checked').parents('span');

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
                location.href='./mini_gallery.do?id=' + '${mh_attr.id}';
            },
            error: function(xhr, status, error) {
                // 삭제 실패: 에러 메시지를 표시합니다.
                console.error('삭제 실패:', error);
            }
        });
    });
 	
 	// 모든 요청이 완료됐을 때 알림을 표시합니다.
    $.when(...promises).done(function() {
        alert('선택된 사진 삭제완료');
    });

    // 체크박스 숨기기
    $('.row-check').css('display', 'none');
}

</script>
</head>

<body class="" onload="selectAllCount()">
<jsp:include page="../mini_top_menu.jsp"></jsp:include>
    <div class="main-panel" style="background-image: url('resources/uploadimg/${mh_attr.backimg}'); background-size:cover; background-repeat:no-repeat;">
    <jsp:include page="../mini_navbar.jsp"></jsp:include>
      <div class="content" style="height: 90vh;">
        <div class="row">
          <div class="col-md-8">
            <div class="card">
              <div class="card-header">
              	<div style="text-align:center; font-family: Georgia; font-size: 20px; font-weight: bold;">
             		<h4 class="card-title"> 사진첩</h4>
              	</div>
                <div style="text-align:right;">
	                <button id="selectDeleteButton" onclick="toggleDeleteMode()" class="btn btn-outline-danger" style="border-radius: 10px; font-weight: bold; font-size: 12px">선택삭제</button>
                </div>
              </div>
              <div class="card-body">
                 <table class="table">
                   <tbody>
                   	<tr>
                   		<td><div id="vos"></div></td>
                   	</tr>
                   </tbody>
                   <tr>
                   	<td id="page" class="text-center"></td>
                   </tr>
                 </table>
              </div><!-- end card-body -->
            </div><!-- end card -->
            <div class="col-md-4" id="buttonContainer">
            <div class="card">
              <div class="card-body">
            	<div class="form-group">
					<label>title</label>
			        <input type="text" id="title" class="form-control" name="title" placeholder="제목을 입력하세요.">
				</div>
             	<div>
					<label>file</label>
			        <input type="file" id="file" class="form-control" name="file" multiple="multiple">
				</div>
		        <button id="uploadButton" onclick="gallery_insertOK()" class="btn btn-primary" style="border-radius: 10px;">사진올리기</button>
              </div><!-- end card-body -->
            </div><!-- end card -->
          </div><!-- end buttonContainer -->
          </div><!-- end col-md-8 -->
        </div><!-- end row -->
      </div><!-- end content -->
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

<script type="text/javascript">
	//다른 사람의 미니홈피 방문시 다이어리 작성 버튼 숨김
	if('${user_id}' != '${mh_attr.id}'){	
	    $('#buttonContainer').hide();
	    $('#selectDeleteButton').hide();
	}
</script>
</body>

</html>