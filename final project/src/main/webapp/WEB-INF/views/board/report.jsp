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
		<div>신고사유를 선택하세요</div>
		<input type="radio" id="reason1" name="reason" value="욕설/혐오/차별적 표현입니다">
		<label for="reason1">욕설/혐오/차별적 표현입니다</label><br>
		<input type="radio" id="reason2" name="reason" value="스팸홍보/도배글입니다">
		<label for="reason2">스팸홍보/도배글입니다</label><br>
		<input type="radio" id="reason3" name="reason" value="음란물입니다">
		<label for="reason3">음란물입니다</label><br>
		<input type="radio" id="reason4" name="reason" value="개인정보 노출 게시물입니다">
		<label for="reason4">개인정보 노출 게시물입니다</label><br>
		<input type="radio" id="reason5" name="reason" value="명예훼손 또는 저작권이 침해되었습니다">
		<label for="reason5">명예훼손 또는 저작권이 침해되었습니다</label><br>
		<input type="radio" id="reason6" name="reason" value="불쾌한 표현이 있습니다">
		<label for="reason6">불쾌한 표현이 있습니다</label><br>
		<button type="button" onclick="submitReport()">신고</button>
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
		
		function submitReport(){
			if($('input:radio[name=reason]').is(":checked")){
				document.getElementById("report_form").submit();
			}else{
				alert('신고사유를 선택하세요.');
			}
		}
	</script>
</body>
</html>