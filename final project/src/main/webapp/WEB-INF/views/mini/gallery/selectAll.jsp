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

        var fileInput = document.getElementById('bfile');
        var file = fileInput.files[0];
        var formData = new FormData();

        formData.append('bfile', file); 
        formData.append('mbname', 'gallery');
        formData.append('writer', '${nickname}'); 

        $.ajax({
            url: 'gallery_insertOK.do', 
            type: 'POST',
            data: formData,
            processData: false,  
            contentType: false,  
            success: function(response) {
                // 서버에서 응답을 받았을 때의 처리
                console.log(response);
                
                // 0.05초 지연 후 페이지 새로고침
                setTimeout(function() {
                    location.reload();
                }, 50);
            },
            error: function(xhr, status, error) {
                // 오류가 발생했을 때의 처리
                console.log(error);
            }
        });
    });
});

$(document).ready(function() {
    $('#backButton').on('click', function(e) {
        e.preventDefault();
        window.history.back();
    });
});
</script>

</head>
<body>
    <jsp:include page="../../top_menu.jsp"></jsp:include>
    <jsp:include page="../../mini_top_menu.jsp"></jsp:include>
    <h1>mini/gallery/selectAll.jsp</h1>
    
    <div style="background-image: url('resources/uploadimg/${backimg}'); background-size: cover; width: 100%; height: 100vh;">
        <h1>사진첩</h1>
        <div><img src="resources/uploadimg/${profilepic}"></div>
        <audio id="bgmPlayer" controls>
            <source src="resources/uploadbgm/${bgm}" type="audio/mp3">
        </audio>
        <br>
        <c:forEach var="vo" items="${vos}">
	        <a href="gallery_selectOne.do?mbnum=${vo.mbnum}">
	  			<img src="resources/uploadimg/thumb_${vo.filepath}">
		    </a>
        </c:forEach>
        <h2>이미지추가</h2><br>
        <input type="file" id="bfile">
        <button id="uploadButton">사진올리기</button>
        
        <div>1 2 3 4 5</div>
        <button id="backButton" class="myButton" style="margin-left: 300px">뒤로가기</button>
    </div>
</body>
</html>