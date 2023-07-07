<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
<head>
<title>사진첩_selectOne</title>
<link rel="stylesheet" href="resources/css/modal.css">
<jsp:include page="../../css.jsp"></jsp:include>
<script src="https://t1.kakaocdn.net/kakao_js_sdk/2.2.0/kakao.min.js" integrity="sha384-x+WG2i7pOR+oWb6O5GV5f1KN2Ko6N7PTGPS7UlasYWNxZMKQA63Cj/B2lbUmUfuC" crossorigin="anonymous"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
<script type="text/javascript">
let url = 'https://861c-218-146-69-112.ngrok-free.app/finalproject/gallery_selectOne.do?id=${param.id}&mbnum=${param.mbnum}';

$(document).on('click', '#editButton', function(e) {
    e.preventDefault();
    
    const originalTitle = "${vo2.title}"; // Original title from server
    
    // Replace the title div with an input field
    $('#title').replaceWith('<input id="title" type="text" value="' + originalTitle + '">');
    
    // Replace the image with a file input field
    $('#file').replaceWith('<input type="file" id="file" name="file" multiple="multiple"> ' + 
    		'<input type="hidden" id="filepath" name="filepath" value="${vo2.filepath}">');
    
    // Change edit button to a save button
    $('#editButton').text('저장').attr('id', 'saveButton');
    
});

$(document).on('click', '#saveButton', function(e) {
    if (confirm("정말 수정하시겠습니까?") == true) {
		
        //데이터를 담아내는 부분
        const id = $("#id").val();
        const title = $("#title").val().trim();
        const file = $("#file")[0].files;
        const filepath = $("#filepath").val();
//         if(title === ''){
//             alert('제목을 입력해주세요.');
//             return;
//         }
        
//         if(!file){
//             alert('파일을 업로드해주세요.');
//             return;
//         }

        var formData = new FormData();
        formData.append("mbnum", ${vo2.mbnum})
        formData.append("title", title);
//         formData.append("file", file);
        if(file) {
        	for(let i = 0; i < file.length; i++){
    			formData.append('file', file[i]);
    		}
        }
        formData.append("filepath", filepath);  // Always append filepath
        //ajax로 파일전송 폼데이터를 보내기위해
        //enctype, processData, contentType 이 세가지를 반드시 세팅해야한다.
        $.ajax({
            enctype: 'multipart/form-data',
            processData: false,
            contentType: false,
            cache: false,
            url : "./gallery_updateOK.do",
            data : formData,
            type : "POST",
            success : function(res){
                alert('수정 완료');
                location.href='./mini_gallery.do?id=' + '${mh_attr.id}';
            },
	        error:function(xhr,status,error){
				console.log('xhr.status : ', xhr.status);	
			}
        })			
    } 
});


//다른 사람의 미니홈피 방문시 다이어리 작성 버튼 숨김
$(document).ready(function () {
	if('${user_id}' != '${mh_attr.id}'){	
	    $('#buttonContainer').hide();
	}
});

$(function(){
	//사용자가 해당 글에 좋아요를 눌렀는지 확인하는 함수
	let sid = '';
	sid = '${user_id}';
	if(sid != ''){
		$.ajax({
			url : "json_mb_likeCheck.do",
			method : 'GET',
			data : {
				id : sid,
				mbnum : ${param.mbnum}
			},
			dataType : 'json', 
			success : function(map) {
// 	 			console.log(map.result);
				if(map.result == 0){		//좋아요를 안눌렀다면
					$("#like_button").show();
					$("#lcancel_button").hide();
				}else{
					$("#like_button").hide();
					$("#lcancel_button").show();
				}
			},
			error : function(xhr, status, error) {
				console.log('xhr:', xhr.status);
//				console.log('status:', status);
//				console.log('error:', error);
			}
		});//end $.ajax()
	}
});//end onload

function like(){
	let sid = '';
	sid = '${user_id}';
	$.ajax({
		url : "json_mb_like.do",
		method : 'GET',
		data : {
			id : sid,
			mbnum : ${param.mbnum}
		},
		dataType : 'json', 
		success : function(map) {
//			console.log(map.result);
			if(map.result == 1){
				$("#like_button").hide();
				$("#lcancel_button").show();
				$("#likes_count").text(map.likes);
			}
		},
		error : function(xhr, status, error) {
			console.log('xhr:', xhr.status);
//			console.log('status:', status);
//			console.log('error:', error);
		}
	});//end $.ajax()
}//end like()

