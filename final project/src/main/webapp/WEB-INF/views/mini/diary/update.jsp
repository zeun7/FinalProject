<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<html>
<head>
<title>다이어리_update</title>
<jsp:include page="../../css.jsp"></jsp:include>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
<script type="text/javascript">
function input_check(){
	oEditors.getById["content"].exec("UPDATE_CONTENTS_FIELD", []);
	console.log($("#content").val());
	
	if($("#title").val() === ''){
		alert('제목을 입력하세요');
	}else if($("#content").val() === '<p>&nbsp;</p>' || $("#content").val() === ''){
		alert('내용을 입력하세요');
	}else{
		document.getElementById("insert_form").submit();
	}
}
</script>
</head>
<body>
	<jsp:include page="../../top_menu.jsp"></jsp:include>
	<jsp:include page="../mini_top_menu.jsp"></jsp:include>
	<h1>mini/diary/update.jsp</h1>
	<form action="diary_updateOK.do?id=${mh_attr.id}&mbnum=${vo2.mbnum}" method="post" enctype="multipart/form-data" id="insert_form">
		<div>
			<h1 style="font-size: 24px;">다이어리 ${m_attr.nickname}</h1>
		</div>
		<div>닉네임 : ${vo2.writer}</div>
		<div>작성일자 : ${vo2.wdate}</div>
		<div>
			제목 :<input type="text" style="border: none;" id="title" name="title"
				value="${vo2.title}">
		</div>
		<div>
			<textarea rows="20" cols="100" id="content" name="content">${vo2.content}</textarea>
		</div>
		<div>
			<img src="resources/uploadimg/${vo2.filepath}">
			<input type="file" id="file" name="file"> 
			<input type="hidden" id="filepath" name="filepath">
		</div>
		<div>
			<button type="button" class="myButton" onclick="input_check()">수정완료</button>
		</div>
	</form>

</body>
</html>

<script type="text/javascript" src="./resources/smarteditor2/js/HuskyEZCreator.js" charset="utf-8"></script>
<script type="text/javascript">
var oEditors = [];
nhn.husky.EZCreator.createInIFrame({
	oAppRef: oEditors,
	elPlaceHolder: "content",
	sSkinURI: "./resources/smarteditor2/SmartEditor2Skin.html",
	htParams : {
		bSkipXssFilter : true
	},
	fCreator: "createSEditor2"
});
</script>