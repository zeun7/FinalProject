<!--
=========================================================
* Paper Dashboard 2 - v2.0.1
=========================================================

* Product Page: https://www.creative-tim.com/product/paper-dashboard-2
* Copyright 2020 Creative Tim (https://www.creative-tim.com)

Coded by www.creative-tim.com

 =========================================================

* The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
-->
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>
 <meta charset="utf-8" />
 <link rel="apple-touch-icon" sizes="76x76" href="resources/assets/img/apple-icon.png">
 <link rel="icon" type="image/png" href="resources/assets/img/favicon.png">
 
 <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
 <title>
   다이어리 작성
 </title>
 <meta content='width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0, shrink-to-fit=no' name='viewport' />
 <!--     Fonts and icons     -->
 <link href="https://fonts.googleapis.com/css?family=Montserrat:400,700,200" rel="stylesheet" />
 <link href="https://maxcdn.bootstrapcdn.com/font-awesome/latest/css/font-awesome.min.css" rel="stylesheet">
 <!-- CSS Files -->
 <link href="resources/assets/css/bootstrap.min.css" rel="stylesheet" />
 <link href="resources/assets/css/paper-dashboard.css?v=2.0.1" rel="stylesheet" />
<link rel="stylesheet" href="resources/css/button.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
<script type="text/javascript">
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

<body class="">
  <jsp:include page="../mini_top_menu.jsp"></jsp:include>
  <div class="wrapper ">
    <div class="main-panel" style="background-image: url('resources/uploadimg/${mh_attr.backimg}'); background-size:cover; background-repeat:no-repeat;">
    <jsp:include page="../mini_navbar.jsp"></jsp:include>
      <div class="content" style="height: 90vh;">
        <div class="row">
          <div class="col-md-12">
            <div class="card card-user">
             <form action="mb_insertOK.do?id=${mh_attr.id}" method="post" enctype="multipart/form-data" id="insert_form">
              <div class="card-header">
                <h5 class="card-title">다이어리</h5>
                <div>
					<input type="hidden" id="mbname" name="mbname" value="diary">
				</div>
				<div>
					<input type="hidden" id="writer" name="writer"
						value="${m_attr.nickname}">
				</div>
				<div>
					<input type="text" class="form-control col-md-6" id="title" name="title"
						value="" placeholder="제목을 입력하세요.">
				</div>
              </div>
              <div class="card-body">
				  <div>
					<label for="file">
						<span id="filepath_text" class="btn-two cyan mini" style="border: 1px solid black">사진/동영상 첨부</span>
					</label>
					<input type="file" id="file" name="file" multiple="multiple" style="display: none" onchange="uploadFile()">
					<input type="hidden" id="isFileExist" name="isFileExist" value="0">
		<!-- 			<input type="file" id="file" name="file">  -->
		<!-- 			<input type="hidden" id="filepath" name="filepath"> -->
				  </div>
                  <div>
					<textarea rows="20" cols="100" id="content" name="content"></textarea>
				  </div>
                  <button type="button" class="btn btn-primary btn-round" onclick="input_check()">다이어리 작성완료</button>
              </div>
             </form>
            </div>
          </div>
        </div>
      </div>
      <footer class="footer footer-black  footer-white ">
        <div class="container-fluid">
          <div class="row">
            <nav class="footer-nav">
              <ul>
                <li><a href="https://www.creative-tim.com" target="_blank">Creative Tim</a></li>
                <li><a href="https://www.creative-tim.com/blog" target="_blank">Blog</a></li>
                <li><a href="https://www.creative-tim.com/license" target="_blank">Licenses</a></li>
              </ul>
            </nav>
            <div class="credits ml-auto">
              <span class="copyright">
                © <script>
                  document.write(new Date().getFullYear())
                </script>, made with <i class="fa fa-heart heart"></i> by Creative Tim
              </span>
            </div>
          </div>
        </div>
      </footer>
    </div>
  </div>
  <!--   Core JS Files   -->
  <script src="resources/assets/js/core/jquery.min.js"></script>
  <script src="resources/assets/js/core/popper.min.js"></script>
  <script src="resources/assets/js/core/bootstrap.min.js"></script>
  <script src="resources/assets/js/plugins/perfect-scrollbar.jquery.min.js"></script>
  <!-- Chart JS -->
  <script src="resources/assets/js/plugins/chartjs.min.js"></script>
  <!--  Notifications Plugin    -->
  <script src="resources/assets/js/plugins/bootstrap-notify.js"></script>
  <!-- Control Center for Now Ui Dashboard: parallax effects, scripts for the example pages etc -->
  <script src="resources/assets/js/paper-dashboard.min.js?v=2.0.1" type="text/javascript"></script><!-- Paper Dashboard DEMO methods, don't include it in your project! -->

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
</body>

</html>