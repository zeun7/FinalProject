<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<html>
<head>
<title>다이어리_insert</title>
<jsp:include page="../../css.jsp"></jsp:include>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>

<script type="text/javascript">
	if('${user_id}' === ''){	// 로그아웃 상태
		$('#logout').hide();
		$('#m_insert').show();
		$('#myinfo').hide();
		$('#login').show();
	}
	else{						// 로그인 상태
		$('#logout').show();
		$('#m_insert').hide();
		$('#myinfo').show();
		$('#login').hide();
	}
	
	if('${mclass}' === '1'){		// 관리자
		$('#manage').show();
	}
	else{						// 일반 유저
		$('#manage').hide();
	}
</script>
</head>
<body>
	<jsp:include page="../../top_menu.jsp"></jsp:include>
	<h1>mini/diary/insert.jsp</h1>

	<form action="mb_insertOK.do" method="post" enctype="multipart/form-data">

		<div>
			<h1 style="font-size: 24px;">다이어리 ${nickname}</h1>
		</div>
		<div>
			<input type="hidden" id="mbname" name="mbname" value="diary">
		</div>
		<div>
			<input type="hidden" id="writer" name="writer"
				value="${nickname}">
		</div>
		<div>
			제목 :<input type="text" style="border: none;" id="title" name="title"
				value="다이어리 제목을 입력하세요">
		</div>
		<div>
			<textarea rows="10" cols="90" name="content">내용을 입력하세요</textarea>
		</div>
		<div>
			이미지 추가 :
			<input type="file" id="bfile" name="bfile"> 
			<input type="hidden" id="filepath" name="filepath">
		</div>
		<div>
			<input type="submit" class="myButton" value="다이어리 작성완료">
		</div>
	</form>

</body>
</html>