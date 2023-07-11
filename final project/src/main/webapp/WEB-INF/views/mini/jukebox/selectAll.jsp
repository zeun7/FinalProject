<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html>
<head>
<style>
    table {
        border-collapse: collapse;
        width: 100%;
    }
    
    th, td {
        border: 1px solid black;
        padding: 8px;
        text-align: left;
    }
    
    th {
        background-color: lightgray;
    }
</style>
<title>쥬크박스</title>
<jsp:include page="../../css.jsp"></jsp:include>
<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.4/moment-with-locales.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
<script type="text/javascript">
let page = 1;
let curPage = 1; 
let mh_attr_id = '${mh_attr.id}';
function selectAllCount(){ // 음악 목록의 페이징 버튼 출력
	$.ajax({
		url : "json_j_count.do",
		method : 'GET',
		data : {
			id : mh_attr_id
		},
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
		url : "json_j_selectAll.do",
		method : 'get',
		data : {
			id : mh_attr_id,
			page : page
		},
		dataType : 'json',
		success : function(arr){
			let tag_vos = '';
			for(let i in arr){
				let vo = arr[i];
				let date = moment(vo.jdate).format('YY/MM/DD HH시mm분ss초');
				console.log(vo);
				tag_vos +=`
					<tr>
					<td><button id="btn_\${i}" onclick="showMusicPlayer('btn_\${i}', '\${vo.bgm}')">\${vo.bgm}</button></td>
					<td>\${date}</td>
		        	</tr>	
				`;
			}
			$("#vos").html(tag_vos);
			curPage = page;
		},
		error : function(xhr, status, error){
			console.log('xhr', xhr.status);
		}
	});//end $.ajax()
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

function buyPeach(){
	window.location.href="mini_peachPay.do?id=${mh_attr.id}";
}

function buyBGM(){
	window.location.href="mini_peachPay.do?id=${mh_attr.id}";
}
</script>

</head>
<body onload="selectAllCount()">
    <jsp:include page="../../top_menu.jsp"></jsp:include>
    <jsp:include page="../mini_top_menu.jsp"></jsp:include>
    <h1>mini/jukebox/selectAll.jsp</h1>
    <div style="background-image: url('resources/uploadimg/${mh_attr.backimg}'); background-size: cover; width: 100%; height: 100vh;">
        <h1>쥬크박스</h1>
        <button onclick="buyPeach()" class="myButton">peach 결제하기</button>
        <button onclick="buyBGM()" class="myButton">음악 구매하기</button>
        <table>
        	<thead>
	        	<tr>
	        		<th>보유 음악</th>
	        		<th>구매 일자</th>
	        	</tr>
        	</thead>
        	<tbody id="vos">
        		
        	</tbody>
        	<tfoot>
        		<tr>
        			<td colspan="2" id="page"></td>
        		</tr>
        	</tfoot>
        </table>
    </div>
</body>
</html>