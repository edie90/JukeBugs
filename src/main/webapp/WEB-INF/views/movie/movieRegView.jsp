<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h2>[ 영화등록 ]</h2>

<form action="movieReg" method="post" enctype="multipart/form-data">
	<table border="1" style="width:500px;">
		<tr>
			<td>영화제목</td>
			<td><input type="text" id="title" name="title" /></td>
		</tr>
		<tr>
			<td>영화감독</td>
			<td><input type="text" id="director" name="director" /></td>
		</tr>
		<tr>
			<td>주연배우</td>
			<td><input type="text" id="actor" name="actor" /></td>
		</tr>
		<tr>
			<td>장르</td>
			<td>
				<select id="genre" name="genre">
					<option value="액션">액션</option>
					<option value="스릴러">스릴러</option>
					<option value="호러">호러</option>
					<option value="에로">에로</option>
					<option value="로맨스">로맨스</option>
				</select>
			</td>
		</tr>
		<tr>
			<td>영화포스터</td>
			<td><input type="file" id="file" name="file" /></td>
		</tr>
		<tr>
			<td colspan="2">
				<input type="submit" value="영화등록" />
				<input type="button" value="취소" onclick="location:href='/movieList'" />
		</tr>
	</table>
</form>
</body>
</html>