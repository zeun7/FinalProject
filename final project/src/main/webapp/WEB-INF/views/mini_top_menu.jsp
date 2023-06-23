<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<ul>
	<li><a href="mini_update.do?id=${user_id}">프로필 수정</a></li>
	<li><a href="">최신 게시글</a></li>
	<li><a href="mini_random.do">랜덤 미니홈피 가기</a></li>
</ul>
<ul>
	<li><a href="mini_home.do?id=${user_id}&nickname=${nickname}">홈</a></li>
	<li><a href="mini_diary.do?writer=${nickname}">다이어리</a></li>
	<li><a href="mini_visit.do?id=${user_id}">방명록</a></li>
	<li><a href="mini_gallery.do?writer=${nickname}">갤러리</a></li>
	<li><a href="mini_game.do?id=${user_id}">게임</a></li>
</ul>
<script type="text/javascript">
	if('${user_id}' === ''){	// 로그아웃 상태
		$('#logout').hide();
		$('#m_insert').show();
		$('#myinfo').hide();
		$('#login').show();
	}
	else{						// 로그인 상태
		$('#logout').show();
		$('#m_insert').hide();
		$('#myinfo').show();
		$('#login').hide();
	}
	
	if('${mclass}' === '1'){		// 관리자
		$('#manage').show();
	}
	else{						// 일반 유저
		$('#manage').hide();
	}
</script>