<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="utf-8" />
  <link rel="apple-touch-icon" sizes="76x76" href="resources/assets/img/apple-icon.png">
  <link rel="icon" type="image/png" href="resources/assets/img/favicon.png">
  <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
  <title>
    방명록 작성
  </title>
  <meta content='width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0, shrink-to-fit=no' name='viewport' />
  <!--     Fonts and icons     -->
  <link href="https://fonts.googleapis.com/css?family=Montserrat:400,700,200" rel="stylesheet" />
  <link href="https://maxcdn.bootstrapcdn.com/font-awesome/latest/css/font-awesome.min.css" rel="stylesheet">
  <!-- CSS Files -->
  <link href="resources/assets/css/bootstrap.min.css" rel="stylesheet" />
  <link href="resources/assets/css/paper-dashboard.css?v=2.0.1" rel="stylesheet" />

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
<script type="text/javascript">
function input_check(){
	oEditors.getById["content"].exec("UPDATE_CONTENTS_FIELD", []);
	console.log($("#content").val());
	
	if($("#content").val() === '<p>&nbsp;</p>' || $("#content").val() === ''){
		alert('내용을 입력하세요');
	}else{
		document.getElementById("insert_form").submit();
	}
}
</script>
</head>

<body class="">
<jsp:include page="../mini_top_menu.jsp"></jsp:include>
  <div class="wrapper ">
    <div class="main-panel" style="background-image: url('resources/uploadimg/${mh_attr.backimg}'); background-size:cover; background-repeat:no-repeat;">
    <jsp:include page="../mini_navbar.jsp"></jsp:include>
      <div class="content" style="height: 90vh;">
        <div class="row">
          <div class="col-md-12">
            <div class="card">
              <div class="card-header">
                <h4 class="card-title"> 방명록</h4>
              </div>
              <div class="card-body">
              	<form action="visit_insertOK.do?id=${mh_attr.id}" method="post" id="insert_form">
			<!-- 	mcnum, cdate은 DAOimpl에서 추가 -->
					<div>
						<input type="hidden" id="mccnum" name="mccnum" value="0">
					</div>
					<div>
						<input type="hidden" id="mbnum" name="mbnum" value="0">
					</div>
			<!-- 		<div> -->
			<!-- 			<input type="hidden" id="id" name="id" -->
			<%-- 				value="${mh_attr.id}"> --%>
			<!-- 		</div> -->
					<div>
						<input type="hidden" id="writer" name="writer"
							value="${param.writer}">
					</div>
					<div>
						<textarea rows="20" cols="100" id="content" name="content"></textarea>
					</div>
					<div>
						<input type="hidden" id="secret" name="secret" value="0">
					</div>
					<div>
						<input type="hidden" id="report" name="report" value="0">
					</div>
					<div>
						<button type="button" class="btn btn-primary btn-round" onclick="input_check()">방명록 작성완료</button>
					</div>
				</form>
              </div>
            </div>
          </div>
        </div>
      </div>
      <footer class="footer footer-black  footer-white ">
        <div class="container-fluid">
          <div class="row">
            <nav class="footer-nav">
				<ul>
					<li>Contact Us</li>
					<li><a class="nav-link btn-magnify"
						href="https://www.instagram.com/" target="_blank"> <i class="fa-brands fa-github"></i>
							<p>
								<span class="d-lg-none d-md-block">github</span>
							</p>
					</a></li>
					<li><a class="nav-link btn-magnify"
						href="https://www.instagram.com/" target="_blank"> <i class="fa-brands fa-instagram"></i>
							<p>
								<span class="d-lg-none d-md-block">instagram</span>
							</p>
					</a></li>
					<li class="nav-item"><a class="nav-link btn-magnify"
						href="https://twitter.com/" target="_blank"> <i class="fa-brands fa-twitter"></i>
							<p>
								<span class="d-lg-none d-md-block">twitter</span>
							</p>
					</a></li>
					<li class="nav-item"><a class="nav-link btn-rotate"
						href="https://ko-kr.facebook.com/" target="_blank"> <i class="fa-brands fa-facebook"></i>
							<p>
								<span class="d-lg-none d-md-block">facebook</span>
							</p>
					</a></li>
				</ul>
			</nav>
			<div class="credits ml-auto">
				<span class="copyright"> © <script>document.write(new Date().getFullYear())
                </script>, made with <i class="fa fa-heart heart"></i> by
					일촌맺어죠
				</span>
			</div>
          </div>
        </div>
      </footer>
    </div>
  </div>

<script type="text/javascript" src="./resources/smarteditor2/js/HuskyEZCreator.js" charset="utf-8"></script>
<script type="text/javascript">
var oEditors = [];
nhn.husky.EZCreator.createInIFrame({
	oAppRef: oEditors,
	elPlaceHolder: "content",
	sSkinURI: "./resources/smarteditor2/SmartEditor2Skin.html",
	htParams : {
		bSkipXssFilter : true
	},
	fCreator: "createSEditor2"
});
</script>
</body>
</html>