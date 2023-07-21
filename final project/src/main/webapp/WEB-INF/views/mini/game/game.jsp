<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="utf-8" />
<link rel="apple-touch-icon" sizes="76x76"
	href="resources/assets/img/apple-icon.png">
<link rel="icon" type="image/png"
	href="resources/assets/img/favicon.png">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
<title>미니게임</title>
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

<link href="resources/css/game.css" rel="stylesheet" />
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.4/moment-with-locales.min.js"></script>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
</head>

<body class="" onload="gameStart()">
	<jsp:include page="../mini_top_menu.jsp"></jsp:include>
	<div class="wrapper ">
		<div class="main-panel"
			style="background-image: url('resources/uploadimg/${mh_attr.backimg}'); background-size:cover; background-repeat:no-repeat;">
			<jsp:include page="../mini_navbar.jsp"></jsp:include>
			<div class="content" style="height: 100%;">
				<div class="row">
					<div class="col-md-12">
						<div class="card"
							style="background-image: url('resources/assets/img/sketchbook.png'); background-size: cover;">
							<div class="card-header game-header">
								<h4 class="card-title text-center game-title">끝말잇기 게임</h4>
							</div>
							<div class="card-body">
								<div id="gameBackground" class="text-time">
									<p id="remainingTime" class="text-center"></p>
								</div>
								<br>
								<br>
								<div id="gameContainer" class="text-center">
									<div id="gameContent">
										<div class="word-start text-center">시작 단어: 사과</div>
										<ul id="wordList"></ul>
										<div class="word-input text-center">
											<div class="word-input-div">
												<input type="text" id="inputWord" placeholder="단어 입력">
											</div>
											<button id="startButton" class="btn-start">게임 시작</button>
											<button id="nextButton" class="btn-start">다음단어</button>
										</div>
										<br>
										<br>
										<button id="showRank" class="btn-rank">랭킹보기</button>
									</div>
									<div id="rankingContent" style="display: none;"></div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
			<jsp:include page="../../footer.jsp"></jsp:include>
		</div>
	</div>
</body>

