<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h2>[ 영화 목록 ]</h2>
<p>총 등록편수 : ${count}</p>

<table border="1" style="width:500px">
	<tr>
		<th>번호</th>
		<th>영화제목</th>
		<th>감독</th>
		<th>주연배우</th>
		<th>장르</th>
	</tr>
	<c:forEach var="m" items="${movie }">
	<tr>
		<td>${m.seq}</td>
		<td>${m.title }</td>
		<td>${m.director }</td>
		<td>${m.actor }</td>
		<td>${m.genre }</td>
	</tr>
	</c:forEach>
	
</table>
<a href="movieRegView">영화등록</a>


</body>
</html>