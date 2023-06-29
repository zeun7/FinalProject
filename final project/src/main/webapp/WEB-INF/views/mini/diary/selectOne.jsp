<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html>
<head>
<title>다이어리_selectOne</title>
<jsp:include page="../../css.jsp"></jsp:include>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
<script type="text/javascript">
$(document).ready(function() {
  var imagePath = "${vo2.filepath}";
  var imageContainer = $("#imageContainer");
  var originalImage = '<img id="diaryImage" width="200px" src="resources/uploadimg/${vo2.filepath}">';

  imageContainer.html(originalImage);

  var backupData = {
    title: $("#titleSpan").text(),
    content: $("#contentSpan").text(),
    filePath: imagePath
  };

  $("#editButton").on('click', function(e) {
    e.preventDefault();

    if ($(this).text() === "수정") {
      $("#titleSpan").html('<input type="text" id="titleInput" value="' + backupData.title + '"/>');
      $("#contentSpan").html('<textarea id="contentInput">' + backupData.content + '</textarea>');

      var fileInput = $('<input type="file" id="fileInput" />');
      if (backupData.filePath !== "") {
        fileInput.attr('value', backupData.filePath);
      }

      imageContainer.html(fileInput);

      // Show the file input field
      fileInput.show();

      // Show the file icon
      $("#fileIcon").show();

      $(this).text('수정완료');
    } else {
      var formData = new FormData();
      formData.append("title", $("#titleInput").val());
      formData.append("content", $("#contentInput").val());
      
      var fileInput = $("#fileInput")[0];
      if (fileInput.files.length > 0) { // 파일이 존재할 경우에만 bfile 필드 추가
        formData.append("bfile", fileInput.files[0]);
      }
      
      $.ajax({
        url: 'diary_updateOK.do',
        method: 'POST',
        data: formData,
        processData: false,
        contentType: false,
        success: function(response) {
          backupData.title = $("#titleInput").val();
          backupData.content = $("#contentInput").val();
          backupData.filePath = response.filePath;
          $("#titleSpan").text(backupData.title);
          $("#contentSpan").text(backupData.content);
          if (backupData.filePath !== "") {
            imageContainer.html('<img id="diaryImage" width="200px" src="resources/uploadimg/' + backupData.filePath + '">');
          } else {
            imageContainer.empty();
          }
          $("#editButton").text('수정');
        },
        error: function() {
          alert('파일을 첨부해 주세요. 첨부파일을 삭제하려면 none.png를 첨부하세요');
          
          // Show the file input field
          fileInput.show();

          // Show the file icon
          $("#fileIcon").show();

          $("#editButton").text('수정완료');
          $("#editButton").prop('disabled', false);
        }
      });
    }
  });
  // 다른 사람의 미니홈피 방문시 다이어리 작성 버튼 숨김
  if('${user_id}' != '${mh_attr.id}'){	
      $('#buttonContainer').hide();
  }
});
</script>
</head>
<body>
<jsp:include page="../../top_menu.jsp"></jsp:include>
<jsp:include page="../mini_top_menu.jsp"></jsp:include>
<h1>mini/diary/selectOne.jsp</h1>
<h1>${user_id}</h1>
<h1>${mh_attr.id}</h1>
<div>${vo2.mbname}</div>
<div id="title">제목 : <span id="titleSpan">${vo2.title}</span></div>
<div>닉네임 : ${vo2.writer}</div>
<div>작성일자 : ${vo2.wdate}</div>
<div style="border: 1px solid black; width: 700px; height: 350px;">
  <p id="content"><span id="contentSpan">${vo2.content}</span></p>
</div>
<div id="imageContainer"></div>
<div id="buttonContainer">
  <button id="editButton" class="myButton">수정</button>
  <a href="diary_deleteOK.do?id=${mh_attr.id}&mbnum=${param.mbnum}" class="myButton">삭제</a>
</div>
</body>
</html>