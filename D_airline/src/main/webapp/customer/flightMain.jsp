<%@page import="jakarta.security.auth.message.callback.PrivateKeyCallback.Request"%>
<%@page import="dao.DBHelper"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.util.*" %>
<%@ page import = "java.sql.*" %>
<%
	System.out.println("----------------------flightMain.jsp");
    Connection conn = DBHelper.getConnection() ;
	ArrayList<HashMap<String,Object>> list = new ArrayList<HashMap<String,Object>> ();
	
	String sql = "SELECT city.city_name , city.airport , country.country_name FROM city LEFT OUTER JOIN country ON city.country_id = country.country_id;";
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
    
    
    
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
<link rel="styleseet" type="text/css" href="/D_airline/css/main.css">
</head>
<body>
	<nav class="navbar bg-body-tertiary">
  <div class="container-fluid">
    <a class="navbar-brand">코리아나항공</a>
    <form class="d-flex" role="search">
      <input class="form-control me-2" type="search" placeholder="Search" aria-label="Search">
      <button class="btn btn-outline-success" type="submit">Search</button>
    </form>
  </div>
	</nav>

	
	
	<div class="container" style="  align-items: flex-start; width: 100% ;">
		
		<div class="container">
		<ul style="display: flex; position: relative; list-style: none; background-color:transparent ;">
			<li style = "position: relative;"><button class="rounded" style="border-color: #000; background-color: #fff;" onclick = 'displayFlightReservation()'>항공권예매</button></li>
			<li style = "position: relative; border-color: #000; background-color: #fff; "><button onclick = 'displayReservationInquiry()'>예약조회</button></li>
			<li style = "position: relative; border-color: #000; background-color: #fff; "><button onclick = 'displayDepartureArrivalInquiry()'>출도착 조회</button></li>
		</ul>
		</div>
		
		
		<!-- 자바 스크립트 or 부트스트랩 찾아서 구현할거임 -->
		<div id ="main" style = "display : block;"> 
			<form action = "/D_airline/customer/flightMain.jsp">
				<button name="type" value="왕복">왕복</button>
				<button name="type" value="편도">편도</button>
			</form>
			<h1>항공권 예매</h1>
			<form action="#"> <!-- 항공편리스트 조회 -->
				<!-- 출발지 , 도착지 입력   -->
				<input list="airport" name="departureLocation" placeholder="출발지">
				<input list="airport" name="arrivalLocation" placeholder="도착지">
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
				<input type="date" name="departDate">
				
				<!--  타입에따라 왕복 , 편도 구분 -->
				<%if( type != "왕복"){ %>
					<input type="date" name="comeBackDate" disabled="disabled">
				<%} else{%>
					<input type="date" name="comeBackDate">
					<%} %>
					<button type="submit"> 조회 </button>
			</form>
		</div>
	
	
	<!-- 예약번호 조회 -->
		<div id="main2" style="display: none;">
			<form>	
				<h1>예약번호 조회</h1>
				<span>예약번호</span>
				<input type="text">
				<br>
				<span>출발일</span>
				<input type="date" name="departDate">
				<br>
				<span>email</span>
				<input type="text" name="memberId">
				<button type="submit"> 조회 </button>
			</form>
		</div>
	
		<div id = "main3" style="display :none;">
		<h1>출도착 조회</h1>
			<form>
				<input list="airport" name="departureLocation" placeholder="출발지">
				<input list="airport" name="arrivalLocation" placeholder="도착지">
				<input type="date" name="departDate">
				<button type="submit"> 조회 </button>
			</form>
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
	</script>


	
	
	</body>
</html>