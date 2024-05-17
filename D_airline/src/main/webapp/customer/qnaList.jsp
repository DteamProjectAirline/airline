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
<!-- 부트스트랩 -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
<style>
	/*첫 화면에서 비활성화된 accordion의 배경색을 나타냄*/
	.accordion-button:not(.collapsed) {
    	background-color: white;
	  }
	/*활성화된 accordion 내용의 배경색을 나타냄*/
	.accordion-collapse.collapse {
    	background-color: #f3f4f8;  
    }
    .flex-container {
	  display: flex;
	  justify-content: center;
	}
</style>
</head>
<body>
	<nav class="navbar bg-body-tertiary">
	  <div class="container-fluid">
		  <div>
		    <a class="navbar-brand">코리아나항공</a>
		  </div>
		  <div>
		    	<!-- 로그인 상태면 고객아이디 , 로그인상태가 아니면 로그인버튼 -->
		    	<%if(session.getAttribute("loginCs") != null){	    	
		    	%>
		    	<!-- 세션에서 사용자  id 값 꺼내와서 표현할거임 -->
		    	  		
		    	<% 
		    	} else{
		    	%>
					<a href="/D_airline/customer/loginForm.jsp">로그인</a>
				<%
		    	}
				%>
					<a href="/D_airline/customer/addMembership.jsp">회원가입</a>   
		  </div>	
	  </div>
	</nav>
	
	<!-- QnA리스트 출력 -->
    <div class="container content-container">
		<h2>자주 묻는 질문</h2>
		<div class="flex-container">
			<div class="container-fluid text-center">
			<div class="accordion" id="accordionExample">
			
				<%
					//qna를 선택했을때 하나의 accordion만 반응하도록 설정
					for(int i = 0; i < qaList.size(); i++) {
				        HashMap<String, Object> m = qaList.get(i);
				        String collapseId = "collapse" + i;
				        String headingId = "heading" + i;
				%>
		 		 	<div class="accordion-item" style="width: 1000px;">
		    			<h2 class="accordion-header" id="<%=headingId%>">
		     				 <button class="accordion-button" type="button" data-bs-toggle="collapse" data-bs-target="#<%=collapseId%>" aria-expanded="true" aria-controls="<%=collapseId%>">	
									<div style="font-weight: bold;">
										<%=m.get("title")%>
									</div>
		     				 </button>
						</h2>
		   			 <div id="<%=collapseId%>" class="accordion-collapse collapse" aria-labelledby="<%=headingId%>" data-bs-parent="#accordionExample" style="border:thin;">
		     			 <!-- 출력시 줄바꿈 기능 -->
		     			 <div class="accordion-body" style="white-space:pre-line">
		     		 		<%=m.get("content")%>
		      			</div>
		    		</div>	
		    	</div>	
				<%
					}
				%>	
				
		</div>				
		</div>
		</div>
	</div>
</body>
</html>