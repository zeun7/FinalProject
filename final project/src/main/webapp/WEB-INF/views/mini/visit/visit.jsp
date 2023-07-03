<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html>	
<head>
<title>방명록</title>
<jsp:include page="../../css.jsp"></jsp:include>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>

</head>
<body>
    <jsp:include page="../../top_menu.jsp"></jsp:include>
    <jsp:include page="../mini_top_menu.jsp"></jsp:include>
    <h1>mini/visit/visit.jsp</h1>
    <div style="background-image: url('resources/uploadimg/${mh_attr.backimg}'); background-size: cover; width: 100%; height: 100vh;">
        <h1>방명록</h1>
    </div>
</body>

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

</html>