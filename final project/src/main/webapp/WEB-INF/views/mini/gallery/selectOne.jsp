<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<html>
<head>
<title>사진첩_selectOne</title>
<jsp:include page="../../css.jsp"></jsp:include>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
<script type="text/javascript">
$(document).on('click', '#editButton', function(e) {
    e.preventDefault();
    
    const originalTitle = "${vo2.title}"; // Original title from server
    
    // Replace the title div with an input field
    $('#title').replaceWith('<input id="title" type="text" value="' + originalTitle + '">');
    
    // Replace the image with a file input field
    $('#file').replaceWith('<input type="file" id="file" name="file"> ' + 
    		'<input type="hidden" id="filepath" name="filepath" value="${vo2.filepath}">');
    
    // Change edit button to a save button
    $('#editButton').text('저장').attr('id', 'saveButton');
    
});

$(document).on('click', '#saveButton', function(e) {
    if (confirm("정말 수정하시겠습니까?") == true) {
		
        //데이터를 담아내는 부분
        const id = $("#id").val();
        const title = $("#title").val().trim();
        const file = $("#file")[0].files[0];
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
            formData.append("file", file);  // Only append file if one was selected
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
            error: function(xhr, status, error) {
                // 삭제 실패: 에러 메시지를 표시합니다.
                console.error('삭제 실패:', error);
            }
        })			
    } 
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
        <div id="file"><img src="resources/uploadimg/${vo2.filepath}"></div>
     <div id="buttonContainer">
		 <button id="editButton" class="myButton">수정<span id="modifiedIndicator"></span></button>
		 <a href="gallery_deleteOK.do?id=${mh_attr.id}&mbnum=${param.mbnum}" class="myButton">삭제</a>
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