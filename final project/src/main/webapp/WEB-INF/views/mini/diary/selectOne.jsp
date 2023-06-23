<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<html>
<head>
<title>다이어리_selectOne</title>
<jsp:include page="../../css.jsp"></jsp:include>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
<script>
  $(document).ready(function() {
    var imagePath = "${vo2.filepath}";
    var imageContainer = $("#imageContainer");
    
    if (imagePath === "") {
      imageContainer.hide();
    }
  });
</script>

</head>
<body>
	<jsp:include page="../../top_menu.jsp"></jsp:include>
	<h1>mini/diary/selectOne.jsp</h1>

	<div>${vo2.mbname}</div>
	<div id="title">제목 : ${vo2.title}</div>
	<div>닉네임 : ${vo2.writer}</div>
	<div>작성일자 : ${vo2.wdate}</div>
	<div style="border: 1px solid black; width: 700px; height: 350px;">
		<p id="content">${vo2.content}</p>
	</div>
	<div id="imageContainer"><img width="200px" src="resources/uploadimg/${vo2.filepath}"></div>
	<div id="buttonContainer">
		<a href="diary_update.do?mbnum=${param.mbnum}" class="myButton">수정</a>
		<a href="diary_deleteOK.do?mbnum=${param.mbnum}" class="myButton">삭제</a>
	</div>
	<div>1 2 3 4 5</div>
</body>
</html>

<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
	<script>
// 		function editTitleAndContent(title, content) {
// 			var titleElement = document.getElementById("title");
// 			var contentElement = document.getElementById("content");
// 			var buttonContainer = document.getElementById("buttonContainer");

// 			if (!titleElement || !contentElement) {
// 				console.error("Failed to find title or content element.");
// 				return;
// 			}

// 			var newTitleInput = document.createElement("input");
// 			newTitleInput.type = "text";
// 			newTitleInput.value = title;

// 			var newContentTextarea = document.createElement("textarea");
// 			newContentTextarea.value = content;

// 			if (titleElement.parentNode) {
// 				titleElement.parentNode.replaceChild(newTitleInput, titleElement);
// 			} else {
// 				console.error("Failed to replace title element.");
// 				return;
// 			}

// 			if (contentElement.parentNode) {
// 				contentElement.parentNode.replaceChild(newContentTextarea, contentElement);
// 			} else {
// 				console.error("Failed to replace content element.");
// 				return;
// 			}

// 			var submitButton = document.createElement("button");
// 			submitButton.innerText = "제출 완료";
// 			submitButton.className = "myButton";
// 			submitButton.onclick = function() {
// 				var updatedTitle = newTitleInput.value;
// 				var updatedContent = newContentTextarea.value;

// 				// Ajax 요청 등 필요한 작업 수행
// 				var xhr = new XMLHttpRequest();
// 				xhr.open("POST", "/json_diary_update.do", true);
// 				xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
// 				xhr.onreadystatechange = function() {
// 					if (xhr.readyState === XMLHttpRequest.DONE) {
// 						if (xhr.status === 200) {
// 							var response = xhr.responseText;
// 							if (response === "1") {
// 								// 완료 메시지 표시
// 								alert("수정이 완료되었습니다.");
// 							} else {
// 								// 실패 메시지 표시
// 								alert("수정에 실패하였습니다.");
// 							}
// 						} else {
// 							// 실패 메시지 표시
// 							alert("서버 오류가 발생하였습니다.");
// 						}
// 					}
// 				};
// 				xhr.send("updatedTitle=" + encodeURIComponent(updatedTitle) + "&updatedContent=" + encodeURIComponent(updatedContent));
// 			};

// 			if (buttonContainer) {
// 				buttonContainer.innerHTML = ""; // 기존 버튼 제거
// 				buttonContainer.appendChild(submitButton);
// 			} else {
// 				console.error("Failed to find button container.");
// 				return;
// 			}
// 		}
	</script>