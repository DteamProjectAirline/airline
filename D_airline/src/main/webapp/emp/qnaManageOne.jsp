<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="dao.QnaDAO"%>
<%@ page import = "java.sql.*" %>
<%@ page import="java.util.*"%>
<%@ page import="java.net.*"%>
<%
	System.out.println("----------qnaManageAddAction.jsp----------");
	System.out.println("세션 ID: " + session.getId());

	if (session.getAttribute("loginAd") == null){
	System.out.println("관리자만 접근 가능한 페이지입니다.");
	String msg = URLEncoder.encode("관리자만 접근 가능한 페이지입니다.","UTF-8");
		response.sendRedirect("/D_airline/customer/flightMain.jsp?msg="+msg);
	return;
	}
%>
<%
	String title = request.getParameter("title");
	//String content = request.getParameter("content");
	System.out.println(title+"<--title");
	//System.out.println(content+"<--content");
	
	ArrayList<HashMap<String, Object>> qaInfo = QnaDAO.qaInfo(title);
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
</head>
<body>
	<h1>QnA 상세보기</h1>
	<%
		for(HashMap<String, Object> m : qaInfo){
	%>
		<div>제목: <%=m.get("title")%></div>
		<div>내용: <%=m.get("content")%></div>
	<%
		}
	%>
</body>
</html>