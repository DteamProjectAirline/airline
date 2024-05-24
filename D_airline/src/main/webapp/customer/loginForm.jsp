<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.net.*" %>

<%
	System.out.println("-----loginForm.jsp-----");

//로그인 화면에서 받을 에러메세지 변수생성
String msg = null;

if(request.getParameter("msg")!=null){
	msg = request.getParameter("msg");
}

System.out.println("[param]msg값 : "+request.getParameter("msg"));


%>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>loginForm</title>
	
</head>
	<body>
		<form Action ="/D_airline/customer/loginAction.jsp" method = "post">
			<div>
				<label for ="customer">고객</label>
				<input name = "type" type="radio" value="customer" required>
				
				<label for ="admin">관리자</label>
				<input name = "type" type="radio" value="admin"  required>
			</div>
			<div>
				<label for ="id">아이디</label>
				<input name = "id" type="text" placeholder="Email address" required>
				
				<label for ="pw">비밀번호</label>
				<input name = "pw" type="password" placeholder="password" required>
			</div>
			<button type="submit">제출하기</button>
		
		</form>
		
	
	</body>
</html>