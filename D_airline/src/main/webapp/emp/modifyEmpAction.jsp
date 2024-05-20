<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.net.*"%>
<%@ page import ="dao.*" %>
<%
	System.out.println("----------modifyEmpAction.jsp----------");
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
	String pw = request.getParameter("pw");
	String hireDate = request.getParameter("hireDate");
	String post = request.getParameter("post");
	
	System.out.println(adminId+"<--adminId");
	System.out.println(pw+"<--pw");
	System.out.println(hireDate+"<--hireDate");
	System.out.println(post+"<--post");
	
	int modifyEmp = AdminDAO.modifyEmp(adminId, pw, hireDate, post);
	
	if(modifyEmp==1){
		System.out.println("관리자정보를 변경하는데 성공하였습니다.");
		String msg = URLEncoder.encode("관리자정보를 변경하는데 성공하였습니다.","UTF-8");
		response.sendRedirect("/D_airline/emp/modifyEmp.jsp?msg="+msg);
	}else{
		System.out.println("관리자정보를 변경하는데 실패하였습니다.");
		String msg = URLEncoder.encode("관리자정보를 변경하는데 실패하였습니다.","UTF-8");
		response.sendRedirect("/D_airline/emp/modifyEmpAction.jsp?msg="+msg);
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