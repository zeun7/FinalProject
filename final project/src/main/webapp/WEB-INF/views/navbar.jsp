<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>

<nav
	class="navbar navbar-expand-lg navbar-absolute fixed-top navbar-transparent">
	<div class="container-fluid">
		<div class="collapse navbar-collapse justify-content-end"
			id="navigation">
			<ul class="navbar-nav">
				<li class="nav-item" id="li_profilepic" style="padding-right: 10px">
					<a href="m_selectOne.do?id=${user_id}"
						class="simple-text logo-mini" id="profile">
						<div class="logo-image-small">
							<img src="resources/uploadimg/${profilepic}" width="35px" height="35px" style="border-radius: 50%;">
						</div> <!-- <p>CT</p> -->
					</a>
				</li>
				<li class="nav-item" id="li_login" style="display: flex; flex-wrap: wrap; align-content: center;"><a href="login.do" id="login" style="padding-right: 10px"> 로그인 </a></li>
				<li class="nav-item" id="li_profile" style="display: flex; flex-wrap: wrap; align-content: center;"><a href="m_selectOne.do?id=${user_id}"
					id="profile" style="padding-right: 10px"> ${nickname} </a></li>
				<li class="nav-item" id="li_insert" style="display: flex; flex-wrap: wrap; align-content: center;"><a href="m_insert.do" id="m_insert" style="padding-right: 10px">
						회원가입 </a></li>
				<li class="nav-item" id="li_logout" style="display: flex; flex-wrap: wrap; align-content: center;"><a href="logout.do" id="logout" style="padding-right: 10px"> 로그아웃
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
}else{
	$('#li_profilepic').show();
	$('#li_login').hide();
	$('#li_profile').show();
	$('#li_insert').hide();
	$('#li_logout').show();
}
</script>