<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
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
			<li><a href="mini_home.do?id=${user_id}"
				onclick="openMiniHomePage(event)"> <i class="nc-icon nc-album-2"></i>
					<p>미니홈피</p>
			</a></li>
			<li><a href="b_selectAll.do?bname=board01"> <i
					class="nc-icon nc-bulb-63"></i>
					<p>자유</p>
			</a></li>
			<li><a href="b_selectAll.do?bname=board02"> <i
					class="nc-icon nc-button-play"></i>
					<p>일상</p>
			</a></li>
			<li><a href="b_selectAll.do?bname=board03"> <i
					class="nc-icon nc-satisfied"></i>
					<p>유머</p>
			</a></li>
			<li><a href="b_selectAll.do?bname=board04"> <i
					class="nc-icon nc-diamond"></i>
					<p>엔터</p>
			</a></li>
			<li><a href="b_selectAll.do?bname=board05"> <i
					class="nc-icon nc-user-run"></i>
					<p>스포츠</p>
			</a></li>
			<li id="friendsList"><a href="m_friends.do"> <i class="nc-icon nc-single-02"></i>
					<p>친구목록</p>
			</a></li>
			<li id="manage"><a href="manage.do"><i class="nc-icon nc-settings"></i>
					<p>관리</p>
			</a></li>
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
		$('#friendsList').hide();
	} else { // 로그인 상태
		$('#logout').show();
		$('#m_insert').hide();
		$('#myinfo').show();
		$('#login').hide();
		$('#profile').show();
		$('#friendsList').show();
	}

	if ('${mclass}' === '1') { // 관리자
		$('#manage').show();
	} else { // 일반 유저
		$('#manage').hide();
	}

	function openMiniHomePage(event) {
		event.preventDefault(); // 기본 동작인 링크 이동을 중지합니다.
		let url = "mini_home.do?id=${user_id}";
		console.log(url);
		let name = '내 미니홈피';
		let options = 'width=1600,height=900,menubar=yes,toolbar=yes,location=yes,resizable=no';
		window.open(url, name, options);
	}
</script>

<!--   Core JS Files   -->
<script src="resources/assets/js/core/jquery.min.js"></script>
<script src="resources/assets/js/core/popper.min.js"></script>
<script src="resources/assets/js/core/bootstrap.min.js"></script>
<script src="resources/assets/js/plugins/perfect-scrollbar.jquery.min.js"></script>