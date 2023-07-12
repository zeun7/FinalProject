<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<jsp:include page="../../css.jsp"></jsp:include>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
<script type="text/javascript">
let page = 1;
let curPage = 1; 
let mh_attr_id = '${mh_attr.id}';

$(function(){	//이용자가 보유한 peach 개수 출력
	$.ajax({
		url : "json_peach_count.do",
		method : 'get',
		data : {
			id : '${user_id}'
		},
		dataType : 'json',
		success : function(vo){
			$('#peach').html(vo.peach);
		},
		error : function(xhr, status, error){
			console.log('xhr', xhr.status);
		}
	});//end ajax
});//end onlaod

function selectAllCount(){ // 음악 목록의 페이징 버튼 출력
	$.ajax({
		url : "json_musicPay_count.do",
		method : 'GET',
		dataType : 'json',
		success : function(result){
			let tag_page = 0;
			let tag_pages = '';
			
			while(result > 0){
				tag_page++;
				tag_pages += `
					<button onclick=selectAll(\${tag_page})>\${tag_page}</button>
				`;
				result -= 10;
			}
			
			if(curPage > tag_page){
				curPage = tag_page;
			}
			selectAll(curPage);
			
			$("#page").html(tag_pages);
		},
		error : function(xhr, status, error){
			console.log('xhr:',xhr.status);
		}
	});//end $.ajax()
}//end selectAllCount()

function selectAll(page){
	$.ajax({
		url : "json_musicPay_selectAll.do",
		method : 'get',
		data : {
			page : page
		},
		dataType : 'json',
		success : function(arr){
			let tag_vos = '';
			for(let i in arr){
				let vo = arr[i];
				console.log(vo);
				tag_vos +=`
					<tr>
					<td>\${vo.bgm}</td>
					<td><button id="btn_\${i}" onclick="showMusicPlayer('btn_\${i}', '\${vo.bgm}')">\${vo.bgm}</button></td>
					<td><button onclick="jukebox_check('\${vo.bgm}')">구매하기</button></td>
		        	</tr>	
				`;
			}
			$("#vos").html(tag_vos);
			curPage = page;
		},
		error : function(xhr, status, error){
			console.log('xhr', xhr.status);
		}
	});//end ajax()
}//end selectAll()

function showMusicPlayer(btn_id ,bgm){
    console.log(bgm);
    let audio=`
        <audio controls autoplay>
            <source src="resources/uploadbgm/\${bgm}" type="audio/mp3">
        </audio>
    `;
    $("#"+btn_id).html(audio);
}

function jukebox_check(bgm){	//구매하려는 곡이 사용자의 보관함에 있는지 확인
	$.ajax({
		url : "json_jukebox_check.do",
		method : 'get',
		data : {
			id: '${user_id}',
			bgm: bgm
		},
		dataType : 'json',
		success : function(result){
			if(result == 1){
				alert('이미 구매한 곡입니다.');
			}else{
				gotoMusic_selectOne(bgm);
			}
		},
		error : function(xhr, status, error){
			console.log('xhr', xhr.status);
		}
	});//end ajax()
}//end jukebox_check()

function gotoMusic_selectOne(bgm){
	console.log(bgm);
	window.location.href="musicPay_selectOne.do?bgm="+bgm;
}
</script>
</head>
<body onload="selectAllCount()">
<jsp:include page="../../top_menu.jsp"></jsp:include>
<h1>musicPay_selectAll</h1>
<div>
	보유 peach:<span id="peach"></span>
</div>
	<table>
		<thead>
			<tr>
				<th>노래제목</th>
				<th>미리듣기</th>
				<th>구매</th>
			</tr>
		</thead>
		<tbody id="vos">
		
		</tbody>
		<tfoot>
			<tr><td id="page"></td></tr>
		</tfoot>
	</table>
</body>
</html>