<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<jsp:include page="../top_menu.jsp"></jsp:include>
	<h1>${param.bname }</h1>
	
	<h3>글쓰기</h3>
	<form action="b_insertOK.do" method="post">
	<table>
		<thead>
			<tr>
				<td>
					<input type="text" name="title" id="title" placeholder="제목을 입력하세요." value="">
					<input type="hidden" name="bname" id="bname" value="${param.bname }">
					<input type="hidden" name="writer" id="writer" value="tester2">
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
					<textarea rows="20" cols="50" name="content" id="content"></textarea>
				</td>
			</tr>
		</tbody>
		<tfoot>
			<tr>
				<td>
					<button>취소</button>
					<input type="submit" value="등록">
				</td>
			</tr>
		</tfoot>
	</table>
	</form>

</body>
</html>