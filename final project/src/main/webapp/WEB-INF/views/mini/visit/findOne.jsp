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
    방명록 상세보기
  </title>
  <meta content='width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0, shrink-to-fit=no' name='viewport' />
  <!--     Fonts and icons     -->
  <link href="https://fonts.googleapis.com/css?family=Montserrat:400,700,200" rel="stylesheet" />
  <link href="https://maxcdn.bootstrapcdn.com/font-awesome/latest/css/font-awesome.min.css" rel="stylesheet">
  <!-- CSS Files -->
  <link href="resources/assets/css/bootstrap.min.css" rel="stylesheet" />
  <link href="resources/assets/css/paper-dashboard.css?v=2.0.1" rel="stylesheet" />
  <link rel="stylesheet" href="resources/css/button.css">
  <script src="https://kit.fontawesome.com/7ed6703c9d.js" crossorigin="anonymous"></script>

<style type="text/css">
#contentArea {
  border: none;
}

#contentArea:focus {
  outline: none;
}

#contentArea {
  resize: none;
}
</style>
<link rel="stylesheet" href="resources/css/button.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
<script type="text/javascript">
let mh_attr_id = '${mh_attr.id}';
console.log(mh_attr_id);

function visitFindOne() {
	let mcnum = '${param.mcnum}'; 
	$.ajax({
		url : 'json_mc_findOne.do',
		type : 'get',
		data : {
			mcnum : mcnum
		},
		dataType : 'json',
		success : function(miniComment) {
			let visit_nickname = ` \${miniComment.writer}`;
			let visit_log = `
				<div style="display: none">mcnum : \${miniComment.mcnum}</div>
				<div style="display: none">mbnum : \${miniComment.mbnum}</div>
				<div id="selectColor" style="display: none">
					포스트잇 색깔 변경
					<select name="color" id="color">
						<option value="#9ff4f9" style="background-color: #9ff4f9">하늘</option>
						<option value="#f4f885" style="background-color: #f4f885">노랑</option>
						<option value="#fbc6ef" style="background-color: #fbc6ef">핑크</option>
						<option value="#bafcdb" style="background-color: #bafcdb">연두</option>
					</select>
				</div><br>
				<textarea id="contentArea" rows="10" cols="70" readonly>\${miniComment.content}</textarea>
				<p>&nbsp;</p><p>&nbsp;</p><p>&nbsp;</p><p>&nbsp;</p><p>&nbsp;</p><p>&nbsp;</p>
				<hr/>
				<div id="buttonss" style="display: flex; justify-content: space-between;">
					<div>
						<a class="custom-btn btn-1" href="mini_visit.do?id=\${mh_attr_id}">목록으로</a>
						작성일자 : \${miniComment.cdate}
					</div>
					<br/>
					<div id="buttonContainer">
						<button id="editButton" class="custom-btn btn-12" onclick="visitUpdate(\${miniComment.mcnum})">수정</button>
						<a href="visit_deleteOK.do?id=\${mh_attr_id}&mcnum=\${miniComment.mcnum}" class="custom-btn btn-12">삭제</a>
					</div>
				</div>
				`;
			$('#visitor_nickname').html(visit_nickname);
			$('#visitor_log').html(visit_log);
			$('#color').val(miniComment.color).prop('selected', true);
			
			// 수정,삭제버튼 보여주는 logic. 주인이 아닐 때 AND nickname이 작성자 닉네임과 다를 때 숨김.
			// 즉, 미니홈피 주인, 작성자만 수정,삭제 가능
	        if('${user_id}' != '${mh_attr.id}' && '${nickname}' != miniComment.writer){    
	            $('#buttonContainer').hide();
	        }
		},
		error : function(request, status, error) {
			console.error('Request failed', status, error);
		}
	});
}

function visitUpdate(mcnum){
    // 기존 내용을 저장
    const originalContent = $("#contentArea").html();
    console.log(originalContent);

    // 내용을 편집할 수 있는 textarea로 바꿈
    $("#contentArea").replaceWith('<textarea id="contentEdit" rows="10" cols="70">' + originalContent + '</textarea>');

    // "수정" 버튼을 "저장" 버튼으로 바꿈
    $("#editButton").off('click').text('저장').attr('id', 'saveButton').attr('onclick', '');
    
    // 포스트잇 색깔 선택 창을 보이게
    $('#selectColor').show();

    $('#saveButton').on('click', function(e) {
        e.preventDefault();

        // 편집된 내용을 가져옴
        const editedContent = $("#contentEdit").val().trim();
        const editedColor = $("#color").val();

        // 데이터를 서버에 전송하기 위한 FormData 객체를 생성
        let formData = new FormData();
        formData.append("mcnum", mcnum);
        formData.append("content", editedContent);
        formData.append("color", editedColor);

        // AJAX 요청을 이용하여 수정된 내용을 서버에 전송
        $.ajax({
            url : 'json_mc_updateOK.do',
            data : formData,
            type : 'POST',
            processData: false,
            contentType: false,
            success : function(res){
                alert('수정 완료');
                location.reload();  // 페이지를 새로 고침하여 수정된 내용을 보여줌
            },
            error: function(xhr, status, error) {
                console.error('수정 실패:', error);
            }
        });
    });
}

</script>
</head>

<body class="" onload="visitFindOne()">
<jsp:include page="../mini_top_menu.jsp"></jsp:include>
  <div class="wrapper ">
    <div class="main-panel" style="background-image: url('resources/uploadimg/${mh_attr.backimg}'); background-size:cover; background-repeat:no-repeat;">
    <jsp:include page="../../navbar.jsp"></jsp:include>
      <div class="content" style="height: 100%;">
        <div class="row">
          <div class="col-md-12">
            <div class="card">
              <div class="card-header">
                <h4 class="card-title" id="visitor_nickname"></h4>
              	<hr>
              </div>
              <div class="card-body">
              	<div id="visitor_log"></div>
              </div>
            </div>
          </div>
        </div>
      </div>
      <jsp:include page="../../footer.jsp"></jsp:include>
    </div>
  </div>
</body>
</html>