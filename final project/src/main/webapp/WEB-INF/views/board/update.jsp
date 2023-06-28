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
	$(function(){
		if('${vo2.filepath}' === ''){
			$('#filepath_text').html('파일 업로드');
			$('#del_file_button').hide();
		}else{
			let file_name = '${vo2.filepath}';
			file_name = file_name.replace('resources/uploadimg_board/', '');
			$('#filepath_text').html(file_name);
			$('#del_file_button').show();
		}
	});//end onload
	
	function delete_file(){
		$('#filepath').val('');
		$('#filepath_text').html('파일 업로드');
	}//end delete_file()
	
	function show_file(){
		$('#filepath_text').html($('#file').val());
		$('#del_file_button').show();
	}//end show_file()
	
	function input_check(){
		oEditors.getById["content"].exec("UPDATE_CONTENTS_FIELD", []);
		console.log($("#content").val());
		
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
	<jsp:include page="../top_menu.jsp"></jsp:include>
	<h1>${param.bname }</h1>
	
	<h3>글수정</h3>
	<form action="b_updateOK.do" method="post" enctype="multipart/form-data" id="update_form" style="width:800px">
	<table style="width: 100%">
		<thead>
			<tr>
				<td>
					<input type="text" name="title" id="title" placeholder="제목을 입력하세요." value="${vo2.title }">
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
					<input type="hidden" id="filepath" name="filepath" value="${vo2.filepath }">
					<label for="file">
						<span id="filepath_text" style="border: 1px solid black">${vo2.filepath }</span>
					</label>
					<button type="button" id="del_file_button" onclick=delete_file()>삭제</button>
				</td>
				<td>
					<input type="file" id="file" name="file" style="display: none" onchange="show_file()">
				</td>
			</tr>
			<tr>
				<td>
					<textarea rows="20" cols="50" name="content" id="content">${vo2.content }</textarea>
				</td>
			</tr>
		</tbody>
		<tfoot>
			<tr>
				<td>
					<button type="button" onclick="history.back()">취소</button>
					<button type="button" onclick="input_check()">수정완료</button>
				</td>
			</tr>
		</tfoot>
	</table>
	</form>
	
<script type="text/javascript" src="./resources/smarteditor2/js/HuskyEZCreator.js" charset="utf-8"></script>
<script type="text/javascript">
	let caname = document.querySelector('#${vo2.caname}');
	caname.setAttribute('selected', true);
	
	var oEditors = [];
	nhn.husky.EZCreator.createInIFrame({
		oAppRef: oEditors,
		elPlaceHolder: "content",
		sSkinURI: "./resources/smarteditor2/SmartEditor2Skin.html",
		fCreator: "createSEditor2"
	});
</script>

</body>
</html>