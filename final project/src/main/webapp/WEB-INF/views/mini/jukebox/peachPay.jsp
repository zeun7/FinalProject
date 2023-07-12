<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html>
<head>
<title>피치구매</title>
<jsp:include page="../../css.jsp"></jsp:include>
<script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
<script type="text/javascript" src="https://service.iamport.kr/js/iamport.payment-1.1.5.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
<script type="text/javascript">
let quantity = 5;
let price = 100;

function payClick(){
	console.log('payClick()');
	console.log(quantity * price);
	
	$.ajax({
		url: 'json_peachPay.do',
		dataType: 'json',
		data: {
			partner_user_id: '${user_id}',
			quantity: quantity,
			total_amount: quantity * price
		},
		method: 'GET',
		success: function(response){
			console.log(response.tid);
			var url = response.next_redirect_pc_url;
			window.location.href=url;
		},
		error : function(xhr, status, error) {
			console.log('xhr:', xhr.status);
		}
	});
}

function getQuantity(event){
	quantity = event.target.value;
}
</script>
</head>
<body>
    <jsp:include page="../../top_menu.jsp"></jsp:include>
    <h1>peachPay</h1>
    <form action="mini_peachPayOK.do" method="post">
    	<table>
			<tr>
				<td>구매상품</td>
				<td>피치</td>
			</tr>    	
			<tr>
				<td>구매수량 선택</td>
				<td>
					<input type="radio" id="quantity5" name="quantity" value="5" onclick="getQuantity(event)" checked="checked">
					<label for="quantity5">5개: 500원</label><br>
					<input type="radio" id="quantity10" name="quantity" value="10" onclick="getQuantity(event)">
					<label for="quantity10">10개: 1000원</label><br>
					<input type="radio" id="quantity30" name="quantity" value="30" onclick="getQuantity(event)">
					<label for="quantity30">30개: 3000원</label><br>
					<input type="radio" id="quantity50" name="quantity" value="50" onclick="getQuantity(event)">
					<label for="quantity50">50개: 5000원</label><br>
					<input type="radio" id="quantity100" name="quantity" value="100" onclick="getQuantity(event)">
					<label for="quantity100">100개: 10000원</label><br>
				</td>
			</tr>    	
			<tr>
				<td colspan="2"><button type="button" id="kakao_pay" onclick="payClick()">구매</button></td>
			</tr>    	
    	</table>
    </form>
    
</body>
</html>