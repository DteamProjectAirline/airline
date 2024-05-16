<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="dao.QnaDAO"%>
<%@ page import = "java.sql.*" %>
<%@ page import="java.util.*"%>
<%@ page import="java.net.*"%>
<%
	System.out.println("----------qnaManageOne.jsp----------");
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
	
	//관리자 QnA리스트에서 상세보기로 넘어갈때
	ArrayList<HashMap<String, Object>> qaSelect = QnaDAO.qaSelect(title);
	//상세보기 페이지에 데이터(제목,내용) 출력
	ArrayList<HashMap<String, Object>> qaInfo = QnaDAO.qaInfo(qnaId, title, content);
	System.out.println(qaInfo+"<--qaInfo");
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
		<form action="/D_airline/emp/qnaManageModifyAction.jsp" method="post">
			제목:<input type="hidden" name="title" value="<%=qnaId%>">
				<input type="text" name="modifiedTitle" value="<%=m.get("title")%>">
		</form>
		<form action="/D_airline/emp/qnaManageModifyAction.jsp" method="post">
		<div>내용: </div>
				<input type="hidden" name="qnaId" value="<%=qnaId%>">
				<textarea name="content" rows="10" cols="60"><%=m.get("content")%></textarea>
				<button type="submit" class="btn btn-outline-primary">수정</button>
		</form>
	<%
		}
	%>
	
</body>
</html>