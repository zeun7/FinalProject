<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>글수정</title>
<link rel="stylesheet" href="resources/css/button.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
<script type="text/javascript">
// 	$(function(){
// 		if('${vo2.filepath}' === ''){
// 			$('#filepath_text').html('파일 업로드');
// 			$('#del_file_button').hide();
// 		}else{
// 			let file_name = '${vo2.filepath}';
// 			file_name = file_name.replace('resources/uploadimg_board/', '');
// 			$('#filepath_text').html(file_name);
// 			$('#del_file_button').show();
// 		}
// 	});//end onload
	
// 	function delete_file(){
// 		$('#filepath').val('');
// 		$('#filepath_text').html('파일 업로드');
// 	}//end delete_file()
	
// 	function show_file(){
// 		$('#filepath_text').html($('#file').val());
// 		$('#del_file_button').show();
// 	}//end show_file()
	
	$(function(){
		let content_val = '${vo2.content}';
		content_val = content_val.replaceAll('<img src="', '<img src="../../');
		content_val = content_val.replaceAll('<video src="', '<video src="../../');
		$("#content").val(content_val);
	});//end onload
	
	function input_check(){
		oEditors.getById["content"].exec("UPDATE_CONTENTS_FIELD", []);
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
		}else if($("#content").val() === ''){
			alert('내용을 입력하세요');
		}else{
			document.getElementById("update_form").submit();
		}
	}//end input_check()
</script>
</head>
<body>
<jsp:include page="../sidebar.jsp"></jsp:include>
<div class="main-panel">
	<div class="col-md-12">
		<div class="card">
			<div class="card-header" style="margin-top:20px; margin-left:20px">
				<h2>글 수정</h2>
			</div>
			<div class="card-body" style="width: 100%">
				<form action="b_updateOK.do" method="post" enctype="multipart/form-data" id="update_form" style="width:800px">
				<table style="width: 100%">
					<thead>
						<tr>
							<td>
								<input type="text" name="title" id="title" style="width:400px" placeholder="제목을 입력하세요." value="${vo2.title }">
								<input type="hidden" name="bnum" id="bnum" value="${vo2.bnum }">
								<input type="hidden" name="bname" id="bname" value="${vo2.bname }">
								<input type="hidden" name="writer" id="writer" value="${vo2.writer }">
							</td>
							<td>
								<select name="caname" id="caname">
									<option id="general" value="general">일반</option>						
									<option id="notice" value="notice">공지</option>
									<option id="question" value="question">질문</option>
								</select>
							</td>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td>
								<label for="file">
									<span class="btn-two cyan mini" id="filepath_text" style="border: 1px solid black">사진/동영상 첨부</span>
								</label>
								<input type="hidden" id="isFileExist" name="isFileExist" value="0">
							</td>
							<td>
								<input type="file" id="file" name="file" multiple="multiple" style="display: none" onchange="uploadFile()">
							</td>
						</tr>
						<tr>
							<td colspan="2">
								<textarea rows="20" cols="50" name="content" id="content" style="width:100%;"></textarea>
							</td>
						</tr>
					</tbody>
					<tfoot>
						<tr>
							<td colspan="2">
								<div class="card-footer"  style="display: flex; justify-content: flex-end;">
									<button type="button" onclick="history.back()" class="custom-btn btn-4" style="margin-right: 10px;">취소</button>
									<button type="button" onclick="input_check()" class="custom-btn btn-4">수정</button>
								</div>
							</td>
						</tr>
					</tfoot>
				</table>
				</form>
			</div> <!-- end "card-body" -->
		</div> <!-- end "card" -->
	</div> <!-- end "col-md-12 -->
	<jsp:include page="../footer.jsp"></jsp:include>
</div>
<script type="text/javascript" src="./resources/smarteditor2/js/HuskyEZCreator.js" charset="utf-8"></script>
<script type="text/javascript">
	let caname = document.querySelector('#${vo2.caname}');
	caname.setAttribute('selected', true);
	
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

</body>
</html>