<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<html>
<head>
<title>게임</title>
<jsp:include page="../../css.jsp"></jsp:include>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
<style>
	#gameContainer {
		position: relative;
		width: 100%;
		height: 100vh;
	}

	#gameBackground {
		position: absolute;
		top: 0;
		left: 0;
		width: 100%;
		height: 100%;
		background-image: url('resources/uploadimg/${backimg}');
		background-size: cover;
	}

	#gameContent {
		position: absolute;
		top: 50%;
		left: 50%;
		transform: translate(-50%, -50%);
		text-align: center;
		color: white;
	}

	#gameContent h2,
	#gameContent p {
		margin: 0;
	}
</style>
<script type="text/javascript">
	$(document).ready(function() {
		$('#backButton').on('click', function(e) {
			e.preventDefault();
			window.history.back();
		});

		var currentWord = '광대'; // 시작 단어

		$('#startButton').on('click', function() {
			addWord();
		});

		$('#inputWord').on('keydown', function(event) {
			if (event.which === 13) {
				event.preventDefault();
				addWord();
			}
		});

		function addWord() {
			var inputWord = $('#inputWord').val(); // 입력한 단어

			if (inputWord !== '' && inputWord.charAt(0) === currentWord.charAt(currentWord.length - 1)) {
				var formattedWord = inputWord.trim(); // 입력한 단어에서 앞뒤 공백 제거
				$('#wordList').empty(); // 리스트 비우기
				var listItem = $('<li>').text('입력한 단어: ' + formattedWord); 
				$('#wordList').append(listItem); // 단어 리스트에 추가

				// 다음 차례 설정
				currentWord = formattedWord;

				// 입력 필드 초기화
				$('#inputWord').val('');
			} else {
				alert('땡!'); // '땡!' 알림창 표시
			}
		}
	});
</script>
</head>
<body>
	<jsp:include page="../../top_menu.jsp"></jsp:include>
	<jsp:include page="../../mini_top_menu.jsp"></jsp:include>
	<h1>mini/game/game.jsp</h1>
	<button id="backButton" class="myButton" style="margin-left: 300px">뒤로가기</button>
	<div id="gameContainer">
		<div id="gameBackground"></div>
		<div id="gameContent">
			<h2>끝말잇기 게임</h2>
			<p>시작 단어: 광대</p>
			<ul id="wordList"></ul>
			<input type="text" id="inputWord" placeholder="단어를 입력하세요">
			<button id="startButton">다음 단어</button>
		</div>
	</div>
</body>
</html>