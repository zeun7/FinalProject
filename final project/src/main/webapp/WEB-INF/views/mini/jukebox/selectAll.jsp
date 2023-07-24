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
  <link rel="stylesheet" href="resources/css/pagination.css">
  <link rel="stylesheet" href="resources/css/board_table.css">
  <link rel="stylesheet" href="resources/css/button2.css">
  <script src="https://kit.fontawesome.com/7ed6703c9d.js" crossorigin="anonymous"></script>
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
			let tag_pages = `<div class="paging-btn-container">`;
			
			while(result > 0){
				tag_page++;
				let activeClass = (tag_page === curPage) ? 'active' : '';
				tag_pages += `
					<button class="paging-btn \${activeClass}" onclick=selectAll(\${tag_page})>\${tag_page}</button>
				`;
				result -= 10;
			}
			tag_pages += `</div>`;
			
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
			
			// 모든 페이지 버튼에서 'active' 클래스를 제거합니다.
            const pageButtons = document.querySelectorAll('.paging-btn');
            pageButtons.forEach((btn) => btn.classList.remove('active'));

            // 현재 페이지 버튼에만 'active' 클래스를 추가합니다.
            pageButtons[page - 1].classList.add('active');
			
			for(let i in arr){
				let vo = arr[i];
				let date = moment(vo.jdate).format('YY/MM/DD HH시mm분ss초');
				console.log(vo);
				tag_vos +=`
					<tr>
					<td style="text-align:center;">\${vo.bgm}
					<span id="btn_\${i}"><btn class="btn btn-sm btn-round btn-icon" onclick="showMusicPlayer('btn_\${i}', '\${vo.bgm}')">
					<i class="nc-icon nc-headphones"></i></btn></span></td>
					<td style="text-align:center;">\${date}</td>
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
     <div class="main-panel" style="background-image: url('resources/uploadimg/${mh_attr.backimg}'); background-size:cover; background-repeat:no-repeat;">
    <jsp:include page="../../navbar.jsp"></jsp:include>
       <div class="content" style="height: 100%;">
        <div class="row">
          <div class="col-md-12">
            <div class="card">
              <div class="card-header">
              	<div style="text-align:center; font-family: Georgia; font-size: 20px; font-weight: bold;">
	                <h4 class="card-title"> 쥬크박스</h4>
              	</div>
              	<div style="display: flex; justify-content: flex-end;">
              		<div id="userPeach" class="btn btn-primary peach" style="border-radius: 10px; margin-right: 10px; background-color: rgb(247,150,192);">보유 peach : ${m_attr.peach}개</div>
	                <button onclick="buyPeach()" class="btn btn-primary" style="border-radius: 10px; margin-right: 10px;" id="peachButton">peach 결제하기</button>
	        		<button onclick="buyBGM()" class="btn btn-primary" style="border-radius: 10px;" id="bgmButton">음악 구매하기</button>
                </div>
              </div>
              <div class="card-body">
                <div class="table-responsive">
                  <table class="table">
                    <thead class=" text-primary" style="text-align:center;">
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
      <jsp:include page="../../footer.jsp"></jsp:include>
    </div>
  </div>

<script type="text/javascript">
	if('${user_id}' != '${mh_attr.id}'){	
	    $('#peachButton').hide();
	    $('#bgmButton').hide();
	    $('#userPeach').hide();
	}
</script>
</body>
</html>