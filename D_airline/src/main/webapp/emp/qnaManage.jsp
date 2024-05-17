<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="dao.QnaDAO"%>
<%@ page import = "java.sql.*" %>
<%@ page import="java.util.*"%>
<%@ page import="java.net.*"%>
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

	
	<div>
		<h1>자주 묻는 질문</h1>
		
	<!-- QnA등록 -->
	<div>
		<a href="/D_airline/emp/qnaManageAddForm.jsp?adminId=">QnA등록</a>
	</div>
	
	<!-- QnA리스트 출력 -->
		<%
			for(HashMap<String, Object> m : qaList){
		%>
			<div>
				<div>
					<a href="/D_airline/emp/qnaManageOne.jsp?qnaId=<%=m.get("qnaId")%>">
						<%=m.get("title")%>
					</a>
				</div>	
				<!-- 출력시 줄바꿈 기능 -->
				<div style="white-space:pre-line">
					<%=m.get("content")%>
				</div>
				<form action="qnaManageDeleteAction.jsp" method="post">
					<input type="hidden" name="qnaId" value="<%=m.get("qnaId")%>">
					<button type="submit">삭제</button>
				</form>
				
			</div>
		<%
			}
		%>
		
	</div>
	
</body>
</html>