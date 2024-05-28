<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="pjhdao.QnaDAO"%>
<%@ page import = "java.sql.*" %>
<%@ page import="java.util.*"%>
<%
	int currentPage = 1; //현재페이지
	
	if(request.getParameter("currentPage") != null){
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	
	//검색기능
	String searchWord = ""; 
	if(request.getParameter("searchWord") != null){
		searchWord = request.getParameter("searchWord");
	}
	
	int rowPerPage = 12; //한 페이지당 출력할 row개수
	int startRow = (currentPage-1)*rowPerPage; //행의 범위결정
	System.out.println(startRow+"<--startRow");
	
	int totalRow = QnaDAO.totalRow(searchWord);
	
	//마지막 페이지 계산
	int lastPage = totalRow / rowPerPage;
	if(totalRow % rowPerPage !=0){
		lastPage = lastPage +1;
	}
	
	
%>
<%
	//QnaDAO에서 qaList불러오기(리스트 출력)
	ArrayList<HashMap<String, Object>> qaList = QnaDAO.qaList(searchWord, startRow, rowPerPage);	
%>
<%
	// 표시할 사용자명 받아오는코드
	String empId = null;
	if(session.getAttribute("loginAd") != null){
		HashMap<String,Object> loginMember = (HashMap<String,Object>) (session.getAttribute("loginAd"));
		empId = (String) loginMember.get("adminId"); 
	}   
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
	 .content-container {
           margin: 20px auto;
           max-width: 1000px;
      }
     
	/*첫 화면에서 비활성화된 accordion의 배경색을 나타냄*/
	.accordion-button:not(.collapsed) {
    	background-color: white;
	  }
	/*활성화된 accordion 내용의 배경색을 나타냄*/
	.accordion-collapse.collapse {
    	background-color: #f3f4f8;  
    	text-align: left;
    }
    .flex-container {
	  display: flex;
	  justify-content: center;
	}
	.fluid{
		width: 100%;
	}
	 /* 검색 바 스타일링 */
    form {
        margin-bottom: 20px;
    }
    form input[type="text"] {
        width: 200px;
        padding: 5px;
        margin-right: 10px;
        border: 1px solid #ccc;
        border-radius: 5px;
    }
    form button {
        padding: 5px 10px;
        background-color: #004b87;
        color: white;
        border: none;
        border-radius: 5px;
    }
     a {
	text-decoration-line: none;
	}
</style>
</head>
<body>
	<nav class="navbar bg-body-tertiary" style="padding-top:0px; padding-bottom: 0px; padding-left:0px; ">
	  <div class="container-fluid">
		  <div>	
		  	<a href="/D_airline/customer/flightMain.jsp">
				<img src="/D_airline/img/KOREANA (3).png" style="height:75px; width: 400px;">
			</a>		    
		  </div>
		  <div style="padding-top: 20px; padding-right: 150px;">
		  	<a href="/D_airline/customer/qnaList.jsp" style="font-size: 40px; line-height: 1.5;">q&a페이지</a>
		  </div>
		  <div style="padding-top: 40px;">
		    	<!-- 로그인 상태면 고객아이디 , 로그인상태가 아니면 로그인버튼 표시-->
		    	<%if(session.getAttribute("loginCs") != null){	    	
		    	%>
		    	  		<!-- 세션에서 사용자 name 값 꺼내옴 -->
		    	  		<div style="display: flex">
		    	  			    	  		
		    	  		 <a style="font-size: 20px; line-height: 1.5;" href="/D_airline/customer/myPage.jsp">myPage</a>
		    	  		
		    	  		</div>
		    	<% 
		    	} else{
		    	%>
				<a href="/D_airline/customer/loginForm.jsp">로그인</a>
				<a href="/D_airline/customer/addMembership.jsp">회원가입</a>   
				<%
		    		}
				%>
				
	  	  </div>	
	  </div>
	</nav>
	
	<!-- QnA리스트 출력 -->
    <div class="container content-container">
		<h2>자주 묻는 질문</h2>
		<div class="container-fluid text-center">
			<form method="get" action="/D_airline/customer/qnaList.jsp?searchWord=<%=request.getParameter(searchWord)%>">
				<div>
					<input type="text" name="searchWord" value="<%=searchWord%>">
					<button type="submit">검색</button>
				</div>
			</form>
		</div>	
		
		<div class="container-fluid text-center" style="width: 100%">
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
		     			 <div class="accordion-body" style="white-space:pre-line;">
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
	
			
	<nav aria-label="Page navigation example">
  	<ul class="pagination justify-content-center">
  	
		<%
			if(currentPage > 1){
		%>
			<li class="page-item">
				<a class ="page-link" href="/D_airline/customer/qnaList.jsp?currentPage=1"> << </a>
			</li>
			<li class="page-item">
				<a class ="page-link" href="/D_airline/customer/qnaList.jsp?currentPage=<%=currentPage-1%>&searchWord=<%=searchWord%>">이전</a>
			</li>
		<%		
			} else{
		%>
			<li class="page-item disabled">
				<a class ="page-link" href="/D_airline/customer/qnaList.jsp?currentPage=1"> << </a>
			<li class="page-item disabled">
				<a class ="page-link" href="/D_airline/customer/qnaList.jsp?currentPage=<%=currentPage-1%>">이전</a>
			</li>
		<%
			}
		%>
			&nbsp;
			<div>
				<span class="btn btn-outline-secondary">
						<%=currentPage%> 
				</span>
			</div>
			&nbsp;
		<%		
			
			if(currentPage < lastPage) {
		%>
			<li class="page-item">
				<a class ="page-link" href="/D_airline/customer/qnaList.jsp?currentPage=<%=currentPage+1%>">다음</a>
			</li>
			<li class="page-item">
				<a class ="page-link" href="/D_airline/customer/qnaList.jsp?currentPage=<%=lastPage%>">>></a>
			</li>
			
		<%		
			}
		%>
	</ul>
	</nav>
	
</body>
</html>