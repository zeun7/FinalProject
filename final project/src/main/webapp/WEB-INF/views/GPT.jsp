<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
<script type="text/javascript">
function generate(){
	console.log("generate()...");
	$.ajax({
		url: 'generate_response.do',
		data:{prompt: $('#prompt').val()},
		method: 'GET',
		dataType: 'json',
		success: function(response){
			$('#response').html(response);
		},
		error: function(error, xhr, status){
			console.log('xhr.status:',xhr.status);
			$('#response').html(response);
		}
	});
}
 
</script>
</head>
<body>
	<h3>GPT에게 보낼 메시지를 입력하세요</h3>
		<form action="generate_response.do" method="GET">
			<input type="text" name="prompt" id="prompt"/>
			<button type="submit">입력</button>
		</form>
		<br/>
		<h3>Response...</h3>
		<div id="response"></div>
</body>
</html>