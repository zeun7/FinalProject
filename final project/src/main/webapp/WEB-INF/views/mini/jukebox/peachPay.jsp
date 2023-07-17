<!--
=========================================================
* Paper Dashboard 2 - v2.0.1
=========================================================

* Product Page: https://www.creative-tim.com/product/paper-dashboard-2
* Copyright 2020 Creative Tim (https://www.creative-tim.com)

Coded by www.creative-tim.com

 =========================================================

* The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
-->
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
			let name = '피치 결제';
			let options = 'width=500,height=500';
			var popup = window.open(url, name, options);

			popup.onunload=function (){
		        window.location.href="mini_jukebox.do?id=${user_id}";
		    }
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
    <div class="main-panel" style="background-image: url('resources/uploadimg/${mh_attr.backimg}')">
    <jsp:include page="../mini_navbar.jsp"></jsp:include>
      <div class="content" style="background-size: cover; width: 100%; height: 100vh;">
        <div class="row">
          <div class="col-md-12">
            <div class="card">
              <div class="card-header">
                <h4 class="card-title"> 피치 구매</h4>
              </div>
              <div class="card-body">
                <div class="table-responsive">
                <form action="mini_peachPayOK.do" method="post">
                  <table class="table">
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
						<td colspan="2"><button type="button" id="kakao_pay" class="btn btn-primary btn-round" onclick="payClick()">구매</button></td>
					</tr>    	
                  </table>
                </form>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
      <footer class="footer footer-black  footer-white ">
        <div class="container-fluid">
          <div class="row">
            <nav class="footer-nav">
              <ul>
                <li><a href="https://www.creative-tim.com" target="_blank">Creative Tim</a></li>
                <li><a href="https://www.creative-tim.com/blog" target="_blank">Blog</a></li>
                <li><a href="https://www.creative-tim.com/license" target="_blank">Licenses</a></li>
              </ul>
            </nav>
            <div class="credits ml-auto">
              <span class="copyright">
                © <script>
                  document.write(new Date().getFullYear())
                </script>, made with <i class="fa fa-heart heart"></i> by Creative Tim
              </span>
            </div>
          </div>
        </div>
      </footer>
    </div>
  </div>
  <!--   Core JS Files   -->
  <script src="resources/assets/js/core/jquery.min.js"></script>
  <script src="resources/assets/js/core/popper.min.js"></script>
  <script src="resources/assets/js/core/bootstrap.min.js"></script>
  <script src="resources/assets/js/plugins/perfect-scrollbar.jquery.min.js"></script>
  <!-- Control Center for Now Ui Dashboard: parallax effects, scripts for the example pages etc -->
  <script src="resources/assets/js/paper-dashboard.min.js?v=2.0.1" type="text/javascript"></script><!-- Paper Dashboard DEMO methods, don't include it in your project! -->
</body>

</html>