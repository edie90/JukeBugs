<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<h2>[ 첫 화면 ]</h2>
<ul>
	<c:if test="${ empty loginName }">
		<li><a href="joinView">회원가입</a></li>
		<li><a href="loginView">로그인</a></li>
	</c:if>
	<c:if test="${not empty loginName }">
		<li> 로그인한 유저 : ${loginName }</li>
		<li><a href="logout">로그아웃</a></li>
		<li><a href="#">개인정보 수정</a><br /></li>
	</c:if>
	<li><a href="movieList">영화정보 목록</a></li>
</ul>
</body>
</html>