function like_cancel(){
	let sid = '';
	sid = '${user_id}';
	$.ajax({
		url : "json_mb_like_delete.do",
		method : 'GET',
		data : {
			id : sid,
			mbnum : ${param.mbnum}
		},
		dataType : 'json', 
		success : function(map) {
	// 			console.log(map.result);
			if(map.result == 1){
				$("#like_button").show();
				$("#lcancel_button").hide();
				$("#likes_count").text(map.likes);
			}
		},
		error : function(xhr, status, error) {
			console.log('xhr:', xhr.status);
//			console.log('status:', status);
//			console.log('error:', error);
		}
	});//end $.ajax()
}//end dislike()

function report(){
	let url = "mb_report.do?mbnum="+${vo2.mbnum}+"&id=${mh_attr.id}";
	let name = "신고하기";
	let option = "width = 500, height = 500";
	window.open(url, name, option);
}//end report()

function copy_url(){
	navigator.clipboard.writeText(url).then(() => {
        alert("복사완료");
      });
}

function share_twitter(){
	let option = "width = 500, height = 500";
	let name = "트위터로 공유";
    window.open("http://twitter.com/share?url=" + encodeURIComponent(url) +"&text=" + encodeURIComponent(document.title), name, option);
}//end share_twitter()

function share_facebook(){
	let option = "width = 500, height = 500";
	let name = "페이스북으로 공유";
    window.open("http://www.facebook.com/sharer.php?u=" + encodeURIComponent(url), name, option);
}//end share_facebook()

$(function(){
	Kakao.init('8b87b1c63625a7c92d74e9e4019cc90f');
	if(Kakao.isInitialized()){
		Kakao.Share.createScrapButton({
		    container: '#kakaotalk-sharing-btn',
		    requestUrl: url
		});
	}
});

//다중파일 출력을 위한 파일 분할
$(document).ready(function () {
	let fileList = "${vo2.filepath}".split(',');
	console.log(fileList);
	tag_file = ``;
	for(var i = 0; i < fileList.length; i++){
		tag_file += `<img src="resources/uploadimg/`+fileList[i]+`">`;
	}
	$('#file').html(tag_file);
});

</script>
</head>
<body>
<jsp:include page="../../top_menu.jsp"></jsp:include>
<jsp:include page="../mini_top_menu.jsp"></jsp:include>
	<h1>mini/gallery/selectOne.jsp</h1>
	<h1>사진첩</h1>
	 <div style="background-image: url('resources/uploadimg/${mh_attr.backimg}'); background-size: cover; width: 100%; height: 100vh;">
        <h1>사진첩</h1>
        <div id="title">제목 : ${vo2.title}</div>
        <div>올린날 : ${vo2.wdate}<span id =modifiedIndicator></span></div>
        <div id="file">
        	
        </div>
	    <div>
			<button onclick="like()" id="like_button">좋아요</button>
			<button onclick="like_cancel()" id="lcancel_button" style="display: none">좋아요 취소</button>
			<span id="likes_count">${vo2.likes }</span>
			<button onclick="open_modal()">공유</button>					
			<button onclick="report()" id="report_button">신고</button>
		</div>
     <div id="buttonContainer">
		 <button id="editButton" class="myButton">수정<span id="modifiedIndicator"></span></button>
		 <a href="gallery_deleteOK.do?id=${mh_attr.id}&mbnum=${param.mbnum}" class="myButton">삭제</a>
     </div>
    </div>
    
    <div id="modal">
		<div class="modal-content">
			<h6>공유하기</h6>
			<button onclick="share_twitter()" id="share_button">트위터로 공유</button>
			<button onclick="share_facebook()" id="share_button">페이스북으로 공유</button>
			<button id="kakaotalk-sharing-btn">카카오톡으로 공유</button>
			<div>
				<label for="copy_url_btn" id="url"></label>			
				<button id="copy_url_btn" onclick="copy_url()">링크복사</button>
			</div>
			<div>
				<button onclick="close_modal()">닫기</button>
			</div>
		</div>
	</div>
	
<script type="text/javascript">
$('#url').html(url);
let modal = document.getElementById("modal");

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