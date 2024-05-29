<%@page import="java.time.LocalDate"%>
<%@page import="pjhdao.CkAirplaneDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="sjwdao.FlightListDAO"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="javax.naming.spi.DirStateFactory.Result"%>
<%@page import="java.sql.*"%>
<%@page import="java.util.*" %>
<%@page import="kjwdao.DBHelper"%>
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
<link rel="stylesheet" type="text/css" href="../css/css_ckList.css">

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
	
	<div class="container content-container">	
		<h2>출도착 조회</h2>	
	</div>
	
	<div class="container-fluid text-center">
	<!-- 출도착 조회 -->
		<div id="main3" class="subFlight" >
			<form action="/D_airline/customer/ckAirplane.jsp">
				<input list="airport" name="departureLocation" placeholder="출발지">
				<input list="airport" name="arrivalLocation" placeholder="도착지">
				<input type="date" name="departDate">
				<button type="submit"> 조회 </button>
			</form>
		</div>	
	</div>		
			
	<div class="container content-container">			
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
		
	<!-- 출도착 리스트 출력 -->
		<%
			int i = 0;
		%>
		<%
			for(HashMap<String, Object> m : ckList){
				i++;
				String flightNameId = "flightName" + i;
				String departureTime = (String) (m.get("departureTime"));
				String arrivalTime = (String) (m.get("arrivalTime"));
				String flightDuration = (String) (m.get("flightDuration"));
		%>
		
		
			<div class="flight-info" id="<%= flightNameId %>">
	            <div class="flight-details" style="border-right: 1px solid black; margin-left: 50px; margin-right: 50px;">
	               	
	                <div style="text-align: center; margin-right: 180px;">
		                <div>
		                	<%= m.get("airline")%>
		                </div>
		                	<%= m.get("planeName") %>
		            	<img src="/D_airline/img/airpline_logo.png" class="planeLogo">
	           		 </div>
		          
	           		
	         	</div>
	            <div style="text-align: center;">
	            	<div style="flex:1; display: flex; flex-direction: column; align-items: center;">
								<span style="font-size: 24px;line-height: 1.5;">
									<%=departureTime.substring(10,16)%><!-- 출발시간 -->
								</span>
								<div>
									<!-- 출발도시 -->
									<%=(String) (m.get("departureCity" ))%>
								</div>
								<div>
									<%=departureTime.substring(5,7)%>월<%=departureTime.substring(8,10)%>일
								</div>	
							</div>
	            	
				</div>
					<div style="text-align: center;">
						<div>
							비행시간:<%=flightDuration.substring(0,2)%>시간<%=flightDuration.substring(3,5)%>분
						</div>
						<div>
							------------------------>
						</div>
					</div>
					
						<div style="display: flex; ">
							<div style="flex:1; display: flex; flex-direction: column; align-items: center;" >
								<span style="font-size: 24px;line-height: 1.5;">
									<!-- 도착시간  -->
									<%=arrivalTime.substring(10,16)%>
								</span> 
								<div>
									<!-- 도착도시 -->
									<%=(String) (m.get("arrivalCity"))%>
								</div>  
								<div>
									<%=arrivalTime.substring(5,7)%>월<%=arrivalTime.substring(8,10)%>일
								</div>
							</div>
						</div>	
					
	        
	        <% 
	        	} 
	        %>
			</div>		
	 	</div>
</body>
</html>