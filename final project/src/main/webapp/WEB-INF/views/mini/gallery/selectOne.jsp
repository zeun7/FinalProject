<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<html>
<head>
<title>사진첩_selectOne</title>
<jsp:include page="../../css.jsp"></jsp:include>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
<script type="text/javascript">

//다른 사람의 미니홈피 방문시 다이어리 작성 버튼 숨김
$(document).ready(function () {
	if('${user_id}' != '${mh_attr.id}'){	
	    $('#buttonContainer').hide();
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
        <div>제목 : ${vo2.title}</div>
        <div id="imageContainer"><img src="resources/uploadimg/${vo2.filepath}"></div>
     <div id="buttonContainer">
		 <button id="editButton" class="myButton">수정</button>
		 <a href="gallery_deleteOK.do?id=${mh_attr.id}&mbnum=${param.mbnum}" class="myButton">삭제</a>
     </div>
    </div>
</body>
</html>