<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<jsp:include page="../../css.jsp"></jsp:include>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
<script type="text/javascript">
let userPeach = 0;
let cost = 5;

$(function(){
	if('${param.bgm}' === 'default_bgm.mp3'){
		cost = 0;
	}
	$('#cost').html(cost);	
	
	$.ajax({	//이용자가 보유한 peach 개수 출력
		url : "json_peach_count.do",
		method : 'get',
		data : {
			id : '${user_id}'
		},
		dataType : 'json',
		success : function(vo){
			$('#peach').html(vo.peach);
			userPeach = vo.peach;
		},
		error : function(xhr, status, error){
			console.log('xhr', xhr.status);
		}
	});//end ajax
});//end onload

function buy_music(){
	if(userPeach - cost < 0){
		alert('peach가 부족합니다.');
	}else{
		$.ajax({
			url : "json_jukebox_insertOK.do",
			method : 'get',
			data : {
				id : '${user_id}',
				bgm: '${param.bgm}',
				peach: cost
			},
			dataType : 'json',
			success : function(result){
				if(result == 1){
					alert('구매 완료');
					window.location.href="mini_jukebox.do?id=${user_id}";
				}else{
					alert('구매에 실패하였습니다.');
				}
			},
			error : function(xhr, status, error){
				console.log('xhr', xhr.status);
			}
		});//end ajax
	}
}

function buyPeach(){
	window.location.href="mini_peachPay.do?id=${user_id}";
}
</script>
</head>
<body>
<h1>musicPay_selectOne</h1>
<table>
	<tr>
		<th>구매곡</th>
		<td>${param.bgm }</td>
	</tr>
	<tr>
		<th>보유 peach</th>
		<td id="peach"></td>
		<td><button onclick="buyPeach()">peach 충전</button></td>
	</tr>
	<tr>
		<th>차감 peach</th>
		<td id="cost"></td>
	</tr>
	<tr>
		<th>구매</th>
		<td><button onclick="buy_music()">구매하기</button></td>
	</tr>
</table>
</body>
</html>