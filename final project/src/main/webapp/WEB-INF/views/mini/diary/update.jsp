<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<html>
<head>
<title>다이어리_update</title>
<jsp:include page="../../css.jsp"></jsp:include>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
<script type="text/javascript">
$(function(){
	let content_val = '${vo2.content}';
	content_val = content_val.replaceAll('<img src="', '<img src="../../');
	content_val = content_val.replaceAll('<video src="', '<video src="../../');
	$("#content").val(content_val);
});//end onload

function input_check(){
	oEditors.getById["content"].exec("UPDATE_CONTENTS_FIELD", []);
	console.log($("#content").val());
	
	let content_val = $("#content").val();
	
	//파일이 첨부되어있는지 확인
	if(content_val.indexOf('<img') != -1 || content_val.indexOf('<video') != -1){
		let input = document.getElementById("isFileExist");
		input.value = 1;
	}
	
	console.log(content_val);
	content_val = content_val.replaceAll('<img src="../../', '<img src="');
	content_val = content_val.replaceAll('<video src="../../', '<video src="');
	$("#content").val(content_val);
	
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
			<div id="imageContainer"><img src="resources/uploadimg/${vo2.filepath}"></div>
<!-- 			<input type="file" id="file" name="file">  -->
			<input type="hidden" id="filepath" name="filepath" value="${vo2.filepath}">
			<label for="file">
				<span id="filepath_text" style="border: 1px solid black">사진/동영상 첨부</span>
			</label>
			<input type="file" id="file" name="file" multiple="multiple" style="display: none" onchange="uploadFile()">
			<input type="hidden" id="isFileExist" name="isFileExist" value="0">
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

	//이미지 없는 글 수정시 엑박 안나오게
	if('${vo2.filepath}' == ''){
	  $('#imageContainer').hide();
	}
	
	//다중 파일 업로드
	function uploadFile(){
		console.log('uploadFile()');
		
		let input = document.getElementById("file");
		console.log(input.files);
		if(input.files[0] != null){
			var formData = new FormData();
			
			for(let i = 0; i < input.files.length; i++){
				formData.append('file', input.files[i]);
			}
			
			$.ajax({
				url : "json_mb_file_insertOK.do?id=${mh_attr.id}",
				method : 'POST',
				data : formData,
				processData: false,
		        contentType: false,
				dataType : 'json', 
				success : function(result) {
		 			if(result.filepathList != null){
		 				for(var i = 0; i < result.filepathList.length; i++){
			 				console.log(result.filepathList[i]);
			 				var ext = result.filepathList[i].split('.').pop().toLowerCase();
			 				console.log(ext);
			 				
			 				if(ext === 'png' || ext === 'jpg'){
				 				var img = document.createElement("img");
					            img.setAttribute("src", result.filepathList[i]);
					            img.setAttribute("width", "400px");
					            var tag_img = '<img src="../../'+result.filepathList[i]+'" width="400px" class="img">';
					 	        oEditors.getById["content"].exec("PASTE_HTML", [tag_img]);
			 				}else{
			 					var video = document.createElement("video");
			 					video.setAttribute("src", result.filepathList[i]);
			 					video.setAttribute("width", "400px");
					            var tag_video = '<video src="../../'+result.filepathList[i]+'" width="400px" controls class="video">';
					 	        oEditors.getById["content"].exec("PASTE_HTML", [tag_video]);
			 				}
		 				}
		 			}
				},
				error : function(xhr, status, error) {
					console.log('xhr:', xhr.status);
		//			console.log('status:', status);
		//			console.log('error:', error);
				}
			});//end $.ajax()
		}//end if
	}//end uploadFile()
</script>