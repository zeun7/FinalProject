<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<jsp:include page="../css.jsp"></jsp:include>
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
	<jsp:include page="../top_menu.jsp"></jsp:include>
	<h1>${param.bname }</h1>
	
	<h3>글쓰기</h3>
	<form action="b_insertOK.do" method="post" enctype="multipart/form-data" id="insert_form" style="width:800px">
	<table style="width: 100%">
		<thead>
			<tr>
				<td>
					<input type="text" name="title" id="title" placeholder="제목을 입력하세요." value="">
					<input type="hidden" name="bname" id="bname" value="${param.bname }">
					<input type="hidden" name="writer" id="writer" value="${nickname }">
				</td>
				<td>
					<select name="caname" id="caname">
						<option value="general">일반</option>
						<option value="notice">공지</option>
						<option value="question">질문</option>
					</select>
				</td>
			</tr>
		</thead>
		<tbody>
			<tr>
				<td>
					<input type="file" id="file" name="file" multiple="multiple" onchange="file_change(event)">
					<div id="file_content"></div>
				</td>
			</tr>
			<tr>
				<td colspan="2">
					<textarea rows="20" cols="50" name="content" id="content"></textarea>
				</td>
			</tr>
		</tbody>
		<tfoot>
			<tr>
				<td>
					<button type="button" onclick="history.back()">취소</button>
					<button type="button" onclick="input_check()">등록</button>
				</td>
			</tr>
		</tfoot>
	</table>
	</form>

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

//다중 파일 업로드
let files = new Array();

function file_change(event){
	console.log('file_change()');
	
	for(var image of event.target.files){
		var reader = new FileReader();
		
		reader.onload = function(event) {
            var img = document.createElement("img");
            img.setAttribute("src", event.target.result);
            img.setAttribute("width", "400px");
            var tag_img = '<img width="400px" src="'+event.target.result+'" id="img">';
	        oEditors.getById["content"].exec("PASTE_HTML", [tag_img]);
          };
          
        reader.readAsDataURL(image);
	}
	
}
</script>

</body>
</html>