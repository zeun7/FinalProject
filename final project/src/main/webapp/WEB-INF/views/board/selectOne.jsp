<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
<script type="text/javascript">
	function like(){
		$.ajax({
			url : "json_b_like.do",
			method : 'GET',
			data : {
				num : 2,
				bnum : ${param.bnum}
			},
			dataType : 'json', 
			success : function(map) {
// 	 			console.log(map.result);
				if(map.result == 1){
					$("#like_button").hide();
				}
			},
			error : function(xhr, status, error) {
				console.log('xhr:', xhr.status);
//				console.log('status:', status);
//				console.log('error:', error);
			}
		});//end $.ajax()
	}//end like()
</script>
</head>
<body>
	<jsp:include page="../top_menu.jsp"></jsp:include>
	<table>
		<thead>
			<tr>
				<td><h3>${vo2.title }</h3></td>
				<td>${vo2.writer }</td>
				<td>${vo2.vcount }</td>
			</tr>
			<tr><td>${vo2.wdate }</td></tr>
		</thead>
		<tbody>
			<tr><td colspan="3">${vo2.content }</td></tr>
		</tbody>
		<tfoot>
			<tr>
				<td>
					<button onclick="like()" id="like_button">좋아요</button>
				</td>
				<td>
					<a href="b_update.do?bnum=${vo2.bnum }">수정</a>
					<a href="b_deleteOK.do?bnum=${vo2.bnum }&bname=${vo2.bname}">삭제</a>
				</td>
			</tr>
		</tfoot>
	</table>

</body>
</html>