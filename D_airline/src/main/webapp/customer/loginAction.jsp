	<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import ="java.sql.*" %>
<%@ page import ="java.util.*" %>
<%@ page import = "java.net.*" %>
<%@ page import ="dao.*" %>


<%
	//인증분기 세션 변수 이름 loginEmp
	System.out.println("----------loginAction.jsp-----");

	System.out.println("로그인 타입(관리자or고객) : "+request.getParameter("type"));
	System.out.println("[param] id : "+request.getParameter("id"));
	System.out.println("[param] pw : "+request.getParameter("pw"));
	String type = null;
	
	
	if(request.getParameter("type")!= null){
		type = request.getParameter("type");
		System.out.println("type : "+type);
		
		
	}
	/*
	if(type.equals("admin")){
		if(session.getAttribute("loginEmp") != null) {
		response.sendRedirect("/D_airline/emp/empMain.jsp");
		return;
		}
	}
	*/
	String id = null;
	String pw = null;

	String msg = null;
	
	
	if(request.getParameter("id") != null){
		id = request.getParameter("id");
	}
	
	if(request.getParameter("pw")!=null){
		pw = request.getParameter("pw");
	}
	
	
	
	System.out.println("id : " + id);
	System.out.println("pw : " + pw);
	
	
	if(type.equals("admin")){
		
		HashMap<String, Object> selectAdminLogin = AdminDAO.selectAdminLogin(id, pw); 
	
		System.out.println("HashMap<String, Object> selectAdminLogin : "+selectAdminLogin);
		
		if(selectAdminLogin!=null){
			System.out.println("관리자 로그인에 성공하였습니다.");
			//하나의 세션변수 안에 여러개의 값을 저장하기 위해 HashMap타입을 사용
			
			session.setAttribute("loginAd",selectAdminLogin);
			
			HashMap<String, Object> m = (HashMap<String,Object>)(session.getAttribute("loginAd"));
			
			m.put("type","admin");
			
			System.out.println("[세션에 주입한 type] - "+ m.get("type"));
			System.out.println("[세션에 주입한 adminId] - "+(String)(m.get("adminId"))); 
			System.out.println("[세션에 주입한 hireDate] - "+(String)(m.get("hireDate"))); 
			System.out.println("[세션에 주입한 post] - "+(String)(m.get("post")));
		

			response.sendRedirect("/D_airline/customer/flightMain.jsp?type=admin");
	
		}else{
			System.out.println("관리자 로그인에 실패하였습니다.");
			msg = URLEncoder.encode("로그인에 실패하였습니다.","UTF-8");
			response.sendRedirect("/D_airline/customer/loginForm.jsp?msg="+msg);
		}
	}else if(type.equals("customer")){
		HashMap<String, Object> selectMemberLogin = MemberDAO.selectMemberLogin(id,pw); 
		
		if(selectMemberLogin!=null){
			System.out.println("고객 로그인에 성공하였습니다.");
			//하나의 세션변수 안에 여러개의 값을 저장하기 위해 HashMap타입을 사용
			
			session.setAttribute("loginCs",selectMemberLogin);
			
			HashMap<String, Object> m = (HashMap<String,Object>)(session.getAttribute("loginCs"));
			m.put("type","customer");


			System.out.println("[세션에 주입한 type] - "+ m.get("type"));
			System.out.println("[세션에서 할당한 HashMap - memberId]"+(String)(m.get("memberId"))); 
			System.out.println("[세션에서 할당한 HashMap - name]"+(String)(m.get("name")));
			System.out.println("[세션에서 할당한 HashMap - phone]"+(String)(m.get("phone"))); 
			System.out.println("[세션에서 할당한 HashMap - nation]"+(String)(m.get("nation"))); 
			System.out.println("[세션에서 할당한 HashMap - birthDate]"+(String)(m.get("birthDate")));
			System.out.println("[세션에서 할당한 HashMap - mileage]"+(Integer)(m.get("mileage")));
			//msg = URLEncoder.encode((String)(m.get("empName"))+"님 반갑습니다.","UTF-8");
				
			
			response.sendRedirect("/D_airline/customer/flightMain.jsp?type=customer");
		}else{
			System.out.println("고객 로그인에 실패하였습니다.");
			msg = URLEncoder.encode("로그인에 실패하였습니다.","UTF-8");
			response.sendRedirect("/D_airline/customer/loginForm.jsp?msg="+msg);
		}
	}
%>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>loginAction</title>
</head>
<body>

</body>
</html>