<script type="text/javascript">
	$('#nextButton').hide(); // --------------!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
	let Game = { // Game 객체 선언
		currentWord : '사과',
		score : 0,
		gameDuration : 10 * 1000,	// 10초
		gameStarted : false,
		remainingTime : 10, // 제한 시간
		startButton : document.getElementById('startButton'),
		timeDisplay : document.getElementById('remainingTime'),
		timerInterval : null, // timerInterval 초기화
		gameTimeout : null
	// gameTimeout 초기화
	}
	
	var WordList = new Array();	// 입력한 단어 리스트
	WordList[0] = '사과';

	// 버튼의 초기 텍스트 설정
	//     Game.startButton.textContent = '게임 시작';
	Game.timeDisplay.textContent = '남은 시간: 10';

	function startTimer() {
		Game.timerInterval = setInterval(function() {
			Game.remainingTime--;
			Game.timeDisplay.textContent = '남은 시간: ' + Game.remainingTime;

			if (Game.remainingTime <= 0) {
				clearInterval(Game.timerInterval);
				Game.timeDisplay.textContent = '게임 끝!';
			}
		}, 1000);
	}

	function startGameTimeout() {
		Game.gameTimeout = setTimeout(function() {
			if (!Game.gameStarted) {
				clearTimeout(Game.gameTimeout);
				return;
			}
			alert('Game Over!');
			// 게임 기록 저장
			$.ajax({
				url : "game_record_insert.do",
				method : "POST",
				data : {
					score : Game.score
				},
				success : function(response) {
					console.log(response);
					gameEnd(response.gnum);
				},
				error : function(jqXHR, textStatus, errorThrown) {
					console.error('Request failed', textStatus, errorThrown);
				}
			});
			clearTimeout(Game.gameTimeout);
		}, Game.gameDuration);
	}

	function gameStart() {
		$('#wordList').hide();
		$('#rankingContent').hide();
		$('#gameContent').show();
		$('#remainingTime').show();

		$('#startButton').on('click', function() {
			startGame();
			$('#startButton').hide();
			$('#nextButton').show();
		});

		$('#startButton').on('keyup', function(event) {
			if (event.which === 13) {
				event.preventDefault();
				startGame();
			}
		});
	}

	function startGame() {
		if (!Game.gameStarted) {
			Game.startButton.removeEventListener('click', startGame);
			Game.startButton.removeEventListener('keyup', startGame);
			$('#nextButton').on('click', function(event) {
				event.preventDefault();
				validateAndAddWord();
			});
			$('#inputWord').on('keyup', function(event) { // inputWord에서 엔터를 입력했을 때의 처리
				if (event.which === 13) {
					event.preventDefault();
					validateAndAddWord();
				}
			});
			Game.gameStarted = true;
			startTimer();
			startGameTimeout();
			validateAndAddWord(); // 여기서 바로 validateAndAddWord 호출
		}
		$('#inputWord').val(''); // inputWord 초기화
		$('#wordList').html('<li>사과</li>'); // wordList 초기화
	}

	$('#inputWord').on('keyup', function(event) {
		if (event.which === 13) {
			event.preventDefault();
			if (!Game.gameStarted) {
				startGame();
			}
		}
	});

	$('#startButton').on('click', function(event) {
		event.preventDefault();
		if (!Game.gameStarted) {
			startGame();
		}
	});

	// 게임플레이 후 랭킹 보여주는 경우
	function gameEnd(gnum) {
		// db에서 user_id, profilepic 가져오기
		$.ajax({
			url : "getUserInfo.do",
			method : "GET",
			data : {
				gnum : gnum
			},
			dataType : 'json',
			success : function(data) {
				show_all_record(data.profilepic, data.score, data.id,
						data.gdate);
			},
			error : function(jqXHR, textStatus, errorThrown) {
				console.error('Request failed', textStatus, errorThrown);
			}
		});
	}

	function show_all_record(userProfilePic, userScore, userId, playDate) {
		$
				.ajax({
					url : "game_ranking_all.do",
					method : "get",
					success : function(records) {
						if (userId) { // 게임을 플레이한 경우 사용자의 점수를 추가
							let userRecord = {
								profilepic : userProfilePic,
								score : userScore,
								id : userId,
								gdate : playDate
							};
							records.unshift(userRecord); // 사용자의 행을 맨 처음에 추가
						}

						let rankingTable = '<table class="table text-center"><tr><th>Rank</th><th>ProfilePic</th><th>UserID</th><th>Score</th><th>PlayDate</th></tr>';

						for (let i = 0; i < records.length; i++) {
							let row = records[i];
							let rank;
							let date = moment(row.gdate).format(
									'YY년MM월DD일HH시mm분ss초');
							if (i === 0 && userScore) {
								// 첫 번째 행이고, 사용자가 게임을 플레이했으면 '내 점수'로 설정
								rank = '내 점수';
							} else {
								// 그 외의 경우, 순위를 1부터 시작하여 부여
								rank = userScore ? i : i + 1; // 게임을 플레이하지 않았다면 i + 1을 사용
							}
							rankingTable += `<tr><td>\${rank}</td><td><img src="resources/uploadimg/thumb_\${row.profilepic}"></td><td>\${row.id}</td><td>\${row.score}점</td><td>\${date}</td></tr>`;
						}
						// 테이블 마지막에 버튼 추가
						rankingTable += `<tfoot><tr><td colspan='5'><button id='restartGameButton' class="btn btn-primary btn-round">게임하기</button><button id='showRankingButton' class="btn btn-round">오늘의 랭킹 보기</button></td></tr></tfoot></table>`;
						rankingTable += `</table>`;

						$('#rankingContent').html(rankingTable);
						$('#rankingContent').show();
						$('#gameContent').hide();

						$('#restartGameButton').on(
								'click',
								function() {
									// Game 객체 초기화(다시하기 버튼을 눌렀을 때를 위한)
									Game.currentWord = '사과';
									Game.score = 0;
									Game.gameStarted = false;
									Game.remainingTime = 60;
									Game.timeDisplay.textContent = '남은 시간: '
											+ Game.remainingTime;
									clearInterval(Game.timerInterval); // 이미 설정된 timerInterval을 취소
									clearTimeout(Game.gameTimeout); // 이미 설정된 gameTimeout을 취소

									$('#inputWord').val(''); // inputWord 초기화
									$('#wordList').html('<li>사과</li>'); // wordList 초기화
									gameStart();
								});

						$('#showRankingButton').on(
								'click',
								function() { // '오늘의 랭킹 보기' 버튼에 이벤트 바인딩
									show_today_ranking(userProfilePic,
											userScore, userId, playDate);
								});
					},
					error : function(jqXHR, textStatus, errorThrown) {
						console
								.error('Request failed', textStatus,
										errorThrown);
					}
				});
	}

	function show_today_ranking(userProfilePic, userScore, userId, playDate) {
		$.ajax({
					url : "game_ranking_today.do",
					method : "get",
					success : function(records) {
						if (userId) { // 게임을 플레이한 경우 사용자의 점수를 추가
							let userRecord = {
								profilepic : userProfilePic,
								score : userScore,
								id : userId,
								gdate : playDate
							};
							records.unshift(userRecord); // 사용자의 행을 맨 처음에 추가
						}

						let rankingTable = '<table class="table text-center"><tr><th>Rank</th><th>ProfilePic</th><th>UserID</th><th>Score</th><th>PlayDate</th></tr>';

						for (let i = 0; i < records.length; i++) {
							let row = records[i];
							let rank;
							let date = moment(row.gdate).format(
									'YY년MM월DD일HH시mm분ss초');
							if (i === 0 && userScore) {
								// 첫 번째 행이고, 사용자가 게임을 플레이했으면 '내 점수'로 설정
								rank = '내 점수';
							} else {
								// 그 외의 경우, 순위를 1부터 시작하여 부여
								rank = userScore ? i : i + 1; // 게임을 플레이하지 않았다면 i + 1을 사용
							}
							rankingTable += `<tr><td>\${rank}</td><td><img src="resources/uploadimg/thumb_\${row.profilepic}"></td><td>\${row.id}</td><td>\${row.score}점</td><td>\${date}</td></tr>`;
						}
						// 테이블 마지막에 버튼 추가
						rankingTable += `<tfoot><tr><td colspan='5'><button id='restartGameButton' class="btn btn-primary btn-round">게임하기</button><button id='showAllRankingButton' class="btn btn-round">전체 랭킹 보기</button></td></tr></tfoot></table>`;
						rankingTable += `</table>`;

						$('#rankingContent').html(rankingTable);
						$('#rankingContent').show();
						$('#gameContent').hide();

						$('#restartGameButton').on(
								'click',
								function() {
									// Game 객체 초기화(다시하기 버튼을 눌렀을 때를 위한)
									Game.currentWord = '사과';
									Game.score = 0;
									Game.gameStarted = false;
									Game.remainingTime = 60;
									Game.startButton.textContent = '게임 시작';
									Game.timeDisplay.textContent = '남은 시간: '
											+ Game.remainingTime;
									clearInterval(Game.timerInterval); // 이미 설정된 timerInterval을 취소
									clearTimeout(Game.gameTimeout); // 이미 설정된 gameTimeout을 취소

									$('#inputWord').val(''); // inputWord 초기화
									$('#wordList').val(''); // wordList 초기화
									gameStart();
								});

						$('#showAllRankingButton').on(
								'click',
								function() { // '전체 랭킹 보기' 버튼에 이벤트 바인딩
									show_all_record(userProfilePic, userScore,
											userId, playDate);
								});
					},
					error : function(jqXHR, textStatus, errorThrown) {
						console
								.error('Request failed', textStatus,
										errorThrown);
					}
				});
	}

	function validateAndAddWord() {
		let inputWord = $('#inputWord').val().trim(); // 입력한 단어 앞뒤 공백 자르기
		if (inputWord !== '') {
			validateWord(inputWord, function(isValid) {
				if (isValid) {
					let hangulWord = /^[가-힣]+$/; // 한글 단어 유효성 검사
					// 입력한 단어가 한글 단어이며, 그리고 입력한 단어의 첫 글자가 현재 참조 단어의 마지막 글자와 같다면
					if (hangulWord.test(inputWord)
							&& inputWord.charAt(0) === Game.currentWord
									.charAt(Game.currentWord.length - 1)) {
						
						let isRepeated = false;
						for(let i of WordList){	// 단어 중복 검사
							if(inputWord === i)
								isRepeated = true;
						}
						WordList[WordList.length] = inputWord;	// 입력한 단어 기억
						
						if(!isRepeated){	// 단어가 중복되지 않았을 경우
							let listItem = $('<li>').text('입력한 단어: ' + inputWord);
							$('#wordList').empty(); // 리스트 비우기
							$('#wordList').append(listItem); // 단어 리스트에 추가
							Game.currentWord = inputWord; // 다음 차례 설정
							Game.score++; // 점수 증가
							$('#inputWord').val(''); // 입력 필드 초기화
							$('#wordList').show();
							Game.remainingTime = 10;
							
							clearInterval(Game.timerInterval); // 돌아가는 타이머 멈추기
							clearTimeout(Game.gameTimeout); // 돌아가는 타임아웃 멈추기
							startTimer(); // 타이머 재시작
							startGameTimeout(); // 타임아웃 재시작
						} else {	// 단어가 중복됐을 경우
							WordList.length = 1;	// 입력한 단어 초기화
							alert('이전에 입력한 단어와 중복!');
						}
					} else if (!hangulWord.test(inputWord)) {
						WordList.length = 1;	// 입력한 단어 초기화
						alert('한글만 입력!'); // '한글만 입력!' 알림창 표시
					} else {
						WordList.length = 1;	// 입력한 단어 초기화
						alert('땡!');	// '땡!' 알림창 표시
					}
				}
			});
		}
	} //end validateAndAddWord()

	function validateWord(word, callback) {
		$.ajax({
			url : "validateWord/" + word,
			method : "GET",
			success : function(response) {
				if (response.isValid) {
					callback(true); //단어가 사전에 존재
				} else {
					alert(response.message); //단어가 사전에 존재하지 않음
					callback(false);
				}
			},
			error : function(jqXHR, textStatus, errorThrown) {
				console.error('Request failed', textStatus, errorThrown);
				callback(false);
			}
		});
	}//end validateWord

	// 랭킹만 보여주는 경우
	$('#showRank').click(
			function() {
				// 게임 종료
				Game.gameStarted = false;
				clearTimeout(Game.gameTimeout);
				clearInterval(Game.timerInterval);

				$('#remainingTime').hide();

				show_all_record(userScore = null, userId = null,
						userProfilePic = null, playDate = null);
			});
</script>
</html>