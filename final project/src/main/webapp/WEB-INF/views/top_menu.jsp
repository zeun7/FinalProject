<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<ol>
	<li><a href="logout.do" id="logout">로그아웃</a></li>
	<li><a href="m_insert.do" id="m_insert">회원가입</a>
	<li><a href="m_selectOne.do?num=${num}" id="myinfo">내정보</a>
	<li><a href="login.do" id="login">로그인</a></li>
</ol>

<ul>
	<li><a href="home.do">HOME</a></li>
	<li><a href="mini_home.do?id=tester1">미니홈피</a></li>
	<li><a href="b_selectAll.do?bname=board1">게시판1</a></li>
	<li><a href="b_selectAll.do?bname=">게시판2</a></li>
	<li><a href="b_selectAll.do?bname=">게시판3</a></li>
	<li><a href="b_selectAll.do?bname=">게시판4</a></li>
	<li><a href="b_selectAll.do?bname=">게시판5</a></li>
	<li><a href="m_friends.do">친구목록</a></li>
	<li><a href="manage.do" id="manage">관리</a></li>
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