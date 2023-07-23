<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<link rel="stylesheet" href="resources/css/button2.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
<script type="text/javascript">
function buyPeach(){
	window.location.href="mini_peachPay.do?id=${user_id}";
}
</script>
<nav
	class="navbar navbar-expand-lg navbar-absolute fixed-top" style="background-color: rgba(255, 255, 255, 0.3);">
	<div class="container-fluid" style="z-index:10;">
		<div class="collapse navbar-collapse justify-content-end"
			id="navigation">
			<ul class="navbar-nav">
				<li class="nav-item" id="li_profilepic" style="padding-right: 10px">
					<a href="m_selectOne.do?id=${user_id}" style="font-color:#000;"
						class="simple-text logo-mini" id="profile">
						<div class="logo-image-small">
							<img src="resources/uploadimg/${profilepic}" width="35px" height="35px" style="border-radius: 50%;">
						</div> <!-- <p>CT</p> -->
					</a>
				</li>
				<li class="nav-item" id="li_login" style="display: flex; flex-wrap: wrap; align-content: center;"><a href="login.do" id="login" style="padding-right: 10px; color:#000;"> 로그인 </a></li>
				<li class="nav-item" id="li_profile" style="display: flex; flex-wrap: wrap; align-content: center;"><a href="m_selectOne.do?id=${user_id}" style="color:#000;"
					id="profile" style="padding-right: 10px"> ${nickname} </a></li>
				<li class="nav-item" id="li_insert" style="display: flex; flex-wrap: wrap; align-content: center;"><a href="m_insert.do" id="m_insert" style="padding-right: 10px; color:#000;">
						회원가입 </a></li>
				<li class="nav-item" id="li_peachCount" style="display: flex; flex-wrap: wrap; align-content: center;">
					<button onclick="buyPeach()" style="border:0px; border-radius: 10px; margin-right: 20px; background-color: rgba(255,255,255,0)">
						<img src="resources/icon/peach.png" style="width:15px; height:15px;"> Peach : ${myPeach}개
					</button>
				</li>
				<li class="nav-item" id="li_logout" style="display: flex; flex-wrap: wrap; align-content: center;"><a href="logout.do" id="logout" style="padding-right: 10px; color:#000;"> 로그아웃
				</a></li>
			</ul>
		</div>
	</div>
</nav>

<script type="text/javascript">
let sid = '';
sid = '${user_id}';

if(sid === ''){
	$('#li_profilepic').hide();
	$('#li_login').show();
	$('#li_profile').hide();
	$('#li_insert').show();
	$('#li_logout').hide();
	$('#li_peachCount').hide();
}else{
	$('#li_profilepic').show();
	$('#li_login').hide();
	$('#li_profile').show();
	$('#li_insert').hide();
	$('#li_logout').show();
}
</script>