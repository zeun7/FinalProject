<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>selectOne</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
<script src="http://code.jquery.com/jquery-latest.js"></script>
<script>
	$(function() {

		$("#upatefrom").click(function() {
			location.href = 'm_update.do?id=${vo2.id}';
		});
	});
	</script>
</head>
<body>
<jsp:include page="../sidebar.jsp"></jsp:include>
<jsp:include page="../navbar.jsp"></jsp:include>
<div class="wrapper ">
	<div class="main-panel">		
		<div class="content">
			<div class="row">
			
				<!-- 왼쪽 카드 프로필, 팀멤버 카드 -->
				<div class="col-md-4">
				
					<!--  프로필 이미지, 닉네임 등등  -->
					<div class="card card-user">
						<div class="image">
							<img src="resources/assets/img/damir-bosnjak.jpg" alt="...">
						</div>
						<div class="card-body">
							<div class="author">
								<img class="avatar border-gray" src="resources/uploadimg/${vo2.profilepic}">
								<h5 class="title">${vo2.nickname}</h5>
								<p class="description">${vo2.id}</p>
							</div>
					
						</div>
						<div class="card-footer">
							<hr>
							<div class="button-container">
								<div class="row">
									<div class="col-lg-3 col-md-6 col-6 ml-auto">
										
									</div>
									<div class="col-lg-4 col-md-6 col-6 ml-auto mr-auto">
										
									</div>
									<div class="col-lg-3 mr-auto">
									
									</div>
								</div>
							</div>
						</div>
					</div> 
				</div>
				
				<!-- 회원정보 수정 카드 -->
				<div class="col-md-8">
					<div class="card card-user">
						<div class="card-header">
							<h5 class="card-title">회원정보</h5>
						</div>
						<div class="card-body">
							<form>
								<div class="row">
									<div class="col-md-5 pr-1">
										<div class="form-group">
											<label>ID</label> <div class="form-control">${vo2.id}</div>
										</div>
									</div>
									<div class="col-md-6 pr-1">
										<div class="form-group">
											<label>닉네임</label>
											<div class="form-control">${vo2.nickname}</div>
										</div>
									</div>
								</div>
								<div class="row">
									<div class="col-md-6 pr-1">
										<div class="form-group">
											<label>이름</label>
											<div class="form-control">${vo2.name}</div>
										</div>
									</div>
								</div>
								<div class="row">
									<div class="col-md-4 pr-1">
										<div class="form-group">
											<label>전화번호</label>
											<div class="form-control">${vo2.tel}</div>
										</div>
									</div>
									<div class="col-md-7 pr-1">
										<div class="form-group">
											<label>이메일</label>
											<div class="form-control">${vo2.email}</div>
										</div>
									</div>
								</div>
								<div class="row">
									<div class="col-md-11 pr-1">
										<div class="form-group">
											<label>회원정보 확인 질문</label>
											<div class="form-control">${vo2.question}</div>
										</div>
									</div>
								</div>
								<div class="row">
									<div class="col-md-11 pr-1">
										<div class="form-group">
											<label>회원정보 확인 답변</label>
											<div class="form-control">${vo2.answer}</div>
										</div>
									</div>
								</div>
								<div class="row">
									<div class="update ml-auto mr-auto">
										<button id="upatefrom"type="button"class="btn btn-primary btn-round"  style="background-color: #94b5e0">회원수정</button>
									</div>
								</div>
							</form>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
</body>
</html>