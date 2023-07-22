<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="utf-8" />
  <link rel="apple-touch-icon" sizes="76x76" href="resources/assets/img/apple-icon.png">
  <link rel="icon" type="image/png" href="resources/assets/img/favicon.png">
  <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
  <title>
    피치구매
  </title>
  <meta content='width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0, shrink-to-fit=no' name='viewport' />
  <!--     Fonts and icons     -->
  <link href="https://fonts.googleapis.com/css?family=Montserrat:400,700,200" rel="stylesheet" />
  <link href="https://maxcdn.bootstrapcdn.com/font-awesome/latest/css/font-awesome.min.css" rel="stylesheet">
  <!-- CSS Files -->
  <link href="resources/assets/css/bootstrap.min.css" rel="stylesheet" />
  <link href="resources/assets/css/paper-dashboard.css?v=2.0.1" rel="stylesheet" />
<script src="https://kit.fontawesome.com/7ed6703c9d.js" crossorigin="anonymous"></script>
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
			console.log(response);
			var url = response.next_redirect_pc_url;
			let name = '피치 결제';
			let options = 'width=500,height=500';
			var popup = window.open(url, name, options);

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

<body class="">
<jsp:include page="../mini_top_menu.jsp"></jsp:include>
  <div class="wrapper ">
    <div class="main-panel" style="background-image: url('resources/uploadimg/${mh_attr.backimg}'); background-size:cover; background-repeat:no-repeat;">
    <jsp:include page="../../navbar.jsp"></jsp:include>
      <div class="content" style="height: 100%;">
        <div class="row">
          <div class="col-md-12">
            <div class="card">
              <div class="card-header">
                 <h4 class="card-title" style="text-align: center;"> Peach 구매</h4>
              </div>
              <div class="card-body">
                <div class="table-responsive">
                <form action="mini_peachPayOK.do" method="post">
                  <table class="table">
                    <tr style="text-align: center;">
						<td>구매상품</td>
						<td>Peach</td>
					</tr>    	
					<tr>
						<td style="text-align: center;">구매수량 선택</td>
						<td style="text-align: center;">
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
						<td colspan="2" style="text-align: right; padding-right: 290px;">
							<button type="button" id="kakao_pay" class="btn btn-primary btn-round" onclick="payClick()">구매</button>
						</td>
					</tr>    	
                  </table>
                </form>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
      <jsp:include page="../../footer.jsp"></jsp:include>
    </div>
  </div>
</body>
</html>