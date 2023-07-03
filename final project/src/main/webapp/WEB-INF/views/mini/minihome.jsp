<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<html>
<head>
<title>미니홈피</title>
<jsp:include page="../css.jsp"></jsp:include>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
<script type="text/javascript">
function redirectToMiniHome(selectElement) {
    var nickname = selectElement.value;
    window.location.href = "mini_home.do?nickname=" + nickname;
  }
</script>
</head>
<body>
	<jsp:include page="../top_menu.jsp"></jsp:include>
	<jsp:include page="mini_top_menu.jsp"></jsp:include>
	<h1>mini/minihome.jsp</h1>
	<div
		style="background-image: url('resources/uploadimg/${mh_attr.backimg}'); background-size: cover; width: 100%; height: 100vh;">
		<h1>미니홈피 제목 : ${mh_attr.title}</h1>
		<select onchange="redirectToMiniHome(this)">
			<option>1촌목록</option>
			<c:forEach var="vo" items="${vos}">
				<option value="${vo.nickname2}">${vo.nickname2}</option>
			</c:forEach>
		</select>

		<h2>방명록...포스팃 형식으로</h2>
	</div>
</body>
</html>