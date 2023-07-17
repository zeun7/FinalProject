<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
    <div class="sidebar" data-color="white" data-active-color="danger" style="overflow: auto">
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
  <script>
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