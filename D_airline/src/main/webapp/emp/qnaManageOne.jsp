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
	String createDate = request.getParameter("createDate");
	String updateDate = request.getParameter("updateDate");
	System.out.println(title+"<--title");
	System.out.println(content+"<--content");
	System.out.println(qnaId+"<--qnaId");
	System.out.println(createDate+"<--createDate");
	System.out.println(updateDate+"<--updateDate");
	
	//관리자 QnA리스트에서 상세보기로 넘어갈때
	ArrayList<HashMap<String, Object>> qaSelect = QnaDAO.qaSelect(title);
	System.out.println(title+"<--title");

	//상세보기 페이지에 데이터(제목,내용) 출력
	ArrayList<HashMap<String, Object>> qaInfo = QnaDAO.qaInfo(qnaId, title, content, createDate, updateDate);
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
			<input type="hidden" name="qnaId" value="<%=qnaId%>">
			<div>
				제목: 
				<input type="text" name="title" value="<%=m.get("title")%>">
			</div>	
			<div>내용:</div>
			<div>	
				<textarea name="content" rows="10" cols="60" style="white-space:pre-line">
					<%= m.get("content")%>
				</textarea>
			</div>
			<div>
				생성:<%=m.get("createDate")%>
			</div>
			<div>
				수정:<%=m.get("updateDate")%>
			</div>
			<button type="submit" class="btn btn-outline-primary">수정</button>
		</form>	
	<%
		}
	%>
	
</body>
</html>