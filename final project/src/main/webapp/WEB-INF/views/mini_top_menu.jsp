<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<ul>
	<li><a href="mini_home.do?id=${vo2.id}">홈</a></li>
	<li><a href="mini_diary.do?mbname=diary&writer=${vo3.nickname}">다이어리</a></li>
	<li><a href="mini_visit.do?id=${vo2.id}">방명록</a></li>
	<li><a href="mini_gallery.do?mbname=gallery&writer=${vo3.nickname}">갤러리</a></li>
	<li><a href="mini_game.do?id=${vo2.id}">게임</a></li>
</ul>
<div
	style="background-image: url('resources/uploadimg/profile_backimg_default.png'); background-size: auto; background-repeat: no-repeat; width: 100%; height: 100vh;">
	<div><img src="resources/uploadimg/${profilepic}"></div>
	<a href="mini_update.do?id=${user_id}">프로필 수정</a>
	<div>${message}</div>
	<div>
		<audio controls>
			<source src="resources/uploadbgm/${vo2.bgm}" type="audio/mp3">
		</audio>
	</div>
	<div>vtoday : ${vtoday}</div>
	<div>vtotal : ${vtotal}</div>
	<a href="">최신 게시글</a> <br>
	<a href="mini_random.do">랜덤 미니홈피 가기</a>
</div>


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