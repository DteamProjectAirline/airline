<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.net.*" %>

<%
	System.out.println("-----loginForm.jsp-----");



//로그인 화면에서 받을 에러메세지 변수생성
String msg = null;

if(request.getParameter("msg")!=null){
	msg = request.getParameter("msg");
}

System.out.println("로그인 액션에서 넘겨받은 msg값 : "+request.getParameter("msg"));

%>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>loginForm</title>
</head>
	<body>
		
			<label for ="id">아이디</label>
			<input name = "id" type="text" placeholder="Email address" required>
			
			<label for ="pw">비밀번호</label>
			<input name = "pw" type="password" required>
		
		
		
	
	</body>
</html>