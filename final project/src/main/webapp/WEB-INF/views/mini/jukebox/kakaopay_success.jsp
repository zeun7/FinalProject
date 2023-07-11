<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
	function gotoJukebox(){
		window.location.href="/finalproject/mini_jukebox.do?id=${user_id}";
	}
</script>
</head>
<body>
<h1>구매 성공</h1>
<button onclick="gotoJukebox()">쥬크박스로</button>    

</body>
</html>