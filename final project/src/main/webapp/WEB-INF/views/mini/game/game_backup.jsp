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
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
<script type="text/javascript">
function gameStart() {
    let currentWord = '사과'; // 시작 단어

    $('#startButton').on('click', function() {
        validateAndAddWord();
    });

    $('#inputWord').on('keyup', function(event) {
        if (event.which === 13) {
            event.preventDefault();
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
}
</script>
</head>
<body onload="gameStart()">
    <jsp:include page="../mini_top_menu.jsp"></jsp:include>
    <h1>mini/game/game.jsp</h1>
    <div
        style="background-image: url('resources/uploadimg/${mh_attr.backimg}'); background-size: cover; width: 100%; height: 100vh;">
        <div id="gameContainer">
            <div id="gameBackground"></div>
            <div id="gameContent">
                <h2>끝말잇기 게임</h2>
                <p>시작 단어: 사과</p>
                <ul id="wordList"></ul>
                <input type="text" id="inputWord" placeholder="단어를 입력하세요">
                <button id="startButton">다음 단어</button>
            </div>
        </div>
    </div>
            <input type="text" id="test" onkeyup="chk_han('test')"/>
</body>
</html>