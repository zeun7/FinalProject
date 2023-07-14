<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<link rel="apple-touch-icon" sizes="76x76" href="resources/assets/img/apple-icon.png">
<link rel="icon" type="image/png" href="resources/assets/img/favicon.png">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
<title>Paper Dashboard 2 by Creative Tim</title>
<meta content='width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0, shrink-to-fit=no' name='viewport' />
<!--     Fonts and icons     -->
<link href="https://fonts.googleapis.com/css?family=Montserrat:400,700,200" rel="stylesheet" />
<link href="https://maxcdn.bootstrapcdn.com/font-awesome/latest/css/font-awesome.min.css" rel="stylesheet">
<!-- CSS Files -->
<link href="resources/assets/css/bootstrap.min.css" rel="stylesheet" />
<link href="resources/assets/css/paper-dashboard.css?v=2.0.1" rel="stylesheet" />
<!-- CSS Just for demo purpose, don't include it in your project -->
<link href="resources/assets/demo/demo.css" rel="stylesheet" />

<div class="sidebar" data-color="white" data-active-color="danger">
	<div class="logo">
		<a href="home.do" class="simple-text logo-mini">
			<div class="logo-image-small">
				<img src="resources/assets/img/logo-small.png">
			</div> <!-- <p>CT</p> -->
		</a> <a href="home.do" class="simple-text logo-normal"> Ilchon <!-- <div class="logo-image-big">
            <img src="../assets/img/logo-big.png">
          </div> -->
		</a>
	</div>
	<div class="sidebar-wrapper">
		<ul class="nav">
			<li class="active "><a href="home.do"> <i
					class="nc-icon nc-bank"></i>
					<p>Home</p>
			</a></li>
			<li><a href="mini_home.do?id=${user_id}"
				onclick="openMiniHomePage(event)"> <i class="nc-icon nc-diamond"></i>
					<p>Minihome</p>
			</a></li>
			<li><a href="b_selectAll.do?bname=board1"> <i
					class="nc-icon nc-pin-3"></i>
					<p>board1</p>
			</a></li>
			<li><a href="b_selectAll.do?bname=board2"> <i
					class="nc-icon nc-bell-55"></i>
					<p>board2</p>
			</a></li>
			<li><a href="b_selectAll.do?bname=board3"> <i
					class="nc-icon nc-single-02"></i>
					<p>board3</p>
			</a></li>
			<li><a href="b_selectAll.do?bname=board4"> <i
					class="nc-icon nc-tile-56"></i>
					<p>board4</p>
			</a></li>
			<li><a href="b_selectAll.do?bname=board5"> <i
					class="nc-icon nc-caps-small"></i>
					<p>board5</p>
			</a></li>
			<li><a href="m_friends.do"> <i class="nc-icon nc-caps-small"></i>
					<p>친구목록</p>
			</a></li>
			<li id="manage"><a href="manage.do"> <i
					class="nc-icon nc-caps-small"></i>
					<p>관리</p>
			</a></li>
			<li><a href="dashboard.do"> <i class="nc-icon nc-caps-small"></i>
					<p>대시보드</p>
			</a></li>
			<li class="active-pro">
				<div class="logo">
					<a href="m_selectOne.do?id=${user_id}"
						class="simple-text logo-mini" id="profile">
						<div class="logo-image-small">
							<img src="resources/assets/img/logo-small.png">
						</div> <!-- <p>CT</p> -->
					</a> <a href="m_selectOne.do?id=${user_id}"
						class="simple-text logo-normal" id="myinfo"> Ilchon <!-- <div class="logo-image-big">
		            <img src="../assets/img/logo-big.png">
		          	</div> -->
					</a> <a href="logout.do" class="simple-text logo-normal" id="logout">
						로그아웃 </a> <a href="login.do" class="simple-text logo-normal"
						id="login"> 로그인 </a> <a href="m_insert.do"
						class="simple-text logo-normal" id="m_insert"> 회원가입 </a>
				</div>
			</li>
		</ul>
	</div>
</div>

<script type="text/javascript">
	if ('${user_id}' === '') { // 로그아웃 상태
		$('#logout').hide();
		$('#m_insert').show();
		$('#myinfo').hide();
		$('#login').show();
		$('#profile').hide();
	} else { // 로그인 상태
		$('#logout').show();
		$('#m_insert').hide();
		$('#myinfo').show();
		$('#login').hide();
		$('#profile').show();
	}

	if ('${mclass}' === '1') { // 관리자
		$('#manage').show();
	} else { // 일반 유저
		$('#manage').hide();
	}

	function openMiniHomePage(event) {
		event.preventDefault(); // 기본 동작인 링크 이동을 중지합니다.
		let url = event.target.href;
		let name = '내 미니홈피';
		let options = 'width=1600,height=900,menubar=yes,toolbar=yes,location=yes,resizable=no';
		window.open(url, name, options);
	}
</script>