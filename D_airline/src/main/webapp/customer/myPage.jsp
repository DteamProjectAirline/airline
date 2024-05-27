<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
</head>
<body>
	<nav class="navbar bg-body-tertiary" style="padding-top:0px; padding-bottom: 0px; padding-left:0px; ">
	  <div class="container-fluid">
		  <div>	
		  	<a href="/D_airline/customer/flightMain.jsp">
				<img src="/D_airline/img/KOREANA (3).png" style="height:75px; width: 400px;">
			</a>		    
		  </div>
		  <div style="padding-top: 40px; padding-right: 150px;">
		  	<a href="/D_airline/customer/qnaList.jsp" style="font-size: 1.6rem; line-height: 1.5;"> q&a페이지</a>
		  </div>
		  <div style="padding-top: 40px;">
		    	<!-- 로그인 상태면 고객아이디 , 로그인상태가 아니면 로그인버튼 표시-->
		    	<%if(session.getAttribute("loginCs") != null){	    	
		    	%>
		    	  		<!-- 세션에서 사용자 name 값 꺼내옴 -->
		    	  		<div style="display: flex">
		    	  			    	  		
		    	  		 <a href="/D_airline/customer/myPage.jsp">myPage</a>
		    	  		
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
	
	<div style="width:1000px;height:100px;display:block;margin: 0 auto;">
		<div>
		가나다라마바사
		</div>
  	</div>
         
</body>
</html>
