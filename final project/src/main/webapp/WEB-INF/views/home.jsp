<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<html>
<head>
<title>Home</title>
<jsp:include page="css.jsp"></jsp:include>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
</head>
<body>
<jsp:include page="top_menu.jsp"></jsp:include>
	<h1>Hello world!</h1>
	user num: ${num}<br />
	user_id: ${user_id}<br/>
	nickname: ${nickname}<br />
	mclass: ${mclass}
</body>
</html>
