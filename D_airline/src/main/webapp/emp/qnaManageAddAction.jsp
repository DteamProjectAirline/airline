<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.net.*"%>
<%@ page import ="kjwdao.*" %>
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
	
	String adminId = request.getParameter("adminId");
	String title = request.getParameter("title");
	String content = request.getParameter("content");
	//디버깅 코드
	System.out.println(adminId+"<--adminId");
	System.out.println(title+"<--title");
	System.out.println(content+"<--content");
	
	//모델 호출 코드
	int QaRow = QnaDAO.qaInsert(adminId, title, content);
	
	if(QaRow==1){ 
		System.out.println("질문 등록에 성공하였습니다.");
		String msg = URLEncoder.encode("질문 등록에 성공하였습니다.", "UTF-8");
		response.sendRedirect("/D_airline/emp/qnaManage.jsp?msg="+msg);
	}else{
		System.out.println("질문 등록에 실패하였습니다.");
		String msg = URLEncoder.encode("질문 등록에 실패하였습니다.", "UTF-8");
		response.sendRedirect("/D_airline/emp/qnaManageAddForm.jsp?msg="+msg);
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