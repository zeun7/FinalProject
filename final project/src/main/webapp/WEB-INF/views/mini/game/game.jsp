<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<html>
<head>
<title>게임</title>
<jsp:include page="../../css.jsp"></jsp:include>
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
        position: relative;
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
    
   #remainingTime {
    position: absolute;
    top: 10px;
    right: 10px;
    font-size: 18px;
    color: white; 
    background-color: pink;
    padding: 5px; 
    border-radius: 5px;
	}
	
	#gameContent img {
    width: 50px; 
    height: 50px;
	}
	
	#rankingContent button {
    position: relative;
    top: 50%;
    left: 50%;
    transform: translate(-50%, -50%);
    text-align: center;
    color: white;
	}
	
</style>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
<script type="text/javascript">
	function gameStart() {
    let currentWord = '사과'; // 시작 단어
    let score = 0; // 점수
    let gameDuration = 10 * 1000; // 게임 시간 (60초)
    let gameStarted = false; //게임 시작 시 flag 추가
    
    let remainingTime = gameDuration / 1000; // 초 단위로 변환
    let timeDisplay = document.getElementById('remainingTime');

    // 1초마다 남은 시간 갱신
    let timerInterval = setInterval(function() {
        remainingTime--;
        timeDisplay.textContent = '남은 시간: ' + remainingTime;
        
        // 시간이 0이 되면 게임 종료
        if (remainingTime <= 0) {
            clearInterval(timerInterval);
            timeDisplay.textContent = '게임 끝!';
        }
    }, 1000);
    
    let gameTimeout = setTimeout(function() {
    	//게임을 플레이하지 않고 제한시간이 지났을 때
    	if(!gameStarted){
    		clearTimeout(gameTimeout);
    		return;
    	}
        alert('Game Over!'); // 게임 종료 메시지
        // 게임 기록 저장
        $.ajax({
            url: "game_record_insert.do",
            method: "POST",
            data: {
                score: score
            },
            success: function(response) {
            	 if (response.result > 0) {
					console.log('if 문');
            		show_all_record2(response.vo2);
                 }
            },
            error: function(jqXHR, textStatus, errorThrown) {
                console.error('Request failed', textStatus, errorThrown);
            }
        });
        clearTimeout(gameTimeout); // 타이머 클리어
    }, gameDuration);

    $('#startButton').on('click', function() {
    	gameStarted = true; //게임 시작 시 flag 참으로 변경
        validateAndAddWord();
    });

    $('#inputWord').on('keyup', function(event) {
        if (event.which === 13) {
            event.preventDefault();
            gameStarted = true; //게임 시작 시 flag 참으로 변경
            validateAndAddWord();
        }
    });

    function validateAndAddWord() {
        let inputWord = $('#inputWord').val().trim(); // 입력한 단어
        if (inputWord !== '') {
            validateWord(inputWord, function(isValid) {
                if (isValid) {
                    let hangulWord = /^[가-힣]+$/; // 한글 단어 유효성 검사
                    // 입력한 단어가 한글 단어이며, 그리고 입력한 단어의 첫 글자가 현재 참조 단어의 마지막 글자와 같다면
                    if (hangulWord.test(inputWord) && inputWord.charAt(0) === currentWord.charAt(currentWord.length - 1)) {
                        $('#wordList').empty(); // 리스트 비우기
                        let listItem = $('<li>').text('입력한 단어: ' + inputWord); 
                        $('#wordList').append(listItem); // 단어 리스트에 추가

                        // 다음 차례 설정
                        currentWord = inputWord;

                        // 점수 증가
                        score++;

                        // 입력 필드 초기화
                        $('#inputWord').val('');
                    } else if (!hangulWord.test(inputWord)) {
                        alert('한글만 입력!'); // '한글만 입력!' 알림창 표시
                    } else {
                        alert('땡!'); // '땡!' 알림창 표시
                    }
                }
            });
        }
    }
   
    function validateWord(word, callback) {
        $.ajax({
            url: "validateWord/" + word,
            method: "GET",
            success: function(response) {
                if (response.isValid) {
                    // 단어가 사전에 존재
                    callback(true);
                } else {
                    // 단어가 사전에 존재하지 않음
                    alert(response.message);
                    callback(false);
                }
            },
            error: function(jqXHR, textStatus, errorThrown) {
                console.error('Request failed', textStatus, errorThrown);
                callback(false);
            }
        });
    }
    
//     function show_all_record2(){
	function show_all_record2(myResult) {
		console.log(myResult);
	        $.ajax({
            url : "game_ranking_all2.do",
            method : "get",
            data : {
            	gnum : myResult
            },
            success : function(records){
            	let vos = records.vos; // vos 추출
                let vo2 = records.vo2; // vo2 추출
            	
                //랭킹 테이블
                let table = $('<table></table>');
                let header = $('<tr><th>Rank</th><th>Score</th><th>profilepic</th><th>ID</th><th>Gdate</th></tr>')
                let footer = $('<tr></tr>');

                // 다시하기 버튼 추가
                let restartButton = $('<button class="myButton"></button>').text('다시하기');
                let restartButtonCell = $('<td colspan="5"></td>').append(restartButton);
                footer.append(restartButtonCell);
                
                // 오늘의 랭킹 버튼 추가
                let todayRankingButton = $('<button class="myButton"></button>').text('오늘의 랭킹');
                let todayRankingButtonCell = $('<td colspan="5"></td>').append(todayRankingButton);
                footer.append(todayRankingButtonCell);

                table.append(header);
                
             	// 나의 레코드를 첫 번째 행으로 추가
                let row = $('<tr></tr>');
                row.append($('<td></td>').text('내 점수'));
                row.append($('<td></td>').text(vo2.score));
                let img = $('<img>').attr('src', "resources/uploadimg/thumb_" + vo2.profilepic);
                row.append($('<td></td>')).append(img);
                row.append($('<td></td>').text(vo2.id));
                row.append($('<td></td>').text(vo2.gdate));
                table.append(row);
                
                vos.forEach(function(record, index){
                	let newIndex = index + 1; // 1부터 시작
                    let row = $('<tr></tr>');
                    row.append($('<td></td>').text(newIndex + 1)); // 2,3,4...
                    row.append($('<td></td>').text(record.score));
                    let img = $('<img>').attr('src', "resources/uploadimg/thumb_" + record.profilepic);
                    row.append($('<td></td>')).append(img);
                    row.append($('<td></td>').text(record.id));
                    row.append($('<td></td>').text(record.gdate));
                    table.append(row);
                });
                table.append(footer);
                $('#rankingContent').html(table);
                    
                // 게임 플레이 화면 숨기고 랭킹 화면 보이기
                $('#showRank').hide();
                $('#gameContent').hide();
                $('#rankingContent').show();
                
                restartButton.click(function() {
                    // 다시하기 버튼이 클릭되면 랭킹 화면 숨기고 게임 플레이 화면 보이기
                    $('#rankingContent').hide();
                    $('#gameContent').show();
                    $('#showRank').show();
                    
                    gameStart();
                });//end restartButton()
                
                todayRankingButton.click(function(myResult){
                    $.ajax({
                        url: "game_ranking_today2.do",
                        method: "GET",
                        data : {
                        	gnum : myResult.gnum,
                        },
                        success: function(records) {
                        	let vos = records.vos; // vos 추출
                            let vo2 = records.vo2; // vo2 추출
                        	
                            // 랭킹 테이블
                            let table = $('<table></table>');
                            let header = $('<tr><th>Rank</th><th>Score</th><th>profilepic</th><th>ID</th><th>Gdate</th></tr>');
                            let footer = $('<tr></tr>');
                            
                            // 다시하기 버튼 추가
                            let restartButton = $('<button class="myButton"></button>').text('다시하기');
                            let restartButtonCell = $('<td colspan="5"></td>').append(restartButton);
                            footer.append(restartButtonCell);
                            
                            // 역대 랭킹 버튼 추가
                            let allTimeRankingButton = $('<button class="myButton"></button>').text('역대 랭킹');
                            let allTimeRankingButtonCell = $('<td colspan="5"></td>').append(allTimeRankingButton);
                            footer.append(allTimeRankingButtonCell);

                            table.append(header);
                            
                         	// 나의 레코드를 첫 번째 행으로 추가
                            let row = $('<tr></tr>');
                            row.append($('<td></td>').text('내 점수'));
                            row.append($('<td></td>').text(vo2.score));
                            let img = $('<img>').attr('src', "resources/uploadimg/thumb_" + vo2.profilepic);
                            row.append($('<td></td>')).append(img);
                            row.append($('<td></td>').text(vo2.id));
                            row.append($('<td></td>').text(vo2.gdate));
                            table.append(row);
                            
                            vos.forEach(function(record, index) {
                            	let newIndex = index + 1; // 1부터 시작
                                let row = $('<tr></tr>');
                                row.append($('<td></td>').text(newIndex + 1)); // 2,3,4,5...
                                row.append($('<td></td>').text(record.score));
                                let img = $('<img>').attr('src', "resources/uploadimg/thumb_" + record.profilepic);
                                row.append($('<td></td>')).append(img);
                                row.append($('<td></td>').text(record.id));
                                row.append($('<td></td>').text(record.gdate));
                                table.append(row);
                            });
                            table.append(footer);
                            $('#rankingContent').html(table);

                            // 다시하기 버튼 클릭 이벤트 핸들러
                            restartButton.click(function() {
                                // 다시하기 버튼이 클릭되면 랭킹 화면 숨기고 게임 플레이 화면 보이기
                                $('#rankingContent').hide();
                                $('#gameContent').show();

                                gameStart();
                            });

                            // 역대 랭킹 버튼 클릭 이벤트 핸들러
                            allTimeRankingButton.click(function() {
                                // 여기서 "show_all_record()" 함수를 다시 호출하여 역대 랭킹을 불러옵니다.
                                show_all_record();
                            });

                        },
                        error: function(jqXHR, textStatus, errorThrown) {
                            console.error('Request failed', textStatus, errorThrown);
                        }
                    });//end ajax
                });//end todayRankingButton()
                
            },
            error: function(jqXHR, textStatus, errorThrown){
                console.error('Request failed', textStatus, errorThrown);
            }
        });//end ajax
    }//end show_all_record2()
    
    window.show_all_record = function() {
        $.ajax({
            url : "game_ranking_all.do",
            method : "get",
            success : function(records){            	
                //랭킹 테이블
                let table = $('<table></table>');
                let header = $('<tr><th>Rank</th><th>Score</th><th>profilepic</th><th>ID</th><th>Gdate</th></tr>')
                let footer = $('<tr></tr>');

                // 다시하기 버튼 추가
                let restartButton = $('<button class="myButton"></button>').text('다시하기');
                let restartButtonCell = $('<td colspan="5"></td>').append(restartButton);
                footer.append(restartButtonCell);
                
                // 오늘의 랭킹 버튼 추가
                let todayRankingButton = $('<button class="myButton"></button>').text('오늘의 랭킹');
                let todayRankingButtonCell = $('<td colspan="5"></td>').append(todayRankingButton);
                footer.append(todayRankingButtonCell);

                table.append(header);
                
                records.forEach(function(record, index){
                    let row = $('<tr></tr>');
                    row.append($('<td></td>').text(index + 1)); // 1,2,3,4... 
                    row.append($('<td></td>').text(record.score));
                    let img = $('<img>').attr('src', "resources/uploadimg/thumb_" + record.profilepic);
                    row.append($('<td></td>')).append(img);
                    row.append($('<td></td>').text(record.id));
                    row.append($('<td></td>').text(record.gdate));
                    table.append(row);
                });
                table.append(footer);
                $('#rankingContent').html(table);
                    
                // 게임 플레이 화면 숨기고 랭킹 화면 보이기
                $('#showRank').hide();
                $('#gameContent').hide();
                $('#rankingContent').show();
                
                restartButton.click(function() {
                    // 다시하기 버튼이 클릭되면 랭킹 화면 숨기고 게임 플레이 화면 보이기
                    $('#rankingContent').hide();
                    $('#gameContent').show();
                    $('#showRank').show();
                    
                    gameStart();
                });//end restartButton()
                
                todayRankingButton.click(function(){
                    $.ajax({
                        url: "game_ranking_today.do",
                        method: "GET",
                        success: function(records) {
                            // 랭킹 테이블
                            let table = $('<table></table>');
                            let header = $('<tr><th>Rank</th><th>Score</th><th>profilepic</th><th>ID</th><th>Gdate</th></tr>');
                            let footer = $('<tr></tr>');
                            
                            // 다시하기 버튼 추가
                            let restartButton = $('<button class="myButton"></button>').text('다시하기');
                            let restartButtonCell = $('<td colspan="5"></td>').append(restartButton);
                            footer.append(restartButtonCell);
                            
                            // 역대 랭킹 버튼 추가
                            let allTimeRankingButton = $('<button class="myButton"></button>').text('역대 랭킹');
                            let allTimeRankingButtonCell = $('<td colspan="5"></td>').append(allTimeRankingButton);
                            footer.append(allTimeRankingButtonCell);

                            table.append(header);
                            
                            records.forEach(function(record, index) {
                                let row = $('<tr></tr>');
                                row.append($('<td></td>').text(index + 1)); // 1,2,3,4...
                                row.append($('<td></td>').text(record.score));
                                let img = $('<img>').attr('src', "resources/uploadimg/thumb_" + record.profilepic);
                                row.append($('<td></td>')).append(img);
                                row.append($('<td></td>').text(record.id));
                                row.append($('<td></td>').text(record.gdate));
                                table.append(row);
                            });
                            table.append(footer);
                            $('#rankingContent').html(table);

                            // 다시하기 버튼 클릭 이벤트 핸들러
                            restartButton.click(function() {
                                // 다시하기 버튼이 클릭되면 랭킹 화면 숨기고 게임 플레이 화면 보이기
                                $('#rankingContent').hide();
                                $('#gameContent').show();

                                gameStart();
                            });

                            // 역대 랭킹 버튼 클릭 이벤트 핸들러
                            allTimeRankingButton.click(function() {
                                // 여기서 "show_all_record()" 함수를 다시 호출하여 역대 랭킹을 불러옵니다.
                                show_all_record();
                            });

                        },
                        error: function(jqXHR, textStatus, errorThrown) {
                            console.error('Request failed', textStatus, errorThrown);
                        }
                    });//end ajax
                });//end todayRankingButton()
                
            },
            error: function(jqXHR, textStatus, errorThrown){
                console.error('Request failed', textStatus, errorThrown);
            }
        });//end ajax
    }//end show_all_record()
}
</script>
</head>
<body onload="gameStart()">
    <jsp:include page="../../top_menu.jsp"></jsp:include>
    <jsp:include page="../mini_top_menu.jsp"></jsp:include>
    <h1>mini/game/game.jsp</h1>
    <div
        style="background-image: url('resources/uploadimg/${mh_attr.backimg}'); background-size: cover; width: 100%; height: 100vh;">
        <div id="gameContainer">
            <div id="gameBackground">
                <p id="remainingTime">남은 시간: 10</p>
            </div>
            <div id="gameContent">
                <h2>끝말잇기 게임</h2>
                <p>시작 단어: 사과</p>
                <ul id="wordList"></ul>
                <input type="text" id="inputWord" placeholder="단어를 입력하세요">
                <button id="startButton">다음 단어</button><br>
		       	<button id="showRank" onclick="show_all_record()" class="myButton" style="position: absolute; top: 50%; right: 0; transform: translateY(-50%);">랭킹보기</button>
            </div>
            <div id="rankingContent" style="display: none;">
            </div>
        </div>
    </div>
</body>
</html>