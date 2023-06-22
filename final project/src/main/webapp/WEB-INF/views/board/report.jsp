<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<form action="b_reportOK.do" method="post" id="report_form">
		<input type="hidden" name="bnum" value="${param.bnum }">
		<textarea rows="15" cols="30" name="reason" placeholder="신고 사유를 작성해주세요."></textarea>
		<input type="submit" value="신고">
	</form>
	
	<div id="reportOK_txt">
		<div>
			<p>신고가 완료되었습니다.</p>
		</div>
		<button onclick="window.close()">닫기</button>
	</div>
	
	<script src="http://code.jquery.com/jquery-latest.js"></script>
	<script type="text/javascript">
		if(${param.bnum} > 0){
			$("#report_form").show();
			$("#reportOK_txt").hide();
		}else{
			$("#report_form").hide();
			$("#reportOK_txt").show();
		}
	</script>
</body>
</html>