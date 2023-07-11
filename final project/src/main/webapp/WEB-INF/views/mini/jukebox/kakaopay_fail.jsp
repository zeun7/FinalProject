<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html>
<head>
<title>피치구매</title>
<jsp:include page="../../css.jsp"></jsp:include>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
<script type="text/javascript">
	function gotoJukebox(){
		window.location.href="/finalproject/mini_jukebox.do?id=${user_id}";
	}
</script>
</head>
<body>
	<h1>결제 실패</h1>
	<button onclick="gotoJukebox()">쥬크박스로</button>    
</body>
</html>