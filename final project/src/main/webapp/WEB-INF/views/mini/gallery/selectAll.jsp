<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html>
<head>
<style>
.row-check {
    display: none;
}
</style>
<title>사진첩_selectAll</title>
<jsp:include page="../../css.jsp"></jsp:include>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
<script type="text/javascript">
$(document).ready(function () {
    $("#uploadButton").on("click", function(e) {
        e.preventDefault();

        var fileInput = document.getElementById('file');
        var file = fileInput.files[0];
        var title = document.getElementById('title').value;
        var formData = new FormData();
		
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
                
//                 // 0.05초 지연 후 페이지 새로고침
//                 setTimeout(function() {
//                     location.reload();
//                 }, 50);

                alert('사진올리기 완료');
                location.href='./mini_gallery.do?id=' + '${mh_attr.id}';
            },
            error: function(xhr, status, error) {
                console.log(error);
            }
        });
    });
    
    // 다른 사람의 미니홈피 방문시 다이어리 작성 버튼 숨김
    if('${user_id}' != '${mh_attr.id}'){	
        $('#buttonContainer').hide();
    }
    
    
});

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
    formData.append('file', file);

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

function selectAllCount(){	// diary 목록의 페이징 버튼 출력
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
			mbname : 'gallery',
			writer : '${m_attr.nickname}',
			page : page
		},
		dataType : 'json', 
		success : function(arr) {
			let tag_vos = '';
			for ( let i in arr) {
 				let vo = arr[i];
 				console.log(vo); 
 				tag_vos += `
 					<span data-mbnum="\${vo.mbnum}">
	 					<input type="checkbox" class="row-check" />
	 		        	 <a href="gallery_selectOne.do?id=\${mh_attr_id}&mbnum=\${vo.mbnum}">
	 			  			<img src="resources/uploadimg/thumb_\${vo.filepath}">
	 				    </a>
 		        	</span>
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
        alert('선택된 사진 완료');
    });

    // 체크박스 숨기기
    $('.row-check').css('display', 'none');
}


</script>

</head>
<body onload="selectAllCount()">
    <jsp:include page="../../top_menu.jsp"></jsp:include>
    <jsp:include page="../mini_top_menu.jsp"></jsp:include>
    <h1>mini/gallery/selectAll.jsp</h1>
    <div style="background-image: url('resources/uploadimg/${mh_attr.backimg}'); background-size: cover; width: 100%; height: 100vh;">
        <h1>사진첩</h1>
        
        <div id="vos"></div>
        <div id="page"></div>
        <div id="buttonContainer">
        <h2>이미지추가</h2><br>
	        <input type="file" id="file" name="file"><br>
	        제목 :<input type="text" id="title" name="title">
	        <button id="uploadButton" onclick="gallery_insertOK()" class="myButton">사진올리기</button>
	        <button id="selectDeleteButton" onclick="toggleDeleteMode()" class="myButton">선택삭제</button>
        </div>
    </div>
</body>
</html>

<script type="text/javascript">
	//다른 사람의 미니홈피 방문시 다이어리 작성 버튼 숨김
	if('${user_id}' != '${mh_attr.id}'){	
	    $('#buttonContainer').hide();
	}
</script>