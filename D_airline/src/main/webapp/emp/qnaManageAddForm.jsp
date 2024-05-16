<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="dao.*"%>
<%@ page import = "java.sql.*" %>
<%@ page import="java.util.*"%>
<%@ page import="java.net.*"%>
<%
	System.out.println("----------qnaManageAddForm.jsp----------");
	System.out.println("세션 ID: " + session.getId());
		
	if (session.getAttribute("loginAd") == null){
	System.out.println("관리자만 접근 가능한 페이지입니다.");
	String msg = URLEncoder.encode("관리자만 접근 가능한 페이지입니다.","UTF-8");
		response.sendRedirect("/D_airline/customer/flightMain.jsp?msg="+msg);
	return;
	}
%>
<%
	HashMap<String, Object> m = new HashMap<>();
	
	//변수할당
	m = (HashMap<String, Object>) (session.getAttribute("loginAd"));
	
	String adminId = null;
	
	//해쉬맵 변수 스트링변수에 할당
	adminId = (String) (m.get("adminId"));
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
			관리자ID:
			<input type="text" name="adminId" value=<%=adminId%> readonly>
		</div>
		<div>
			제목:
			<input type="text" name="title">
		</div>
		<div>
			내용:
			<textarea rows="10" cols="60" name="content"></textarea>
		</div>
		<button type="submit">저장</button>
	</form>
</body>
</html>