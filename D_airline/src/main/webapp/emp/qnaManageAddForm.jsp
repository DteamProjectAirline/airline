<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="dao.*"%>
<%@ page import = "java.sql.*" %>
<%@ page import="java.util.*"%>
<%@ page import="java.net.*"%>
<%
	System.out.println("----------qnaManageAddForm.jsp----------");
	System.out.println("세션 ID: " + session.getId());
		
	if (session.getAttribute("loginAd") == null){
	System.out.println("관리자만 접근 가능한 페이지입니다.");
	String msg = URLEncoder.encode("관리자만 접근 가능한 페이지입니다.","UTF-8");
		response.sendRedirect("/D_airline/customer/flightMain.jsp?msg="+msg);
	return;
	}
%>
<%
	HashMap<String, Object> m = new HashMap<>();
	
	//변수할당
	m = (HashMap<String, Object>) (session.getAttribute("loginAd"));
	
	String adminId = null;
	
	//해쉬맵 변수 스트링변수에 할당
	adminId = (String) (m.get("adminId"));
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

		<h1>QnA등록</h1>
		<form action="/D_airline/emp/qnaManageAddAction.jsp" method="post">
			<div>
				<label for="admin" class="form-label">관리자ID:</label> 
				<input type="text" name="adminId" value=<%=adminId%> readonly>
			</div>
			<div>
				<label for="title" class="form-label">제목:</label> 
				<input type="text" name="title">
			</div>
			
				<label for="content" class="form-label">내용:</label> 
				<textarea class="form-control" id="content" name="content" rows="10" cols="60"></textarea>
			
			<div style="margin-top: 20px;">
				<button type="submit" class="btn btn-outline-primary">저장</button>
			</div>
		</form>
	</div>	
</body>
</html>