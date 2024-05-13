<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="dao.QnaDAO"%>
<%@ page import = "java.sql.*" %>
<%@ page import="java.util.*"%>
<%
	int currentPage = 1; //현재페이지
	
	if(request.getParameter("currentPage") != null){
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	
	int rowPerPage = 7; //한 페이지당 출력할 row개수
	int startRow = (currentPage-1)*rowPerPage; //행의 범위결정
	System.out.println(startRow+"<--startRow");
	
	int totalRow = 0;
	
	int lastPage = totalRow / rowPerPage;
	if(totalRow % rowPerPage !=0){
		lastPage = lastPage +1;
	}
%>
<%
	//QnaDAO에서 qaList불러오기(리스트 출력)
	ArrayList<HashMap<String, Object>> qaList = QnaDAO.qaList(startRow, rowPerPage);
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
</head>
<body>
	<!-- QnA리스트 출력 -->
	<div>
		<h1>자주 묻는 질문</h1>
		<%
			for(HashMap<String, Object> m : qaList){
		%>
			<div><%=m.get("title")%></div>
			<div><%=m.get("content")%></div>
		<%
			}
		%>
		
		
	</div>
</body>
</html>