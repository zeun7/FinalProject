<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
  <script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
<link href="resources/css/icon.css" rel="stylesheet" />
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
    <div class="sidebar" data-color="white" data-active-color="danger" style="overflow: auto">
      <div class="logo">
          <div>
            <img src="resources/uploadimg/${m_attr.profilepic}">
          </div>
          <!-- <p>CT</p> -->
          <div style="text-align:center;">
	          <div>${m_attr.nickname}</div>
	          <div id="mini_update">
				<a href="mini_update.do?id=${mh_attr.id}" class=" text-primary">미니홈피 수정</a>
				</div>
				<div>${mh_attr.message}</div>
				<div>
					<audio controls style="width: 230px">
						<source src="resources/uploadbgm/${mh_attr.bgm}" type="audio/mp3">
					</audio>
				</div>
				<div>TODAY : ${mh_attr.vtoday}</div>
				<div id="vtotal">TOTAL : ${mh_attr.vtotal}</div>
				<br>
				<div>
					<button onclick="goToNewestDiary()" style="border: 0; background: white;" class=" text-primary">최신 다이어리</button>
					<button onclick="goToNewestGallery()" style="border: 0; background: white;" class=" text-primary">최신 사진</button>
				</div>
				<div>
					<a href="mini_random.do?id=${mh_attr.id}" class="btn btn-primary btn-block" style="border-radius: 10px;">랜덤 미니홈피 가기</a>
				</div>
				<div>
					<a href="mini_home.do?id=${user_id}" class="btn btn-primary btn-block" style="border-radius: 10px;">My 미니홈피</a>
				</div>
			</div>
      </div>
      <div class="sidebar-wrapper">
        <ul class="nav">
          <li id="li_home" class="side_list">
            <a href="mini_home.do?id=${mh_attr.id}" onclick="changeActive('li_home')" style="display:flex;">
              <img src="resources/icon/miniHome_icon.png" class="side_icon nc-icon">
              <p class="side_menu">홈</p>
            </a>
          </li>
          <li id="li_diary" class="side_list">
            <a href="mini_diary.do?id=${mh_attr.id}" onclick="changeActive('li_diary')" style="display:flex;">
             <img src="resources/icon/diary_icon.png" class="side_icon nc-icon">
              <p class="side_menu">다이어리</p>
            </a>
          </li>
          <li id="li_visit" class="side_list">
            <a href="mini_visit.do?id=${mh_attr.id}" onclick="changeActive('li_visit')" style="display:flex;">
            <img src="resources/icon/visit_icon.png" class="side_icon nc-icon">
              <p class="side_menu">방명록</p>
            </a>
          </li>
          <li id="li_gallery" class="side_list">
            <a href="mini_gallery.do?id=${mh_attr.id}" onclick="changeActive('li_gallery')" style="display:flex;">
              <img src="resources/icon/gallery_icon.png" class="side_icon nc-icon">
              <p class="side_menu">사진첩</p>
            </a>
          </li>
          <li id="li_game" class="side_list">
            <a href="mini_game.do?id=${mh_attr.id}" onclick="changeActive('li_game')" style="display:flex;">
              <img src="resources/icon/game_icon.png" class="side_icon nc-icon">
              <p class="side_menu">게임</p>
            </a>
          </li>
          <li id="li_jukebox" class="side_list">
            <a href="mini_jukebox.do?id=${mh_attr.id}" onclick="changeActive('li_jukebox')" style="display:flex;">
              <img src="resources/icon/jukebox_icon.png" class="side_icon nc-icon">
              <p class="side_menu">쥬크박스</p>
            </a>
          </li>
        </ul>
      </div>
    </div>
  <script>
	// 다른 사람의 미니홈피 방문시 다이어리 작성 버튼 숨김
	if ('${user_id}' != '${mh_attr.id}') {
		$('#mini_update').hide();
		$('#jukebox').hide();
		$('#vtotal').hide();
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