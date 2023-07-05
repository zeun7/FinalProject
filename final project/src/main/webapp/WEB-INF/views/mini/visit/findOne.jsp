<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<html>
<head>
<title>방명록_selectOne</title>
<jsp:include page="../../css.jsp"></jsp:include>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
<script type="text/javascript">
let mh_attr_id = '${mh_attr.id}';
console.log(mh_attr_id);
	function visitFindOne() {
		let mcnum = '${param.mcnum}'; 
		$.ajax({
			url : 'json_mc_findOne.do',
			type : 'get',
			data : {
				mcnum : mcnum
			},
			dataType : 'json',
			success : function(miniComment) {
				let visit_log = `
					<div>mcnum : \${miniComment.mcnum}</div>
					<div>mbnum : \${miniComment.mbnum}</div>
					<div>hnum : \${miniComment.hnum}</div>
					<div>닉네임 : \${miniComment.writer}</div>
					<div style="border: 1px solid black; width: 700px; height: 350px;">
						<p id="content">
							<span id="contentSpan">\${miniComment.content}</span>
						</p>
					</div>
					<div>작성일자 : \${miniComment.cdate}</div>
					<button id="editButton" class="myButton" onclick="vistUpdate(\${miniComment.mcnum})">수정</button>
					<a href="visit_deleteOK.do?id=\${mh_attr_id}&mcnum=\${miniComment.mcnum}" class="myButton">삭제</a>
					`;
				$('#visitor_log').html(visit_log);
			},
			error : function(request, status, error) {
				console.error('Request failed', status, error);
			}
		});
	}
</script>

</head>
<body onload="visitFindOne()">
	<jsp:include page="../../top_menu.jsp"></jsp:include>
	<jsp:include page="../mini_top_menu.jsp"></jsp:include>
	<h1>mini/visit/selectOne.jsp</h1>
	<div id="visitor_log"></div>
</body>
</html>