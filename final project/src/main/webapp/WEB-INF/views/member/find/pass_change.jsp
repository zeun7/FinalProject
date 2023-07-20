<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
    <link rel="stylesheet"
        href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <title>비밀번호 찾기</title>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
    <script src="https://kit.fontawesome.com/7ed6703c9d.js" crossorigin="anonymous"></script>
    <script type="text/javascript">
   
    	$(function() {
    		$("#Email").click(function() {
    			location.href = 'find_pw_from.do';
    		})
    	})
   
    function submitForm() {
        var pw1 = document.getElementById("pw1").value;
        var pw2 = document.getElementById("pw2").value;

        if (pw1 !== pw2 || pw1.length < 6 || pw2.length < 6) {
            alert("비밀번호가 일치하지 않거나 입력한 글자가 6글자 이상이어야 합니다.");
            return;
        }

        document.getElementById("joinForm").submit();
    }
    </script>

    <style>
    .card {
        padding: 80px 30px; /* 상단/하단 80px, 좌우 30px의 공간을 설정합니다. */
        margin: 0 auto;
        max-width: 900px;
    }
    </style>
</head>
<body>
    <jsp:include page="../../sidebar.jsp"></jsp:include>
    <jsp:include page="../../navbar.jsp"></jsp:include>
    <div class="main-panel">
        <div class="content">
            <div class="row">
                <div class="col-md-12">
                    <div class="card">
                        <div class="card-header" style="text-align: center;">
                            <h3>비밀번호 변경</h3>
                        </div>
                        <div>
                            <form id="joinForm" action="pass_change.do" method="post">
                                <br> <br>
                                <p>
                                <div>
                                    <strong>변경할 비밀번호 입력:</strong>
                                </div>
                                <div>
                                <input type="hidden" name="id" id="id" value="${vo.id} ">
                                    <input class="w3-input" type="password" id="pw1" name="pw"
                                        placeholder="비밀번호" >
                                    <h6 style="color: green;">※ 6글자 이상으로 작성해 주세요</h6>
                                    <input class="w3-input" type="password" id="pw2" name="pw2"
                                        placeholder="비밀번호 한번더 입력" >
                                </div>
                                <button type="button" class="w3-button w3-block w3-ripple w3-margin-top w3-round"
                                    style="background-color: #94b5e0" onclick="submitForm()">비밀번호
                                    변경</button>


                                <button type="button" id="Email"
                                    class="w3-button w3-block w3-ripple w3-margin-top w3-round"
                                    style="background-color: #94b5e0">Cancel</button>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <jsp:include page="../../footer.jsp"></jsp:include>
    </div>
</body>
</html>