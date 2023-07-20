<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="utf-8" />
<link rel="apple-touch-icon" sizes="76x76"
	href="resources/assets/img/apple-icon.png">
<link rel="icon" type="image/png"
	href="resources/assets/img/favicon.png">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
<title>방명록</title>
<meta
	content='width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0, shrink-to-fit=no'
	name='viewport' />
<!--     Fonts and icons     -->
<link
	href="https://fonts.googleapis.com/css?family=Montserrat:400,700,200"
	rel="stylesheet" />
<link
	href="https://maxcdn.bootstrapcdn.com/font-awesome/latest/css/font-awesome.min.css"
	rel="stylesheet">
<!-- CSS Files -->
<link href="resources/assets/css/bootstrap.min.css" rel="stylesheet" />
<link href="resources/assets/css/paper-dashboard.css?v=2.0.1"
	rel="stylesheet" />
<script src="https://kit.fontawesome.com/7ed6703c9d.js" crossorigin="anonymous"></script>
<link rel="stylesheet" href="resources/css/postit.css">
<link rel="stylesheet" href="resources/css/visitors_log.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
<script type="text/javascript">
function redirectToMiniHome(selectElement) {
    var nickname = selectElement.value;
    window.location.href = "mini_home.do?nickname=" + nickname;
  }

let mh_attr_id = '${mh_attr.id}';
console.log(mh_attr_id);

function recent_visitLog(){
    $.ajax({
        url: "json_mc_findAll.do",
        method: "get",
        data : {
			id : mh_attr_id
		},
        dataType: "json",
        success: function(data) {
        	console.log(data);
            let visit_log = ``;
            $.each(data, function(index, miniComment){
            	let content = miniComment.content;
 				if (content.length > 20) {
 					  content = content.substring(0, 20) + '...';
 				}
            	
                visit_log += `
			        <div class="postit">
 					<span onclick="gotoFindOne(\${miniComment.mcnum})">
				        <h5>\${miniComment.writer}</h5><br><br>
				        <span>\${miniComment.cdate}</span>
			        </span>
			        </div>
			        `;
            });
            $('#visitors_log').html(visit_log);
        },
        error: function(request, status, error) {
            console.error('Request failed', status, error);
        }
    });
}

function gotoFindOne(mcnum){
	window.location.href="visit_findOne.do?id="+mh_attr_id+"&mcnum="+mcnum;
}
</script>
</head>

<body class="" onload="recent_visitLog()">
	<jsp:include page="./mini_top_menu.jsp"></jsp:include>
	<div class="wrapper ">
		<div class="main-panel"
			style="background-image: url('resources/uploadimg/${mh_attr.backimg}'); background-size:cover; background-repeat:no-repeat;">
			<jsp:include page="./mini_navbar.jsp"></jsp:include>
			<div class="content" style="height: 90vh;">
				<div class="row">
					<div class="col-md-12">
						<div class="card">
							<div class="card-header"
								style="text-align: center; font-family: Georgia; font-size: 20px; font-weight: bold;">
								<div class="card-header">
									<h4 class="card-title" style="display: flex; justify-content: center;">최근 방명록</h4>
									<div style="display: flex; justify-content: flex-end;">
										<select onchange="redirectToMiniHome(this)">
												<option>1촌목록</option>
											<c:forEach var="vo" items="${vos}">
												<option value="${vo.nickname2}">${vo.nickname2}</option>
											</c:forEach>
										</select>
									</div>
								</div>
								<div class="card-body" style="height: 600px;">
									<div id="visitors_log"></div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
			<jsp:include page="../footer.jsp"></jsp:include>
		</div>
	</div>
	<!--   Core JS Files   -->
	<script src="resources/assets/js/core/jquery.min.js"></script>
	<script src="resources/assets/js/core/popper.min.js"></script>
	<script src="resources/assets/js/core/bootstrap.min.js"></script>
	<script
		src="resources/assets/js/plugins/perfect-scrollbar.jquery.min.js"></script>
	<!-- Chart JS -->
	<script src="resources/assets/js/plugins/chartjs.min.js"></script>
	<!--  Notifications Plugin    -->
	<script src="resources/assets/js/plugins/bootstrap-notify.js"></script>
	<!-- Control Center for Now Ui Dashboard: parallax effects, scripts for the example pages etc -->
	<script src="resources/assets/js/paper-dashboard.min.js?v=2.0.1"
		type="text/javascript"></script>
</body>
</html>