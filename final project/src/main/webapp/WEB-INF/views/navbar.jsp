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
				<li class="nav-item" id="li_login" style="display: flex; flex-wrap: wrap; align-content: center;"><a href="login.do" id="login" style="padding-right: 10px"> �α��� </a></li>
				<li class="nav-item" id="li_profile" style="display: flex; flex-wrap: wrap; align-content: center;"><a href="m_selectOne.do?id=${user_id}"
					id="profile" style="padding-right: 10px"> ${nickname} </a></li>
				<li class="nav-item" id="li_insert" style="display: flex; flex-wrap: wrap; align-content: center;"><a href="m_insert.do" id="m_insert" style="padding-right: 10px">
						ȸ������ </a></li>
				<li class="nav-item" id="li_peachCount" style="display: flex; flex-wrap: wrap; align-content: center;">
					<button onclick="buyPeach()" class="btn-gradient purple mini" style="border-radius: 10px; background-color: rgb(247,150,192); margin-right: 20px;">
						My Peach : ${myPeach}��
					</button>
				</li>
				<li class="nav-item" id="li_logout" style="display: flex; flex-wrap: wrap; align-content: center;"><a href="logout.do" id="logout" style="padding-right: 10px"> �α׾ƿ�
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