<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<html>
<head>
<title>방명록</title>
<jsp:include page="../../css.jsp"></jsp:include>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
<script type="text/javascript">
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
	<h1>mini/visit/visit.jsp</h1>
	<div
		style="background-image: url('resources/uploadimg/${backimg}'); background-size: cover; width: 100%; height: 100vh;">
		<audio id="bgmPlayer" controls autoplay>
			<source src="resources/uploadbgm/${bgm}" type="audio/mp3">
		</audio>
		<button id="backButton" class="myButton" style="margin-left: 300px">뒤로가기</button>
	</div>
</body>
</html>
