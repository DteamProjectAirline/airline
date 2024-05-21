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
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>		
<style>
	.content-container {
            margin: 20px auto;
            max-width: 800px;
            padding: 20px;
            border: 1px solid #ccc;
            border-radius: 10px;
     }
      .form-label {
            font-weight: bold;
     }
</style>
</head>
<body>
	 <div class="container content-container">
		<h1>QnA 상세보기</h1>
		<%
			for(HashMap<String, Object> m : qaInfo){
		%>
			<form action="/D_airline/emp/qnaManageModifyAction.jsp" method="post">
				<input type="hidden" name="qnaId" value="<%=qnaId%>">
				<div>
					<label for="title" class="form-label">제목:</label> 
					<input type="text" name="title" value="<%=m.get("title")%>">
				</div>	
					<label for="content" class="form-label">내용:</label>
                    <textarea class="form-control" id="content" name="content" rows="10" style="white-space:pre-line"><%=m.get("content")%></textarea>
				<div>
					 <label class="form-label">생성:</label>
					<%=m.get("createDate")%>
				</div>
				<div>
					 <label class="form-label">수정:</label>
					<%=m.get("updateDate")%>
				</div>
				<div style="margin-top: 20px;">
					<button type="submit" class="btn btn-outline-primary">수정</button>
				</div>	
			</form>	
		<%
			}
		%>
	</div>
</body>
</html>