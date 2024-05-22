<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="dao.*"%>
<%@ page import = "java.sql.*" %>
<%@ page import="java.util.*"%>
<%@ page import="java.net.*"%>    
<%@ page import = "java.time.*" %>
<%
	// 표시할 사용자명 받아오는코드
	String customerId = null;
	if(session.getAttribute("loginCs") != null){
	HashMap<String,Object> loginMember = (HashMap<String,Object>) (session.getAttribute("loginCs"));
	customerId = (String) loginMember.get("memberId"); 
	}
%>    
<%
	// 오늘날짜 받아오는 코드. input date 에서 날짜제한 시키기 위함
	LocalDate now = LocalDate.now();
	//System.out.println(now);
	//System.out.println("----------------------flightMain.jsp");
    Connection conn = DBHelper.getConnection() ;
	ArrayList<HashMap<String,Object>> list = new ArrayList<HashMap<String,Object>> ();
	
	String sql = "SELECT city.city_name , city.airport , country.country_name FROM city LEFT OUTER JOIN country ON city.country_id = country.country_id order by country.country_id asc";
	PreparedStatement stmt = conn.prepareStatement(sql);
	ResultSet rs = stmt.executeQuery();
	
	while(rs.next()){
		HashMap<String,Object> m = new HashMap<String,Object>();
			m.put("cityName", rs.getString("city_name"));
			m.put("airport" , rs.getString("airport"));
			m.put("countryName" , rs.getString("country_name"));
			list.add(m);
	}
%>	
<%
	String departureLocation = request.getParameter("departureLocation");
	String arrivalLocation = request.getParameter("arrivalLocation");
	String departDate = request.getParameter("departDate"); 
	/*  보여줘야할거가 뭐더라?  그냥 그날에 있었던 항공편 + 상태를 보여주면 되는거아님?*/
	System.out.println(departureLocation+"<--departureLocation");
	System.out.println(arrivalLocation+"<--arrivalLocation");
	System.out.println(departDate+"<--departDate");
%>    
<% 
   //출도착지, 날짜 하나라도 입력안되면 메인페이지로 이동
   	if(departureLocation == "" || arrivalLocation == "" || departDate == "" || 
   		departureLocation == null || arrivalLocation == null || departDate == null ){
			response.sendRedirect("/D_airline/customer/flightMain.jsp");
	} 
%>  
<%
	//출도착 조회 불러오는 리스트
	ArrayList<HashMap<String, Object>> ckList = CkAirplaneDAO.ckList(departureLocation, arrivalLocation, departDate);
%>  
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.1/font/bootstrap-icons.css">
<link rel="stylesheet" type="text/css" href="../css/css_flightList.css">

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
		    	  		<%=customerId%>
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
	
	<h2>출도착 조회</h2>
	
	
				
	<!-- 출도착 조회 -->
		<div id="main3" class="subFlight" >
			<form action="/D_airline/customer/ckAirplane.jsp">
				<input list="airport" name="departureLocation" placeholder="출발지">
				<input list="airport" name="arrivalLocation" placeholder="도착지">
				<input type="date" name="departDate">
				<button type="submit"> 조회 </button>
			</form>
			
			<!-- 출,도착지에 나타날 리스트 데이터 뿌리기  -->
			<datalist id="airport">
				<%for(HashMap<String,Object> m : list){ %>
					<option value="<%=(String)(m.get("cityName"))%>" >
						<%=(String) (m.get("countryName"))%>
						<%=(String) (m.get("airport"))%>
					</option>
				<%
					} 
				%>	
			</datalist>
		</div>
		
	<!-- 출도착 리스트 출력 -->
		
		
		<%
			for(HashMap<String, Object> m : ckList){
		%>
				<div>
					항공기: <%=m.get("planeName")%>
					항공사: <%=m.get("airline")%>
					출발: <%=m.get("departureCity")%>
					도착: <%=m.get("arrivalCity")%>
					출발시간: <%=m.get("departureTime")%>
					도착시간: <%=m.get("arrivalTime")%>
					상태: <%=m.get("status")%>
				</div>
		<%
			}
		%>
	

</body>
</html>