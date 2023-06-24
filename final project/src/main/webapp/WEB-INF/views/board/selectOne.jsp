<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<jsp:include page="../css.jsp"></jsp:include>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
<script type="text/javascript">
	$(function(){
		//사용자가 해당 글에 좋아요를 눌렀는지 확인하는 함수
		$.ajax({
			url : "json_b_likeCheck.do",
			method : 'GET',
			data : {
				num : ${num},
				bnum : ${param.bnum}
			},
			dataType : 'json', 
			success : function(map) {
// 	 			console.log(map.result);
				if(map.result == 0){		//좋아요를 안눌렀다면
					$("#like_button").show();
					$("#lcancel_button").hide();
				}else{
					$("#like_button").hide();
					$("#lcancel_button").show();
				}
			},
			error : function(xhr, status, error) {
				console.log('xhr:', xhr.status);
//				console.log('status:', status);
//				console.log('error:', error);
			}
		});//end $.ajax()
	});//end onload
	
	function like(){
		$.ajax({
			url : "json_b_like.do",
			method : 'GET',
			data : {
				num : ${num},
				bnum : ${param.bnum}
			},
			dataType : 'json', 
			success : function(map) {
// 	 			console.log(map.result);
				if(map.result == 1){
					$("#like_button").hide();
					$("#lcancel_button").show();
					$("#likes_count").text(map.likes);
				}
			},
			error : function(xhr, status, error) {
				console.log('xhr:', xhr.status);
//				console.log('status:', status);
//				console.log('error:', error);
			}
		});//end $.ajax()
	}//end like()
	
	function like_cancel(){
		$.ajax({
			url : "json_b_like_delete.do",
			method : 'GET',
			data : {
				num : ${num},
				bnum : ${param.bnum}
			},
			dataType : 'json', 
			success : function(map) {
// 	 			console.log(map.result);
				if(map.result == 1){
					$("#like_button").show();
					$("#lcancel_button").hide();
					$("#likes_count").text(map.likes);
				}
			},
			error : function(xhr, status, error) {
				console.log('xhr:', xhr.status);
//				console.log('status:', status);
//				console.log('error:', error);
			}
		});//end $.ajax()
	}//end dislike()
	
	function report(){
		let url = "b_report.do?bnum="+${vo2.bnum};
		let name = "신고하기";
		let option = "width = 500, height = 500";
		window.open(url, name, option);
	}//end report()
	
	function share(){
		
	}//end share()
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
			<tr>
				<td>${vo2.wdate }</td>
			</tr>
		</thead>
		<tbody>
			<tr>
				<td colspan="3">
					<img width="300px" src="${vo2.filepath}">
				</td>
			</tr>
			<tr>
				<td colspan="3"><textarea rows="15" cols="30" readonly>${vo2.content }</textarea></td>
			</tr>
		</tbody>
		<tfoot>
			<tr>
				<td>
					<button onclick="like()" id="like_button">좋아요</button>
					<button onclick="like_cancel()" id="lcancel_button">좋아요 취소</button>
					<span id="likes_count">${vo2.likes }</span>
<!-- 					<button onclick="share()" id="share_button">공유</button> -->
					<a class="twitter-share-button"
					  href="https://twitter.com/intent/tweet">
					Tweet</a>
					<button onclick="report()" id="report_button">신고</button>
				</td>
				<td id="update_delete"><a href="b_update.do?bnum=${vo2.bnum }">수정</a> <a
					href="b_deleteOK.do?bnum=${vo2.bnum }&bname=${vo2.bname}">삭제</a></td>
			</tr>
		</tfoot>
	</table>

	<script type="text/javascript">
		if('${nickname}' === '${vo2.writer}'){
			$('#update_delete').show();
		}else{
			$('#update_delete').hide();
		}
	</script>
</body>
</html>