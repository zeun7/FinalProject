<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<jsp:include page="../css.jsp"></jsp:include>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
</head>
<body>
	<jsp:include page="../top_menu.jsp"></jsp:include>
	<h1>${param.bname }</h1>
	
	<h3>글수정</h3>
	<form action="b_updateOK.do" method="post" enctype="multipart/form-data">
	<table>
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
					<input type="file" id="file" name="file">
					<input type="hidden" id="file_name" name="file_name" value="">
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
					<input type="submit" value="수정완료">
				</td>
			</tr>
		</tfoot>
	</table>
	</form>
	
	<script type="text/javascript">
		let caname = document.querySelector('#${vo2.caname}');
		caname.setAttribute('selected', true);
		
		let file_name = '${vo2.filepath}';
		file_name = file_name.replace('resources/uploadimg_board/', '');
		let tag_fname = document.querySelector('#file_name');
		tag_fname.setAttribute('value', file_name);
	</script>

</body>
</html>