<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<html>
<head>
<title>다이어리_selectAll</title>
<jsp:include page="../../css.jsp"></jsp:include>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
<script type="text/javascript">



$(document).ready(function() {
    // 다른 사람의 미니홈피 방문시 다이어리 작성 버튼 숨김
    if('${user_id}' != '${mh_attr.id}'){	
        $('#diary_insert').hide();
    }
});
</script>


</head>
<body>
<jsp:include page="../../top_menu.jsp"></jsp:include>
<jsp:include page="../mini_top_menu.jsp"></jsp:include>
	<h1>mini/diary/selectAll.jsp ${user_id}</h1>
	<div
		style="background-image: url('resources/uploadimg/${mh_attr.backimg}'); background-size: cover; width: 100%; height: 100vh;">
			<h1>다이어리</h1>
		<a href="diary_insert.do?id=${mh_attr.id}" id="diary_insert" class="myButton">다이어리 작성</a>
		
		<table id="boardList">
		<thead>
			<tr>
				<th>mbnum</th>
				<th>mbname</th>
				<th>writer</th>
				<th>title</th>
				<th>wdate</th>
				<th></th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="vo" items="${vos}">
				<tr>
					<td>${vo.mbnum}</td>
					<td>${vo.mbname}</td>
					<td>${vo.writer}</td>
					<td>${vo.title}</td>
					<td>${vo.wdate}</td>
					<td><a href="diary_selectOne.do?id=${mh_attr.id}&mbnum=${vo.mbnum}">자세히 보기</a></td>
				</tr>
			</c:forEach>
		</tbody>
		<tfoot>
			<tr>
				<td colspan="6" id="page"></td>
			</tr>
		</tfoot>
		</table>
	</div>
	
</body>
</html>