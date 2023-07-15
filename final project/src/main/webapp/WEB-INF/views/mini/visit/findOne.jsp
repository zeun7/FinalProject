<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<html>
<head>
<title>방명록_selectOne</title>
<jsp:include page="../../css.jsp"></jsp:include>
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
			let visit_log = `
				<div>mcnum : \${miniComment.mcnum}</div>
				<div>mbnum : \${miniComment.mbnum}</div>
				<div>닉네임 : \${miniComment.writer}</div>
				<div style="border: 1px solid black; width: 700px; height: 350px;">
					<p id="content">
						<span id="contentSpan">\${miniComment.content}</span>
					</p>
				</div>
				<div>작성일자 : \${miniComment.cdate}</div>
				<div id="buttonContainer">
					<button id="editButton" class="myButton" onclick="visitUpdate(\${miniComment.mcnum})">수정</button>
					<a href="visit_deleteOK.do?id=\${mh_attr_id}&mcnum=\${miniComment.mcnum}" class="myButton">삭제</a>
				</div>
				`;
			$('#visitor_log').html(visit_log);
			
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
    const originalContent = $("#contentSpan").text();

    // 내용을 편집할 수 있는 textarea로 바꿈
    $("#contentSpan").replaceWith('<textarea id="contentEdit" rows="10" cols="70">' + originalContent + '</textarea>');

    // "수정" 버튼을 "저장" 버튼으로 바꿈
    $("#editButton").off('click').text('저장').attr('id', 'saveButton').attr('onclick', '');

    $('#saveButton').on('click', function(e) {
        e.preventDefault();

        // 편집된 내용을 가져옴
        const editedContent = $("#contentEdit").val().trim();

        // 데이터를 서버에 전송하기 위한 FormData 객체를 생성
        let formData = new FormData();
        formData.append("mcnum", mcnum);
        formData.append("content", editedContent);

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
<body onload="visitFindOne()">
	<jsp:include page="../../sidebar.jsp"></jsp:include>
	<h1>mini/visit/selectOne.jsp</h1>
	<div id="visitor_log"></div>
</body>
</html>