<%@page import="jakarta.security.auth.message.callback.PrivateKeyCallback.Request"%>
<%@page import="dao.DBHelper"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.util.*" %>
<%@ page import = "java.sql.*" %>
<%@ page import = "java.time.*" %>
<%

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
		HashMap<String,Object> a = new HashMap<String,Object>();
			a.put("cityName", rs.getString("city_name"));
			a.put("airport" , rs.getString("airport"));
			a.put("countryName" , rs.getString("country_name"));
			list.add(a);
	}
	
	String type = null;
	if(request.getParameter("type") == null || request.getParameter("type").equals("왕복")){
	 		type = "왕복";
	} else {
		type = request.getParameter("type");
	}
%>    
<%
	// 표시할 사용자명 받아오는코드
	String empId = null;
	if(session.getAttribute("loginCs") != null){
	HashMap<String,Object> loginMember = (HashMap<String,Object>) (session.getAttribute("loginCs"));
	empId = (String) loginMember.get("memberId"); 
	}
%>    
    
    
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.1/font/bootstrap-icons.css">
<link rel="stylesheet" type="text/css" href="../css/css_main.css">
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
		    	  		<%=empId%>
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

	
	<div style="width:100%; height:500px; background-image: url('/D_airline/img/mainImg.jpg');background-size: cover;">
	<div  style=" width:1000px; margin-bottom:80px; margin-right:320px; ; margin-left:475px; margin-top: 48px; align-items: flex-start;  ">
		
		<div style="padding-left:0px; padding-right:0px;" >
			<ul class="mainBtnUl">
				<li class="mainLi">
					<button id="btn1" class ="mainBtn" onclick = "displayFlightReservation();changeColor(this)">항공권예매</button>
				</li>
				<li class="mainLi">
					<button id="btn2" class ="subBtn" onclick = "displayReservationInquiry();changeColor(this)">예약조회</button>
				</li>
				<li class="mainLi">
					<button id="btn3" class ="subBtn" onclick = "displayDepartureArrivalInquiry();changeColor(this)">출도착 조회</button>
				</li>
			</ul>
		</div>
		

		<!-- 자바 스크립트 or 부트스트랩 찾아서 구현할거임 -->
		<div id ="main" class="mainFlight" style="width: 100%;"> 
			
			<form action = "/D_airline/customer/flightMain.jsp" style="margin-left: 48px ; ">
				<button name="type" value="왕복" style=" margin-top: 16px; margin-bottom: 16px; color:white;border-radius:10px 10px 10px 10px;background-color:#00256c">왕복</button>
				<button name="type" value="편도" style="color:white; border-radius:10px 10px 10px 10px; background-color:#00256c">편도</button>
			</form>
			<form method="post" action="/D_airline/customer/flightList1.jsp"> <!-- 항공편리스트 조회 -->
				<!-- 출발지 , 도착지 입력   -->
				<input type="hidden" name="type" value="<%=type%>">
			<div class="inputdiv">
				<div>
					<input class="wrap" style="margin-left:12px;" list="airport" name="departureLocation" placeholder="출발지" required="required">
				</div>
				
				<div>
					<input class="wrap" style=""list="airport" name="arrivalLocation" placeholder="도착지" required="required">
				</div>
				
				<div>
					<input class="wrap" type="date" name="departDate" min="<%=now%>" required="required">
				</div>
				
				<div>
					<%if( type != "왕복"){ %>
						<input class="wrap" type="date" name="comeBackDate" disabled="disabled">
					<%} else{%>
						<input class="wrap" type="date" name="comeBackDate" required="required">
						<%} %>
						<%System.out.println(); %>
						<button type="submit" style="margin-left:10px; margin-top:15px; background-color: #00256c "class="btn btn-primary">조회</button>
				</div>


			</div>

				<!-- 출,도착지에 나타날 리스트 데이터 뿌리기  -->
				<datalist id="airport">
					
				<%for(HashMap<String,Object> b : list){ %>
					<option value="<%=(String)(b.get("cityName"))%>" >
					<%=(String) (b.get("countryName"))%>
					<%=(String) (b.get("airport"))%>
					</option>
				<%} %>	
				</datalist>
				
				<!-- 출발일 받아오는 값 -->
				
				
				
				<!--  타입에따라 왕복 , 편도 구분 -->
				
			</form>
		</div>
	
	
	<!-- 예약번호 조회 -->
		<div id="main2" class="subFlight" >
			<form action="/d_airline/customer/ckReservation.jsp">	
				<span>예약번호</span>
				<input type="text" name="bookingId">
				<br>
				<span>출발일</span>
				<input type="date" name="departDate">
				<br>
				<span>email</span>
				<input type="text" name="memberId">
				<button type="submit"> 조회 </button>
			</form>
		</div>
	
		<div id ="main3" class="subFlight" >
			<form action="/d_airline/customer/ckAirplane.jsp">
				<input list="airport" name="departureLocation" placeholder="출발지">
				<input list="airport" name="arrivalLocation" placeholder="도착지">
				<input type="date" name="departDate">
				<button type="submit"> 조회 </button>
			</form>
		</div>
	</div>
	</div>
	
	<script>
	  function displayFlightReservation() {
	    document.getElementById('main').style.display = 'block';
	    document.getElementById('main2').style.display = 'none';
	    document.getElementById('main3').style.display = 'none'; // 항공권조회 표시하고 나머지 숨김
	  }
		
		
	  
	  function displayReservationInquiry() {
	    document.getElementById('main').style.display = 'none';
	    document.getElementById('main2').style.display = 'block';
	    document.getElementById('main3').style.display = 'none'; // 예약조회 표시하고 나머지 숨김
	  }
	
	  function displayDepartureArrivalInquiry() {
	    document.getElementById('main').style.display = 'none';
	    document.getElementById('main2').style.display = 'none';
	    document.getElementById('main3').style.display = 'block'; // 출도착지 표시하고 나머지 숨김 
	  }
	  function changeColor(button) {
		  // Get all buttons on the page
		  const buttons = document.querySelectorAll('button');

		  // Set the background color of all buttons to blue (default)
		  for (const otherButton of buttons) {
		    otherButton.style.backgroundColor = '#00256c'; // Set default color to blue
		  }

		  // Set the background color of the currently selected button to white
		  button.style.backgroundColor = '#d3d3d3'; // Set selected color to white
		}	</script>


	
	
	</body>
</html>