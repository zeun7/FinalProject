<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<a href="home.do">home</a>
	
	<hr>
	<a href="b_selectAll.do">b_selectAll</a>
	<a href="b_selectOne.do?bnum=3">b_selectOne</a>
	<a href="b_insert.do">b_insert</a>
	<a href="b_update.do">b_update</a>
	<a href="b_insertOK.do?bname=게시판1&caname=일반&writer=tester2&title=제목11&content=내용11">b_insertOK</a>
	<a href="b_updateOK.do?bnum=10&title=updated&content=updatecontent">b_updateOK</a>
	<a href="b_deleteOK.do?bnum=5">b_deleteOK</a>
	
	<hr>
	<a href="json_b_selectAll.do?bname=게시판1&page=1&limit=10">json_b_selectAll</a>
	<a href="json_b_searchList.do?bname=게시판1&page=1&limit=10&searchKey=title&searchWord=1">json_b_searchList:title</a>
	<a href="json_b_searchList.do?bname=게시판1&page=1&limit=10&searchKey=content&searchWord=1">json_b_searchList:content</a>
	<a href="json_b_searchList.do?bname=게시판1&page=1&limit=10&searchKey=writer&searchWord=2">json_b_searchList:writer</a>
	<a href="json_b_like.do">json_b_like</a>
	<a href="json_b_report.do">json_b_report</a>

</body>
</html>