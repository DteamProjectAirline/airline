<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="dao.QnaDAO"%>
<%@ page import = "java.sql.*" %>
<%@ page import="java.util.*"%>
<%@ page import="java.net.*"%>
<%
	//인증분기: 세션변수 이름
%>
<%
	
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
</head>
<body>
	<h1>QnA등록</h1>
	<form action="/D_airline/emp/qnaManageAddAction" method="post">
		<div>
			제목:
			<input type="text" name="qnaTitle">
		</div>
		<div>
			내용:
			<textarea rows="10" cols="60" name="qnaContent"></textarea>
		</div>
		<button type="submit">저장</button>
	</form>
</body>
</html>