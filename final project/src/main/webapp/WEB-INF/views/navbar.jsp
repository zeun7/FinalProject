<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>

<nav class="navbar navbar-expand-lg navbar-absolute fixed-top navbar-transparent">
	<div class="container-fluid">
		<div class="navbar-wrapper">
			<div class="navbar-toggle">
				<button type="button" class="navbar-toggler">
					<span class="navbar-toggler-bar bar1"></span> <span
						class="navbar-toggler-bar bar2"></span> <span
						class="navbar-toggler-bar bar3"></span>
				</button>
			</div>
			<a class="navbar-brand" href="javascript:;">Paper Dashboard 2</a>
		</div>
		<button class="navbar-toggler" type="button" data-toggle="collapse"
			data-target="#navigation" aria-controls="navigation-index"
			aria-expanded="false" aria-label="Toggle navigation">
			<span class="navbar-toggler-bar navbar-kebab"></span> <span
				class="navbar-toggler-bar navbar-kebab"></span> <span
				class="navbar-toggler-bar navbar-kebab"></span>
		</button>
		<div class="collapse navbar-collapse justify-content-end"
			id="navigation">
			<ul class="navbar-nav">
				<li class="nav-item"><a href="login.do" id="login">
					<p>
						<span class="d-lg-none d-md-block">로그인</span>
					</p>
				</a></li>
				<li class="nav-item"><a href="m_selectOne.do?id=${user_id}" id="profile">
					<p>
						<span class="d-lg-none d-md-block">${nickname}</span>
					</p>
				</a></li>
				<li><a href="m_selectOne.do?id=${user_id}" id="myinfo">
					<p>
						<span class="d-lg-none d-md-block">${nickname}</span>
					</p>
				</a></li>
				<li class="nav-item"><a href="m_insert.do" id="m_insert">
					<p>
						<span class="d-lg-none d-md-block">회원가입</span>
					</p>
				</a></li>
				<li class="nav-item"><a href="logout.do" id="logout">
					<p>
						<span class="d-lg-none d-md-block">로그아웃</span>
					</p>
				</a></li>
			</ul>
		</div>
	</div>
</nav>