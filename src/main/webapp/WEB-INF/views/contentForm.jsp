<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>글 내용</title>
</head>
<body>
	<h2>글 내용</h2>
	<form action="updateAction" method="post">
		<table width="500" cellpadding="0" cellspacing="0" border="1">
		<input type="hidden" name="board_idx" value="${ dto.board_idx }" />
			<tr>
				<td>번호</td>
				<td>${ dto.board_idx }</td>
			</tr>
			<tr>
				<td>조회수</td>
				<td>${ dto.board_hit }</td>
			</tr>
			<tr>
				<td>이름</td>
				<td><input type="text" name="board_name" value="${ dto.board_name }" size="50"></td>
			</tr>
			<tr>
				<td>제목</td>
				<td><input type="text" name="board_title" value="${ dto.board_title }" size="50"></td>
			</tr>
			<tr>
				<td>내용</td>
				<td><textarea rows="10" cols="50" name="board_content"> ${ dto.board_idx } </textarea></td>
			</tr>
			<tr>
				<td colspan="2">
					&nbsp;&nbsp;<input type="submit" value="수정하기">&nbsp;&nbsp;
					<a href="listForm"><input type="button" value="목록보기"></a>&nbsp;&nbsp;
					<a href="deleteAction?board_idx=${ dto.board_idx }"><input type="button" value="삭제하기"></a>
				</td>
				<td></td>
			</tr>
		</table>
	</form>
</body>
</html>