<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.net.*"%>
<%@ page import ="kjwdao.*" %>
<%
	System.out.println("----------modifyEmp.jsp----------");
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
	
	ArrayList<HashMap<String, Object>> selectAdmin = AdminDAO.selectAdmin(adminId, pw, hireDate, post);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>관리자 정보변경</h1>
	<form action="modifyEmpAction.jsp" method="post">
		<div>
			관리자ID:
			<input type="text" name="id" value="<%=adminId%>">
		</div>
		<div>	
			비밀번호:
			<input type="password" name="pw">
		</div>
		<div>	
			입사일:
			<input type="date" name="hireDate" value="<%=hireDate%>">
		</div>
		<div>	
			직책:
			<input type="text" name="post" value="<%=post%>">
		</div>	
			<button type="submit">저장</button>
	</form>
</body>
</html>