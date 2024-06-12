<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.net.*" %>

<%
	System.out.println("-----loginForm.jsp-----");

//로그인 화면에서 받을 에러메세지 변수생성
String msg = null;

if(request.getParameter("msg")!=null){
	msg = request.getParameter("msg");
}

System.out.println("[param]msg값 : "+request.getParameter("msg"));


%>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	

	</style>
	<!-- Latest compiled and minified CSS -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

<!-- Latest compiled JavaScript -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<link rel="stylesheet" type="text/css" href="../css/css_loginForm.css">
	<title>loginForm</title>
	
</head>
	<body>
		
		<form method="post" action="/D_airline/customer/loginAction.jsp">
			
			<div style="background: #ffffff; width: 100%;">
				<div>
					<a href="/D_airline/customer/flightMain.jsp">
						<img src="/D_airline/img/KOREANA (3).png" style="height:130px; width: 400px;">
					</a>	
				</div>
			</div>
			<div class="login-container">
       
		        <div class="login-box">
		        	<h1>로그인</h1>
		            <p class="membership">아직, 대한항공 회원이 아니세요? 회원으로 가입하시고 마일리지 혜택을 누려 보세요.</p>
		            <div class="join-button">회원가입</div>
		            
		            <div class="form-group">
		            	<input type="hidden" name = "type" value="customer" >
		            	<label for="username">아이디</label>
		                <input type="text" name="id" required>
		            </div>
		            <div class="form-group">
		            	<label for="password">비밀번호</label>
		                <input type="password" name="pw" required>
		            </div>
		             
		            <button type="submit" class="login-button">로그인</button>
		 		</div>
			</div>
		</form>

	</body>
</html>