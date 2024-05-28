<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="pjhdao.QnaDAO"%>
<%@ page import = "java.sql.*" %>
<%@ page import="java.util.*"%>
<%@ page import="java.net.*"%>
<%
	System.out.println("----------qnaManageModifyAction.jsp----------");
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
	String content = request.getParameter("content");
	String qnaId = request.getParameter("qnaId");
	
	System.out.println(title+"<--title");
	System.out.println(content+"<--content");
	System.out.println(qnaId+"<--qnaId");
	
	int QaRow = QnaDAO.qaModify(title, content, qnaId);
	System.out.println(QaRow+"<--QaRow");
	
	if(QaRow==1){
		System.out.println("질문을 변경하는데 성공하였습니다.");
		String msg = URLEncoder.encode("질문을 변경하는데 성공하였습니다.", "UTF-8");
		response.sendRedirect("/D_airline/emp/qnaManage.jsp?msg=" + msg);
	}else{
		System.out.println("질문을 변경하는데 실패하였습니다.");
		String msg = URLEncoder.encode("질문을 변경하는데 실패하였습니다.", "UTF-8");
		response.sendRedirect("/D_airline/emp/qnaManage.jsp?msg=" + msg);
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	
</body>
</html>