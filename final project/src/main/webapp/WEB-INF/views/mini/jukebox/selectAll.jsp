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
    쥬크박스
  </title>
  <meta content='width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0, shrink-to-fit=no' name='viewport' />
  <!--     Fonts and icons     -->
  <link href="https://fonts.googleapis.com/css?family=Montserrat:400,700,200" rel="stylesheet" />
  <link href="https://maxcdn.bootstrapcdn.com/font-awesome/latest/css/font-awesome.min.css" rel="stylesheet">
  <!-- CSS Files -->
  <link href="resources/assets/css/bootstrap.min.css" rel="stylesheet" />
  <link href="resources/assets/css/paper-dashboard.css?v=2.0.1" rel="stylesheet" />

<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.4/moment-with-locales.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
<script type="text/javascript">
let page = 1;
let curPage = 1; 
let mh_attr_id = '${mh_attr.id}';
function selectAllCount(){ // 음악 목록의 페이징 버튼 출력
	$.ajax({
		url : "json_j_count.do",
		method : 'GET',
		data : {
			id : mh_attr_id
		},
		dataType : 'json',
		success : function(result){
			let tag_page = 0;
			let tag_pages = '';
			
			while(result > 0){
				tag_page++;
				tag_pages += `
					<button onclick=selectAll(\${tag_page})>\${tag_page}</button>
				`;
				result -= 10;
			}
			
			if(curPage > tag_page){
				curPage = tag_page;
			}
			selectAll(curPage);
			
			$("#page").html(tag_pages);
		},
		error : function(xhr, status, error){
			console.log('xhr:',xhr.status);
		}
	});//end $.ajax()
}//end selectAllCount()

function selectAll(page){
	$.ajax({
		url : "json_j_selectAll.do",
		method : 'get',
		data : {
			id : mh_attr_id,
			page : page
		},
		dataType : 'json',
		success : function(arr){
			let tag_vos = '';
			for(let i in arr){
				let vo = arr[i];
				let date = moment(vo.jdate).format('YY/MM/DD HH시mm분ss초');
				console.log(vo);
				tag_vos +=`
					<tr>
					<td>\${vo.bgm}
					<span id="btn_\${i}"><btn class="btn btn-sm btn-outline-success btn-round btn-icon" onclick="showMusicPlayer('btn_\${i}', '\${vo.bgm}')">
					<i class="nc-icon nc-headphones"></i></btn></span></td>
					<td>\${date}</td>
		        	</tr>	
				`;
			}
			$("#vos").html(tag_vos);
			curPage = page;
		},
		error : function(xhr, status, error){
			console.log('xhr', xhr.status);
		}
	});//end $.ajax()
}//end selectAll()

function showMusicPlayer(btn_id ,bgm){
    console.log(bgm);
    let audio=`
        <audio controls autoplay>
            <source src="resources/uploadbgm/\${bgm}" type="audio/mp3">
        </audio>
    `;
    $("#"+btn_id).html(audio);
}

function buyPeach(){
	window.location.href="mini_peachPay.do?id=${mh_attr.id}";
}

function buyBGM(){
	window.location.href="musicPay_selectAll.do?id=${mh_attr.id}";
}
</script>
</head>

<body class="" onload="selectAllCount()">
<jsp:include page="../mini_top_menu.jsp"></jsp:include>
  <div class="wrapper ">
    <div class="main-panel" style="background-image: url('resources/uploadimg/${mh_attr.backimg}')">
    <jsp:include page="../mini_navbar.jsp"></jsp:include>
      <div class="content" style="background-size: cover; width: 100%; height: 100vh;">
        <div class="row">
          <div class="col-md-12">
            <div class="card card-plain">
              <div class="card-header">
                <h4 class="card-title"> 쥬크박스</h4>
                <button onclick="buyPeach()" class="btn btn-primary btn-round" id="peachButton">peach 결제하기</button>
        		<button onclick="buyBGM()" class="btn btn-primary btn-round" id="bgmButton">음악 구매하기</button>
              </div>
              <div class="card-body">
                <div class="table-responsive">
                  <table class="table">
                    <thead class=" text-primary">
                      <th>
                        보유 음악
                      </th>
                      <th>
                        구매 일자
                      </th>
                    </thead>
                    <tbody id="vos">
                    </tbody>
                    <tfoot>
		        		<tr>
		        			<td colspan="2" id="page"></td>
		        		</tr>
		        	</tfoot>
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

<script type="text/javascript">
	if('${user_id}' != '${mh_attr.id}'){	
	    $('#peachButton').hide();
	    $('#bgmButton').hide();
	}
</script>
</body>

</html>