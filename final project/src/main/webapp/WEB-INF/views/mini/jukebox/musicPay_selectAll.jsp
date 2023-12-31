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
    음악구매
  </title>
  <meta content='width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0, shrink-to-fit=no' name='viewport' />
  <!--     Fonts and icons     -->
  <link href="https://fonts.googleapis.com/css?family=Montserrat:400,700,200" rel="stylesheet" />
  <link href="https://maxcdn.bootstrapcdn.com/font-awesome/latest/css/font-awesome.min.css" rel="stylesheet">
  <!-- CSS Files -->
  <link href="resources/assets/css/bootstrap.min.css" rel="stylesheet" />
  <link href="resources/assets/css/paper-dashboard.css?v=2.0.1" rel="stylesheet" />
<script src="https://kit.fontawesome.com/7ed6703c9d.js" crossorigin="anonymous"></script>
<link rel="stylesheet" href="resources/css/pagination.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
<script type="text/javascript">
let page = 1;
let curPage = 1; 
let mh_attr_id = '${mh_attr.id}';

$(function(){	//이용자가 보유한 peach 개수 출력
	$.ajax({
		url : "json_peach_count.do",
		method : 'get',
		data : {
			id : '${user_id}'
		},
		dataType : 'json',
		success : function(vo){
			$('#peach').html(vo.peach);
		},
		error : function(xhr, status, error){
			console.log('xhr', xhr.status);
		}
	});//end ajax
});//end onlaod

function selectAllCount(){ // 음악 목록의 페이징 버튼 출력
	$.ajax({
		url : "json_musicPay_count.do",
		method : 'GET',
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
		url : "json_musicPay_selectAll.do",
		method : 'get',
		data : {
			page : page
		},
		dataType : 'json',
		success : function(arr){
			let tag_vos = '';
			for(let i in arr){
				let vo = arr[i];
				console.log(vo);
				tag_vos +=`
					<tr>
					<td>\${vo.bgm}</td>
					<td><span id="btn_\${i}"><btn class="btn btn-sm btn-round btn-icon" onclick="showMusicPlayer('btn_\${i}', '\${vo.bgm}')">
					<i class="nc-icon nc-headphones"></i></btn></span></td>
					<td><button onclick="jukebox_check('\${vo.bgm}')" class="btn btn-primary btn-round">구매하기</button></td>
		        	</tr>	
				`;
			}
			$("#vos").html(tag_vos);
			curPage = page;
		},
		error : function(xhr, status, error){
			console.log('xhr', xhr.status);
		}
	});//end ajax()
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

function jukebox_check(bgm){	//구매하려는 곡이 사용자의 보관함에 있는지 확인
	$.ajax({
		url : "json_jukebox_check.do",
		method : 'get',
		data : {
			id: '${user_id}',
			bgm: bgm
		},
		dataType : 'json',
		success : function(result){
			if(result == 1){
				alert('이미 구매한 곡입니다.');
			}else{
				gotoMusic_selectOne(bgm);
			}
		},
		error : function(xhr, status, error){
			console.log('xhr', xhr.status);
		}
	});//end ajax()
}//end jukebox_check()

function gotoMusic_selectOne(bgm){
	console.log(bgm);
	window.location.href="musicPay_selectOne.do?id=${user_id}&bgm="+bgm;
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
                <h4 class="card-title"> 음악 구매</h4>
              </div>
              <div class="card-body">
                <div class="table-responsive">
                  <table class="table">
                    <thead class=" text-primary">
                      <th>
                        노래제목
                      </th>
                      <th>
                        미리듣기
                      </th>
                      <th>
                        구매
                      </th>
                    </thead>
                    <tbody id="vos">
                    </tbody>
                    <tfoot>
						<tr><td colspan="3" id="page"></td></tr>
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
</body>
</html>