<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html>	
<head>
<style>
.row-check {
    display: none;
}
</style>
<title>방명록</title>
<jsp:include page="../../css.jsp"></jsp:include>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
<script type="text/javascript">
let page = 1;
let curPage = 1;
let mh_attr_id = '${mh_attr.id}';

function findAllCount(){	// 방명록 목록의 페이징 버튼 출력
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
				tag_pages += `
					<button onclick=findAll(\${tag_page})>\${tag_page}</button>
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
            for ( let i in arr) {
            	let vo = arr[i];
 				console.log(vo); 
 				visit_log += `
 					<span data-mcnum="\${vo.mcnum}">
	 					<input type="checkbox" class="row-check" />
	                	<a href="visit_findOne.do?id=\${mh_attr_id}&mcnum=\${vo.mcnum}" style="border:3px solid white;"class="myButton" >
				        <h3>\${vo.writer}</h3>
				        <p>\${vo.content}</p>
				        <span>\${vo.cdate}</span></a>
			        </span>
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
        const mcnum = row.data('mcnum');  // 데이터 mcnum을 가져옵니다.

        $.ajax({
            url: 'select_mc_deleteOK.do',
            method: 'POST',
            data: {
                mcnum: mcnum
            },
            success: function(response) {
                location.href='./mini_visit.do?id=' + '${mh_attr.id}';
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
<body onload="findAllCount()">
    <jsp:include page="../../top_menu.jsp"></jsp:include>
    <jsp:include page="../mini_top_menu.jsp"></jsp:include>
    <h1>mini/visit/findAll.jsp</h1>
    <div style="background-image: url('resources/uploadimg/${mh_attr.backimg}'); background-size: cover; width: 100%; height: 100vh;">
        <h1>방명록</h1>
        <div id="buttonContainer">
			<a href="visit_insert.do?id=${mh_attr.id}&writer=${nickname}" id="visit_insert" class="myButton">방명록 쓰기</a>
			<button id="selectDeleteButton" onclick="toggleDeleteMode()" class="myButton">선택삭제</button>
		</div>
        
        <div id="visitors_log"></div>
        <div id="page"></div>
    </div>
</body>
</html>
<script type="text/javascript">
	if('${user_id}' != '${mh_attr.id}'){	
	    $('#selectDeleteButton').hide();
	}
</script>