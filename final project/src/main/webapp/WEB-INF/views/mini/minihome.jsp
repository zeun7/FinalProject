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

let mh_attr_id = '${mh_attr.id}';
console.log(mh_attr_id);
$(document).ready(function(){
    $.ajax({
        url: "json_mc_findAll.do",
        method: "get",
        data : {
			id : mh_attr_id
		},
        dataType: "json",
        success: function(data) {
            let visit_log = ``;
            $.each(data, function(index, miniComment){
                visit_log += `
                	<a href="visit_findOne.do?id=\${mh_attr_id}&mcnum=\${miniComment.mcnum}" style="border:3px solid white;"class="myButton" >
			        <h3>\${miniComment.writer}</h3>
			        <p>\${miniComment.content}</p>
			        <span>\${miniComment.cdate}</span></a>
			        `;
            });
            $('#visitors_log').html(visit_log);
        },
        error: function(request, status, error) {
            console.error('Request failed', status, error);
        }
    });
});

</script>
</head>
<body>
	<jsp:include page="../top_menu.jsp"></jsp:include>
	<jsp:include page="mini_top_menu.jsp"></jsp:include>
	<h1>mini/minihome.jsp</h1>
	<div
		style="background-image: url('resources/uploadimg/${mh_attr.backimg}'); background-size: cover; width: 100%; height: 100vh;">
		<h2>미니홈피 제목 : ${mh_attr.title}</h2>
		<select onchange="redirectToMiniHome(this)">
			<option>1촌목록</option>
			<c:forEach var="vo" items="${vos}">
				<option value="${vo.nickname2}">${vo.nickname2}</option>
			</c:forEach>
		</select>

		<h2>방명록...포스팃 형식으로</h2>
		<div id="visitors_log"></div>
	</div>
</body>
</html>