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
    다이어리
  </title>
  <meta content='width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0, shrink-to-fit=no' name='viewport' />
  <!--     Fonts and icons     -->
  <link href="https://fonts.googleapis.com/css?family=Montserrat:400,700,200" rel="stylesheet" />
  <link href="https://maxcdn.bootstrapcdn.com/font-awesome/latest/css/font-awesome.min.css" rel="stylesheet">
  <!-- CSS Files -->
  <link href="resources/assets/css/bootstrap.min.css" rel="stylesheet" />
  <link href="resources/assets/css/paper-dashboard.css?v=2.0.1" rel="stylesheet" />

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
                <h4 class="card-title"> 음악 구매</h4>
                <button onclick="buyPeach()" class="btn btn-primary btn-round">peach 충전</button>
              </div>
              <div class="card-body">
                <div class="">
                  <table class="table">
                    <tr>
						<th class=" text-primary">구매곡</th>
						<td>${param.bgm }</td>
					</tr>
					<tr>
						<th class=" text-primary">보유 peach</th>
						<td id="peach"></td>
					</tr>
					<tr>
						<th class=" text-primary">차감 peach</th>
						<td id="cost"></td>
					</tr>
					<tr>
						<th class=" text-primary">구매</th>
						<td><button onclick="buy_music()" class="btn btn-primary btn-round">구매하기</button></td>
					</tr>
                  </table>
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