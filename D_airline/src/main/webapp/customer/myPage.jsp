<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import ="java.util.*" %>
<%@ page import ="java.sql.*" %>    
<%
String customerName = null;
String customerPhone = null;
String customerId = null;
String customerBirthDate = null;
int mileage = 0;
if(session.getAttribute("loginCs") != null){
	HashMap<String,Object> loginMember = (HashMap<String,Object>) (session.getAttribute("loginCs"));
	customerName = (String) loginMember.get("name");
	customerId = (String) loginMember.get("memberId");
	customerPhone = (String) loginMember.get("phone");
	 mileage = (int) loginMember.get("mileage")	;
	 customerBirthDate = (String) loginMember.get("birthDate");
}
%>
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
		  	<a href="/D_airline/customer/qnaList.jsp" style="font-size: 1.6rem; line-height: 1.5;">자주묻는질문</a>
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
	
	<div style="width:1000px;height:100px;display:block;margin: 0 auto; margin-top: 50px;">
		<h1>회원정보</h1>
		<div style="background-color: #f3f4f8 ;height: 150px; border-radius: 16px ">
			<ul style="display:flex;list-style: none;justify-content: space-between;flex-direction: row;">
				<li style="flex-basis: 20%;flex-shrink: 1; margin-left:25px;">
					<Strong>성명</Strong>
					<p><%=customerName %></p>
				</li>
				
				<li style="flex-basis: 20%;flex-shrink: 1;">
					<Strong>아이디</Strong>
					<p><%=customerId %></p>
				</li>
				
				<li style="flex-basis: 20%;flex-shrink: 1;">
					<Strong>생년월일</Strong>
					<p><%=customerName %></p>
				</li>
				
				<li style="flex-basis: 20%;flex-shrink: 1;">
					<Strong>전화번호</Strong>
					<p><%=customerPhone%></p>
				</li>
				<li style="flex-basis: 20%;flex-shrink: 1;">
					<Strong>마일리지</Strong>
					<p><%=mileage%></p>
				</li>
				
			</ul>
			
		</div>
		<div style="padding: 40px 64px;margin-top:25px;border: 1px solid #d9dbe1;height: 100px;">
			<p>예약정보 </p>
			<span>가나다라마바사</span>
		</div>
  	</div>
         
</body>
</html>
