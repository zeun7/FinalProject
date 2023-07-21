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
<link rel="stylesheet" href="resources/css/modal.css">
<script src="https://kit.fontawesome.com/7ed6703c9d.js" crossorigin="anonymous"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
<script type="text/javascript">
let userPeach = 0;
let cost = 1;
let gptTxt = '';

$(function(){
// 	$('#cost').html(cost);	
	
	$.ajax({	//이용자가 보유한 peach 개수 출력
		url : "json_peach_count.do",
		method : 'get',
		data : {
			id : '${user_id}'
		},
		dataType : 'json',
		success : function(vo){
			$('#peach').html('보유 peach: '+vo.peach);
			userPeach = vo.peach;
		},
		error : function(xhr, status, error){
			console.log('xhr', xhr.status);
		}
	});//end ajax
});//end onload

function pcount_down(){
	let presult = 1;
	
	if(userPeach - cost < 0){
		alert('peach가 부족합니다.');
		presult = 0;
		return presult;
	}else{
		$.ajax({
			url : "json_pcount_down.do",
			method : 'get',
			data : {
				id : '${user_id}',
				peach: cost
			},
			dataType : 'json',
			success : function(result){
				console.log(result.result);
			},
			error : function(xhr, status, error){
				console.log('xhr', xhr.status);
			}
		});//end ajax
	}
	
	return presult;
}

function input_check(){
	oEditors.getById["content"].exec("UPDATE_CONTENTS_FIELD", []);
	console.log($("#content").val());
	
	let content_val = $("#content").val();
	let content_txtonly = content_val.replace(/[<][^>]*[>]/gi, "");	//gpt용 텍스트
	console.log('txtonly:', content_txtonly);
	
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
		if($('#AI_Image').is(':checked')){
			var result = pcount_down();
			if(result == 1){
				let modal = document.getElementById("modal");
				modal.style.display = "block";
				document.body.style.overflow = "hidden"; // 스크롤바 제거
				gpt_translate(content_txtonly);
			}
		}else{
			submit_form();
		}
	}
}//end input_check()

function buyPeach(){
	window.location.href="mini_peachPay.do?id=${user_id}";
}

function gpt_translate(content_txtonly){
	
	$.ajax({
		url : "gptTranslate.do",
		method : 'get',
		data : {
			question : content_txtonly
		},
		dataType : 'json',
		success : function(vo){
			console.log(vo.response);
			gptTxt = vo.response;
			gptTxt += " I imagine this in cute cartoon style.";
			gpt_make_image(gptTxt);
		},
		error : function(xhr, status, error){
			console.log('xhr', xhr.status);
		}
	});//end ajax
}//end gpt_translate()

function gpt_make_image(gptTxt){
	$.ajax({
		url : "gptMakeImage.do",
		method : 'get',
		data : {
			question : gptTxt
		},
		dataType : 'json',
		success : function(vo){
			console.log(vo.response);
			let imgUrl = vo.response;
			gpt_download_image(imgUrl);
		},
		error : function(xhr, status, error){
			console.log('xhr', xhr.status);
		}
	});//end ajax
}//end gpt_make_image()

function gpt_download_image(imgUrl){
	$.ajax({
		url : "json_download_image.do",
		method : 'get',
		data : {
			url : imgUrl,
			id : '${user_id}'
		},
		dataType : 'json',
		success : function(map){
			console.log(map.filepath);
			$('#ai_path').val(map.filepath);
			let input = document.getElementById("isFileExist");
			input.value = 1;
			submit_form();
		},
		error : function(xhr, status, error){
			console.log('xhr', xhr.status);
		}
	});//end ajax
}

function submit_form(){
	document.getElementById("insert_form").submit();
}

</script>
</head>

<body class="">
  <jsp:include page="../mini_top_menu.jsp"></jsp:include>
  <div class="wrapper ">
    <div class="main-panel" style="background-image: url('resources/uploadimg/${mh_attr.backimg}'); background-size:cover; background-repeat:no-repeat;">
    <jsp:include page="../mini_navbar.jsp"></jsp:include>
      <div class="content" style="height: 100%;">
        <div class="row">
          <div class="col-md-12">
            <div class="card card-user">
             <form action="mb_insertOK.do?id=${mh_attr.id}" method="post" enctype="multipart/form-data" id="insert_form">
              <div class="card-header">
                <h5 class="card-title">다이어리</h5>
                <div>
					<input type="hidden" id="mbname" name="mbname" value="diary">
					<input type="hidden" id="ai_path" name = "ai_path" value="">
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
					<label for="AI_Image" style="margin-left: 5px;">
						<input type="checkbox" id="AI_Image" name="AI_Image" value="true"> 
						AI로 이미지 생성
					</label>
					<label id="peach" style="margin-left: 23%"></label>
					<button type="button" onclick="buyPeach()" class="btn-two cyan mini" style="border: 1px solid black">peach 충전</button>
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
      <jsp:include page="../../footer.jsp"></jsp:include>
    </div>
  </div>
  
  <div id="modal">
	<div class="modal-content" style="top:5%; left:10%; width:350px; height:350px; align-content: center;">
		<h4 style="margin-top: auto; margin-bottom: auto;">AI 이미지 생성중...</h4>
		
	</div>
  </div>

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
			}
		});//end $.ajax()
	}//end if
}//end uploadFile()
</script>
</body>
</html>