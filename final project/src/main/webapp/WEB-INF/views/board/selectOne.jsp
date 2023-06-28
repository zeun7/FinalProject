<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="resources/css/modal.css">
<jsp:include page="../css.jsp"></jsp:include>
<script src="https://t1.kakaocdn.net/kakao_js_sdk/2.2.0/kakao.min.js" integrity="sha384-x+WG2i7pOR+oWb6O5GV5f1KN2Ko6N7PTGPS7UlasYWNxZMKQA63Cj/B2lbUmUfuC" crossorigin="anonymous"></script>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
<script type="text/javascript">
let url = location.href;
let encodeUrl = encodeURIComponent(location.href)
console.log(encodeUrl);

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
	
	function share_twitter(){
		let option = "width = 500, height = 500";
		let name = "트위터로 공유";
	    window.open("http://twitter.com/share?url=" + encodeURIComponent(location.href) +"&text=" + encodeURIComponent(document.title), name, option);
	}//end share_twitter()
	
	function share_facebook(){
		let option = "width = 500, height = 500";
		let name = "페이스북으로 공유";
	    window.open("http://www.facebook.com/sharer.php?u=" + encodeURIComponent(location.href), name, option);
	}//end share_facebook()
	
	function copy_url(){
		navigator.clipboard.writeText(location.href).then(() => {
	        alert("복사완료");
	      });
	}
	
	$(function(){
		Kakao.init('8b87b1c63625a7c92d74e9e4019cc90f');
		if(Kakao.isInitialized()){
			Kakao.Share.createScrapButton({
			    container: '#kakaotalk-sharing-btn',
			    requestUrl: window.location.href
			});
		}
	});
	
</script>
</head>
<body>
	<jsp:include page="../top_menu.jsp"></jsp:include>
<!-- 	페이스북 공유 sdk -->
	<div id="fb-root"></div>
	<script async defer crossorigin="anonymous" src="https://connect.facebook.net/ko_KR/sdk.js#xfbml=1&version=v17.0" nonce="NOEk7uEg"></script>
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
					<hr>
					<img width="300px" src="${vo2.filepath}">
				</td>
			</tr>
			<tr>
<%-- 				<td colspan="3"><textarea rows="15" cols="30" readonly>${vo2.content }</textarea></td> --%>
				<td colspan="3"><div>${vo2.content }<hr></div></td>
			</tr>
		</tbody>
		<tfoot>
			<tr>
				<td>
					<button onclick="like()" id="like_button">좋아요</button>
					<button onclick="like_cancel()" id="lcancel_button">좋아요 취소</button>
					<span id="likes_count">${vo2.likes }</span>
					<button onclick="open_modal()">공유</button>					
					<button onclick="report()" id="report_button">신고</button>
				</td>
				<td id="update_delete"><a href="b_update.do?bnum=${vo2.bnum }">수정</a> <a
					href="b_deleteOK.do?bnum=${vo2.bnum }&bname=${vo2.bname}">삭제</a></td>
			</tr>
		</tfoot>
	</table>
	
	<div id="modal">
		<div class="modal-content">
			<h6>공유하기</h6>
			<button onclick="share_twitter()" id="share_button">트위터로 공유</button>
			<button onclick="share_facebook()" id="share_button">페이스북으로 공유</button>
			<button id="kakaotalk-sharing-btn">카카오톡으로 공유</button>
			<div>
				<label for="copy_url_btn" id="url"></label>			
				<button id="copy_url_btn" onclick="copy_url()">링크복사</button>
			</div>
			<div>
				<button onclick="close_modal()">닫기</button>
			</div>
		</div>
	</div>

	<script type="text/javascript">
		if('${nickname}' === '${vo2.writer}'){
			$('#update_delete').show();
		}else{
			$('#update_delete').hide();
		}
		
		$('#url').html(url);
		let modal = document.getElementById("modal");
		
		function open_modal(){
			modal.style.display = "block";
			document.body.style.overflow = "hidden"; // 스크롤바 제거
		}
		
		function close_modal(){
			modal.style.display = "none";
			document.body.style.overflow = "auto"; // 스크롤바
		}
	</script>
</body>
</html>