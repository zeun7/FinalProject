<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<html>
<head>
<title>방명록_insert</title>
<jsp:include page="../../css.jsp"></jsp:include>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
<script type="text/javascript">
function input_check(){
	oEditors.getById["content"].exec("UPDATE_CONTENTS_FIELD", []);
	console.log($("#content").val());
	
	if($("#content").val() === '<p>&nbsp;</p>' || $("#content").val() === ''){
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
	<h1>mini/diary/insert.jsp</h1>
	<h1>${param.writer}</h1>
	<form action="visit_insertOK.do?id=${mh_attr.id}" method="post" id="insert_form">
<!-- 	mcnum, cdate은 DAOimpl에서 추가 -->
		<div>
			<h1 style="font-size: 24px;">방명록</h1>
		</div>
		<div>
			<input type="hidden" id="mccnum" name="mccnum" value="0">
		</div>
		<div>
			<input type="hidden" id="mbnum" name="mbnum" value="0">
		</div>
<!-- 		<div> -->
<!-- 			<input type="hidden" id="id" name="id" -->
<%-- 				value="${mh_attr.id}"> --%>
<!-- 		</div> -->
		<div>
			<input type="hidden" id="writer" name="writer"
				value="${param.writer}">
		</div>
		<div>
			<textarea rows="20" cols="100" id="content" name="content"></textarea>
		</div>
		<div>
			<input type="hidden" id="secret" name="secret" value="0">
		</div>
		<div>
			<input type="hidden" id="report" name="report" value="0">
		</div>
		<div>
			<button type="button" class="myButton" onclick="input_check()">방명록 작성완료</button>
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