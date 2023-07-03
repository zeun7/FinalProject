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
		let content_val = $("#content").val();
		
		//파일이 첨부되어있는지 확인
		if(content_val.indexOf('<img') == -1 && content_val.indexOf('<video') == -1){
			let input = document.getElementById("file");
			input.files.length = 0;
		}
		console.log(content_val);
		content_val = content_val.replaceAll('src="../../', 'src="');
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
					<label for="file">
						<span id="filepath_text" style="border: 1px solid black">사진/동영상 첨부</span>
					</label>
					<input type="file" id="file" name="file" multiple="multiple" style="display: none" onchange="uploadFile()">
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
			url : "json_b_file_insertOK.do",
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
				            var tag_img = '<img width="400px" src="../../'+result.filepathList[i]+'" class="img">';
				 	        oEditors.getById["content"].exec("PASTE_HTML", [tag_img]);
		 				}else{
		 					var video = document.createElement("video");
		 					video.setAttribute("src", result.filepathList[i]);
		 					video.setAttribute("width", "400px");
				            var tag_video = '<video width="400px" src="../../'+result.filepathList[i]+'" controls class="video">';
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

</body>
</html>