<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="dao.*"%>
<%@ page import = "java.sql.*" %>
<%@ page import="java.util.*"%>
<%@ page import="java.net.*"%>
<%
	System.out.println("----------qnaManageAddForm.jsp----------");
	System.out.println("세션 ID: " + session.getId());
	
	String msg = null;
	
	//인증분기: 세션변수 이름
	if (session.getAttribute("loginAd") == null){
	System.out.println("관리자만 접근 가능한 페이지입니다.");
	msg = URLEncoder.encode("관리자만 접근 가능한 페이지입니다.","UTF-8");
		response.sendRedirect("/D_airline/customer/flightMain.jsp?msg="+msg);
	return;
}
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
	<form action="/D_airline/emp/qnaManageAddAction.jsp" method="post">
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