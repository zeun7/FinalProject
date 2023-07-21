<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>글쓰기</title>
<link rel="stylesheet" href="resources/css/button.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
<script src="https://kit.fontawesome.com/7ed6703c9d.js" crossorigin="anonymous"></script>
<script type="text/javascript">
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
		}else if($("#content").val() === '<p>&nbsp;</p>' || $("#content").val() === ''){
			alert('내용을 입력하세요');
		}else{
			document.getElementById("insert_form").submit();
		}
	}
</script>
</head>
<body>
<jsp:include page="../sidebar.jsp"></jsp:include>
<div class="main-panel">
	<div class="col-md-12">
		<div class="card">
			<div class="card-header" style="margin-top:20px; margin-left:20px">
				<h1><c:set var="bname" value="${param.bname}"></c:set>
					<c:choose><c:when test="${bname eq 'board01'}"> <!-- 자유 -->
							자유
					</c:when></c:choose>
					<c:choose><c:when test="${bname eq 'board02'}"> <!-- 일상 -->
							일상
					</c:when></c:choose>
					<c:choose><c:when test="${bname eq 'board03'}"> <!-- 유머 -->
							유머
					</c:when></c:choose>
					<c:choose><c:when test="${bname eq 'board04'}"> <!-- 엔터 -->
							엔터
					</c:when></c:choose>
					<c:choose><c:when test="${bname eq 'board05'}"> <!-- 스포츠 -->
							스포츠
					</c:when></c:choose></h1>
			</div>
			<div class="card-body" style="width: 100%">
				<form action="b_insertOK.do" method="post" enctype="multipart/form-data" id="insert_form" style="width:800px">
				<table style="width: 100%">
					<thead>
						<tr>
							<td>
								<input type="text" name="title" id="title" style="width:400px" placeholder="제목을 입력하세요." value="">
								<input type="hidden" name="bname" id="bname" value="${param.bname }">
								<input type="hidden" name="writer" id="writer" value="${nickname }">
							</td>
							<td>
								<c:set var="bname" value="${param.bname}"></c:set>
								<c:choose>
									<c:when test="${bname eq 'board01'}"> <!-- 자유 -->
										<select name="caname" id="caname">
											<option value="category01">자유</option>
											<option value="category02">질문</option>
											<option value="category03">썰</option>
										</select>
									</c:when>
									
									<c:when test="${bname eq 'board02'}"> <!-- 일상 -->
										<select name="caname" id="caname">
											<option value="category04">일상</option>
											<option value="category05">맛집</option>
											<option value="category06">고민</option>
											<option value="category07">OOTD</option>
											<option value="category08">뷰티</option>
										</select>
									</c:when>
									
									<c:when test="${bname eq 'board03'}"> <!-- 유머 -->
										<select name="caname" id="caname">
											<option value="category09">유머</option>
											<option value="category10">이슈</option>
										</select>
									</c:when>
									
									<c:when test="${bname eq 'board04'}"> <!-- 엔터 -->
										<select name="caname" id="caname">
											<option value="category11">가수</option>
											<option value="category12">아이돌</option>
											<option value="category13">배우</option>
											<option value="category14">드라마</option>
											<option value="category15">영화</option>
											<option value="category16">유튜브</option>
										</select>
									</c:when>
									
									<c:when test="${bname eq 'board05'}"> <!-- 스포츠 -->
										<select name="caname" id="caname">
											<option value="category17">축구</option>
											<option value="category18">야구</option>
											<option value="category19">농구</option>
											<option value="category20">배구</option>
											<option value="category21">골프</option>
											<option value="category22">e스포츠</option>
										</select>
									</c:when>
								</c:choose>
							</td>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td>
								<label for="file">
									<span  class="btn-two cyan mini" id="filepath_text" style="border: 1px solid black">사진/동영상 첨부</span>
								</label>
								<input type="file" id="file" name="file" multiple="multiple" style="display: none" onchange="uploadFile()">
								<input type="hidden" id="isFileExist" name="isFileExist" value="0">
							</td>
						</tr>
						<tr>
							<td colspan="2">
								<textarea rows="20" cols="50" name="content" id="content" style="width:100%;"></textarea>
							</td>
						</tr>
					</tbody>
				</table>
				<div class="card-footer"  style="display: flex; justify-content: flex-end;">
					<button type="button" class="custom-btn btn-4" style="margin-right: 10px;" onclick="history.back()">취소</button>
					<button type="button" class="custom-btn btn-4" onclick="input_check()">글쓰기</button>
				</div>
				</form>
			</div> <!-- end "card-body"-->
		</div> <!-- end "card"-->
	</div> <!-- end "col-md-12"-->
	<jsp:include page="../footer.jsp"></jsp:include>
</div> <!-- end "main-panel"-->
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

if ('${mclass}' !== '1') { // 관리자만 공지 쓸 수 있게
	$('#announcement').hide();
}
</script>

</body>
</html>