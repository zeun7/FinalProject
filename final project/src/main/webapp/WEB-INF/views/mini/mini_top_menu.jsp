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
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

  <meta charset="utf-8" />
  <link rel="apple-touch-icon" sizes="76x76" href="resources/assets/img/apple-icon.png">
  <link rel="icon" type="image/png" href="resources/assets/img/favicon.png">
  <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
  <meta content='width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0, shrink-to-fit=no' name='viewport' />
  <!--     Fonts and icons     -->
  <link href="https://fonts.googleapis.com/css?family=Montserrat:400,700,200" rel="stylesheet" />
  <link href="https://maxcdn.bootstrapcdn.com/font-awesome/latest/css/font-awesome.min.css" rel="stylesheet">
  <!-- CSS Files -->
  <link href="resources/assets/css/bootstrap.min.css" rel="stylesheet" />
  <link href="resources/assets/css/paper-dashboard.css?v=2.0.1" rel="stylesheet" />
  <script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
  <script type="text/javascript">
  	function goToNewestDiary(){
		$.ajax({
			url : "newest_diary.do",
			method : 'GET',
			data : {
				mbname : 'diary',
				writer : '${m_attr.nickname}'
			},
			dataType : 'json',
			success: function(response) {
				console.log(response);
				if(response.mbnum == 0) {
	                alert("최신 게시글이 없습니다.");
	            } else {
	                window.location.href = "diary_selectOne.do?id=${m_attr.id}&mbnum=" + response.mbnum;
	            }
			},
			error: function(jqXHR, textStatus, errorThrown) {
	            console.error(textStatus, errorThrown);
	        }
		});
		
	}
	function goToNewestGallery(){
		$.ajax({
			url : "newest_gallery.do",
			method : "GET",
			data : {
				mbname : 'gallery',
				writer : '${m_attr.nickname}'
			},
			dataType : 'json',
			success : function(response) {
				if(response.mbnum == 0){
					alert("최신 게시글이 없습니다.");
				} else {
					window.location.href = "gallery_selectOne.do?id=${m_attr.id}&mbnum=" + response.mbnum;
				}
			},
			error : function(jqXHR,textStatus, errorThrown){
				console.error(textStatus, errorThrown);
			}
		});
	}
  </script>
    <div class="sidebar" data-color="white" data-active-color="danger">
      <div class="logo">
          <div>
            <img src="resources/uploadimg/${m_attr.profilepic}">
          </div>
          <!-- <p>CT</p> -->
          <div>${mh_attr.id}</div>
          <div id="mini_update">
			<a href="mini_update.do?id=${mh_attr.id}">미니홈피 수정</a>
			</div>
			<div>${mh_attr.message}</div>
			<div>
				<audio controls style="width: 230px">
					<source src="resources/uploadbgm/${mh_attr.bgm}" type="audio/mp3">
				</audio>
			</div>
			<div>vtoday : ${mh_attr.vtoday}</div>
			<div>vtotal : ${mh_attr.vtotal}</div>
			<div>
				<button onclick="goToNewestDiary()">최신 다이어리</button>
				<button onclick="goToNewestGallery()">최신 사진</button>
			</div>
			<div>
				<a href="mini_random.do?id=${mh_attr.id}">랜덤 미니홈피 가기</a>
			</div>
      </div>
      <div class="sidebar-wrapper">
        <ul class="nav">
          <li id="li_home">
            <a href="mini_home.do?id=${mh_attr.id}" onclick="changeActive('li_home')">
              <i class="nc-icon nc-bank"></i>
              <p>홈</p>
            </a>
          </li>
          <li id="li_diary" >
            <a href="mini_diary.do?id=${mh_attr.id}" onclick="changeActive('li_diary')">
              <i class="nc-icon nc-single-copy-04"></i>
              <p>다이어리</p>
            </a>
          </li>
          <li id="li_visit" >
            <a href="mini_visit.do?id=${mh_attr.id}" onclick="changeActive('li_visit')">
              <i class="nc-icon nc-book-bookmark"></i>
              <p>방명록</p>
            </a>
          </li>
          <li id="li_gallery" >
            <a href="mini_gallery.do?id=${mh_attr.id}" onclick="changeActive('li_gallery')">
              <i class="nc-icon nc-album-2"></i>
              <p>사진첩</p>
            </a>
          </li>
          <li id="li_game" >
            <a href="mini_game.do?id=${mh_attr.id}" onclick="changeActive('li_game')">
              <i class="nc-icon nc-controller-modern"></i>
              <p>게임</p>
            </a>
          </li>
          <li id="li_jukebox" >
            <a href="mini_jukebox.do?id=${mh_attr.id}" onclick="changeActive('li_jukebox')">
              <i class="nc-icon nc-note-03"></i>
              <p>쥬크박스</p>
            </a>
          </li>
        </ul>
      </div>
    </div>
    <div class="main-panel">
    <!-- Navbar -->
      <nav class="navbar navbar-expand-lg navbar-absolute fixed-top navbar-transparent">
        <div class="container-fluid">
          <div class="navbar-wrapper">
            <div class="navbar-toggle">
              <button type="button" class="navbar-toggler">
                <span class="navbar-toggler-bar bar1"></span>
                <span class="navbar-toggler-bar bar2"></span>
                <span class="navbar-toggler-bar bar3"></span>
              </button>
            </div>
            <a class="navbar-brand" href="javascript:;">Paper Dashboard 2</a>
          </div>
          <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navigation" aria-controls="navigation-index" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-bar navbar-kebab"></span>
            <span class="navbar-toggler-bar navbar-kebab"></span>
            <span class="navbar-toggler-bar navbar-kebab"></span>
          </button>
          <div class="collapse navbar-collapse justify-content-end" id="navigation">
            <form>
              <div class="input-group no-border">
                <input type="text" value="" class="form-control" placeholder="Search...">
                <div class="input-group-append">
                  <div class="input-group-text">
                    <i class="nc-icon nc-zoom-split"></i>
                  </div>
                </div>
              </div>
            </form>
            <ul class="navbar-nav">
              <li class="nav-item">
                <a class="nav-link btn-magnify" href="javascript:;">
                  <i class="nc-icon nc-layout-11"></i>
                  <p>
                    <span class="d-lg-none d-md-block">Stats</span>
                  </p>
                </a>
              </li>
              <li class="nav-item btn-rotate dropdown">
                <a class="nav-link dropdown-toggle" href="http://example.com" id="navbarDropdownMenuLink" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                  <i class="nc-icon nc-bell-55"></i>
                  <p>
                    <span class="d-lg-none d-md-block">Some Actions</span>
                  </p>
                </a>
                <div class="dropdown-menu dropdown-menu-right" aria-labelledby="navbarDropdownMenuLink">
                  <a class="dropdown-item" href="#">Action</a>
                  <a class="dropdown-item" href="#">Another action</a>
                  <a class="dropdown-item" href="#">Something else here</a>
                </div>
              </li>
              <li class="nav-item">
                <a class="nav-link btn-rotate" href="javascript:;">
                  <i class="nc-icon nc-settings-gear-65"></i>
                  <p>
                    <span class="d-lg-none d-md-block">Account</span>
                  </p>
                </a>
              </li>
            </ul>
          </div>
        </div>
      </nav>
      <!-- End Navbar -->
      </div>
  <!--   Core JS Files   -->
  <script src="resources/assets/js/core/jquery.min.js"></script>
  <script src="resources/assets/js/core/popper.min.js"></script>
  <script src="resources/assets/js/core/bootstrap.min.js"></script>
  <script src="resources/assets/js/plugins/perfect-scrollbar.jquery.min.js"></script>
  <!--  Notifications Plugin    -->
  <script src="resources/assets/js/plugins/bootstrap-notify.js"></script>
  <!-- Control Center for Now Ui Dashboard: parallax effects, scripts for the example pages etc -->
  <script src="resources/assets/js/paper-dashboard.min.js?v=2.0.1" type="text/javascript"></script><!-- Paper Dashboard DEMO methods, don't include it in your project! -->
  <script>
  	if ('${user_id}' === '') { // 로그아웃 상태
		$('#logout').hide();
		$('#m_insert').show();
		$('#myinfo').hide();
		$('#login').show();
	} else { // 로그인 상태
		$('#logout').show();
		$('#m_insert').hide();
		$('#myinfo').show();
		$('#login').hide();
	}

	if ('${mclass}' === '1') { // 관리자
		$('#manage').show();
	} else { // 일반 유저
		$('#manage').hide();
	}

	// 다른 사람의 미니홈피 방문시 다이어리 작성 버튼 숨김
	if ('${user_id}' != '${mh_attr.id}') {
		$('#mini_update').hide();
		$('#jukebox').hide();
	}
	
	//li태그의 active 클래스 바꾸는 함수
	function changeActive(id){
		$('#li_home').addClass("");
		$('#li_diary').addClass("");
		$('#li_visit').addClass("");
		$('#li_gallery').addClass("");
		$('#li_game').addClass("");
		$('#li_jukebox').addClass("");
		$('#'+id).addClass("active ");
	}
  </script>