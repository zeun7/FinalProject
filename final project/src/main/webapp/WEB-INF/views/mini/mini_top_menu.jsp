<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>

<ul>
	<li><a href="mini_home.do?id=${mh_attr.id}">홈</a></li>
	<li><a href="mini_diary.do?id=${mh_attr.id}">다이어리</a></li>
	<li><a href="mini_visit.do?id=${mh_attr.id}">방명록</a></li>
	<li><a href="mini_gallery.do?id=${mh_attr.id}">사진첩</a></li>
	<li><a href="mini_game.do?id=${mh_attr.id}">게임</a></li>
</ul>
<div
	style="background-image: url('resources/uploadimg/profile_backimg_default.png'); background-size: auto; background-repeat: no-repeat; width: 100%; height: 100vh;">
	<div>
		<img src="resources/uploadimg/${m_attr.profilepic}">
	</div>
	<div id="mini_update">
		<a href="mini_update.do?id=${mh_attr.id}">미니홈피 수정</a>
	</div>
	<div>${mh_attr.message}</div>
	<div>
		<audio controls>
			<source src="resources/uploadbgm/${mh_attr.bgm}" type="audio/mp3">
		</audio>
	</div>
<!-- 		<div> -->
<%-- 			<iframe src="/music_player.jsp?id=${mh_attr.id}" style="width: 300px; height: 60px;"></iframe> --%>
<!-- 		</div> -->

	<div>vtoday : ${mh_attr.vtoday}</div>
	<div>vtotal : ${mh_attr.vtotal}</div>
	<div>
		<a href="">최신 게시글</a>
<%-- 		<a href="diary_selectOne.do?mbnum="+${newest.mbnum}>${newest.title}</a> --%>
<%-- 		<a href="gallery_selectOne.do?mbnum="+${newest2.mbnum}>${newest2.title}</a> --%>
	</div>
	<div>
		<a href="mini_random.do?id=${mh_attr.id}">랜덤 미니홈피 가기</a>
	</div>
	

	
</div>

<script type="text/javascript">
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
	}
</script>