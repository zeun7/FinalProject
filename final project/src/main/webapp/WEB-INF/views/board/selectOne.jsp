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
	<table>
		<tr>
			<td><h3>${vo2.title }</h3></td>
			<td>${vo2.writer }</td>
			<td>${vo2.vcount }</td>
		</tr>
		<tr><td>${vo2.wdate }</td></tr>
	</table>

	
</body>
</html>