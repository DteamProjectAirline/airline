<%@page import="sjwdao.FlightListDAO"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="javax.naming.spi.DirStateFactory.Result"%>
<%@page import="java.sql.*"%>
<%@page import="java.util.*" %>
<%@page import="dao.DBHelper"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
String type = request.getParameter("type"); //왕복편도
String departureLocation = request.getParameter("departureLocation"); //출발지
String arrivalLocation = request.getParameter("arrivalLocation"); // 도착지 or 복귀공항
String departDate = request.getParameter("departDate");  //출발일
String comeBackDate = request.getParameter("comeBackDate"); // 돌아오는날

/* System.out.println(type+"왕복,편도");
System.out.println(departureLocation+"출발지");
System.out.println(arrivalLocation+"도착지");
System.out.println(departDate+"출발일");
System.out.println(comeBackDate+"복귀일 편도면 null임."); */ 

// 항공편 리스트 불러오는 메소드;
ArrayList<HashMap<String,Object>> list = FlightListDAO.flightList(departureLocation, arrivalLocation, departDate);

%>    
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
<link rel="stylesheet" type="text/css" href="../css/css_flightList.css">
</head> 
<body>

<div>
	가는 편 <%=departureLocation%> -> <%=arrivalLocation %> 
</div>
	
 	<div style="width: 1300px; margin-left:300px; ">	
	<ul style="list-style: none; width: 100%; height: 160px;">
		<%int i = 0; %>
		<%for(HashMap<String,Object> e : list) {
			i = i + 1 ;
		System.out.println(i);
		String departureTime = (String) (e.get("departureTime"));
		String arrivalTime = (String) (e.get("arrivalTime"));
		String flightDuration = (String) (e.get("flightDuration"));
		int flightId = (int) (e.get("flight_id"));
		// 항공기별 좌석잔여개수 div 가 반복돼서 for each 사용불가. 단일값을 하나씩 꺼내야함.
		//System.out.println(flightId +"<flight");
		ArrayList<HashMap<String,Object>> seatNum = FlightListDAO.asdas(flightId);
			//System.out.println(seatNum.get(0).get("cnt"));
		int ecoSeatPrice = (int) ((int) (e.get("baseFare"))*(double) (seatNum.get(0).get("seatPrice")));
		int busSeatPrice = (int) ((int) (e.get("baseFare"))*(double) (seatNum.get(1).get("seatPrice")));
		int firstSeatPrice = (int) ((int) (e.get("baseFare"))*(double) (seatNum.get(2).get("seatPrice")));
			
		%>
		<form id="flightForm<%=i%>" method="POST" action="/D_airline/customer/flightList2.jsp">
			<li style="display: flex ;margin: 32px 0 64px; border: 10px; border-radius: 2rem;height: 180px;">
				<div class="flightBorder">
					<div class="flightContent">
					<div style="text-align: center;">비행시간:<%=flightDuration.substring(0,2)%>시간<%=flightDuration.substring(3,5)%>분
					</div>
					<div style="text-align: center;">-------------></div>
						<div style="display: flex;">
							<div style="flex:1; display: flex; flex-direction: column; align-items: start;">
								<span style="font-size: 24px;line-height: 1.5;">
								<%=departureTime.substring(10,16)%>
								</span>
							<div><%=(String) (e.get("departureCity" ))%></div>
							
							</div>
							<div style="flex:1; display: flex; flex-direction: column; align-items: end" >
								<span style="font-size: 24px;line-height: 1.5;">
								
								<%=arrivalTime.substring(10,16)%>
								</span>
								<div><%=(String) (e.get("arrivalCity"))%></div>
							</div>
									
						</div>
						<div style="margin-top: 5px;">
						<%=(String) (e.get("planeName"     ))%>
						<%=(String) (e.get("airLine"       ))%>
						</div>
					</div>
				</div>
				
				<div style="display:flex; border: 1px solid #d9dbe1; border-bottom-right-radius:20px;border-top-right-radius:20px; width: 100%; margin-right: 100px;">
						
						<div class="flightTopBorder">
							<label style="width: 100%" for="selectEconomy" >
							
							<input type="radio" style="opacity: 0;" id="selectEconomy" name="flight_grade" value="<%=ecoSeatPrice%>">
								<div class="priceBorder" style="margin-top: 20px;">
									<div>
									일반석
									</div>
									<div style="font-size: 24px;line-height: 1.5;">
									<%=ecoSeatPrice%>원	
									</div>
									<div>잔여좌석:<%=(seatNum.get(0).get("cnt"))%></div>
								</div>
							</label>					
						</div>
						
					
					<div class="flightTopBorder">
						<label style="width: 100%" for="selectBusiness" >
							<input type="radio" style="opacity: 0;" name="flight_grade" id="selectBusiness" value=<%=busSeatPrice%>>
							<div class="priceBorder">
								<div>
								비지니스
								</div>
								<div style="font-size: 24px;line-height: 1.5;">
								<%=busSeatPrice%>원	
								</div>
								<div>잔여좌석<%=(seatNum.get(1).get("cnt"))%></div>
							</div>	
						</label>	
					</div>
					
					<div class="flightRightBorder" >
						<label style="width: 100%" for="selectFirst">
							<input type="radio"  style="opacity: 0;" name="flight_grade" id="selectFirst" value=<%=firstSeatPrice%>>
							<div class="priceBorder">
								<div>퍼스트</div>
								<div style="font-size: 24px;line-height: 1.5;">
								<%=firstSeatPrice%>원
								</div>
								<div>잔여좌석:<%=(seatNum.get(2).get("cnt"))%></div>
							</div>		
						</label>
					</div>
				</div>
				<input type="hidden" name="flightId" value=<%=flightId%>>
			</li>
		</form>		
		<%} %>
	</ul>
	</div>
<nav class="navbar bg-body-tertiary fixed-bottom shadow-lg  bg-body-tertiary rounded" style="height: 80px;">
		  <div class="container-fluid">
		    <a class="navbar-brand">Navbar</a>
		      <div style="line-height:1.5; padding-top:12px;font-size:30px;color:#00256c;">총액</div>
		      <div style="line-height:1.5; padding:12px;font-size: 30px;color:#00256c;" id="selectedSeatPrice">0원</div>
		      <div style="padding-top:10px;">
		      <button type="submit" id="nextPageButton" class="btn btn-primary btn-lg" style="margin-right:200px; width: 175px; height:50px;background-color:#00256c;">다음여정</button>
		      </div>	
		  </div>
		</nav>


 <script>
 let FormId = null;
 const labels = document.querySelectorAll('label[for^="select"]');
 labels.forEach((label, i) => {
     label.addEventListener('click', function(event) {
         // 선택된 라디오 버튼의 값을 가져옴
         const selectedValue = document.querySelector('input[name="flight_grade"]:checked').value;
         // 선택된 좌석의 가격을 표시할 요소를 찾음
         const priceDisplayElement = document.getElementById('selectedSeatPrice');
         // 선택된 좌석의 가격을 업데이트
         priceDisplayElement.textContent =  selectedValue +"원";
         // 선택된 좌석의 가격을 숨겨진 입력 필드에 저장
         FormId = 'flightForm' + i;
     });
 });
 document.getElementById('nextPageButton').addEventListener('click', function() {
	    // 폼 제출
	    if(FormId){
	    document.getElementById(FormId).submit();
	    }
	});
</script>
	
</body>
</html>