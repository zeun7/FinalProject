<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html>
<head>
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

</script>

</head>
<body>
    <jsp:include page="../../top_menu.jsp"></jsp:include>
    <jsp:include page="../mini_top_menu.jsp"></jsp:include>
    <h1>mini/gallery/selectAll.jsp</h1>
    <div style="background-image: url('resources/uploadimg/${mh_attr.backimg}'); background-size: cover; width: 100%; height: 100vh;">
        <h1>사진첩</h1>
        <c:forEach var="vo" items="${vos}">
	        <a href="gallery_selectOne.do?id=${mh_attr.id}&mbnum=${vo.mbnum}">
	  			<img src="resources/uploadimg/thumb_${vo.filepath}">
		    </a>
        </c:forEach>
        <h2>이미지추가</h2><br>
        <div id="buttonContainer">
	        <input type="file" id="file" name="file"><br>
	        제목 :<input type="text" id="title" name="title">
	        <button id="uploadButton">사진올리기</button>
        </div>
    </div>
</body>
</html>