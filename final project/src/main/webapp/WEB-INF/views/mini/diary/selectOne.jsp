<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html>
<head>
<title>다이어리_selectOne</title>
<jsp:include page="../../css.jsp"></jsp:include>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>

</head>
<body>
<jsp:include page="../../top_menu.jsp"></jsp:include>
<jsp:include page="../mini_top_menu.jsp"></jsp:include>
<h1>mini/diary/selectOne.jsp</h1>
<h1>${user_id}</h1>
<h1>${mh_attr.id}</h1>
<div>${vo2.mbname}</div>
<div id="title">제목 : <span id="titleSpan">${vo2.title}</span></div>
<div>닉네임 : ${vo2.writer}</div>
<div>작성일자 : ${vo2.wdate}</div>
<div style="border: 1px solid black; width: 700px; height: 350px;">
  <p id="content"><span id="contentSpan">${vo2.content}</span></p>
</div>
<div id=imageContainer><img src="resources/uploadimg/${vo2.filepath}"></div>
<div id="buttonContainer">
  <a href="diary_update.do?id=${mh_attr.id}&mbnum=${param.mbnum}" class="myButton">수정</a>
  <a href="diary_deleteOK.do?id=${mh_attr.id}&mbnum=${param.mbnum}" class="myButton">삭제</a>
</div>
</body>
</html>
<script type="text/javascript">
  // 다른 사람의 미니홈피 방문시 다이어리 작성 버튼 숨김
  if('${user_id}' != '${mh_attr.id}'){	
      $('#buttonContainer').hide();
  }
  if('${vo2.filepath}' == ''){
	  $('#imageContainer').hide();
  }
</script>